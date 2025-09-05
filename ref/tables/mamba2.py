# Copyright (c) 2024, Tri Dao, Albert Gu.

import math

import torch
import torch.nn as nn
import torch.nn.functional as F

from einops import rearrange, repeat

from real_quant_mamba_ssm.ops.triton.layernorm_gated import RMSNorm as RMSNormGated

from real_quant_mamba_ssm.distributed.tensor_parallel import ColumnParallelLinear, RowParallelLinear
from real_quant_mamba_ssm.distributed.distributed_utils import all_reduce, reduce_scatter

from real_quant_mamba_ssm.ops.triton.ssd_combined import mamba_split_conv1d_scan_ref
import pdb

from huggingface_hub import PyTorchModelHubMixin

from real_quant_mamba_ssm.int_mamba import *


w_quantizer = Quantizer(**W_QUANT_PARAMS)
ac_quantizer = Quantizer(**AC_QUANT_PARAMS)
a_quantizer = Quantizer(**A_QUANT_PARAMS)


class Mamba2(nn.Module, PyTorchModelHubMixin):
    def __init__(
        self,
        d_model,
        d_state=128,
        d_conv=4,
        conv_init=None,
        expand=2,
        headdim=64,
        d_ssm=None,  # If not None, we only apply SSM on this many dimensions, the rest uses gated MLP
        ngroups=1,
        A_init_range=(1, 16),
        D_has_hdim=False,
        rmsnorm=True,
        norm_before_gate=False,
        dt_min=0.001,
        dt_max=0.1,
        dt_init_floor=1e-4,
        dt_limit=(0.0, float("inf")),
        bias=False,
        conv_bias=True,
        # Fused kernel and sharding options
        chunk_size=256,
        use_mem_eff_path=True,
        layer_idx=None,  # Absorb kwarg for general module
        process_group=None,
        sequence_parallel=True,
        device=None,
        dtype=None,
    ):
        factory_kwargs = {"device": device, "dtype": dtype}
        super().__init__()
        self.d_model = d_model
        self.d_state = d_state
        self.d_conv = d_conv
        self.conv_init = conv_init
        self.expand = expand
        self.process_group = process_group
        self.sequence_parallel = sequence_parallel
        self.world_size = 1 if process_group is None else process_group.size()
        self.local_rank = 0 if process_group is None else process_group.rank()
        self.d_inner = (self.expand * self.d_model) // self.world_size
        assert self.d_inner * self.world_size == self.expand * self.d_model
        self.headdim = headdim
        self.d_ssm = self.d_inner if d_ssm is None else d_ssm // self.world_size
        assert ngroups % self.world_size == 0
        self.ngroups = ngroups // self.world_size
        assert self.d_ssm % self.headdim == 0
        self.nheads = self.d_ssm // self.headdim
        self.D_has_hdim = D_has_hdim
        self.rmsnorm = rmsnorm
        self.norm_before_gate = norm_before_gate
        self.dt_limit = dt_limit
        self.activation = "silu"
        self.chunk_size = chunk_size
        self.use_mem_eff_path = use_mem_eff_path
        self.layer_idx = layer_idx

        # Order: [z, x, B, C, dt]
        d_in_proj = 2 * self.d_inner + 2 * self.ngroups * self.d_state + self.nheads
        # pdb.set_trace()
        if self.process_group is None:
            self.in_proj = nn.Linear(self.d_model, d_in_proj, bias=bias, **factory_kwargs)
        else:
            self.in_proj = ColumnParallelLinear(self.d_model, d_in_proj * self.world_size, bias=bias,
                                                process_group=self.process_group, sequence_parallel=self.sequence_parallel,
                                                **factory_kwargs)
        
        self.in_proj_wq = None
        self.in_proj_s1 = None
        self.in_proj_s2 = None
        self.out_proj_wq = None
        self.out_proj_s1 = None
        self.out_proj_s2 = None
        self.rmsnorm2 = None
        self.conv1d_wq = None
        self.conv1d_ws = None
        self.conv1d_bq = None
        self.conv1d_bs = None
        self.dt_bias_q = None
        self.dt_bias_s = None
        self.A_q = None
        self.A_s = None
        self.D_q = None
        self.D_s = None

        conv_dim = self.d_ssm + 2 * self.ngroups * self.d_state
        self.conv1d = nn.Conv1d(
            in_channels=conv_dim,
            out_channels=conv_dim,
            bias=conv_bias,
            kernel_size=d_conv,
            groups=conv_dim,
            padding=d_conv - 1,
            **factory_kwargs,
        )
        if self.conv_init is not None:
            nn.init.uniform_(self.conv1d.weight, -self.conv_init, self.conv_init)

        self.act = nn.SiLU()

        # Initialize log dt bias
        dt = torch.exp(
            torch.rand(self.nheads, **factory_kwargs) * (math.log(dt_max) - math.log(dt_min))
            + math.log(dt_min)
        )
        dt = torch.clamp(dt, min=dt_init_floor)
        # Inverse of softplus: https://github.com/pytorch/pytorch/issues/72759
        inv_dt = dt + torch.log(-torch.expm1(-dt))
        self.dt_bias = nn.Parameter(inv_dt)
        # Just to be explicit. Without this we already don't put wd on dt_bias because of the check
        # name.endswith("bias") in param_grouping.py
        self.dt_bias._no_weight_decay = True

        assert A_init_range[0] > 0 and A_init_range[1] >= A_init_range[0]
        A = torch.empty(self.nheads, dtype=torch.float32, device=device).uniform_(*A_init_range)
        A_log = torch.log(A).to(dtype=dtype)
        self.A_log = nn.Parameter(A_log)
        self.A_log._no_weight_decay = True

        # D "skip" parameter
        self.D = nn.Parameter(torch.ones(self.d_ssm if self.D_has_hdim else self.nheads, device=device))
        self.D._no_weight_decay = True

        if self.rmsnorm:
            assert RMSNormGated is not None
            self.norm = RMSNormGated(self.d_ssm, eps=1e-5, norm_before_gate=self.norm_before_gate,
                                     group_size=self.d_ssm // ngroups, **factory_kwargs)

        if self.process_group is None:
            self.out_proj = nn.Linear(self.d_inner, self.d_model, bias=bias, **factory_kwargs)
        else:
            self.out_proj = RowParallelLinear(self.d_inner * self.world_size, self.d_model, bias=bias,
                                              process_group=self.process_group, sequence_parallel=self.sequence_parallel,
                                              **factory_kwargs)

    def forward(self, u, seqlen=None, seq_idx=None, cu_seqlens=None, inference_params=None,
                rmsnorm1=None, times=0):
        seqlen_og = seqlen
        if seqlen is None:
            batch, seqlen, dim = u.shape
        else:
            batch_seqlen, dim = u.shape
            batch = batch_seqlen // seqlen
        if self.layer_idx<2 and times == 0:
            tensor2bin(u,f"bin/refs/rms1_layer{self.layer_idx}.bin")
        u_q,u_s = ac_quantizer(u, O_W, fused=False,pre_mul=False)
        if self.layer_idx<2 and times == 0:
            tensor2bin(u_q,f"bin/refs/rms1_q_layer{self.layer_idx}.bin")
            tensor2bin(u_s,f"bin/refs/rms1_s_layer{self.layer_idx}.bin")
        inference_params_seqlen_offset = None
        conv_state, ssm_state = None, None
        if inference_params is not None:
            inference_batch = cu_seqlens.shape[0] - 1 if cu_seqlens is not None else batch
            conv_state, ssm_state = self._get_states_from_cache(inference_params, inference_batch)
            inference_params_seqlen_offset = inference_params.seqlen_offset

        zxbcdt = shift_matmul(u_q, u_s, self.in_proj_wq, self.in_proj_s1, self.in_proj_s2,
                               self.in_proj.weight.shape[1], self.in_proj.weight.shape[0],
                               AC_QUANT_PARAMS["group_size"], W_QUANT_PARAMS["group_size"], "in_proj")
        zxbcdt = rearrange(zxbcdt, "(b l) d -> b l d", b=batch)
        Trunc_d = rmsnorm1.O_out + O_W - O_CONV_IN
        zxbcdt = (zxbcdt >> Trunc_d)

        if self.layer_idx<2 and times == 0:
            tensor2bin(zxbcdt,f"bin/refs/zxbcdt_layer{self.layer_idx}.bin")

        if seqlen_og is not None:
            zxbcdt = rearrange(zxbcdt, "(b l) d -> b l d", l=seqlen)
        dt_limit_kwargs = {} if self.dt_limit == (0.0, float("inf")) else dict(dt_limit=self.dt_limit)

        out = mamba_split_conv1d_scan_ref(
            zxbcdt,
            rearrange(self.conv1d.weight, "d 1 w -> d w"),
            self.conv1d.bias,
            self.dt_bias,
            A=None,
            D=rearrange(self.D, "(h p) -> h p", p=self.headdim) if self.D_has_hdim else self.D,
            chunk_size=self.chunk_size,
            activation=self.activation,
            rmsnorm_weight=self.norm.weight if self.rmsnorm else None,
            rmsnorm_eps=self.norm.eps if self.rmsnorm else 1e-6,
            outproj_weight=self.out_proj.weight,
            outproj_bias=self.out_proj.bias,
            headdim=None if self.D_has_hdim else self.headdim,
            ngroups=self.ngroups,
            norm_before_gate=self.norm_before_gate,
            **dt_limit_kwargs,
            conv_state=conv_state,
            ssm_state=ssm_state,
            seqlen_offset=inference_params_seqlen_offset,
            out_proj_wq=self.out_proj_wq,
            out_proj_s1=self.out_proj_s1,
            out_proj_s2=self.out_proj_s2,
            rmsnorm2=self.rmsnorm2,
            conv1d_wq=self.conv1d_wq,
            conv1d_ws=self.conv1d_ws,
            conv1d_bq=self.conv1d_bq,
            conv1d_bs=self.conv1d_bs,
            dt_bias_q=self.dt_bias_q,
            dt_bias_s=self.dt_bias_s,
            A_q=self.A_q,
            A_s=self.A_s,
            D_q=self.D_q,
            D_s=self.D_s,
            times=times,
            layer_idx=self.layer_idx
        )
        if seqlen_og is not None:
            out = rearrange(out, "b l d -> (b l) d")
        if self.process_group is not None:
            reduce_fn = reduce_scatter if self.sequence_parallel else all_reduce
            out = reduce_fn(out, self.process_group)

        return out

    def allocate_inference_cache(self, batch_size, max_seqlen, dtype=None, **kwargs):
        device = self.out_proj.weight.device
        conv_dtype = self.conv1d.weight.dtype if dtype is None else dtype
        conv_state = torch.zeros(
            batch_size, self.d_conv, self.conv1d.weight.shape[0], device=device, dtype=conv_dtype
        ).transpose(1, 2)
        ssm_dtype = self.in_proj.weight.dtype if dtype is None else dtype
        ssm_state = torch.zeros(
            batch_size, self.nheads, self.headdim, self.d_state, device=device, dtype=ssm_dtype
        )
        return conv_state, ssm_state

    def _get_states_from_cache(self, inference_params, batch_size, initialize_states=False):
        assert self.layer_idx is not None
        # pdb.set_trace()
        if self.layer_idx not in inference_params.key_value_memory_dict:
            batch_shape = (batch_size,)
            ssm_state = (
                torch.zeros(
                    batch_size,
                    self.d_state,
                    self.nheads,
                    self.headdim,
                    device=self.in_proj.weight.device,
                    dtype=torch.int8,
                ),
                torch.zeros(
                    batch_size,
                    self.d_state,
                    self.nheads,
                    int(self.headdim/A_QUANT_PARAMS["group_size"]),
                    device=self.in_proj.weight.device,
                    dtype=torch.int8,
                )
            )
            conv_state = (
                torch.zeros(
                    batch_size,
                    self.d_conv-1,
                    self.conv1d.weight.shape[0],
                    device=self.conv1d.weight.device,
                    dtype=torch.int8,
                ).transpose(1, 2),
                torch.zeros(
                    batch_size,
                    self.d_conv-1,
                    int(self.conv1d.weight.shape[0]/CONV_A_QUANT_PARAMS["group_size"]),
                    device=self.conv1d.weight.device,
                    dtype=torch.int8,
                ).transpose(1, 2)
            )
            inference_params.key_value_memory_dict[self.layer_idx] = (conv_state, ssm_state)
        else:
            conv_state, ssm_state = inference_params.key_value_memory_dict[self.layer_idx]
            # TODO: What if batch size changes between generation, and we reuse the same states?
            if initialize_states:
                conv_state.zero_()
                ssm_state.zero_()
        return conv_state, ssm_state

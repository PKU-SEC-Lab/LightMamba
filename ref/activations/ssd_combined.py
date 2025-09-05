# Copyright (c) 2024, Tri Dao, Albert Gu.

"""We want triton==2.1.0 or 2.2.0 for this
"""

from typing import Optional

import math
from packaging import version

import torch
import torch.nn.functional as F
from torch import Tensor

from einops import rearrange, repeat

import pdb
from real_quant_mamba_ssm.int_mamba import *
# from rotate_utils import hadamard_utils

ac_quantizer = Quantizer(**AC_QUANT_PARAMS)
a_quantizer = Quantizer(**A_QUANT_PARAMS)
conv_a_quantizer = Quantizer(**CONV_A_QUANT_PARAMS)
conv_w_quantizer = Quantizer(**CONV_W_QUANT_PARAMS)
silu = IntSiLU(O_CONV_OUT,O_SILU_OUT)

from real_quant_mamba_ssm.ops.selective_scan_interface import selective_scan_ref


def mamba_split_conv1d_scan_ref(zxbcdt, conv1d_weight, conv1d_bias, dt_bias, A, D, chunk_size, dt_limit=(0.0, float("inf")), activation="silu", rmsnorm_weight=None, rmsnorm_eps=1e-6, outproj_weight=None, outproj_bias=None, headdim=None, ngroups=1, norm_before_gate=True,
                                conv_state=None,ssm_state=None,seqlen_offset=None,
                                out_proj_wq=None,out_proj_s1=None,out_proj_s2=None,
                                rmsnorm2=None,
                                conv1d_wq=None,conv1d_ws=None,conv1d_bq=None,conv1d_bs=None,
                                dt_bias_q=None,dt_bias_s=None,
                                A_q=None,A_s=None,
                                D_q=None,D_s=None,
                                times=0,layer_idx=0):
    if D.dim() == 1:
        nheads, = D.shape
    else:
        nheads, headdim = D.shape
    batch, seqlen, _ = zxbcdt.shape
    dim = nheads * headdim
    dstate = (zxbcdt.shape[-1] - 2 * dim - nheads) // ngroups // 2
    z, xBC, dt = torch.split(zxbcdt, [dim, dim + 2 * ngroups * dstate, nheads], dim=-1)
    xBC = xBC.contiguous()
    if layer_idx<2 and times == 0:
        tensor2bin(z,f"bin/refs/z_layer{layer_idx}.bin")
    if layer_idx<2 and times == 0:
        tensor2bin(xBC,f"bin/refs/xBC_layer{layer_idx}.bin")
    xBC_q,xBC_s = conv_a_quantizer(xBC, O_CONV_IN, fused=False,pre_mul=False)
    if layer_idx<2 and times == 0:
        tensor2bin(xBC_q,f"bin/refs/xBC_q_layer{layer_idx}.bin")
        tensor2bin(xBC_s,f"bin/refs/xBC_s_layer{layer_idx}.bin")

    if conv_state is not None:
        xBC_q = rearrange(xBC_q, "(b l gt) g -> b (gt g) l",b=batch,l=seqlen)
        xBC_s = rearrange(xBC_s, "(b l gt) 1 -> b gt l",b=batch,l=seqlen)
        if seqlen_offset>0:
            xBC_q = torch.cat((conv_state[0], xBC_q), dim=-1)
            xBC_s = torch.cat((conv_state[1], xBC_s), dim=-1)
            conv_state[0].copy_(torch.roll(conv_state[0], shifts=-1, dims=-1))
            conv_state[1].copy_(torch.roll(conv_state[1], shifts=-1, dims=-1))
            conv_state[0][:, :, -1] = xBC_q[:, :, -1]
            conv_state[1][:, :, -1] = xBC_s[:, :, -1]
            xBC_q = rearrange(xBC_q, "b (gt g) l -> (b l gt) g",b=batch,l=seqlen+3,g=CONV_A_QUANT_PARAMS["n_bits"])
            xBC_s = rearrange(xBC_s, "b gt l -> (b l gt) 1")
            xBC = conv_matmul(xBC_q,xBC_s,conv1d_wq,conv1d_ws,conv1d_bq,conv1d_bs,
                          seqlen,dim+2*ngroups*dstate,CONV_A_QUANT_PARAMS["group_size"],False)
        else:
            xBC_q = torch.cat((conv_state[0], xBC_q), dim=-1)
            xBC_s = torch.cat((conv_state[1], xBC_s), dim=-1)
            conv_state[0].copy_(F.pad(xBC_q, (3 - xBC_q.shape[-1], 0)))
            conv_state[1].copy_(F.pad(xBC_s, (3 - xBC_s.shape[-1], 0)))
            xBC_q = rearrange(xBC_q, "b (gt g) l -> (b l gt) g",b=batch,l=seqlen+3,g=CONV_A_QUANT_PARAMS["n_bits"])
            xBC_s = rearrange(xBC_s, "b gt l -> (b l gt) 1")
            xBC = conv_matmul(xBC_q,xBC_s,conv1d_wq,conv1d_ws,conv1d_bq,conv1d_bs,
                          seqlen,dim+2*ngroups*dstate,CONV_A_QUANT_PARAMS["group_size"],False)
    else:
        xBC = conv_matmul(xBC_q,xBC_s,conv1d_wq,conv1d_ws,conv1d_bq,conv1d_bs,
                          seqlen,dim+2*ngroups*dstate,CONV_A_QUANT_PARAMS["group_size"],True)
    Trunc_d = O_CONV_IN + O_CONV_W - O_CONV_OUT
    xBC = (xBC >> Trunc_d)
    if layer_idx<2 and times == 0:
        tensor2bin(xBC,f"bin/refs/xBC_conv_layer{layer_idx}.bin")

    if layer_idx<2 and times == 0:
        xBCz=torch.cat((xBC,z),dim=-1)
        tensor2bin(xBCz,f"bin/refs/xBCz_layer{layer_idx}.bin")
    xBC = silu(xBC)
    z = silu(z)
    if layer_idx<2 and times == 0:
        xBCz=torch.cat((xBC,z),dim=-1)
        tensor2bin(xBCz,f"bin/refs/xBCz_silu_layer{layer_idx}.bin")
        xBCz_q,xBCz_s = a_quantizer(xBCz, O_SILU_OUT, fused=False,pre_mul=False)
        tensor2bin(xBCz_q,f"bin/refs/xBCz_silu_q_layer{layer_idx}.bin")
        tensor2bin(xBCz_s,f"bin/refs/xBCz_silu_s_layer{layer_idx}.bin")
    z = z.contiguous()
    z_q,z_s = a_quantizer(z, O_SILU_OUT, fused=False,pre_mul=False)
    if layer_idx<2 and times == 0:
        tensor2bin(z_q,f"bin/refs/z_silu_q_layer{layer_idx}.bin")
        tensor2bin(z_s,f"bin/refs/z_silu_s_layer{layer_idx}.bin")
    z = z_q.to(torch.int64) << z_s
    z = rearrange(z, "(b l gt) g -> b l (gt g)",b=batch,l=seqlen)
    z = z.to(dtype=torch.float64)

    x, B, C = torch.split(xBC, [dim, ngroups * dstate, ngroups * dstate], dim=-1)
    out = selective_scan_ref(x, dt, A, B, C, D=D, z=None, delta_bias=dt_bias, delta_softplus=True,
                             ssm_state=ssm_state,
                             dt_bias_q=dt_bias_q,dt_bias_s=dt_bias_s,
                             A_q=A_q,A_s=A_s,
                             D_q=D_q,D_s=D_s,
                             times=times,layer_idx=layer_idx)

    out = torch.einsum('bld,bld->bld', out, z).to(dtype=torch.int64)
    Trunc_d = O_Y + O_SILU_OUT - O_RMS2_IN
    out = (out >> Trunc_d)
    if layer_idx<2 and times == 0:
        tensor2bin(out,f"bin/refs/yz_layer{layer_idx}.bin")
    out = rmsnorm2(out)

    # had_K, K = hadamard_utils.get_hadK(out.shape[-1])
    # out = hadamard_utils.matmul_hadU_cuda(out, had_K, K)

    out = out.contiguous()
    if layer_idx<2 and times == 0:
        tensor2bin(out,f"bin/refs/rms2_layer{layer_idx}.bin")
    out_q,out_s = ac_quantizer(out, O_W, fused=False,pre_mul=False)
    if layer_idx<2 and times == 0:
        tensor2bin(out_q,f"bin/refs/rms2_q_layer{layer_idx}.bin")
        tensor2bin(out_s,f"bin/refs/rms2_s_layer{layer_idx}.bin")
    out = shift_matmul(out_q, out_s, out_proj_wq, out_proj_s1, out_proj_s2, 
                        outproj_weight.shape[1], outproj_weight.shape[0], 
                        AC_QUANT_PARAMS["group_size"], W_QUANT_PARAMS["group_size"], "out_proj")
    out = rearrange(out, "(b l) d -> b l d", b=batch)
    Trunc_d = rmsnorm2.O_out + O_W - O_RES
    out = (out >> Trunc_d)
    if layer_idx<2 and times == 0:
        tensor2bin(out,f"bin/refs/out_proj_layer{layer_idx}.bin")
    return out


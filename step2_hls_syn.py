from post_syn_process import *
from pre_syn_process import *

import os
# use os to add include path for C++ compiler
# os.environ["CPLUS_INCLUDE_PATH"] = os.getcwd()

# compile all
case_names = [
      # "B_BUFFER",
    # "C_BUFFER",
    # "CONV_STATE",
    # "CONV",
    # "DAH",
    # "DBU",
    # "DTA",
    # "DTADAPT",
    # "DTB_QUANT_FP",
    # "DTB_QUANT",
    # "DTB",
    # "EXP_QUANT",
    # "EXP",
    # "GEMM_DEMUX",
    # "GEMM_MUX",
    # "GEMM",
    # "HT_ADD_QUANT",
    # "HT_ADD",
    # "HT_STATE",
    # "HTC_QUANT",
    # "HTC",
    # "M_AXI_FLOW",
    # "M_AXI_STATIC",
    # "QUANT_CONV",
    "RESIDUAL",
    # "RMSNORM_1",
    # "RMSNORM_2",
    # "RMSNORM_QUATNT_1",
    # "RMSNORM_QUATNT_2",
    # "SILU_DEMUX",
    # "SILU_MUX",
    # "SILU_QUANT",
    # "SILU",
    # "SOFTPLUS",
    # "UD",
    # "YZ"
]

INSTANCE_DIR = os.path.join(ROOT_DIR, "instances")

create_subprojects(INSTANCE_DIR, case_names=case_names, overwrite=True)

# create the tcl files for each subproject
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=True)
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csynth=True)
create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=True, do_csynth=True)
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=True, do_csynth=True, do_syn=True)
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=True, do_csynth=True, do_cosim=True)
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=True, do_csynth=True, do_cosim=True, cosim_random_stall=True)
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=True, do_csynth=True, do_cosim=True, do_syn=True)
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=True, do_csynth=True, do_cosim=True, do_impl=True, phys_opt="all")
# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=False, do_csynth=True, do_cosim=False, do_impl=True, phys_opt="all")

# create_tcls(INSTANCE_DIR, case_names=case_names, do_csim=False, do_csynth=True, do_cosim=False, do_impl=True, phys_opt="all", pipeline_style="frp")

# launch the tcl files
run_instances(INSTANCE_DIR, case_names=case_names, version="2024.2")
# WARNING: DO NOT USE 2023.2, MAIN GEMM WILL FAIL
# run_instances(INSTANCE_DIR, case_names=case_names, version="2023.2")
# run_instances(INSTANCE_DIR, case_names=case_names, version="2021.2")
# run_instances(INSTANCE_DIR, case_names=case_names, version="2020.1")

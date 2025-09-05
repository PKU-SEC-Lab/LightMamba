from post_syn_process import *
from pre_syn_process import *

import os
os.environ["CPLUS_INCLUDE_PATH"] = os.getcwd()

case_names = [
    # "RMSNORM"
    # "CORDIC"
    # "QUANTIZER"
    # "GEMM"
    # "ROPE_QK_QUANT"
    # "MUX"
    # "BUFFER_TESTBENCH"
    # "RV_GEMM"
    # "QUANTIZER"
    # "GEMM_PERMUTE"
    "MUX"
]

INSTANCE_DIR = os.path.join(ROOT_DIR, "instances")


for case_name in case_names:
    workspace_path = os.path.join(INSTANCE_DIR, f"proj_{case_name}", "work")
    # use os.system to open HLS gui
    os.system(f'vitis_hls -p {workspace_path} ')
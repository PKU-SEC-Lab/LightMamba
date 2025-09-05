import os
import numpy as np

binary_path = "C:/projects/ClionProjects/LLM/cmake-build-debug/binaries_renamed/"
target_path = "C:/projects/AAAProjects/PROJ14_LLM/src/ref/"

print("binary_path: ", binary_path)
print("target_path: ", target_path)

if not os.path.exists(target_path):
    os.makedirs(target_path)
    

# // read decoder hyperparams
#     auto DECODER_HYPERPARAMS = read_tensor<int64_t>(prefix + "DECODER_HYPERPARAMS.bin");
#     int idx = 0;
#     auto C = DECODER_HYPERPARAMS[idx++];
#     auto GA = DECODER_HYPERPARAMS[idx++];
#     auto GW = DECODER_HYPERPARAMS[idx++];
#     auto GR = DECODER_HYPERPARAMS[idx++];
#     auto H = DECODER_HYPERPARAMS[idx++];
#     auto KVH = DECODER_HYPERPARAMS[idx++];
#     auto HC = DECODER_HYPERPARAMS[idx++];
#     auto CM = DECODER_HYPERPARAMS[idx++];
#     auto N_BITS = DECODER_HYPERPARAMS[idx++];
#     cout << "C=" << C << " G=" << GA << " GW=" << GW << " GR=" << GR << " H=" << H << " KVH=" << KVH << " HC=" << HC << " CM=" << CM << " N_BITS=" << N_BITS << endl;

#     auto HC2 = HC / 2;

#     // read MHA truncs
#     auto MHA_TRUNCS = read_tensor<int64_t>(prefix + "MHA_TRUNCS.bin");
#     idx = 0;
#     auto MHA_TRUNC_QK = MHA_TRUNCS[idx++];
#     auto MHA_TRUNC_V = MHA_TRUNCS[idx++];
#     auto MHA_TRUNC_R = MHA_TRUNCS[idx++];
#     auto MHA_TRUNC_A = MHA_TRUNCS[idx++];
#     auto MHA_TRUNC_O = MHA_TRUNCS[idx++];

#     // read rmsnorm hyperparams
#     auto MHA_RMSNORM_HYPERPARAMS = read_tensor<int64_t>(prefix + "MHA_RMSNORM_HYPERPARAMS.bin");
#     idx = 0;
#     auto MHA_RMSNORM_RSQRT_BITS = MHA_RMSNORM_HYPERPARAMS[idx++];
#     auto MHA_RMSNORM_RSQRT_ENTRIES = MHA_RMSNORM_HYPERPARAMS[idx++];
#     auto MHA_RMSNORM_RSQRT_NUM_TABLES = MHA_RMSNORM_HYPERPARAMS[idx++];
#     auto MHA_RMSNORM_TRUNC_MUL1 = MHA_RMSNORM_HYPERPARAMS[idx++];
#     auto MHA_RMSNORM_TRUNC_MUL2 = MHA_RMSNORM_HYPERPARAMS[idx++];
#     cout << "RMSNORM_RSQRT_BITS=" << MHA_RMSNORM_RSQRT_BITS << " MHA_RMSNORM_RSQRT_ENTRIES=" << MHA_RMSNORM_RSQRT_ENTRIES
#          << " MHA_RMSNORM_RSQRT_NUM_TABLES=" << MHA_RMSNORM_RSQRT_NUM_TABLES << " MHA_RMSNORM_TRUNC_MUL1="
#          << MHA_RMSNORM_TRUNC_MUL1 << " MHA_RMSNORM_TRUNC_MUL2=" << MHA_RMSNORM_TRUNC_MUL2 << endl;
#     // read MHA_RMSNORM tensors
#     auto MHA_RMSNORM_LOG2DENOMS = read_tensor<int64_t>(prefix + "MHA_RMSNORM_LOG2DENOMS.Bin");
#     auto MHA_RMSNORM_ALPHAS = read_tensor<int64_t>(prefix + "MHA_RMSNORM_ALPHAS.bin");
#     auto MHA_RMSNORM_TABLES = read_tensor<int64_t>(prefix + "MHA_RMSNORM_TABLES.bin");
#     auto MHA_RMSNORM_OFFSETS_DIFF = read_tensor<int64_t>(prefix + "MHA_RMSNORM_OFFSETS_DIFF.bin");
#     auto MHA_RMSNORM_LNW = read_tensor<int64_t>(prefix + "MHA_RMSNORM_LNW.bin");

#     // read cordic hyperparams
#     auto CORDIC_HYPERPARAMS = read_tensor<int64_t>(prefix + "MHA_CORDIC_HYPERPARAMS.bin");
#     idx = 0;
#     auto CORDIC_N_ITER = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_K = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_O_ANGLE = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_O_K = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_FIXED_4_PI = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_FIXED_PI_2 = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_FIXED_PI = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_FIXED_3PI_2 = CORDIC_HYPERPARAMS[idx++];
#     auto CORDIC_FIXED_2PI = CORDIC_HYPERPARAMS[idx++];
#     cout << "CORDIC_N_ITER=" << CORDIC_N_ITER << " CORDIC_O_ANGLE=" << CORDIC_O_ANGLE << " CORDIC_O_K=" << CORDIC_O_K
#          << " CORDIC_FIXED_4_PI=" << CORDIC_FIXED_4_PI << " CORDIC_FIXED_PI_2=" << CORDIC_FIXED_PI_2 << " CORDIC_FIXED_PI="
#          << CORDIC_FIXED_PI << " CORDIC_FIXED_3PI_2=" << CORDIC_FIXED_3PI_2 << " CORDIC_FIXED_2PI=" << CORDIC_FIXED_2PI << endl;
#     // read cordic tensors
#     auto CORDIC_THETAS = read_tensor<int64_t>(prefix + "MHA_CORDIC_THETAS.bin");
#     // read rope hyperparams
#     auto ROPE_HYPERPARAMS = read_tensor<int64_t>(prefix + "MHA_ROPE_HYPERPARAMS.bin");
#     idx = 0;
#     auto ROPE_TRUNC_MUL = ROPE_HYPERPARAMS[idx++];
#     // read rope tensors
#     auto ROPE_THETAS = read_tensor<int64_t>(prefix + "MHA_ROPE_THETAS.bin");

#     // read softmax hyperparams
#     auto SOFTMAX_HYPERPARAMS = read_tensor<int64_t>(prefix + "MHA_SOFTMAX_HYPERPARAMS.bin");
#     idx = 0;
#     auto EXP_LOG2DENOM = SOFTMAX_HYPERPARAMS[idx++];
#     auto EXP_ENTRIES = SOFTMAX_HYPERPARAMS[idx++];
#     auto RECIP_NUM_TABLES = SOFTMAX_HYPERPARAMS[idx++];
#     auto RECIP_ENTRIES = SOFTMAX_HYPERPARAMS[idx++];
#     auto SOFTMAX_TRUNC_MUL = SOFTMAX_HYPERPARAMS[idx++];
#     // read softmax tensors
#     auto EXP_TABLE = read_tensor<int64_t>(prefix + "MHA_SOFTMAX_EXP_TABLE.bin");
#     auto RECIP_TABLES = read_tensor<int64_t>(prefix + "MHA_SOFTMAX_RECIP_TABLES.bin");
#     auto RECIP_ALPHAS = read_tensor<int64_t>(prefix + "MHA_SOFTMAX_RECIP_ALPHAS.bin");
#     auto RECIP_LOG2DENOMS = read_tensor<int64_t>(prefix + "MHA_SOFTMAX_RECIP_LOG2DENOMS.bin");
#     auto RECIP_OFFSETS_DIFF = read_tensor<int64_t>(prefix + "MHA_SOFTMAX_RECIP_OFFSETS_DIFF.bin");
#     cout << "EXP_LOG2DENOM=" << EXP_LOG2DENOM << " EXP_ENTRIES=" << EXP_ENTRIES << " RECIP_NUM_TABLES=" << RECIP_NUM_TABLES
#          << " SOFTMAX_TRUNC_MUL=" << SOFTMAX_TRUNC_MUL << endl;

#     // read MLP rmsnorm hyperparams
#     auto MLP_RMSNORM_HYPERPARAMS = read_tensor<int64_t>(prefix + "MLP_RMSNORM_HYPERPARAMS.bin");
#     idx = 0;
#     auto MLP_RMSNORM_RSQRT_BITS = MLP_RMSNORM_HYPERPARAMS[idx++];
#     auto MLP_RMSNORM_RSQRT_ENTRIES = MLP_RMSNORM_HYPERPARAMS[idx++];
#     auto MLP_RMSNORM_RSQRT_NUM_TABLES = MLP_RMSNORM_HYPERPARAMS[idx++];
#     auto MLP_RMSNORM_TRUNC_MUL1 = MLP_RMSNORM_HYPERPARAMS[idx++];
#     auto MLP_RMSNORM_TRUNC_MUL2 = MLP_RMSNORM_HYPERPARAMS[idx++];
#     cout << "MLP_RMSNORM_RSQRT_BITS=" << MLP_RMSNORM_RSQRT_BITS << " MLP_RMSNORM_RSQRT_ENTRIES=" << MLP_RMSNORM_RSQRT_ENTRIES
#          << " MLP_RMSNORM_RSQRT_NUM_TABLES=" << MLP_RMSNORM_RSQRT_NUM_TABLES << " MLP_RMSNORM_TRUNC_MUL1="
#          << MLP_RMSNORM_TRUNC_MUL1 << " MLP_RMSNORM_TRUNC_MUL2=" << MLP_RMSNORM_TRUNC_MUL2 << endl;
#     // read MLP rmsnorm tensors
#     auto MLP_RMSNORM_LOG2DENOMS = read_tensor<int64_t>(prefix + "MLP_RMSNORM_LOG2DENOMS.bin");
#     auto MLP_RMSNORM_ALPHAS = read_tensor<int64_t>(prefix + "MLP_RMSNORM_ALPHAS.bin");
#     auto MLP_RMSNORM_TABLES = read_tensor<int64_t>(prefix + "MLP_RMSNORM_TABLES.bin");
#     auto MLP_RMSNORM_OFFSETS_DIFF = read_tensor<int64_t>(prefix + "MLP_RMSNORM_OFFSETS_DIFF.bin");
#     auto MLP_RMSNORM_LNW = read_tensor<int64_t>(prefix + "MLP_RMSNORM_LNW.bin");

#     // read SiLU hyperparams
#     auto SILU_HYPERPARAMS = read_tensor<int64_t>(prefix + "MLP_SILU_HYPERPARAMS.bin");
#     idx = 0;
#     auto SILU_LOG2DENOM = SILU_HYPERPARAMS[idx++];
#     auto SILU_ENTRIES = SILU_HYPERPARAMS[idx++];
#     auto SILU_O_BACK = SILU_HYPERPARAMS[idx++];
#     cout << "SILU_LOG2DENOM=" << SILU_LOG2DENOM << " SILU_ENTRIES=" << SILU_ENTRIES << " SILU_O_BACK=" << SILU_O_BACK << endl;
#     // read SiLU tensors
#     auto SILU_TABLE = read_tensor<int64_t>(prefix + "MLP_SILU_TABLE.bin");

#     // read MLP truncs
#     auto MLP_TRUNCS = read_tensor<int64_t>(prefix + "MLP_TRUNCS.bin");
#     idx = 0;
#     auto MLP_TRUNC_MUL = MLP_TRUNCS[idx++];
#     auto MLP_TRUNC_D = MLP_TRUNCS[idx++];
#     cout << "MLP_TRUNC_MUL=" << MLP_TRUNC_MUL << " MLP_TRUNC_D=" << MLP_TRUNC_D << endl;

bin_names = [
    "DECODER_HYPERPARAMS.bin",
    "MHA_TRUNCS.bin",
    "MHA_RMSNORM_HYPERPARAMS.bin",
    "MHA_RMSNORM_LOG2DENOMS.bin",
    "MHA_RMSNORM_ALPHAS.bin",
    "MHA_RMSNORM_TABLES.bin",
    "MHA_RMSNORM_OFFSETS_DIFF.bin",
    "MHA_RMSNORM_LNW.bin",
    "MHA_CORDIC_HYPERPARAMS.bin",
    "MHA_CORDIC_THETAS.bin",
    "MHA_ROPE_HYPERPARAMS.bin",
    "MHA_ROPE_THETAS.bin",
    "MHA_SOFTMAX_HYPERPARAMS.bin",
    "MHA_SOFTMAX_EXP_TABLE.bin",
    "MHA_SOFTMAX_RECIP_TABLES.bin",
    "MHA_SOFTMAX_RECIP_ALPHAS.bin",
    "MHA_SOFTMAX_RECIP_LOG2DENOMS.bin",
    "MHA_SOFTMAX_RECIP_OFFSETS_DIFF.bin",
    "MLP_RMSNORM_HYPERPARAMS.bin",
    "MLP_RMSNORM_LOG2DENOMS.bin",
    "MLP_RMSNORM_ALPHAS.bin",
    "MLP_RMSNORM_TABLES.bin",
    "MLP_RMSNORM_OFFSETS_DIFF.bin",
    "MLP_RMSNORM_LNW.bin",
    "MLP_SILU_HYPERPARAMS.bin",
    "MLP_SILU_TABLE.bin",
    "MLP_TRUNCS.bin"
]

def savetxt(data, path):
    with open(path, "w") as f:
        f.write(','.join([f"{d: 4d}" for d in data]))
        
            
MHA_RMSNORM_FILES = [bin_name for bin_name in bin_names if "MHA_RMSNORM" in bin_name and "LNW" not in bin_name]
MLP_RMSNORM_FILES = [bin_name.replace("MHA", "MLP") for bin_name in MHA_RMSNORM_FILES]

# check, if RMSNORM in the name, MHA and MLP should be the same
for decoder_id in range(32):
    # compare MHA and MLP
    for MHA_FILE, MLP_FILE in zip(MHA_RMSNORM_FILES, MLP_RMSNORM_FILES):
        print(f"comparing {MHA_FILE} and {MLP_FILE}")
        MHA_PATH = os.path.join(binary_path, f"decoder_{decoder_id}", MHA_FILE)
        MLP_PATH = os.path.join(binary_path, f"decoder_{decoder_id}", MLP_FILE)
        MHA_DATA = np.fromfile(MHA_PATH, dtype=np.int64).reshape(-1)
        MLP_DATA = np.fromfile(MLP_PATH, dtype=np.int64).reshape(-1)
        assert np.array_equal(MHA_DATA, MLP_DATA), f"decoder_{decoder_id} {MHA_FILE} not equal to {MLP_FILE}"

        # np.savetxt(os.path.join(target_path, MHA_FILE.replace(".bin", ".txt").replace("MHA_", "")), MHA_DATA, fmt='%d', delimiter=',')
        savetxt(MHA_DATA, os.path.join(target_path, MHA_FILE.replace(".bin", ".txt").replace("MHA_", "")))

# use decoder_0 as reference
# all the parameters should be the same, except the MHA_RMSNORM_LNW and MLP_RMSNORM_LNW
ref_decoder_id = 0
for decoder_id in range(32):
    for bin_name in bin_names:
        bin_path        = os.path.join(binary_path, f"decoder_{decoder_id}", bin_name)
        bin_ref_path    = os.path.join(binary_path, f"decoder_{ref_decoder_id}", bin_name)
        txt_path        = os.path.join(target_path, f"decoder_{decoder_id}", bin_name.replace(".bin", ".txt"))
        # use np fromfile to read binary file
        data        = np.fromfile(bin_path, dtype=np.int64).reshape(-1)
        data_ref    = np.fromfile(bin_ref_path, dtype=np.int64).reshape(-1)
        # compare with reference
        if "LNW" in bin_name:
            pass
        else:
            assert np.array_equal(data, data_ref), f"decoder_{decoder_id} {bin_name} not equal to ref_decoder_{ref_decoder_id}"


# for LNW, concat them together, order is MHA0 -> MLP0 -> MHA1 -> MLP1 -> ...
for bin_name in bin_names:
    if bin_name in MHA_RMSNORM_FILES or bin_name in MLP_RMSNORM_FILES:
        continue
    bin_path = os.path.join(binary_path, f"decoder_{ref_decoder_id}", bin_name)
    txt_path = os.path.join(target_path, bin_name.replace(".bin", ".txt"))
    print(f"converting {bin_path} to {txt_path}")
    data = np.fromfile(bin_path, dtype=np.int64).reshape(-1)
    # np.savetxt(txt_path, data, fmt='%d', delimiter=',')
    savetxt(data, txt_path)
# special handling for LNW
data = []
for decoder_id in range(32):
    for bin_name in ["MHA_RMSNORM_LNW.bin", "MLP_RMSNORM_LNW.bin"]:
        bin_path = os.path.join(binary_path, f"decoder_{decoder_id}", bin_name)
        data.append(np.fromfile(bin_path, dtype=np.int64).reshape(-1))
data = np.concatenate(data)
txt_path = os.path.join(target_path, "RMSNORM_LNW.txt")
print(f"converting all LNW to {txt_path}")
# np.savetxt(txt_path, data, fmt='%d', delimiter=',')
savetxt(data, txt_path)


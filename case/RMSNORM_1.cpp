/**
 * This module tests the RMS normalization operation by loading reference data, creating input streams,
 * executing the RMSNORM operation, and comparing the output against reference data. The implementation
 * is optimized for HLS with stream interfaces.
 */
#include "../src/common.h"
#include "../src/rmsnorm1.h"
#include <cstdint> // 包含 int8_t 的定义
#include <stdint.h>
#include "../src/utils.h"

/** @brief Number of test layers */
constexpr int TEST_L = 2;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;

/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = 1;

/** @brief Channel dimension size */
constexpr int C = 2560;
/** @brief Channel parallelism */
constexpr int CP = 8;

/** @brief Instance of the RMSNORM class with specified template parameters, initialized with RMSNORM_LNW weights */
RMSNORM<64, T, TP, C, CP> rmsnorm_inst(RMSNORM_LNW);

/** @brief Number of time tiles */
constexpr int TT = rmsnorm_inst.TT;
/** @brief Number of channel tiles */
constexpr int CT = rmsnorm_inst.CT;

/**
 * @brief Top-level function for the RMSNORM test module.
 *
 * Executes the RMS normalization operation for a specific layer on the input stream and produces an output stream.
 *
 * @param l Layer index to process.
 * @param i_stream Input stream of data with TP*CP parallelism.
 * @param o_stream Output stream of normalized data with TP*CP parallelism.
 */
void top(int l, hls::stream<hls::vector<X_T, TP * CP> > &i_stream, hls::stream<hls::vector<XLN_T, TP * CP> > &o_stream){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=o_stream

    /**< Execute RMS normalization */
    rmsnorm_inst.do_rmsnorm(l, i_stream, o_stream);
}

// Reference and DUT data declarations
int64_t REF_X                   [T*C];
int64_t REF_XLN                 [T*C];
int64_t DUT_XLN                 [T*C];


/**
 * @brief Test function for a single RMSNORM layer.
 *
 * Loads reference data, creates input streams, runs the RMSNORM operation, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";

    // read refs, both MHA and MLP
    auto INPUT_X                  = read_tensor<int64_t>(file_path + "/before_rms1_layer"+file_path_suffix);
    auto INPUT_XLN                = read_tensor<int64_t>(file_path + "/rms1_layer"+file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t>(INPUT_X,    REF_X,          1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(INPUT_XLN,  REF_XLN,        1, 1, T_LOAD, T, C, C);

   // Create input and output streams
    hls::stream<hls::vector<X_T,    TP * CP> > i_stream;
    hls::stream<hls::vector<XLN_T,  TP * CP> > o_stream;

    // Populate input stream
    array2stream<int64_t, X_T, 1, 1, T, TP, C, CP>(REF_X, i_stream, "X", true);

    // // Execute the top function
    std::cout << "Calling top" << std::endl;
    top(l, i_stream, o_stream);
    std::cout << "Finished" << std::endl;

    // Read output stream into array
    stream2array<int64_t, XLN_T, 1, T, TP, C, CP>(o_stream, DUT_XLN, "XLN", true);

    // Verify that streams are empty
    assert(i_stream.empty());
    assert(o_stream.empty());

    // Compare output with reference
    compare<int64_t>(REF_XLN, DUT_XLN, T*C, "XLN");

}


/**
 * @brief Main function to run tests for all layers.
 *
 * Iterates through all test layers and calls the test function for each.
 * @return 0 on successful completion.
 */
int main(){
    for(int l=0; l<TEST_L; ++l){
        test_layer(l);
    }
    return 0;
}
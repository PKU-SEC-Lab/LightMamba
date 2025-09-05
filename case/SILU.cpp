/*
 * This module tests the SILU (Sigmoid Linear Unit) operation by loading reference data, creating input streams,
 * executing the SILU operation, and comparing the output against reference data. The implementation is optimized
 * for HLS with stream interfaces and dataflow directives.
 */
#include "../src/common.h"
#include "../src/silu.h"
#include <thread>

/** @brief Number of test layers */
constexpr int TEST_L = 2;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;

/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = 1;

/** @brief Channel dimension size */
constexpr int C = 4 * 2560 + 2 * 128;
/** @brief Channel parallelism */
constexpr int CP = 8;

/** @brief Input data type for SILU operation */
typedef SILU_IN_T if_t;
/** @brief Output data type for SILU operation */
typedef SILU_OUT_T silu_t;

/** @brief Instance of the SILU class with specified template parameters */
SILU<if_t, silu_t, T, TP, C, CP> silu_inst;

/** @brief Number of time tiles */
constexpr int TT = silu_inst.TT;
/** @brief Number of channel tiles */
constexpr int CT = silu_inst.CT;

// define top function
/**
 * @brief Top-level function for the SILU test module.
 *
 * Executes the SILU operation to apply the Sigmoid Linear Unit activation function on the input stream
 * and produces an output stream.
 *
 * @param i_stream Input stream of data with TP*CP parallelism.
 * @param o_stream Output stream of computed results with TP*CP parallelism.
 */
void top(hls::stream<hls::vector<if_t, TP * CP> > &i_stream, hls::stream<hls::vector<silu_t, TP * CP> > &o_stream){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit
     // Execute SILU operation
    silu_inst.do_silu(i_stream, o_stream);
}

// Reference and DUT data declarations
int64_t REF_X               [T*C];
int64_t REF_SILU            [T*C];
int64_t DUT_SILU            [T*C];

/**
 * @brief Test function for a single SILU layer.
 *
 * Loads reference data, creates input streams, runs the SILU operation, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // // Read reference data
    auto SILU_IN     = read_tensor<int64_t>(file_path + "/xBCz_layer"+file_path_suffix);
    auto SILU_OUT    = read_tensor<int64_t>(file_path + "/xBCz_silu_layer"+file_path_suffix);
    // put the data into REF
    // Convert tensors to arrays
    tensor2array<int64_t>(SILU_IN, REF_X,     1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(SILU_OUT, REF_SILU, 1, 1, T_LOAD, T, C, C);

    // Create input and output streams
    hls::stream<hls::vector<if_t,  TP * CP> > i_stream("i_stream");
    hls::stream<hls::vector<silu_t, TP * CP> > o_stream("o_stream");

    // Write input data to stream
    array2stream<int64_t, if_t, 1, 1, T, TP, C, CP>(REF_X, i_stream, "SILU_IN", true);

    // call top function
    top(i_stream, o_stream);

    // // Read output stream into array
    stream2array<int64_t, silu_t, 1, T, TP, C, CP>(o_stream, DUT_SILU, "SILU", true);

    // Verify that streams are empty
    assert(i_stream.empty());
    assert(o_stream.empty());

    // Compare output with reference
    compare<int64_t>(REF_SILU, DUT_SILU, T*C, "SILU");

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
        // printf("Layer %d passed\n", l);
    }
    return 0;
}
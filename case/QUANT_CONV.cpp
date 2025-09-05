/** 
 * This module tests the quantization operation by loading reference data, creating input streams,
 * executing the quantization operation, and comparing the output against reference data. The implementation
 * is optimized for HLS with stream interfaces and aggregation directives.
 */
#include "../src/common.h"
#include "../src/quantizer.h"
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
constexpr int C = 5376;
/** @brief Channel parallelism */
constexpr int CP = 8;
/** @brief Group size for quantization */
constexpr int G = 8;

/** @brief Instance of the QUANTIZER class with specified template parameters */
QUANTIZER<X_T, A_T, AS_T, 1, T, TP, C, CP, G> quantizer_inst;

/** @brief Number of time tiles */
constexpr int TT = T / TP;
/** @brief Number of channel tiles */
constexpr int CT = C / CP;

/**
 * @brief Top-level function for the QUANTIZER test module.
 *
 * Executes the quantization operation on the input stream, producing quantized output and scale streams.
 *
 * @param i_stream Input stream of data with TP*CP parallelism.
 * @param o_stream Output stream of quantized data with TP*CP parallelism.
 * @param o_s_stream Output stream of scale data with TP parallelism.
 */
void top(
    hls::stream<hls::vector<X_T, TP * CP> >  &i_stream, 
    hls::stream<hls::vector<A_T, TP * CP> >  &o_stream,
    hls::stream<hls::vector<AS_T, TP     > > &o_s_stream
    ){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=o_stream
    #pragma HLS interface axis port=o_s_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit
    #pragma HLS aggregate variable=o_s_stream compact=bit

    /**< Execute quantization */
    quantizer_inst.do_quant(i_stream,o_stream,o_s_stream);
}

// Reference and DUT data declarations
int64_t REF_X            [T*C];
int64_t REF_Q            [T*C];
int64_t REF_S            [T*CT];
int64_t DUT_Q            [T*C];
int64_t DUT_S            [T*CT];


/**
 * @brief Test function for a single QUANTIZER layer.
 *
 * Loads reference data, creates input streams, runs the quantization operation, and compares the output
 * against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // Read reference data
    auto IN       = read_tensor<int64_t>(file_path + "/xBC_layer" + file_path_suffix);
    auto OUT_Q    = read_tensor<int64_t>(file_path + "/xBC_q_layer" + file_path_suffix);
    auto OUT_S    = read_tensor<int64_t>(file_path + "/xBC_s_layer" + file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t>(IN,    REF_X, 1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(OUT_Q, REF_Q, 1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(OUT_S, REF_S, 1, 1, T_LOAD, T, CT, CT);

    // create streams
    hls::stream<hls::vector<X_T,  TP * CP> > i_stream("i_stream");
    hls::stream<hls::vector<A_T,  TP * CP> > o_stream("o_stream");
    hls::stream<hls::vector<AS_T, TP     > > o_s_stream("o_s_stream");  

   // Populate input stream
    array2stream<int64_t, X_T, 1, 1, T, TP, C, CP>(REF_X, i_stream, "IN", true);

    // call top function
    top(i_stream, o_stream, o_s_stream);

    // read output stream
    stream2array<int64_t, A_T, 1, T, TP, C, CP>(o_stream, DUT_Q, "Q", true);
    stream2array<int64_t, AS_T, 1, T, TP, CT, 1>(o_s_stream, DUT_S, "S", true);

    // Verify that streams are empty
    assert(i_stream.empty());
    assert(o_stream.empty());
    assert(o_s_stream.empty());
    
    // Compare outputs with reference
    compare<int64_t>(REF_Q, DUT_Q, T*C, "Q");
    compare<int64_t>(REF_S, DUT_S, T*CT, "S");
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
/**
 * This module tests the SILU (Sigmoid Linear Unit) operation followed by quantization by loading reference data,
 * creating input streams, executing the SILU and QUANTIZER operations, and comparing the output against reference data.
 * The implementation is optimized for HLS with dataflow and stream interfaces.
 */

#include "../src/common.h"
#include "../src/silu.h"
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
constexpr int C = 4 * 2560 + 2 * 128;
/** @brief Channel parallelism */
constexpr int CP = 8;
/** @brief Group size for quantization */
constexpr int G = 8;

/** @brief Input data type for SILU operation */
typedef SILU_IN_T if_t;
/** @brief Output data type for SILU operation */
typedef SILU_OUT_T silu_t;

/** @brief Instance of the SILU class with specified template parameters */
SILU<if_t, silu_t, T, TP, C, CP> silu_inst;
/** @brief Instance of the QUANTIZER class with specified template parameters */
QUANTIZER<silu_t, A_T, AS_T, 1, T, TP, C, CP, G> quantizer_inst;

/** @brief Number of time tiles */
constexpr int TT = silu_inst.TT;
/** @brief Number of channel tiles */
constexpr int CT = silu_inst.CT;


/**
 * @brief Top-level function for the SILU and QUANTIZER test module.
 *
 * Executes the SILU operation followed by quantization on the input stream, producing quantized output and scale streams.
 *
 * @param i_stream Input stream of data with TP*CP parallelism.
 * @param out_stream Output stream of quantized data with TP*CP parallelism.
 * @param out_s_stream Output stream of scale data with TP parallelism.
 */
void top(
    hls::stream<hls::vector<if_t, TP * CP> > &i_stream, 
    hls::stream<hls::vector<A_T, TP * CP> > &out_stream,
    hls::stream<hls::vector<AS_T, TP     > > &out_s_stream
    ){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=out_stream
    #pragma HLS interface axis port=out_s_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=out_stream compact=bit
    #pragma HLS aggregate variable=out_s_stream compact=bit
    #pragma HLS dataflow

    hls::stream<hls::vector<silu_t, TP * CP> > temp_stream;
// Execute SILU and QUANTIZER operations
    silu_inst.do_silu(i_stream, temp_stream);
    quantizer_inst.do_quant(temp_stream,out_stream,out_s_stream);
}

// Reference and DUT data declarations
int64_t REF_X                 [T*C];
int64_t REF_SILU_Q            [T*C];
int64_t REF_SILU_S            [T*CT];
int64_t DUT_SILU_Q            [T*C];
int64_t DUT_SILU_S            [T*CT];

/**
 * @brief Test function for a single SILU and QUANTIZER layer.
 *
 * Loads reference data, creates input streams, runs the SILU and QUANTIZER operations, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // // Read reference data
    auto SILU_IN       = read_tensor<int64_t>(file_path + "/xBCz_layer" + file_path_suffix);
    auto SILU_OUT_Q    = read_tensor<int64_t>(file_path + "/xBCz_silu_q_layer" + file_path_suffix);
    auto SILU_OUT_S    = read_tensor<int64_t>(file_path + "/xBCz_silu_s_layer" + file_path_suffix);

    // put the data into REF
    tensor2array<int64_t>(SILU_IN,    REF_X,     1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(SILU_OUT_Q, REF_SILU_Q, 1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(SILU_OUT_S, REF_SILU_S, 1, 1, T_LOAD, T, CT, CT);

    // Create input and output streams
    hls::stream<hls::vector<if_t,  TP * CP> > i_stream("i_stream");
    hls::stream<hls::vector<A_T, TP * CP> > o_stream("o_stream");
    hls::stream<hls::vector<AS_T, TP     > > o_s_stream("o_s_stream");  

     // Write input data to stream
    array2stream<int64_t, if_t, 1, 1, T, TP, C, CP>(REF_X, i_stream, "SILU_IN", true);

   // Execute the top function
    top(i_stream, o_stream, o_s_stream);

    // read output stream
    stream2array<int64_t, A_T, 1, T, TP, C, CP>(o_stream, DUT_SILU_Q, "SILU_Q", true);
    stream2array<int64_t, AS_T, 1, T, TP, CT, 1>(o_s_stream, DUT_SILU_S, "SILU_S", true);
    // Verify that streams are empty
    assert(i_stream.empty());
    assert(o_stream.empty());
    assert(o_s_stream.empty());
    
    // Compare outputs with reference
    compare<int64_t>(REF_SILU_Q, DUT_SILU_Q, T*C, "SILU_Q");
    compare<int64_t>(REF_SILU_S, DUT_SILU_S, T*CT, "SILU_S");
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
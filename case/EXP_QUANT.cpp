/**
 * @brief This module tests the exponential operation followed by quantization by loading reference data,
 * creating input streams, executing the EXP and QUANTIZER operations, and comparing the output
 * against reference data. The implementation is optimized for HLS with dataflow and stream interfaces.
 */

#include "../src/common.h"
#include "../src/exp.h"
#include "../src/quantizer.h"
#include <thread>

constexpr int TEST_L         = 2;

/** @brief Number of test layers */
constexpr int TEST_L = 2;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;

/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = 1;

/** @brief Channel dimension size */
constexpr int C = (2 * 2560) / 64;
/** @brief Channel parallelism */
constexpr int CP = 8;
/** @brief Group size for quantization */
constexpr int G = 8;

/** @brief Input data type for the EXP module */
typedef EXP_IN_T if_t;
/** @brief Output data type for the EXP module */
typedef EXP_OUT_T exp_t;

/** @brief Instance of the EXP class with specified template parameters */
EXP<if_t, exp_t, T, TP, C, CP> exp_inst;
/** @brief Instance of the QUANTIZER class with specified template parameters */
QUANTIZER<exp_t, A_T, AS_T, 1, T, TP, C, CP, G> quantizer_inst;

/** @brief Number of time tiles */
constexpr int TT = exp_inst.TT;
/** @brief Number of channel tiles */
constexpr int CT = exp_inst.CT;


/**
 * @brief Top-level function for the EXP and QUANTIZER test module.
 *
 * Executes the exponential operation followed by quantization, processing input streams and
 * producing quantized and scale output streams.
 *
 * @param i_stream Input stream of data with TP*CP parallelism.
 * @param o_stream Output stream of quantized data with TP*CP parallelism.
 * @param o_s_stream Output stream of scale data with TP parallelism.
 */
// define top function
void top(
    hls::stream<hls::vector<if_t, TP * CP> > &i_stream, 
    hls::stream<hls::vector<A_T, TP * CP> > &o_stream,
    hls::stream<hls::vector<AS_T, TP     > > &o_s_stream
    ){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=o_stream
    #pragma HLS interface axis port=o_s_stream
    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit
    #pragma HLS aggregate variable=o_s_stream compact=bit
    #pragma HLS dataflow
// Declare intermediate stream
    hls::stream<hls::vector<exp_t, TP * CP> > temp_stream;
    // Execute exponential operation
    exp_inst.do_exp(i_stream, temp_stream);
    // Execute quantization
    quantizer_inst.do_quant(temp_stream,o_stream,o_s_stream);

}

// Reference and DUT data declarations
int64_t REF_X                [T*C];
int64_t REF_exp_Q            [T*C];
int64_t REF_exp_S            [T*CT];
int64_t DUT_exp_Q            [T*C];
int64_t DUT_exp_S            [T*CT];


/**
 * @brief Test function for a single layer of EXP and QUANTIZER.
 *
 * Loads reference data, creates input streams, runs the EXP and QUANTIZER operations,
 * and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
 // Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Read reference tensors
    auto exp_IN     = read_tensor<int64_t>(file_path + "/dA_before_exp_layer" + file_path_suffix);
    auto exp_OUT_Q    = read_tensor<int64_t>(file_path + "/dA_exp_q_layer" + file_path_suffix);
    auto exp_OUT_S    = read_tensor<int64_t>(file_path + "/dA_exp_s_layer" + file_path_suffix);

    // put the data into REF
    // Convert tensors to arrays
    tensor2array<int64_t>(exp_IN, REF_X,     1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(exp_OUT_Q, REF_exp_Q, 1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(exp_OUT_S, REF_exp_S, 1, 1, T_LOAD, T, CT, CT);

    // create streams
    // Create input and output streams
    hls::stream<hls::vector<if_t,  TP * CP> > i_stream("i_stream");
    hls::stream<hls::vector<A_T, TP * CP> >  o_stream("o_stream");
    hls::stream<hls::vector<AS_T, TP     > > o_s_stream("o_s_stream");  

    // Write input data to stream
    array2stream<int64_t, if_t, 1, 1, T, TP, C, CP>(REF_X, i_stream, "exp_IN", true);

    // call top function
    top(i_stream, o_stream,o_s_stream);

    // Read output streams into arrays
    stream2array<int64_t, A_T, 1, T, TP, C, CP>(o_stream, DUT_exp_Q, "exp_Q", true);
    stream2array<int64_t, AS_T, 1, T, TP, CT, 1>(o_s_stream, DUT_exp_S, "exp_S", true);
    
    // Verify that streams are empty
    assert(i_stream.empty());
    assert(o_stream.empty());
    assert(o_s_stream.empty());

    // Compare outputs with reference
    compare<int64_t>(REF_exp_Q, DUT_exp_Q, T*C, "exp_Q");
    compare<int64_t>(REF_exp_S, DUT_exp_S, T*CT, "exp_S");

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
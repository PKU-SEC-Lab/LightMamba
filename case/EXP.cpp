/**
 * @file exp.cpp
 * @brief Testbench for the EXP class using HLS streams and LUT-based exponential evaluation.
 */

#include "../src/common.h"
#include "../src/exp.h"
#include <thread>
/**
 * @def TEST_L
 * @brief Number of test layers to run.
 */
constexpr int TEST_L         = 2;

// instanciate the exp inst
constexpr int T_LOAD    = 512;
//* actual size
constexpr int T         = 1;
constexpr int TP        = 1;
// scale down
// constexpr int T         = 2;
// constexpr int TP        = 1;

constexpr int C       = (2 * 2560) / 64;
constexpr int CP      = 8; // interface parallelism

typedef EXP_IN_T     if_t;
typedef EXP_OUT_T    exp_t;

EXP<if_t, exp_t, T, TP, C, CP> exp_inst;

constexpr int TT  = exp_inst.TT;
constexpr int CT  = exp_inst.CT;

// define top function
/**
 * @brief Top-level wrapper function for HLS synthesis.
 *
 * This function sets up AXIS interfaces and calls the EXP processing instance.
 *
 * @param i_stream Input stream of vectorized values
 * @param o_stream Output stream of exponentiated values
 */
void top(
    hls::stream<hls::vector<if_t, TP * CP> > &i_stream, 
    hls::stream<hls::vector<exp_t, TP * CP> > &o_stream
    ){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    exp_inst.do_exp(i_stream, o_stream);
}

/// Reference input values
int64_t REF_X              [T*C];
/// Reference exponential output values
int64_t REF_exp            [T*C];

/// Device Under Test output values
int64_t DUT_exp            [T*C];
/**
 * @brief Executes a single test on the exponential layer.
 *
 * Loads reference input/output tensors, streams data through the top function, 
 * collects output and compares against reference.
 *
 * @param l Index of the layer to test
 */
void test_layer(int l){
// Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // Read reference tensors
    // read refs
    auto exp_IN     = read_tensor<int64_t>(file_path + "/dA_before_exp_layer" + file_path_suffix);
    auto exp_OUT    = read_tensor<int64_t>(file_path + "/dA_exp_layer" + file_path_suffix);

    // put the data into REF
    // Convert tensors into flat arrays
    tensor2array<int64_t>(exp_IN, REF_X,     1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(exp_OUT, REF_exp, 1, 1, T_LOAD, T, C, C);

    // create streams
    // Declare HLS input/output streams
    hls::stream<hls::vector<if_t,  TP * CP> > i_stream("i_stream");
    hls::stream<hls::vector<exp_t, TP * CP> > o_stream("o_stream");

    // write input data to stream
     // Stream data from array into input stream
    array2stream<int64_t, if_t, 1, 1, T, TP, C, CP>(REF_X, i_stream, "exp_IN", true);

    // call top function
    top(i_stream, o_stream);

    // read output stream
    // Retrieve output into array
    stream2array<int64_t, exp_t, 1, T, TP, C, CP>(o_stream, DUT_exp, "exp", true);
// Ensure all data has been processed
    assert(i_stream.empty());
    assert(o_stream.empty());

    // sleep
    // Compare output against reference
    compare<int64_t>(REF_exp, DUT_exp, T*C, "exp");

}
/**
 * @brief Entry point for the exponential layer testbench.
 *
 * Runs multiple layers of exponential transform tests.
 *
 * @return 0 on success
 */

int main(){
    for(int l=0; l<TEST_L; ++l){
        test_layer(l);
        // printf("Layer %d passed\n", l);
    }
    return 0;
}
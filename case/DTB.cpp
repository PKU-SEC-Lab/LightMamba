/**
 * @brief Testbench for the DTB (Dot-Product Transformation) module in the Llama model.
 *
 * This module tests the DTB operation by loading reference data, creating input streams,
 * executing the DTB operation, and comparing the output against reference data. The
 * implementation is optimized for HLS with dataflow and stream interfaces.
 */

#include "../src/common.h"
#include "../src/dtB.h"

#include <pthread.h>


/** @brief Number of test layers */
constexpr int TEST_L = 2;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;

/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = 1;

/** @brief Channel dimension size */
constexpr int C = 80;
/** @brief Channel parallelism */
constexpr int CP = 8;

/** @brief Hidden dimension size */
constexpr int N = 128;
/** @brief Hidden dimension parallelism */
constexpr int NP = 8;

/** @brief Instance of the DTB class with specified template parameters */
DTB<T, C, CP, N, NP> dtB_inst;

/** @brief Number of channel tiles */
constexpr int CT = dtB_inst.CT;
/** @brief Number of hidden dimension tiles */
constexpr int NT2 = dtB_inst.NT2;

/**
 * @brief Top-level function for the DTB test module.
 *
 * Executes the DTB operation for a specified layer using the instantiated DTB instance,
 * processing input streams and producing an output stream.
 *
 * @param dt_stream Input stream of data with CP parallelism.
 * @param dt_s_stream Input stream of scale data with single element vectors.
 * @param B_stream Input stream of data with CP parallelism.
 * @param B_s_stream Input stream of scale data with single element vectors.
 * @param o_stream Output stream of computed results with CP parallelism.
 */
void top(
    hls::stream<hls::vector<A_T,      CP> >& dt_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& dt_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& B_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& B_s_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=dt_stream
    #pragma HLS interface axis port=dt_s_stream
    #pragma HLS interface axis port=B_stream
    #pragma HLS interface axis port=B_s_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=dt_stream compact=bit
    #pragma HLS aggregate variable=dt_s_stream compact=bit
    #pragma HLS aggregate variable=B_stream compact=bit
    #pragma HLS aggregate variable=B_s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow
 // Execute the DTB operation
    dtB_inst  .do_dtB   (dt_stream, dt_s_stream,  B_stream, B_s_stream,  o_stream );
}

// Reference and DUT data declarations
int64_t  REF_DT_Q               [T*C ];
int64_t  REF_DT_S               [T*CT];
int64_t  REF_B_Q                [T*N ];
int64_t  REF_B_S                [T*NT2];
int64_t  REF_DTB                [T*C*N ];
int64_t  DUT_DTB                [T*C*N ];

/**
 * @brief Test function for a single DTB layer.
 *
 * Loads reference data, creates input streams, runs the DTB operation, and compares
 * the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    // Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Read reference tensors
    auto DT_Q              = read_tensor<int64_t>(file_path + "/dt_softplus_q_layer" + file_path_suffix);
    auto DT_S              = read_tensor<int64_t>(file_path + "/dt_softplus_s_layer" + file_path_suffix);
    auto B_Q               = read_tensor<int64_t>(file_path + "/B_q_layer" + file_path_suffix);
    auto B_S               = read_tensor<int64_t>(file_path + "/B_s_layer" + file_path_suffix);
    auto DTB               = read_tensor<int64_t>(file_path + "/dB_layer" + file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t>(DT_Q,    REF_DT_Q,          1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(DT_S,    REF_DT_S,          1, 1, T_LOAD, T, CT,CT);
    tensor2array<int64_t>(B_Q,     REF_B_Q,           1, 1, T_LOAD, T, N, N);
    tensor2array<int64_t>(B_S,     REF_B_S,           1, 1, T_LOAD, T, NT2,NT2);
    tensor2array<int64_t>(DTB,     REF_DTB,           1, 1, T_LOAD, T, C*N, C*N);

    // create streams
    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > dt_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > dt_s_stream;
    hls::stream<hls::vector<A_T,      CP> > B_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > B_s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;

    // Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C, CP>(REF_DT_Q, dt_stream, "DT_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT, 1>(REF_DT_S, dt_s_stream, "DT_S", true);
    array2stream<int64_t, A_T, CT, 1, T, TP, N, NP>(REF_B_Q, B_stream, "B_Q", true);
    array2stream<int64_t, ASCALE_T, CT, 1, T, TP, NT2, 1>(REF_B_S, B_s_stream, "B_S", true);

    // call top function
    top(dt_stream, dt_s_stream, B_stream, B_s_stream, o_stream);

    stream2array<int64_t, X_T, 1, T, TP, C*N,  CP>(o_stream, DUT_DTB, "DTB", true);

    // Verify that streams are empty
    assert(dt_stream.empty());
    assert(dt_s_stream.empty());
    assert(B_stream.empty());
    assert(B_s_stream.empty());
    assert(o_stream.empty());

    // Compare output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_DTB, DUT_DTB, T*C*N, "DTB");
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
        printf("Test %d passed\n", l);
    }
    return 0;
}
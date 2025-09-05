/**
 * @file DAH.cpp
 * @brief Testbench for the Dot-Product Attention Head (DAH) module of the Llama model.
 *

 */
#include "../src/common.h"
#include "../src/dAh.h"

#include <pthread.h>
/** @brief Number of test layers */
constexpr int TEST_L    = 2;

// instanciate the RMSNORM inst
constexpr int T_LOAD    = 512;         // saved seq length, since T is in the inner loop

// actual size
constexpr int T         = 1;
constexpr int TP        = 1;

constexpr int C         = 80;
constexpr int CP        = 8;
constexpr int N         = 128;
constexpr int NP        = 8;
constexpr int P         = 64;
constexpr int PP        = 8;
/** @brief DAH instance for dot-product attention head */
DAH  <T, C, CP, N, NP, P, PP> dAh_inst;
/** @brief Number of channel tiles */
constexpr int CT = dAh_inst.CT;
/** @brief Number of hidden dimension tiles */
constexpr int NT2 = dAh_inst.NT2;
/** @brief Number of projection tiles */
constexpr int PT = dAh_inst.PT;
/**
 * @brief Top-level function for the DAH module test.
 *
 * Executes the DAH operation by processing input streams and producing an output stream.
 * @param dA_stream Input stream of attention data with CP parallelism.
 * @param dA_s_stream Input stream of attention scale data with single element vectors.
 * @param ht_stream Input stream of hidden state data with CP parallelism.
 * @param ht_s_stream Input stream of hidden state scale data with single element vectors.
 * @param o_stream Output stream of computed results with CP parallelism.
 */
void top(
    hls::stream<hls::vector<A_T,      CP> >& dA_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& dA_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& ht_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& ht_s_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=dA_stream
    #pragma HLS interface axis port=dA_s_stream
    #pragma HLS interface axis port=ht_stream
    #pragma HLS interface axis port=ht_s_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=dA_stream compact=bit
    #pragma HLS aggregate variable=dA_s_stream compact=bit
    #pragma HLS aggregate variable=ht_stream compact=bit
    #pragma HLS aggregate variable=ht_s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow
 // Execute the DAH operation
    dAh_inst  .do_dAh   (dA_stream, dA_s_stream,  ht_stream, ht_s_stream,  o_stream );
}

// Reference and DUT data declarations
int64_t  REF_DA_Q               [T*C ];
int64_t  REF_DA_S               [T*CT];
int64_t  REF_HT_Q                [T*C*P*N];
int64_t  REF_HT_S                [T*C*PT*N];
int64_t  REF_DAH                [T*C*P*N];
int64_t  DUT_DAH                [T*C*P*N];

/**
 * @brief Test function for a single DAH layer.
 *
 * Loads reference data, creates input streams, runs the DAH operation, and compares outputs.
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    // Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Read input reference tensors
    auto DA_Q              = read_tensor<int64_t>(file_path + "/dA_exp_q_layer" + file_path_suffix);
    auto DA_S              = read_tensor<int64_t>(file_path + "/dA_exp_s_layer" + file_path_suffix);
    auto HT_Q               = read_tensor<int64_t>(file_path + "/ht1_q0_layer" + file_path_suffix);
    auto HT_S               = read_tensor<int64_t>(file_path + "/ht1_s0_layer" + file_path_suffix);
    auto DAH               = read_tensor<int64_t>(file_path + "/dAh1_layer" + file_path_suffix);

    // tensor2array<int64_t>(DA_Q,    REF_DA_Q,      1, 1, T_LOAD, T, C, C);
    // tensor2array<int64_t>(DA_S,    REF_DA_S,      1, 1, T_LOAD, T, CT,CT);
    // Populate reference arrays
    for(int t=0; t<T; ++t){
        for(int c=0; c<C; ++c){
            REF_DA_Q[t*C + c] = DA_Q[1*C + c];
        }
    }
    for(int t=0; t<T; ++t){
        for(int c=0; c<CT; ++c){
            REF_DA_S[t*CT + c] = DA_S[1*CT + c];
        }
    }
    tensor2array<int64_t>(HT_Q,     REF_HT_Q,       1, 1, T, T, C*P*N, C*P*N);
    tensor2array<int64_t>(HT_S,     REF_HT_S,       1, 1, T, T, C*PT*N,C*PT*N);
    tensor2array<int64_t>(DAH,     REF_DAH,       1, 1, T, T, C*P*N, C*P*N);

    // create streams
    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > dA_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > dA_s_stream;
    hls::stream<hls::vector<A_T,      CP> > ht_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > ht_s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;

         // Populate input streams with reference data
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C, CP>(REF_DA_Q, dA_stream, "DA_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT, 1>(REF_DA_S, dA_s_stream, "DA_S", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C*P*N, PP>(REF_HT_Q, ht_stream, "HT_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, C*PT*N, 1>(REF_HT_S, ht_s_stream, "HT_S", true);

    // call top function
    // Execute the DAH operation
    top(dA_stream, dA_s_stream, ht_stream, ht_s_stream, o_stream);
// Read output stream into array
    stream2array<int64_t, X_T, 1, T, TP, C*N*P,  PP>(o_stream, DUT_DAH, "DAH", true);
 // Verify that streams are empty
    assert(dA_stream.empty());
    assert(dA_s_stream.empty());
    assert(ht_stream.empty());
    assert(ht_s_stream.empty());
    assert(o_stream.empty());

    // Compare DAH output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_DAH, DUT_DAH, T*C*N*P, "DAH");
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
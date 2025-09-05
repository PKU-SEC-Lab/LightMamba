/**
 * This module tests the HTC operation by loading reference data, creating input streams, executing the HTC operation,
 * and comparing the output against reference data. The implementation is optimized for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/htC.h"

#include <pthread.h>

/** @brief Number of test layers */
constexpr int TEST_L    = 2;

// instanciate the RMSNORM inst
/** @brief Saved sequence length for loading */
constexpr int T_LOAD    = 512;         // saved seq length, since T is in the inner loop

// actual size
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
/** @brief Projection dimension size */
constexpr int P = 64;
/** @brief Projection parallelism */
constexpr int PP = 8;

// Instantiation of HTC class with specified template parameters.
HTC  <T, C, CP, N, NP, P, PP> htC_inst;

/** @brief Number of channel tiles */
constexpr int CT = htC_inst.CT;
/** @brief Number of hidden dimension tiles */
constexpr int NT2 = htC_inst.NT2;
/** @brief Number of projection tiles */
constexpr int PT = htC_inst.PT;

/**
 * @brief Top-level function for processing HTC operations.
 *
 * This function orchestrates the dataflow for the HTC instance, processing input streams
 * and producing an output stream.
 *
 * @param ht_stream Input stream of vectors of type A_T with CP elements.
 * @param ht_s_stream Input stream of scaling factors (ASCALE_T, single element).
 * @param C_stream Input stream of vectors of type A_T with CP elements for multiplication.
 * @param C_s_stream Input stream of scaling factors (ASCALE_T, single element) for multiplication.
 * @param uD_stream Input stream of vectors of type X_T with CP elements for addition.
 * @param o_stream Output stream of vectors of type X_T with CP elements.
 */
void top(
    hls::stream<hls::vector<A_T,      CP> >& ht_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& ht_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& C_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& C_s_stream,
    hls::stream<hls::vector<X_T,      CP> >& uD_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=ht_stream
    #pragma HLS interface axis port=ht_s_stream
    #pragma HLS interface axis port=C_stream
    #pragma HLS interface axis port=C_s_stream
    #pragma HLS interface axis port=uD_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=ht_stream compact=bit
    #pragma HLS aggregate variable=ht_s_stream compact=bit
    #pragma HLS aggregate variable=C_stream compact=bit
    #pragma HLS aggregate variable=C_s_stream compact=bit
    #pragma HLS interface axis port=uD_stream
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow
     // Execute HTC operation
    htC_inst.do_htC(ht_stream, ht_s_stream,  C_stream, C_s_stream, uD_stream, o_stream );
}

// Reference and DUT data declarations
int64_t  REF_HT_Q               [T*C*N*P ];
int64_t  REF_HT_S               [T*C*NT2*P];
int64_t  REF_C_Q                [T*N     ];
int64_t  REF_C_S                [T*NT2    ];
int64_t  REF_UD                 [T*C*P   ];
int64_t  REF_Y                  [T*C*P   ];
int64_t  DUT_Y                  [T*C*P   ];

/**
 * @brief Test function for a single HTC layer.
 *
 * Loads reference data, creates input streams, runs the HTC operation, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    //// Read reference data
    auto HT_Q              = read_tensor<int64_t>(file_path + "/ht2_q0_layer" + file_path_suffix);
    auto HT_S              = read_tensor<int64_t>(file_path + "/ht2_s0_layer" + file_path_suffix);
    auto C_Q               = read_tensor<int64_t>(file_path + "/C_q_layer" + file_path_suffix);
    auto C_S               = read_tensor<int64_t>(file_path + "/C_s_layer" + file_path_suffix);
    auto UD                = read_tensor<int64_t>(file_path + "/uD_layer" + file_path_suffix);
    auto Y                 = read_tensor<int64_t>(file_path + "/y_layer" + file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t>(HT_Q,    REF_HT_Q,      1, 1, T, T, C*N*P, C*N*P);
    tensor2array<int64_t>(HT_S,    REF_HT_S,      1, 1, T, T, C*NT2*P,C*NT2*P);
    tensor2array<int64_t>(C_Q,     REF_C_Q,       1, 1, T_LOAD, T, N, N);
    tensor2array<int64_t>(C_S,     REF_C_S,       1, 1, T_LOAD, T, NT2,NT2);
    tensor2array<int64_t>(UD,      REF_UD,        1, 1, T_LOAD, T, C*P,C*P);
    tensor2array<int64_t>(Y,       REF_Y,         1, 1, T_LOAD, T, C*P, C*P);
    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > ht_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > ht_s_stream;
    hls::stream<hls::vector<A_T,      CP> > C_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > C_s_stream;
    hls::stream<hls::vector<X_T,      CP> > uD_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;

    //  Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C*N*P, NP>(REF_HT_Q, ht_stream, "HT_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, C*NT2*P, 1>(REF_HT_S, ht_s_stream, "HT_S", true);
    array2stream<int64_t, A_T, C*PT, 1, T, TP, N, NP>(REF_C_Q, C_stream, "C_Q", true);
    array2stream<int64_t, ASCALE_T, C*PT, 1, T, TP, NT2, 1>(REF_C_S, C_s_stream, "C_S", true);
    array2stream<int64_t, X_T, 1, 1, T, TP, C*P, PP>(REF_UD, uD_stream, "UD", true);


    // call top function
    top(ht_stream, ht_s_stream, C_stream, C_s_stream, uD_stream, o_stream);
// Read output stream into array
    stream2array<int64_t, X_T, 1, T, TP, C*P,  PP>(o_stream, DUT_Y, "Y", true);

    // Verify that streams are empty
    assert(ht_stream.empty());
    assert(ht_s_stream.empty());
    assert(C_stream.empty());
    assert(C_s_stream.empty());
    assert(uD_stream.empty());
    assert(o_stream.empty());

    // Compare output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_Y, DUT_Y, T*C*P, "Y");
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
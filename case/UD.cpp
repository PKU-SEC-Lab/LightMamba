/**
 * This module tests the UD operation by loading reference data, creating input streams, executing the UD operation,
 * and comparing the output against reference data. The implementation is optimized for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/uD.h"

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
/** @brief Projection dimension size */
constexpr int P = 64;
/** @brief Projection parallelism */
constexpr int PP = 8;

/** @brief Instance of the UD class with specified template parameters, initialized with DQ and DS weights */
UD<64, T, C, CP, P, PP> uD_inst(DQ, DS);

/** @brief Number of channel tiles */
constexpr int CT = uD_inst.CT;
/** @brief Number of projection tiles */
constexpr int PT = uD_inst.PT;

/**
 * @brief Top-level function for the UD test module.
 *
 * Executes the UD operation to perform matrix multiplication and scaling for a specific layer.
 *
 * @param l Layer index to process.
 * @param i_stream Input stream of data with CP parallelism.
 * @param s_stream Input stream of scale data with single element vectors.
 * @param o_stream Output stream of computed results with CP parallelism.
 */
void top(
    int l, 
    hls::stream<hls::vector<A_T,      CP> >& i_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=s_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow
// Execute UD operation
    uD_inst  .do_uD   (l, i_stream,   s_stream,  o_stream );
}

// Reference and DUT data declarations
int64_t  REF_U_Q               [T*C*P ];
int64_t  REF_U_S               [T*C*PT];
int64_t  REF_UD                [T*C*P ];
int64_t  DUT_UD                [T*C*P ];

/**
 * @brief Test function for a single UD layer.
 *
 * Loads reference data, creates input streams, runs the UD operation, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
     // Read reference data
    auto U_Q              = read_tensor<int64_t>(file_path + "/u_q_layer" + file_path_suffix);
    auto U_S              = read_tensor<int64_t>(file_path + "/u_s_layer" + file_path_suffix);
    auto UD               = read_tensor<int64_t>(file_path + "/uD_layer" + file_path_suffix);
// Convert tensors to arrays
    tensor2array<int64_t>(U_Q,    REF_U_Q,          1, 1, T_LOAD, T, C*P, C*P);
    tensor2array<int64_t>(U_S,    REF_U_S,          1, 1, T_LOAD, T, C*PT,C*PT);
    tensor2array<int64_t>(UD,     REF_UD,           1, 1, T_LOAD, T, C*P, C*P);

    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > i_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;

     // Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C*P, PP>(REF_U_Q, i_stream, "U_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, C*PT, 1>(REF_U_S, s_stream, "U_S", true);

    // call top function
    top(l, i_stream, s_stream, o_stream);
// Read output stream into array
    stream2array<int64_t, X_T, 1, T, TP, C*P,  PP>(o_stream, DUT_UD, "UD", true);

    // Verify that streams are empty
    assert(i_stream.empty());
    assert(s_stream.empty());
    assert(o_stream.empty());

    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    // Compare output with reference
    compare<int64_t>(REF_UD, DUT_UD, T*C*P, "UD");
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
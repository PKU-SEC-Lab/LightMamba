
/**
 * @file DBU.cpp
 * @brief Testbench for the DBU (Dot-Product and Multiplication) module in the Llama model.
 *
 * This module tests the DBU operation by loading reference data, creating input streams,
 * executing the DBU operation, and comparing the output against reference data. The
 * implementation is optimized for HLS with dataflow and stream interfaces.
 */#include "../src/common.h"
#include "../src/dBu_divide.h"

#include <pthread.h>
/** @brief Number of test layers */
constexpr int TEST_L    = 2;

// instanciate the RMSNORM inst
constexpr int T_LOAD    = 512;         // saved seq length, since T is in the inner loop

// actual size
constexpr int T         = 1;
constexpr int TP        = 1;

/** @brief Channel dimension size */
constexpr int C         = 80;
/** @brief Channel parallelism */
constexpr int CP        = 8;
/** @brief Hidden dimension size */
constexpr int N         = 128;
/** @brief Hidden dimension parallelism */
constexpr int NP        = 8;
/** @brief Projection dimension size */
constexpr int P         = 64;
/** @brief Projection parallelism */
constexpr int PP        = 8;
/** @brief Instance of the DBU class with specified template parameters */
DBU  <T, C, CP, N, NP, P, PP> dBu_inst;

/** @brief Number of channel tiles */
constexpr int CT = dBu_inst.CT;
/** @brief Number of hidden dimension tiles */
constexpr int NT2 = dBu_inst.NT2;
/** @brief Number of projection tiles */
constexpr int PT = dBu_inst.PT;
/**
 * @brief Top-level function for the DBU test module.
 *
 * Executes the DBU operation using the instantiated DBU instance, processing input streams
 * and producing an output stream.
 *
 * @param dB_stream Input stream of data with CP parallelism.
 * @param dB_s_stream Input stream of scale data with single element vectors.
 * @param u_stream Input stream of data with CP parallelism.
 * @param u_s_stream Input stream of scale data with single element vectors.
 * @param o_stream Output stream of computed results with CP parallelism.
 */

void top(
    hls::stream<hls::vector<A_T,      CP> >& dB_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& dB_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& u_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& u_s_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=dB_stream
    #pragma HLS interface axis port=dB_s_stream
    #pragma HLS interface axis port=u_stream
    #pragma HLS interface axis port=u_s_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=dB_stream compact=bit
    #pragma HLS aggregate variable=dB_s_stream compact=bit
    #pragma HLS aggregate variable=u_stream compact=bit
    #pragma HLS aggregate variable=u_s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow
    // Execute the DBU operation
    dBu_inst  .do_dBu   (dB_stream, dB_s_stream,  u_stream, u_s_stream,  o_stream );
}

// Reference and DUT data declarations
int64_t  REF_DB_Q               [T*C*N ];
int64_t  REF_DB_S               [T*CT*N];
int64_t  REF_U_Q                [T*C*P ];
int64_t  REF_U_S                [T*C*PT];
int64_t  REF_DBU                [T*C*P*N];
int64_t  DUT_DBU                [T*C*P*N];

/**
 * @brief Test function for a single DBU layer.
 *
 * Loads reference data, creates input streams, runs the DBU operation, and compares outputs
 * against reference data.
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
    auto DB_Q              = read_tensor<int64_t>(file_path + "/dB_q_layer" + file_path_suffix);
    auto DB_S              = read_tensor<int64_t>(file_path + "/dB_s_layer" + file_path_suffix);
    auto U_Q               = read_tensor<int64_t>(file_path + "/u_q_layer" + file_path_suffix);
    auto U_S               = read_tensor<int64_t>(file_path + "/u_s_layer" + file_path_suffix);
    auto DBU               = read_tensor<int64_t>(file_path + "/dBu0_layer" + file_path_suffix);
// Convert tensors to arrays
    tensor2array<int64_t>(DB_Q,    REF_DB_Q,      1, 1, T_LOAD, T, C*N, C*N);
    tensor2array<int64_t>(DB_S,    REF_DB_S,      1, 1, T_LOAD, T, CT*N,CT*N);
    tensor2array<int64_t>(U_Q,     REF_U_Q,       1, 1, T_LOAD, T, C*P, C*P);
    tensor2array<int64_t>(U_S,     REF_U_S,       1, 1, T_LOAD, T, C*PT,C*PT);
    tensor2array<int64_t>(DBU,     REF_DBU,       1, 1, T, T, C*P*N, C*P*N);

    // create streams
     // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > dB_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > dB_s_stream;
    hls::stream<hls::vector<A_T,      CP> > u_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > u_s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;
// Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C*N, CP>(REF_DB_Q, dB_stream, "DB_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT*N, 1>(REF_DB_S, dB_s_stream, "DB_S", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C*P, PP>(REF_U_Q, u_stream, "U_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, C*PT, 1>(REF_U_S, u_s_stream, "U_S", true);

    // call top function
    // Execute the top function
    top(dB_stream, dB_s_stream, u_stream, u_s_stream, o_stream);
// Read output stream into array
    stream2array<int64_t, X_T, 1, T, TP, C*N*P,  PP>(o_stream, DUT_DBU, "DBU", true);
 // Verify that streams are empty
    assert(dB_stream.empty());
    assert(dB_s_stream.empty());
    assert(u_stream.empty());
    assert(u_s_stream.empty());
    assert(o_stream.empty());
 // Compare output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_DBU, DUT_DBU, T*C*N*P, "DBU");
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
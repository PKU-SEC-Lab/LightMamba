/**
 *
 * This module tests the YZ operation by loading reference data, creating input streams, executing the YZ operation,
 * and comparing the output against reference data. The implementation is optimized for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/yz.h"

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
constexpr int C = 5120;
/** @brief Channel parallelism */
constexpr int CP = 8;

/** @brief Instance of the YZ class with specified template parameters */
YZ<T, C, CP> yz_inst;

/** @brief Number of channel tiles */
constexpr int CT = yz_inst.CT;

/**
 * @brief Top-level function for the YZ test module.
 *
 * Executes the YZ operation to perform element-wise multiplication and scaling of input streams.
 *
 * @param y_stream Input stream of y data with CP parallelism.
 * @param y_s_stream Input stream of y scale data with single element vectors.
 * @param z_stream Input stream of z data with CP parallelism.
 * @param z_s_stream Input stream of z scale data with single element vectors.
 * @param o_stream Output stream of computed results with CP parallelism.
 */
void top(
    hls::stream<hls::vector<A_T,      CP> >& y_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& y_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& z_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& z_s_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=y_stream
    #pragma HLS interface axis port=y_s_stream
    #pragma HLS interface axis port=z_stream
    #pragma HLS interface axis port=z_s_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=y_stream compact=bit
    #pragma HLS aggregate variable=y_s_stream compact=bit
    #pragma HLS aggregate variable=z_stream compact=bit
    #pragma HLS aggregate variable=z_s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow
// Execute YZ operation
    yz_inst  .do_yz   (y_stream, y_s_stream,  z_stream, z_s_stream,  o_stream );
}

// Reference and DUT data declarations
int64_t  REF_Y_Q               [T*C ];
int64_t  REF_Y_S               [T*CT];
int64_t  REF_Z_Q                [T*C ];
int64_t  REF_Z_S                [T*CT];
int64_t  REF_YZ                [T*C ];
int64_t  DUT_YZ                [T*C ];

/**
 * @brief Test function for a single YZ layer.
 *
 * Loads reference data, creates input streams, runs the YZ operation, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // // Read reference data
    auto Y_Q              = read_tensor<int64_t>(file_path + "/y_q_layer" + file_path_suffix);
    auto Y_S              = read_tensor<int64_t>(file_path + "/y_s_layer" + file_path_suffix);
    auto Z_Q               = read_tensor<int64_t>(file_path + "/z_silu_q_layer" + file_path_suffix);
    auto Z_S               = read_tensor<int64_t>(file_path + "/z_silu_s_layer" + file_path_suffix);
    auto YZ               = read_tensor<int64_t>(file_path + "/yz_layer" + file_path_suffix);
// Convert tensors to arrays
    tensor2array<int64_t>(Y_Q,     REF_Y_Q,           1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(Y_S,     REF_Y_S,           1, 1, T_LOAD, T, CT,CT);
    tensor2array<int64_t>(Z_Q,     REF_Z_Q,           1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(Z_S,     REF_Z_S,           1, 1, T_LOAD, T, CT,CT);
    tensor2array<int64_t>(YZ,      REF_YZ,            1, 1, T_LOAD, T, C, C);

    // create streams
    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > y_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > y_s_stream;
    hls::stream<hls::vector<A_T,      CP> > z_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > z_s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;

    // Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C, CP>(REF_Y_Q, y_stream, "Y_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT, 1>(REF_Y_S, y_s_stream, "Y_S", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C, CP>(REF_Z_Q, z_stream, "Z_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT, 1>(REF_Z_S, z_s_stream, "Z_S", true);

    // call top function
    top(y_stream, y_s_stream, z_stream, z_s_stream, o_stream);
// Read output stream into array
    stream2array<int64_t, X_T, 1, T, TP, C,  CP>(o_stream, DUT_YZ, "YZ", true);


    // Verify that streams are empty
    assert(y_stream.empty());
    assert(y_s_stream.empty());
    assert(z_stream.empty());
    assert(z_s_stream.empty());
    assert(o_stream.empty());

    // Compare output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_YZ, DUT_YZ, T*C, "YZ");
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
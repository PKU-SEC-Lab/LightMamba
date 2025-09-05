
#include "../src/common.h"
#include "../src/dtB.h"
#include "../src/quantizer.h"
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

/** @brief Group size for quantization */
constexpr int G = 8;
/** @brief Scale tensor size for quantization */
constexpr int S_T = (C * N) / G;

/** @brief Instance of the DTB class with specified template parameters */
DTB<T, C, CP, N, NP> dtB_inst;
/** @brief Instance of the QUANTIZER class with specified template parameters */
QUANTIZER<X_T, A_T, AS_T, 1, T, TP, C * N, CP, G> quantizer_inst;

/** @brief Number of channel tiles */
constexpr int CT = dtB_inst.CT;
/** @brief Number of hidden dimension tiles */
constexpr int NT2 = dtB_inst.NT2;

/**
 * @brief Top-level function for the DTB and quantization test module.
 *
 * Executes the DTB operation followed by quantization, processing input streams and producing
 * quantized and scale output streams.
 *
 * @param dt_stream Input stream of data with CP parallelism.
 * @param dt_s_stream Input stream of scale data with single element vectors.
 * @param B_stream Input stream of data with CP parallelism.
 * @param B_s_stream Input stream of scale data with single element vectors.
 * @param o_stream Output stream of quantized data with CP parallelism.
 * @param o_s_stream Output stream of scale data with single element vectors.
 */
void top(
    hls::stream<hls::vector<A_T,      CP> >& dt_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& dt_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& B_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& B_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& o_stream,
    hls::stream<hls::vector<ASCALE_T,  1> >& o_s_stream    
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=dt_stream
    #pragma HLS interface axis port=dt_s_stream
    #pragma HLS interface axis port=B_stream
    #pragma HLS interface axis port=B_s_stream
    #pragma HLS interface axis port=o_stream
    #pragma HLS interface axis port=o_s_stream
    #pragma HLS aggregate variable=dt_stream compact=bit
    #pragma HLS aggregate variable=dt_s_stream compact=bit
    #pragma HLS aggregate variable=B_stream compact=bit
    #pragma HLS aggregate variable=B_s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit
    #pragma HLS aggregate variable=o_s_stream compact=bit
    #pragma HLS dataflow
// Declare intermediate stream
    hls::stream<hls::vector<X_T, CP> > temp_stream;
    // Execute DTB operation
    dtB_inst  .do_dtB   (dt_stream, dt_s_stream,  B_stream, B_s_stream,  temp_stream);
    // Execute quantization
    quantizer_inst.do_quant(temp_stream,o_stream,o_s_stream);
}

// Reference and DUT data declarations
int64_t  REF_DT_Q               [T*C ];
int64_t  REF_DT_S               [T*CT];
int64_t  REF_B_Q                [T*N ];
int64_t  REF_B_S                [T*NT2];
int64_t  REF_DTB_Q                [T*C*N ];
int64_t  REF_DTB_S                [T*S_T ];
int64_t  DUT_DTB_Q                [T*C*N ];
int64_t  DUT_DTB_S                [T*S_T ];

/**
 * @brief Test function for a single DTB layer.
 *
 * Loads reference data, creates input streams, runs the DTB and quantization operations,
 * and compares the output against reference data.
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
    auto DTB_Q               = read_tensor<int64_t>(file_path + "/dB_q_layer" + file_path_suffix);
    auto DTB_S               = read_tensor<int64_t>(file_path + "/dB_s_layer" + file_path_suffix);    

     // Convert tensors to arrays
    tensor2array<int64_t>(DT_Q,    REF_DT_Q,          1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(DT_S,    REF_DT_S,          1, 1, T_LOAD, T, CT,CT);
    tensor2array<int64_t>(B_Q,     REF_B_Q,           1, 1, T_LOAD, T, N, N);
    tensor2array<int64_t>(B_S,     REF_B_S,           1, 1, T_LOAD, T, NT2,NT2);
    tensor2array<int64_t>(DTB_Q,     REF_DTB_Q,           1, 1, T_LOAD, T, C*N, C*N);
    tensor2array<int64_t>(DTB_S,     REF_DTB_S,           1, 1, T_LOAD, T, S_T, S_T);

    // create streams
   // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > dt_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > dt_s_stream;
    hls::stream<hls::vector<A_T,      CP> > B_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > B_s_stream;
    hls::stream<hls::vector<A_T,      CP> > o_stream;
    hls::stream<hls::vector<ASCALE_T,  1> > o_s_stream;     

    // Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C, CP>(REF_DT_Q, dt_stream, "DT_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT, 1>(REF_DT_S, dt_s_stream, "DT_S", true);
    array2stream<int64_t, A_T, CT, 1, T, TP, N, NP>(REF_B_Q, B_stream, "B_Q", true);
    array2stream<int64_t, ASCALE_T, CT, 1, T, TP, NT2, 1>(REF_B_S, B_s_stream, "B_S", true);

    // call top function
    // Execute the top function
    top(dt_stream, dt_s_stream, B_stream, B_s_stream, o_stream,o_s_stream);

    // Read output streams into arrays
    stream2array<int64_t, A_T, 1, T, TP, C*N,  CP>(o_stream, DUT_DTB_Q, "DTBq", true);
    stream2array<int64_t, ASCALE_T, 1, T, TP, S_T,  1>(o_s_stream, DUT_DTB_S, "DTBs", true);

     // Verify that streams are empty
    assert(dt_stream.empty());
    assert(dt_s_stream.empty());
    assert(B_stream.empty());
    assert(B_s_stream.empty());
    assert(o_stream.empty());
    assert(o_s_stream.empty());

    // Compare outputs with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_DTB_Q, DUT_DTB_Q, T*C*N, "DTBq");
    compare<int64_t>(REF_DTB_S, DUT_DTB_S, T*S_T, "DTBs");    
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
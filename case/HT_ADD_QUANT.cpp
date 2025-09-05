/**
 * @brief Testbench for the HT_ADD and QUANTIZER modules in the Llama model.
 *
 * This module tests the HT_ADD operation followed by quantization by loading reference data,
 * creating input streams, executing the HT_ADD and QUANTIZER operations, and comparing the output
 * against reference data. The implementation is optimized for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/ht_add.h"
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
/** @brief Projection dimension size */
constexpr int P = 64;
/** @brief Projection parallelism */
constexpr int PP = 8;
/** @brief Group size for quantization */
constexpr int G = 8;

/** @brief Instance of the HT_ADD class with specified template parameters */
HT_ADD<T, C, CP, N, NP, P, PP> ht_add_inst;
/** @brief Instance of the QUANTIZER class for ht1 stream */
QUANTIZER<X_T, A_T, AS_T, 1, T, TP, C * P * N, CP, G> quantizer_inst1;
/** @brief Instance of the QUANTIZER class for ht2 stream */
QUANTIZER<X_T, A_T, AS_T, 1, T, TP, C * P * N, CP, G> quantizer_inst2;

/** @brief Number of channel tiles */
constexpr int CT = ht_add_inst.CT;
/** @brief Number of hidden dimension tiles */
constexpr int NT2 = ht_add_inst.NT2;
/** @brief Number of projection tiles */
constexpr int PT = ht_add_inst.PT;

/**
 * @brief Top-level function for the HT_ADD and QUANTIZER test module.
 *
 * Executes the HT_ADD operation to add and split input streams, followed by quantization of the resulting streams.
 *
 * @param dAh_stream Input stream of dAh data with CP parallelism.
 * @param dBu_stream Input stream of dBu data with CP parallelism.
 * @param ht1_q_stream Output stream of quantized ht1 data with CP parallelism.
 * @param ht1_s_stream Output stream of ht1 scale data with single element vectors.
 * @param ht2_q_stream Output stream of quantized ht2 data with CP parallelism.
 * @param ht2_s_stream Output stream of ht2 scale data with single element vectors.
 */
void top(
    hls::stream<hls::vector<X_T,CP> >& dAh_stream,
    hls::stream<hls::vector<X_T,CP> >& dBu_stream,
    hls::stream<hls::vector<A_T,CP> >& ht1_q_stream,
    hls::stream<hls::vector<AS_T,1> >& ht1_s_stream,
    hls::stream<hls::vector<A_T,CP> >& ht2_q_stream,
    hls::stream<hls::vector<AS_T,1> >& ht2_s_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=dAh_stream
    #pragma HLS interface axis port=dBu_stream
    #pragma HLS interface axis port=ht1_q_stream
    #pragma HLS interface axis port=ht1_s_stream    
    #pragma HLS interface axis port=ht2_q_stream
    #pragma HLS interface axis port=ht2_s_stream

    #pragma HLS aggregate variable=dAh_stream compact=bit
    #pragma HLS aggregate variable=dBu_stream compact=bit
    #pragma HLS aggregate variable=ht1_q_stream compact=bit
    #pragma HLS aggregate variable=ht1_s_stream compact=bit
    #pragma HLS aggregate variable=ht2_q_stream compact=bit
    #pragma HLS aggregate variable=ht2_s_stream compact=bit
    #pragma HLS dataflow

    hls::stream<hls::vector<X_T, TP * CP> > ht1_stream;
    hls::stream<hls::vector<X_T, TP * CP> > ht2_stream;

    #pragma HLS stream variable=ht1_stream depth=32
    #pragma HLS stream variable=ht2_stream depth=32

    // Execute HT_ADD and QUANTIZER operations
    ht_add_inst  .do_ht_add   (dAh_stream, dBu_stream,  ht1_stream, ht2_stream);
    quantizer_inst1. do_quant(ht1_stream,ht1_q_stream,ht1_s_stream);
    quantizer_inst2. do_quant(ht2_stream,ht2_q_stream,ht2_s_stream);    
}

// Reference and DUT data declarations
int64_t  REF_DAH               [T*C*N*P];
int64_t  REF_DBU               [T*C*N*P];

int64_t  REF_HT1_Q                [T*C*P*N];
int64_t  REF_HT1_S                [T*C*P*N/G];
int64_t  DUT_HT1_Q                [T*C*P*N];
int64_t  DUT_HT1_S                [T*C*P*N/G];

int64_t  REF_HT2_Q                [T*C*P*N];
int64_t  REF_HT2_S                [T*C*P*N/G];
int64_t  DUT_HT2_Q                [T*C*P*N];
int64_t  DUT_HT2_S                [T*C*P*N/G];

/**
 * @brief Test function for a single HT_ADD and QUANTIZER layer.
 *
 * Loads reference data, creates input streams, runs the HT_ADD and QUANTIZER operations,
 * and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    //// Read reference data
    auto DAH              = read_tensor<int64_t>(file_path + "/dAh1_layer" + file_path_suffix);
    auto DBU              = read_tensor<int64_t>(file_path + "/dBu1_layer" + file_path_suffix);
    auto HT1_Q               = read_tensor<int64_t>(file_path + "/ht1_q1_layer" + file_path_suffix);
    auto HT1_S               = read_tensor<int64_t>(file_path + "/ht1_s1_layer" + file_path_suffix);
    auto HT2_Q               = read_tensor<int64_t>(file_path + "/ht2_q1_layer" + file_path_suffix);
    auto HT2_S               = read_tensor<int64_t>(file_path + "/ht2_s1_layer" + file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t>(DAH,     REF_DAH,       1, 1, T, T, C*P*N, C*P*N);
    tensor2array<int64_t>(DBU,     REF_DBU,       1, 1, T, T, C*P*N, C*P*N);
    tensor2array<int64_t>(HT1_Q,     REF_HT1_Q,       1, 1, T, T, C*P*N, C*P*N);
    tensor2array<int64_t>(HT1_S,     REF_HT1_S,       1, 1, T, T, C*P*N/G, C*P*N/G);
    tensor2array<int64_t>(HT2_Q,     REF_HT2_Q,       1, 1, T, T, C*P*N, C*P*N);
    tensor2array<int64_t>(HT2_S,     REF_HT2_S,       1, 1, T, T, C*P*N/G, C*P*N/G);
    //  // Create input and output streams
    hls::stream<hls::vector<X_T,      CP> > dAh_stream;
    hls::stream<hls::vector<X_T,      CP> > dBu_stream;
    hls::stream<hls::vector<A_T,      CP> > ht1_q_stream;
    hls::stream<hls::vector<AS_T,      1> > ht1_s_stream;   
    hls::stream<hls::vector<A_T,      CP> > ht2_q_stream;
    hls::stream<hls::vector<AS_T,      1> > ht2_s_stream;
    // Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, X_T, 1, 1, T, TP, C*N*P, PP>(REF_DAH, dAh_stream, "DAH", true);
    array2stream<int64_t, X_T, 1, 1, T, TP, C*N*P, PP>(REF_DBU, dBu_stream, "DBU", true);

    // call top function
    top(dAh_stream, dBu_stream, ht1_q_stream, ht1_s_stream, ht2_q_stream, ht2_s_stream);

    stream2array<int64_t, A_T, 1, T, TP, C*N*P,  PP>(ht1_q_stream, DUT_HT1_Q, "HT1Q", true);
    stream2array<int64_t, A_T, 1, T, TP, C*N*P,  PP>(ht2_q_stream, DUT_HT2_Q, "HT2Q", true);
    stream2array<int64_t, AS_T, 1, T, TP, C*N*P/G,  1>(ht1_s_stream, DUT_HT1_S, "HT1S", true);
    stream2array<int64_t, AS_T, 1, T, TP, C*N*P/G,  1>(ht2_s_stream, DUT_HT2_S, "HT2S", true);


// Verify that streams are empty
    assert(dAh_stream.empty());
    assert(dBu_stream.empty());
    assert(ht1_q_stream.empty());
    assert(ht2_q_stream.empty());

     // Compare outputs with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_HT1_Q, DUT_HT1_Q, T*C*N*P, "HT1Q");
    compare<int64_t>(REF_HT2_Q, DUT_HT2_Q, T*C*N*P, "HT2Q");
    compare<int64_t>(REF_HT1_S, DUT_HT1_S, T*C*N*P/G, "HT1S");
    compare<int64_t>(REF_HT2_S, DUT_HT2_S, T*C*N*P/G, "HT2S");
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
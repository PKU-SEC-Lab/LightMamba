
/**

 * This file contains the implementation of a test framework for the HTC and Quantizer classes,
 * including data loading, stream processing, and result verification for a specified number of layers.
 */
#include "../src/common.h"
#include "../src/htC.h"
#include "../src/quantizer.h"

#include <pthread.h>
/**
 * @brief Number of test layers to process.
 */
constexpr int TEST_L    = 2;
/**
 * @brief Saved sequence length for RMSNORM instantiation.
 */
// instanciate the RMSNORM inst
constexpr int T_LOAD    = 512;         // saved seq length, since T is in the inner loop

// actual size
constexpr int T         = 1;
constexpr int TP        = 1;

// Number of channels.
constexpr int C         = 80;
constexpr int CP        = 8;

// Total number of iterations.
constexpr int N         = 128;

// Number of iterations per processing element.
constexpr int NP        = 8;

// Number of parallel processing elements.
constexpr int P         = 64;

// Number of parallel processing elements per channel.
constexpr int PP        = 8;

//Number of groups for quantization.
constexpr int G        = 8;



//Instantiation of HTC class with specified template parameters.
HTC<T, C, CP, N, NP, P, PP> htC_inst;

//Instantiation of Quantizer class with specified template parameters.
QUANTIZER<X_T, A_T, AS_T, 1, T, TP, C*P, CP, G> quantizer_inst;


//Number of channels per processing element (C/CP).
constexpr int CT = htC_inst.CT;

// Number of iterations per processing element (N/NP).
constexpr int NT2 = htC_inst.NT2;

 //Number of parallel processing elements (P/PP).
constexpr int PT = htC_inst.PT;


/**
 * @brief Top-level function for processing HTC and quantization operations.
 *
 * This function orchestrates the dataflow between the HTC and Quantizer instances,
 * processing input streams and producing quantized output streams.
 *
 * @param ht_stream Input stream of vectors of type A_T with CP elements.
 * @param ht_s_stream Input stream of scaling factors (ASCALE_T, single element).
 * @param C_stream Input stream of vectors of type A_T with CP elements for multiplication.
 * @param C_s_stream Input stream of scaling factors (ASCALE_T, single element) for multiplication.
 * @param uD_stream Input stream of vectors of type X_T with CP elements for addition.
 * @param o_q_stream Output stream of quantized vectors of type A_T with CP elements.
 * @param o_s_stream Output stream of scaling factors (AS_T, single element).
 */
void top(
    hls::stream<hls::vector<A_T,      CP> >& ht_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& ht_s_stream,
    hls::stream<hls::vector<A_T,      CP> >& C_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& C_s_stream,
    hls::stream<hls::vector<X_T,      CP> >& uD_stream,
    hls::stream<hls::vector<A_T,      CP> >& o_q_stream,
    hls::stream<hls::vector<AS_T,      1> >& o_s_stream  
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=ht_stream
    #pragma HLS interface axis port=ht_s_stream
    #pragma HLS interface axis port=C_stream
    #pragma HLS interface axis port=C_s_stream
    #pragma HLS interface axis port=uD_stream
    #pragma HLS interface axis port=o_q_stream
    #pragma HLS interface axis port=o_s_stream    

    #pragma HLS aggregate variable=ht_stream compact=bit
    #pragma HLS aggregate variable=ht_s_stream compact=bit
    #pragma HLS aggregate variable=C_stream compact=bit
    #pragma HLS aggregate variable=C_s_stream compact=bit
    #pragma HLS interface axis port=uD_stream
    #pragma HLS aggregate variable=o_q_stream compact=bit
    #pragma HLS aggregate variable=o_s_stream compact=bit   

    #pragma HLS dataflow
    // Temporary stream for intermediate results between HTC and Quantizer.
    hls::stream<hls::vector<X_T, CP> > temp_stream;
    htC_inst.do_htC(ht_stream, ht_s_stream,  C_stream, C_s_stream, uD_stream, temp_stream );
    quantizer_inst.do_quant(temp_stream, o_q_stream, o_s_stream);

}

// Reference and DUT data declarations
int64_t  REF_HT_Q               [T*C*N*P ];
int64_t  REF_HT_S               [T*C*NT2*P];
int64_t  REF_C_Q                [T*N     ];
int64_t  REF_C_S                [T*NT2    ];
int64_t  REF_UD                 [T*C*P   ];

int64_t  REF_Y_Q                  [T*C*P   ];
int64_t  REF_Y_S                  [T*C*P/G   ];
int64_t  DUT_Y_Q                  [T*C*P   ];
int64_t  DUT_Y_S                  [T*C*P/G   ];

/**
 * @brief Tests the HTC and Quantizer functionality for a specified layer.
 *
 * Loads reference data from binary files, converts it to streams, processes it through
 * the top function, and compares the output with reference data.
 *
 * @param l The layer index to test (decoder order).
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    // Base file path for reference data
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Read reference tensors from binary files
    auto HT_Q              = read_tensor<int64_t>(file_path + "/ht2_q0_layer" + file_path_suffix);
    auto HT_S              = read_tensor<int64_t>(file_path + "/ht2_s0_layer" + file_path_suffix);
    auto C_Q               = read_tensor<int64_t>(file_path + "/C_q_layer" + file_path_suffix);
    auto C_S               = read_tensor<int64_t>(file_path + "/C_s_layer" + file_path_suffix);
    auto UD                = read_tensor<int64_t>(file_path + "/uD_layer" + file_path_suffix);
    auto Y_Q                 = read_tensor<int64_t>(file_path + "/y_q_layer" + file_path_suffix);
    auto Y_S                 = read_tensor<int64_t>(file_path + "/y_s_layer" + file_path_suffix);

     // Convert tensors to arrays
    tensor2array<int64_t>(HT_Q,    REF_HT_Q,      1, 1, T, T, C*N*P, C*N*P);
    tensor2array<int64_t>(HT_S,    REF_HT_S,      1, 1, T, T, C*NT2*P,C*NT2*P);
    tensor2array<int64_t>(C_Q,     REF_C_Q,       1, 1, T_LOAD, T, N, N);
    tensor2array<int64_t>(C_S,     REF_C_S,       1, 1, T_LOAD, T, NT2,NT2);
    tensor2array<int64_t>(UD,      REF_UD,        1, 1, T_LOAD, T, C*P,C*P);
    tensor2array<int64_t>(Y_Q,       REF_Y_Q,         1, 1, T_LOAD, T, C*P, C*P);
    tensor2array<int64_t>(Y_S,       REF_Y_S,         1, 1, T_LOAD, T, C*P/G, C*P/G);    
    // create streams
   
    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > ht_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > ht_s_stream;
    hls::stream<hls::vector<A_T,      CP> > C_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > C_s_stream;
    hls::stream<hls::vector<X_T,      CP> > uD_stream;
    hls::stream<hls::vector<A_T,      CP> > o_q_stream;
    hls::stream<hls::vector<AS_T,      1> > o_s_stream;

     // Convert arrays to streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C*N*P, NP>(REF_HT_Q, ht_stream, "HT_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, C*NT2*P, 1>(REF_HT_S, ht_s_stream, "HT_S", true);
    array2stream<int64_t, A_T, C*PT, 1, T, TP, N, NP>(REF_C_Q, C_stream, "C_Q", true);
    array2stream<int64_t, ASCALE_T, C*PT, 1, T, TP, NT2, 1>(REF_C_S, C_s_stream, "C_S", true);
    array2stream<int64_t, X_T, 1, 1, T, TP, C*P, PP>(REF_UD, uD_stream, "UD", true);


    // call top function
    top(ht_stream, ht_s_stream, C_stream, C_s_stream, uD_stream, o_q_stream, o_s_stream);

    // Convert output streams to arrays
    stream2array<int64_t, A_T, 1, T, TP, C*P,  PP>(o_q_stream, DUT_Y_Q, "Y_Q", true);
    stream2array<int64_t, AS_T, 1, T, TP, C*P/G,  1>(o_s_stream, DUT_Y_S, "Y_S", true);

     // Verify streams are empty
    assert(ht_stream.empty());
    assert(ht_s_stream.empty());
    assert(C_stream.empty());
    assert(C_s_stream.empty());
    assert(uD_stream.empty());
    assert(o_q_stream.empty());
    assert(o_s_stream.empty());

     // Compare output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_Y_Q, DUT_Y_Q, T*C*P, "Y");
    compare<int64_t>(REF_Y_S, DUT_Y_S, T*C*P/G, "Y"); 
}


/**
 * @brief Main function to run tests for multiple layers.
 *
 * Iterates through the specified number of layers, calling test_layer for each,
 * and prints the test status.
 *
 * @return Returns 0 on successful completion.
 */
int main(){
    for(int l=0; l<TEST_L; ++l){
        test_layer(l);
        printf("Test %d passed\n", l);
    }
    return 0;
}
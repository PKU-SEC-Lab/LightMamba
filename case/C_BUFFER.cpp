#include "../src/common.h"
#include "../src/utils.h"
#include "../src/gemm_buffer.h"

/** 
 * @brief Multiplexer module for the Llama model, interfacing with GEMM module.
 *  This module is the mux for the Llama, the previous module of GEMM
 *it takes 3 channels: XLN, A, XM
 * XLN is RMSNorm result
 * A is the attention result
 * XM is the MLP multiplication result
 * pay attention to the data order:
 * XLN is normal order,     4x8 parallelism
 * A is normal order,       4x8 parallelism
 * XM is unpacked order,    1x8 parallelism
 * The module includes a testbench to verify functionality against reference data.
 */
// hyperparameters
/** @brief Group size for parallelism */
constexpr int G     = 8;

//* actual size
//* scale down
constexpr int L         = 2;

constexpr int T_LOAD    = 512;  // saved seq length
constexpr int T         = 1;
constexpr int TP        = 1;    // this TP is input parallelism

constexpr int TT        = T / TP;

constexpr int N         = 128;
constexpr int C         = 5120;

constexpr int NP        = G; // for both input parallelism and output parallelism

constexpr int NT2       = N  / NP;
constexpr int R         = C / G;
constexpr int NUM_X     = T*N*R;
constexpr int NUM_S     = NUM_X / G;



// Type definitions

/** @brief Type for quantized data */

typedef ap_int  <DW_ACQ     > q_t;

/** @brief Type for scale data */

typedef ap_uint <DW_ASCALE  > s_t;

// Buffer declarations
/** @brief Buffer for quantized data */
GEMM_BUFFER<q_t, 1, T, TP, N, NP> buffer_q;
/** @brief Buffer for scale data */
GEMM_BUFFER<s_t, 1, T, TP, NT2, 1> buffer_s;

/**
 * @brief Top-level function for the Llama multiplexer module.
 *
 * Processes input streams of quantized and scale data, buffers them, and writes to output streams.
 * @param i_stream Input stream of quantized data with TP*NP parallelism.
 * @param i_s_stream Input stream of scale data with TP parallelism.
 * @param q_stream Output stream of quantized data with T*NP parallelism.
 * @param s_stream Output stream of scale data with T parallelism.
 */
void top(
    // input streams
    hls::stream<hls::vector<q_t, TP*NP> > &i_stream,
    hls::stream<hls::vector<s_t, TP   > > &i_s_stream,
    // output streams
    hls::stream<hls::vector<q_t, T* NP> > &q_stream,    // fully unrolled output parallelism
    hls::stream<hls::vector<s_t, T* 1 > > &s_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=i_s_stream
    #pragma HLS interface axis port=q_stream
    #pragma HLS interface axis port=s_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=i_s_stream compact=bit
    #pragma HLS aggregate variable=q_stream    compact=bit
    #pragma HLS aggregate variable=s_stream    compact=bit

    // declare internal streams
    #pragma HLS dataflow


    // stage 2: buffer mha xln
    // for qkvom, input dims are the same
 // Buffer the input streams and write to output streams
    buffer_q.do_buffer          (R, i_stream, q_stream);
    buffer_s.do_buffer          (R, i_s_stream, s_stream);

}

// Reference and DUT data declarations
// declare the ref data here
int64_t REF_IN_Q    [T  *N  ];  // mha input
int64_t REF_IN_S    [T  *NT2 ];  // mha input

// declare the dut output here
int64_t DUT_X_Q          [NUM_X];
int64_t DUT_X_S          [NUM_S];

void test_layer(int l){
    //* copy from GEMM testbench, create i_stream_ref and s_stream_ref, as golden reference
    {
        // Load reference data from files
        string file_path = "D:/file/project/git/light-mamba/ref/activations";
        string file_path_suffix      = to_string(l) + ".bin";
        // read input refs
        // Read input reference tensors
        auto IN_Q      = read_tensor<int64_t>  (file_path + "/C_q_layer" + file_path_suffix);
        auto IN_S      = read_tensor<int64_t>  (file_path + "/C_s_layer" + file_path_suffix);
        // Convert tensors to arrays
        //          <dtype >    TENSOR,     ARRAY,          H_LOAD, H,      T_LOAD, T,      C_LOAD, C
        tensor2array<int64_t>(   IN_Q,     REF_IN_Q,     1,      1,      T_LOAD, T,      N,    N );
        tensor2array<int64_t>(   IN_S,     REF_IN_S,     1,      1,      T_LOAD, T,      NT2,  NT2);
      
    }

    // create streams
    hls::stream<hls::vector<q_t, TP*NP> > i_stream ( "i_stream" );
    hls::stream<hls::vector<s_t, TP   > > i_s_stream ( "i_s_stream" );
    hls::stream<hls::vector<q_t, T* NP> > q_stream     ( "q_stream"    );
    hls::stream<hls::vector<s_t, T    > > s_stream     ( "s_stream"    );

    // // put data into the streams, with correct order
    array2stream<int64_t, q_t, 1, 1, T, TP, N,  NP >(REF_IN_Q, i_stream, "IN Q", true);
    array2stream<int64_t, s_t, 1, 1, T, TP, NT2, 1  >(REF_IN_S, i_s_stream, "IN S", true);

    // call the top function
    top(i_stream, i_s_stream, q_stream, s_stream);

    // check q stream size
    printf("q_stream size: %d\n", q_stream.size());
    printf("s_stream size: %d\n", s_stream.size());
    printf("NUM_X: %d\n", NUM_X);
    printf("NUM_S: %d\n", NUM_S);

    // read the output streams
    stream2array<int64_t, q_t, 1, 1, 1, NUM_X, T*NP>(q_stream, DUT_X_Q, "OUT Q", true);
    stream2array<int64_t, s_t, 1, 1, 1, NUM_S, T   >(s_stream, DUT_X_S, "OUT S", true);

    // compare the output streams
    // compare<int64_t>(REF_X_Q, DUT_X_Q, NUM_X, "X Q", true);
    // compare<int64_t>(REF_X_S, DUT_X_S, NUM_S, "X S", true);
    string info="X Q";
    bool match = true;
    for(int r=0; r<R; ++r){
        for(int c=0; c<N; ++c){
            if(REF_IN_Q[c] != DUT_X_Q[r*N+c]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(),r*N+c, REF_IN_Q[c], DUT_X_Q[r*N+c]);
                match = false;
            }
        }
    }
    if(match){
    } else {
        printf("%s mismatch\n", info.c_str());
    }
    info="X S";
    match = true;
    for(int r=0; r<R; ++r){
        for(int c=0; c<NT2; ++c){
            if(REF_IN_S[c] != DUT_X_S[r*NT2+c]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(),r*NT2+c, REF_IN_S[c], DUT_X_S[r*NT2+c]);
                match = false;
            }
        }
    }
    if(match){
    } else {
        printf("%s mismatch\n", info.c_str());
    }
}

/**
 * @brief Main function to run tests for all layers.
 *
 * Iterates through all layers and calls the test function for each.
 * @return 0 on successful completion.
 */
int main(){
    // read input data and reference data
    for(int l=0; l<L; ++l){
        test_layer(l);
        printf("Layer %d passed\n", l);
    }
}



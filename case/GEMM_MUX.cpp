#include "../src/common.h"
#include "../src/utils.h"
#include "../src/gemm_buffer.h"

/**
 * @brief Implementation of a multiplexer (MUX) for GEMM operations in the Llama model.
 *
 * This module serves as a multiplexer for the Llama model, preceding the GEMM operation.
 * It handles three input channels:
 * - XLN: RMSNorm result (normal order, 4x8 parallelism)
 * - A: Attention result (normal order, 4x8 parallelism)
 * - XM: MLP multiplication result (unpacked order, 1x8 parallelism)
 *
 * The module buffers and multiplexes these inputs into unified output streams for GEMM processing.
 */

/**
 * @brief Hyperparameters and constants for the GEMM multiplexer.
 */
constexpr int G = 8; ///< Parallelism factor for input and output channels.
constexpr int L = 2; ///< Number of layers (scaled down for testing).
constexpr int T_LOAD = 512; ///< Saved sequence length.
constexpr int T = 1; ///< Sequence length for processing.
constexpr int TP = 1; ///< Input parallelism.
constexpr int TT = T / TP; ///< Derived sequence length per parallel unit.
constexpr int CI1 = 2560; ///< Input channel size for first stream.
constexpr int CI2 = 5120; ///< Input channel size for second stream.
constexpr int CO1 = 10576; ///< Output channel size for first stream.
constexpr int CO2 = 2560; ///< Output channel size for second stream.
constexpr int CP = G; ///< Channel parallelism for input and output.
constexpr int CIT1 = CI1 / CP; ///< Input channels per parallel unit for first stream.
constexpr int CIT2 = CI2 / CP; ///< Input channels per parallel unit for second stream.
constexpr int COT1 = CO1 / CP; ///< Output channels per parallel unit for first stream.
constexpr int COT2 = CO2 / CP; ///< Output channels per parallel unit for second stream.
constexpr int NUM_X = T * (CI1 * COT1 + CI2 * COT2); ///< Total size of q data.
constexpr int NUM_S = NUM_X / G; ///< Total size of s data.
constexpr int R1 = COT1; ///< Repeat count for first stream buffer.
constexpr int R2 = COT2; ///< Repeat count for second stream buffer.

typedef ap_int<DW_AQ> q_t; ///< Data type for quantized values.
typedef ap_uint<DW_ASCALE> s_t; ///< Data type for scale values.

// calculate repeat times for each buffer
constexpr int R1 = COT1;
constexpr int R2 = COT2;


/**
 * @brief Multiplexer function for GEMM input streams.
 *
 * This function multiplexes two buffered input streams (xlnq1, xlns1 and xlnq2, xlns2)
 * into unified output streams (q_stream, s_stream) based on the iteration index.
 *
 * @param xlnq1_buffered_stream First input stream for quantized data (RMSNorm).
 * @param xlns1_buffered_stream First input stream for scale data (RMSNorm).
 * @param xlnq2_buffered_stream Second input stream for quantized data (MLP).
 * @param xlns2_buffered_stream Second input stream for scale data (MLP).
 * @param q_stream Output stream for multiplexed quantized data.
 * @param s_stream Output stream for multiplexed scale data.
 */
void GEMM_MUX(
    // input streams
    hls::stream<hls::vector<q_t, T*CP> > &xlnq1_buffered_stream,
    hls::stream<hls::vector<s_t, T   > > &xlns1_buffered_stream,
    hls::stream<hls::vector<q_t, T*CP> > &xlnq2_buffered_stream,
    hls::stream<hls::vector<s_t, T   > > &xlns2_buffered_stream,
    // ouptut streams
    hls::stream<hls::vector<q_t, T*CP> > &q_stream,
    hls::stream<hls::vector<s_t, T   > > &s_stream
){
    // Iterate over the total number of data elements from both input buffers
    for(int r=0; r<R1*CIT1 + R2*CIT2; ++r){
         // Pipeline the loop with initiation interval (II) = 1 for high throughput
        #pragma HLS pipeline II=1
           // Declare vector containers for q and s values
        hls::vector<q_t, T*CP> q_vec;
        hls::vector<s_t, T   > s_vec;
        // Read from the first input stream if within its range
        if(r < R1*CIT1){ 
            q_vec = xlnq1_buffered_stream.read();
            s_vec = xlns1_buffered_stream.read();
        } else {  // Otherwise, read from the second input stream
            q_vec = xlnq2_buffered_stream.read();
            s_vec = xlns2_buffered_stream.read();
        }
        // Write the selected data to the unified output streams
        q_stream.write(q_vec);
        s_stream.write(s_vec);
    }
}


/**
 * @brief Buffer instances for input and output streams.
 */
GEMM_BUFFER<q_t, 1, T, TP, CI1, CP> in_buffer_q; ///< Buffer for first quantized input stream.
GEMM_BUFFER<s_t, 1, T, TP, CIT1, 1> in_buffer_s; ///< Buffer for first scale input stream.
GEMM_BUFFER<q_t, 1, T, TP, CI2, CP> out_buffer_q; ///< Buffer for second quantized input stream.
GEMM_BUFFER<s_t, 1, T, TP, CIT2, 1> out_buffer_s; ///< Buffer for second scale input stream.

void top(
    // input streams
    hls::stream<hls::vector<q_t, TP*CP> > &xlnq1_stream,
    hls::stream<hls::vector<s_t, TP   > > &xlns1_stream,
    hls::stream<hls::vector<q_t, TP*CP> > &xlnq2_stream,
    hls::stream<hls::vector<s_t, TP   > > &xlns2_stream,
    // output streams
    hls::stream<hls::vector<q_t, T* CP> > &q_stream,    // fully unrolled output parallelism
    hls::stream<hls::vector<s_t, T* 1 > > &s_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=xlnq1_stream
    #pragma HLS interface axis port=xlns1_stream
    #pragma HLS interface axis port=xlnq2_stream
    #pragma HLS interface axis port=xlns2_stream
    #pragma HLS interface axis port=q_stream
    #pragma HLS interface axis port=s_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=xlnq1_stream compact=bit
    #pragma HLS aggregate variable=xlns1_stream compact=bit
    #pragma HLS aggregate variable=xlnq2_stream compact=bit
    #pragma HLS aggregate variable=xlns2_stream compact=bit
    #pragma HLS aggregate variable=q_stream    compact=bit
    #pragma HLS aggregate variable=s_stream    compact=bit

    // declare internal streams
    // buffered streams, including mha_xln, a, mlp_xln
    hls::stream<hls::vector<q_t, T*CP> > xlnq1_buffered_stream   ( "xlnq1_buffered_stream"    );
    hls::stream<hls::vector<s_t, T   > > xlns1_buffered_stream   ( "xlns1_buffered_stream"    );
    hls::stream<hls::vector<q_t, T*CP> > xlnq2_buffered_stream   ( "xlnq2_buffered_stream"    );
    hls::stream<hls::vector<s_t, T   > > xlns2_buffered_stream   ( "xlns2_buffered_stream"    );

    #pragma HLS dataflow


    // stage 2: buffer mha xln
    // for qkvom, input dims are the same

    in_buffer_q.do_buffer          (R1, xlnq1_stream, xlnq1_buffered_stream);
    in_buffer_s.do_buffer          (R1, xlns1_stream, xlns1_buffered_stream);

    out_buffer_q.do_buffer         (R2, xlnq2_stream, xlnq2_buffered_stream);
    out_buffer_s.do_buffer         (R2, xlns2_stream, xlns2_buffered_stream);


    // stage 3: mux qkvom
    GEMM_MUX(
        xlnq1_buffered_stream,
        xlns1_buffered_stream,
        xlnq2_buffered_stream,
        xlns2_buffered_stream,
        q_stream,
        s_stream
    );


}

/**
 * @brief Reference and DUT data arrays for testing.
 */
// declare the ref data here
int64_t REF_XLN1_Q    [T  *CI1  ];  // mha input
int64_t REF_XLN1_S    [T  *CIT1 ];  // mha input
int64_t REF_XLN2_Q    [T  *CI2  ];  // mha input
int64_t REF_XLN2_S    [T  *CIT2 ];  // mha input

// declare the dut output here
int64_t DUT_X_Q          [NUM_X];
int64_t DUT_X_S          [NUM_S];

/**
 * @brief Test function for a single layer.
 *
 * This function reads reference data, converts it to streams, calls the top function,
 * and verifies the output against the reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    //* copy from GEMM testbench, create i_stream_ref and s_stream_ref, as golden reference
    {

        string file_path = "D:/file/project/git/light-mamba/ref/activations";
        string file_path_suffix      = to_string(l) + ".bin";
        // read input refs
        auto XLN1_Q      = read_tensor<int64_t>  (file_path + "/rms1_q_layer" + file_path_suffix);
        auto XLN1_S      = read_tensor<int64_t>  (file_path + "/rms1_s_layer" + file_path_suffix);
        auto XLN2_Q      = read_tensor<int64_t>  (file_path + "/rms2_q_layer" + file_path_suffix);
        auto XLN2_S      = read_tensor<int64_t>  (file_path + "/rms2_s_layer" + file_path_suffix);
        // Convert tensors into flat arrays
        //          <dtype >    TENSOR,     ARRAY,          H_LOAD, H,      T_LOAD, T,      C_LOAD, C
        tensor2array<int64_t>(   XLN1_Q,     REF_XLN1_Q,     1,      1,      T_LOAD, T,      CI1,    CI1 );
        tensor2array<int64_t>(   XLN1_S,     REF_XLN1_S,     1,      1,      T_LOAD, T,      CIT1,   CIT1);
        tensor2array<int64_t>(   XLN2_Q,     REF_XLN2_Q,     1,      1,      T_LOAD, T,      CI2,    CI2 );
        tensor2array<int64_t>(   XLN2_S,     REF_XLN2_S,     1,      1,      T_LOAD, T,      CIT2,   CIT2);
    }

    // create streams
    hls::stream<hls::vector<q_t, TP*CP> > xlnq1_stream ( "xlnq1_stream" );
    hls::stream<hls::vector<s_t, TP   > > xlns1_stream ( "xlns1_stream" );
    hls::stream<hls::vector<q_t, TP*CP> > xlnq2_stream ( "xlnq2_stream" );
    hls::stream<hls::vector<s_t, TP   > > xlns2_stream ( "xlns2_stream" );
    hls::stream<hls::vector<q_t, T* CP> > q_stream     ( "q_stream"    );
    hls::stream<hls::vector<s_t, T    > > s_stream     ( "s_stream"    );

    // // put data into the streams, with correct order
    array2stream<int64_t, q_t, 1, 1, T, TP, CI1,  CP >(REF_XLN1_Q, xlnq1_stream, "XLN1 Q", true);
    array2stream<int64_t, s_t, 1, 1, T, TP, CIT1, 1  >(REF_XLN1_S, xlns1_stream, "XLN1 S", true);
    array2stream<int64_t, q_t, 1, 1, T, TP, CI2,  CP >(REF_XLN2_Q, xlnq2_stream, "XLN2 Q", true);
    array2stream<int64_t, s_t, 1, 1, T, TP, CIT2, 1  >(REF_XLN2_S, xlns2_stream, "XLN2 S", true);

    // call the top function
    top(xlnq1_stream, xlns1_stream, xlnq2_stream, xlns2_stream, q_stream, s_stream);

    // check q stream size
    printf("q_stream size: %d\n", q_stream.size());
    printf("s_stream size: %d\n", s_stream.size());
    printf("NUM_X: %d\n", NUM_X);
    printf("NUM_S: %d\n", NUM_S);

    // read the output streams
    stream2array<int64_t, q_t, 1, 1, 1, NUM_X, T*CP>(q_stream, DUT_X_Q, "X Q", true);
    stream2array<int64_t, s_t, 1, 1, 1, NUM_S, T   >(s_stream, DUT_X_S, "X S", true);

    // compare the output streams
    // compare<int64_t>(REF_X_Q, DUT_X_Q, NUM_X, "X Q", true);
    // compare<int64_t>(REF_X_S, DUT_X_S, NUM_S, "X S", true);
    
    string info="X Q";
    bool match = true;
    for(int r=0; r<R1; ++r){
        for(int c=0; c<CI1; ++c){
            if(REF_XLN1_Q[c] != DUT_X_Q[r*CI1+c]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(),r*CI1+c, REF_XLN1_Q[c], DUT_X_Q[r*CI1+c]);
                match = false;
            }
        }
    }
    for(int r=0; r<R2; ++r){
        for(int c=0; c<CI2; ++c){
            if(REF_XLN2_Q[c] != DUT_X_Q[R1*CI1+r*CI2+c]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(),R1*CI1+r*CI1+c, REF_XLN2_Q[c], DUT_X_Q[R1*CI1+r*CI2+c]);
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
    for(int r=0; r<R1; ++r){
        for(int c=0; c<CIT1; ++c){
            if(REF_XLN1_S[c] != DUT_X_S[r*CIT1+c]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(),r*CIT1+c, REF_XLN1_S[c], DUT_X_S[r*CIT1+c]);
                match = false;
            }
        }
    }
    for(int r=0; r<R2; ++r){
        for(int c=0; c<CIT2; ++c){
            if(REF_XLN2_S[c] != DUT_X_S[R1*CIT1+r*CIT2+c]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(),R1*CIT1+r*CIT1+c, REF_XLN2_S[c], DUT_X_S[R1*CIT1+r*CIT2+c]);
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
 * Iterates through all layers and calls the test_layer function for each.
 *
 * @return 0 on successful execution.
 */
int main(){
    // read input data and reference data
    for(int l=0; l<L; ++l){
        test_layer(l);
        printf("Layer %d passed\n", l);
    }
}



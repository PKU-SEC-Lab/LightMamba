
/**
 * This module tests the demultiplexer operation that splits a combined input stream into multiple output streams
 * (x, x2, B, C, z) along with their respective scale streams. It loads reference data, creates input streams,
 * executes the demultiplexer, and compares the output against reference data. The implementation is optimized
 * for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/utils.h"


// This module is the demux for the Llama, the next module of GEMM

// hyperparameters
/** @brief Group size for parallelism */
constexpr int G = 8;

/** @brief Number of test layers */
constexpr int L = 2;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;
/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = T;

/** @brief Channel dimension size for xBC stream */
constexpr int CC = 5376;
/** @brief Hidden dimension size */
constexpr int N = 128;
/** @brief Channel dimension size for z stream */
constexpr int C2 = 5120;

/** @brief Channel parallelism for input and output streams */
constexpr int CP = G;

/** @brief Number of hidden dimension tiles for B and C streams */
constexpr int NT2 = N / CP;
/** @brief Total number of hidden dimension tiles */
constexpr int NTT = 2 * N / CP;
/** @brief Number of channel tiles for xBC stream */
constexpr int CCT = CC / CP;
/** @brief Number of channel tiles for z stream */
constexpr int C2T = C2 / CP;
/** @brief Total number of channel tiles */
constexpr int CT = (CC + C2) / CP;

/** @brief Total number of elements in the input stream */
constexpr int NUM_Y = CC + C2;

/** @brief Quantized data type for streams */
typedef ap_int<DW_ACQ> q_t;
/** @brief Scale data type for streams */
typedef ap_uint<DW_ASCALE> s_t;

/**
 * @brief Top-level function for the demultiplexer module.
 *
 * Splits the combined input stream (silu_stream) and its scale stream (silu_s_stream) into multiple output streams
 * (x, x2, B, C, z) with their respective scale streams based on the channel tile index.
 *
 * @param silu_stream Input stream of quantized data with CP parallelism.
 * @param silu_s_stream Input stream of scale data with single element vectors.
 * @param x_stream Output stream for x data with CP parallelism.
 * @param x_s_stream Output stream for x scale data with single element vectors.
 * @param x_stream2 Output stream for x2 data with CP parallelism.
 * @param x_s_stream2 Output stream for x2 scale data with single element vectors.
 * @param B_stream Output stream for B data with CP parallelism.
 * @param B_s_stream Output stream for B scale data with single element vectors.
 * @param C_stream Output stream for C data with CP parallelism.
 * @param C_s_stream Output stream for C scale data with single element vectors.
 * @param z_stream Output stream for z data with CP parallelism.
 * @param z_s_stream Output stream for z scale data with single element vectors.
 */
void top(
    hls::stream<hls::vector<q_t,  CP> >& silu_stream,
    hls::stream<hls::vector<s_t,  1> >& silu_s_stream,
    hls::stream<hls::vector<q_t,  CP> >& x_stream,
    hls::stream<hls::vector<s_t,  1> >& x_s_stream,
    hls::stream<hls::vector<q_t,  CP> >& x_stream2,
    hls::stream<hls::vector<s_t,  1> >& x_s_stream2,
    hls::stream<hls::vector<q_t,  CP> >& B_stream,
    hls::stream<hls::vector<s_t,  1> >& B_s_stream,
    hls::stream<hls::vector<q_t,  CP> >& C_stream,
    hls::stream<hls::vector<s_t,  1> >& C_s_stream,
    hls::stream<hls::vector<q_t,  CP> >& z_stream,
    hls::stream<hls::vector<s_t,  1> >& z_s_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=silu_stream
    #pragma HLS interface axis port=silu_s_stream
    #pragma HLS interface axis port=x_stream
    #pragma HLS interface axis port=x_stream2
    #pragma HLS interface axis port=B_stream
    #pragma HLS interface axis port=C_stream
    #pragma HLS interface axis port=z_stream
    #pragma HLS interface axis port=x_s_stream
    #pragma HLS interface axis port=x_s_stream2
    #pragma HLS interface axis port=B_s_stream
    #pragma HLS interface axis port=C_s_stream
    #pragma HLS interface axis port=z_s_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=silu_stream compact=bit
    #pragma HLS aggregate variable=silu_s_stream compact=bit
    #pragma HLS aggregate variable=x_stream    compact=bit
    #pragma HLS aggregate variable=x_stream2    compact=bit
    #pragma HLS aggregate variable=B_stream    compact=bit
    #pragma HLS aggregate variable=C_stream    compact=bit
    #pragma HLS aggregate variable=z_stream    compact=bit
    #pragma HLS aggregate variable=x_s_stream    compact=bit
    #pragma HLS aggregate variable=x_s_stream2    compact=bit
    #pragma HLS aggregate variable=B_s_stream    compact=bit
    #pragma HLS aggregate variable=C_s_stream    compact=bit
    #pragma HLS aggregate variable=z_s_stream    compact=bit

    /**< Iterate over total channel tiles */
    for(int ct=0;ct<CT;++ct) {

        /**< Enable pipelining with initiation interval of 1 */
        #pragma HLS pipeline II=1

         /**< Read input quantized vector */
        hls::vector<q_t, CP> i_vec=silu_stream.read();

         /**< Read input scale vector */
        hls::vector<s_t, 1> s_vec=silu_s_stream.read();

        /**< Route to B stream for first NT2 tiles */
        if(ct<NT2) {
            B_stream.write(i_vec);
            B_s_stream.write(s_vec);
        }

        /**< Route to C stream for next NT2 tiles */
        else if(ct<NTT) {
            C_stream.write(i_vec);
            C_s_stream.write(s_vec);
        }

        /**< Route to x and x2 streams for even indices */
        else if((ct&1)==0) {
            x_stream.write(i_vec);
            x_s_stream.write(s_vec);
            x_stream2.write(i_vec);
            x_s_stream2.write(s_vec);
        }

        /**< Route to z stream for odd indices */
        else {
            z_stream.write(i_vec);
            z_s_stream.write(s_vec);
        }
    }
}

// Reference and DUT data declarations
// declare the ref input
int64_t REF_Y           [NUM_Y ];   // condensed input
int64_t REF_Y_S           [CT ];   // condensed input
// declare the ref output
int64_t REF_X       [T*C2 ];   // Q
int64_t REF_X_S       [T*C2T ];   // Q
int64_t REF_B      [T*N ];   // K
int64_t REF_B_S      [T*NT2 ];   // K
int64_t REF_C      [T*N ];   // K
int64_t REF_C_S      [T*NT2 ];   // K
int64_t REF_Z        [T*C2 ];   // V
int64_t REF_Z_S        [T*C2T ];   // V

// declare the permuted dut output
int64_t DUT_X       [T*C2 ];   // Q
int64_t DUT_X_S       [T*C2T ];   // Q
int64_t DUT_X2       [T*C2 ];   // Q
int64_t DUT_X_S2       [T*C2T ];   // Q
int64_t DUT_B      [T*N ];   // K
int64_t DUT_B_S      [T*NT2 ];   // K
int64_t DUT_C      [T*N ];   // K
int64_t DUT_C_S      [T*NT2 ];   // K
int64_t DUT_Z        [T*C2 ];   // V
int64_t DUT_Z_S        [T*C2T ];   // V


/**
 * @brief Test function for a single demultiplexer layer.
 *
 * Loads reference data, creates input streams, runs the demultiplexer operation, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    {
        // read condensed input：Read input reference data
        auto Y = read_tensor<int64_t> (file_path + "/xBCz_silu_q_layer" + file_path_suffix);
        auto Y_S = read_tensor<int64_t> (file_path + "/xBCz_silu_s_layer" + file_path_suffix);
        // read result
        // put input into ref
        tensor2array<int64_t>(Y, REF_Y, 1,  1,  T_LOAD,   T,  NUM_Y,  NUM_Y);
        tensor2array<int64_t>(Y_S, REF_Y_S, 1,  1,  T_LOAD,   T,  CT,  CT);
        // // Construct reference output arrays
        int ct = 0;
        /**< Copy B data */
        for (int nt = 0; nt < NT2; ++nt) {
            for (int cp = 0; cp < CP; ++cp) {
                REF_B[nt * CP + cp] = REF_Y[ct * CP + cp];
            }
            REF_B_S[nt] = REF_Y_S[ct];
            ct++;
        }
         /**< Copy C data */
        for (int nt = 0; nt < NT2; ++nt) {
            for (int cp = 0; cp < CP; ++cp) {
                REF_C[nt * CP + cp] = REF_Y[ct * CP + cp];
            }
            REF_C_S[nt] = REF_Y_S[ct];
            ct++;
        }

        /**< Copy x and z data alternately */
        for (int c2t = 0; c2t < C2T; ++c2t) {
            for (int cp = 0; cp < CP; ++cp) {
                REF_X[c2t * CP + cp] = REF_Y[ct * CP + cp];
            }
            REF_X_S[c2t] = REF_Y_S[ct];
            ct++;
            for (int cp = 0; cp < CP; ++cp) {
                REF_Z[c2t * CP + cp] = REF_Y[ct * CP + cp];
            }
            REF_Z_S[c2t] = REF_Y_S[ct];
            ct++;
        }
        
    }

    // Create input and output streams
    hls::stream<hls::vector<q_t, CP> > silu_stream( "silu_stream");
    hls::stream<hls::vector<q_t, CP> > x_stream  ( "x_stream"  );
    hls::stream<hls::vector<q_t, CP> > x_stream2  ( "x_stream2"  );
    hls::stream<hls::vector<q_t, CP> > B_stream ( "B_stream" );
    hls::stream<hls::vector<q_t, CP> > C_stream ( "C_stream" );
    hls::stream<hls::vector<q_t, CP> > z_stream   ( "z_stream"   );
    hls::stream<hls::vector<s_t, 1 > > silu_s_stream( "silu_s_stream");
    hls::stream<hls::vector<s_t, 1 > > x_s_stream  ( "x_s_stream"  );
    hls::stream<hls::vector<s_t, 1 > > x_s_stream2  ( "x_s_stream2"  );
    hls::stream<hls::vector<s_t, 1 > > B_s_stream ( "B_s_stream" );
    hls::stream<hls::vector<s_t, 1 > > C_s_stream ( "C_s_stream" );
    hls::stream<hls::vector<s_t, 1 > > z_s_stream   ( "z_s_stream"   );

    // use condensed as input
    array2stream       <int64_t,   q_t,  1,   1,    1,    1,   NUM_Y,  CP>(REF_Y, silu_stream, "Input Y");
    array2stream       <int64_t,   s_t,  1,   1,    1,    1,   CT,  1>(REF_Y_S, silu_s_stream, "Input Y");
    // call top function
    top(silu_stream, silu_s_stream, x_stream, x_s_stream, x_stream2, x_s_stream2,
    B_stream, B_s_stream, C_stream, C_s_stream, z_stream, z_s_stream);

    // stream out and put into perm result
    stream2array<int64_t,  q_t,  1,  T,  T, C2, CP>(x_stream,  DUT_X,   "Output X", true);
    stream2array<int64_t,  s_t,  1,  T,  T, C2T, 1>(x_s_stream,  DUT_X_S,   "Output X_S", true);
    stream2array<int64_t,  q_t,  1,  T,  T, C2, CP>(x_stream2,  DUT_X2,   "Output X2", true);
    stream2array<int64_t,  s_t,  1,  T,  T, C2T, 1>(x_s_stream2,  DUT_X_S2,   "Output X_S2", true);
    stream2array<int64_t,  q_t,  1,  T,  T, N,  CP>(B_stream,  DUT_B,   "Output B", true);
    stream2array<int64_t,  s_t,  1,  T,  T, NT2, 1>(B_s_stream,  DUT_B_S,   "Output B_S", true);
    stream2array<int64_t,  q_t,  1,  T,  T, N,  CP>(C_stream,  DUT_C,   "Output C", true);
    stream2array<int64_t,  s_t,  1,  T,  T, NT2, 1>(C_s_stream,  DUT_C_S,   "Output C_S", true);
    stream2array<int64_t,  q_t,  1,  T,  T, C2, CP>(z_stream,  DUT_Z,   "Output Z", true);
    stream2array<int64_t,  s_t,  1,  T,  T, C2T, 1>(z_s_stream,  DUT_Z_S,   "Output Z_S", true);
    

    // Compare outputs with reference
    compare<int64_t>(REF_X,  DUT_X,  T*C2, "X"  );
    compare<int64_t>(REF_X_S,DUT_X_S,T*C2T, "X_S"  );
    compare<int64_t>(REF_X,  DUT_X2,  T*C2, "X2"  );
    compare<int64_t>(REF_X_S,DUT_X_S2,T*C2T, "X_S2"  );
    compare<int64_t>(REF_B,  DUT_B,  T*N, "B"  );
    compare<int64_t>(REF_B_S,DUT_B_S,T*NT2, "B_S"  );
    compare<int64_t>(REF_C,  DUT_C,  T*N, "C"  );
    compare<int64_t>(REF_C_S,DUT_C_S,T*NT2, "C_S"  );
    compare<int64_t>(REF_Z,  DUT_Z,  T*C2, "Z"  );
    compare<int64_t>(REF_Z_S,DUT_Z_S,T*C2T, "Z_S"  );
}


/**
 * @brief Main function to run tests for all layers.
 *
 * Iterates through all test layers and calls the test function for each.
 * @return 0 on successful completion.
 */
int main(){
    // read input data and reference data
    for(int l=0; l<L; ++l){
        test_layer(l);
        printf("Layer %d passed\n", l);
    }
}



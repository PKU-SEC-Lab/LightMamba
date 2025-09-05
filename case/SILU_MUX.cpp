/**
 * This module tests the multiplexer operation that combines input streams (xBC and z) into a single output stream
 * for the SILU operation. It loads reference data, creates input streams, executes the multiplexer, and compares
 * the output against reference data. The implementation is optimized for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/utils.h"
#include "../src/gemm_buffer.h"

// This module is the mux for the Llama, the previous module of GEMM
// it takes 3 channels: XLN, A, XM
// XLN is RMSNorm result
// A is the attention result
// XM is the MLP multiplication result

// pay attention to the data order:
// XLN is normal order,     4x8 parallelism
// A is normal order,       4x8 parallelism
// XM is unpacked order,    1x8 parallelism

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
constexpr int TP = 1;
/** @brief Number of time tiles */
constexpr int TT = T / TP;

/** @brief Channel dimension size for xBC stream */
constexpr int CC = 5376;
/** @brief Hidden dimension size */
constexpr int N = 128;
/** @brief Channel dimension size for z stream */
constexpr int C2 = 5120;

/** @brief Channel parallelism for input and output streams */
constexpr int CP = G;

/** @brief Number of hidden dimension tiles */
constexpr int NTT = 2 * N / CP;
/** @brief Number of channel tiles for xBC stream */
constexpr int CCT = CC / CP;
/** @brief Number of channel tiles for z stream */
constexpr int C2T = C2 / CP;
/** @brief Total number of channel tiles */
constexpr int CT = C2 * 2 / CP;

/** @brief Total number of elements in the output stream */
constexpr int NUM_X = CC + C2;


/**
 * @brief Multiplexer function for combining xBC and z streams for SILU operation.
 *
 * Reads from xBC and z input streams and combines them into a single output stream in a specific order.
 * The first NTT vectors come from xBC, followed by interleaved vectors from xBC and z streams.
 *
 * @param xBC_stream Input stream of xBC data with TP*CP parallelism.
 * @param z_stream Input stream of z data with TP*CP parallelism.
 * @param silu_stream Output stream of combined data with T*CP parallelism.
 */
void SILU_MUX(
    // input streams
    hls::stream<hls::vector<X_T, TP*CP> > &xBC_stream,
    hls::stream<hls::vector<X_T, TP*CP> > &z_stream,
    // output streams
    hls::stream<hls::vector<X_T, T* CP> > &silu_stream
){
    for(int ct=0;ct<NTT;ct++) {     /**< Iterate over hidden dimension tiles */
        #pragma HLS pipeline II=1   /**< Enable pipelining with initiation interval of 1 */
        hls::vector<X_T, CP> vec;    /**< Temporary vector for data */
        vec=xBC_stream.read();      /**< Read from xBC stream */
        silu_stream.write(vec); /**< Write to output stream */
    }
    for(int ct=0;ct<CT;ct++) {  /**< Iterate over channel tiles */
        #pragma HLS pipeline II=1 /**< Enable pipelining with initiation interval of 1 */
        hls::vector<X_T, CP> vec; /**< Temporary vector for data */
        if(ct&1) {   /**< Alternate between z and xBC streams */
            vec=z_stream.read(); /**< Read from z stream for odd indices */
        }
        else {
            vec=xBC_stream.read();  /**< Read from xBC stream for even indices */
        }
        silu_stream.write(vec); /**< Write to output stream */
        
    }
}

/**
 * @brief Top-level function for the SILU multiplexer test module.
 *
 * Executes the SILU multiplexer operation to combine xBC and z streams into a single output stream.
 *
 * @param xBC_stream Input stream of xBC data with TP*CP parallelism.
 * @param z_stream Input stream of z data with TP*CP parallelism.
 * @param silu_stream Output stream of combined data with T*CP parallelism.
 */
void top(
    // input streams
    hls::stream<hls::vector<X_T, TP*CP> > &xBC_stream,
    hls::stream<hls::vector<X_T, TP*CP> > &z_stream,
    // output streams
    hls::stream<hls::vector<X_T, T* CP> > &silu_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=xBC_stream
    #pragma HLS interface axis port=z_stream
    #pragma HLS interface axis port=silu_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=xBC_stream compact=bit
    #pragma HLS aggregate variable=z_stream compact=bit
    #pragma HLS aggregate variable=silu_stream compact=bit

    #pragma HLS dataflow


    // stage 2: buffer mha xln
    // for qkvom, input dims are the same

    // stage 3: mux qkvom
    // Execute SILU multiplexer operation
    SILU_MUX(
        xBC_stream,
        z_stream,
        silu_stream
    );


}


// Reference and DUT data declarations
int64_t REF_XBC    [T  *CC  ];  // mha input
int64_t REF_Z      [T  *C2 ];  // mha input

// declare the dut output here
int64_t REF_X          [NUM_X];
int64_t DUT_X          [NUM_X];

/**
 * @brief Test function for a single SILU multiplexer layer.
 *
 * Loads reference data, creates input streams, runs the SILU multiplexer operation, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    //* copy from GEMM testbench, create i_stream_ref and s_stream_ref, as golden reference
    {
        string file_path = "D:/file/project/git/light-mamba/ref/activations";
        string file_path_suffix      = to_string(l) + ".bin";
         // Read reference data
        auto XBC      = read_tensor<int64_t>  (file_path + "/xBC_layer" + file_path_suffix);
        auto Z        = read_tensor<int64_t>  (file_path + "/z_layer" + file_path_suffix);

         // Convert tensors to arrays
        //          <dtype >    TENSOR,     ARRAY,          H_LOAD, H,      T_LOAD, T,      C_LOAD, C
        tensor2array<int64_t>(   XBC,     REF_XBC,   1,      1,      T_LOAD, T,      CC,    CC);
        tensor2array<int64_t>(   Z,       REF_Z,     1,      1,      T_LOAD, T,      C2,    C2);
     
         // Construct reference output array
        int ct = 0;
        for (int nt2 = 0; nt2 < NTT; ++nt2) {
            for (int cp = 0; cp < CP; ++cp) {
                REF_X[ct * CP + cp] = REF_XBC[nt2 * CP + cp];
            }
            ct++;
        }
        for (int c2t = 0; c2t < C2T; ++c2t) {
            for (int cp = 0; cp < CP; ++cp) {
                REF_X[ct * CP + cp] = REF_XBC[2 * N + c2t * CP + cp];
            }
            ct++;
            for (int cp = 0; cp < CP; ++cp) {
                REF_X[ct * CP + cp] = REF_Z[c2t * CP + cp];
            }
            ct++;
        }
    }

    // Create input and output streams
    hls::stream<hls::vector<X_T, TP*CP> > xBC_stream ( "xBC_stream" );
    hls::stream<hls::vector<X_T, TP*CP> > z_stream   ( "z_stream" );
    hls::stream<hls::vector<X_T, TP*CP> > silu_stream( "silu_stream" );


    // // put data into the streams, with correct order
    array2stream<int64_t, X_T, 1, 1, T, TP, CC,  CP >(REF_XBC, xBC_stream, "XBC", true);
    array2stream<int64_t, X_T, 1, 1, T, TP, C2,  CP >(REF_Z, z_stream, "Z", true);
    
    

    // call the top function
    top(xBC_stream, z_stream, silu_stream);

    // check q stream size
    // Print stream size for debugging
    printf("silu_stream size: %d\n", silu_stream.size());
    printf("NUM_X: %d\n", NUM_X);


    // read the output streams
    stream2array<int64_t, X_T, 1, 1, 1, NUM_X, T*CP>(silu_stream, DUT_X, "X", true);
    

    // compare the output streams
    // Compare output with reference
    compare<int64_t>(REF_X, DUT_X, NUM_X, "X", true);
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



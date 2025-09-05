/**
 * This module implements a multiplexer for residual connections, processing input streams, adding residual inputs,
 * and producing residual outputs and final output streams. It is optimized for HLS with pipelining, unrolling, and
 * array reshaping directives. The testbench validates the functionality by comparing outputs against reference data.
 */
#include "../src/common.h"
#include "../src/utils.h"

/** @brief Group size for channel parallelism */
constexpr int G = 8;

/** @brief Number of layers */
constexpr int L = 2;
/** @brief Number of test layers */
constexpr int L_TEST = 1;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;
/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = 1;
/** @brief Number of time tiles */
constexpr int TT = T / TP;

/** @brief Channel dimension size */
constexpr int C = 2560;
/** @brief Channel parallelism */
constexpr int CP = G;
/** @brief Number of channel tiles */
constexpr int CT = C / CP;

/** @brief Total number of elements in the input/output arrays */
constexpr int NUM_X = T * C;
/** @brief Total number of elements in the output data arrays */
constexpr int NUM_OD = T * C;

/** @brief Data type for the largest accumulated value */
typedef X_T data_t;


/**
 * @brief Top-level function for the residual multiplexer module.
 *
 * Processes input streams, writes to residual output streams, adds residual input streams to the buffer,
 * and produces final output streams for multiple layers.
 *
 * @param l_begin Starting layer index.
 * @param l_close Ending layer index (exclusive).
 * @param x_stream Input stream of data with TP*CP parallelism.
 * @param res_i_stream Residual input stream with CP parallelism.
 * @param res_o_stream Residual output stream with TP*CP parallelism.
 * @param y_stream Final output stream with TP*CP parallelism.
 */
void top(
    int l_begin,
    int l_close,
    hls::stream<hls::vector<data_t, TP*CP> >& x_stream,
    // hls::stream<hls::vector<data_t, TP*CP> >& res_i_stream,
    hls::stream<hls::vector<data_t,    CP> >& res_i_stream,
    hls::stream<hls::vector<data_t, TP*CP> >& res_o_stream,
    hls::stream<hls::vector<data_t, TP*CP> >& y_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=x_stream
    #pragma HLS interface axis port=res_i_stream
    #pragma HLS interface axis port=res_o_stream
    #pragma HLS interface axis port=y_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=x_stream         compact=bit
    #pragma HLS aggregate variable=res_i_stream     compact=bit
    #pragma HLS aggregate variable=res_o_stream     compact=bit
    #pragma HLS aggregate variable=y_stream         compact=bit

    /** @brief Buffer for input data, dimensioned as [T][C] */
    data_t x_buf[T][C];
    /**< Cyclically reshape first dimension of x_buf */
    #pragma HLS array_reshape variable=x_buf cyclic factor=TP dim=1 
     /**< Cyclically reshape second dimension of x_buf */
    #pragma HLS array_reshape variable=x_buf cyclic factor=CP dim=2
    /**< Bind x_buf to URAM */
    #pragma HLS bind_storage  variable=x_buf type=RAM_2P impl=URAM

    // for each layer:
    // 1. directly write buffer to residual_o
    // 2. read residual_i, add to buffer

    // first, read x, write to buffer
    // Stage 1: Read input stream and store in buffer
    for(int tt = 0; tt < TT; ++tt) { /**< Iterate over time tiles */
        for(int ct = 0; ct < CT; ++ct) { /**< Iterate over channel tiles */
            #pragma HLS pipeline II=1 /**< Enable pipelining with initiation interval of 1 */
            hls::vector<data_t, TP * CP> vec = x_stream.read(); /**< Read input vector */
            for(int tp = 0; tp < TP; ++tp) { /**< Iterate over time parallelism */
                for(int cp = 0; cp < CP; ++cp) { /**< Iterate over channel parallelism */
                    #pragma HLS unroll /**< Unroll loop for parallel processing */
                    x_buf[tt * TP + tp][ct * CP + cp] = vec[tp * CP + cp]; /**< Store input data in buffer */
                }
            }
        }
    }

    //// Stage 2: Process each layer: adjust the data input order, since OD is unpacked
    for(int l=l_begin; l<l_close; ++l){
        // write buffer to residual_o directly
        for(int tt=0; tt<TT; ++tt){
            for(int ct=0; ct<CT; ++ct){
                #pragma HLS pipeline II=1
                hls::vector<data_t, TP*CP> vec;
                for(int tp=0; tp<TP; ++tp){
                    for(int cp=0; cp<CP; ++cp){
                        #pragma HLS unroll
                        vec[tp*CP + cp] = x_buf[tt*TP + tp][ct*CP + cp];
                    }
                }
                res_o_stream.write(vec);
            }
        }
        // read residual_i, add to buffer, with order adjustment
        // Read residual input and add to buffer
        for(int ct=0; ct<CT; ++ct){
            for(int tt=0; tt<TT; ++tt){
                #pragma HLS pipeline II=1
                // declare vec
                hls::vector<data_t, TP*CP> vec_i;
                hls::vector<data_t, TP*CP> vec_buf;
                // read unpacked tokens
                for(int tp=0; tp<TP; ++tp){
                    hls::vector<data_t, CP> vec_cp = res_i_stream.read();
                    for(int cp=0; cp<CP; ++cp){
                        vec_i[tp*CP + cp] = vec_cp[cp];
                    }
                }
                // read from buffer
                for(int tp=0; tp<TP; ++tp){
                    for(int cp=0; cp<CP; ++cp){
                        vec_buf[tp*CP + cp] = x_buf[tt*TP + tp][ct*CP + cp];
                    }
                }
                // add to buffer
                for(int tp=0; tp<TP; ++tp){
                    for(int cp=0; cp<CP; ++cp){
                        x_buf[tt*TP + tp][ct*CP + cp] = vec_i[tp*CP + cp] + vec_buf[tp*CP + cp];
                    }
                }
            }
        }
    }

     // Stage 3: Write buffer to final output stream
    for(int tt=0; tt<TT; ++tt){
        for(int ct=0; ct<CT; ++ct){
            #pragma HLS pipeline II=1
            hls::vector<data_t, TP*CP> vec; /**< Output vector */
            for(int tp=0; tp<TP; ++tp){
                 /**< Iterate over channel parallelism */
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll /**< Unroll loop for parallel processing */
                     /**< Copy buffer data to output vector */
                    vec[tp*CP + cp] = x_buf[tt*TP + tp][ct*CP + cp];
                }
            }
             /**< Write to final output stream */
            y_stream.write(vec);
        }
    }
}

// Reference and DUT data declarations
// declare the refs
int64_t REF_MAMBA_X         [L*T*C];
int64_t REF_MHA_O_RES       [L*T*C];
int64_t REF_XD_RES          [L*T*C];
// declare the ref input
int64_t REF_X               [  T*C];
// delcare the ref output
int64_t REF_Y               [  T*C];
int64_t REF_RESIDUAL_O      [L*T*C];
// declare the ref residual
int64_t DUT_Y               [  T*C];
int64_t DUT_RESIDUAL_O      [L*T*C];

// //* declare the condensed input
int64_t REF_CONDENSED_OD    [L*NUM_X];

// declare the ref input
/**
 * @brief Test function for multiple layers of the residual multiplexer.
 *
 * Loads reference data, creates input streams, runs the residual multiplexer operation, and compares
 * the output against reference data for the specified layer range.
 *
 * @tparam l_begin Starting layer index.
 * @tparam l_close Ending layer index (exclusive).
 */
template<int l_begin, int l_close>
void test_multi_layer(){
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    for(int l=l_begin; l<l_close; ++l){
        string file_path_suffix      = to_string(l) + ".bin";
        // read results
        auto MAMBA_X          = read_tensor<int64_t> (file_path + "/before_rms1_layer" + file_path_suffix);
        auto XD_RES           = read_tensor<int64_t> (file_path + "/output_layer" + file_path_suffix);

        //* read condensed input
        auto CONDENSED_OD   = read_tensor<int64_t> (file_path + "/out_proj_layer" + file_path_suffix);

        // put input into ref
        tensor2array<int64_t>(  MAMBA_X,        REF_MAMBA_X         + l*T*C,    1,      1,      T_LOAD, T,      C,      C    );
        tensor2array<int64_t>(  XD_RES,         REF_XD_RES          + l*T*C,    1,      1,      T_LOAD, T,      C,      C    );

        // put condensed input into ref
        tensor2array<int64_t>(  CONDENSED_OD,   REF_CONDENSED_OD    + l*T*C,    1,      1,      T_LOAD, 1,      NUM_X, NUM_X);

        //// Verify coherence of input data
        for(int t=0; t<T; ++t){
            for(int c=0; c<C; ++c){
                // MHA_X + MHA_O -> MLP_X
                /**< Check input coherence */
                assert(REF_MAMBA_X[l*T*C + t*C + c] + REF_CONDENSED_OD[l*T*C + t*C + c] == REF_XD_RES     [l*T*C + t*C + c]);
            }
        }

        //  // Set residual output reference
        for(int t=0; t<T; ++t){
            for(int c=0; c<C; ++c){
                REF_RESIDUAL_O[l*T*C + t*C + c] = REF_MAMBA_X[l*T*C + t*C + c];
            }
        }

        // Set input reference for the first layer
        if(l == l_begin){
            for(int t=0; t<T; ++t){
                for(int c=0; c<C; ++c){
                    // put first layer's MHA_X into the ref input
                    REF_X[t*C + c] = REF_MAMBA_X[l*T*C + t*C + c];
                }
            }
        }
         // Set output reference for the last layer
        if(l == l_close - 1){
            for(int t=0; t<T; ++t){
                for(int c=0; c<C; ++c){
                    // put last layer's MLP_XD_RES into the ref output
                    REF_Y[t*C + c] = REF_XD_RES[l*T*C + t*C + c];
                }
            }
        }
    }



    // create streams
    hls::stream<hls::vector<data_t, TP*CP> > x_stream       ("X");
    hls::stream<hls::vector<data_t,    CP> > res_i_stream   ("RESIDUAL I");
    hls::stream<hls::vector<data_t, TP*CP> > res_o_stream   ("RESIDUAL O");
    hls::stream<hls::vector<data_t, TP*CP> > y_stream       ("Y");

    // stream in
    array2stream<int64_t, data_t, 1, 1, T, TP, C, CP>(REF_X,     x_stream,     "X",            true);

    // use condensed input instead
    array2stream<int64_t, data_t, 1, 1, 1, 1, (l_close-l_begin)*NUM_X, CP>(REF_CONDENSED_OD + l_begin*NUM_X, res_i_stream, "CONDENSED OD", true);

    // call top function
    top(l_begin, l_close, x_stream, res_i_stream, res_o_stream, y_stream);

    // Read output streams into arrays
    stream2array<int64_t, data_t, 1,                 T, TP, C, CP>(y_stream,     DUT_Y,          "Y",          true);
    stream2array<int64_t, data_t, (l_close-l_begin), T, TP, C, CP>(res_o_stream, DUT_RESIDUAL_O, "RESIDUAL O", true);

     // Compare outputs with reference
    compare<int64_t>(REF_Y                       ,          DUT_Y,                                  T*C, "Y"       );
    compare<int64_t>(REF_RESIDUAL_O + l_begin*T*C,          DUT_RESIDUAL_O,       (l_close-l_begin)*T*C, "RESIDUAL");

    // Verify that streams are empty
    assert(x_stream.empty());
    assert(res_i_stream.empty());
    assert(res_o_stream.empty());
    assert(y_stream.empty());
}

/**
 * @brief Main function to run tests for a single layer.
 *
 * Calls the test function for a single layer range (0 to 1).
 * @return 0 on successful completion.
 */
int main(){

    // test_multi_layer(0, L_TEST);
    // test_multi_layer<0, L_TEST>();
    // test single layer
    test_multi_layer<0, 1>();
    
    return 0;
}
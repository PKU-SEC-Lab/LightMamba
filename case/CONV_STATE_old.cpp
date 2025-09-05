/**
 * 
 * @brief Multiplexer module for residual connections in the Llama model with testbench.
 *
 */

#include "../src/common.h"
#include "../src/utils.h"


// This module is the mux for RESIDUAL

// hyperparameters
/** @brief Group size for parallelism */
constexpr int G         = 8;

//* actual size
//* scale down
// constexpr int L         = 2;

constexpr int TEST_L    = 2;

constexpr int T_LOAD    = 512;  // saved seq length
constexpr int T         = 1;
constexpr int TP        = 1;
constexpr int TT        = T / TP;

constexpr int C         = 5376;
constexpr int CP        = G;
constexpr int CT        = C / CP;
constexpr int D         = 4;

constexpr int STATE_P        = 32;
constexpr int STATE_P_S      = 64;

constexpr int ST        = D*C / STATE_P;
constexpr int ST_S      = D*CT / STATE_P_S;

// calculate total number of X
constexpr int NUM_X     = T*C;
constexpr int NUM_OD    = T*C;

// dtypes: X_T
// Type definitions
typedef A_T data_t;    
typedef AS_T data_s_t;    
/**
 * @brief Top-level function for the residual multiplexer module.
 *
 * Processes convolution and input streams, buffers state data, and produces output streams.
 * @param conv_stream Input stream of convolution data with STATE_P parallelism.
 * @param conv_s_stream Input stream of convolution scale data with STATE_P_S parallelism.
 * @param xBC_stream Input stream of xBC data with CP parallelism.
 * @param xBC_s_stream Input stream of xBC scale data with single element vectors.
 * @param o_stream Output stream of processed data with CP parallelism.
 * @param o_s_stream Output stream of scale data with single element vectors.
 * @param conv_state_stream Output stream of convolution state data with STATE_P parallelism.
 * @param conv_state_s_stream Output stream of convolution scale state data with STATE_P_S parallelism.
 */  
void top(
    hls::stream<hls::vector<data_t, STATE_P> >& conv_stream,
    hls::stream<hls::vector<data_s_t, STATE_P_S> >& conv_s_stream,
    hls::stream<hls::vector<data_t, CP> >& xBC_stream,
    hls::stream<hls::vector<data_s_t, 1> >& xBC_s_stream,
    hls::stream<hls::vector<data_t, CP> >& o_stream,
    hls::stream<hls::vector<data_s_t, 1> >& o_s_stream,
    hls::stream<hls::vector<data_t, STATE_P> >& conv_state_stream,
    hls::stream<hls::vector<data_s_t, STATE_P_S> >& conv_state_s_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=conv_stream
    #pragma HLS interface axis port=conv_s_stream
    #pragma HLS interface axis port=xBC_stream
    #pragma HLS interface axis port=xBC_s_stream
    #pragma HLS interface axis port=o_stream
    #pragma HLS interface axis port=o_s_stream
    #pragma HLS interface axis port=conv_state_stream
    #pragma HLS interface axis port=conv_state_s_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=conv_stream             compact=bit
    #pragma HLS aggregate variable=conv_s_stream           compact=bit
    #pragma HLS aggregate variable=xBC_stream              compact=bit
    #pragma HLS aggregate variable=xBC_s_stream            compact=bit
    #pragma HLS aggregate variable=o_stream                compact=bit
    #pragma HLS aggregate variable=o_s_stream              compact=bit
    #pragma HLS aggregate variable=conv_state_stream       compact=bit
    #pragma HLS aggregate variable=conv_state_s_stream     compact=bit
// Declare buffers for convolution state data
    data_t conv_state_buf[D*C];
    data_s_t conv_state_s_buf[D*CT];
    #pragma HLS array_reshape variable=conv_state_buf cyclic factor=STATE_P
    #pragma HLS array_reshape variable=conv_state_s_buf cyclic factor=STATE_P_S
    #pragma HLS bind_storage  variable=conv_state_buf type=RAM_2P impl=URAM
    #pragma HLS bind_storage  variable=conv_state_s_buf type=RAM_2P impl=URAM

    // for each layer:
     // Read and buffer convolution state data

    for(int ct=0; ct<ST; ++ct){
        #pragma HLS pipeline II=1
        hls::vector<data_t, STATE_P> vec = conv_stream.read();
        for(int cp=0; cp<STATE_P; ++cp){
            #pragma HLS unroll
            conv_state_buf[ct*STATE_P+cp] = vec[cp];
        }
    }
    // Read and buffer convolution scale state data
    for(int ct=0; ct<ST_S; ++ct){
        #pragma HLS pipeline II=1
        hls::vector<data_s_t, STATE_P_S> vec = conv_s_stream.read();
        for(int cp=0; cp<STATE_P_S; ++cp){
            #pragma HLS unroll
            conv_state_s_buf[ct*STATE_P_S+cp] = vec[cp];
        }
    }

    // read residual_i, add to buffer, with order adjustment
    // Process residual input, add to buffer, and produce output
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<D; ++d){
            #pragma HLS pipeline II=1
            hls::vector<data_t, CP> o_vec;
            hls::vector<data_s_t, 1> os_vec;
            if(d<D-1) {
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    o_vec[cp] = conv_state_buf[ct*D*CP+d*CP+cp];
                    os_vec[0] = conv_state_s_buf[ct*D+d];
                }
            }
            else {
                hls::vector<data_t, CP> i_vec = xBC_stream.read();
                hls::vector<data_s_t, 1> is_vec = xBC_s_stream.read();
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    conv_state_buf[ct*D*CP+(D-1)*CP+cp] = i_vec[cp];
                    o_vec[cp] = i_vec[cp];
                    conv_state_s_buf[ct*D+(D-1)] = is_vec[0];
                    os_vec[0] = is_vec[0];
                }
            }
            o_stream.write(o_vec);
            o_s_stream.write(os_vec);

        }
    }

// Write convolution state data to output stream
    for(int ct=0; ct<ST; ++ct){
        #pragma HLS pipeline II=1
        hls::vector<data_t, STATE_P> vec;
        for(int cp=0; cp<STATE_P; ++cp){
            #pragma HLS unroll
            vec[cp] = conv_state_buf[ct*STATE_P+cp];
        }
        conv_state_stream.write(vec);
    }
    // Write convolution scale state data to output stream
    for(int ct=0; ct<ST_S; ++ct){
        #pragma HLS pipeline II=1
        hls::vector<data_s_t, STATE_P_S> vec;
        for(int cp=0; cp<STATE_P_S; ++cp){
            #pragma HLS unroll
            vec[cp] = conv_state_s_buf[ct*STATE_P_S+cp];
        }
        conv_state_s_stream.write(vec);
    }
}

// Reference and DUT data declarations
/** @brief Reference input quantized data for xBC */
int64_t  REF_XBC_Q               [D*C ];
/** @brief Reference input scale data for xBC */
int64_t  REF_XBC_S               [D*CT];
/** @brief DUT output data */
int64_t  DUT_O                   [D*C ];
/** @brief DUT output scale data */
int64_t  DUT_O_S                 [D*CT];
/** @brief DUT convolution state data */
int64_t  DUT_CONV                [D*C ];
/** @brief DUT convolution scale state data */
int64_t  DUT_CONV_S              [D*CT];
/**
 * @brief Test function for a single residual multiplexer layer.
 *
 * Loads reference data, creates input streams, runs the top function, and compares outputs.
 * @param l Layer index to test.
 */

void test_layer(int l){
    // l now is the order of decoder, not sub layer
    // Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs, both MHA and MLP
// Read input reference tensors
    auto XBC_Q              = read_tensor<int64_t>(file_path + "/xBC_q_layer" + file_path_suffix);
    auto XBC_S              = read_tensor<int64_t>(file_path + "/xBC_s_layer" + file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t>(XBC_Q,    REF_XBC_Q,          1, 1, T_LOAD, 4, C, C);
    tensor2array<int64_t>(XBC_S,    REF_XBC_S,          1, 1, T_LOAD, 4, CT,CT);

    // create streams
    // Create input and output streams
    hls::stream<hls::vector<data_t, STATE_P>  > conv_stream;
    hls::stream<hls::vector<data_s_t, STATE_P_S> > conv_s_stream;
    hls::stream<hls::vector<data_t, CP>  > xBC_stream;
    hls::stream<hls::vector<data_s_t, 1> > xBC_s_stream;
    hls::stream<hls::vector<data_t, CP>  > o_stream;
    hls::stream<hls::vector<data_s_t, 1> > o_s_stream;
    hls::stream<hls::vector<data_t, STATE_P>  > conv_state_stream;
    hls::stream<hls::vector<data_s_t, STATE_P_S> > conv_state_s_stream;

    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    ProgressBar progress_bar("CONV_STATE_IN", 1);
    progress_bar.start();
    // update the progress bar
     // Populate convolution state input stream
    progress_bar.update(1);
    for(int ct=0; ct<ST; ++ct){
        hls::vector<data_t, STATE_P> vec;
        for(int cp=0; cp<STATE_P; ++cp){
            int index=ct*STATE_P+cp;//index=d*CT*CP+ct*CP+cp  index=ct*D*CP+d*CP+cp
            int d2=index/CP%D;//ct*D+d   d
            int ct2=index/CP/D;//ct*D+d   ct
            int cp2=index%CP;//cp
            vec[cp] = REF_XBC_Q[d2*C+ct2*CP+cp2];
        }
        conv_stream.write(vec);
    }
    ProgressBar progress_bar2("CONV_STATE_S_IN", 1);
    progress_bar2.start();
    // update the progress bar
    progress_bar2.update(1);
    // Populate convolution scale state input stream
    for(int ct=0; ct<ST_S; ++ct){
        hls::vector<data_s_t, STATE_P_S> vec;
        for(int cp=0; cp<STATE_P_S; ++cp){
            int index=ct*STATE_P_S+cp;//index=d*CT+ct  index=ct*D+d
            int d2=index%D;
            int ct2=index/D;
            vec[cp] = REF_XBC_S[d2*CT+ct2];
        }
        conv_s_stream.write(vec);
    }
    ProgressBar progress_bar3("XBC_Q_IN", 1);
    progress_bar3.start();
    // update the progress bar
    progress_bar3.update(1);
    for(int ct=0; ct<CT; ++ct){
        // write the data to stream
        // Populate xBC input stream
        hls::vector<data_t, CP> vec;
        for(int cp=0; cp<CP; ++cp){
            vec[cp] = REF_XBC_Q[3*C+ct*CP+cp];
        }
        xBC_stream.write(vec);
        
    }
    ProgressBar progress_bar4("XBC_S_IN", 1);
    progress_bar4.start();
    // update the progress bar
    progress_bar4.update(1);
    // Populate xBC scale input stream
    for(int ct=0; ct<CT; ++ct){
        // write the data to stream
        hls::vector<data_s_t, 1> vec;
        vec[0] = REF_XBC_S[3*CT+ct];
        xBC_s_stream.write(vec);
    }

    // call top function
    top(conv_stream, conv_s_stream, xBC_stream, xBC_s_stream, o_stream, o_s_stream, conv_state_stream, conv_state_s_stream);
    // Read output streams into arrays
    stream2array<int64_t, data_t, 1, D, 1, C,  CP>(o_stream, DUT_O, "O", true);
    stream2array<int64_t, data_s_t, 1, D, 1, CT,  1>(o_s_stream, DUT_O_S, "OS", true);
    stream2array<int64_t, data_t, 1, 1, 1, D*C,  STATE_P>(conv_state_stream, DUT_CONV, "CONV", true);
    stream2array<int64_t, data_s_t, 1, 1, 1, D*CT,  STATE_P_S>(conv_state_s_stream, DUT_CONV_S, "CONV_S", true);

    // Verify that streams are empty
    assert(conv_stream.empty());
    assert(conv_s_stream.empty());
    assert(xBC_stream.empty());
    assert(xBC_s_stream.empty());
    assert(o_stream.empty());
    assert(o_s_stream.empty());
    assert(conv_state_stream.empty());
    assert(conv_state_s_stream.empty());

    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
     // Compare convolution scale state data with reference
    string info="O";
    bool match = true;
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<D; ++d){
            for(int cp=0; cp<CP; ++cp){
                if(REF_XBC_Q[d*C+ct*CP+cp] != DUT_O[ct*D*CP+d*CP+cp]){
                    printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(),ct*D*CP+d*CP+cp, REF_XBC_Q[d*C+ct*CP+cp], DUT_O[ct*D*CP+d*CP+cp]);
                    match = false;
                }
            }
        }
    }
    if(match){
    } else {
        printf("%s mismatch\n", info.c_str());
    }
     // Compare convolution scale state data with reference
    info="O_S";
    match = true;
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<D; ++d){
            if(REF_XBC_S[d*CT+ct] != DUT_O_S[ct*D+d]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(), ct*D+d, REF_XBC_S[d*CT+ct], DUT_O_S[ct*D+d]);
                match = false;
            }
        }
    }
    if(match){
    } else {
        printf("%s mismatch\n", info.c_str());
    }
     // Compare convolution scale state data with reference
    info="CONV";
    match = true;
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<D-1; ++d){
            for(int cp=0; cp<CP; ++cp){
                if(REF_XBC_Q[(d+1)*C+ct*CP+cp] != DUT_CONV[ct*D*CP+(d+1)*CP+cp]){
                    printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(), ct*3*CP+d*CP+cp, REF_XBC_Q[(d+1)*C+ct*CP+cp], DUT_CONV[ct*D*CP+(d+1)*CP+cp]);
                    match = false;
                }
            }
        }
    }
    if(match){
    } else {
        printf("%s mismatch\n", info.c_str());
    }
     // Compare convolution scale state data with reference
    info="CONV_S";
    match = true;
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<D-1; ++d){
            if(REF_XBC_S[(d+1)*CT+ct] != DUT_CONV_S[ct*D+(d+1)]){
                printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(), ct*3+d, REF_XBC_S[(d+1)*CT+ct], DUT_CONV_S[ct*D+(d+1)]);
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
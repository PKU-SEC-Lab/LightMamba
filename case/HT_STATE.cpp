 /**
 * This module tests the residual multiplexer operation by loading reference data, creating input streams,
 * processing the streams through a top-level function, and comparing the output against reference data.
 * The implementation is optimized for HLS with stream interfaces and array reshaping.
 */

#include "../src/common.h"
#include "../src/utils.h"


// This module is the mux for RESIDUAL

// hyperparameters
/** @brief Group size for processing */
constexpr int G         = 8;

//* actual size
//* scale down
// constexpr int L         = 2;
/** @brief Number of test layers */
constexpr int TEST_L    = 2;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD    = 512;  // saved seq length
/** @brief Sequence length for processing */
constexpr int T         = 1;
/** @brief Time parallelism for input streams */
constexpr int TP        = 1;
/** @brief Number of time tiles */
constexpr int TT        = T / TP;

/** @brief Channel dimension size */
constexpr int C = 5120;
/** @brief Channel parallelism */
constexpr int CP = G;
/** @brief Hidden dimension size */
constexpr int N = 128;
/** @brief Hidden dimension parallelism */
constexpr int NP = G;
/** @brief Number of channel tiles */
constexpr int CT = C / CP;
/** @brief Half of hidden dimension parallelism */
constexpr int NP2 = NP / 2;
/** @brief Number of hidden dimension tiles */
constexpr int NT2 = N / NP;
/** @brief Number of hidden dimension tiles for NP2 */
constexpr int NTT = N / NP2;
/** @brief Number of channel tiles for scale data */
constexpr int CTT = CT / CP;

/** @brief Data type for input and output vectors */
typedef A_T data_t;
/** @brief Data type for scale vectors */
typedef AS_T data_s_t;


/**
 * @brief Top-level function for the residual multiplexer module.
 *
 * Processes input state and ht streams, buffers them, performs residual addition, and produces
 * output state and ht streams. The implementation uses dataflow and array reshaping for HLS optimization.
 *
 * @param state_in_stream Input stream of state data with NP2*CP parallelism.
 * @param state_in_s_stream Input stream of state scale data with NP*CP parallelism.
 * @param ht_in_stream Input stream of ht data with CP parallelism.
 * @param ht_in_s_stream Input stream of ht scale data with single element vectors.
 * @param ht_out_stream Output stream of ht data with CP parallelism.
 * @param ht_out_s_stream Output stream of ht scale data with single element vectors.
 * @param state_out_stream Output stream of state data with NP2*CP parallelism.
 * @param state_out_s_stream Output stream of state scale data with NP*CP parallelism.
 */
void top(
    hls::stream<hls::vector<data_t, NP2*CP> >& state_in_stream,
    hls::stream<hls::vector<data_s_t, NP*CP> >& state_in_s_stream,
    hls::stream<hls::vector<data_t, CP> >& ht_in_stream,
    hls::stream<hls::vector<data_s_t, 1> >& ht_in_s_stream,
    hls::stream<hls::vector<data_t, CP> >& ht_out_stream,
    hls::stream<hls::vector<data_s_t, 1> >& ht_out_s_stream,
    hls::stream<hls::vector<data_t, NP2*CP> >& state_out_stream,
    hls::stream<hls::vector<data_s_t, NP*CP> >& state_out_s_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=state_in_stream
    #pragma HLS interface axis port=state_in_s_stream
    #pragma HLS interface axis port=ht_in_stream
    #pragma HLS interface axis port=ht_in_s_stream
    #pragma HLS interface axis port=ht_out_stream
    #pragma HLS interface axis port=ht_out_s_stream
    #pragma HLS interface axis port=state_out_stream
    #pragma HLS interface axis port=state_out_s_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=state_in_stream        compact=bit
    #pragma HLS aggregate variable=state_in_s_stream      compact=bit
    #pragma HLS aggregate variable=ht_in_stream           compact=bit
    #pragma HLS aggregate variable=ht_in_s_stream         compact=bit
    #pragma HLS aggregate variable=ht_out_stream          compact=bit
    #pragma HLS aggregate variable=ht_out_s_stream        compact=bit
    #pragma HLS aggregate variable=state_out_stream       compact=bit
    #pragma HLS aggregate variable=state_out_s_stream     compact=bit
 // Buffer for state data
    data_t ht_state_buf[N][C];
    // Buffer for state scale data
    data_s_t ht_state_s_buf[N][CT];
    #pragma HLS array_reshape variable=ht_state_buf cyclic factor=NP2 dim=1
    #pragma HLS array_reshape variable=ht_state_buf cyclic factor=CP dim=2
    #pragma HLS bind_storage  variable=ht_state_buf type=RAM_2P impl=URAM

    #pragma HLS array_reshape variable=ht_state_s_buf cyclic factor=NP dim=1
    #pragma HLS array_reshape variable=ht_state_s_buf cyclic factor=CP dim=2
    #pragma HLS bind_storage  variable=ht_state_s_buf type=RAM_2P impl=URAM

    // Read and buffer state input stream
    for(int ct=0; ct<CT; ++ct){
        for(int nt=0; nt<NTT; ++nt){
            #pragma HLS pipeline II=1
            hls::vector<data_t, NP2*CP> vec = state_in_stream.read();
            for(int np=0; np<NP2; ++np){
                #pragma HLS unroll
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    ht_state_buf[nt*NP2+np][ct*CP+cp] = vec[np*CP+cp];
                }
            }
        }
    }
    // Read and buffer state scale input stream
    for(int ct=0; ct<CTT; ++ct){
        for(int nt=0; nt<NT2; ++nt){
            #pragma HLS pipeline II=1
            hls::vector<data_s_t, NP*CP> vec = state_in_s_stream.read();
            for(int np=0; np<NP; ++np){
                #pragma HLS unroll
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    ht_state_s_buf[nt*NP+np][ct*CP+cp] = vec[np*CP+cp];
                }
            }
        }
    }


    // read residual_i, add to buffer, with order adjustment
    // Process residual input, add to buffer, and produce ht output
    for(int ct=0; ct<CT; ++ct){
        for(int r=0; r<2; ++r){
            for(int nt=0; nt<NT2; ++nt){
                for(int np=0; np<NP; ++np){
                    #pragma HLS pipeline II=1
                    if(r==0) {
                        hls::vector<data_t, CP> o_vec;
                        hls::vector<data_s_t, 1> os_vec;
                        os_vec[0]=ht_state_s_buf[nt*NP+np][ct];
                        for(int cp=0; cp<CP; ++cp){
                            #pragma HLS unroll
                            o_vec[cp] = ht_state_buf[nt*NP+np][ct*CP+cp];
                        }
                        ht_out_stream.write(o_vec);
                        ht_out_s_stream.write(os_vec);
                    }
                    else {
                        hls::vector<data_t, CP> i_vec=ht_in_stream.read();
                        hls::vector<data_s_t, 1> is_vec=ht_in_s_stream.read();
                        ht_state_s_buf[nt*NP+np][ct]=is_vec[0];
                        for(int cp=0; cp<CP; ++cp){
                            #pragma HLS unroll
                            ht_state_buf[nt*NP+np][ct*CP+cp] = i_vec[cp];
                        }
                    }
                }
            }
        }
    }

     // Write buffered state data to output stream
    for(int ct=0; ct<CT; ++ct){
        for(int nt=0; nt<NTT; ++nt){
            #pragma HLS pipeline II=1
            hls::vector<data_t, NP2*CP> vec;
            for(int np=0; np<NP2; ++np){
                #pragma HLS unroll
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    vec[np*CP+cp] = ht_state_buf[nt*NP2+np][ct*CP+cp];
                }
            }
            state_out_stream.write(vec);
        }
    }
 // Write buffered state scale data to output stream
    for(int ct=0; ct<CTT; ++ct){
        for(int nt=0; nt<NT2; ++nt){
            #pragma HLS pipeline II=1
            hls::vector<data_s_t, NP*CP> vec;
            for(int np=0; np<NP; ++np){
                #pragma HLS unroll
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    vec[np*CP+cp] = ht_state_s_buf[nt*NP+np][ct*CP+cp];
                }
            }
            state_out_s_stream.write(vec);
        }
    }

}

// Reference and DUT data declarations
int64_t  REF_HT1_Q               [N*C];
int64_t  REF_HT1_S               [N*CT];
int64_t  REF_HT2_Q               [N*C];
int64_t  REF_HT2_S               [N*CT];

int64_t  DUT_HT1_Q               [N*C ];
int64_t  DUT_HT1_S               [N*CT];
int64_t  DUT_HT2_Q               [N*C ];
int64_t  DUT_HT2_S               [N*CT];
/**
 * @brief Test function for a single residual multiplexer layer.
 *
 * Loads reference data, creates input streams, runs the residual multiplexer operation, and compares
 * the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs, both MHA and MLP

    auto HT1_Q              = read_tensor<int64_t>(file_path + "/ht1_q0_layer" + file_path_suffix);
    auto HT1_S              = read_tensor<int64_t>(file_path + "/ht1_s0_layer" + file_path_suffix);
    auto HT2_Q              = read_tensor<int64_t>(file_path + "/ht1_q1_layer" + file_path_suffix);
    auto HT2_S              = read_tensor<int64_t>(file_path + "/ht1_s1_layer" + file_path_suffix);
 // Convert tensors to arrays
    tensor2array<int64_t>(HT1_Q,    REF_HT1_Q,          1, 1, T, T, N*C, N*C);
    tensor2array<int64_t>(HT1_S,    REF_HT1_S,          1, 1, T, T, N*CT,N*CT);
    tensor2array<int64_t>(HT2_Q,    REF_HT2_Q,          1, 1, T, T, N*C, N*C);
    tensor2array<int64_t>(HT2_S,    REF_HT2_S,          1, 1, T, T, N*CT,N*CT);

     // Create input and output streams
    hls::stream<hls::vector<data_t, NP2*CP>  > state_in_stream;
    hls::stream<hls::vector<data_s_t, NP*CP> > state_in_s_stream;
    hls::stream<hls::vector<data_t, CP>  > ht_in_stream;
    hls::stream<hls::vector<data_s_t, 1> > ht_in_s_stream;
    hls::stream<hls::vector<data_t, CP>  > ht_out_stream;
    hls::stream<hls::vector<data_s_t, 1> > ht_out_s_stream;
    hls::stream<hls::vector<data_t, NP2*CP>  > state_out_stream;
    hls::stream<hls::vector<data_s_t, NP*CP> > state_out_s_stream;

    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    ProgressBar progress_bar("STATE_IN", 1);
    progress_bar.start();
    // update the progress bar
    progress_bar.update(1);
    for(int ct=0; ct<CT; ++ct){
        for(int nt=0; nt<NTT; ++nt){
            hls::vector<data_t, NP2*CP> vec;
            for(int np=0; np<NP2; ++np){
                for(int cp=0; cp<CP; ++cp){
                    vec[np*CP+cp] = REF_HT1_Q[ct*N*CP+(nt*NP2+np)*CP+cp]; 
                }
            }
            state_in_stream.write(vec);
        }
    }
    ProgressBar progress_bar2("STATE_IN_S", 1);
    progress_bar2.start();
    // update the progress bar
    progress_bar2.update(1);
    for(int ct=0; ct<CTT; ++ct){
        for(int nt=0; nt<NT2; ++nt){
            hls::vector<data_s_t, NP*CP> vec;
            for(int np=0; np<NP; ++np){
                for(int cp=0; cp<CP; ++cp){
                    vec[np*CP+cp] = REF_HT1_S[(ct*CP+cp)*N+nt*NP+np]; 
                }
            }
            state_in_s_stream.write(vec);
        }
    }
    array2stream<int64_t, A_T, 1, 1, T, TP, C*N, CP>(REF_HT2_Q, ht_in_stream, "HT_IN_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT*N, 1>(REF_HT2_S, ht_in_s_stream, "HT_IN_S", true);

    // call top function
    top(state_in_stream, state_in_s_stream, ht_in_stream, ht_in_s_stream, ht_out_stream, ht_out_s_stream, state_out_stream, state_out_s_stream);

    // Read output streams into arrays
    stream2array<int64_t, data_t, 1, T, TP, C*N,  CP>(ht_out_stream, DUT_HT1_Q, "HT_OUT_Q", true);
    stream2array<int64_t, data_s_t, 1, T, TP, CT*N,  1>(ht_out_s_stream, DUT_HT1_S, "HT_OUT_S", true);
    ProgressBar progress_bar3("STATE_OPUT", 1);
    progress_bar3.start();
    // update the progress bar
    progress_bar3.update(1);
    for(int ct=0; ct<CT; ++ct){
        for(int nt=0; nt<NTT; ++nt){
            hls::vector<data_t, NP2*CP> vec=state_out_stream.read();
            for(int np=0; np<NP2; ++np){
                for(int cp=0; cp<CP; ++cp){
                    DUT_HT2_Q[ct*N*CP+(nt*NP2+np)*CP+cp] = vec[np*CP+cp]; 
                }
            }
        }
    }
    ProgressBar progress_bar4("STATE_OUT_S", 1);
    progress_bar4.start();
    // update the progress bar
    progress_bar4.update(1);
    for(int ct=0; ct<CTT; ++ct){
        for(int nt=0; nt<NT2; ++nt){
            hls::vector<data_s_t, NP*CP> vec=state_out_s_stream.read();
            for(int np=0; np<NP; ++np){
                for(int cp=0; cp<CP; ++cp){
                    DUT_HT2_S[(ct*CP+cp)*N+nt*NP+np] = vec[np*CP+cp]; 
                }
            }
        }
    }

    // Verify that streams are empty
    assert(state_in_stream.empty());
    assert(state_in_s_stream.empty());
    assert(ht_in_stream.empty());
    assert(ht_in_s_stream.empty());
    assert(ht_out_stream.empty());
    assert(ht_out_s_stream.empty());
    assert(state_out_stream.empty());
    assert(state_out_s_stream.empty());

    // Compare outputs with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_HT1_Q, DUT_HT1_Q, T*C*N, "HT_OUT_Q");
    compare<int64_t>(REF_HT1_S, DUT_HT1_S, T*CT*N, "HT_OUT_S");
    compare<int64_t>(REF_HT2_Q, DUT_HT2_Q, T*C*N, "STATE_OUT");
    compare<int64_t>(REF_HT2_S, DUT_HT2_S, T*CT*N, "STATE_OUT_S");
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
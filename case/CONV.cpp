/**
 * @file CONV.cpp
 * @brief Testbench for quantized convolution module using HLS streams.
 */
#include "../src/common.h"
#include "../src/conv_step_0.h"

#include <pthread.h>
/// Number of layers to test
constexpr int TEST_L    = 2;

// instanciate the RMSNORM inst
/// Input sequence length (load size for saved tensors)
constexpr int T_LOAD    = 512;         // saved seq length, since T is in the inner loop

// actual size
constexpr int T         = 1;
constexpr int TP        = 1;
/// Channel dimensions
constexpr int C         = 5376;
constexpr int CP        = 8;
/// Adjusted channel dimensions for weight transformations
constexpr int C2        = 5120;
constexpr int N         = 128;
constexpr int NT2       = N/CP;
constexpr int C2T       = C2/CP;
/// Instantiate the convolution module
CONV  <64, T, C, CP   > conv_inst(CONV_BIAS,CONV_BIAS_S);
/// Derived constant: number of channel tiles
constexpr int CT = conv_inst.CT;
// Number of elements in the input tensor
constexpr int NUM_X     = T*C;
/**
 * @brief Top function wrapping the convolution operation.
 * 
 * @param l Current layer index.
 * @param i_stream Input data stream.
 * @param s_stream Input scale stream.
 * @param w_stream Weight stream.
 * @param w_s_stream Weight scale stream.
 * @param o_stream Output data stream.
 */

void top(
    int l, 
    hls::stream<hls::vector<A_T,      CP> >& i_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
    hls::stream<hls::vector<WC_T,      CP> >& w_stream,
    hls::stream<hls::vector<AS_T, 1 > >& w_s_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=s_stream
    #pragma HLS interface axis port=w_stream
    #pragma HLS interface axis port=w_s_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=s_stream compact=bit
    #pragma HLS aggregate variable=w_stream compact=bit
    #pragma HLS aggregate variable=w_s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow

    conv_inst  .do_conv   (l, i_stream,   s_stream,w_stream, w_s_stream, o_stream );
}

int64_t  REF_XBC_Q               [4*C ];
int64_t  REF_XBC_S               [4*CT];
int64_t  REF_BCX_Q               [4*C ];
int64_t  REF_BCX_S               [4*CT];
int64_t  REF_CONV                [4*C ];
int64_t  REF_CONV2                [4*C ];
int64_t  DUT_CONV                [T*C ];
int64_t  REF_W_Q               [4*C ];
int64_t  REF_W_S               [4*CT];
int64_t  REF_W2_Q               [4*C ];
int64_t  REF_W2_S               [4*CT];

/**
 * @brief Test a single convolution layer.
 * 
 * @param l Layer index to test.
 */

void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Load reference tensors from file
    auto XBC_Q              = read_tensor<int64_t>(file_path + "/activations/xBC_q_layer" + file_path_suffix);
    auto XBC_S              = read_tensor<int64_t>(file_path + "/activations/xBC_s_layer" + file_path_suffix);
    auto CONV               = read_tensor<int64_t>(file_path + "/activations/xBC_conv_layer" + file_path_suffix);
    auto W_Q              = read_tensor<int64_t>(file_path + "/weights/conv_wq_layer" + file_path_suffix);
    auto W_S              = read_tensor<int64_t>(file_path + "/weights/conv_ws_layer" + file_path_suffix);

     // Flatten reference tensors
    tensor2array<int64_t>(XBC_Q,    REF_XBC_Q,          1, 1, T_LOAD, 4, C, C);
    tensor2array<int64_t>(XBC_S,    REF_XBC_S,          1, 1, T_LOAD, 4, CT,CT);
    tensor2array<int64_t>(CONV,     REF_CONV,           1, 1, T_LOAD, 4, C, C);
    tensor2array<int64_t>(W_Q,    REF_W_Q,          1, 1, 4, 4, C, C);
    tensor2array<int64_t>(W_S,    REF_W_S,          1, 1, 4, 4, CT,CT);

  // Reorder input and weight data for testing
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<4; ++d){
            int ct_cur;
            if(ct<NT2*2) {
                ct_cur=ct+C2T;
            }
            else {
                ct_cur=ct-2*NT2;
            }
            for(int cp=0; cp<CP; ++cp){
                REF_BCX_Q[d*C+ct*CP+cp] = REF_XBC_Q[d*C+ct_cur*CP+cp];
                REF_CONV2[d*C+ct*CP+cp] = REF_CONV[d*C+ct_cur*CP+cp];
                REF_W2_Q[d*C+ct*CP+cp] = REF_W_Q[d*C+ct_cur*CP+cp];
            }
            REF_BCX_S[d*CT+ct] = REF_XBC_S[d*CT+ct_cur];
            REF_W2_S[d*CT+ct] = REF_W_S[d*CT+ct_cur];
        }
    }

    // create streams
    hls::stream<hls::vector<A_T,      CP> > i_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > s_stream;
    hls::stream<hls::vector<WC_T,      CP> > w_stream;
    hls::stream<hls::vector<AS_T, 1 > > w_s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;
 // Stream input data
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    ProgressBar progress_bar("XBC_Q", 1);
    progress_bar.start();
    // update the progress bar
    progress_bar.update(1);
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<4; ++d){
            // write the data to stream
            hls::vector<A_T, CP> vec;
            for(int cp=0; cp<CP; ++cp){
                vec[cp] = REF_BCX_Q[d*C+ct*CP+cp];
            }
            i_stream.write(vec);
        }
    }
    ProgressBar progress_bar2("XBC_S", 1);
    progress_bar2.start();
    // update the progress bar
    progress_bar2.update(1);
    // Stream input scales
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<4; ++d){
            // write the data to stream
            hls::vector<ASCALE_T, 1> vec;
            vec[0] = REF_BCX_S[d*CT+ct];
            s_stream.write(vec);
        }
    }
    ProgressBar progress_bar_w("W_Q", 1);
    progress_bar_w.start();
    // update the progress bar
    progress_bar_w.update(1);
     // Stream weights
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<4; ++d){
            // write the data to stream
            hls::vector<A_T, CP> vec;
            for(int cp=0; cp<CP; ++cp){
                vec[cp] = REF_W2_Q[d*C+ct*CP+cp];
            }
            w_stream.write(vec);
        }
    }
    ProgressBar progress_bar_ws("W_S", 1);
    progress_bar_ws.start();
    // update the progress bar
    progress_bar_ws.update(1);
     // Stream weight scales
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<4; ++d){
            // write the data to stream
            hls::vector<ASCALE_T, 1> vec;
            vec[0] = REF_W2_S[d*CT+ct];
            w_s_stream.write(vec);
        }
    } 


    // call top function
    top(l, i_stream, s_stream, w_stream,w_s_stream,o_stream);
// Extract output
    stream2array<int64_t, X_T, 1, T, TP, C,  CP>(o_stream, DUT_CONV, "CONV", true);
  // Assert streams are drained
    assert(i_stream.empty());
    assert(s_stream.empty());
    assert(w_stream.empty());
    assert(w_s_stream.empty());
    assert(o_stream.empty());

    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    string info="CONV";
    bool match = true;
    // Compare with reference
    for(int i=0; i<C; ++i){
        if(REF_CONV2[3*C+i] != DUT_CONV[i]){
            printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(), i, REF_CONV2[3*C+i], DUT_CONV[i]);
            match = false;
        }
    }
    if(match){
    } else {
        printf("%s mismatch\n", info.c_str());
    }
}
/**
 * @brief Entry point of testbench. Runs all layer tests.
 */

int main(){
    // Layer-by-layer testing
    for(int l=0; l<TEST_L; ++l){
        test_layer(l);
        printf("Test %d passed\n", l);
    }
    return 0;
}
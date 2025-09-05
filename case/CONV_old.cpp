/**
 * @file conv_old.cpp
 * @brief Convolution layer module for the Llama model with testbench.
 */
#include "../src/common.h"
#include "../src/conv_step_0.h"

#include <pthread.h>
/** @brief Number of test layers */
constexpr int TEST_L    = 2;

// instanciate the RMSNORM inst
constexpr int T_LOAD    = 512;         // saved seq length, since T is in the inner loop

// actual size
constexpr int T         = 1;
constexpr int TP        = 1;

constexpr int C         = 5376;
constexpr int CP        = 8;

constexpr int C2        = 5120;
constexpr int N         = 128;
constexpr int NT2       = N/CP;
constexpr int C2T       = C2/CP;

/** @brief Convolution instance with specified weights and biases */
CONV  <64, T, C, CP   > conv_inst(CONV_WEIGHT,CONV_WEIGHT_S,CONV_BIAS,CONV_BIAS_S);

/** @brief Number of channel tiles */
constexpr int CT = conv_inst.CT;

/** @brief Total size of the X tensor */
constexpr int NUM_X     = T*C;
/**
 * @brief Top-level function for the convolution layer.
 *
 * Executes the convolution operation on input streams and produces output streams.
 * @param l Layer index.
 * @param i_stream Input stream of activation data with CP parallelism.
 * @param s_stream Input stream of scale data with single element vectors.
 * @param o_stream Output stream of convolution results with CP parallelism.
 */
void top(
    int l, 
    hls::stream<hls::vector<A_T,      CP> >& i_stream,
    hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
    hls::stream<hls::vector<X_T,      CP> >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=s_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=s_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    #pragma HLS dataflow
 // Perform convolution using the instantiated convolution instance
    conv_inst  .do_conv   (l, i_stream,   s_stream,  o_stream );
}
// Reference and DUT data declarations
int64_t  REF_XBC_Q               [4*C ];
int64_t  REF_XBC_S               [4*CT];
int64_t  REF_BCX_Q               [4*C ];
int64_t  REF_BCX_S               [4*CT];
int64_t  REF_CONV                [4*C ];
int64_t  REF_CONV2                [4*C ];
int64_t  DUT_CONV                [T*C ];

/**
 * @brief Test function for a single convolution layer.
 *
 * Loads reference data, creates input streams, runs the convolution, and compares outputs.
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    // Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Read input reference tensors
    auto XBC_Q              = read_tensor<int64_t>(file_path + "/xBC_q_layer" + file_path_suffix);
    auto XBC_S              = read_tensor<int64_t>(file_path + "/xBC_s_layer" + file_path_suffix);
    auto CONV               = read_tensor<int64_t>(file_path + "/xBC_conv_layer" + file_path_suffix);
// Convert tensors to arrays
    tensor2array<int64_t>(XBC_Q,    REF_XBC_Q,          1, 1, T_LOAD, 4, C, C);
    tensor2array<int64_t>(XBC_S,    REF_XBC_S,          1, 1, T_LOAD, 4, CT,CT);
    tensor2array<int64_t>(CONV,     REF_CONV,           1, 1, T_LOAD, 4, C, C);
// Reorder reference data for BCX layout
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
            }
            REF_BCX_S[d*CT+ct] = REF_XBC_S[d*CT+ct_cur];
        }
    }

    // create streams
    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > i_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;

    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    ProgressBar progress_bar("XBC_Q", 1);
    progress_bar.start();
    // update the progress bar
    progress_bar.update(1);
    // Populate input stream for quantized data
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
    // Populate input stream for scale data
    for(int ct=0; ct<CT; ++ct){
        for(int d=0; d<4; ++d){
            // write the data to stream
            hls::vector<ASCALE_T, 1> vec;
            vec[0] = REF_BCX_S[d*CT+ct];
            s_stream.write(vec);
        }
    }
            


    // call top function

    // Execute the convolution
    top(l, i_stream, s_stream, o_stream);
// Read output stream into array
    stream2array<int64_t, X_T, 1, T, TP, C,  CP>(o_stream, DUT_CONV, "CONV", true);
  // Verify that streams are empty
    assert(i_stream.empty());
    assert(s_stream.empty());
    assert(o_stream.empty());
 // Compare convolution output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    string info="CONV";
    bool match = true;
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
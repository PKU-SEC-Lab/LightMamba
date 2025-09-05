#include "../src/common.h"
#include "../src/dtA.h"

#include <pthread.h>

/** @brief Number of test layers */
constexpr int TEST_L    = 2;

// instanciate the RMSNORM inst
/** @brief Saved sequence length for loading */
constexpr int T_LOAD    = 512;         // saved seq length, since T is in the inner loop

// actual size
constexpr int T         = 1;
constexpr int TP        = 1;

/** @brief Channel dimension size */
constexpr int C         = 80;
/** @brief Channel parallelism */
constexpr int CP        = 8;

/** @brief Instance of the DTA class with specified template parameters */
DTA  <64, T, C, CP   > dtA_inst(AQ,AS);

/** @brief Number of channel tiles */
constexpr int CT = dtA_inst.CT;

/** @brief Total number of elements in input/output tensors */
constexpr int NUM_X     = T*C;


/**
 * @brief Top-level function for the DTA test module.
 *
 * Executes the DTA operation for a specified layer using the instantiated DTA instance,
 * processing input streams and producing an output stream.
 *
 * @param l Layer index to process.
 * @param i_stream Input stream of data with CP parallelism.
 * @param s_stream Input stream of scale data with single element vectors.
 * @param o_stream Output stream of computed results with CP parallelism.
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
    
// Execute the DTA operation
    dtA_inst  .do_dtA   (l, i_stream,   s_stream,  o_stream );
}

// Reference and DUT data declarations
int64_t  REF_DT_Q               [T*C ];
int64_t  REF_DT_S               [T*CT];
int64_t  REF_DTA                [T*C ];
int64_t  DUT_DTA                [T*C ];

/**
 * @brief Test function for a single DTA layer.
 *
 * Loads reference data, creates input streams, runs the DTA operation, and compares outputs
 * against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    // Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Read reference tensors
    auto DT_Q              = read_tensor<int64_t>(file_path + "/dt_softplus_q_layer" + file_path_suffix);
    auto DT_S              = read_tensor<int64_t>(file_path + "/dt_softplus_s_layer" + file_path_suffix);
    auto DTA               = read_tensor<int64_t>(file_path + "/dA_before_exp_layer" + file_path_suffix);
// Convert tensors to arrays
    tensor2array<int64_t>(DT_Q,    REF_DT_Q,          1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(DT_S,    REF_DT_S,          1, 1, T_LOAD, T, CT,CT);
    tensor2array<int64_t>(DTA,     REF_DTA,           1, 1, T_LOAD, T, C, C);

    // create streams
    // Create input and output streams
    hls::stream<hls::vector<A_T,      CP> > i_stream;
    hls::stream<hls::vector<ASCALE_T, 1 > > s_stream;
    hls::stream<hls::vector<X_T,      CP> > o_stream;

    // Populate input streams
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, A_T, 1, 1, T, TP, C, CP>(REF_DT_Q, i_stream, "DT_Q", true);
    array2stream<int64_t, ASCALE_T, 1, 1, T, TP, CT, 1>(REF_DT_S, s_stream, "DT_S", true);

    // call top function
    // Execute the top function
    top(l, i_stream, s_stream, o_stream);

    // Read output stream into array
    stream2array<int64_t, X_T, 1, T, TP, C,  CP>(o_stream, DUT_DTA, "DTA", true);
 // Verify that streams are empty
    assert(i_stream.empty());
    assert(s_stream.empty());
    assert(o_stream.empty());

    // Compare output with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t>(REF_DTA, DUT_DTA, T*C, "DTA");
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
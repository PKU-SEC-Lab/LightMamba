/**
 * This module tests the RMS normalization followed by quantization by loading reference data, creating input streams,
 * executing the RMSNORM and QUANTIZER operations, and comparing the output against reference data. The implementation
 * is optimized for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/rmsnorm1.h"
#include "../src/quantizer.h"

#include <pthread.h>

/** @brief Number of test layers */
constexpr int TEST_L = 2;
/** @brief Group size for quantization */
constexpr int G = 8;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;

/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = 1;

/** @brief Channel dimension size */
constexpr int C = 2560;
/** @brief Channel parallelism */
constexpr int CP = 8;

/** @brief Instance of the RMSNORM class with specified template parameters, initialized with RMSNORM_LNW weights */
RMSNORM<64, T, TP, C, CP> rmsnorm_inst(RMSNORM_LNW);
/** @brief Instance of the QUANTIZER class with specified template parameters */
QUANTIZER<XLN_T, AQ_T, AS_T, 1, T, TP, C, CP, G> quantizer_inst;

/** @brief Number of time tiles */
constexpr int TT = rmsnorm_inst.TT;
/** @brief Number of channel tiles */
constexpr int CT = rmsnorm_inst.CT;

/** @brief Total number of elements in the input/output arrays */
constexpr int NUM_X = T * C;

/**
 * @brief Top-level function for the RMSNORM and QUANTIZER test module.
 *
 * Executes RMS normalization followed by quantization on the input stream, producing quantized output and scale streams.
 *
 * @param l Layer index to process.
 * @param x_stream Input stream of data with TP*CP parallelism.
 * @param xlnq_stream Output stream of quantized data with TP*CP parallelism.
 * @param xlns_stream Output stream of scale data with TP parallelism.
 */
void top(
    int l, 
    hls::stream<hls::vector<X_T,  TP * CP> > &x_stream, 
    hls::stream<hls::vector<AQ_T, TP * CP> > &xlnq_stream,
    hls::stream<hls::vector<AS_T, TP     > > &xlns_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=x_stream
    #pragma HLS interface axis port=xlnq_stream
    #pragma HLS interface axis port=xlns_stream

    #pragma HLS aggregate variable=x_stream    compact=bit
    #pragma HLS aggregate variable=xlnq_stream compact=bit
    #pragma HLS aggregate variable=xlns_stream compact=bit

    #pragma HLS dataflow

    // declare streams
    /**< Intermediate stream for RMS normalized data */
    hls::stream<hls::vector<XLN_T, TP * CP> > xln_stream;

     /**< Execute RMS normalization */
    rmsnorm_inst  .do_rmsnorm   (l, x_stream,   xln_stream              );
    /**< Execute quantization */
    quantizer_inst.do_quant     (   xln_stream, xlnq_stream, xlns_stream);
}


// Reference and DUT data declarations
int64_t REF_X                   [T*C];
int64_t  REF_XLN_Q               [T*C ];
int64_t  REF_XLN_S               [T*CT];

int64_t  DUT_XLN_Q               [T*C ];
int64_t  DUT_XLN_S               [T*CT];


/**
 * @brief Test function for a single RMSNORM and QUANTIZER layer.
 *
 * Loads reference data, creates input streams, runs the RMSNORM and QUANTIZER operations, and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
    // l now is the order of decoder, not sub layer
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    
    // Read reference data
    auto INPUT_X                  = read_tensor<int64_t>(file_path + "/before_rms1_layer"+file_path_suffix);
    auto OUTPUT_XLN_Q             = read_tensor<int64_t>(file_path + "/rms1_q_layer"+file_path_suffix);
    auto OUTPUT_XLN_S             = read_tensor<int64_t>(file_path + "/rms1_s_layer"+file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t >(OUTPUT_XLN_Q,    REF_XLN_Q,          1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t >(OUTPUT_XLN_S,    REF_XLN_S,          1, 1, T_LOAD, T, CT,CT);
    tensor2array<int64_t>(INPUT_X,    REF_X,          1, 1, T_LOAD, T, C, C);
    // create streams
    // Create input and output streams
    hls::stream<hls::vector<X_T,     TP * CP> > x_stream;
    hls::stream<hls::vector<AQ_T,    TP * CP> > xlnq_stream;
    hls::stream<hls::vector<AS_T,    TP     > > xlns_stream;

     // Populate input stream
    // array2stream<int64_t, X_T, 1, 2, T, TP, C, CP>(REF_X, x_stream, "X", true);
    array2stream<int64_t, X_T, 1, 1, T, TP, C, CP>(REF_X, x_stream, "X", true);

    // call top function
    top(l, x_stream, xlnq_stream, xlns_stream);

    // save condensed output
    //save_condensed_tensor<int8_t, AQ_T, 2*T*C,  TP*CP>(file_path + "/CONDENSED_XLN_Q.bin", xlnq_stream);
    //save_condensed_tensor<int8_t, AS_T, 2*T*CT, TP   >(file_path + "/CONDENSED_XLN_S.bin", xlns_stream);

    // Read output streams into arrays
    stream2array<int64_t, AQ_T, 1, T, TP, C,  CP>(xlnq_stream, DUT_XLN_Q, "XLN_Q", true);
    stream2array<int64_t, AS_T, 1, T, TP, CT, 1 >(xlns_stream, DUT_XLN_S, "XLN_S", true);

    // Verify that streams are empty
    assert(x_stream   .empty());
    assert(xlnq_stream.empty());
    assert(xlns_stream.empty());

    // Compare outputs with reference
    // compare<int64_t>(REF_XLN, DUT_XLN, 2*T*C, "XLN");
    compare<int64_t >(REF_XLN_Q, DUT_XLN_Q, T*C,  "XLN_Q");
    compare<int64_t >(REF_XLN_S, DUT_XLN_S, T*CT, "XLN_S");
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
#include "../src/common.h"
#include "../src/softplus.h"
#include <thread>

/**
 * @brief Number of test layers to process.
 */
constexpr int TEST_L = 2;

/**
 * @brief Saved sequence length for Softplus instantiation.
 */
constexpr int T_LOAD = 512;

// Actual size parameters
/**
 * @brief Sequence length.
 */
constexpr int T = 1;
/**
 * @brief Sequence length per processing element.
 */
constexpr int TP = 1;
/**
 * @brief Number of channels, calculated as (2 * 2560) / 64.
 */
constexpr int C = (2 * 2560) / 64;
/**
 * @brief Interface parallelism, number of channels per processing element.
 */
constexpr int CP = 8;

/**
 * @brief Input data type for Softplus operation.
 */
typedef SOFTPLUS_IN_T if_t;
/**
 * @brief Output data type for Softplus operation.
 */
typedef SOFTPLUS_OUT_T softplus_t;

/**
 * @brief Instantiation of Softplus class with specified template parameters.
 */
SOFTPLUS<if_t, softplus_t, T, TP, C, CP> softplus_inst;

/**
 * @brief Number of sequence length divisions (T/TP).
 */
constexpr int TT = softplus_inst.TT;
/**
 * @brief Number of channel divisions (C/CP).
 */
constexpr int CT = softplus_inst.CT;

/**
 * @brief Top-level function for processing Softplus operations.
 *
 * This function orchestrates the dataflow for the Softplus instance, processing the input stream
 * and producing an output stream with the Softplus activation applied.
 *
 * @param l Layer index (decoder order).
 * @param i_stream Input stream of vectors of type if_t with TP * CP elements.
 * @param o_stream Output stream of vectors of type softplus_t with TP * CP elements.
 */
void top(int l, hls::stream<hls::vector<if_t, TP * CP> > &i_stream, hls::stream<hls::vector<softplus_t, TP * CP> > &o_stream){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=o_stream

    #pragma HLS aggregate variable=i_stream compact=bit
    #pragma HLS aggregate variable=o_stream compact=bit

    softplus_inst.do_softplus(i_stream, o_stream);
}

// Reference and DUT data declarations
int64_t REF_X               [T*C];
int64_t REF_SOFTPLUS            [T*C];
int64_t DUT_SOFTPLUS            [T*C];

/**
 * @brief Tests the Softplus functionality for a specified layer.
 *
 * Loads reference data from binary files, converts it to streams, processes it through
 * the top function, and compares the output with reference data.
 *
 * @param l The layer index to test (decoder order).
 */
void test_layer(int l){

// Base file path for reference data

    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    //// Read reference tensors from binary files
    auto SOFTPLUS_IN     = read_tensor<int64_t>(file_path + "/dt_before_softplus_layer" + file_path_suffix);
    auto SOFTPLUS_OUT    = read_tensor<int64_t>(file_path + "/dt_softplus_layer" + file_path_suffix);

    // Convert tensors to arrays
    tensor2array<int64_t>(SOFTPLUS_IN, REF_X,     1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(SOFTPLUS_OUT, REF_SOFTPLUS, 1, 1, T_LOAD, T, C, C);

    // Create input and output streams
    hls::stream<hls::vector<if_t,  TP * CP> > i_stream("i_stream");
    hls::stream<hls::vector<softplus_t, TP * CP> > o_stream("o_stream");

    // write input data to stream
    array2stream<int64_t, if_t, 1, 1, T, TP, C, CP>(REF_X, i_stream, "SOFTPLUS_IN", true);

    // call top function
    top(l, i_stream, o_stream);

    // read output stream
    stream2array<int64_t, softplus_t, 1, T, TP, C, CP>(o_stream, DUT_SOFTPLUS, "SOFTPLUS", true);

     // Verify streams are empty
    assert(i_stream.empty());
    assert(o_stream.empty());

    // Compare output with reference
    compare<int64_t>(REF_SOFTPLUS, DUT_SOFTPLUS, T*C, "SOFTPLUS");

}
/**
 * @brief Main function to run tests for multiple layers.
 *
 * Iterates through the specified number of layers, calling test_layer for each.
 *
 * @return Returns 0 on successful completion.
 */
int main(){
    for(int l=0; l<TEST_L; ++l){
        test_layer(l);
        // printf("Layer %d passed\n", l);
    }
    return 0;
}
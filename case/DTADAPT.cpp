#include "../src/common.h"
#include "../src/dtadapt.h"
#include <thread>
/** @brief Number of test layers */
constexpr int TEST_L         = 2;

// instanciate the exp inst
/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;

/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for input streams */
constexpr int TP = 1;

/** @brief Channel dimension size */
constexpr int C = (2 * 2560) / 64;
/** @brief Channel parallelism */
constexpr int CP = 8;
/** @brief Group size for parallelism */
constexpr int G = 8;

/** @brief Instance of the DTADAPT class with specified template parameters */
DTADAPT<MAMBA_L, T, TP, C, CP> dtadapt_inst(DTADAPT_BIAS_Q, DTADAPT_BIAS_S);

/** @brief Number of time tiles */
constexpr int TT = dtadapt_inst.TT;
/** @brief Number of channel tiles */
constexpr int CT = dtadapt_inst.CT;

// define top function

/**
 * @brief Top-level function for the DTADAPT test module.
 *
 * Executes the DTADAPT operation for a specified layer using the instantiated DTADAPT instance,
 * processing input streams and producing two sets of output streams for quantized and scale data.
 *
 * @param l Layer index to process.
 * @param i_stream Input stream of data with TP*CP parallelism.
 * @param o_stream First output stream of quantized data with TP*CP parallelism.
 * @param o_s_stream First output stream of scale data with TP parallelism.
 * @param o_stream2 Second output stream of quantized data with TP*CP parallelism.
 * @param o_s_stream2 Second output stream of scale data with TP parallelism.
 */
void top(
    int l,
    hls::stream<hls::vector<X_T, TP * CP> > &i_stream, 
    hls::stream<hls::vector<A_T, TP * CP> >  &o_stream,
    hls::stream<hls::vector<AS_T, TP     > > &o_s_stream,
    hls::stream<hls::vector<A_T, TP * CP> >  &o_stream2,
    hls::stream<hls::vector<AS_T, TP     > > &o_s_stream2
    ){
    #pragma HLS interface ap_ctrl_chain port=return
    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=o_stream
    #pragma HLS interface axis port=o_s_stream
    #pragma HLS interface axis port=o_stream2
    #pragma HLS interface axis port=o_s_stream2
    #pragma HLS aggregate variable=i_stream compact=bit  
    #pragma HLS aggregate variable=o_stream compact=bit
    #pragma HLS aggregate variable=o_s_stream compact=bit
    #pragma HLS aggregate variable=o_stream2 compact=bit
    #pragma HLS aggregate variable=o_s_stream2 compact=bit

    // Execute the DTADAPT operation
    dtadapt_inst.do_dtadapt(l,i_stream,o_stream,o_s_stream,o_stream2,o_s_stream2);

}

// Reference and DUT data declarations
int64_t REF_X                [T*C];
int64_t DTADAPT_Q            [T*C];
int64_t DTADAPT_S            [T*CT];
int64_t DUT_DTADAPT_Q            [T*C];
int64_t DUT_DTADAPT_S            [T*CT];
int64_t DUT_DTADAPT_Q2            [T*C];
int64_t DUT_DTADAPT_S2            [T*CT];


/**
 * @brief Test function for a single DTADAPT layer.
 *
 * Loads reference data, creates input streams, runs the DTADAPT operation, and compares
 * both sets of output streams against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
// Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    // read refs
    // Read reference tensors
    auto DTADAPT_IN     = read_tensor<int64_t>(file_path + "/dt_layer" + file_path_suffix);
    auto DTADAPT_OUT_Q    = read_tensor<int64_t>(file_path + "/dt_softplus_q_layer" + file_path_suffix);
    auto DTADAPT_OUT_S    = read_tensor<int64_t>(file_path + "/dt_softplus_s_layer" + file_path_suffix);    

    // put the data into REF
     // Convert tensors to arrays
    tensor2array<int64_t>(DTADAPT_IN,    REF_X,     1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(DTADAPT_OUT_Q, DTADAPT_Q, 1, 1, T_LOAD, T, C, C);
    tensor2array<int64_t>(DTADAPT_OUT_S, DTADAPT_S, 1, 1, T_LOAD, T, CT, CT);

    // Create input and output streams
    hls::stream<hls::vector<X_T,  TP * CP> > i_stream("i_stream");
    hls::stream<hls::vector<A_T, TP * CP> >  o_stream("o_stream");
    hls::stream<hls::vector<AS_T, TP     > > o_s_stream("o_s_stream");  
    hls::stream<hls::vector<A_T, TP * CP> >  o_stream2("o_stream2");
    hls::stream<hls::vector<AS_T, TP     > > o_s_stream2("o_s_stream2");  

    // write input data to stream
    array2stream<int64_t, X_T, 1, 1, T, TP, C, CP>(REF_X, i_stream, "DTADAPT_IN", true);

    // call top function
    top(l, i_stream, o_stream,o_s_stream,o_stream2,o_s_stream2);

    // read output stream 
    stream2array<int64_t, A_T, 1, T, TP, C, CP>(o_stream, DUT_DTADAPT_Q, "DUT_DTADAPT_Q", true);
    stream2array<int64_t, AS_T, 1, T, TP, CT, 1>(o_s_stream, DUT_DTADAPT_S, "DUT_DTADAPT_S", true);
    stream2array<int64_t, A_T, 1, T, TP, C, CP>(o_stream2, DUT_DTADAPT_Q2, "DUT_DTADAPT_2", true);
    stream2array<int64_t, AS_T, 1, T, TP, CT, 1>(o_s_stream2, DUT_DTADAPT_S2, "DUT_DTADAPT_S2", true);
    
    // Verify that streams are empty
    assert(i_stream.empty());
    assert(o_stream.empty());
    assert(o_s_stream.empty());
    assert(o_stream2.empty());
    assert(o_s_stream2.empty());
    // Compare outputs with reference
    compare<int64_t>(DTADAPT_Q, DUT_DTADAPT_Q, T*C, "DUT_DTADAPT_Q");
    compare<int64_t>(DTADAPT_S, DUT_DTADAPT_S, T*CT, "DUT_DTADAPT_S");
    compare<int64_t>(DTADAPT_Q, DUT_DTADAPT_Q2, T*C, "DUT_DTADAPT_Q2");
    compare<int64_t>(DTADAPT_S, DUT_DTADAPT_S2, T*CT, "DUT_DTADAPT_S2");
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
        // printf("Layer %d passed\n", l);
    }
    return 0;
}
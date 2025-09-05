/**
 * @file GEMM.cpp
 * @brief Testbench for the TENSOR_CORE and ACCUMULATOR modules in the Llama model.
 *
 * This module tests the general matrix multiplication (GEMM) and accumulation operations by loading reference data,
 * creating input streams, executing the TENSOR_CORE and ACCUMULATOR operations, and comparing the output against
 * reference data. The implementation is optimized for HLS with dataflow and stream interfaces.
 */
#include "../src/common.h"
#include "../src/tensor_core.h"
#include "../src/accumulator.h"
#include "../src/utils.h"

/** @brief Flag to indicate small-scale testing */
// constexpr bool IS_SMALL = false;
constexpr bool IS_SMALL = true;

// hyperparameters
constexpr int H     = 1;
/** @brief Group size for activation quantization */
constexpr int GA    = 8;
/** @brief Group size for weight quantization */
constexpr int GW    = 128;

//* actual size
// constexpr int L     = LLAMA_L_MHA;
//* scale down

/** @brief Number of test layers */
constexpr int L         = 1;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;
/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism for GEMM */
constexpr int GEMM_TP = T;

//Input channel dimension size
constexpr int CI         = 2560;
constexpr int CI2        = 5120;

//Output channel dimension size 
constexpr int CO         = 10576;
constexpr int CO2        = 2560;

//Input channel parallelism
constexpr int CIP       = GA;    // forced alignment, therefore the s can be bypassed!
//Output channel parallelism
constexpr int COP       = GA;


//Number of input channel tiles 
constexpr int CIT        = CI  / CIP;
constexpr int CIT2       = CI2 / CIP;

//Number of output channel tiles
constexpr int COT        = CO  / COP;
constexpr int COT2       = CO2 / COP;

//Number of weight tiles
constexpr int WT         = CI  / GW; 
constexpr int WT2        = CI2 / GW;

//
constexpr int TRUNC_BASE = 10;

constexpr int TRUNC_BASE2 = 12;
/** @brief Bitwidth for tensor core output */
// for gemm type, need to calculate the bitwidth
constexpr int DW_TENSOR_CORE = DW_AQ + DW_WQ + log2ce(CIP);

// dtypes
typedef ap_int  <DW_AQ           > aq_t;
typedef ap_int  <DW_WQ           > wq_t;
typedef ap_uint <DW_ASCALE       > as_t;
typedef ap_uint <DW_WSCALE       > ws_t;
typedef ap_int  <DW_TENSOR_CORE  > gemm_t;
typedef ap_int  <DW_XD           > acc_t;    // largest accumulated value
typedef ap_int  <DW_X            > of_t;     // largest accumulated value

// complicated testbench, combining the gemm and the accumulator
// Main TENSOR_CORE is responsible for 7 matrix multiplications
// QKVOUGD
// QKVO: T*C  -> T*C
// UG:   T*C  -> T*CM
// D:    T*CM -> T*C
const int T_IN = (CI * CO ) / (CIP * COP);  // CI and CO tripcounts for one matrix
const int T_OUT = (CI2 * CO2) / (CIP * COP);
const int T_TENSOR_CORE = T_IN + T_OUT;

// next for accumulator, need to determine A1, A2, N1, N2
// A1, A2 are the accumulator times on input channel
const int A1 = CI  / CIP;
const int A2 = CI2 / CIP;
// N1, N2 are the repeat times, which means t & co repeat contribution.
// t will not have contribution, it is weight broadcasting, therefore it is similar to single token
const int N_IN = CO  / COP;
const int N_OUT = CO2 / COP;
// total repeat times, of two stages
const int ACC_N1 = N_IN;
const int ACC_N2 = N_OUT;

// instanciate the gemm inst
/** @brief Instance of the TENSOR_CORE class with specified template parameters */
TENSOR_CORE        <aq_t, wq_t, gemm_t, T_TENSOR_CORE, GEMM_TP, CIP, COP>  tensor_core_inst;
// instanciate the accumulator inst
/** @brief Instance of the ACCUMULATOR class with specified template parameters */
ACCUMULATOR <gemm_t, as_t, ws_t, acc_t, of_t, TRUNC_BASE, TRUNC_BASE2, GEMM_TP, COP, A1, A2, ACC_N1, ACC_N2, GA, GW>   accum_inst;


/**
 * @brief Top-level function for the GEMM and accumulator test module.
 *
 * Executes the TENSOR_CORE operation followed by the ACCUMULATOR operation, processing input streams
 * and producing the final output stream.
 *
 * @param i_stream Input stream of quantized activation data with GEMM_TP*CIP parallelism.
 * @param s_stream Input stream of activation scale data with GEMM_TP parallelism.
 * @param w_stream Input stream of quantized weight data with COP*CIP parallelism.
 * @param s1_stream Input stream of weight scale data (first set) with COP parallelism.
 * @param s2_stream Input stream of weight scale data (second set) with COP parallelism.
 * @param o_stream Output stream of final results with COP parallelism.
 */
void top(
    hls::stream<hls::vector<aq_t, GEMM_TP *CIP> >& i_stream,
    hls::stream<hls::vector<as_t, GEMM_TP     > >& s_stream,

    hls::stream<hls::vector<wq_t, COP*CIP> >& w_stream,
    hls::stream<hls::vector<ws_t, COP    > >& s1_stream,
    hls::stream<hls::vector<ws_t, COP    > >& s2_stream,

    hls::stream<hls::vector<of_t, COP   > >& o_stream
){
    #pragma HLS interface ap_ctrl_chain port=return

    #pragma HLS interface axis port=i_stream
    #pragma HLS interface axis port=w_stream
    #pragma HLS interface axis port=s_stream
    #pragma HLS interface axis port=s1_stream
    #pragma HLS interface axis port=s2_stream
    #pragma HLS interface axis port=o_stream

    // set aggregate pragma
    #pragma HLS aggregate variable=i_stream  compact=bit
    #pragma HLS aggregate variable=w_stream  compact=bit
    #pragma HLS aggregate variable=s_stream  compact=bit
    #pragma HLS aggregate variable=s1_stream compact=bit
    #pragma HLS aggregate variable=s2_stream compact=bit
    #pragma HLS aggregate variable=o_stream  compact=bit


    // // Declare intermediate stream
    hls::stream<hls::vector<gemm_t, GEMM_TP *COP> > gemm_stream ("gemm_stream");

    #pragma HLS dataflow
    // do the main gemm
    tensor_core_inst.   do_tensor_core  (i_stream,      w_stream,   gemm_stream);
    // do the accumulator
    accum_inst.         do_accumulator  (gemm_stream,   s_stream,   s1_stream,  s2_stream,  o_stream);
}


// declare the ref data here
int64_t REF_XLN1_Q    [T  *CI  ];  //  in_proj
int64_t REF_XLN1_S    [T  *CIT ];  //  in_proj
int64_t REF_XLN2_Q    [T  *CI2 ];  //  out_proj
int64_t REF_XLN2_S    [T  *CIT2];  //  out_proj
// declare weights
int64_t REF_WIN_Q         [CO *CI  ]; // in_proj weight
int64_t REF_WIN_S1        [CO *WT  ]; // in_proj shift1
int64_t REF_WIN_S2        [CO *WT  ]; // in_proj shift2
int64_t REF_WOUT_Q        [CO2*CI2 ]; // out_proj weight
int64_t REF_WOUT_S1       [CO2*WT2 ]; // out_proj shift1
int64_t REF_WOUT_S2       [CO2*WT2 ]; // out_proj shift2
// declare the ref output
int64_t REF_IN       [T  *CO ];   // in_proj output
int64_t REF_OUT      [T  *CO2];  // out_proj output
// declare the dut output
int64_t DUT_IN       [T  *CO ];   // in_proj output
int64_t DUT_OUT      [T  *CO2];  // out_proj output


/**
 * @brief Test function for a single GEMM and accumulator layer.
 *
 * Loads reference data, creates input streams, runs the TENSOR_CORE and ACCUMULATOR operations,
 * and compares the output against reference data.
 *
 * @param l Layer index to test.
 */
void test_layer(int l){
// Load reference data
    {
        string file_path = "D:/file/project/git/light-mamba/ref";
        string file_path_suffix      = to_string(l) + ".bin";
         // Read input reference data
        auto XLN1_Q      = read_tensor<int64_t>  (file_path + "/activations/rms1_q_layer" + file_path_suffix);
        auto XLN1_S      = read_tensor<int64_t>  (file_path + "/activations/rms1_s_layer" + file_path_suffix);
        auto XLN2_Q      = read_tensor<int64_t>  (file_path + "/activations/rms2_q_layer" + file_path_suffix);
        auto XLN2_S      = read_tensor<int64_t>  (file_path + "/activations/rms2_s_layer" + file_path_suffix);
        // Read weight reference data
        auto WIN_Q       = read_tensor<int64_t>  (file_path + "/weights/in_proj_wq_layer" + file_path_suffix);
        auto WIN_S1      = read_tensor<int64_t>  (file_path + "/weights/in_proj_s1_layer" + file_path_suffix);
        auto WIN_S2      = read_tensor<int64_t>  (file_path + "/weights/in_proj_s2_layer" + file_path_suffix);
        auto WOUT_Q      = read_tensor<int64_t>  (file_path + "/weights/out_proj_wq_layer" + file_path_suffix);
        auto WOUT_S1     = read_tensor<int64_t>  (file_path + "/weights/out_proj_s1_layer" + file_path_suffix);
        auto WOUT_S2     = read_tensor<int64_t>  (file_path + "/weights/out_proj_s2_layer" + file_path_suffix);
        // Read output reference data
        auto IN          = read_tensor<int64_t>  (file_path + "/activations/zxbcdt_layer" + file_path_suffix);
        auto OUT         = read_tensor<int64_t>  (file_path + "/activations/out_proj_layer" + file_path_suffix);

        //          <dtype >    TENSOR,     ARRAY,          H_LOAD, H,      T_LOAD, T,      C_LOAD, C
// Convert tensors to arrays
        tensor2array<int64_t>(   XLN1_Q,     REF_XLN1_Q,     1,      1,      T_LOAD, T,      CI,     CI   );
        tensor2array<int64_t>(   XLN1_S,     REF_XLN1_S,     1,      1,      T_LOAD, T,      CIT,    CIT  );
        tensor2array<int64_t>(   XLN2_Q,     REF_XLN2_Q,     1,      1,      T_LOAD, T,      CI2,    CI2  );
        tensor2array<int64_t>(   XLN2_S,     REF_XLN2_S,     1,      1,      T_LOAD, T,      CIT2,   CIT2 );
        tensor2array<int64_t>(   IN,         REF_IN,         1,      1,      T_LOAD, T,      CO,     CO   );
        tensor2array<int64_t>(   OUT,        REF_OUT,        1,      1,      T_LOAD, T,      CO2,    CO2  );
        tensor2array<int64_t>(   WIN_Q,      REF_WIN_Q,      1,      1,      CO,     CO,     CI,     CI   );
        tensor2array<int64_t>(   WIN_S1,     REF_WIN_S1,     1,      1,      CO,     CO,     WT,     WT   );
        tensor2array<int64_t>(   WIN_S2,     REF_WIN_S2,     1,      1,      CO,     CO,     WT,     WT   );
        tensor2array<int64_t>(   WOUT_Q,     REF_WOUT_Q,     1,      1,      CO2,    CO2,    CI2,    CI2  );
        tensor2array<int64_t>(   WOUT_S1,    REF_WOUT_S1,    1,      1,      CO2,    CO2,    WT2,    WT2  );
        tensor2array<int64_t>(   WOUT_S2,    REF_WOUT_S2,    1,      1,      CO2,    CO2,    WT2,    WT2  );
    }

    // Create input and output streams
    hls::stream<hls::vector<aq_t, GEMM_TP *CIP> > i_stream   ( "i_stream"   );
    hls::stream<hls::vector<as_t, GEMM_TP     > > s_stream   ( "s_stream"   );

    hls::stream<hls::vector<wq_t,  COP*CIP> > w_stream   ( "w_stream"   );
    hls::stream<hls::vector<ws_t, COP    > > s1_stream  ( "s1_stream"  );
    hls::stream<hls::vector<ws_t, COP    > > s2_stream  ( "s2_stream"  );

    hls::stream<hls::vector<of_t, COP    > > o_stream   ( "o_stream"   );  // inplace unpacked

    //              arr type,   s type,    repeat, H,      T,      GEMM_TP,     C,      CP
    // input quantized data 
     // Populate input streams
    array2stream<   int64_t,     aq_t,       COT,    1,      T,      GEMM_TP,     CI,      CIP>(REF_XLN1_Q, i_stream, "Input XLN1", true);  // Q
    array2stream<   int64_t,     aq_t,       COT2,   1,      T,      GEMM_TP,     CI2,     CIP>(REF_XLN2_Q, i_stream, "Input XLN2", true);  // D
    // input scale data
    array2stream<   int64_t,     as_t,       COT,    1,      T,      GEMM_TP,     CIT,     1  >(REF_XLN1_S, s_stream);  // Q
    array2stream<   int64_t,     as_t,       COT2,   1,      T,      GEMM_TP,     CIT2,    1  >(REF_XLN2_S, s_stream);  // D
    // weight quantized data
    array2stream<   int64_t,     wq_t,       1,      1,      CO,     COP,         CI,      CIP>(REF_WIN_Q,      w_stream);  // Q
    array2stream<   int64_t,     wq_t,       1,      1,      CO2,    COP,         CI2,     CIP>(REF_WOUT_Q,     w_stream);  // D
    // weight scale data 1
    array2stream<   int64_t,     ws_t,       1,      1,      CO,     COP,         WT,      1  >(REF_WIN_S1,     s1_stream); // Q
    array2stream<   int64_t,     ws_t,       1,      1,      CO2,    COP,         WT2,     1  >(REF_WOUT_S1,    s1_stream); // D
    // weight scale data 2
    array2stream<   int64_t,     ws_t,       1,      1,      CO,     COP,         WT,      1  >(REF_WIN_S2,     s2_stream); // Q
    array2stream<   int64_t,     ws_t,       1,      1,      CO2,    COP,         WT2,     1  >(REF_WOUT_S2,    s2_stream); // D

    // call the top function
    // std::cout << "Calling top" << std::endl;
    top(i_stream, s_stream, w_stream, s1_stream, s2_stream, o_stream);
    // std::cout << "Finished" << std::endl;

    // read the output, no repeat           
    stream2array_unpack<int64_t,    of_t,           1,      T,      GEMM_TP,     CO,     COP>(o_stream,      DUT_IN,  "Output IN",  true);
    stream2array_unpack<int64_t,    of_t,           1,      T,      GEMM_TP,     CO2,    COP>(o_stream,      DUT_OUT, "Output OUT", true);

    compare<int64_t>(REF_IN,  DUT_IN,  T*CO,  "IN");
    compare<int64_t>(REF_OUT, DUT_OUT, T*CO2, "OUT");
}
/**
 * @brief Main function to run tests for all layers.
 *
 * Iterates through all test layers and calls the test function for each.
 * @return 0 on successful completion.
 */
int main(){

    for(int l=0; l<L; ++l){
        test_layer(l);
        printf("Layer %d passed\n", l);
    }
}



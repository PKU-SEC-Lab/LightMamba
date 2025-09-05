#include "../src/common.h"
#include "../src/utils.h"


// This module is the demux for the Llama, the next module of GEMM

// hyperparameters
/** @brief Group size for processing */
constexpr int G     = 8;

//* actual size
// constexpr int L     = LLAMA_L_MHA;
//* scale down
/** @brief Number of test layers */
constexpr int L         = 2;

/** @brief Saved sequence length for loading */
constexpr int T_LOAD = 512;
/** @brief Sequence length for processing */
constexpr int T = 1;
/** @brief Time parallelism */
constexpr int TP = T;
/** @brief Channel parallelism */
constexpr int CP = G;
/** @brief Hidden dimension size */
constexpr int N = 128;
/** @brief Projection dimension size */
constexpr int P = 64;
/** @brief Channel dimension size for dt */
constexpr int CH = 80;
/** @brief Channel dimension size for xBC */
constexpr int CC = 5376;
/** @brief Channel dimension size for z */
constexpr int C2 = 5120;
/** @brief Channel dimension size for output */
constexpr int CO = 2560;
/** @brief Number of channel tiles for dt */
constexpr int CHT = CH / CP;
/** @brief Number of hidden dimension tiles */
constexpr int NTT = 2 * N / CP;
/** @brief Total number of cycles for processing */
constexpr int CT = 2 * P + 1;
/** @brief Number of channel tiles for output */
constexpr int COT = CO / CP;

/// @brief Derived tiling sizes
constexpr int CHT       = CH/CP;
constexpr int NTT       = 2*N/CP;
constexpr int CT        = 2*P+1; //129
constexpr int COT       = CO/CP; //129

// calculate total number of Y
constexpr int NUM_Y     = 2*N+CH*CT;
/// @brief Typedef for accumulated integer data (based on data width DW_X)
typedef ap_int  <DW_X     > data_t;     // largest accumulated value

/**
 * @brief Top-level HLS module for Llama demultiplexing.
 *
 * This function reads a sequence of vectors from a combined input stream (`gemm_stream`),
 * and splits the vectors into four separate output streams:
 * - `dt_stream` for the Q projection
 * - `xBC_stream` for the K projection
 * - `z_stream` for the V projection
 * - `out_stream` for the final projection (e.g., out_proj)
 *
 * @param gemm_stream Combined input stream from previous GEMM stage
 * @param dt_stream Output stream for Q projection
 * @param xBC_stream Output stream for K projection
 * @param z_stream Output stream for V projection
 * @param out_stream Output stream for out_proj result
 */
void top(
    hls::stream<hls::vector<X_T,  CP> >& gemm_stream,
    hls::stream<hls::vector<X_T,  CP> >& dt_stream,
    hls::stream<hls::vector<X_T,  CP> >& xBC_stream,
    hls::stream<hls::vector<X_T,  CP> >& z_stream,
    hls::stream<hls::vector<X_T,  CP> >& out_stream
){
    #pragma HLS interface ap_ctrl_chain port=return
    // set interface
    #pragma HLS interface axis port=gemm_stream
    #pragma HLS interface axis port=dt_stream
    #pragma HLS interface axis port=xBC_stream
    #pragma HLS interface axis port=z_stream
    #pragma HLS interface axis port=out_stream
    // set aggregate pragma
    #pragma HLS aggregate variable=gemm_stream compact=bit
    #pragma HLS aggregate variable=dt_stream   compact=bit
    #pragma HLS aggregate variable=xBC_stream  compact=bit
    #pragma HLS aggregate variable=z_stream    compact=bit
    #pragma HLS aggregate variable=out_stream    compact=bit
 // Load initial 2*N vectors for xBC
    for(int ct=0;ct<NTT;++ct) {
        #pragma HLS pipeline II=1
        hls::vector<X_T, CP> vec;
        vec=gemm_stream.read();
        xBC_stream.write(vec);

    }
    // Load CH * CT vectors: split into dt, xBC, and z
    for(int ctt=0;ctt<CHT;++ctt) {
        for(int ct=0;ct<CT;++ct) {
            #pragma HLS pipeline II=1
            hls::vector<X_T, CP> vec;
            vec=gemm_stream.read();
            if(ct==0) {
                dt_stream.write(vec);
            }
            else if(ct&1) {
                xBC_stream.write(vec);
            }
            else {
                z_stream.write(vec);
            }
        }
    }
    // Process output stream 
    for(int ct=0;ct<COT;++ct) {
        #pragma HLS pipeline II=1
        hls::vector<X_T, CP> vec;
        vec=gemm_stream.read();
        out_stream.write(vec);

    }
        
}

// Reference and DUT data declarations
// declare the ref input
int64_t REF_Y           [NUM_Y ];   // condensed input
int64_t REF_Y2          [CO ];   // condensed input
// declare the ref output
int64_t REF_DT       [T*CH ];   // Q
int64_t REF_XBC      [T*CC ];   // K
int64_t REF_Z        [T*C2 ];   // V

// declare the permuted dut output
int64_t DUT_DT       [T*CH ]; // QK permuted
int64_t DUT_XBC      [T*CC ]; // V  permuted
int64_t DUT_Z        [T*C2 ]; // O  permuted
int64_t DUT_O        [T*CO ]; // O  permuted

/**
 * @brief Test function for a single demultiplexer layer.
 *
 * Loads reference data, creates input streams, runs the demultiplexer operation, and compares
 * the output against reference data.
 *
 * @param l Layer index to test.
 */

void test_layer(int l){
    // Load reference data from files
    string file_path = "D:/file/project/git/light-mamba/ref/activations";
    string file_path_suffix      = to_string(l) + ".bin";
    {
        //  Read condensed input and output projection data
        auto Y           = read_tensor<int64_t> (file_path + "/zxbcdt_layer" + file_path_suffix);
        auto Y2           = read_tensor<int64_t> (file_path + "/out_proj_layer" + file_path_suffix);
        // read results
        // auto DT          = read_tensor<int64_t> (file_path + "/dt_layer" + file_path_suffix);
        // auto XBC         = read_tensor<int64_t> (file_path + "/xBC_layer" + file_path_suffix);
        // auto Z           = read_tensor<int64_t> (file_path + "/z_layer" + file_path_suffix);
        
        // Convert tensors to arrays： Convert to flat arrays
        tensor2array<int64_t>(Y, REF_Y, 1,  1,  T_LOAD,   T,  NUM_Y,  NUM_Y);
        tensor2array<int64_t>(Y2, REF_Y2, 1,  1,  T_LOAD,   T,  CO,  CO);
        // put results into ref
        // tensor2array<int64_t>(  DT,    REF_DT,    1,      1,      T_LOAD, T,      CH,     CH   );
        // tensor2array<int64_t>(  XBC,   REF_XBC,   1,      1,      T_LOAD, T,      CC,     CC   );
        // tensor2array<int64_t>(  Z,     REF_Z,     1,      1,      T_LOAD, T,      C2,     C2   );

        // // Manual demux for reference values
        int ct = 0;
        for (int nt2 = 0; nt2 < NTT; ++nt2) {
            for (int cp = 0; cp < CP; ++cp) {
                REF_XBC[nt2 * CP + cp] = REF_Y[ct * CP + cp];
            }
            ct++;
        }
        for (int ht = 0; ht < CHT; ++ht) {
            for (int cp = 0; cp < CP; ++cp) {
                REF_DT[ht * CP + cp] = REF_Y[ct * CP + cp];
            }
            ct++;
            for (int p = 0; p < P; ++p) {
                for (int cp = 0; cp < CP; ++cp) {
                    REF_XBC[2 * N + ht * CP * P + p * CP + cp] = REF_Y[ct * CP + cp];
                }
                ct++;
                for (int cp = 0; cp < CP; ++cp) {
                    REF_Z[ht * CP * P + p * CP + cp] = REF_Y[ct * CP + cp];
                }
                ct++;
            }
        }
        
    }

    // Create input and output streams
    hls::stream<hls::vector<X_T,            CP> > gemm_stream( "gemm_stream");
    hls::stream<hls::vector<X_T,            CP> > dt_stream  ( "dt_stream"  );
    hls::stream<hls::vector<X_T,            CP> > xBC_stream ( "xBC_stream" );
    hls::stream<hls::vector<X_T,            CP> > z_stream   ( "z_stream"   );
    hls::stream<hls::vector<X_T,            CP> > out_stream ( "out_stream" );

    // Populate input streams
    array2stream       <int64_t,   X_T,  1,   1,    1,    1,   NUM_Y,  CP>(REF_Y, gemm_stream, "Input Y");
    array2stream       <int64_t,   X_T,  1,   1,    1,    1,   CO,  CP>(REF_Y2, gemm_stream, "Input Y2");
    // call top function
    // Run HLS top function
    top(gemm_stream, dt_stream, xBC_stream, z_stream, out_stream);

    // Read output streams into arrays
    stream2array<int64_t,  X_T,  1,  T,  T, CH, CP>(dt_stream,  DUT_DT,   "Output DT", true);
    stream2array<int64_t,  X_T,  1,  T,  T, CC, CP>(xBC_stream, DUT_XBC,  "Output XBC",true);
    stream2array<int64_t,  X_T,  1,  T,  T, C2, CP>(z_stream,   DUT_Z,    "Output Z",  true);
    stream2array<int64_t,  X_T,  1,  T,  T, CO, CP>(out_stream, DUT_O,    "Output O",  true);
    

    // // Compare outputs with reference
    compare<int64_t>(REF_DT,  DUT_DT,  T*CH, "DT"  );
    compare<int64_t>(REF_XBC, DUT_XBC, T*CC, "XBC" );
    compare<int64_t>(REF_Z,   DUT_Z,   T*C2, "Z"   );
    compare<int64_t>(REF_Y2,  DUT_O,   T*CO, "O"   );
}

/**
 * @brief Entry point for the testbench
 * 
 * Iterates over all layers and tests the `top` module functionality.
 * 
 * @return int Exit status
 */
int main(){

    for(int l=0; l<L; ++l){
        test_layer(l);
        printf("Layer %d passed\n", l);
    }
}



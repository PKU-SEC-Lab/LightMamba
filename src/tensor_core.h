#ifndef __INT_MAIN_TENSOR_CORE_H__
#define __INT_MAIN_TENSOR_CORE_H__

#include "common.h"
#include "utils.h"

// For an whole Llama2 decoder, the following operations should be done in main gemm:
// 1. QKV generation
// 2. O projection
// 3. U projection
// 4. G projection
// 5. D projection
// therefore, just need to calculate the whole number of operations "N", since for each one is equivalent
/**
 * @class TENSOR_CORE
 * @brief Template class for performing matrix multiplication operations in the Llama2 decoder.
 *
 * Executes matrix multiplication for input and weight streams, producing an output stream with
 * specified parallelism. The implementation supports progress tracking in simulation mode and is
 * optimized for HLS synthesis.
 *
 * @tparam if_t Input data type.
 * @tparam w_t Weight data type.
 * @tparam of_t Output data type.
 * @tparam N Number of matrix multiplication operations.
 * @tparam TP Time parallelism for input and output streams.
 * @tparam CIP Input channel parallelism.
 * @tparam COP Output channel parallelism.
 */
template<
    class if_t,
    class w_t,
    class of_t,
    int N,
    int TP,
    int CIP,
    int COP
>
class TENSOR_CORE{
public:

    #ifndef __SYNTHESIS__ 
    /** @brief Progress bar for simulation mode */
    ProgressBar pb;
    TENSOR_CORE(): pb("TENSOR_CORE", N / 1000 + 1) {}
       /**
     * @brief Constructor initializing the progress bar for simulation.
     */
    #else
      /**
     * @brief Constructor for synthesis mode.
     */
    TENSOR_CORE() {}

    #endif

        /**
     * @brief Performs matrix multiplication for the Llama2 decoder.
     *
     * Reads input and weight streams, performs matrix multiplication with full unrolling,
     * and writes the results to the output stream. Includes progress tracking in simulation mode.
     *
     * @param i_stream Input stream of data with TP*CIP parallelism.
     * @param w_stream Input stream of weight data with COP*CIP parallelism.
     * @param o_stream Output stream of computed results with TP*COP parallelism.
     */
    void do_tensor_core(
        hls::stream<hls::vector<if_t, TP *CIP> >& i_stream, 
        hls::stream<hls::vector<w_t,  COP*CIP> >& w_stream,
        hls::stream<hls::vector<of_t, TP *COP> >& o_stream
    ) {

        #ifndef __SYNTHESIS__
        pb.start();
        #endif
// Iterate over the number of operations
        for(int n = 0; n < N; n++) {
            #pragma HLS pipeline II=1

            #ifndef __SYNTHESIS__
            if(n % 1000 == 0) pb.update(1);
            #endif
 // Read input and weight vectors
            hls::vector<if_t, TP *CIP> i_vec = i_stream.read();
            hls::vector<w_t,  COP*CIP> w_vec = w_stream.read();
            hls::vector<of_t, TP *COP> o_vec;
            // initialize the output vector
            for(int tp = 0; tp < TP; tp++) {
                for(int cop = 0; cop < COP; cop++) {
                    #pragma HLS unroll
                    o_vec[tp*COP + cop] = 0;
                }
            }
            // completely unrolled matmul
            // Perform fully unrolled matrix multiplication
            for(int tp = 0; tp < TP; tp++) {
                for(int cop = 0; cop < COP; cop++) {
                    for(int cip = 0; cip < CIP; cip++) {
                        #pragma HLS unroll
                        auto mul_res = i_vec[tp*CIP + cip] * w_vec[cop*CIP + cip];
                        #pragma HLS bind_op variable=mul_res op=mul impl=fabric
                        o_vec[tp*COP + cop] += mul_res;
                    }
                }
            }
            /// Write result to output stream
            o_stream.write(o_vec);
        }
    }

};

#endif
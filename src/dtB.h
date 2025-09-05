/**
 * @file DTB.h
 * @brief Header file for the DTB class implementing a dot-product transformation operation.
 *
 * This class performs a dot-product transformation (DTB) operation for the Llama model, processing input streams with
 * integer scaling factors and producing an output stream. The implementation is optimized for HLS with pipelining,
 * dataflow, and unrolling directives.
 */
#ifndef __INT_DTB_H__
#define __INT_DTB_H__

#include "common.h"
#include "utils.h"
/**
 * @class DTB
 * @brief Template class for computing dot-product transformation operations with integer scaling.
 *
 * Processes input streams of data and scaling factors, performs multiplication with integer scaling,
 * and produces an output stream with specified parallelism.
 *
 * @tparam T Sequence length.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 * @tparam N Hidden dimension size.
 * @tparam NP Hidden dimension parallelism.
 */
template<
    int     T,      
    int     C,
    int     CP,
    int     N,
    int     NP
>
class DTB{
public:
    /** @brief Number of channel tiles */
    static constexpr int CT = C / CP;
    /** @brief Number of hidden dimension tiles */
    static constexpr int NT2 = N / NP;
    /** @brief Truncation shift for output scaling */
    static constexpr int TRUNC_D = 10;
    /**
     * @brief Constructor for DTB class.
     */
    DTB(){
    }

    /**
     * @brief Performs the dot-product transformation operation.
     *
     * Reads input streams for data and scaling factors, performs multiplication with integer scaling,
     * and writes the results to the output stream.
     *
     * @param dt_stream Input stream of data with CP parallelism.
     * @param dt_s_stream Input stream of scale data with single element vectors.
     * @param B_stream Input stream of data with CP parallelism.
     * @param B_s_stream Input stream of scale data with single element vectors.
     * @param o_stream Output stream of computed results with CP parallelism.
     */
    void do_dtB(
        hls::stream<hls::vector<A_T,      CP> >& dt_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& dt_s_stream,
        hls::stream<hls::vector<A_T,      CP> >& B_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& B_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow

        hls::vector<A_T, CP> dt_vec;
        hls::vector<ASCALE_T, 1> dt_s_vec;
        hls::vector<A_T, CP> B_vec;
        hls::vector<ASCALE_T, 1> B_s_vec;
        // Iterate over channel tiles
        for(int ct=0;ct<CT;ct++) {
            // Iterate over hidden dimension tiles plus one
            for(int nt=0;nt<NT2+1;nt++) {
                // Iterate over hidden dimension parallelism
                for(int np=0;np<NP;np++) {
                    #pragma HLS pipeline II=1
                    if(nt<NT2) {
                        hls::vector<X_T, CP> o_vec;
                        // Read input data at the start of the outer loops
                        if(nt==0&&np==0) {
                            dt_vec=dt_stream.read();
                            dt_s_vec=dt_s_stream.read();
                        }
// Read B data at the start of the inner loop
                        if(np==0) {
                            B_vec=B_stream.read();
                            B_s_vec=B_s_stream.read();
                        }
                        // Compute combined scale
                        ap_uint<5> scale = dt_s_vec[0] + B_s_vec[0];
                        // Perform multiplication and scaling
                        for(int cp=0;cp<CP;cp++) {
                            #pragma HLS unroll
                            auto mul_res=dt_vec[cp]*B_vec[np];
                            #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                            o_vec[cp]=XD_T(mul_res) << scale;
                        } 
                        // Write result to output stream
                        o_stream.write(o_vec);
                    }
                }
            }
        }

    }
};

#endif
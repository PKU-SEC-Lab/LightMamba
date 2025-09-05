/**
 * This file defines the HTC class, which implements a high-throughput computation Uppercase compute operation
 * using HLS (High-Level Synthesis) streams for efficient data processing.
 */

#ifndef __INT_HTC_H__
#define __INT_HTC_H__

#include "common.h"
#include "utils.h"
/**
 * @class HTC
 * @brief Template class for high-throughput compute operations.
 *
 * @tparam T  Template parameter for data type size.
 * @tparam C  Number of channels.
 * @tparam CP Number of channels per processing element.
 * @tparam N  Total number of iterations.
 * @tparam NP Number of iterations per processing element.
 * @tparam P  Number of parallel processing elements.
 * @tparam PP Number of parallel processing elements per channel.
 */
template<
    int     T,      
    int     C,
    int     CP,
    int     N,
    int     NP,
    int     P,
    int     PP
>
class HTC{
public:
    /// @brief Number of channels per processing element (C/CP).
    static constexpr int CT = C / CP;
    /// @brief Number of iterations per processing element (N/NP).
    static constexpr int NT2 = N / NP;
    /// @brief Number of parallel processing elements (P/PP).
    static constexpr int PT = P / PP;
    /// @brief Truncation shift value for output scaling.
    static constexpr int TRUNC_D  = 17;
    /**
     * @brief Default constructor for HTC class.
     */
    HTC(){
    }
   /**
     * @brief Performs high-throughput compute operation on input streams.
     *
     * Processes input streams through a series of multiply-accumulate operations with scaling,
     * producing an output stream with truncated and adjusted results.
     *
     * @param ht_stream Input stream of vectors of type A_T with CP elements.
     * @param ht_s_stream Input stream of scaling factors (ASCALE_T, single element).
     * @param C_stream Input stream of vectors of type A_T with CP elements for multiplication.
     * @param C_s_stream Input stream of scaling factors (ASCALE_T, single element) for multiplication.
     * @param uD_stream Input stream of vectors of type X_T with CP elements for addition.
     * @param o_stream Output stream of vectors of type X_T with CP elements.
     */
    void do_htC(
        hls::stream<hls::vector<A_T,      CP> >& ht_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& ht_s_stream,
        hls::stream<hls::vector<A_T,      CP> >& C_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& C_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& uD_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow
        /// @brief Local vector for storing input data from ht_stream.
        hls::vector<A_T, CP> ht_vec;
        /// @brief Local vector for storing scaling factor from ht_s_stream.
        hls::vector<ASCALE_T, 1> ht_s_vec;
        /// @brief Local vector for storing input data from C_stream.
        hls::vector<A_T, CP> C_vec;
        /// @brief Local vector for storing scaling factor from C_s_stream.
        hls::vector<ASCALE_T, 1> C_s_vec;
        /// @brief Local vector for storing input data from uD_stream.
        hls::vector<X_T, CP> uD_vec;
        /// @brief Buffer array for accumulating intermediate results.
        HTC_T buffer[PP];
        /// @brief Local vector for storing output data to o_stream.
        hls::vector<X_T, CP> o_vec;

        // Iterating over channels, processing elements, and iterations
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        for(int pp=0;pp<PP;pp++) {
                            #pragma HLS pipeline II=1
                            // Read input vectors and scaling factors
                            ht_vec=ht_stream.read();
                            ht_s_vec=ht_s_stream.read();
                            if(pp==0) {
                                C_vec=C_stream.read();
                                C_s_vec=C_s_stream.read();
                            }
                            if(nt==0&&pp==0) {
                                uD_vec=uD_stream.read();
                            }
                            if(nt==0) {
                                buffer[pp] = 0;
                            }
                            // Compute combined scaling factor
                            ap_uint<5> scale=ht_s_vec[0]+C_s_vec[0];
                            X_T mul_tmp=0;
                            // Perform multiply-accumulate operation
                            for(int np=0;np<NP;np++) {
                                #pragma HLS unroll
                                auto mul_res=ht_vec[np]*C_vec[np];
                                #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                                mul_tmp+=mul_res;
                            }
                            // Accumulate scaled result into buffer
                            buffer[pp] += HTC_T(mul_tmp) << scale;
                            // Compute final output with truncation and addition
                            if(nt==NT2-1) {
                                o_vec[pp] = (buffer[pp]>> TRUNC_D) +uD_vec[pp];
                            }
                            if(nt==NT2-1&&pp==PP-1) {
                                // Write output vector to stream
                                o_stream.write(o_vec);
                            }
                            // if(nt==NT2-1&&pp==PP-1) {
                            //     for(int pp2=0; pp2<PP; ++pp2){
                            //         #pragma HLS unroll
                            //         o_vec[pp2] = o_vec[pp2] >> TRUNC_D;
                            //     }
                            //     o_stream.write(o_vec);
                            // }
                        }
                    }
                }
            }
        }

    }
};

#endif
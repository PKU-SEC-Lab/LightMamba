/**
 * @file aAh.h
 * @brief Header file for the DAH class implementing a dot-product attention head operation.
 *
 * This class performs a dot-product attention head (DAH) operation, processing input streams
 * of attention and hidden state data, applying multiplication and scaling, and producing an
 * output stream. The implementation is optimized for HLS with pipelining and dataflow directives.
 */
#ifndef __INT_DAH_H__
#define __INT_DAH_H__

#include "common.h"
#include "utils.h"
/**
 * @class DAH
 * @brief Template class for computing dot-product attention head operations.
 *
 * Processes input streams of attention and hidden state data, performs multiplication,
 * applies scaling, and produces an output stream with specified parallelism.
 *
 * @tparam T Sequence length.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 * @tparam N Hidden dimension size.
 * @tparam NP Hidden dimension parallelism.
 * @tparam P Projection dimension size.
 * @tparam PP Projection parallelism.
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
class DAH{
public:
    static constexpr int CT = C / CP;
    static constexpr int NT2 = N / NP;
    static constexpr int PT = P / PP;
    static constexpr int TRUNC_D  = 6;
    /**
     * @brief Constructor for DAH class.
     */
    DAH(){
    }
    /**
     * @brief Performs the dot-product attention head operation.
     *
     * Reads attention and hidden state streams, computes the dot product, applies scaling,
     * and writes the result to the output stream.
     *
     * @param dA_stream Input stream of attention data with CP parallelism.
     * @param dA_s_stream Input stream of attention scale data with single element vectors.
     * @param ht_stream Input stream of hidden state data with CP parallelism.
     * @param ht_s_stream Input stream of hidden state scale data with single element vectors.
     * @param o_stream Output stream of computed results with CP parallelism.
     */
    void do_dAh(
        hls::stream<hls::vector<A_T,      CP> >& dA_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& dA_s_stream,
        hls::stream<hls::vector<A_T,      CP> >& ht_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& ht_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow
        hls::vector<A_T, CP> dA_vec;
        hls::vector<ASCALE_T, 1> dA_s_vec;
        hls::vector<A_T, CP> ht_vec;
        hls::vector<ASCALE_T, 1> ht_s_vec;
         // Iterate over channel tiles
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        for(int np=0;np<NP;np++) {
                            #pragma HLS pipeline II=1
                            hls::vector<X_T, CP> o_vec;                            
                            if(cp==0&&pt==0&&nt==0&&np==0) {
                                 // Read attention data once per outer loop iteration
                                dA_vec=dA_stream.read();
                                dA_s_vec=dA_s_stream.read();
                            }
                            // Read hidden state data
                            ht_vec=ht_stream.read();
                            ht_s_vec=ht_s_stream.read();
                             // Compute combined scale
                            ap_uint<5> scale = dA_s_vec[0] + ht_s_vec[0];
                            // Perform dot-product and scaling
                            for(int pp=0;pp<PP;pp++) {
                                #pragma HLS unroll
                                auto mul_res=dA_vec[cp]*ht_vec[pp];
                                #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                                o_vec[pp]=(XD_T(mul_res) << scale) >> TRUNC_D;
                            }
                            // Write result to output stream
                            o_stream.write(o_vec);
                        }
                    }
                }
            }
        }

    }
};

#endif
/**
 * @brief Header file for the YZ class implementing element-wise multiplication with scaling 
 *
 * This class performs element-wise multiplication of two input streams with corresponding scale factors,
 * producing an output stream. The implementation is optimized for HLS with dataflow, pipelining, and unrolling directives.
 */

#ifndef __INT_YZ_H__
#define __INT_YZ_H__

#include "common.h"
#include "utils.h"
/**
 * @class YZ
 * @brief Template class for element-wise multiplication and scaling operations in the Llama model.
 *
 * Performs element-wise multiplication of two input streams, applies scaling based on their scale factors,
 * and produces an output stream with truncation. The implementation is optimized for HLS synthesis.
 *
 * @tparam T Sequence length.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 */
template<
    int     T,      
    int     C,
    int     CP
>
class YZ{
public:
    /** @brief Number of channel tiles */
    static constexpr int CT = C / CP;
    /** @brief Truncation shift value for output scaling */
    static constexpr int TRUNC_D = 10;
    /**
     * @brief Constructor for YZ class.
     */
    YZ(){
    }

        /**
     * @brief Performs element-wise multiplication and scaling.
     *
     * Reads input streams for y and z data along with their scale factors, performs element-wise
     * multiplication, applies scaling, and writes the result to the output stream.
     *
     * @param y_stream Input stream of y data with CP parallelism.
     * @param y_s_stream Input stream of y scale data with single element vectors.
     * @param z_stream Input stream of z data with CP parallelism.
     * @param z_s_stream Input stream of z scale data with single element vectors.
     * @param o_stream Output stream of computed results with CP parallelism.
     */
    void do_yz(
        hls::stream<hls::vector<A_T,      CP> >& y_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& y_s_stream,
        hls::stream<hls::vector<A_T,      CP> >& z_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& z_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow

        
        for(int ct=0;ct<CT;ct++) {
            #pragma HLS pipeline II=1
            hls::vector<A_T, CP> y_vec = y_stream.read();               /**< Read y data vector from input stream */
            hls::vector<ASCALE_T, 1> y_s_vec = y_s_stream.read();       /**< Read y scale factor from input stream */
            hls::vector<A_T, CP> z_vec = z_stream.read();               /**< Read z data vector from input stream */
            hls::vector<ASCALE_T, 1> z_s_vec = z_s_stream.read();       /**< Read z scale factor from input stream */
            hls::vector<X_T, CP> o_vec;                                 /**< Output vector for results */
            ap_uint<5> scale = y_s_vec[0] + z_s_vec[0];                 /**< Compute combined scale factor */
            for(int cp=0;cp<CP;cp++) {
                #pragma HLS unroll
                
                auto mul_res=y_vec[cp]*z_vec[cp];/**< Perform element-wise multiplication */
                 
                #pragma HLS bind_op variable=mul_res op=mul impl=dsp /**< Bind multiplication to DSP implementation */
                
                o_vec[cp]= (XD_T(mul_res) << scale) >> TRUNC_D; /**< Apply scaling and truncation */
            } 
           
            o_stream.write(o_vec);  /**< Write result to output stream */
    }
};

#endif
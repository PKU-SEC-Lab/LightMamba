/**
 * @brief Header file for the UD class implementing matrix multiplication with scaling 
 *
 * This class performs matrix multiplication of an input stream with a weight matrix, applies scaling,
 * and produces an output stream with truncation. The implementation is optimized for HLS with dataflow,
 * pipelining, and unrolling directives.
 */
#ifndef __INT_UD_H__
#define __INT_UD_H__

#include "common.h"
#include "utils.h"


/** @brief Array of D weight quantization values */
constexpr int DQ[] = {
    #include "../../../ref/weights/D_q.txt"
};

/** @brief Array of D weight scale values */
constexpr int DS[] = {
    #include "../../../ref/weights/D_s.txt"
};


/**
 * @class UD
 * @brief Template class for matrix multiplication and scaling operations in the Llama model.
 *
 * Performs matrix multiplication of input data with a weight matrix D, applies scaling using
 * input and weight scale factors, and produces an output stream with truncation. The implementation
 * is optimized for HLS synthesis.
 *
 * @tparam L Number of layers.
 * @tparam T Sequence length.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 * @tparam P Projection dimension size.
 * @tparam PP Projection parallelism.
 */
template<
    int     L,
    int     T,      
    int     C,
    int     CP,
    int     P,
    int     PP
>
class UD{
public:
    /** @brief Number of channel tiles */
    static constexpr int CT = C / CP;
    /** @brief Number of projection tiles */
    static constexpr int PT = P / PP;
    /** @brief Truncation shift value for output scaling */
    static constexpr int TRUNC_D = 8;

    /** @brief Weight matrix for D, dimensioned as [L][C] */
    WC_T D_weight[L][C];
    /** @brief Scale factors for D weights, dimensioned as [L][CT] */
    WSCALE_T D_weight_s[L][CT];

        /**
     * @brief Constructor for UD class.
     *
     * Initializes the weight matrix and scale factors from provided initialization arrays.
     *
     * @tparam init_t Data type for initialization arrays.
     * @param Dq_init Initialization array for D weight quantization values.
     * @param Ds_init Initialization array for D weight scale values.
     */
    template<typename init_t>
    UD(
        const init_t Dq_init[L*C],
        const init_t Ds_init[L*CT]){
        for(int l=0; l<L; ++l){
            for(int c=0; c<C; ++c){
                D_weight[l][c] = Dq_init[l*C + c];
            }
        }
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT; ++ct){
                D_weight_s[l][ct] = Ds_init[l*CT + ct];
            }
        }
    }

        /**
     * @brief Performs matrix multiplication and scaling for a specific layer.
     *
     * Reads input data and scale factor streams, performs matrix multiplication with the D weight matrix,
     * applies scaling, and writes the result to the output stream after truncation.
     *
     * @param l Layer index to process.
     * @param i_stream Input stream of data with CP parallelism.
     * @param s_stream Input stream of scale data with single element vectors.
     * @param o_stream Output stream of computed results with CP parallelism.
     */
    void do_uD(
        int l,
        hls::stream<hls::vector<A_T,      CP> >& i_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow
        #pragma HLS bind_storage variable=D_weight           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=D_weight_s         type=ram_2p impl=URAM

        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    #pragma HLS pipeline II=1
                    hls::vector<A_T, CP> i_vec=i_stream.read(); /**< Read input data vector from stream */
                    hls::vector<ASCALE_T, 1> s_vec=s_stream.read(); /**< Read scale factor from stream */
                    hls::vector<X_T, CP> o_vec; /**< Output vector for results */

                    ap_uint<5> scale = s_vec[0] + D_weight_s[l][ct]; /**< Compute combined scale factor */
                    for(int pp=0;pp<PP;pp++) {   /**< Iterate over projection parallelism */
                        #pragma HLS unroll
                        auto mul_res = i_vec[pp] * D_weight[l][ct*CP+cp]; /**< Perform matrix multiplication */
                        #pragma HLS bind_op variable=mul_res op=mul impl=dsp /**< Bind multiplication to DSP */
                        o_vec[pp] = (XD_T(mul_res) << scale) >> TRUNC_D;  /**< Apply scaling and truncation */
                    }
                    o_stream.write(o_vec);  /**< Write result to output stream */
                }
            }
        }

    }
};

#endif
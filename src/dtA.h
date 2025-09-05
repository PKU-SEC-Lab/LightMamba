/**
 * @brief Header file for the DTA class implementing a dot-product transformation operation.
 *
 */
#ifndef __INT_DTA_H__
#define __INT_DTA_H__

#include "common.h"
#include "utils.h"

/**
 * @brief Array of quantized weights for the DTA operation.
 */
constexpr int AQ           [] = {
    #include "../../../ref/weights/A_q.txt"
};
/**
 * @brief Array of scale weights for the DTA operation.
 */
constexpr int AS         [] = {
    #include "../../../ref/weights/A_s.txt"
};

/**
 * @class DTA
 * @brief Template class for computing dot-product transformation operations.
 *
 * Initializes weight arrays from provided data and performs dot-product operations with scaling
 * on input streams to produce output streams.
 *
 * @tparam L Number of layers.
 * @tparam T Sequence length.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 */
template<
    int     L,
    int     T,      
    int     C,
    int     CP
>
class DTA{
public:
/** @brief Number of channel tiles */
    static constexpr int CT = C / CP;
     /** @brief Truncation shift for output scaling */
    static constexpr int TRUNC_D  = 10;

    /** @brief Weight array for quantized data */
    AQ_T_ A_weight[L][C];

    /** @brief Weight array for scale data */
    WSCALE_T A_weight_s[L][CT];

    /**
     * @brief Constructor for DTA class.
     *
     * Initializes the weight arrays using provided initialization data.
     *
     * @tparam init_t Data type for initialization arrays.
     * @param Aq_init Array of quantized weight initialization data.
     * @param As_init Array of scale weight initialization data.
     */
    template<typename init_t>
    DTA(
        const init_t Aq_init[L*C],
        const init_t As_init[L*CT]){
        for(int l=0; l<L; ++l){
            for(int c=0; c<C; ++c){
                A_weight[l][c] = Aq_init[l*C + c];
            }
        }
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT; ++ct){
                A_weight_s[l][ct] = As_init[l*CT + ct];
            }
        }
    }

        /**
     * @brief Performs the dot-product transformation operation for a specific layer.
     *
     * Reads input streams, performs dot-product with weights, applies scaling, and writes to the output stream.
     *
     * @param l Layer index to process.
     * @param i_stream Input stream of data with CP parallelism.
     * @param s_stream Input stream of scale data with single element vectors.
     * @param o_stream Output stream of computed results with CP parallelism.
     */
    void do_dtA(
        int l,
        hls::stream<hls::vector<A_T,      CP> >& i_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow
        #pragma HLS array_reshape variable=A_weight          cyclic      factor=CP
        #pragma HLS bind_storage variable=A_weight           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=A_weight_s         type=ram_2p impl=URAM
// Iterate over channel tiles
        for(int ct=0;ct<CT;ct++) {
            for(int tmp=0;tmp<3;tmp++) {
                #pragma HLS pipeline II=1
                if(tmp==0) {
                     // Read input data
                    hls::vector<A_T, CP> i_vec=i_stream.read();
                    hls::vector<ASCALE_T, 1> s_vec=s_stream.read();
                    hls::vector<X_T, CP> o_vec;
                    // Compute combined scale
                    ap_uint<5> scale = s_vec[0] + A_weight_s[l][ct];
                    // Perform dot-product and scaling
                    for(int cp=0;cp<CP;cp++) {
                        #pragma HLS unroll
                        auto mul_res = i_vec[cp] * A_weight[l][ct*CP+cp];
                        #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                        o_vec[cp] = (XD_T(mul_res) << scale) >> TRUNC_D;
                    }
                    // Write result to output stream
                    o_stream.write(o_vec);
                }
            }
        }

    }
};

#endif
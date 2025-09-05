/**
 * @file int_conv.h
 * @brief Header file defining the CONV class for integer convolution using quantized weights and biases.
 */

#ifndef __INT_CONV_H__
#define __INT_CONV_H__

#include "common.h"
#include "utils.h"
/**
 * @brief Quantized convolution weights (Wq), loaded from external file.
 */

constexpr int CONV_WEIGHT           [] = {       
    #include "../../../ref/weights/conv_wq.txt"
};
/**
 * @brief Scaling factors for convolution weights (Ws), loaded from external file.
 */
constexpr int CONV_WEIGHT_S         [] = {
    #include "../../../ref/weights/conv_ws.txt" 
};
/**
 * @brief Quantized convolution biases (Bq), loaded from external file.
 */
constexpr int CONV_BIAS             [] = { 
    #include "../../../ref/weights/conv_bq.txt"
};
/**
 * @brief Scaling factors for convolution biases (Bs), loaded from external file.
 */
constexpr int CONV_BIAS_S           [] = {
    #include "../../../ref/weights/conv_bs.txt" 
};

/**
 * @class CONV
 * @brief Template class implementing quantized 1D convolution with fixed depth using HLS.
 *
 * This class supports streaming input/output and applies fixed-point arithmetic
 * for inference on FPGAs. It supports scaling of both weights and biases using lookup values.
 *
 * @tparam L  Number of convolution layers
 * @tparam T  Temporal length (not directly used here)
 * @tparam C  Total number of channels
 * @tparam CP Channel parallelism factor
 */
template<
    int     L,
    int     T,      
    int     C,
    int     CP
>
class CONV{
public:
/// Channel tile count
    static constexpr int CT = C / CP;
    /// Convolution depth (number of input timesteps or filter depth)
    static constexpr int D  = 4;
    /// Number of bits to truncate from the output after accumulation
    static constexpr int TRUNC_D  = 10;

  /// Quantized weight tensor [layer][channel_tile][depth][channel_parallel]
    WC_T conv_weight[L][CT][D][CP];
     /// Weight scaling factors [layer][channel_tile][depth]
    WSCALE_T conv_weight_s[L][CT][D];
/// Quantized bias tensor [layer][channel]
    WC_T conv_bias[L][C];
    /// Bias scaling factors [layer][channel_tile]
    WSCALE_T_ conv_bias_s[L][CT];
    /**
     * @brief Constructor to initialize weights and biases from flattened arrays.
     *
     * @tparam init_t Initialization type (e.g., int, float)
     * @param wq_init Flattened weight array of size L * CT * D * CP
     * @param ws_init Flattened weight scale array of size L * CT * D
     * @param bq_init Flattened bias array of size L * C
     * @param bs_init Flattened bias scale array of size L * CT
     */

    template<typename init_t>
    CONV(
        const init_t wq_init[L*CT*D*CP],
        const init_t ws_init[L*CT*D],
        const init_t bq_init[L*C],
        const init_t bs_init[L*CT]){
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT; ++ct){
                for(int d=0; d<D; ++d){
                    for(int cp=0; cp<CP; ++cp){
                        conv_weight[l][ct][d][cp] = wq_init[l*CT*D*CP + ct*D*CP + d*CP + cp];
                    }
                }
            }
        }
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT; ++ct){
                for(int d=0; d<D; ++d){
                    conv_weight_s[l][ct][d] = ws_init[l*CT*D + ct*D + d];
                }
            }
        }
        for(int l=0; l<L; ++l){
            for(int c=0; c<C; ++c){
                conv_bias[l][c] = bq_init[l*C + c];
            }
        }
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT; ++ct){
                conv_bias_s[l][ct] = bs_init[l*CT + ct];
            }
        }
    }
    /**
     * @brief Perform convolution for a specific layer.
     *
     * This function processes one tile (CT) of the input stream, applying the quantized weights and biases,
     * scaling, and right-shifting the result before writing to the output stream.
     *
     * @param l         Index of the convolution layer
     * @param i_stream  Input stream of shape [CP], representing feature input
     * @param s_stream  Stream of input scaling values
     * @param o_stream  Output stream of shape [CP], representing the convolved result
     */
    void do_conv(
        int l,
        hls::stream<hls::vector<A_T,      CP> >& i_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS array_reshape variable=conv_weight          cyclic      factor=CP
        #pragma HLS array_reshape variable=conv_bias          cyclic      factor=CP
        #pragma HLS bind_storage variable=conv_weight           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight_s         type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_bias             type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_bias_s           type=ram_2p impl=URAM

        for(int ct=0;ct<CT;ct++) {
            for(int d=0;d<D;d++) {
                #pragma HLS pipeline II=1
                hls::vector<A_T, CP> i_vec=i_stream.read();
                hls::vector<ASCALE_T, 1> s_vec=s_stream.read();
                hls::vector<X_T, CP> o_vec;
// Initialize with bias on first depth
                if(d==0) {
                    for(int cp=0;cp<CP;cp++) {
                        #pragma HLS unroll
                        XD_T conv_b=conv_bias[l][ct * CP + cp];
                        o_vec[cp] = conv_b << conv_bias_s[l][ct];
                    }
                }
                ap_uint<5> scale = s_vec[0] + conv_weight_s[l][ct][d];

                // Multiply-accumulate
                for(int cp=0;cp<CP;cp++) {
                    #pragma HLS unroll
                    auto mul_res = i_vec[cp] * conv_weight[l][ct][d][cp];
                    #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                    o_vec[cp] += XD_T(mul_res) << scale;
                }
                // Write result after final depth
                if(d==D-1) {
                    for(int cp=0;cp<CP;cp++) {
                        #pragma HLS unroll
                        o_vec[cp] = o_vec[cp] >> TRUNC_D;
                    }
                    o_stream.write(o_vec);
                }

            }
        }

    }
};

#endif
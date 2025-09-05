#ifndef __INT_CONV_H__
#define __INT_CONV_H__

#include "common.h"
#include "utils.h"


constexpr int CONV_WEIGHT           [] = {
    #include "../../../ref/weights/conv_wq.txt"
};
constexpr int CONV_WEIGHT_S         [] = {
    #include "../../../ref/weights/conv_ws.txt"
};
constexpr int CONV_BIAS             [] = {
    #include "../../../ref/weights/conv_bq.txt"
};
constexpr int CONV_BIAS_S           [] = {
    #include "../../../ref/weights/conv_bs.txt"
};

template<
    int     L,
    int     T,      
    int     C,
    int     CP
>
class CONV{
public:
    static constexpr int CT = C / CP;
    static constexpr int D  = 4;
    static constexpr int TRUNC_D  = 10;

    WC_T conv_weight[L][CT][D][CP];
    WSCALE_T conv_weight_s[L][CT][D];

    WC_T conv_bias[L][C];
    WSCALE_T_ conv_bias_s[L][CT];

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

                if(d==0) {
                    for(int cp=0;cp<CP;cp++) {
                        #pragma HLS unroll
                        XD_T conv_b=conv_bias[l][ct * CP + cp];
                        o_vec[cp] = conv_b << conv_bias_s[l][ct];
                    }
                }
                ap_uint<5> scale = s_vec[0] + conv_weight_s[l][ct][d];
                for(int cp=0;cp<CP;cp++) {
                    #pragma HLS unroll
                    auto mul_res = i_vec[cp] * conv_weight[l][ct][d][cp];
                    #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                    o_vec[cp] += XD_T(mul_res) << scale;
                }
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
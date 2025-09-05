#ifndef __INT_CONV_STEP_H__
#define __INT_CONV_STEP_H__

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


    static constexpr int C2 = C / 2;
    static constexpr int CT2 = CT / 2;

    static constexpr int C22        = 5120;
    static constexpr int N         = 128;
    static constexpr int NT2       = N/CP;
    static constexpr int C22T       = C22/CP;

    WC_T conv_weight1[L][CT2*CP];
    WC_T conv_weight2[L][CT2*CP];
    WC_T conv_weight3[L][CT2*CP];
    WC_T conv_weight4[L][CT2*CP];
    WC_T conv_weight5[L][CT2*CP];
    WC_T conv_weight6[L][CT2*CP];
    WC_T conv_weight7[L][CT2*CP];
    WC_T conv_weight8[L][CT2*CP];
    WSCALE_T conv_weight_s1[L][CT2][D];
    WSCALE_T conv_weight_s2[L][CT2][D];

    WC_T conv_bias[L][C2];
    WC_T conv_bias2[L][C2];
    WSCALE_T_ conv_bias_s[L][CT];

    template<typename init_t>
    CONV(
        const init_t wq_init[L*CT*D*CP],
        const init_t ws_init[L*CT*D],
        const init_t bq_init[L*C],
        const init_t bs_init[L*CT]){
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT2; ++ct){
                for(int d=0; d<D; ++d){
                    for(int cp=0; cp<CP; ++cp){
                        int ct_cur;
                        int ct_cur2;
                        if(ct<NT2*2) {
                            ct_cur=ct+C22T;
                        }
                        else {
                            ct_cur=ct-2*NT2;
                        }
                        if(ct+CT2<NT2*2) {
                            ct_cur2=ct+CT2+C22T;
                        }
                        else {
                            ct_cur2=ct+CT2-2*NT2;
                        }
                        if(d==0) {

                            conv_weight1[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur*D*CP + d*CP + cp];
                            conv_weight2[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur2*D*CP + d*CP + cp];
                        }
                        else if(d==1) {
                            conv_weight3[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur*D*CP + d*CP + cp];
                            conv_weight4[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur2*D*CP + d*CP + cp];
                        }
                        else if(d==2) {
                            conv_weight5[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur*D*CP + d*CP + cp];
                            conv_weight6[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur2*D*CP + d*CP + cp];
                        }
                        else {
                            conv_weight7[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur*D*CP + d*CP + cp];
                            conv_weight8[l][ct*CP+cp] = wq_init[l*CT*D*CP + ct_cur2*D*CP + d*CP + cp];
                        }

                    }
                }
            }
        }
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT2; ++ct){
                int ct_cur;
                int ct_cur2;
                if(ct<NT2*2) {
                    ct_cur=ct+C22T;
                }
                else {
                    ct_cur=ct-2*NT2;
                }
                if(ct+CT2<NT2*2) {
                    ct_cur2=ct+CT2+C22T;
                }
                else {
                    ct_cur2=ct+CT2-2*NT2;
                }
                for(int d=0; d<D; ++d){
                    conv_weight_s1[l][ct][d] = ws_init[l*CT*D + ct_cur*D + d];
                    conv_weight_s2[l][ct][d] = ws_init[l*CT*D + ct_cur2*D + d];
                }
            }
        }
        for(int l=0; l<L; ++l){
            for(int c=0; c<C2; ++c){
                int ct_cur;
                int ct_cur2;
                if(c<N*2) {
                    ct_cur=c+C22;
                }
                else {
                    ct_cur=c-2*N;
                }
                if(c+C2<N*2) {
                    ct_cur2=c+C2+C22;
                }
                else {
                    ct_cur2=c+C2-2*N;
                }
                conv_bias[l][c] = bq_init[l*C + ct_cur];
                conv_bias2[l][c] = bq_init[l*C + ct_cur2];
            }
        }
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT; ++ct){
                int ct_cur;
                if(ct<NT2*2) {
                    ct_cur=ct+C22T;
                }
                else {
                    ct_cur=ct-2*NT2;
                }
                conv_bias_s[l][ct] = bs_init[l*CT + ct_cur];
            }
        }
    }

    void w_cache(
        int l,
        hls::stream<hls::vector<WC_T,      CP> >& w_stream,
        hls::stream<hls::vector<WSCALE_T, 1 > >& w_s_stream
    ) {
        #pragma HLS array_reshape variable=conv_weight1          cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_weight2          cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_weight3          cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_weight4          cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_weight5          cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_weight6          cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_weight7          cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_weight8          cyclic      factor=CP dim=2 
        #pragma HLS bind_storage variable=conv_weight1           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight2           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight3           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight4           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight5           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight6           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight7           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight8           type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight_s1         type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_weight_s2         type=ram_2p impl=URAM
        hls::vector<XD_T, CP> o_vec;
        for(int r=0;r<2;r++) {
            for(int ct=0;ct<CT2;ct++) {
                for(int d=0;d<D;d++) {
                    #pragma HLS pipeline II=1
    
                    hls::vector<WC_T, CP> w_vec;
                    hls::vector<WSCALE_T, 1> ws_vec;
                    if(r<1) {
                        ws_vec[0] = conv_weight_s1[l][ct][d];
                    }
                    else {
                        ws_vec[0] = conv_weight_s2[l][ct][d];
                    }
                    if(d<1) {
                        if(r<1)
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight1[l][ct*CP+cp];
                            }
                        else
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight2[l][ct*CP+cp];
                            }
                    }
                    else if(d<2) {
                        if(r<1)
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight3[l][ct*CP+cp];
                            }
                        else
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight4[l][ct*CP+cp];
                            }
                    }
                    else if(d<3) {
                        if(r<1)
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight5[l][ct*CP+cp];
                            }
                        else
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight6[l][ct*CP+cp];
                            }
                    }
                    else {
                        if(r<1)
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight7[l][ct*CP+cp];
                            }
                        else
                            for(int cp=0;cp<CP;cp++) {
                                #pragma HLS unroll
                                w_vec[cp]=conv_weight8[l][ct*CP+cp];
                            }
                    }
                    w_stream.write(w_vec);
                    w_s_stream.write(ws_vec);
                }
            }
        }

    }

    void b_cache(
        int l,
        hls::stream<hls::vector<WC_T,      CP> >& b_stream,
        hls::stream<hls::vector<WSCALE_T_, 1 > >& b_s_stream
    ) {
        #pragma HLS array_reshape variable=conv_bias             cyclic      factor=CP dim=2
        #pragma HLS array_reshape variable=conv_bias2            cyclic      factor=CP dim=2
        #pragma HLS bind_storage variable=conv_bias             type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_bias2             type=ram_2p impl=URAM
        #pragma HLS bind_storage variable=conv_bias_s           type=ram_2p impl=URAM
        
        for(int r=0;r<2;r++) {
            for(int ct=0;ct<CT2;ct++) {          
                #pragma HLS pipeline II=1
                hls::vector<WC_T, CP> b_vec;
                hls::vector<WSCALE_T_, 1> bs_vec;
                if(r<1) {
                    bs_vec[0] = conv_bias_s[l][ct];
                }
                else {
                    bs_vec[0] = conv_bias_s[l][ct+CT2];
                }
                if(r<1) {
                    for(int cp=0;cp<CP;cp++) {
                        #pragma HLS unroll
                        b_vec[cp]=conv_bias[l][ct * CP + cp];
                    }
                }
                else {
                    for(int cp=0;cp<CP;cp++) {
                        #pragma HLS unroll
                        b_vec[cp]=conv_bias2[l][ct * CP + cp];
                    }
                }
                b_stream.write(b_vec);
                b_s_stream.write(bs_vec);
            }
        }

    }


    void conv_mul(
        hls::stream<hls::vector<A_T,      CP> >& i_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
        hls::stream<hls::vector<WC_T,      CP> >& w_stream,
        hls::stream<hls::vector<WSCALE_T, 1 > >& w_s_stream,
        hls::stream<hls::vector<WC_T,      CP> >& b_stream,
        hls::stream<hls::vector<WSCALE_T_, 1 > >& b_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        hls::vector<XD_T, CP> o_vec;
        for(int r=0;r<2;r++) {
            for(int ct=0;ct<CT2;ct++) {
                for(int d=0;d<D+2;d++) {
                    #pragma HLS pipeline II=1
    
                    if(d<1) {
                        hls::vector<WC_T, CP> b_vec=b_stream.read();
                        hls::vector<WSCALE_T_, 1> bs_vec=b_s_stream.read();
                        for(int cp=0;cp<CP;cp++) {
                            #pragma HLS unroll
                            o_vec[cp] = XD_T(b_vec[cp]) << bs_vec[0];
                        }
                    }
                    else if(d<D+1) {
                        hls::vector<A_T, CP> i_vec=i_stream.read();
                        hls::vector<ASCALE_T, 1> s_vec=s_stream.read();
                        hls::vector<WC_T, CP> w_vec=w_stream.read();
                        hls::vector<WSCALE_T, 1> ws_vec=w_s_stream.read();
                        ap_uint<5> scale=s_vec[0] + ws_vec[0];
                        for(int cp=0;cp<CP;cp++) {
                            #pragma HLS unroll
                            auto mul_res = i_vec[cp] * w_vec[cp];
                            #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                            o_vec[cp] += XD_T(mul_res) << scale;
                        }
                    }
                    else {
                        hls::vector<X_T, CP> out_vec;
                        for(int cp=0;cp<CP;cp++) {
                            #pragma HLS unroll
                            out_vec[cp] = o_vec[cp] >> TRUNC_D;
                        }
                        o_stream.write(out_vec);
                    }

                }
            }
        }

    }


    void do_conv(
        int l,
        hls::stream<hls::vector<A_T,      CP> >& i_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow

        hls::stream<hls::vector<WC_T,      CP> > w_stream  ( "w_stream"  );
        hls::stream<hls::vector<WSCALE_T, 1 > > w_s_stream  ( "w_s_stream"  );

        hls::stream<hls::vector<WC_T,      CP> > b_stream  ( "b_stream"  );
        hls::stream<hls::vector<WSCALE_T_, 1 > > b_s_stream  ( "b_s_stream"  );

        w_cache(
            l,
            w_stream,
            w_s_stream
        );
        b_cache(
            l,
            b_stream,
            b_s_stream
        );
        conv_mul(
            i_stream,
            s_stream,
            w_stream,
            w_s_stream,
            b_stream,
            b_s_stream,
            o_stream
        );
    }
};

#endif
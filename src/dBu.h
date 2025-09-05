#ifndef __INT_DBU_H__
#define __INT_DBU_H__

#include "common.h"
#include "utils.h"

template<
    int     T,      
    int     C,
    int     CP,
    int     N,
    int     NP,
    int     P,
    int     PP
>
class DBU{
public:
    static constexpr int CT = C / CP;
    static constexpr int NT2 = N / NP;
    static constexpr int PT = P / PP;
    static constexpr int TRUNC_D  = 11;

    DBU(){
    }

    void do_dBu(
        hls::stream<hls::vector<A_T,      CP> >& dB_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& dB_s_stream,
        hls::stream<hls::vector<A_T,      CP> >& u_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& u_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow
        A_T wb[N][CP];
        ASCALE_T wb_s[N];
        #pragma HLS array_reshape variable=wb          cyclic      factor=CP
        #pragma HLS bind_storage    variable=wb type=ram_2p impl=BRAM
        #pragma HLS bind_storage    variable=wb_s type=ram_2p impl=BRAM
        hls::vector<A_T, CP> dB_vec;
        hls::vector<ASCALE_T, 1> dB_s_vec;
        hls::vector<A_T, CP> u_vec;
        hls::vector<ASCALE_T, 1> u_s_vec;
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        for(int np=0;np<NP;np++) {
                            #pragma HLS pipeline II=1
                            hls::vector<X_T, CP> o_vec;
                            hls::vector<A_T, CP> i_vec;
                            hls::vector<ASCALE_T, 1> s_vec;
                            if(cp==0&&pt==0) {
                                dB_vec=dB_stream.read();
                                dB_s_vec=dB_s_stream.read();
                                for(int p=0;p<CP;p++) {
                                    #pragma HLS unroll
                                    i_vec[p]=dB_vec[p];
                                }
                                s_vec[0]=dB_s_vec[0];
                                for(int p=0;p<CP;p++) {
                                    #pragma HLS unroll
                                    wb[nt*NP+np][p]=dB_vec[p];
                                }
                                wb_s[nt*NP+np]=dB_s_vec[0];
                            }
                            else {
                                for(int p=0;p<CP;p++) {
                                    #pragma HLS unroll
                                    i_vec[p]=wb[nt*NP+np][p];
                                }
                                s_vec[0]=wb_s[nt*NP+np];
                            }
                            if(nt==0&&np==0) {
                                u_vec=u_stream.read();
                                u_s_vec=u_s_stream.read();
                            }
                            ap_uint<5> scale = s_vec[0] + u_s_vec[0];
                            // ap_uint<5> scale = wb_s[nt*NP+np] + u_s_vec[0];
                            for(int pp=0;pp<PP;pp++) {
                                #pragma HLS unroll
                                auto mul_res=i_vec[cp]*u_vec[pp];
                                // auto mul_res=wb[nt*NP+np][cp]*u_vec[pp];
                                #pragma HLS bind_op variable=mul_res op=mul impl=dsp
                                o_vec[pp]=(DBU_T(mul_res) << scale) >> TRUNC_D;
                            }
                            o_stream.write(o_vec);
                        }
                    }
                }
            }
        }

    }
};

#endif
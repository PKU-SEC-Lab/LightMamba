/**

 * @brief Header file for the DBU class implementing a dot-product and multiplication operation with caching.
 *
 */
#ifndef __INT_DBU_DIVIDE_H__
#define __INT_DBU_DIVIDE_H__

#include "common.h"
#include "utils.h"
/**
 * @class DBU
 * @brief Template class for computing dot-product and multiplication operations with caching.
 *
 * Processes input streams of data and scale values, caches them, performs multiplication with scaling,
 * and produces an output stream with specified parallelism.
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
class DBU{
public:
    /** @brief Number of channel tiles */
    static constexpr int CT = C / CP;
    /** @brief Number of hidden dimension tiles */
    static constexpr int NT2 = N / NP;
    /** @brief Number of projection tiles */
    static constexpr int PT = P / PP;
    /** @brief Truncation shift for output scaling */
    static constexpr int TRUNC_D = 11;
   /**
     * @brief Constructor for DBU class.
     */
    DBU(){
    }
    /**
     * @brief Caches input data and scale streams.
     *
     * Reads input streams, stores data in buffers, and writes to intermediate streams for further processing.
     *
     * @param dB_stream Input stream of data with CP parallelism.
     * @param dB_s_stream Input stream of scale data with single element vectors.
     * @param dB_cache_stream Output stream of cached data with single element vectors.
     * @param dB_cache_s_stream Output stream of cached scale data with single element vectors.
     */
    void dB_cache(
        hls::stream<hls::vector<A_T,      CP> >& dB_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& dB_s_stream,
        hls::stream<hls::vector<A_T,      1> >& dB_cache_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& dB_cache_s_stream
    ) {
         // Declare buffers for caching data
        A_T wb[N][CP];
        ASCALE_T wb_s[N];
        #pragma HLS array_reshape variable=wb          cyclic      factor=1 dim=1
        #pragma HLS array_reshape variable=wb          cyclic      factor=CP dim=2
        #pragma HLS bind_storage    variable=wb type=ram_2p impl=BRAM
        #pragma HLS bind_storage    variable=wb_s type=ram_2p impl=BRAM
// Iterate over channel tiles
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        for(int np=0;np<NP;np++) {
                            #pragma HLS pipeline II=1
                            hls::vector<A_T, 1> o_vec;
                            hls::vector<ASCALE_T, 1> s_vec;
                            // Read and cache data at the start of outer loops
                            if(cp==0&&pt==0) {
                                hls::vector<A_T, CP> dB_vec=dB_stream.read();
                                hls::vector<ASCALE_T, 1> dB_s_vec=dB_s_stream.read();
                                for(int p=0;p<CP;p++) {
                                    #pragma HLS unroll
                                    wb[nt*NP+np][p]=dB_vec[p];
                                }
                                wb_s[nt*NP+np]=dB_s_vec[0];
                            }
                            o_vec[0]=wb[nt*NP+np][cp];
                            s_vec[0]=wb_s[nt*NP+np];
                            // Write cached data to output streams
                            dB_cache_stream.write(o_vec);
                            dB_cache_s_stream.write(s_vec);
                        }
                    }
                }
            }
        }

    }
   /**
     * @brief Performs multiplication operation on cached data.
     *
     * Reads cached data and input streams, performs multiplication with scaling, and writes to the output stream.
     *
     * @param dB_cache_stream Input stream of cached data with single element vectors.
     * @param dB_cache_s_stream Input stream of cached scale data with single element vectors.
     * @param u_stream Input stream of data with CP parallelism.
     * @param u_s_stream Input stream of scale data with single element vectors.
     * @param o_stream Output stream of computed results with CP parallelism.
     */
    void dBu_mul(
        hls::stream<hls::vector<A_T,      1> >& dB_cache_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& dB_cache_s_stream,
        hls::stream<hls::vector<A_T,      CP> >& u_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& u_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        hls::vector<A_T, CP> dB_vec;
        hls::vector<ASCALE_T, 1> dB_s_vec;
        hls::vector<A_T, CP> u_vec;
        hls::vector<ASCALE_T, 1> u_s_vec;
        // Iterate over channel tiles
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                // Iterate over projection tiles
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        // Iterate over hidden dimension parallelism
                        for(int np=0;np<NP;np++) {
                            #pragma HLS pipeline II=1
                            hls::vector<X_T, CP> o_vec;
                            // Read cached data
                            hls::vector<A_T, 1> i_vec=dB_cache_stream.read();
                            hls::vector<ASCALE_T, 1> s_vec=dB_cache_s_stream.read();
                            if(nt==0&&np==0) {
                                u_vec=u_stream.read();
                                u_s_vec=u_s_stream.read();
                            }
                            ap_uint<5> scale = s_vec[0] + u_s_vec[0];
                            for(int pp=0;pp<PP;pp++) {
                                #pragma HLS unroll
                                auto mul_res=i_vec[0]*u_vec[pp];
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
    /**
     * @brief Top-level function for the DBU operation.
     *
     * Orchestrates the caching and multiplication stages using dataflow optimization.
     *
     * @param dB_stream Input stream of data with CP parallelism.
     * @param dB_s_stream Input stream of scale data with single element vectors.
     * @param u_stream Input stream of data with CP parallelism.
     * @param u_s_stream Input stream of scale data with single element vectors.
     * @param o_stream Output stream of computed results with CP parallelism.
     */
    void do_dBu(
        hls::stream<hls::vector<A_T,      CP> >& dB_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& dB_s_stream,
        hls::stream<hls::vector<A_T,      CP> >& u_stream,
        hls::stream<hls::vector<ASCALE_T, 1 > >& u_s_stream,
        hls::stream<hls::vector<X_T,      CP> >& o_stream
    ) {
        #pragma HLS dataflow
 // Declare intermediate streams for caching
        hls::stream<hls::vector<A_T,      1> > dB_cache_stream  ( "dB_cache_stream"  );
        hls::stream<hls::vector<ASCALE_T, 1 > > dB_cache_s_stream  ( "dB_cache_s_stream"  );
// Execute caching stage
        dB_cache(
            dB_stream,
            dB_s_stream,
            dB_cache_stream,
            dB_cache_s_stream
        );
         // Execute multiplication stage
        dBu_mul(
            dB_cache_stream,
            dB_cache_s_stream,
            u_stream,
            u_s_stream,
            o_stream
        );
    }
};

#endif
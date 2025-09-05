/**
 * @file ht_add.h
 * @brief Header file for the HT_ADD class implementing addition and splitting operations for the Llama model.
 *
 * This class performs addition of two input streams, followed by splitting and adaptation of the resulting stream
 * into two output streams. The implementation is optimized for HLS with dataflow, pipelining, and unrolling directives.
 */
#ifndef __INT_HT_ADD_H__
#define __INT_HT_ADD_H__

#include "common.h"
#include "utils.h"
/**
 * @class HT_ADD
 * @brief Template class for addition and stream splitting operations in the Llama model.
 *
 * Performs element-wise addition of two input streams, splits the result into two streams, and adapts one of the streams
 * to match the required output format. The implementation is optimized for HLS synthesis.
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
class HT_ADD{
public:
/** @brief Number of channel tiles */
    static constexpr int CT = C / CP;
    /** @brief Number of hidden dimension tiles */
    static constexpr int NT2 = N / NP;
     /** @brief Number of projection tiles */
    static constexpr int PT = P / PP;
   /**
     * @brief Constructor for HT_ADD class.
     */
    HT_ADD(){
    }

        /**
     * @brief Performs element-wise addition of two input streams.
     *
     * Adds corresponding elements from the dAh and dBu streams and writes the result to the output stream.
     *
     * @param dAh_stream Input stream of dAh data with CP parallelism.
     * @param dBu_stream Input stream of dBu data with CP parallelism.
     * @param ht_stream Output stream of added results with CP parallelism.
     */
    void ht_add(
        hls::stream<hls::vector<X_T,      CP> >& dAh_stream,
        hls::stream<hls::vector<X_T,      CP> >& dBu_stream,
        hls::stream<hls::vector<X_T,      CP> >& ht_stream
    ) {
        
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        for(int np=0;np<NP;np++) {
                            #pragma HLS pipeline II=1
                            hls::vector<X_T, CP> dAh_vec=dAh_stream.read();
                            hls::vector<X_T, CP> dBu_vec=dBu_stream.read();
                            hls::vector<X_T, CP> o_vec;
      
                            for(int pp=0;pp<PP;pp++) {
                                #pragma HLS unroll
                                o_vec[pp]=dAh_vec[pp]+dBu_vec[pp];
                            }
                            ht_stream.write(o_vec);
                        }
                    }
                }
            }
        }

    }

        /**
     * @brief Splits the input stream into two output streams.
     *
     * Reads from the input stream, duplicates it to one output stream, and accumulates data into
     * a wider vector for the second output stream.
     *
     * @param ht_stream Input stream of data with CP parallelism.
     * @param ht1_stream Output stream of duplicated data with CP parallelism.
     * @param ht2_adapt_stream Output stream of accumulated data with NP*CP parallelism.
     */
    void ht_split(
        hls::stream<hls::vector<X_T,CP> >& ht_stream,
        hls::stream<hls::vector<X_T,CP> >& ht1_stream,
        hls::stream<hls::vector<X_T,NP*CP> >& ht2_adapt_stream
    ) {
        hls::vector<X_T,NP*CP> ht2_vec;
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        for(int np=0;np<NP;np++) {
                            #pragma HLS pipeline II=1
                            hls::vector<X_T, CP> i_vec=ht_stream.read();
                            for(int pp=0;pp<PP;pp++) {
                                #pragma HLS unroll
                                ht2_vec[np*PP+pp]= i_vec[pp];
                            }
                            ht1_stream.write(i_vec);
                            if(np==NP-1) {
                                ht2_adapt_stream.write(ht2_vec);
                            }   
                            
                        }
                    }
                }
            }
        }
        
    }

        /**
     * @brief Adapts the wide stream to match the output format.
     *
     * Reads from the wide input stream and reformats the data into the output stream with CP parallelism.
     *
     * @param ht2_adapt_stream Input stream of data with NP*CP parallelism.
     * @param ht2_stream Output stream of reformatted data with CP parallelism.
     */

    void ht2_adapt(
        hls::stream<hls::vector<X_T,NP*CP> >& ht2_adapt_stream,
        hls::stream<hls::vector<X_T,CP> >& ht2_stream
    ) {
        hls::vector<X_T,NP*CP> ht2_vec;
        for(int ct=0;ct<CT;ct++) {
            for(int cp=0;cp<CP;cp++) {
                for(int pt=0;pt<PT;pt++) { 
                    for(int nt=0;nt<NT2;nt++) {
                        for(int pp=0;pp<PP;pp++) {
                            #pragma HLS pipeline II=1
                            hls::vector<X_T, CP> o_vec;
                            if(pp==0) {
                                ht2_vec=ht2_adapt_stream.read();
                            }
                            for(int np=0;np<NP;np++) {
                                #pragma HLS unroll
                                o_vec[np]= ht2_vec[np*PP+pp];
                            }
                            ht2_stream.write(o_vec);                            
                        }
                    }
                }
            }
        }
        
    }

        /**
     * @brief Main function to perform addition, splitting, and adaptation.
     *
     * Executes the ht_add, ht_split, and ht2_adapt operations in a dataflow manner to process
     * input streams and produce two output streams.
     *
     * @param dAh_stream Input stream of dAh data with CP parallelism.
     * @param dBu_stream Input stream of dBu data with CP parallelism.
     * @param ht1_stream Output stream of added results with CP parallelism.
     * @param ht2_stream Output stream of reformatted results with CP parallelism.
     */
    void do_ht_add(
        hls::stream<hls::vector<X_T,CP> >& dAh_stream,
        hls::stream<hls::vector<X_T,CP> >& dBu_stream,
        hls::stream<hls::vector<X_T,CP> >& ht1_stream,
        hls::stream<hls::vector<X_T,CP> >& ht2_stream
    ) {
        #pragma HLS dataflow
        hls::stream<hls::vector<X_T, CP> > ht_stream ("ht_stream");
        hls::stream<hls::vector<X_T, NP*CP> > ht2_adapt_stream ("ht2_adapt_stream");
        #pragma HLS stream variable=ht_stream    depth=32
        #pragma HLS stream variable=ht2_adapt_stream    depth=32
        ht_add(
            dAh_stream,
            dBu_stream,
            ht_stream
        );
        ht_split(
            ht_stream,
            ht1_stream,
            ht2_adapt_stream
        );
        ht2_adapt(
            ht2_adapt_stream,
            ht2_stream
        );
    }
};

#endif
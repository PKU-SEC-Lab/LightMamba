#ifndef __INT_GEMM_BUFFER_H__
#define __INT_GEMM_BUFFER_H__

#include "common.h"
#include "utils.h"
/**
 * @brief A templated GEMM buffer utility class for reading/writing tiled data in HLS.
 * 
 * This class provides methods to read from and write to multi-dimensional buffers with 
 * tiling along dimensions T and C. It is intended for HLS (High-Level Synthesis) with 
 * Xilinx toolchains, making extensive use of streams and pipelining for performance.
 * 
 * @tparam data_t The data type of the buffer elements.
 * @tparam H      The number of heads or independent buffers.
 * @tparam T      The size along the T dimension (must be divisible by TP).
 * @tparam TP     The tile size for the T dimension.
 * @tparam C      The size along the C dimension (must be divisible by CP).
 * @tparam CP     The tile size for the C dimension.
 */
template<
    class data_t,
    int H,
    int T,
    int TP,
    // T is complete unrolled when fetched, but tiled when streaming in
    int C,
    int CP>
class GEMM_BUFFER{
public:

    static_assert(T % TP == 0, "T must be multiple of TP");
    static_assert(C % CP == 0, "C must be multiple of CP");

    static constexpr int TT = T / TP;
    static constexpr int CT = C / CP;

    /**
     * @brief Read a buffer from a packed input stream.
     * 
     * This function reads data from a stream where each vector contains TP*CP elements 
     * and unpacks it into a 5D buffer.
     * 
     * @param BUF      Output buffer to store the read data.
     * @param i_stream Input stream of packed vectors (TP*CP).
     */
    void rd_buffer(
        data_t BUF[H][TT][TP][CT][CP],
        hls::stream<hls::vector<data_t, TP*CP> > &i_stream
    ){
        #pragma HLS inline
        // first, fetch from xln stream, granularity is TP*CP
        for(int h=0; h<H; ++h){
            for(int tt=0; tt<TT; ++tt){
                for(int ct=0; ct<CT; ++ct){
                    #pragma HLS pipeline II=1
                    // #pragma HLS pipeline off
                    hls::vector<data_t, TP*CP> i_vec = i_stream.read();
                    for(int tp=0; tp<TP; ++tp){
                        for(int cp=0; cp<CP; ++cp){
                            #pragma HLS unroll
                            BUF[h][tt][tp][ct][cp] = i_vec[tp*CP+cp];
                        }
                    }
                }
            }
        }
    }
   /**
     * @brief Read a buffer from an unpacked input stream.
     * 
     * This function reads vectors of size CP multiple times to fill a TP*CP tile.
     * 
     * @param BUF      Output buffer to store the read data.
     * @param i_stream Input stream of unpacked vectors (CP).
     */
    void rd_buffer_unpack(
        data_t BUF[H][TT][TP][CT][CP],
        hls::stream<hls::vector<data_t, CP> > &i_stream
    ){
        #pragma HLS inline
        // unpacked input data, although the tile shape is TP*CP, it is unpacked to CP; need to read multiple times
        for(int h=0; h<H; ++h){
            for(int ct=0; ct<CT; ++ct){
                for(int tt=0; tt<TT; ++tt){
                    for(int tp=0; tp<TP; ++tp){
                        #pragma HLS pipeline II=1
                        // #pragma HLS pipeline off
                        hls::vector<data_t, CP> i_vec = i_stream.read();
                        for(int cp=0; cp<CP; ++cp){
                            #pragma HLS unroll
                            BUF[h][tt][tp][ct][cp] = i_vec[cp];
                        }
                    }
                }
            }
        }
    }
    /**
     * @brief Write the buffer content to an output stream.
     * 
     * This function flattens a TP*CP tile and writes it as a vector of T*CP.
     * 
     * @param BUF      Input buffer to be written.
     * @param R        Number of repetitions (e.g., output rows).
     * @param o_stream Output stream for the packed data.
     */
    void wr_buffer(
        data_t BUF[H][TT][TP][CT][CP],
        int R, 
        hls::stream<hls::vector<data_t, T*CP> > &o_stream
    ){
        #pragma HLS inline
        // fetch from xln buffer, fully unroll T, repeat multiple times to generate all heads / QKV / output channels
        for(int h=0; h<H; ++h){
            for(int r=0; r<R; ++r){
                for(int ct=0; ct<CT; ++ct){
                    #pragma HLS pipeline II=1
                    hls::vector<data_t, T*CP> o_vec;
                    for(int tt=0; tt<TT; ++tt){
                        for(int tp=0; tp<TP; ++tp){
                            for(int cp=0; cp<CP; ++cp){
                                #pragma HLS unroll
                                o_vec[tt*TP*CP+tp*CP+cp] = BUF[h][tt][tp][ct][cp];
                            }
                        }
                    }
                    // wr_buffer to stream
                    o_stream.write(o_vec);
                }
            }
        }
    }
    /**
     * @brief Write the buffer content to an output stream with reordered H and R loops.
     * 
     * Similar to wr_buffer, but the outer loop is over R before H.
     * 
     * @param BUF      Input buffer to be written.
     * @param R        Number of repetitions (e.g., output rows).
     * @param o_stream Output stream for the packed data.
     */
    void wr_buffer_merge(
        data_t BUF[H][TT][TP][CT][CP],
        int R, 
        hls::stream<hls::vector<data_t, T*CP> > &o_stream
    ){
        #pragma HLS inline
        // exchange the order
        for(int r=0; r<R; ++r){
            for(int h=0; h<H; ++h){
                for(int ct=0; ct<CT; ++ct){
                    #pragma HLS pipeline II=1
                    hls::vector<data_t, T*CP> o_vec;
                    for(int tt=0; tt<TT; ++tt){
                        for(int tp=0; tp<TP; ++tp){
                            for(int cp=0; cp<CP; ++cp){
                                #pragma HLS unroll
                                o_vec[tt*TP*CP+tp*CP+cp] = BUF[h][tt][tp][ct][cp];
                            }
                        }
                    }
                    // wr_buffer to stream
                    o_stream.write(o_vec);
                }
            }
        }
    }

    /**
     * @brief Performs a complete buffer operation: read from stream and write to stream.
     * 
     * Uses packed TP*CP vectors for input and writes flattened T*CP vectors.
     * 
     * @param R        Number of write repetitions.
     * @param i_stream Input stream with packed data.
     * @param o_stream Output stream with flattened data.
     */
    void do_buffer(
        int R,
        hls::stream<hls::vector<data_t, TP*CP> > &i_stream,
        hls::stream<hls::vector<data_t, T *CP> > &o_stream
    ){
        data_t BUF[H][TT][TP][CT][CP]; // buffer
        #pragma HLS array_partition variable=BUF complete dim=2
        #pragma HLS array_reshape   variable=BUF complete dim=3
        #pragma HLS array_reshape   variable=BUF complete dim=5
        rd_buffer(BUF,            i_stream);
        wr_buffer(BUF,      R,    o_stream);
    }

     /**
     * @brief Performs a complete buffer operation with merged write order.
     * 
     * @param R        Number of write repetitions.
     * @param i_stream Input stream with packed data.
     * @param o_stream Output stream with flattened data.
     */
    void do_buffer_merge(
        int R,
        hls::stream<hls::vector<data_t, TP*CP> > &i_stream,
        hls::stream<hls::vector<data_t, T *CP> > &o_stream
    ){
        data_t BUF[H][TT][TP][CT][CP]; // buffer
        #pragma HLS array_partition variable=BUF complete dim=2
        #pragma HLS array_reshape   variable=BUF complete dim=3
        #pragma HLS array_reshape   variable=BUF complete dim=5
        rd_buffer      (BUF,                i_stream);
        wr_buffer_merge(BUF,        R,      o_stream);
    }
    /**
     * @brief Performs a buffer operation using unpacked input data.
     * 
     * Reads from CP-sized vectors multiple times to form TP*CP tiles.
     * 
     * @param R        Number of write repetitions.
     * @param i_stream Input stream with unpacked data.
     * @param o_stream Output stream with flattened data.
     */
    void do_buffer_unpack(
        int R,
        hls::stream<hls::vector<data_t,    CP> > &i_stream,
        hls::stream<hls::vector<data_t, T *CP> > &o_stream
    ){
        data_t BUF[H][TT][TP][CT][CP]; // buffer
        #pragma HLS array_partition variable=BUF complete dim=2
        #pragma HLS array_reshape   variable=BUF complete dim=3
        #pragma HLS array_reshape   variable=BUF complete dim=5

        rd_buffer_unpack(BUF,              i_stream);
        wr_buffer       (BUF,       R,     o_stream);
    }

};




#endif
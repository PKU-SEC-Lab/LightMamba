/**
 * @file softplus.h
 * @brief Header file for the SOFTPLUS class implementing the softplus activation function.
 *
 * This class applies the softplus activation function using lookup tables for efficient
 * computation. The implementation is optimized for HLS with pipelining and unrolling directives.
 */

#ifndef __INT_SOFTPLUS_H__
#define __INT_SOFTPLUS_H__

#include "common.h"
#include "utils.h"

// SOFTPLUS
/** @brief Log2 denominator for indexing the softplus lookup table */
constexpr int SOFTPLUS_LOG2DENOM        = 4;
/** @brief Log2 denominator for indexing the scale lookup table */
constexpr int SOFTPLUS_LOG2DENOM_S      = 11;
/** @brief Number of entries in the softplus lookup table */
constexpr int SOFTPLUS_ENTRIES          = 4096;
/** @brief Number of entries in the scale lookup table */
constexpr int SOFTPLUS_ENTRIES_S        = 32;
/** @brief Offset for input normalization */
constexpr int alpha = -25600;

// arrays
/**
 * @brief Lookup table for softplus activation values.
 */
constexpr int SOFTPLUS_tABLE          [] = {
    #include "../../../ref/tables/softplus_table.txt"
};

/**
 * @brief Lookup table for scale values of the softplus activation.
 */
constexpr int SOFTPLUS_tABLE_S          [] = {
    #include "../../../ref/tables/softplus_table_s.txt"
};

/**
 * @class SOFTPLUS
 * @brief Template class for applying the softplus activation function.
 *
 * Processes input streams by applying the softplus function using lookup tables and produces
 * output streams with specified parallelism.
 *
 * @tparam if_t Input data type.
 * @tparam softplus_t Output data type.
 * @tparam T Sequence length.
 * @tparam TP Time parallelism.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 */
template<
    class if_t,
    class softplus_t,
    int T,
    int TP,
    int C,
    int CP
>

class SOFTPLUS{
public:

    static constexpr int TT    = T    / TP;
    static constexpr int CT    = C    / CP;
    /**
     * @brief Constructor for SOFTPLUS class.
     */
    SOFTPLUS(){}
    /**
     * @brief Applies the softplus activation function to the input stream.
     *
     * Reads the input stream, computes the softplus activation using lookup tables, and writes
     * the results to the output stream.
     *
     * @param i_stream Input stream of data with TP*CP parallelism.
     * @param o_stream Output stream of softplus-activated data with TP*CP parallelism.
     */
    void do_softplus(
        hls::stream<hls::vector<if_t, TP * CP> > &i_stream, 
        hls::stream<hls::vector<softplus_t, TP * CP> > &o_stream
        ){
            for(int tt=0; tt<TT; ++tt){
                for(int ct=0; ct<CT; ++ct){
                    for(int tmp=0;tmp<4;tmp++) {
                        #pragma HLS pipeline II=1
                        if(tmp==0) {
                            hls::vector<if_t, TP * CP>    xug_vec = i_stream.read();
                            hls::vector<softplus_t, TP * CP>   softplus_vec;
                            // Apply softplus activation for each element
                            for(int tp=0; tp<TP; ++tp){
                                for(int cp=0; cp<CP; ++cp){
                                    #pragma HLS unroll
                                    // index
                                    // Compute index for lookup tables
                                    int idx = tp * CP + cp;
                                    int LUT_IDX = (xug_vec[idx] - alpha) >> SOFTPLUS_LOG2DENOM;
                                    int LUT_S_IDX = (xug_vec[idx] - alpha) >> SOFTPLUS_LOG2DENOM_S;
                                    // Clamp indices to valid range
                                    LUT_IDX = clamp(LUT_IDX, 0, SOFTPLUS_ENTRIES - 1);
                                    LUT_S_IDX = clamp(LUT_S_IDX, 0, SOFTPLUS_ENTRIES_S - 1);

                                    // Retrieve softplus and scale values
                                    auto SOFTPLUS_val = SOFTPLUS_tABLE[LUT_IDX];
                                    auto SOFTPLUS_s   = SOFTPLUS_tABLE_S[LUT_S_IDX];
                                     // Apply scaling to softplus value
                                    softplus_vec[idx] = SOFTPLUS_val << SOFTPLUS_s;
                                }
                            }
                            // Write result to output stream
                            o_stream.write(softplus_vec);
                        }
                    }
                } // end of cmt loop
            } // end of tt loop
        }

};

#endif
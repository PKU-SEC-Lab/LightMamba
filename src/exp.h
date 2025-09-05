/**
 * @file int_exp.h
 * @brief Header for EXP class implementing exponential LUT-based transformation using HLS.
 */
#ifndef __INT_EXP_H__
#define __INT_EXP_H__

#include "common.h"
#include "utils.h"


// EXP
/**
 * @def EXP_LOG2DENOM
 * @brief Base-2 logarithm denominator for exponential LUT indexing.
 */
constexpr int EXP_LOG2DENOM        = 3;
/**
 * @def EXP_LOG2DENOM_S
 * @brief Secondary log2 denominator for shift LUT indexing.
 */
constexpr int EXP_LOG2DENOM_S      = 10;
/**
 * @def EXP_ENTRIES
 * @brief Number of entries in the exponential lookup table.
 */
constexpr int EXP_ENTRIES          = 4096;
/**
 * @def EXP_ENTRIES_S
 * @brief Number of entries in the shift lookup table.
 */
constexpr int EXP_ENTRIES_S        = 32;
/**
 * @def alpha
 * @brief Offset constant used to shift the input value before indexing LUT.
 */
constexpr int alpha = -20480;

// arrays
constexpr int exp_tABLE          [] = {
    #include "../../../ref/tables/exp_table.txt"
};

/**
 * @brief Exponential shift table (used to determine left shift for scaling).
 */
constexpr int exp_tABLE_S          [] = {
    #include "../../../ref/tables/exp_table_s.txt"
};

/**
 * @class EXP
 * @brief Template class implementing exponential transformation using lookup tables and HLS.
 *
 * This class takes a stream of input vectors, applies a LUT-based exponential transformation
 * and writes the result to the output stream. The transformation uses both a value and a scaling table.
 *
 * @tparam if_t   Input data type
 * @tparam exp_t  Output data type
 * @tparam T      Total number of elements along time dimension
 * @tparam TP     Parallelism factor along time
 * @tparam C      Total number of elements along channel dimension
 * @tparam CP     Parallelism factor along channel
 */
template<
    class if_t,
    class exp_t,
    int T,
    int TP,
    int C,
    int CP
>
class EXP{
public:

    static constexpr int TT    = T    / TP;
    static constexpr int CT    = C    / CP;
   /**
     * @brief Default constructor.
     */
    EXP(){}
    /**
     * @brief Perform exponential transformation on input stream.
     *
     * Reads vectorized input data from `i_stream`, performs a lookup-table-based
     * exponential transformation with scaling, and writes the results to `o_stream`.
     * 
     * @param i_stream Input stream of type `hls::stream<hls::vector<if_t, TP * CP>>`
     * @param o_stream Output stream of type `hls::stream<hls::vector<exp_t, TP * CP>>`
     */
    void do_exp(
        hls::stream<hls::vector<if_t, TP * CP> > &i_stream, 
        hls::stream<hls::vector<exp_t, TP * CP> > &o_stream
        ){
            for(int tt=0; tt<TT; ++tt){
                for(int ct=0; ct<CT; ++ct){
                    for(int tmp=0;tmp<5;tmp++) {
                        #pragma HLS pipeline II=1
                        if(tmp==0) {
                            hls::vector<if_t, TP * CP>    xug_vec = i_stream.read();
                            hls::vector<exp_t, TP * CP>   exp_vec;
                            
                            for(int tp=0; tp<TP; ++tp){
                                for(int cp=0; cp<CP; ++cp){
                                    #pragma HLS unroll
                                    // index
                                    int idx = tp * CP + cp;
                                     // Compute indices into both LUTs
                                    int LUT_IDX = (xug_vec[idx] - alpha) >> EXP_LOG2DENOM;
                                    int LUT_S_IDX = (xug_vec[idx] - alpha) >> EXP_LOG2DENOM_S;
                                    // Clamp indices to table bounds
                                    LUT_IDX = clamp(LUT_IDX, 0, EXP_ENTRIES - 1);
                                    LUT_S_IDX = clamp(LUT_S_IDX, 0, EXP_ENTRIES_S - 1);
                                    // Lookup and scale result
                                    auto EXP_val = exp_tABLE[LUT_IDX];
                                    auto EXP_s   = exp_tABLE_S[LUT_S_IDX];
                                    exp_vec[idx] = EXP_val << EXP_s;
                                }
                            }

                            o_stream.write(exp_vec);
                        }
                    }
                }
            } // end of cmt loop
        } // end of tt loop
    

};

#endif
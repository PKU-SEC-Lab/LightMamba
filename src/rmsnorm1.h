/**
 * @file int_rmsnorm1.h
 * @brief Header file for the RMSNORM class implementing RMS normalization for the Llama model.
 *
 * This class performs RMS (Root Mean Square) normalization on streaming input data using lookup tables
 * for reciprocal square root computation. The implementation is optimized for HLS with pipelining,
 * unrolling, and array reshaping directives.
 */
#ifndef __INT_RMSNORM1_H__
#define __INT_RMSNORM1_H__

#include "common.h"
#include "utils.h"
#include <hls_math.h>

// RMSNORM_RSQRT
/** @brief Number of bits for RSQRT lookup table indexing */
constexpr int RSQRT_BITS = 8;
/** @brief Number of entries in each RSQRT lookup table */
constexpr int RSQRT_ENTRIES = 512;
/** @brief Number of RSQRT lookup tables */
constexpr int RSQRT_NUM_TABLES = 8;
/** @brief Truncation shift for first multiplication in RSQRT computation */
constexpr int RSQRT_TRUNC_MUL1 = 12;
/** @brief Truncation shift for second multiplication in RSQRT computation */
constexpr int RSQRT_TRUNC_MUL2 = 8;

/** @brief Log2 denominators for RSQRT lookup table indexing */
constexpr int RSQRT_LOG2DENOMS[] = {
    #include "../../../ref/tables/rmsnorm1_log2denoms.txt"
};

/** @brief Alpha offsets for RSQRT lookup table selection */
constexpr int64_t RSQRT_ALPHAS[] = {
    #include "../../../ref/tables/rmsnorm1_alphas.txt"
};

/** @brief RSQRT lookup tables for reciprocal square root computation */
constexpr int RSQRT_TABLES[] = {
    #include "../../../ref/tables/rmsnorm1_tables.txt"
};

/** @brief Offset differences for RSQRT lookup table adjustments */
constexpr int RSQRT_OFFSETS_DIFF[] = {
    #include "../../../ref/tables/rmsnorm1_offsets_diff.txt"
};

/** @brief RMS normalization weight values */
constexpr int RMSNORM_LNW[] = {
    #include "../../../ref/weights/rmsnorm1_wq.txt"
};

/**
 * @class RMSNORM
 * @brief Template class for performing RMS normalization in the Llama model.
 *
 * Computes RMS normalization on input data streams, applying weights and using lookup tables for
 * reciprocal square root calculations. The implementation is optimized for HLS synthesis.
 *
 * @tparam L Number of layers.
 * @tparam T Sequence length.
 * @tparam TP Time parallelism.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 */
template<
    int L, 
    int T,
    int TP,
    int C,
    int CP
>
class RMSNORM{
public:

/**< Ensure T is divisible by TP */
    static_assert(T % TP == 0, "T % TP != 0");
    /**< Ensure C is divisible by CP */
    static_assert(C % CP == 0, "C % CP != 0");

    /** @brief Number of time tiles */
    static constexpr int TT = T / TP;
    /** @brief Number of channel tiles */
    static constexpr int CT = C / CP;

    /** @brief Weight matrix for RMS normalization, dimensioned as [L][C] */
    LNW1_T LNW[L][C];
    /** @brief Buffer for input data, dimensioned as [TP][C] */
    X_T X_BUF[TP][C];
    /** @brief Buffer for sum of squared input values, dimensioned as [TP] */
    X_POW2SUM_T X_POW2SUM[TP];
    /** @brief Buffer for reciprocal square root values, dimensioned as [TP] */
    X_RSQRT_T X_RSQRT[TP];


    /**
     * @brief Constructor for RMSNORM class.
     *
     * Initializes the weight matrix from the provided initialization array.
     *
     * @tparam init_t Data type for initialization array.
     * @param lnw_init Initialization array for RMS normalization weights.
     */
    template<typename init_t>
    RMSNORM(const init_t lnw_init[L*C]){
        for(int l=0; l<L; ++l){
            for(int c=0; c<C; ++c){
                LNW[l][c] = lnw_init[l*C + c];
            }
        }
    }

     /**
     * @brief Performs RMS normalization on an input stream for a specific layer.
     *
     * Reads input data stream, computes the RMS normalization by calculating the reciprocal square root
     * of the sum of squared inputs, applies weights, and writes the normalized output to the output stream.
     *
     * @param l Layer index to process.
     * @param i_stream Input stream of data with TP*CP parallelism.
     * @param o_stream Output stream of normalized data with TP*CP parallelism.
     */
    void do_rmsnorm(int l, hls::stream<hls::vector<X_T, TP * CP> > &i_stream, hls::stream<hls::vector<XLN_T, TP * CP> > &o_stream){
        // shaping
        /**< Fully reshape first dimension of X_BUF */
        #pragma HLS array_reshape variable=X_BUF        complete              dim=1
        /**< Cyclically reshape second dimension of X_BUF */
        #pragma HLS array_reshape variable=X_BUF        cyclic      factor=CP dim=2
        /**< Fully reshape X_POW2SUM */
        #pragma HLS array_reshape variable=X_POW2SUM    complete
        /**< Fully reshape X_RSQRT */
        #pragma HLS array_reshape variable=X_RSQRT      complete


        /**< Cyclically reshape first dimension of LNW */
        #pragma HLS array_reshape variable=LNW          cyclic      factor=1 dim=1
        /**< Cyclically reshape second dimension of LNW */
        #pragma HLS array_reshape variable=LNW          cyclic      factor=CP dim=2

        // bind storage
        #pragma HLS bind_storage variable=X_BUF         type=ram_2p impl=URAM /**< Bind X_BUF to URAM */
        #pragma HLS bind_storage variable=X_POW2SUM     type=ram_2p impl=LUTRAM  /**< Bind X_POW2SUM to LUTRAM */
        #pragma HLS bind_storage variable=X_RSQRT       type=ram_2p impl=LUTRAM   /**< Bind X_RSQRT to LUTRAM */

        #pragma HLS bind_storage variable=LNW           type=ram_2p impl=URAM  /**< Bind LNW to URAM */
        
        /**< Iterate over time tiles */
        for(int tt=0; tt<TT; ++tt){
            
               // Stage 1: Calculate sum of squared inputs
            for(int ct=0; ct<CT; ++ct){   /**< Iterate over channel tiles */
                    #pragma HLS pipeline II=1  /**< Enable pipelining with initiation interval of 1 */

                    // read input stream
                    hls::vector<X_T, TP * CP> i_vec = i_stream.read();
                    // reset X_POW2SUM
                    if(ct == 0){
                        for(int tp=0; tp<TP; ++tp){
                            /**< Unroll loop for parallel processing */
                            #pragma HLS unroll
                             /**< Initialize sum of squares */
                            X_POW2SUM[tp] = 0;
                        }
                    }
                    // calculate X_POW2SUM
                    for(int tp=0; tp<TP; ++tp){
                        for(int cp=0; cp<CP; ++cp){  /**< Iterate over channel parallelism */
                            #pragma HLS unroll 
                            X_BUF[tp][ct*CP + cp]   = i_vec[tp*CP + cp];   /**< Store input in buffer */

                            /**< Accumulate sum of squares */
                            X_POW2SUM[tp]           = X_POW2SUM[tp] + i_vec[tp*CP + cp] * i_vec[tp*CP + cp];
                        }
                    }
                }

             // Stage 2: Calculate reciprocal square root
            for(int tp=0; tp<TP; ++tp){
                    // calculate X_RSQRT
                    int LUT_IDX = 0; /**< Initialize lookup table index */
                    for(int i=0; i<RSQRT_NUM_TABLES; ++i){  /**< Select appropriate lookup table */
                        #pragma HLS unroll
                        if(X_POW2SUM[tp] >= RSQRT_ALPHAS[i]){
                            LUT_IDX = i;  /**< Update lookup table index */
                        }
                    }
                auto ALPHA = RSQRT_ALPHAS[LUT_IDX]; /**< Get alpha offset */
                auto LOG2DENOM = RSQRT_LOG2DENOMS[LUT_IDX]; /**< Get log2 denominator */
                auto OFFSET_DIFF = RSQRT_OFFSETS_DIFF[LUT_IDX]; /**< Get offset difference */
                auto INDEX = clamp((X_POW2SUM[tp] - ALPHA) >> LOG2DENOM, 0, RSQRT_ENTRIES - 1); /**< Compute lookup index */
                X_RSQRT[tp] = RSQRT_TABLES[LUT_IDX * RSQRT_ENTRIES + INDEX] << OFFSET_DIFF; /**< Compute reciprocal square root */
                }



             // Stage 3: Compute normalized output
            for(int ct=0; ct<CT; ++ct){
                    #pragma HLS pipeline II=1

                    // hls::vector<LNW_T, CP> lnw_vec;
                    // for(int cp=0; cp<CP; ++cp){
                    //     #pragma HLS unroll
                    //     // calculate X_MUL_X_RSQRT
                    //     lnw_vec[cp] = LNW[l][ct * CP + cp];
                    // }

                    hls::vector<XLN_T, TP * CP> o_vec;
                    for(int tp=0; tp<TP; ++tp){
                        for(int cp=0; cp<CP; ++cp){
                            #pragma HLS unroll   /**< Unroll loop for parallel processing */
                            // calculate X_MUL_X_RSQRT

                            /**< Compute scaled input */
                            auto X_MUL_X_RSQRT = (X_BUF[tp][ct * CP + cp] * X_RSQRT[tp]) >> RSQRT_TRUNC_MUL1;

                             /**< Apply weight and truncate */
                            o_vec[tp * CP + cp] = (X_MUL_X_RSQRT * LNW[l][ct * CP + cp]) >> RSQRT_TRUNC_MUL2;
                            // o_vec[tp * CP + cp] = (X_MUL_X_RSQRT * lnw_vec[cp]) >> RSQRT_TRUNC_MUL2;
                    }

                     /**< Write normalized vector to output stream */
                    o_stream.write(o_vec);
                }
            }
    
        }

    }
};

#endif
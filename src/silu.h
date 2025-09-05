/**
 * @brief Header file for the SILU class implementing the Sigmoid Linear Unit activation function.
 *
 * This class implements the SiLU (Sigmoid Linear Unit) activation function for streaming data using lookup tables.
 * The implementation is optimized for HLS with pipelining and unrolling directives.
 */

#ifndef __INT_SILU_H__
#define __INT_SILU_H__

#include "common.h"
#include "utils.h"

// LLM constants
// constexpr int SILU_HYPERPARAMS   [] = {
//     #include "src/ref/MLP_SILU_HYPERPARAMS.txt"
// };

// SILU silu(x) = x/(1+exp(-x))
/** @brief Log2 denominator for SiLU value lookup table indexing */
constexpr int SILU_LOG2DENOM = 5;
/** @brief Log2 denominator for SiLU shift lookup table indexing */
constexpr int SILU_LOG2DENOM_S = 12;
/** @brief Number of entries in the SiLU value lookup table */
constexpr int SILU_ENTRIES = 4096;
/** @brief Number of entries in the SiLU shift lookup table */
constexpr int SILU_ENTRIES_S = 32;
/** @brief Alpha offset for SiLU lookup table indexing */
constexpr int alpha = -25600;

// Lookup table to implement silu() calculation
/** @brief Lookup table for SiLU values */
constexpr int silu_tABLE          [] = {
    #include "../../../ref/tables/silu_table.txt"
};

/** @brief Lookup table for SiLU shift values */
constexpr int silu_tABLE_S          [] = {
    #include "../../../ref/tables/silu_table_s.txt"
};


/**
 * @class SILU
 * @brief Template class for computing the SiLU activation function in the Llama model.
 *
 * Processes input stream data in blocks, applies the SiLU activation function using lookup tables,
 * and produces an output stream. The implementation is optimized for HLS synthesis.
 *
 * @tparam if_t Input data type for the SiLU operation.
 * @tparam silu_t Output data type for the SiLU operation.
 * @tparam T Sequence length.
 * @tparam TP Time parallelism.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 */
template<
    class if_t,
    class silu_t,
    int T,
    int TP,
    int C,
    int CP
>
// A class implementing the SiLU (Sigmoid Linear Unit) activation function for streaming data.
// Processes input stream data in blocks and applies SiLU using lookup tables.
class SILU{
public:

    /** @brief Number of time tiles */
    static constexpr int TT = T / TP;
    /** @brief Number of channel tiles */
    static constexpr int CT = C / CP;

    /**
     * @brief Constructor for SILU class.
     */
    SILU(){}

    /**
     * @brief Computes the SiLU activation function on an input stream.
     *
     * Reads vectors from the input stream, applies the SiLU activation function using lookup tables,
     * and writes the results to the output stream.
     *
     * @param i_stream Input stream containing vectors of type if_t with TP*CP elements.
     * @param o_stream Output stream to store vectors of type silu_t with TP*CP elements.
     */
    void do_silu(
        hls::stream<hls::vector<if_t, TP * CP> > &i_stream, 
        hls::stream<hls::vector<silu_t, TP * CP> > &o_stream
        ){
            for(int tt=0; tt<TT; ++tt){
                // Iterate over channel tiles
                for(int ct=0; ct<CT; ++ct){
                #pragma HLS pipeline II=1  // Enable pipelining with initiation interval of 1
                // Read a vector from the input stream
                hls::vector<if_t, TP * CP>    xug_vec = i_stream.read();
                // Create a vector for SiLU output
                hls::vector<silu_t, TP * CP>   silu_vec;
                // // Process each element in the vector
                for(int tp=0; tp<TP; ++tp){
                    for(int cp=0; cp<CP; ++cp){
                        #pragma HLS unroll // Unroll the loop for parallel processing
                        // index
                        // Compute the linear index
                        int idx = tp * CP + cp;
                        // Compute lookup table indices for SiLU value and shift
                        int LUT_IDX = (xug_vec[idx] - alpha) >> SILU_LOG2DENOM;
                        int LUT_S_IDX = (xug_vec[idx] - alpha) >> SILU_LOG2DENOM_S;
                         // Clamp indices to valid lookup table ranges
                        LUT_IDX = clamp(LUT_IDX, 0, SILU_ENTRIES - 1);
                        LUT_S_IDX = clamp(LUT_S_IDX, 0, SILU_ENTRIES_S - 1);
                        // Retrieve SiLU value and shift from lookup tables
                        auto SILU_val = silu_tABLE[LUT_IDX];
                        auto SILU_s   = silu_tABLE_S[LUT_S_IDX];
                        // Compute the final SiLU output by applying the shift
                        silu_vec[idx] = SILU_val << SILU_s;
                    }
                }
                // Write the computed SiLU vector to the output stream
                o_stream.write(silu_vec);

            } // end of cmt loop
        } // end of tt loop
    }

};

#endif
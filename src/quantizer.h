/**
 * @file quantizer.h
 * @brief Header file for the QUANTIZER class implementing dynamic quantization.
 *
 * This class performs dynamic quantization on input data streams, splitting data into groups,
 * calculating scaling factors, and producing quantized output and scale streams. The implementation
 * is optimized for HLS with pipelining, unrolling, and array partitioning directives.
 */
#ifndef __INT_QUANTIZER_H__
#define __INT_QUANTIZER_H__

#include "common.h"
#include "utils.h"

// LLM constants
/**
 * @brief Computes the ceiling of the base-2 logarithm for a given value.
 *
 * Used to calculate scaling factors for quantization. Handles powers of 2 and zero cases
 * using a priority encoder approach.
 *
 * @param x Input value of type ap_int<DW_X>.
 * @return int8_t Ceiling of the base-2 logarithm of the input value.
 */
template<int DW_X>
int8_t log2ceil(ap_int<DW_X> x) {
    #pragma HLS inline
    if(x >= 1) x = x - 1; 
    // handling the case of 2's power, such as 2, 4, 8, etc. Also suitable for 0
    // instead of non-deterministic while loop, we use for loop; a priority encoder
    for (int i = DW_X; i >= 1; --i) {
        if (x[i-1] == 1) {
            return i;
        }
    }
    return 0;
}


// since the quantizer is not only used after GeMM, but also after layernorm and other places,
// it should support different data types
/**
 * @class QUANTIZER
 * @brief Template class for dynamic quantization of input data streams.
 *
 * Splits input data into groups, computes the absolute maximum per group, calculates scaling
 * factors, and applies quantization to produce output and scale streams.
 *
 * @tparam if_t Input data type.
 * @tparam of_t Output data type.
 * @tparam sf_t Scale data type.
 * @tparam L Number of layers.
 * @tparam T Sequence length.
 * @tparam TP Time parallelism.
 * @tparam C Channel dimension size.
 * @tparam CP Channel parallelism.
 * @tparam G Group size for quantization.
 */
template<
    class if_t,
    class of_t,
    class sf_t,
    int L,
    int T,
    int TP,
    int C, 
    int CP,
    int G
> class QUANTIZER {
public:
    // static assertion
    // Static assertions to ensure valid parameter configurations
    static_assert(T % TP == 0, "T % TP != 0");
    static_assert(C % CP == 0, "C % CP != 0");
    static_assert(CP % G == 0, "CP % G != 0");
    /** @brief Number of time tiles */
    static constexpr int TT = T / TP;
    /** @brief Number of channel tiles */
    static constexpr int CT = C / CP;
    /** @brief Number of channels per group */
    static constexpr int CG = C / G;
    /** @brief Number of channel parallel groups */
    static constexpr int CPG = CP / G;

    // get quantization bits out of "of_t"
    /** @brief Quantization bits derived from output data type */
    int Q_BITS = of_t::width;
    /** @brief Maximum quantization value */
    int Q_MAX = +(1 << (Q_BITS - 1)) - 1;
    /** @brief Minimum quantization value */
    int Q_MIN = -(1 << (Q_BITS - 1));
    /** @brief Maximum clamp value for scaling */
    static constexpr int A_CLAMP_MAX = 15;

        /**
     * @brief Performs dynamic quantization on the input stream.
     *
     * Reads the input stream, splits data into groups, computes the absolute maximum per group,
     * calculates scaling factors, applies quantization, and writes to output and scale streams.
     *
     * @param i_stream Input stream of data with TP*CP parallelism.
     * @param o_stream Output stream of quantized data with TP*CP parallelism.
     * @param s_stream Output stream of scale data with TP*CPG parallelism.
     */
    void do_quant(
        hls::stream<hls::vector<if_t, TP*CP > >& i_stream, 
        hls::stream<hls::vector<of_t, TP*CP > >& o_stream,
        hls::stream<hls::vector<sf_t, TP*CPG> >& s_stream
    ) {
        // Iterate over layers
        for(int l=0; l<L; ++l){
            for(int tt=0; tt<TT; ++tt){
                for(int ct=0; ct<CT; ++ct){
                    #pragma HLS pipeline II=1

                    // data preparation， Read input vector
                    hls::vector<if_t, TP*CP > i_vec = i_stream.read();
                    hls::vector<of_t, TP*CP > o_vec;
                    hls::vector<sf_t, TP*CPG> s_vec;
                   // Split input into groups 
                    if_t i_group[TP][CPG][G];
                    #pragma HLS array_partition variable=i_group complete dim=1
                    #pragma HLS array_partition variable=i_group complete dim=2
                    #pragma HLS array_partition variable=i_group complete dim=3
                    // split
                    for(int tp=0; tp<TP; ++tp){
                        for(int cpg=0; cpg<CPG; ++cpg){
                            for(int g=0; g<G; ++g){
                                #pragma HLS unroll
                                i_group[tp][cpg][g] = i_vec[tp*CP + cpg*G + g];
                            }
                        }
                    }
                    // for each group, find abs max
                    // Find absolute maximum per group
                    if_t abs_max[TP][CPG];
                    #pragma HLS array_partition variable=abs_max complete dim=1
                    #pragma HLS array_partition variable=abs_max complete dim=2
                     // Initialize abs_max
                    for(int tp=0; tp<TP; ++tp){
                        for(int cpg=0; cpg<CPG; ++cpg){
                            #pragma HLS unroll
                            abs_max[tp][cpg] = 0;
                        }
                    }
                    for(int tp=0; tp<TP; ++tp){
                        for(int cpg=0; cpg<CPG; ++cpg){
                            for(int g=0; g<G; ++g){
                                #pragma HLS unroll
                                abs_max[tp][cpg] = max(abs_max[tp][cpg], (if_t)abs(i_group[tp][cpg][g]));
                            }
                        }
                    }
                    // // Calculate scale for each group
                    for(int tp=0; tp<TP; ++tp){
                        for(int cpg=0; cpg<CPG; ++cpg){
                            #pragma HLS unroll
                            int8_t s_val = log2ceil(abs_max[tp][cpg]) - (Q_BITS - 1);
                            s_vec[tp*CPG + cpg] = clamp(s_val, 0, A_CLAMP_MAX);
                        }
                    }
                    // Perform dynamic quantization
                    for(int tp=0; tp<TP; ++tp){
                        for(int cpg=0; cpg<CPG; ++cpg){
                            for(int g=0; g<G; ++g){
                                #pragma HLS unroll
                                if_t q_val = i_group[tp][cpg][g];
                                sf_t s_val = s_vec[tp*CPG + cpg];
                                if(s_val != 0){
                                    q_val = q_val >> (s_val-1);
                                    q_val = q_val + 1;
                                    q_val = q_val >> 1; // simulate the rounding
                                }
                                // o_vec[tp*CP + cpg*G + g] = min(q_val, (if_t)Q_MAX);
                                o_vec[tp*CP + cpg*G + g] = clamp(q_val, (if_t)Q_MIN, (if_t)Q_MAX);
                                // o_vec[tp*CP + cpg*G + g] = q_val; //* error inject
                            }
                        }
                    }

                    // Write results to output streams
                    o_stream.write(o_vec);
                    s_stream.write(s_vec);

                } // end of ct
            } // end of tt
        } // end of l
    }

};


#endif

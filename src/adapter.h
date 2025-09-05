/**
 * @brief Header file for the Adapter class implementing channel parallelism adaptation for HLS streams.
 *
 * This class provides functionality to adapt the channel parallelism of input data streams to a different
 * channel parallelism for output streams. It supports both divisible and non-divisible cases by packing
 * or unpacking data vectors. The implementation is optimized for HLS with pipelining, unrolling, and
 * dataflow directives.
 */
#ifndef __INT_ADAPTER_H__
#define __INT_ADAPTER_H__

#include "common.h"

using namespace std;

/**
 * @brief Computes the Greatest Common Divisor (GCD) of two integers using the Euclidean algorithm.
 *
 * @param a First integer.
 * @param b Second integer.
 * @return The GCD of a and b.
 */
constexpr int GCD(int a, int b) {
    return b == 0 ? a : GCD(b, a % b);
}

/**
 * @class Adapter
 * @brief Template class for adapting channel parallelism of data streams in the Llama model.
 *
 * This class handles the conversion of input streams with one channel parallelism (CIP) to output streams
 * with a different channel parallelism (COP). It supports both packing (when CIP < COP) and unpacking
 * (when CIP > COP) operations, including cases where CIP and COP are not divisible by each other.
 *
 * @tparam __data_t Data type of the stream elements.
 * @tparam T Input feature map height (sequence length).
 * @tparam TP Input feature map height parallel degree.
 * @tparam C Input feature map channel dimension.
 * @tparam CIP Input feature map channel parallel degree.
 * @tparam COP Output feature map channel parallel degree.
 */
template<
    class __data_t,     // input feature map type
    int T,              // input feature map height
    int TP,             // input feature map height parallel degree
    int C,              // input feature map channel
    int CIP,            // input feature map channel parallel degree
    int COP>            // output feature map channel parallel degree
class Adapter{
public:
    static_assert(T % TP == 0, "T must be multiple of TP"); /**< Ensure T is divisible by TP */
    static_assert(C % CIP == 0, "C must be multiple of CIP"); /**< Ensure C is divisible by CIP */
    static_assert(C % COP == 0, "C must be multiple of COP"); /**< Ensure C is divisible by COP */

    /** @brief Number of time tiles */
    static constexpr int TT = T / TP;
    /** @brief Number of input channel tiles */
    static constexpr int CIT = C / CIP;
    /** @brief Number of output channel tiles */
    static constexpr int COT = C / COP;

    /** @brief Number of unpacking iterations (when CIP > COP) */
    static constexpr int UNPK_TRIP = CIP / COP;
    /** @brief Number of packing iterations (when CIP < COP) */
    static constexpr int PACK_TRIP = COP / CIP;

    /** @brief Least Common Multiple of CIP and COP for non-divisible cases */
    static constexpr int CP = (CIP * COP) / GCD(CIP, COP);
    /** @brief Number of channel tiles for non-divisible adaptation */
    static constexpr int CT = C / CP;
    /** @brief Ratio of CP to COP */
    static constexpr int CP_COP = CP / COP;
    /** @brief Ratio of CP to CIP */
    static constexpr int CP_CIP = CP / CIP;

    
    /**
     * @brief Constructor for the Adapter class.
     */
    Adapter(){}

        /**
     * @brief Unpacks input stream with higher channel parallelism to output stream with lower channel parallelism.
     *
     * Reads input vectors with TP*CIP parallelism and writes output vectors with TP*COP parallelism,
     * distributing data across multiple iterations when CIP > COP.
     *
     * @param i_stream Input stream with TP*CIP parallelism.
     * @param o_stream Output stream with TP*COP parallelism.
     */
    static void unpk(hls::stream<hls::vector<__data_t, TP*CIP> > &i_stream, hls::stream<hls::vector<__data_t, TP*COP> > &o_stream) {
        #pragma HLS inline

        hls::vector<__data_t, TP*CIP> vec_i; /**< Temporary input vector */

        TT_LOOP: for(int tt=0; tt<TT; ++tt){
            CIT_LOOP: for(int cit=0; cit<CIT; ++cit){
                UNPK_LOOP: for(int t=0; t<UNPK_TRIP; ++t){
                    #pragma HLS pipeline II=1 /**< Enable pipelining with initiation interval of 1 */

                    /**< Read input vector at the start of unpacking */
                    if(t == 0)  vec_i = i_stream.read(); 

                    hls::vector<__data_t, TP*COP> vec_o(0);
                   
                    TP_LOOP: for(int tp=0; tp<TP; ++tp){
                        /**< Unroll loop for parallel processing */
                        #pragma HLS unroll
                        CIP_LOOP: for(int cip=0; cip<CIP; ++cip){
                            /**< Unroll loop for parallel processing */
                            #pragma HLS unroll 

                            // assign vec_o
                            /**< Shift remaining data in input vector */
                            if(cip < COP)       vec_o[tp*COP +cip] = vec_i[tp*CIP +cip];
                            // assign vec_i
                            if(cip + COP < CIP) vec_i[tp*CIP +cip] = vec_i[tp*CIP + (cip+COP)];
                             /**< Pad with zeros if necessary */
                            else                vec_i[tp*CIP +cip] = 0;
  
                        }
                    }

                    /**< Write output vector to stream */
                    o_stream.write(vec_o);

                } // end of UNPK_LOOP
            } // end of CIT_LOOP
        } // end of TT_LOOP
    }

        /**
     * @brief Packs input stream with lower channel parallelism to output stream with higher channel parallelism.
     *
     * Reads input vectors with TP*CIP parallelism and writes output vectors with TP*COP parallelism,
     * accumulating data across multiple iterations when CIP < COP.
     *
     * @param i_stream Input stream with TP*CIP parallelism.
     * @param o_stream Output stream with TP*COP parallelism.
     */
    static void pack(hls::stream<hls::vector<__data_t, TP*CIP> > &i_stream, hls::stream<hls::vector<__data_t, TP*COP> > &o_stream) {
        #pragma HLS inline

        TT_LOOP: for(int tt=0; tt<TT; ++tt){
            COT_LOOP: for(int cot=0; cot<COT; ++cot){

                /**< Output vector */
                hls::vector<__data_t, TP*COP> vec_o;

                PACK_LOOP: for(int t=0; t<PACK_TRIP; ++t){  /**< Iterate over packing iterations */
                    #pragma HLS pipeline II=1

                     /**< Read input vector */
                    hls::vector<__data_t, TP*CIP> vec_i = i_stream.read();
                    
                    TP_LOOP: for(int tp=0; tp<TP; ++tp){
                        #pragma HLS unroll
                        /**< Iterate over output channel parallelism */
                        COP_LOOP: for(int cop=0; cop<COP; ++cop){  
                            /**< Unroll loop for parallel processing */
                            #pragma HLS unroll
                            /**< Shift existing data in output vector */
                            if(cop + CIP < COP)     vec_o[tp*COP + cop] = vec_o[tp*COP + (cop+CIP)];

                            /**< Assign input data to output vector */
                            else                    vec_o[tp*COP + cop] = vec_i[tp*CIP + (cop+CIP-COP)]; 
                        
                        }
                    }

                } // end of PACK_LOOP

                 /**< Write output vector to stream */
                o_stream.write(vec_o);

            } // end of COT_LOOP
        } // end of TT_LOOP
    }

        /**
     * @brief Handles non-divisible channel parallelism adaptation.
     *
     * Uses a two-stage process (packing to an intermediate parallelism CP, then unpacking to COP)
     * when CIP and COP are not divisible by each other.
     *
     * @param i_stream Input stream with TP*CIP parallelism.
     * @param o_stream Output stream with TP*COP parallelism.
     */
    void non_divisible(hls::stream<hls::vector<__data_t, TP*CIP> > &i_stream, hls::stream<hls::vector<__data_t, TP*COP> > &o_stream) const{
        #pragma HLS dataflow

        /**< Intermediate stream for packed data */
        hls::stream<hls::vector<__data_t, TP*CP> >  packed_stream("packed_stream"); 

        /**< Pack to intermediate parallelism */
        Adapter<__data_t, T, TP, C, CIP, CP>::pack  (i_stream,  packed_stream);
         /**< Unpack to output parallelism */
        Adapter<__data_t, T, TP, C, CP, COP>::unpk  (packed_stream, o_stream);
    }

    /**
     * @brief Adapts input stream channel parallelism to output stream channel parallelism.
     *
     * Selects the appropriate method (pack, unpack, or non_divisible) based on whether CIP and COP
     * are divisible by each other.
     *
     * @param i_stream Input stream with TP*CIP parallelism.
     * @param o_stream Output stream with TP*COP parallelism.
     */
    void do_adapt(hls::stream<hls::vector<__data_t, TP*CIP> > &i_stream, hls::stream<hls::vector<__data_t, TP*COP> > &o_stream) const{
        
        /**< Check if CIP and COP are divisible */
        if(CIP % COP == 0 or COP % CIP == 0){
            // divisible implementation
            /**< Unpack if CIP > COP */
            if(CIP > COP)   unpk(i_stream, o_stream);
             /**< Pack if CIP < COP */
            else            pack(i_stream, o_stream);
        } else {
            // non-divisible implementation
             /**< Handle non-divisible case */
            non_divisible(i_stream, o_stream);
        }

    }

};

#endif
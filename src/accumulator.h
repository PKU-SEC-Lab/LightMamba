/**
 * @file accumulator.h
 * @brief Header file for the ACCUMULATOR class implementing accumulation and unpacking operations.
 *
 * This class performs accumulation and unpacking operations for the Llama model, processing input streams
 * with scaling factors, accumulating results, and unpacking them into the final output stream. The implementation
 * is optimized for HLS with dataflow, pipelining, and unrolling directives.
 */
#ifndef __INT_MAIN_ACCUMULATOR_H__
#define __INT_MAIN_ACCUMULATOR_H__

#include "common.h"
#include "utils.h"

/**
 * @class ACCUMULATOR
 * @brief Template class for accumulation and unpacking operations in the Llama model.
 *
 * Performs accumulation of input data with scaling factors in two stages, followed by unpacking
 * to produce the final output stream. Supports progress tracking in simulation mode and is
 * optimized for HLS synthesis.
 *
 * @tparam if_t Input data type.
 * @tparam as_t Activation scale data type.
 * @tparam ws_t Weight scale data type.
 * @tparam acc_t Accumulation data type.
 * @tparam of_t Output data type.
 * @tparam TRUNC_BASE Truncation base for stage 1.
 * @tparam TRUNC_BASE2 Truncation base for stage 2.
 * @tparam TP Time parallelism for input and output streams.
 * @tparam CP Channel parallelism.
 * @tparam A1 Number of accumulations for stage 1.
 * @tparam A2 Number of accumulations for stage 2.
 * @tparam N1 Number of repeats for stage 1.
 * @tparam N2 Number of repeats for stage 2.
 * @tparam GA Group size for activation quantization.
 * @tparam GW Group size for weight quantization.
 */
template<
    class if_t,
    class as_t,
    class ws_t,
    class acc_t,
    class of_t,

    int TRUNC_BASE,     // basic truncation
    int TRUNC_BASE2,     // basic truncation

    int TP,     // input tile size
    int CP,     // input tile size

    int A1,     // stage 1 accumulate times
    int A2,     // stage 2 accumulate times

    int N1,     // stage 1 repeat time
    int N2,     // stage 2 repeat time

    int GA,       // group size,
    int GW
>
class ACCUMULATOR{
public:

    // total repeat time
    static constexpr int N      = N1*A1 + N2*A2;
     /** @brief Boundary between stage 1 and stage 2 */
    static constexpr int bound  = N1*A1;
 /** @brief Number of groups for weight quantization */
    static constexpr int GT     = GW/GA;

    #ifndef __SYNTHESIS__
     /** @brief Progress bar for simulation mode */
    ProgressBar pb;
        /**
     * @brief Constructor initializing the progress bar for simulation.
     */
    ACCUMULATOR(): pb("ACCUMULATOR", N / 1000 + 1) {}
    #else
        /**
     * @brief Constructor for synthesis mode.
     */
    ACCUMULATOR() {}
    #endif
    /**
     * @brief Performs stage 1 accumulation with scaling.
     *
     * Accumulates input data with activation and weight scaling factors, splitting the results
     * into two output streams after a specified number of accumulations.
     *
     * @param i_stream Input stream of data with TP*CP parallelism.
     * @param s_stream Input stream of activation scale data with TP parallelism.
     * @param s1_stream Input stream of weight scale data (first set) with CP parallelism.
     * @param s2_stream Input stream of weight scale data (second set) with CP parallelism.
     * @param o1_stream Output stream for first half of accumulated results with TP*CP/2 parallelism.
     * @param o2_stream Output stream for second half of accumulated results with TP*CP/2 parallelism.
     */
    void stage1_accumulation(
        hls::stream<hls::vector<if_t, TP*CP     > >& i_stream,
        hls::stream<hls::vector<as_t, TP        > >& s_stream,

        hls::stream<hls::vector<ws_t, CP        > >& s1_stream,
        hls::stream<hls::vector<ws_t, CP        > >& s2_stream,

        hls::stream<hls::vector<of_t, TP*CP/2   > >& o1_stream,
        hls::stream<hls::vector<of_t, TP*CP/2   > >& o2_stream
    ) {
        acc_t psum[TP*CP];
        #pragma HLS array_reshape variable=psum complete dim=1

        // initialize with reset
        // Initialize partial sum array
        for(int tp = 0; tp < TP; tp++) {
            for(int cp = 0; cp < CP; cp++) {
                #pragma HLS unroll
                psum[tp*CP + cp] = 0;
            }
        }

        int acc_cnt = 0; // Counter for accumulation
        int out_cnt = 0; // Counter for output
        int s_cnt = GT;  // Counter for scale data

        #ifndef __SYNTHESIS__
        pb.start();
        #endif
        hls::vector<ws_t, CP   > s1_vec;
        hls::vector<ws_t, CP   > s2_vec;
        for(int n=0; n<N; ++n){
            #pragma HLS pipeline II=1

            #ifndef __SYNTHESIS__
            if(n % 1000 == 0) pb.update(1);
            #endif

            hls::vector<if_t, TP*CP> i_vec  = i_stream .read();
            hls::vector<as_t, TP   > s_vec  = s_stream .read();
            if(s_cnt == GT) {
                s_cnt = 0;
                s1_vec = s1_stream.read();
                s2_vec = s2_stream.read();
            }
            s_cnt++;

            // accumulate with shift
            for(int tp = 0; tp < TP; tp++) {
                for(int cp = 0; cp < CP; cp++) {
                    #pragma HLS unroll
                    auto x_val  = i_vec [tp*CP + cp];
                    auto s_val  = s_vec [tp];
                    auto s1_val = s1_vec[cp];
                    auto s2_val = s2_vec[cp];

                    psum[tp*CP + cp] += acc_t(x_val) << (s_val + s1_val);
                    psum[tp*CP + cp] += acc_t(x_val) << (s_val + s2_val);
                }
            }

            ++acc_cnt;

            // Determine accumulation limit and truncation
            int A = (n < bound) ? A1 : A2;
            int TRUNC_D = (n < bound) ? TRUNC_BASE : TRUNC_BASE2;

            // Output when accumulation limit is reached
            if(acc_cnt == A){
                // reset counter
                acc_cnt = 0;
                // write, but split into two
                hls::vector<of_t, TP*CP/2> o1_vec;
                hls::vector<of_t, TP*CP/2> o2_vec;
                for(int j=0; j<TP*CP/2; ++j){
                    #pragma HLS unroll
                    o1_vec[j] = psum[j          ] >> TRUNC_D;
                    o2_vec[j] = psum[j + TP*CP/2] >> TRUNC_D;
                }
                // write
                o1_stream.write(o1_vec);
                o2_stream.write(o2_vec);
                // reset psum
                for(int tp = 0; tp < TP; tp++) {
                    for(int cp = 0; cp < CP; cp++) {
                        #pragma HLS unroll
                        psum[tp*CP + cp] = 0;
                    }
                }
            }

        }

    }

    
    /**
     * @brief Performs stage 2 unpacking of accumulated results.
     *
     * Unpacks the accumulated results from two streams into a single output stream,
     * handling the time parallelism dimension.
     *
     * @param o1_stream Input stream for first half of accumulated results with TP*CP/2 parallelism.
     * @param o2_stream Input stream for second half of accumulated results with TP*CP/2 parallelism.
     * @param o_stream Output stream of unpacked results with CP parallelism.
     */
    void stage2_unpack(
        hls::stream<hls::vector<of_t, TP*CP/2> >& o1_stream,
        hls::stream<hls::vector<of_t, TP*CP/2> >& o2_stream,
        hls::stream<hls::vector<of_t, CP     > >& o_stream
    ) {
        for(int n=0; n<N1+N2; ++n){

            hls::vector<of_t, TP*CP/2> o1_vec = o1_stream.read();
            hls::vector<of_t, TP*CP/2> o2_vec = o2_stream.read();

            of_t obuf[TP*CP];
            #pragma HLS array_reshape variable=obuf complete dim=1
 // Combine the two input vectors
            for(int j=0; j<TP*CP/2; ++j){
                #pragma HLS unroll
                obuf[j          ] = o1_vec[j];
                obuf[j + TP*CP/2] = o2_vec[j];
            }

            // unpack TP dim
            for(int tp=0; tp<TP; ++tp){
                #pragma HLS pipeline II=1
                hls::vector<of_t, CP> o_vec;

                // assign lower to o_vec
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    o_vec[cp] = obuf[cp];
                }
                 // Shift buffer
                for(int tp=0; tp<TP-1; ++tp){
                    for(int cp=0; cp<CP; ++cp){
                        #pragma HLS unroll
                        obuf[tp*CP + cp] = obuf[(tp+1)*CP + cp];
                    }
                }
                // write
                o_stream.write(o_vec);
            }
        }
    }

        /**
     * @brief Main function to perform accumulation and unpacking.
     *
     * Executes the stage1_accumulation and stage2_unpack operations in a dataflow manner,
     * processing input streams and producing the final output stream.
     *
     * @param i_stream Input stream of data with TP*CP parallelism.
     * @param s_stream Input stream of activation scale data with TP parallelism.
     * @param s1_stream Input stream of weight scale data (first set) with CP parallelism.
     * @param s2_stream Input stream of weight scale data (second set) with CP parallelism.
     * @param o_stream Output stream of final results with CP parallelism.
     */

    void do_accumulator(
        hls::stream<hls::vector<if_t, TP*CP > >& i_stream,
        hls::stream<hls::vector<as_t, TP    > >& s_stream,

        hls::stream<hls::vector<ws_t, CP    > >& s1_stream,
        hls::stream<hls::vector<ws_t, CP    > >& s2_stream,

        hls::stream<hls::vector<of_t, CP    > >& o_stream
    ) {
        #pragma HLS interface ap_ctrl_chain port=return
        #pragma HLS interface axis port=i_stream
        #pragma HLS interface axis port=s_stream
        #pragma HLS interface axis port=s1_stream
        #pragma HLS interface axis port=s2_stream
        #pragma HLS interface axis port=o_stream
        #pragma HLS dataflow

        hls::stream<hls::vector<of_t, TP*CP/2> > o1_stream;
        hls::stream<hls::vector<of_t, TP*CP/2> > o2_stream;

        stage1_accumulation(i_stream, s_stream, s1_stream, s2_stream, o1_stream, o2_stream);
        stage2_unpack(o1_stream, o2_stream, o_stream);
    }

};

#endif
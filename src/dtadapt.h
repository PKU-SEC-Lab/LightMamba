#ifndef __INT_DTADAPT_H__
#define __INT_DTADAPT_H__
/**
 * @brief Header file for the DTADAPT class implementing a dot-product adaptation with bias, softplus, and quantization.
 */
#include "common.h"
#include "utils.h"
#include "softplus.h"
#include "quantizer.h"

// BIAS weight
/**
 * @brief Array of quantized bias weights for the DTADAPT operation.
 */
constexpr int DTADAPT_BIAS_Q           [] = {
    #include "../../../ref/weights/dt_bq.txt"
};

/**
 * @brief Array of scale bias weights for the DTADAPT operation.
 */
constexpr int DTADAPT_BIAS_S           [] = {
    #include "../../../ref/weights/dt_bs.txt"
};

/**
 * @class DTADAPT
 * @brief Template class for computing dot-product adaptation operations with bias, softplus, and quantization.
 *
 * Initializes bias weight arrays and processes input streams through bias addition, softplus activation,
 * quantization, and stream copying to produce multiple output streams.
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
class DTADAPT{
public:

/** @brief Number of time tiles */
    static constexpr int TT    = T    / TP;
     /** @brief Number of channel tiles */
    static constexpr int CT    = C    / CP;

      /** @brief Group size for parallelism */
    static constexpr int G     = 8;

     /** @brief Bias weight array for quantized data */
    WC_T       BIAS_Q         [L][C];
      /** @brief Bias weight array for scale data */
    WSCALE_T   BIAS_S         [L][CT];     

        /**
     * @brief Constructor for DTADAPT class.
     *
     * Initializes the bias weight arrays using provided initialization data.
     *
     * @tparam init_t Data type for initialization arrays.
     * @param bias_q_init Array of quantized bias weight initialization data.
     * @param bias_s_init Array of scale bias weight initialization data.
     */
    template<typename init_t>
    DTADAPT(
        const init_t bias_q_init[L*C],
        const init_t bias_s_init[L*CT]
    ){
        for(int l=0; l<L; ++l){
            for(int c=0; c<C; ++c){
                BIAS_Q[l][c] = bias_q_init[l*C + c];
            }
        }
        for(int l=0; l<L; ++l){
            for(int ct=0; ct<CT; ++ct){
                BIAS_S[l][ct] = bias_s_init[l*CT + ct];
            }
        }

    }

        /**
     * @brief Applies bias to the input stream.
     *
     * Reads the input stream, adds bias with scaling, and writes to the output stream.
     *
     * @param l Layer index to process.
     * @param i_stream Input stream of data with TP*CP parallelism.
     * @param o_stream Output stream of biased data with TP*CP parallelism.
     */
    void do_bias(
        int l,
        hls::stream<hls::vector<X_T, TP*CP> > &i_stream,         
        hls::stream<hls::vector<X_T, TP*CP> > &o_stream) {

        #pragma HLS array_reshape variable=BIAS_Q          cyclic      factor=CP 
        #pragma HLS bind_storage variable=BIAS_Q           type=ram_2p impl=URAM  
        #pragma HLS array_reshape variable=BIAS_S          cyclic      factor=CP 
        #pragma HLS bind_storage variable=BIAS_S           type=ram_2p impl=URAM  

        hls::vector<X_T,   TP*CP> bias_i;
        hls::vector<X_T, TP*CP> vec_o;
// Iterate over T tiles
        TT_LOOP: for(int tt=0; tt<TT; ++tt){
            CT_LOOP: for(int ct=0; ct<CT; ++ct){  
                for(int tmp=0;tmp<2;tmp++) {
                    #pragma HLS pipeline II=1   
                    if(tmp==0) {
                        hls::vector<X_T, TP*CP > i_vec = i_stream.read();
                        TP_LOOP: for(int tp=0; tp<TP; ++tp){
                            CP_LOOP: for(int cp=0; cp<CP; ++cp){
                            #pragma HLS unroll
                                // assign vec_o
                            bias_i[tp*CP +cp] = X_T(BIAS_Q[l][ct*CP+cp]) << BIAS_S[l][ct];
                            vec_o[tp*CP +cp] = bias_i[tp*CP +cp] + i_vec[tp*CP +cp];
                            }
                        }

                        o_stream.write(vec_o);
                    }

                }

            }// end of CT_LOOP
        } // end of TT_LOOP
    } 

        /**
     * @brief Copies input streams to multiple output streams.
     *
     * Reads input streams and duplicates them to two sets of output streams.
     *
     * @param oq_stream Input stream of quantized data with TP*CP parallelism.
     * @param os_stream Input stream of scale data with TP parallelism.
     * @param oq_stream1 First output stream of quantized data with TP*CP parallelism.
     * @param os_stream1 First output stream of scale data with TP parallelism.
     * @param oq_stream2 Second output stream of quantized data with TP*CP parallelism.
     * @param os_stream2 Second output stream of scale data with TP parallelism.
     */
    void do_copy(
        hls::stream<hls::vector<A_T, TP * CP> > &oq_stream,
        hls::stream<hls::vector<AS_T, TP     > > &os_stream,
        hls::stream<hls::vector<A_T, TP * CP> > &oq_stream1,
        hls::stream<hls::vector<AS_T, TP     > > &os_stream1,
        hls::stream<hls::vector<A_T, TP * CP> > &oq_stream2,
        hls::stream<hls::vector<AS_T, TP     > > &os_stream2
        ) {


        for(int tt=0; tt<TT; ++tt){
            for(int ct=0; ct<CT; ++ct){  
                #pragma HLS pipeline II=1   
                hls::vector<A_T, TP * CP> vec_i=oq_stream.read();
                hls::vector<AS_T, TP    > vec_s=os_stream.read();
                oq_stream1.write(vec_i);
                os_stream1.write(vec_s);
                oq_stream2.write(vec_i);
                os_stream2.write(vec_s);
            }// end of CT_LOOP
        } // end of TT_LOOP
    } 

      /** @brief Instance of the SOFTPLUS class for activation */
    SOFTPLUS<X_T, X_T, T, TP, C, CP> softplus_inst;

        /** @brief Instance of the QUANTIZER class for quantization */
    QUANTIZER<X_T, A_T, AS_T, 1, T, TP, C, CP, G> quantizer_inst;

        /**
     * @brief Top-level function for the DTADAPT operation.
     *
     * Orchestrates the bias addition, softplus activation, quantization, and stream copying stages
     * using dataflow optimization.
     *
     * @param l Layer index to process.
     * @param i_stream Input stream of data with TP*CP parallelism.
     * @param oq_stream1 First output stream of quantized data with TP*CP parallelism.
     * @param os_stream1 First output stream of scale data with TP parallelism.
     * @param oq_stream2 Second output stream of quantized data with TP*CP parallelism.
     * @param os_stream2 Second output stream of scale data with TP parallelism.
     */
    void do_dtadapt(
        int l,
        hls::stream<hls::vector<X_T, TP * CP> > &i_stream, 
        hls::stream<hls::vector<A_T, TP * CP> > &oq_stream1,
        hls::stream<hls::vector<AS_T, TP     > > &os_stream1,
        hls::stream<hls::vector<A_T, TP * CP> > &oq_stream2,
        hls::stream<hls::vector<AS_T, TP     > > &os_stream2
        ){
        
        // #pragma HLS interface ap_ctrl_chain port=return
        // #pragma HLS interface axis port=i_stream
        // #pragma HLS interface axis port=oq_stream
        // #pragma HLS interface axis port=os_stream        

        // Declare intermediate streams
        hls::stream<hls::vector<X_T, TP * CP > > bias_stream  ( "bias_stream"  );
        hls::stream<hls::vector<X_T, TP * CP > > softplus_stream  ( "softplus_stream"  );
        hls::stream<hls::vector<A_T, TP * CP > > oq_stream  ( "oq_stream"  );
        hls::stream<hls::vector<AS_T, TP     > > os_stream  ( "os_stream"  );
        // #pragma HLS stream variable=bias_stream type=fifo depth=32
        // #pragma HLS stream variable=softplus_stream type=fifo depth=32

        #pragma HLS dataflow
         // Execute bias addition
        do_bias(l, i_stream, bias_stream);
        // Execute softplus activation
        softplus_inst.do_softplus(bias_stream, softplus_stream);
        // Execute quantization
        quantizer_inst.do_quant(softplus_stream, oq_stream, os_stream);
         // Execute stream copying
        do_copy(oq_stream, os_stream,oq_stream1, os_stream1,oq_stream2, os_stream2);
        } 


};

#endif



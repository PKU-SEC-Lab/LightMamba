/**
 * This file defines constants and data types used for weight, convolution, and hidden layer data processing
 * in a High-Level Synthesis (HLS) implementation for a neural network accelerator.
 */
#include "../src/common.h"
#include "../src/utils.h"

// Number of layers to process.
constexpr int L         = 2;

// Number of groups for quantization.
constexpr int G         = 8;

// Group width for scaling factors.
constexpr int GW        = 128;
// WQ parallelism required: G**2
// WS parallelism required: G


// Data width for X in memory (32 bits).
constexpr int DW_X_MEM  = 32;       // in the memory_w, x is 32 bit


// Burst length for AXI memory transfers.
constexpr int BURST_LEN         = 256;

// Maximum data width for AXI interface, based on quantized weight width.
constexpr int DW_MAXI           = G*G*DW_WQ; // use WQ as standard, and align multiple WS to WQ
// Bytes per packet for AXI transfers.
constexpr int BYTE_PER_PACKET   = DW_MAXI / 8;

// Saved sequence length for loading.
constexpr int T_LOAD  = 512;
constexpr int T  = 1;
// Number of channels.
constexpr int C  = 2560;
// Input channels for first convolution.
constexpr int CI1  = 2560;
// Output channels for first convolution.
constexpr int CO1  = 10576;
constexpr int CI2  = 5120;
constexpr int CO2  = 2560;

// Combined channel count.
constexpr int CC  = 5376;

// Sequence length per processing element.
constexpr int TP = 1;
//  Channels per processing element.
constexpr int CP = G;

// Total number of quantized weights.
constexpr int NUM_Q = CI1*CO1 + CI2*CO2;//40181760

// Total number of scaling factors.
constexpr int NUM_S = NUM_Q / GW;        // 313920

// Number of quantized weights for convolution.
constexpr int C_NUM_Q = 4*CC;//21504

// Number of scaling factors for convolution.
constexpr int C_NUM_S = C_NUM_Q / G;//2688

// Number of quantized weights for hidden layer.
constexpr int H_NUM_Q = CI2*128;//655360

//  Number of scaling factors for hidden layer.
constexpr int H_NUM_S = H_NUM_Q / G;//81920
// in the perspective of weight_producer cycles
// Total bits for weights and scales.
constexpr int TOTAL_BITS   = NUM_Q*DW_WQ + NUM_S*DW_WSCALE*2;//162610560

// Total cycles for weight processing.
constexpr int TOTAL_CYCS   = TOTAL_BITS / DW_MAXI +2;//635197.5 635199

// Total bursts for weight processing.
constexpr int TOTAL_BURSTS = TOTAL_CYCS / BURST_LEN + 1;//2481 2482

// Remaining cycles after full bursts for weights.
constexpr int BOARD = TOTAL_CYCS - TOTAL_CYCS / BURST_LEN * BURST_LEN;//63
// static_assert(TOTAL_CYCS % BURST_LEN == 0, "BURST_LEN must be a factor of TOTAL_CYCS");
// Total bits for convolution data.
constexpr int C_BITS   = C_NUM_Q*DW_ACQ + C_NUM_S*DW_ASCALE;//182784

// Total cycles for convolution data.
constexpr int C_CYCS   = C_BITS / DW_MAXI;//714

// Total bursts for convolution data.
constexpr int C_BURSTS = C_CYCS / BURST_LEN + 1;//2912 2913
// Remaining cycles after full bursts for convolution.
constexpr int C_BOARD = C_CYCS - C_CYCS / BURST_LEN * BURST_LEN;//202

// Cycles for quantized convolution weights.
constexpr int CWQ_CYCS = C_NUM_Q*DW_ACQ/DW_MAXI;

// Cycles for convolution scaling factors.
constexpr int CWS_CYCS = C_NUM_S*DW_ASCALE/DW_MAXI;;

// Total bits for hidden layer data.
constexpr int H_BITS   = H_NUM_Q*DW_ACQ + H_NUM_S*DW_ASCALE;//5570560

// Total cycles for hidden layer data.
constexpr int H_CYCS   = H_BITS / DW_MAXI;//21760

//  Total bursts for hidden layer data.
constexpr int H_BURSTS = H_CYCS / BURST_LEN;//85

// Cycles for quantized hidden layer weights.
constexpr int HWQ_CYCS = H_NUM_Q*DW_ACQ/DW_MAXI;

//  Cycles for hidden layer scaling factors.
constexpr int HWS_CYCS = H_NUM_S*DW_ASCALE/DW_MAXI;

// in the perspective of weight_distributor, every 19 cycles, distribute 16 cycles to wq_queue, 3 cycles to ws_queue
//  Weight quantization loops
constexpr int WQ_LOOPS = NUM_Q*DW_WQ/DW_MAXI; //627840

// Weight scaling loops.
constexpr int WS_LOOPs = NUM_S*DW_WSCALE*2/DW_MAXI+2;  //7357.5 7359 7356

//  Weight quantization cycles per loop.
constexpr int WQ_CYCS = 256; //627840 313920

// Weight scaling cycles per loop.
constexpr int WS_CYCS = 3;  //7358   3679  312715 316394

//  Total loops for weight distribution.
constexpr int TOTAL_LOOPS = WS_LOOPs/3;//2453

// Remaining weight quantization cycles.
constexpr int WQ_BOARD = WQ_LOOPS-WQ_CYCS*(TOTAL_LOOPS-1); //128

// Blocks per loop for weight scaling.
constexpr int BLOCK_PER_LOOP_WS = WS_CYCS*DW_MAXI/(DW_WSCALE*2*G);//16

// Remaining weight scaling blocks.
constexpr int WS_BOARD = (NUM_S*DW_WSCALE*2-WS_CYCS*DW_MAXI*(TOTAL_LOOPS-1))/(DW_WSCALE*2*G); //8

// reading x and writing y
// Total number of X elements.
constexpr int NUM_X             = T*C;//2560

//  Number of tiles for X processing.
constexpr int NUM_TILE          = NUM_X / (TP*CP);//320

// Packs per tile for X processing.
constexpr int PACK_PER_TILE     = TP*CP*DW_X_MEM / DW_MAXI;//1

// X elements per packet.
constexpr int X_PER_PACK        = DW_MAXI / DW_X_MEM;//8

// define data types
typedef ap_int <DW_MAXI         > maxi_t;
typedef ap_int <DW_X            > x_t;
typedef ap_int <DW_X_MEM        > x_mem_t;
typedef ap_int <DW_WQ           > wq_t;
typedef ap_uint<DW_WSCALE       > ws_t;
typedef ap_uint<DW_MAXI*WS_CYCS > ws_pack_t;

// Data type for quantized convolution data
typedef ap_int <DW_ACQ          > cq_t;

// Data type for convolution scaling factors.
typedef ap_uint<DW_ASCALE       > cs_t;


/**
 * @brief Produces weight, convolution, and hidden layer data streams and writes back processed data.
 *
 * Reads convolution, hidden layer, and weight data from memory arrays in bursts and writes them to output streams.
 * Additionally, reads processed convolution and hidden layer data from input streams and writes them back to memory.
 * Optimized for HLS with pipelined AXI transfers.
 *
 * @param l Layer index.
 * @param memory_w Pointer to weight memory array.
 * @param memory_c Pointer to convolution memory array.
 * @param memory_h Pointer to hidden layer memory array.
 * @param mem_stream Output stream for weight data.
 * @param conv_stream Output stream for convolution data.
 * @param ht_stream Output stream for hidden layer data.
 * @param conv2_stream Input stream for processed convolution data.
 * @param ht2_stream Input stream for processed hidden layer data.
 */
void weight_producer(int l, maxi_t* memory_w, maxi_t* memory_c,maxi_t* memory_h, 
hls::stream<maxi_t>& mem_stream, hls::stream<maxi_t>& conv_stream, hls::stream<maxi_t>& ht_stream,
hls::stream<maxi_t>& conv2_stream, hls::stream<maxi_t>& ht2_stream
){
    // Read first segment of convolution data
    for(int n=0; n<C_BURSTS-1; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            // int idx = l*C_CYCS + n*BURST_LEN + i;
            // // assert(idx < L*C_CYCS);
            // maxi_t packet = memory_c[idx];
            // if(n!=C_BURSTS-1||i<C_BOARD) {
                int idx = l*C_CYCS*2 + n*BURST_LEN + i;
                // assert(idx < L*C_CYCS);
                maxi_t packet = memory_c[idx];
                conv_stream.write(packet);
            // }
        }
    }
    for(int n=0; n<1; ++n){
        for(int i=0; i<C_BOARD; ++i){
            #pragma HLS pipeline II=1
            int idx = l*C_CYCS*2 + (C_BURSTS-1)*BURST_LEN + i;
            // assert(idx < L*C_CYCS);
            maxi_t packet = memory_c[idx];
            conv_stream.write(packet);
        }
    }

    // Read second segment of convolution data
    for(int n=0; n<C_BURSTS-1; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            // int idx = l*C_CYCS + n*BURST_LEN + i;
            // // assert(idx < L*C_CYCS);
            // maxi_t packet = memory_c[idx];
            // if(n!=C_BURSTS-1||i<C_BOARD) {
                int idx = l*C_CYCS*2 + C_CYCS + n*BURST_LEN + i;
                // assert(idx < L*C_CYCS);
                maxi_t packet = memory_c[idx];
                conv_stream.write(packet);
            // }
        }
    }
    for(int n=0; n<1; ++n){
        for(int i=0; i<C_BOARD; ++i){
            #pragma HLS pipeline II=1
            int idx = l*C_CYCS*2 + C_CYCS + (C_BURSTS-1)*BURST_LEN + i;
            // assert(idx < L*C_CYCS);
            maxi_t packet = memory_c[idx];
            conv_stream.write(packet);
        }
    }
    for(int n=0; n<H_BURSTS; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            int idx = l*H_CYCS + n*BURST_LEN + i;
            // assert(idx < L*H_CYCS);
            maxi_t packet = memory_h[idx];
            ht_stream.write(packet);
            
        }
    }
    for(int n=0; n<TOTAL_BURSTS-1; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            // int idx = l*TOTAL_CYCS + n*BURST_LEN + i;
            // // assert(idx < L*TOTAL_CYCS);
            // maxi_t packet = memory_w[idx];
            // if(n!=TOTAL_BURSTS-1||i<BOARD) {
                int idx = l*TOTAL_CYCS + n*BURST_LEN + i;
                // assert(idx < L*TOTAL_CYCS);
                maxi_t packet = memory_w[idx];
                mem_stream.write(packet);
            // }
        }
    }
    for(int n=0; n<1; ++n){
        for(int i=0; i<BOARD; ++i){
            #pragma HLS pipeline II=1
            int idx = l*TOTAL_CYCS + (TOTAL_BURSTS-1)*BURST_LEN + i;
            // assert(idx < L*TOTAL_CYCS);
            maxi_t packet = memory_w[idx];
            mem_stream.write(packet);
        }
    }
    for(int n=0; n<C_BURSTS-1; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            // if(n!=C_BURSTS-1||i<C_BOARD) {
                int idx = l*C_CYCS*2 + n*BURST_LEN + i;
                maxi_t packet = conv2_stream.read();
                memory_c[idx]=packet;
            // }
        }
    }
    for(int n=0; n<1; ++n){
        for(int i=0; i<C_BOARD; ++i){
            #pragma HLS pipeline II=1
            int idx = l*C_CYCS*2 + (C_BURSTS-1)*BURST_LEN + i;
            maxi_t packet = conv2_stream.read();
            memory_c[idx]=packet;
        }
    }
    for(int n=0; n<H_BURSTS; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            int idx = l*H_CYCS + n*BURST_LEN + i;
            maxi_t packet = ht2_stream.read();
            memory_h[idx]=packet;
        }
    }
}

/**
 * @brief Produces convolution data stream from memory.
 *
 * Reads convolution data from memory and writes to the convolution stream in bursts, optimized for HLS pipelining.
 * Skips invalid accesses in the last burst to avoid exceeding memory bounds.
 *
 * @param l Layer index.
 * @param memory_c Pointer to convolution memory array.
 * @param conv_stream Output stream for convolution data.
 */
void conv_producer(int l, maxi_t* memory_c, hls::stream<maxi_t>& conv_stream){
    // l is number of layers
    for(int n=0; n<C_BURSTS; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            if(n!=C_BURSTS-1||i<C_BOARD) {
                // maxi_t packet = memory_w[l*TOTAL_CYCS + n*BURST_LEN + i];
                int idx = l*C_CYCS + n*BURST_LEN + i;
                assert(idx < L*C_CYCS);
                maxi_t packet = memory_c[idx];
                conv_stream.write(packet);
            }
        }
    }
}

/**
 * @brief Produces hidden layer data stream from memory.
 *
 * Reads hidden layer data from memory and writes to the hidden layer stream in bursts, optimized for HLS pipelining.
 *
 * @param l Layer index.
 * @param memory_h Pointer to hidden layer memory array.
 * @param ht_stream Output stream for hidden layer data.
 */
void ht_producer(int l, maxi_t* memory_h, hls::stream<maxi_t>& ht_stream){
    // l is number of layers
    for(int n=0; n<H_BURSTS; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            // maxi_t packet = memory_w[l*TOTAL_CYCS + n*BURST_LEN + i];
            int idx = l*H_CYCS + n*BURST_LEN + i;
            assert(idx < L*H_CYCS);
            maxi_t packet = memory_h[idx];
            ht_stream.write(packet);
            
        }
    }
}

/**
 * @brief Distributes weight data to quantization and scaling queues.
 *
 * Reads from the weight memory stream and distributes packets to weight quantization and scaling queues based on cycle
 * counts, ensuring proper allocation for the final loop iteration.
 *
 * @param mem_stream Input stream for weight data.
 * @param wq_queue Output stream for quantized weights.
 * @param ws_queue Output stream for weight scaling factors.
 */
void weight_distributor(
    hls::stream<maxi_t>& mem_stream,
    hls::stream<maxi_t>& wq_queue,
    hls::stream<maxi_t>& ws_queue
){
    for(int loop=0; loop<TOTAL_LOOPS; ++loop){
        for(int cyc=0; cyc<WQ_CYCS+WS_CYCS; ++cyc){
            #pragma HLS pipeline II=1
            
            if(cyc < WS_CYCS){
                maxi_t packet = mem_stream.read();
                ws_queue.write(packet);
            } else {
                if(loop<TOTAL_LOOPS-1||cyc<WS_CYCS+WQ_BOARD) {
                    maxi_t packet = mem_stream.read();
                    wq_queue.write(packet);
                }
            }
        }
    }
}

/**
 * @brief Distributes convolution data to quantization and scaling queues.
 *
 * Reads from the convolution stream and distributes packets to convolution quantization and scaling queues for two
 * rounds of processing.
 *
 * @param conv_stream Input stream for convolution data.
 * @param cq_queue Output stream for quantized convolution data.
 * @param cs_queue Output stream for convolution scaling factors.
 */
void conv_distributor(
    hls::stream<maxi_t>& conv_stream,
    hls::stream<maxi_t>& cq_queue,
    hls::stream<maxi_t>& cs_queue
){
    for(int r=0; r<2; ++r){
        for(int cyc=0; cyc<CWQ_CYCS+CWS_CYCS; ++cyc){
            #pragma HLS pipeline II=1
            maxi_t packet = conv_stream.read();
            if(cyc < CWQ_CYCS){
                cq_queue.write(packet);
            } else {
                cs_queue.write(packet);
            }
        }
    }
}

/**
 * @brief Distributes hidden layer data to quantization and scaling queues.
 *
 * Reads from the hidden layer stream and distributes packets to hidden layer quantization and scaling queues based on
 * cycle counts.
 *
 * @param ht_stream Input stream for hidden layer data.
 * @param hq_queue Output stream for quantized hidden layer data.
 * @param hs_queue Output stream for hidden layer scaling factors.
 */
void ht_distributor(
    hls::stream<maxi_t>& ht_stream,
    hls::stream<maxi_t>& hq_queue,
    hls::stream<maxi_t>& hs_queue
){
    for(int cyc=0; cyc<HWQ_CYCS+HWS_CYCS; ++cyc){
        #pragma HLS pipeline II=1
        maxi_t packet = ht_stream.read();
        if(cyc < HWQ_CYCS){
            hq_queue.write(packet);
        } else {
            hs_queue.write(packet);
        }
    }
}


/**
 * @brief Composes quantized convolution data into a stream of vectors.
 *
 * Reads quantized convolution packets from the input queue, converts them into vectors, and writes to the output stream.
 * The first loop pads the last dimension with zeros, while the second loop performs direct bit slicing.
 *
 * @param cq_queue Input stream for quantized convolution packets.
 * @param cq_stream Output stream for convolution quantization vectors.
 */
void compose_cq(
    hls::stream<maxi_t>& cq_queue,
    hls::stream<hls::vector<cq_t, 4*CP> >& cq_stream
){
    for(int loop=0; loop<CWQ_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet = cq_queue.read();
        hls::vector<cq_t, 4*CP> vec;
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int d=0; d<3; d++){
            #pragma HLS unroll
            for(int cp=0; cp<CP; cp++){
                #pragma HLS unroll
                int index=(d+1)*CP+cp;
                vec[d*CP+cp] = packet.range((index+1)*DW_ACQ-1, index*DW_ACQ);
            }
        }
        for(int cp=0; cp<CP; cp++){
            #pragma HLS unroll
            vec[3*CP+cp] = 0;
        }
        cq_stream.write(vec); 
    }
    for(int loop=0; loop<CWQ_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet = cq_queue.read();
        hls::vector<cq_t, 4*CP> vec;
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int p=0; p<4*CP; p++){
            #pragma HLS unroll
            vec[p] = packet.range((p+1)*DW_ACQ-1, p*DW_ACQ);
        }
        cq_stream.write(vec); 
    }
}

/**
 * @brief Composes convolution scaling factors into a stream of vectors.
 *
 * Reads convolution scaling packets from the input queue, converts them into vectors, and writes to the output stream.
 * The first loop pads the last dimension with zeros, while the second loop performs direct bit slicing.
 *
 * @param cs_queue Input stream for convolution scaling packets.
 * @param cs_stream Output stream for convolution scaling factor vectors.
 */
void compose_cs(
    hls::stream<maxi_t>& cs_queue,
    hls::stream<hls::vector<cs_t, 8*CP> >& cs_stream
){
    for(int loop=0; loop<CWS_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet = cs_queue.read();
        hls::vector<cs_t, 8*CP> vec;
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int d=0; d<3; d++){
            #pragma HLS unroll
            for(int cp=0; cp<2*CP; cp++){
                #pragma HLS unroll
                int index=cp*4+d+1;
                vec[cp*4+d] = packet.range((index+1)*DW_ASCALE-1, index*DW_ASCALE);
            }
        }
        for(int cp=0; cp<2*CP; cp++){
            #pragma HLS unroll
            vec[cp*4+3] = 0;
        }
        cs_stream.write(vec); 
    }
    for(int loop=0; loop<CWS_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet = cs_queue.read();
        hls::vector<cs_t, 8*CP> vec;
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int p=0; p<8*CP; p++){
            #pragma HLS unroll
            vec[p] = packet.range((p+1)*DW_ASCALE-1, p*DW_ASCALE);
        }
        cs_stream.write(vec); 
    }
    
}

/**
 * @brief Composes quantized hidden layer data into a stream of vectors.
 *
 * Reads quantized hidden layer packets from the input queue, converts them into vectors, and writes to the output stream.
 *
 * @param hq_queue Input stream for quantized hidden layer packets.
 * @param hq_stream Output stream for hidden layer quantization vectors.
 */
void compose_hq(
    hls::stream<maxi_t>& hq_queue,
    hls::stream<hls::vector<cq_t, 4*CP> >& hq_stream
){
    for(int loop=0; loop<HWQ_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet = hq_queue.read();
        hls::vector<cq_t, 4*CP> vec;
        for(int p=0; p<4*CP; p++){
            #pragma HLS unroll
            vec[p] = packet.range((p+1)*DW_ACQ-1, p*DW_ACQ);
        }
        hq_stream.write(vec); 
    }
}

/**
 * @brief Composes hidden layer scaling factors into a stream of vectors.
 *
 * Reads hidden layer scaling packets from the input queue, converts them into vectors, and writes to the output stream.
 *
 * @param hs_queue Input stream for hidden layer scaling packets.
 * @param hs_stream Output stream for hidden layer scaling factor vectors.
 */
void compose_hs(
    hls::stream<maxi_t>& hs_queue,
    hls::stream<hls::vector<cs_t, 8*CP> >& hs_stream
){
    for(int loop=0; loop<HWS_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet = hs_queue.read();
        hls::vector<cs_t, 8*CP> vec;
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int p=0; p<8*CP; p++){
            #pragma HLS unroll
            vec[p] = packet.range((p+1)*DW_ASCALE-1, p*DW_ASCALE);
        }
        hs_stream.write(vec); 
    }
}

/**
 * @brief Composes quantized weight data into a stream of vectors.
 *
 * Reads quantized weight packets from the input queue, converts them into vectors, and writes to the output stream.
 *
 * @param wq_queue Input stream for quantized weight packets.
 * @param wq_stream Output stream for quantized weight vectors.
 */
void compose_wq(
    hls::stream<maxi_t>& wq_queue,
    hls::stream<hls::vector<wq_t, G*G> >& wq_stream
){
    for(int loop=0; loop<WQ_LOOPS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet = wq_queue.read();
        hls::vector<wq_t, G*G> vec;
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int p=0; p<G*G; p++){
            #pragma HLS unroll
            vec[p] = packet.range((p+1)*DW_WQ-1, p*DW_WQ);
        }
        wq_stream.write(vec);
    }
}


/**
 * @brief Stage 1 of weight scaling composition.
 *
 * Collects multiple weight scaling packets into a single packed stream for further processing.
 *
 * @param ws_queue Input stream for weight scaling packets.
 * @param ws_pack_stream Output stream for packed weight scaling data.
 */
void compose_ws_stage1(
    hls::stream<maxi_t>& ws_queue,
    hls::stream<ws_pack_t>& ws_pack_stream
){
    for(int loop=0; loop<TOTAL_LOOPS; ++loop){
        ws_pack_t pack = 0;
        // collect multiple maxit_t into one ws_pack_t
        for(int i=0; i<WS_CYCS; ++i){
            #pragma HLS pipeline II=1
            maxi_t packet = ws_queue.read();
            pack.range((i+1)*DW_MAXI-1, i*DW_MAXI) = packet;
        }
        ws_pack_stream.write(pack);
    }
}

/**
 * @brief Stage 2 of weight scaling composition.
 *
 * Distributes packed weight scaling data into two separate vector streams for the accelerator.
 *
 * @param ws_pack_stream Input stream for packed weight scaling data.
 * @param ws1_stream Output stream for first weight scaling factor vectors.
 * @param ws2_stream Output stream for second weight scaling factor vectors.
 */
void compose_ws_stage2(
    hls::stream<ws_pack_t>& ws_pack_stream,
    hls::stream<hls::vector<ws_t, G> >& ws1_stream,
    hls::stream<hls::vector<ws_t, G> >& ws2_stream
){
    for(int loop=0; loop<TOTAL_LOOPS; ++loop){
        ws_pack_t pack = ws_pack_stream.read();
        // the pack contains many ws_t, distribute them to ws1 and ws2
        // representation 1: bitwidth = DW_MAXI * WS_CYCS
        // representation 2: bitwidth = DW_WS * 2 * G * BLOCK_PER_LOOP_WS

        // as a reference:
        //          val LOOP_WS = new Array[BigInt](BLOCK_PER_LOOP_WS * G * 2)
        //          for (idx <- 0 until BLOCK_PER_LOOP_WS * G) {
        //            LOOP_WS(idx * 2 + 0) = BigInt(REF_CONDENSED_WS1(l)(loop * BLOCK_PER_LOOP_WS * G + idx))
        //            LOOP_WS(idx * 2 + 1) = BigInt(REF_CONDENSED_WS2(l)(loop * BLOCK_PER_LOOP_WS * G + idx))
        //          }

        for(int i=0; i<BLOCK_PER_LOOP_WS; ++i){
            #pragma HLS pipeline II=1
            hls::vector<ws_t, G> vec1, vec2;
            for(int g=0; g<G; ++g){
                #pragma HLS unroll
                vec1[g] = pack.range(DW_WSCALE*1-1, DW_WSCALE*0);
                vec2[g] = pack.range(DW_WSCALE*2-1, DW_WSCALE*1);
                pack = pack >> (DW_WSCALE*2);
            }
            if(loop<TOTAL_LOOPS-1||i<WS_BOARD) {
                ws1_stream.write(vec1);
                ws2_stream.write(vec2);
            }
        }
    }
}


/**
 * @brief Composes weight scaling factors into two vector streams.
 *
 * Orchestrates the two-stage process of composing weight scaling factors into two output streams using dataflow
 * optimization.
 *
 * @param ws_queue Input stream for weight scaling packets.
 * @param ws1_stream Output stream for first weight scaling factor vectors.
 * @param ws2_stream Output stream for second weight scaling factor vectors.
 */
void compose_ws(
    hls::stream<maxi_t>& ws_queue,
    hls::stream<hls::vector<ws_t, G> >& ws1_stream,
    hls::stream<hls::vector<ws_t, G> >& ws2_stream
){
    #pragma HLS dataflow
    hls::stream<ws_pack_t> ws_pack_stream;

    compose_ws_stage1(ws_queue, ws_pack_stream);
    compose_ws_stage2(ws_pack_stream, ws1_stream, ws2_stream);
}


/**
 * @brief Reads X data from memory into a stream of vectors.
 *
 * Reads X data from memory, unpacks 256-bit packets into 32-bit elements, and writes them to the output stream as
 * vectors for the accelerator.
 *
 * @param memory_x Pointer to X memory array.
 * @param x_stream Output stream for X data vectors.
 */
void read_x(
    maxi_t* memory_x,
    hls::stream<hls::vector<x_t, TP*CP> >& x_stream
){
    // read T*C elements from memory_x, each is a 32-bit integer
    // in the memory_x view, each element is 256-bit, containing 8 X elements

    for(int n_tile=0; n_tile<NUM_TILE; ++n_tile){
        hls::vector<x_t, TP*CP> vec;
        for(int n_pack=0; n_pack<PACK_PER_TILE; ++n_pack){
            #pragma HLS pipeline II=1
            maxi_t packet = memory_x[n_tile*PACK_PER_TILE + n_pack];
            for(int num_x=0; num_x<X_PER_PACK; ++num_x){
                #pragma HLS unroll
                vec[n_pack*X_PER_PACK + num_x] = packet.range(DW_X-1, 0);
                packet = packet >> DW_X_MEM;
            }
        }
        x_stream.write(vec);
    }
}

/**
 * @brief Writes Y data from a stream to memory.
 *
 * Reads Y data vectors from the input stream, packs them into 256-bit packets, and writes to the memory array.
 *
 * @param memory_y Pointer to Y memory array.
 * @param y_stream Input stream for Y data vectors.
 */
void write_y(
    maxi_t* memory_y,
    hls::stream<hls::vector<x_t, TP*CP> >& y_stream
){
    // write T*C elements to memory_y, each is a 32-bit integer
    // in the memory_y view, each element is 256-bit, containing 8 Y elements
    for(int n_tile=0; n_tile<NUM_TILE; ++n_tile){
        hls::vector<x_t, TP*CP> vec = y_stream.read();
        for(int n_pack=0; n_pack<PACK_PER_TILE; ++n_pack){
            #pragma HLS pipeline II=1
            maxi_t packet = 0;
            for(int num_y=X_PER_PACK-1; num_y>=0; --num_y){
                #pragma HLS unroll
                packet = packet << DW_X_MEM;
                // packet = packet | vec[n_pack*X_PER_PACK + num_y];
                packet.range(DW_X_MEM-1, 0) = vec[n_pack*X_PER_PACK + num_y];
            }
            memory_y[n_tile*PACK_PER_TILE + n_pack] = packet;
        }
    }
}

/**
 * @brief Decomposes convolution quantization data from a stream of vectors.
 *
 * Reads convolution quantization vectors from the input stream, converts them into packets, and writes to the output
 * queue for storage.
 *
 * @param cq2_queue Output stream for convolution quantization packets.
 * @param cq2_stream Input stream for convolution quantization vectors.
 */
void decompose_cq(
    hls::stream<maxi_t>& cq2_queue,
    hls::stream<hls::vector<cq_t, 4*CP> >& cq2_stream
){
    for(int loop=0; loop<CWQ_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet;
        hls::vector<cq_t, 4*CP> vec=cq2_stream.read();
        for(int d=0; d<4; d++){
            #pragma HLS unroll
            for(int cp=0; cp<CP; cp++){
                #pragma HLS unroll
                int index=d*CP+cp;
                packet.range((index+1)*DW_ACQ-1, index*DW_ACQ)=vec[d*CP+cp];
            }
        }
        cq2_queue.write(packet); 
    }
}

/**
 * @brief Decomposes convolution scaling factors from a stream of vectors.
 *
 * Reads convolution scaling vectors from the input stream, converts them into packets, and writes to the output queue
 * for storage.
 *
 * @param cs2_queue Output stream for convolution scaling packets.
 * @param cs2_stream Input stream for convolution scaling vectors.
 */
void decompose_cs(
    hls::stream<maxi_t>& cs2_queue,
    hls::stream<hls::vector<cs_t, 8*CP> >& cs2_stream
){
    for(int loop=0; loop<CWS_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet;
        hls::vector<cs_t, 8*CP> vec = cs2_stream.read();
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int r=0; r<2; r++){
            #pragma HLS unroll
            for(int d=0; d<4; d++){
                #pragma HLS unroll
                for(int cp=0; cp<CP; cp++){
                    #pragma HLS unroll
                    int index=r*4*CP+d*CP+cp;
                    packet.range((index+1)*DW_ASCALE-1, index*DW_ASCALE) = vec[r*4*CP+d*CP+cp];
                }
            }
        }
        cs2_queue.write(packet); 
    }
}

/**
 * @brief Merges convolution quantization and scaling streams into a single stream.
 *
 * Reads from convolution quantization and scaling queues and combines them into a single output stream.
 *
 * @param cq2_queue Input stream for convolution quantization packets.
 * @param cs2_queue Input stream for convolution scaling packets.
 * @param conv2_stream Output stream for merged convolution data.
 */
void conv_merge(
    hls::stream<maxi_t>& cq2_queue,
    hls::stream<maxi_t>& cs2_queue,
    hls::stream<maxi_t>& conv2_stream
){
    for(int cyc=0; cyc<CWQ_CYCS+CWS_CYCS; ++cyc){
        #pragma HLS pipeline II=1
        maxi_t packet;
        if(cyc < CWQ_CYCS){
            packet=cq2_queue.read();
        } else {
            packet=cs2_queue.read();
        }
        conv2_stream.write(packet);
    }
}

/**
 * @brief Writes convolution and hidden layer data to memory.
 *
 * Reads from convolution and hidden layer output streams and writes to memory in bursts, ensuring valid accesses for
 * convolution data in the last burst.
 *
 * @param l Layer index.
 * @param memory_c Pointer to convolution memory array.
 * @param memory_h Pointer to hidden layer memory array.
 * @param conv2_stream Input stream for processed convolution data.
 * @param ht2_stream Input stream for processed hidden layer data.
 */
void write_ch(
    int l,
    maxi_t* memory_c, maxi_t* memory_h,
    hls::stream<maxi_t>& conv2_stream, hls::stream<maxi_t>& ht2_stream
){
    for(int n=0; n<C_BURSTS; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            if(n!=C_BURSTS-1||i<C_BOARD) {
                int idx = l*C_CYCS + n*BURST_LEN + i;
                maxi_t packet = conv2_stream.read();
                memory_c[idx]=packet;
            }
        }
    }
    for(int n=0; n<H_BURSTS; ++n){
        for(int i=0; i<BURST_LEN; ++i){
            #pragma HLS pipeline II=1
            int idx = l*H_CYCS + n*BURST_LEN + i;
            maxi_t packet = ht2_stream.read();
            memory_h[idx]=packet;
        }
    }
}

/**
 * @brief Decomposes hidden layer quantization data from a stream of vectors.
 *
 * Reads hidden layer quantization vectors from the input stream, converts them into packets, and writes to the output
 * queue for storage.
 *
 * @param hq2_queue Output stream for hidden layer quantization packets.
 * @param hq2_stream Input stream for hidden layer quantization vectors.
 */
void decompose_hq(
    hls::stream<maxi_t>& hq2_queue,
    hls::stream<hls::vector<cq_t, 4*CP> >& hq2_stream
){
    for(int loop=0; loop<HWQ_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet;
        hls::vector<cq_t, 4*CP> vec=hq2_stream.read();
        for(int p=0; p<4*CP; p++){
            #pragma HLS unroll
            packet.range((p+1)*DW_ACQ-1, p*DW_ACQ)=vec[p];
        }
        hq2_queue.write(packet); 
    }
}

/**
 * @brief Decomposes hidden layer scaling factors from a stream of vectors.
 *
 * Reads hidden layer scaling vectors from the input stream, converts them into packets, and writes to the output queue
 * for storage.
 *
 * @param hs2_queue Output stream for hidden layer scaling packets.
 * @param hs2_stream Input stream for hidden layer scaling vectors.
 */
void decompose_hs(
    hls::stream<maxi_t>& hs2_queue,
    hls::stream<hls::vector<cs_t, 8*CP> >& hs2_stream
){
    for(int loop=0; loop<HWS_CYCS; ++loop){
        #pragma HLS pipeline II=1
        maxi_t packet;
        hls::vector<cs_t, 8*CP> vec = hs2_stream.read();
        // Equal width conversion: DW_MAXI -> G*G*DW_WQ
        for(int p=0; p<8*CP; p++){
            #pragma HLS unroll
            packet.range((p+1)*DW_ASCALE-1, p*DW_ASCALE)=vec[p];
        }
        hs2_queue.write(packet); 
    }
}

/**
 * @brief Merges hidden layer quantization and scaling streams into a single stream.
 *
 * Reads from hidden layer quantization and scaling queues and combines them into a single output stream.
 *
 * @param hq2_queue Input stream for hidden layer quantization packets.
 * @param hs2_queue Input stream for hidden layer scaling packets.
 * @param ht_stream Output stream for merged hidden layer data.
 */
void ht_merge(
    hls::stream<maxi_t>& hq2_queue,
    hls::stream<maxi_t>& hs2_queue,
    hls::stream<maxi_t>& ht_stream
){
    for(int cyc=0; cyc<HWQ_CYCS+HWS_CYCS; ++cyc){
        #pragma HLS pipeline II=1
        maxi_t packet;
        if(cyc < HWQ_CYCS){
            packet=hq2_queue.read();
        } else {
            packet=hs2_queue.read();
        }
        ht_stream.write(packet);
    }
}


/**
 * @brief Top-level function for managing data processing in a neural network accelerator.
 *
 * Orchestrates the dataflow for reading input data (X), producing and distributing weight, convolution, and hidden layer
 * streams, and writing output data (Y) to memory. Uses dataflow optimization to parallelize operations across multiple
 * processing stages, interfacing with the accelerator via AXI streams and memory interfaces.
 *
 * @param l_begin Starting layer index.
 * @param l_close Ending layer index.
 * @param memory_x Pointer to input X memory array.
 * @param memory_w Pointer to weight memory array.
 * @param memory_y Pointer to output Y memory array.
 * @param memory_c Pointer to convolution memory array.
 * @param memory_h Pointer to hidden layer memory array.
 * @param x_stream Output stream for X data to accelerator.
 * @param wq_stream Output stream for quantized weight vectors to accelerator.
 * @param ws1_stream Output stream for first weight scaling factor vectors to accelerator.
 * @param ws2_stream Output stream for second weight scaling factor vectors to accelerator.
 * @param cq_stream Output stream for convolution quantization vectors to accelerator.
 * @param cs_stream Output stream for convolution scaling factor vectors to accelerator.
 * @param cq2_stream Input stream for processed convolution quantization vectors from accelerator.
 * @param cs2_stream Input stream for processed convolution scaling factor vectors from accelerator.
 * @param hq_stream Output stream for hidden layer quantization vectors to accelerator.
 * @param hs_stream Output stream for hidden layer scaling factor vectors to accelerator.
 * @param hq2_stream Input stream for processed hidden layer quantization vectors from accelerator.
 * @param hs2_stream Input stream for processed hidden layer scaling factor vectors from accelerator.
 * @param y_stream Input stream for Y data from accelerator.
 */
void top(
    int l_begin,
    int l_close,

    maxi_t*    memory_x,
    maxi_t*    memory_w,
    maxi_t*    memory_y,
    maxi_t*    memory_c,
    maxi_t*    memory_h,

    hls::stream<hls::vector<x_t, TP*CP> >& x_stream,    // to accelerator

    hls::stream<hls::vector<wq_t, G*G> >& wq_stream,    // to accelerator
    hls::stream<hls::vector<ws_t, G  > >& ws1_stream,   // to accelerator
    hls::stream<hls::vector<ws_t, G  > >& ws2_stream,   // to accelerator

    hls::stream<hls::vector<cq_t, 4*CP> >& cq_stream,    // to accelerator
    hls::stream<hls::vector<cs_t, 8*CP> >& cs_stream,   // to accelerator
    hls::stream<hls::vector<cq_t, 4*CP> >& cq2_stream,   // to accelerator
    hls::stream<hls::vector<cs_t, 8*CP> >& cs2_stream,   // to accelerator
    hls::stream<hls::vector<cq_t, 4*CP> >& hq_stream,    // to accelerator
    hls::stream<hls::vector<cs_t, 8*CP> >& hs_stream,   // to accelerator
    hls::stream<hls::vector<cq_t, 4*CP> >& hq2_stream,    // to accelerator
    hls::stream<hls::vector<cs_t, 8*CP> >& hs2_stream,   // to accelerator
    hls::stream<hls::vector<x_t, TP*CP> >& y_stream     // from accelerator
){
    #pragma HLS interface ap_ctrl_chain port=return

    #pragma HLS interface mode=m_axi bundle=gmem port=memory_w depth=TOTAL_CYCS max_read_burst_length=BURST_LEN max_write_burst_length=BURST_LEN num_read_outstanding=16 num_write_outstanding=16 latency=35 offset=direct
    #pragma HLS interface mode=m_axi bundle=gmem port=memory_x depth=NUM_X      max_read_burst_length=BURST_LEN max_write_burst_length=BURST_LEN num_read_outstanding=16 num_write_outstanding=16 latency=35 offset=direct
    #pragma HLS interface mode=m_axi bundle=gmem port=memory_y depth=NUM_X      max_read_burst_length=BURST_LEN max_write_burst_length=BURST_LEN num_read_outstanding=16 num_write_outstanding=16 latency=35 offset=direct
    #pragma HLS interface mode=m_axi bundle=gmem port=memory_c depth=C_CYCS*2   max_read_burst_length=BURST_LEN max_write_burst_length=BURST_LEN num_read_outstanding=16 num_write_outstanding=16 latency=35 offset=direct
    #pragma HLS interface mode=m_axi bundle=gmem port=memory_h depth=H_CYCS     max_read_burst_length=BURST_LEN max_write_burst_length=BURST_LEN num_read_outstanding=16 num_write_outstanding=16 latency=35 offset=direct

    #pragma HLS interface axis port=x_stream
    #pragma HLS interface axis port=wq_stream
    #pragma HLS interface axis port=ws1_stream
    #pragma HLS interface axis port=ws2_stream
    #pragma HLS interface axis port=y_stream

    #pragma HLS interface axis port=cq_stream
    #pragma HLS interface axis port=cs_stream
    #pragma HLS interface axis port=cq2_stream
    #pragma HLS interface axis port=cs2_stream

    #pragma HLS interface axis port=hq_stream
    #pragma HLS interface axis port=hs_stream
    #pragma HLS interface axis port=hq2_stream
    #pragma HLS interface axis port=hs2_stream

    #pragma HLS aggregate variable=x_stream     compact=bit
    #pragma HLS aggregate variable=wq_stream    compact=bit
    #pragma HLS aggregate variable=ws1_stream   compact=bit
    #pragma HLS aggregate variable=ws2_stream   compact=bit
    #pragma HLS aggregate variable=y_stream     compact=bit

    #pragma HLS aggregate variable=cq_stream    compact=bit
    #pragma HLS aggregate variable=cs_stream    compact=bit
    #pragma HLS aggregate variable=cq2_stream   compact=bit
    #pragma HLS aggregate variable=cs2_stream   compact=bit

    #pragma HLS aggregate variable=hq_stream    compact=bit
    #pragma HLS aggregate variable=hs_stream    compact=bit
    #pragma HLS aggregate variable=hq2_stream    compact=bit
    #pragma HLS aggregate variable=hs2_stream    compact=bit

    // read x
    read_x(memory_x, x_stream);

    // read weight
    // for(int l=l_begin; l<l_close; ++l){
    for(int l_diff=0; l_diff<l_close-l_begin; ++l_diff){    // help the loop counter to be initialized to 0
        #pragma HLS dataflow
        // internal stream
        hls::stream<maxi_t> mem_stream;
        hls::stream<maxi_t> wq_queue;
        hls::stream<maxi_t> ws_queue;
        hls::stream<maxi_t> conv_stream;
        hls::stream<maxi_t> cq_queue;
        hls::stream<maxi_t> cs_queue;
        hls::stream<maxi_t> conv2_stream;
        hls::stream<maxi_t> cq2_queue;
        hls::stream<maxi_t> cs2_queue;
        hls::stream<maxi_t> ht_stream;
        hls::stream<maxi_t> hq_queue;
        hls::stream<maxi_t> hs_queue;
        hls::stream<maxi_t> ht2_stream;
        hls::stream<maxi_t> hq2_queue;
        hls::stream<maxi_t> hs2_queue;

        #pragma HLS stream variable=mem_stream depth=4096
        #pragma HLS stream variable=conv_stream depth=4096
        #pragma HLS stream variable=conv2_stream depth=4096
        #pragma HLS stream variable=ht_stream depth=4096
        #pragma HLS stream variable=ht2_stream depth=4096

        #pragma HLS stream variable=wq_queue depth=32
        #pragma HLS stream variable=ws_queue depth=32
        #pragma HLS stream variable=cq_queue depth=32
        #pragma HLS stream variable=cs_queue depth=32
        #pragma HLS stream variable=cq2_queue depth=32
        #pragma HLS stream variable=cs2_queue depth=32
        #pragma HLS stream variable=hq_queue depth=32
        #pragma HLS stream variable=hs_queue depth=32
        #pragma HLS stream variable=hq2_queue depth=32
        #pragma HLS stream variable=hs2_queue depth=32

         // Data processing pipeline
        decompose_cq        (cq2_queue,         cq2_stream                  );
        decompose_cs        (cs2_queue,         cs2_stream                  );
        conv_merge          (cq2_queue,         cs2_queue,      conv2_stream);
        decompose_hq        (hq2_queue,         hq2_stream                  );
        decompose_hs        (hs2_queue,         hs2_stream                  );
        ht_merge            (hq2_queue,         hs2_queue,      ht2_stream  );
        weight_producer     (l_begin + l_diff,  memory_w, memory_c, memory_h,
                            mem_stream, conv_stream, ht_stream,
                            conv2_stream, ht2_stream
                            );
        conv_distributor    (conv_stream,       cq_queue,       cs_queue    );
        compose_cq          (cq_queue,          cq_stream                   );
        compose_cs          (cs_queue,          cs_stream                   );
        ht_distributor      (ht_stream,         hq_queue,       hs_queue    );
        compose_hq          (hq_queue,          hq_stream                   );
        compose_hs          (hs_queue,          hs_stream                   );
        weight_distributor  (mem_stream,        wq_queue,       ws_queue    );
        compose_wq          (wq_queue,          wq_stream                   );
        compose_ws          (ws_queue,          ws1_stream,     ws2_stream  );


    }

     // // Write output Y data
    write_y(memory_y, y_stream);
}


// constexpr int MEM_DEPTH = (0x100000000 + X_BYTES*2) / BYTE_PER_PACKET;
// maxi_t memory_w[MEM_DEPTH] = {0};

// Initialize memory arrays
maxi_t memory_w[L*TOTAL_CYCS] = {0};
maxi_t memory_x[T*C         ] = {0};
maxi_t memory_y[T*C         ] = {0};
maxi_t memory_c[L*C_CYCS*2    ] = {0};
maxi_t memory_h[L*H_CYCS    ] = {0};

/**
 * @brief Main function for testing weight and data processing.
 *
 * Initializes memory arrays and streams, writes test data to streams, calls the top-level function, and verifies that
 * streams are empty after processing.
 *
 * @return Returns 0 on successful completion.
 */
int main(){

    hls::stream<hls::vector<x_t,  TP*CP > > x_stream;
    hls::stream<hls::vector<wq_t, G*G   > > wq_stream;
    hls::stream<hls::vector<ws_t, G     > > ws1_stream;
    hls::stream<hls::vector<ws_t, G     > > ws2_stream;
    hls::stream<hls::vector<x_t,  TP*CP > > y_stream;
    hls::stream<hls::vector<cq_t, 4*CP  > > cq_stream;
    hls::stream<hls::vector<cs_t, 8*CP  > > cs_stream;
    hls::stream<hls::vector<cq_t, 4*CP  > > cq2_stream;
    hls::stream<hls::vector<cs_t, 8*CP  > > cs2_stream;
    hls::stream<hls::vector<cq_t, 4*CP  > > hq_stream;
    hls::stream<hls::vector<cs_t, 8*CP  > > hs_stream;
    hls::stream<hls::vector<cq_t, 4*CP  > > hq2_stream;
    hls::stream<hls::vector<cs_t, 8*CP  > > hs2_stream;

     // Reference arrays for test data
    int64_t REF_OUT      [T  *CO2];  // out_proj output
    int64_t REF_X      [T  *CO2];  // out_proj output

   
     // Load  data from file
    string file_path = "D:/file/project/git/light-mamba/ref";
    string file_path_suffix      = to_string(0) + ".bin";
    auto OUT         = read_tensor<int64_t>  (file_path + "/activations/out_proj_layer" + file_path_suffix);
    tensor2array<int64_t>(   OUT,        REF_OUT,        1,      1,      T_LOAD, T,      CO2,    CO2  );
    // write data to memory
    array2stream<int64_t, x_t, 1, 1, 1, 1, T*C, TP*CP>(REF_OUT, y_stream, "y", true);
    for(int l=0;l<L;l++) {
        for(int n=0;n<CWQ_CYCS;n++) {
            hls::vector<cq_t, 4*CP   > cq_vec;
            cq2_stream.write(cq_vec);
        }
        for(int n=0;n<CWS_CYCS;n++) {
            hls::vector<cs_t, 8*CP   > cs_vec;
            cs2_stream.write(cs_vec);
        }
        for(int n=0;n<HWQ_CYCS;n++) {
            hls::vector<cq_t, 4*CP   > hq_vec;
            hq2_stream.write(hq_vec);
        }
        for(int n=0;n<HWS_CYCS;n++) {
            hls::vector<cs_t, 8*CP   > hs_vec;
            hs2_stream.write(hs_vec);
        }
    }

    // Call top-level function
    top(0, L, memory_x, memory_w, memory_y, memory_c, memory_h, 
    x_stream, wq_stream, ws1_stream, ws2_stream,
    cq_stream, cs_stream,cq2_stream, cs2_stream,
    hq_stream, hs_stream,hq2_stream, hs2_stream,
    y_stream);

    // read data from memory
    stream2array<int64_t, x_t, 1, 1, 1,    T*C, TP*CP>(x_stream, REF_OUT, "x", true);
    for(int l=0;l<L;l++) {
        for(int n=0;n<NUM_Q/G/G;n++) {
            hls::vector<wq_t, G*G   > wq_vec=wq_stream.read();
        }
        for(int n=0;n<NUM_S/G;n++) {
            hls::vector<ws_t, G     > ws1_vec=ws1_stream.read();
            hls::vector<ws_t, G     > ws2_vec=ws2_stream.read();
        }
        for(int n=0;n<CWQ_CYCS*2;n++) {
            hls::vector<cq_t, 4*CP   > cq_vec=cq_stream.read();
        }
        for(int n=0;n<CWS_CYCS*2;n++) {
            hls::vector<cs_t, 8*CP   > cs_vec=cs_stream.read();
        }
        for(int n=0;n<HWQ_CYCS;n++) {
            hls::vector<cq_t, 4*CP   > hq_vec=hq_stream.read();
        }
        for(int n=0;n<HWS_CYCS;n++) {
            hls::vector<cs_t, 8*CP   > hs_vec=hs_stream.read();
        }
    }


    // Verify streams are empty
    assert(x_stream.empty());
    assert(wq_stream.empty());
    assert(ws1_stream.empty());
    assert(ws2_stream.empty());
    assert(y_stream.empty());
    assert(cq_stream.empty());
    assert(cs_stream.empty());
    assert(cq2_stream.empty());
    assert(cs2_stream.empty());

    return 0;
}
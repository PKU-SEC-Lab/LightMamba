# constexpr int L         = 1;
# constexpr int G         = 8;
# // WQ parallelism required: G**2
# // WS parallelism required: G

# constexpr int DW_WS = DW_WSCALE;

# constexpr int BURST_LEN = 256;
# constexpr int DW_MAXI   = G*G*DW_WQ; // use WQ as standard, and align multiple WS to WQ

# constexpr int C  = 4096;
# constexpr int CM = 11008;

# constexpr int NUM_Q = 4*C*C + 3*C*CM;
# constexpr int NUM_S = NUM_Q / G;        // number of scale pairs

# // in the perspective of weight_producer cycles
# constexpr int TOTAL_BITS   = NUM_Q*DW_WQ + NUM_S*DW_WS*2;
# constexpr int TOTAL_CYCS   = TOTAL_BITS / DW_MAXI;
# constexpr int TOTAL_BURSTS = TOTAL_CYCS / BURST_LEN;
# static_assert(TOTAL_CYCS % BURST_LEN == 0, "BURST_LEN must be a factor of TOTAL_CYCS");

# // in the perspective of weight_distributor, every 19 cycles, distribute 16 cycles to wq_queue, 3 cycles to ws_queue
# constexpr int WQ_CYCS = 16;
# constexpr int WS_CYCS = 3;
# // calculate how many block can be loaded in one loop
# constexpr int BLOCK_PER_LOOP_WQ = WQ_CYCS*DW_MAXI/(DW_WQ*G*G);
# constexpr int BLOCK_PER_LOOP_WS = WS_CYCS*DW_MAXI/(DW_WS*2*G);
# static_assert(BLOCK_PER_LOOP_WQ == BLOCK_PER_LOOP_WS, "BLOCK_PER_LOOP_WQ must be equal to BLOCK_PER_LOOP_WS");
# // calculate total loops, including both WQ and WS
# constexpr int TOTAL_LOOPS = TOTAL_CYCS / (WQ_CYCS + WS_CYCS);
# static_assert(TOTAL_CYCS % (WQ_CYCS + WS_CYCS) == 0, "WQ_CYCS + WS_CYCS must be a factor of TOTAL_CYCS");

L               = 32 # 32 decoders in llama2
G               = 8
DW_WQ           = 4
DW_WS           = 3
BURST_LEN       = 256
DW_MAXI         = G*G*DW_WQ
C               = 4096
CM              = 11008
NUM_Q           = 4*C*C + 3*C*CM
NUM_S           = NUM_Q // G
DECODER_BITS    = NUM_Q*DW_WQ + NUM_S*DW_WS*2
DECODER_CYCS    = DECODER_BITS // DW_MAXI
DECODER_BURSTS  = DECODER_CYCS // BURST_LEN
print(f"DECODER_BITS: {DECODER_BITS}, DECODER_CYCS: {DECODER_CYCS}, DECODER_BURSTS: {DECODER_BURSTS}")

# for whole network, how many bits?
LLAMA_BITS      = L * DECODER_BITS
LLAMA_BYTES     = LLAMA_BITS // 8
LLAMA_GBs       = LLAMA_BYTES / (1<<30)
LLAMA_CYCS      = L * DECODER_CYCS
print(f"LLAMA_BYTES: {LLAMA_BYTES}, LLAMA_GBs: {LLAMA_GBs}, LLAMA_CYCS: {LLAMA_CYCS}")

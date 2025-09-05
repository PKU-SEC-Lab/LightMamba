#include "layers.h"

const ll T = 1; // number of tokens
const ll D = 2560; // number of dims
const ll N = 128; // number of scan channels
const ll L = 64; // number of layers
const ll P = 64;// number of head dims
const ll V = 50288;// number of voca
const ll prompt_len = 14;
const ll decode_len = 100;
const ll O_RES = 10;

ll top_k = 1;
const double top_p = 0.0;
const double temperature = 1.0;
const double repetition_penalty = 1.2;

static const ll C_in = 4 * D + 2 * N + 2 * D / P; // conv channels
static const ll C_conv = 2 * D + 2 * N; // conv channels
static const ll C2 = 2 * D; //channels
static const ll CH = 2 * D / P; // head channels
static const ll C_silu = 4 * D + 2 * N; // silu channels
static const ll CP = 8;
static const ll NT = N/CP;
static const ll HT = CH/CP;
static const ll C2T = C2/CP;
static const ll C_conv_T = C_conv/CP;
static const ll C_silu_T = C_silu/CP;

/**
 * @brief Converts a token ID to an embedded integer vector using the embedding table.
 * @param token_id The ID of the token to embed.
 * @param embedding_table The embedding table of size V * D.
 * @return An integer vector of size D representing the embedded token.
 */
ivec Embedding(ll token_id, const dvec &embedding_table) {
     // Initialize output vector (note: allocated with size V but only D elements are used)
    ivec input(V);
    // Convert embedding values to integers with scaling
    for (ll d = 0; d < D; ++d) {

        input[d] = (ll)(embedding_table[token_id * D +d] * pow(2, O_RES));
    }
    return input;
}

/**
 * @brief Performs final RMS normalization on the decode input.
 * @param decode_input Input integer vector of size D.
 * @param rms_weight RMS weight vector of size D.
 * @return A double-precision vector of size D after normalization.
 */
dvec Last_RMS(const ivec &decode_input, const dvec &rms_weight) {
    // Convert input to double-precision with scaling
    dvec x(D);
    for (ll d = 0; d < D; ++d) {
        x[d] = (double)(decode_input[d]) / pow(2.0, O_RES);
    }
    // Compute mean of squares
    double sum = 0;
    for (ll d = 0; d < D; ++d) {
        sum += x[d] * x[d];
    }
    sum /= D;
    // Compute RMS normalization
    double Sqrt = sqrt(sum);
    for (ll d = 0; d < D; ++d) {
        x[d] = x[d] * rms_weight[d] / Sqrt;
    }
    return x;
}
/**
 * @brief Computes logits and samples a token using top-k or top-p sampling.
 * @param rms Normalized input vector of size D.
 * @param lm_head Language model head weights of size V * D.
 * @param prev_output_tokens Previous output tokens for repetition penalty.
 * @param seqlen Current sequence length.
 * @return The sampled token ID.
 * @throws Assertion failure if top_p is invalid (top_p > 1.0).
 */
ll LM(const dvec &rms, const dvec &lm_head, const ivec &prev_output_tokens, ll seqlen) {
    // Compute logits through matrix multiplication
    dvec logits(V);
    for (ll v = 0; v < V; ++v) {
        double acc = 0;
        for (ll d = 0; d < D; ++d) {
            acc += lm_head[v * D + d] * rms[d];
        }
        logits[v] = acc;
    }
    // Apply repetition penalty if enabled
    if (repetition_penalty != 1.0) {
        for (ll i = 0; i < seqlen; ++i) {
            if (logits[prev_output_tokens[i]] < 0)
                logits[prev_output_tokens[i]] *= repetition_penalty;
            else
                logits[prev_output_tokens[i]] /= repetition_penalty;
        }
    }
    // Perform greedy decoding (top_k = 1)
    ll cur=0;
    double max_val = logits[0];
    if (top_k == 1) {
        for (ll v = 0; v < V; ++v) {
            if (logits[v] > max_val) {
                cur = v;
                max_val = logits[v];
            }
        }
        return cur;
    }
    else {
        if (top_p > 0)
        // Validate top_p parameter
            assert(top_p <= 1.0);
        // Limit top_k to vocabulary size
        if (top_k > 0) {
            top_k = min(top_k, V);
        }
    }

}

/**
 * @brief Main function to run the Mamba model inference.
 * @return Exit code (0 for success).
 */
int main() {
// Initialize convolution and hidden states
    ivec conv_state(L * 3 * C_conv);
    ivec conv_state_s(L * 3 * C_conv_T);
    ivec hidden_state(L * N * C2);
    ivec hidden_state_s(L * N * C2T);

    // Initialize convolution and hidden states to zero
    for (ll i = 0; i < L; ++i) {
        for (ll t = 0; t < 3; ++t) {
            for (ll c = 0; c < C_conv; ++c) {
                // Note: conv_state[t * C_conv + c] is used before initialization
                conv_state[i * 3 * C_conv + t * C_conv + c] = conv_state[t * C_conv + c];
            }
            for (ll c = 0; c < C_conv_T; ++c) {
                 // Note: conv_state_s[t * C_conv_T + c] is used before initialization
                conv_state_s[i * 3 * C_conv_T + t * C_conv_T + c] = conv_state_s[t * C_conv_T + c];
            }
        }
        for (ll n = 0; n < N; ++n) {
            for (ll c = 0; c < C2; ++c) {
                hidden_state[i * N * C2 + n * C2 + c] = 0;
            }
            for (ll c = 0; c < C2T; ++c) {
                hidden_state_s[i * N * C2T + n * C2T + c] = 0;
            }
        }
    }

 // Load input tensor
    ivec input = read_tensor<ll>("./bin/refs/input.bin");
    // Initialize Mamba model
    Mamba<T, D, N, L, P> mamba;
    // Run forward pass
    ivec result = mamba.forward(input, conv_state, conv_state_s,
                                hidden_state, hidden_state_s);
// Commented-out code for embedding, prefill, and decoding
//    //input
//    ivec input_ids(prompt_len);
//    input_ids = {3220, 5798, 4159, 512, 436, 32463, 4877, 2127, 323, 247, 747, 3448, 1566, 285};
//
//    //input embedding
//    ivec input(prompt_len * D);
//    dvec embedding_table = read_tensor<double>("./bin/weights/embedding.bin");
//    for (ll t = 0; t < prompt_len; ++t) {
//        for (ll d = 0; d < D; ++d) {
//            input[t * D + d] = (ll)(embedding_table[input_ids[t] * D +d] * pow(2, O_RES));
//        }
//    }
//
//    //prefill
//    Mamba<prompt_len, D, N, L, P> mamba_prefill;
//    ivec result = mamba_prefill.forward(input, conv_state, conv_state_s,
//                                        hidden_state, hidden_state_s);
//    printf("prefill finished\n");
//
//
//    //initial output
//    ivec output_ids(prompt_len + decode_len);
//    for (ll t = 0; t < prompt_len; ++t) {
//        output_ids[t] = input_ids[t];
//    }
//
//
//
//    //get first decode output
//    for (ll d = 0; d < D; ++d) {
//        result[d] = result[(prompt_len - 1) * D + d];
//    }
//    dvec rms_weight = read_tensor<double>("./bin/weights/last_rms_weight.bin");
//    dvec rms = Last_RMS(result, rms_weight);
//    dvec lm_head = read_tensor<double>("./bin/weights/lm_head.bin");
//    ll sample_token = LM(rms, lm_head, output_ids, prompt_len);
//    output_ids[prompt_len] = sample_token;
//
//    //autoregressive decode
//    ivec decode_input(D);
//    Mamba<1, D, N, L, P> mamba_decode;
//    for (ll t = 0; t < decode_len-1; ++t) {
//        printf("decode times:%lld\n",t);
//        decode_input = Embedding(sample_token, embedding_table);
//        decode_input = mamba_decode.forward(decode_input, conv_state, conv_state_s,
//                                            hidden_state, hidden_state_s);
//        rms = Last_RMS(decode_input, rms_weight);
//        sample_token = LM(rms, lm_head, output_ids, prompt_len + t + 1);
//        output_ids[prompt_len + t + 1] = sample_token;
//    }
//
//    //print output
//    for (ll t = 0; t < prompt_len + decode_len; ++t) {
//        printf("%lld ",output_ids[t]);
//    }
//
//    // Save output tokens
//    string filename="./output_ids.bin";
//    write_tensor(output_ids, filename);


    return 0;
}

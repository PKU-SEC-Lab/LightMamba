#ifndef DEIT_S_LAYERS_H
#define DEIT_S_LAYERS_H

#include <iostream>
#include <fstream>
#include "util.h"

using namespace std;

/**
 * @brief Template class for quantizing integer vectors with specified dimensions and bit widths.
 *
 * This class provides functionality to quantize an input integer vector into a lower-bit representation,
 * producing a quantized vector and a scaling factor vector.
 *
 * @tparam T Number of tokens (first dimension of the tensor).
 * @tparam C Number of channels (second dimension of the tensor).
 * @tparam Bits Number of bits for quantization.
 * @tparam BW Bit width for maximum value checking.
 */
template<ll T, ll C, ll Bits, ll BW>
class Quant {
public:

    static const ll CP = 8; // Number of channels per group.
    static const ll CT = C/CP; // Number of channel groups (C / CP).

    //Number of bits for quantization.
    static const ll Q_BITS = Bits; 
     //Maximum quantized value (2^(Q_BITS-1) - 1).
    static const ll Q_MAX  = +(1 << (Q_BITS - 1)) - 1;
    //Minimum quantized value (-2^(Q_BITS-1)).
    static const ll Q_MIN  = -(1 << (Q_BITS - 1)); 

    //Maximum allowed scaling factor.
    static const ll A_CLAMP_MAX = 15;

    // Minimum scaling factor.
    static const ll min_0 = 0; //

    // Maximum value allowed for input before scaling (2^(BW-1) - 1).
    const ll BW_MAX = +(1 << (BW - 1)) - 1;
    const ll one = 1;

    string type_name;
    /**
     * @brief Constructor for the Quant class.
     * @param quant_name Name to identify the quantization instance.
     */
    explicit Quant(string quant_name) {
        // Initialize the type_name member with the provided name
        type_name=quant_name;
    }
    /**
     * @brief Quantizes an input integer vector with scaling.
     * @param x Input integer vector of size T * C.
     * @return A TwoIvec structure containing the quantized vector (x) and scaling factors (y).
     * @throws Assertion failure if any input value exceeds BW_MAX.
     */
    TwoIvec forward(const ivec &x) {
         // Initialize output vector for quantized values (size T * C)
        ivec y(T * C);
         // Initialize output vector for scaling factors (size T * CT)
        ivec ys(T * CT);
        // quant
        for (ll t = 0; t < T; ++t) {
            for (ll ct = 0; ct < CT; ++ct) {
                // Initialize maximum absolute value for the current group
                ll max_val = 0;
                // Find the maximum absolute value in the current channel group
                for (ll cp = 0; cp < CP; ++cp) {
                    
                // Calculate the index in the flattened input vector
                   max_val = max(max_val, abs(x[t * C + ct * CP + cp]));
                }
                // Initialize scaling factor
                ll s = 0;
                 // Check if the maximum value exceeds the allowed bit width
                if(max_val > BW_MAX) {
                    // Print the quantization instance name and trigger assertion failure
                    cout << type_name << endl;
                    assert(false);
                }
                // Adjust max_val for scaling calculation
                if(max_val >= 1) max_val = max_val - 1;
                 // Find the highest set bit in max_val to determine scaling factor
                for (int i = BW; i >= 1; --i) {
                    if ((max_val & (one << (i - 1))) != 0) {
                        s = i;
                        break;
                    }
                }
                // Adjust scaling factor relative to quantization bits
                s = s - (Q_BITS - 1);
                // Clamp the scaling factor between min_0 and A_CLAMP_MAX
                s = clamp(s, min_0, A_CLAMP_MAX);

                    // Quantize each value in the current channel group
                for (ll cp = 0; cp < CP; ++cp) {
                    // Get the input value at the current index
                    ll q_val = x[t * C + ct * CP + cp];
                    if(s != 0){
                         // Right-shift to scale down the value
                        q_val = q_val >> (s-1);
                        // Add 1 to adjust for rounding simulation
                        q_val = q_val + 1;
                        // Right-shift again to simulate rounding
                        q_val = q_val >> 1; // simulate the rounding
                    }
                    // Clamp the quantized value between Q_MIN and Q_MAX
//                    y[t * C + ct * CP + cp] = min(q_val, Q_MAX);
                    y[t * C + ct * CP + cp] = clamp(q_val, Q_MIN, Q_MAX);
                }
                // Store the scaling factor for the current group
                ys[t * CT + ct] =s;
            }
        }
        // Create output structure with quantized values and scaling factors
        TwoIvec two_ivec;
        two_ivec.x=y;
        two_ivec.y=ys;
        return two_ivec;
    }

};

/**
 *  Template class for RMS normalization with lookup table-based quantization.
 *
 * This class implements RMS normalization for an input integer vector, using precomputed lookup tables
 * for efficient normalization and quantization of the output.
 *
 * @tparam T Number of tokens (first dimension of the tensor).
 * @tparam D Number of channels (second dimension of the tensor).
 */
template<ll T, ll D>
class Rmsnorm1 {
public:

// Number of channels (equal to D).
    static const ll C = D; // in channels
    // Number of entries in each lookup table.
    static const ll ENTRIES = 512; 
    // Number of lookup tables.
    static const ll num_tables = 8;
    // Truncation shift for multiplication in normalization (first stage).
    static const ll RSQRT_TRUNC_MUL1 = 12;
    //  Truncation shift for multiplication in normalization (second stage).
    static const ll RSQRT_TRUNC_MUL2 = 8;
    //  Minimum value for clamping indices.
    static const ll min_0 = 0;

    //  Lookup table for alpha thresholds, loaded from file.
    const ll alphas[num_tables] = {
#include "./cmake-build-debug/bin/tables/rmsnorm1_alphas.txt"
    };
       /**
     * @brief Lookup table for log2 denominators, loaded from file.
     */
    const ll log2denoms[num_tables] = {
#include "./cmake-build-debug/bin/tables/rmsnorm1_log2denoms.txt"
    };

        /**
     * @brief Lookup table for offset differences, loaded from file.
     */
    const ll offsets_diff[num_tables] = {
#include "./cmake-build-debug/bin/tables/rmsnorm1_offsets_diff.txt"
    };

     /**
     * @brief Lookup table for normalization values, loaded from file.
     */
    const ll tables[num_tables*ENTRIES] = {
#include "./cmake-build-debug/bin/tables/rmsnorm1_tables.txt"
    };

    ivec LNW;  //Weight vector for normalization, loaded from file.
    ll layerid; //Identifier for the layer.
    // Quantization object for processing the normalized output.
    Quant<T, C, 4, 32> rms_quant = Quant<T, C, 4, 32>("rms1_qunat");

    /**
     * @brief Constructor for the Rmsnorm1 class.
     * @param layer_id Identifier for the layer, used to load weights.
     */
    explicit Rmsnorm1(ll layer_id) {

        // Construct file path for weight file using layer_id
        const string prefix = "./bin/weights/rmsnorm1_";
        const string id = "_layer" + std::to_string(layer_id) + ".bin";
         // Load weight vector from binary file
        LNW = read_tensor<ll>(prefix + "wq" + id);
        // Store the layer identifier
        layerid=layer_id;
    }

    /**
     * @brief Performs RMS normalization and quantization on an input integer vector.
     * @param x Input integer vector of size T * C.
     * @return A TwoIvec structure containing the quantized normalized vector (x) and scaling factors (y).
     * @throws Assertion failure if any weight value exceeds the allowed range.
     */
    TwoIvec forward(const ivec &x) {
        printf("start rms1\n");
         // Initialize output vector for normalized values (size T * C)
        ivec y(T * C);
        // matmul
        for (ll t = 0; t < T; ++t) {
            // Calculate the sum of squares for the current token
            ll sum = 0;
            for (ll c = 0; c < C; ++c) {
                // Compute the square of the input value and add to sum
                sum += (x[t * C + c] * x[t * C + c]);
            }

             // Select the appropriate lookup table index based on sum
            ll LUT_IDX = 0;
            for (ll i = 0; i < num_tables; ++i) {
                // Check if sum exceeds or equals the alpha threshold
                if(sum >= alphas[i])
                    LUT_IDX = i;
            }
             // Retrieve parameters from lookup tables
            ll ALPHA          = alphas[LUT_IDX];        // Alpha threshold for the selected table
            ll LOG2DENOM      = log2denoms[LUT_IDX];    // Log2 denominator for scaling
            ll OFFSET_DIFF    = offsets_diff[LUT_IDX];  // Offset difference for table access
             // Calculate table index, clamping to valid range
            ll INDEX          = clamp((sum - ALPHA) >> LOG2DENOM, min_0, ENTRIES - 1);
            // Retrieve normalized value and apply offset
            ll X_RSQRT        = tables[LUT_IDX * ENTRIES + INDEX] << OFFSET_DIFF;
            // Normalize and scale each channel
            for (ll c = 0; c < C; ++c) {
                // Multiply input by normalized value and truncate
                ll X_MUL_X_RSQRT = (x[t * C + c] * X_RSQRT) >> RSQRT_TRUNC_MUL1;
                // Apply weight and truncate again
                y[t * C + c] = (X_MUL_X_RSQRT * LNW[c]) >> RSQRT_TRUNC_MUL2;
                // Ensure weight is within valid range
                assert(abs(LNW[c])<=((one<<(LNW1_T-1))-1));
            }
        }
//        ivec ref = read_tensor<ll>("./bin/refs/rms1_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(y, ref, T, C);
         // Quantize the normalized output
        TwoIvec two_ivec;
        two_ivec = rms_quant.forward(y);
        // Return the quantized result
        return two_ivec;
    }

};

/**
 *Template class for input projection with matrix multiplication and scaling.
 *
 * This class implements an input projection mechanism that applies matrix multiplication
 * with weights and scaling factors to an input integer vector, producing a transformed output vector.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam D Number of input channels.
 * @tparam N Parameter for calculating output channels.
 * @tparam P Parameter for calculating output channels.
 */
template<ll T, ll D, ll N, ll P>
class IN_PROJ {
public:
    static const ll CI = D; // Number of input channels (equal to D).
    static const ll CO = D*4+2*N+2*D/P; // Number of output channels (D*4 + 2*N + 2*D/P).
    static const ll CIP = 8; //Number of channels per group for input processing.
    static const ll CIT = CI/CIP; // Number of input channel groups (CI / CIP).
    static const ll G = 128; // Group size for weight matrix processing.
    static const ll GT = CI/G; // Number of groups (CI / G).
    static const ll GCT = G/CIP; // Number of channel groups per group (G / CIP).
    static const ll Trunc_d = 10; // Truncation shift for output values.

    // Weight, bias, and other tensors for the MLP mechanism
    ivec scalars_s1; // First scaling factor tensor, loaded from file.
    ivec scalars_s2; // Second scaling factor tensor, loaded from file.
    ivec Iw; //Weight tensor for matrix multiplication, loaded from file.

    ll layerid; //Identifier for the layer.

        /**
     * @brief Constructor for the IN_PROJ class.
     * @param layer_id Identifier for the layer, used to load weights and scaling factors.
     */
    explicit IN_PROJ(ll layer_id) {
        // // Construct file path prefix using layer_id
        const string prefix = "./bin/weights/in_proj_";
        const string id = "_layer" + std::to_string(layer_id) + ".bin";
        //// Load weight tensor from binary file
        Iw = read_tensor<ll>(prefix + "wq" + id);
        // Load  scaling factor tensor from binary file
        scalars_s1 = read_tensor<ll>(prefix + "s1" + id);
        scalars_s2 = read_tensor<ll>(prefix + "s2" + id);
        // Store the layer identifier
        layerid=layer_id;
    }

    /**
     * @brief Performs input projection with matrix multiplication and scaling.
     * @param x Input integer vector of size T * CI.
     * @param xs Scaling factor vector of size T * CIT.
     * @return Output integer vector of size T * CO.
     * @throws Assertion failure if intermediate or output values exceed allowed ranges.
     */
    ivec forward(const ivec &x, const ivec &xs) {
        printf("start in_proj\n");
         // Initialize output vector for projected values (size T * CO)
        ivec y(T * CO);
        // matmul
        for (ll t = 0; t < T; ++t) {
            for (ll co = 0; co < CO; ++co) {
                ll acc = 0; // Initialize accumulator for matrix multiplication
                for (ll gt = 0; gt < GT; ++gt) {
                    for (ll gct = 0; gct < GCT; ++gct) {
                         // Initialize group accumulator
                        ll acc_g = 0;
                        for (ll cip = 0; cip < CIP; ++cip) {
                            // Calculate input channel index
                            ll ci = gt * G + gct * CIP + cip;
                             // Perform matrix multiplication: input * weight
                            acc_g += x[t * CI + ci] * Iw[co * CI + ci];
                        }

                        // Calculate channel group index
                        ll cit = gt * GCT + gct;
                        // Apply first scaling factor and accumulate
                        acc += acc_g << (xs[t * CIT + cit] + scalars_s1[co * GT + gt]);
                        // Apply second scaling factor and accumulate
                        acc += acc_g << (xs[t * CIT + cit] + scalars_s2[co * GT + gt]);
                         // Ensure intermediate accumulator is within valid range
                        assert(abs(acc)<=((one<<(XD_T-1))-1));
                    }
                }
                // Truncate the accumulator to produce the output value
                y[t * CO + co] = acc >> Trunc_d;
                // Ensure output value is within valid range
                assert(abs(y[t * CO + co])<=((one<<(X_T-1))-1));
            }
        }
//        printf("in_proj finished\n");
        // Return the projected output vector
        return y;
    }

};
/**
 * Template class for convolution operation with padding and state management.
 *
 * This class implements a convolution operation on an input integer vector with padding,
 * producing a convolved output vector and updated convolution states with scaling factors.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam D Number of base channels for calculating total channels.
 * @tparam N Additional parameter for calculating total channels.
 */
template<ll T, ll D, ll N>
class Conv {
public:
    static const ll C = 2 * D + 2 * N; // Number of channels (2 * D + 2 * N).
    static const ll CP = 8; // Number of channels per group for processing.
    static const ll CT = C/CP; // Number of channel groups (C / CP).
    static const ll Trunc_d = 10; // Truncation shift for output values.
    // Weight, bias, and other tensors for the MLP mechanism
    ivec scalars_w; //Weight scaling factor tensor, loaded from file.
    ivec scalars_b; //Bias scaling factor tensor, loaded from file.
    ivec Iw; //Weight tensor for convolution, loaded from file.
    ivec Ib; //Bias tensor for convolution, loaded from file.

    ll layerid; //Identifier for the layer.
    /**
     * @brief Constructor for the Conv class.
     * @param layer_id Identifier for the layer, used to load weights and scaling factors.
     */
    explicit Conv(ll layer_id) {
        // Create file path using layer_id
        const string prefix = "./bin/weights/conv_";
        const string id = "_layer" + std::to_string(layer_id) + ".bin";
        // Load tensors from binary files
        Iw = read_tensor<ll>(prefix + "wq" + id);
        scalars_w = read_tensor<ll>(prefix + "ws" + id);
        Ib = read_tensor<ll>(prefix + "bq" + id);
        scalars_b = read_tensor<ll>(prefix + "bs" + id);
        // Store the layer identifier
        layerid=layer_id;
    }
    /**
     * @brief Performs convolution with padding and state management.
     * @param x Input integer vector of size T * C.
     * @param xs Scaling factor vector of size T * CT.
     * @param conv_state Convolution state vector of size 3 * C.
     * @param conv_state_s Convolution state scaling factor vector of size 3 * CT.
     * @return A ThreeIvec structure containing the convolved output (x), new convolution state (y), and new state scaling factors (z).
     * @throws Assertion failure if intermediate or output values exceed allowed ranges.
     */
    ThreeIvec forward(const ivec &x, const ivec &xs, const ivec &conv_state, const ivec &conv_state_s) {
        printf("start conv\n");
        // padding
        // Initialize padded output vector (size (T + 3) * C)
        ivec y((T + 3) * C);
        // Initialize padded scaling factor vector (size (T + 3) * CT)
        ivec ys((T + 3) * CT);
         // Copy convolution state to the first 3 tokens for padding
        for (ll t = 0; t < 3; ++t) {
            for (ll c = 0; c < C; ++c) {
                // Copy state values to padded output
                y[t * C + c] = conv_state[t * C + c];
            }
            for (ll c = 0; c < CT; ++c) {
                // Copy state scaling factors to padded scaling vector
                ys[t * CT + c] = conv_state_s[t * CT + c];
            }
        }
        // Copy input and scaling factors to padded vectors starting at offset 3
        for (ll t = 0; t < T; ++t) {
            for (ll c = 0; c < C; ++c) {
                // Copy input values to padded output
                y[(t + 3) * C + c] = x[t * C + c];
            }
            for (ll c = 0; c < CT; ++c) {
                // Copy scaling factors to padded scaling vector
                ys[(t + 3) * CT + c] = xs[t * CT + c];
            }
        }
        // conv
        // Initialize output vector for convolved values (size T * C)
        ivec z(T * C);
        // Perform convolution
        for (ll t = 0; t < T; ++t) {
            // Iterate over each channel group
            for (ll ct = 0; ct < CT; ++ct) {
                // Iterate over each channel within the group
                for (ll cp = 0; cp < CP; ++cp) {
                    // Calculate channel index
                    ll index = ct * CP + cp;
                    // Initialize accumulator with scaled bias
                    ll acc = Ib[index] << scalars_b[ct];
                    // Apply convolution over a window of 4 tokens
                    for (ll d = 0; d < 4; ++d) {
                        // Multiply input value with corresponding weight
                        ll mul = y[(t + d) * C + index] * Iw[d * C + index];
                        // Calculate scaling factor for the current position
                        ll scale = ys[(t + d) * CT + ct] + scalars_w[d * CT + ct];
                        // Accumulate scaled multiplication result
                        acc += mul << scale;
                        // Ensure intermediate accumulator is within valid range
                        assert(abs(acc)<=((one<<(XD_T-1))-1));
                    }
                     // Truncate the accumulator to produce the output value
                    z[t * C + index] = acc >> Trunc_d;
                    // Ensure output value is within valid range
                    assert(abs(z[t * C + index])<=((one<<(X_T-1))-1));
                }
            }
        }
        // Initialize new convolution state (size 3 * C)
        ivec new_conv_state(3 * C);
          // Initialize new convolution state scaling factors (size 3 * CT)
        ivec new_conv_state_s(3 * CT);
        // Extract the last 3 tokens for the new convolution state
        for (ll t = 0; t < 3; ++t) {
            for (ll c = 0; c < C; ++c) {
                // Copy values from the end of the padded output
                new_conv_state[t * C + c] = y[(t + T) * C + c];
            }
            for (ll c = 0; c < CT; ++c) {
                // Copy scaling factors from the end of the padded scaling vector
                new_conv_state_s[t * CT + c] = ys[(t + T) * CT + c];
            }

        }

//        printf("conv finished\n");

// Create output structure with convolved output and new states
        ThreeIvec three_ivec;
        three_ivec.x = z;
        three_ivec.y = new_conv_state;
        three_ivec.z = new_conv_state_s;
        // Return the result
        return three_ivec;
    }

};

/**
 * @file Silu.h
 * @brief Template class for SiLU (Sigmoid Linear Unit) activation with lookup table-based processing.
 *
 * This class implements the SiLU activation function on an input integer vector, using precomputed lookup tables
 * for efficient activation and quantization of the output.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam D Number of base channels for calculating total channels.
 * @tparam N Additional parameter for calculating total channels.
 */
template<ll T, ll D, ll N>
class Silu {
public:
    static const ll C = 4 * D + 2 * N; // Number of input channels (4 * D + 2 * N).
    static const ll CP = 8; //
    static const ll CT = C/CP; // in channels

    //  Alpha offset for input normalization.
    static const ll alpha = -25600;
    //  Number of entries in the main lookup table.
    static const ll entries = 4096;     //1387.6070436610555
    // Number of entries in the scaling lookup table.
    static const ll entries_s = 32;
    // Minimum value for clamping indices.
    static const ll min_0 = 0;

// Log2 denominator for main table index calculation.
    static const ll log2denom = 5;
    //  Log2 denominator for scaling table index calculation.
    static const ll log2denom_s = 12;
//  Main lookup table for SiLU activation values, loaded from file.
    const ll table[entries] = {
#include "./cmake-build-debug/bin/tables/silu_table.txt"
    };
    //  Lookup table for scaling factors, loaded from file.
    const ll table_s[entries_s] = {
#include "./cmake-build-debug/bin/tables/silu_table_s.txt"
    };

       /**
     * @brief Quantization object for processing the activated output.
     */
    Quant<T, C, 8, 32> silu_quant = Quant<T, C, 8, 32>("silu_quant");
    ll layerid; //Identifier for the layer.
// Default constructor for the Silu class.
    Silu() = default;
   /**
     * @brief Constructor for the Silu class.
     * @param layer_id Identifier for the layer.
     */
    explicit Silu(ll layer_id) {
        // Store the layer identifier
        layerid=layer_id;
    }
    /**
     * @brief Applies SiLU activation and quantization to an input integer vector.
     * @param x Input integer vector of size T * C.
     * @return A TwoIvec structure containing the quantized activated vector (x) and scaling factors (y).
     */
    TwoIvec forward(const ivec &x) {
        // Initialize output vector for activated values (size T * C)
        ivec y(T * C);
        // // Apply SiLU activation
        for (ll t = 0; t < T; ++t) {
            for (ll c = 0; c < C; ++c) {
                // Calculate index for main lookup table by shifting input
                ll cursor = (x[t * C + c] - alpha) >> log2denom;
                // Calculate index for scaling lookup table
                ll cursor_s = (x[t * C + c] - alpha) >> log2denom_s;
                 // Clamp main table index to valid range
                cursor = clamp(cursor, min_0, entries - 1);
                 // Clamp scaling table index to valid range
                cursor_s = clamp(cursor_s, min_0, entries_s - 1);
                // Retrieve SiLU activation value from main table
                ll silu_val = table[cursor];
                // Retrieve scaling factor from scaling table
                ll output_scale = table_s[cursor_s];
                // Apply scaling to the activation value
                y[t * C + c] = silu_val << output_scale;
            }
        }
// Quantize the activated output
        TwoIvec two_ivec;
        two_ivec = silu_quant.forward(y);
        // Return the quantized result
        return two_ivec;
    }
};

/**
 *  Template class for Softplus activation with bias addition and quantization.
 *
 * This class implements a transformation that adds a bias to an input integer vector, applies the Softplus
 * activation function using precomputed lookup tables, and quantizes the output.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam C Number of channels.
 */
template<ll T, ll C>
class DtAdapt {
public:
    static const ll CP = 8; //
    static const ll CT = C/CP; // in channels

    //  Alpha offset for input normalization in Softplus calculation.
    static const ll alpha = -25600;
    // Number of entries in the main Softplus lookup table.
    static const ll entries = 4096;     //1387.6070436610555
    //  Number of entries in the scaling lookup table.
    static const ll entries_s = 32;
    // Minimum value for clamping indices.
    static const ll min_0 = 0;
    //  Log2 denominator for main table index calculation.
    static const ll log2denom = 4;
    // denominator for scaling table index calculation.
    static const ll log2denom_s = 11;

    // Main lookup table for Softplus activation values, loaded from file.
    const ll table[entries] = {
#include "./cmake-build-debug/bin/tables/softplus_table.txt"
    };

    // Lookup table for scaling factors, loaded from file.
    const ll table_s[entries_s] = {
#include "./cmake-build-debug/bin/tables/softplus_table_s.txt"
    };
    // Quantization object for processing the activated output.
    Quant<T, C, 8, 32> dt_quant = Quant<T, C, 8, 32>("dt_quant");

    ll layerid;

    // Bias scaling factor tensor, loaded from file.
    ivec scalars;
    // Bias tensor, loaded from file.
    ivec Ib;
    /**
     * @brief Constructor for the DtAdapt class.
     * @param layer_id Identifier for the layer, used to load bias and scaling factors.
     */
    explicit DtAdapt(ll layer_id) {
        // Create file path using layer_id
        const string prefix = "./bin/weights/dt_";
        const string id = "_layer" + std::to_string(layer_id) + ".bin";
        // Load tensors from binary files
        Ib = read_tensor<ll>(prefix + "bq" + id);
        scalars = read_tensor<ll>(prefix + "bs" + id);
        layerid=layer_id;
    }
    /**
     * @brief Applies bias addition, Softplus activation, and quantization to an input integer vector.
     * @param x Input integer vector of size T * C.
     * @return A TwoIvec structure containing the quantized activated vector (x) and scaling factors (y).
     * @throws Assertion failure if output values exceed the allowed range.
     */
    TwoIvec forward(const ivec &x) {
// Initialize intermediate vector for biased values (size T * C)
        ivec y(T * C);
         // Initialize output vector for activated values (size T * C)
        ivec z(T * C);
        // add bias
        for (ll t = 0; t < T; ++t) {
            for (ll ct = 0; ct < CT; ++ct) {
                for (ll cp = 0; cp < CP; ++cp) {
                    // Calculate scaled bias
                    ll bias = Ib[ct * CP + cp] << scalars[ct];
                    // Add bias to input value
                    y[t * C + ct * CP + cp] = x[t * C + ct * CP + cp] + bias;
                    // Ensure output value is within valid range
                    assert(abs(y[t * C + ct * CP + cp])<=((one<<(X_T-1))-1));
                }
            }
        }
        // Apply Softplus activation
        for (ll t = 0; t < T; ++t) {
            for (ll c = 0; c < C; ++c) {
                 // Calculate index for main Softplus lookup table
                ll cursor = (y[t * C + c] - alpha) >> log2denom;
                // Calculate index for scaling lookup table
                ll cursor_s = (y[t * C + c] - alpha) >> log2denom_s;
                // Clamp main table index to valid range
                cursor = clamp(cursor, min_0, entries - 1);
                 // Clamp scaling table index to valid range
                cursor_s = clamp(cursor_s, min_0, entries_s - 1);
                // Retrieve Softplus activation value from main table
                ll softplus_val = table[cursor];
                 // Retrieve scaling factor from scaling table
                ll output_scale = table_s[cursor_s];
                // Apply scaling to the activation value
                z[t * C + c] = softplus_val << output_scale;
            }
        }

        // Quantize the activated output
        TwoIvec two_ivec;
        two_ivec = dt_quant.forward(z);
        return two_ivec;
    }

};
/**
 * Template class for exponential activation with lookup table-based processing.
 *
 * This class implements the exponential activation function on an input integer vector, using precomputed
 * lookup tables for efficient activation and quantization of the output.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam C Number of channels.
 */
template<ll T, ll C>
class Exp {
public:
    static const ll CP = 8; //
    static const ll CT = C/CP; // in channels

    static const ll alpha = -20480;
    static const ll entries = 4096;     //1387.6070436610555
    static const ll entries_s = 32;
    static const ll min_0 = 0;
    static const ll log2denom = 3;
    static const ll log2denom_s = 10;

    const ll table[entries] = {
#include "./cmake-build-debug/bin/tables/exp_table.txt"
    };
    const ll table_s[entries_s] = {
#include "./cmake-build-debug/bin/tables/exp_table_s.txt"
    };

    Quant<T, C, 8, 32> exp_quant = Quant<T, C, 8, 32>("exp_quant");
    ll layerid;

    Exp() = default;

    explicit Exp(ll layer_id) {
        layerid=layer_id;
    }

    /**
     * @brief Applies exponential activation and quantization to an input integer vector.
     * @param x Input integer vector of size T * C.
     * @return A TwoIvec structure containing the quantized activated vector (x) and scaling factors (y).
     */
    TwoIvec forward(const ivec &x) {
        // Initialize output vector for activated values (size T * C)
        ivec y(T * C);
        // Apply exponential activation
        for (ll t = 0; t < T; ++t) {
            for (ll c = 0; c < C; ++c) {
                 // Calculate index for main exponential lookup table
                ll cursor = (x[t * C + c] - alpha) >> log2denom;
                // Calculate index for scaling lookup table
                ll cursor_s = (x[t * C + c] - alpha) >> log2denom_s;
                // Clamp main table index to valid range
                cursor = clamp(cursor, min_0, entries - 1);
                // Clamp scaling table index to valid range
                cursor_s = clamp(cursor_s, min_0, entries_s - 1);
                 // Retrieve exponential activation value from main table
                ll exp_val = table[cursor];
                // Retrieve scaling factor from scaling table
                ll output_scale = table_s[cursor_s];
                // Apply scaling to the activation value
                y[t * C + c] = exp_val << output_scale;
            }
        }

         // Quantize the activated output
        TwoIvec two_ivec;
        two_ivec = exp_quant.forward(y);
        return two_ivec;
    }
};

/**
 * SSM Template class for Selective State Space Model (SSM) processing.
 *
 * This class implements a Selective State Space Model, performing operations such as matrix multiplication,
 * exponential activation, and quantization on input tensors with hidden state management.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam D Number of base channels for calculating total channels.
 * @tparam N Additional parameter for calculating channel dimensions.
 * @tparam P Parameter for calculating head channels.
 * @tparam L Total number of layers (used for conditional debugging).
 */
template<ll T, ll D, ll N, ll P, ll L>
class SSM {
public:
    static const ll C2 = 2 * D; // Number of channels (2 * D)
    static const ll CH = 2 * D / P; // Number of head channels (2 * D / P).
    static const ll CP = 8; //
    static const ll C2T = C2/CP;
    static const ll NT = N/CP;
    static const ll HT = CH/CP;
    static const ll PT = P/CP;
//Quantization object for dB tensor.
    Quant<T, N * CH, 8, 32> dB_quant = Quant<T, N * CH, 8, 32>("dB_quant");
    // Exponential activation object for dA processing.
    Exp<T, CH> exp;
    //  Quantization object for hidden state type 1.
    Quant<N, C2, 8, 32> ht_quant_type1 = Quant<N, C2, 8, 32>("ht_quant_type1");
    // Quantization object for hidden state type 2
    Quant<C2, N, 8, 32> ht_quant_type2 = Quant<C2, N, 8, 32>("ht_quant_type2");
    // Quantization object for output tensor y.
    Quant<T, C2, 8, 32> y_quant = Quant<T, C2, 8, 32>("y_quant");
    ll layerid;

    ivec scalars_a;//Scaling factor tensor for matrix A, loaded from file.
    ivec IA;        //Matrix A tensor, loaded from file.
    ivec scalars_d; //Scaling factor tensor for matrix D, loaded from file.
    ivec ID; //Matrix D tensor, loaded from file.
    string mamba_model_name; //Name of the Mamba model (unused in current implementation).

        /**
     * @brief Constructor for the SSM class.
     * @param layer_id Identifier for the layer, used to load weights and scaling factors.
     */
    explicit SSM(ll layer_id) {
        // Create file path using layer_id
        const string prefix_A = "./bin/weights/A_";
        const string prefix_D = "./bin/weights/D_";
        const string id = "_layer" + std::to_string(layer_id) + ".bin";
        // Load tensors from binary files
        scalars_a = read_tensor<ll>(prefix_A + "s" + id);
        IA = read_tensor<ll>(prefix_A + "q" + id);
        scalars_d = read_tensor<ll>(prefix_D + "s" + id);
        ID = read_tensor<ll>(prefix_D + "q" + id);
        layerid=layer_id; 


    }
    /**
     * @brief Performs SSM processing with matrix operations, exponential activation, and quantization.
     * @param dt Input delta tensor of size T * CH.
     * @param dts Scaling factor tensor for dt of size T * HT.
     * @param B Input B tensor of size T * N.
     * @param Bs Scaling factor tensor for B of size T * NT.
     * @param C Input C tensor of size T * N.
     * @param Cs Scaling factor tensor for C of size T * NT.
     * @param x Input x tensor of size T * C2.
     * @param xs Scaling factor tensor for x of size T * C2T.
     * @param z Input z tensor of size T * C2.
     * @param zs Scaling factor tensor for z of size T * C2T.
     * @param hidden_state Initial hidden state tensor of size N * C2.
     * @param hidden_state_s Scaling factor tensor for hidden state of size N * C2T.
     * @return A ThreeIvec structure containing the output tensor (x), updated hidden state (y), and updated hidden state scaling factors (z).
     * @throws Assertion failure if intermediate or output values exceed allowed ranges.
     */
    ThreeIvec forward(const ivec &dt, const ivec &dts,
                    const ivec &B, const ivec &Bs,
                    const ivec &C, const ivec &Cs,
                    const ivec &x, const ivec &xs,
                    const ivec &z, const ivec &zs,
                    const ivec &hidden_state, const ivec &hidden_state_s) {

        printf("start ssm\n");
        TwoIvec two_ivec;
        ll Trunc_d;

        // Compute dA = dt * A
        ivec dA(T * CH);
        Trunc_d = 10; // Set truncation shift for dA
        for (ll t = 0; t < T; ++t) {
            for (ll ht = 0; ht < HT; ++ht) {
                 // Calculate scaling factor
                ll scale = dts[t * HT + ht] + scalars_a[ht];
                for (ll cp = 0; cp < CP; ++cp) {
                     // Multiply dt with A matrix element
                    ll mul = dt[t * CH + ht * CP + cp] * IA[ht * CP + cp];
                    // Apply scaling and store in dA
                    dA[t * CH + ht * CP + cp] = mul << scale;
                     // Ensure intermediate value is within valid range
                    assert(abs(dA[t * CH + ht * CP + cp])<=((one<<(XD_T-1))-1));
                    // Truncate the result
                    dA[t * CH + ht * CP + cp] >>= Trunc_d;
                    // Ensure truncated value is within valid range
                    assert(abs(dA[t * CH + ht * CP + cp])<=((one<<(X_T-1))-1));
                }
            }
        }


        // Debugging check for dA (commented out)
        // dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_dA_" + std::to_string(layerid) + ".bin");
        // compare_double(dA, ref, T, CH, CP, Sy, "layer_" + std::to_string(layerid),0.1,0.1);

        // Apply exponential activation to dA
        ivec dAs(T * HT);
        two_ivec = exp.forward(dA);
        dA = two_ivec.x;  // Quantized dA
        dAs = two_ivec.y;  // Scaling factors for dA

//        // check dA_exp
//        ivec ref = read_tensor<ll>("./bin/refs/dA_exp_q_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(dA, ref, T, CH);
//        ivec ref = read_tensor<ll>("./bin/refs/dA_exp_s_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(dAs, ref, T, HT);

         // Compute dB = dt * B
        ivec dB(T * N * CH);
        Trunc_d = 0;  // No truncation for dB
        for (ll t = 0; t < T; ++t) {
            for (ll ht = 0; ht < HT; ++ht) {
                for (ll nt = 0; nt < NT; ++nt) {
                    // Calculate scaling factor
                    ll scale = dts[t * HT + ht] + Bs[t * NT + nt];
                    for (ll np = 0; np < CP; ++np) {
                        for (ll cp = 0; cp < CP; ++cp) {
                            // Multiply dt with B matrix element
                            ll mul = dt[t * CH + ht * CP + cp] * B[t * N + nt * CP + np];
                            // Apply scaling and store in dB
                            dB[t * N * CH + (nt * CP + np) * CH + ht * CP +cp] = mul << scale;
                            // Ensure intermediate value is within valid range
                            assert(abs(dB[t * N * CH + (nt * CP + np) * CH + ht * CP +cp])<=((one<<(XD_T-1))-1));
                            // Apply truncation (none in this case)
                            dB[t * N * CH + (nt * CP + np) * CH + ht * CP +cp] >>= Trunc_d;
                            // Ensure truncated value is within valid range
                            assert(abs(dB[t * N * CH + (nt * CP + np) * CH + ht * CP +cp])<=((one<<(X_T-1))-1));
                        }
                    }
                }
            }
        }

//        // check dB
//        dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_dB_" + std::to_string(layerid) + ".bin");
//        compare_double(dB, ref, T * N, CH, CP, Sy, "layer_" + std::to_string(layerid),0.1,0.1);


        //  // Quantize dB
        ivec dBs(T * N * HT);
        // Quantized dB
        two_ivec=dB_quant.forward(dB);
        dB = two_ivec.x;
        dBs = two_ivec.y;
        printf("dB finished\n");

//        // check dB
//        ivec ref = read_tensor<ll>("./bin/refs/dB_q_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(dB, ref, T * N, CH);
//        ivec ref = read_tensor<ll>("./bin/refs/dB_s_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(dBs, ref, T * N, HT);


        // // Compute dBx = dB * x
        ivec dBx(T * N * C2);
        Trunc_d = 11;
        for (ll t = 0; t < T; ++t) {
            for (ll ht = 0; ht < HT; ++ht) {
                for (ll chp = 0; chp < CP; ++chp) {
                    for (ll pt = 0; pt < PT; ++pt) {
                        for (ll n = 0; n < N; ++n) {
                            // Calculate scaling factor
                            ll scale = dBs[t * N * HT + n * HT + ht] + xs[t * C2T + (ht * CP +chp) * PT + pt];
                            for (ll cp = 0; cp < CP; ++cp) {
                                // Multiply dB with x
                                ll mul = dB[t * N * CH + n * CH + ht * CP + chp] * x[t * C2 + (ht * CP + chp) * P + pt * CP + cp];
                                 // Apply scaling and store in dBx
                                dBx[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp] = mul << scale;
                                // Ensure intermediate value is within valid range
                                assert(abs(dBx[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp])<=((one<<(DBU_T-1))-1));
                                // Truncate the result
                                dBx[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp] >>= Trunc_d;
                                // Ensure truncated value is within valid range
                                assert(abs(dBx[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp])<=((one<<(X_T-1))-1));
                            }
                        }
                    }
                }
            }
        }

//        // check dBx
//        dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_dBx_" + std::to_string(layerid) + ".bin");
//        compare_double(dBx, ref, T * N, C2, CP, Sy, "layer_" + std::to_string(layerid),0.1,0.1);

        //  // Compute xD = x * D
        ivec xD(T * C2);
        Trunc_d = 8;
        for (ll t = 0; t < T; ++t) {
            for (ll ht = 0; ht < HT; ++ht) {
                for (ll chp = 0; chp < CP; ++chp) {
                    for (ll pt = 0; pt < PT; ++pt) {
                        ll scale = xs[t * C2T + (ht * CP +chp) * PT + pt] + scalars_d[ht];
                        for (ll cp = 0; cp < CP; ++cp) {
                            ll mul = x[t * C2 + (ht * CP + chp) * P + pt * CP + cp] * ID[ht * CP + chp];
                            xD[t * C2 + (ht * CP + chp) * P + pt * CP + cp] = mul << scale;
                            assert(abs(xD[t * C2 + (ht * CP + chp) * P + pt * CP + cp])<=((one<<(XD_T-1))-1));
                            xD[t * C2 + (ht * CP + chp) * P + pt * CP + cp] >>= Trunc_d;
                            assert(abs(xD[t * C2 + (ht * CP + chp) * P + pt * CP + cp])<=((one<<(X_T-1))-1));
                        }
                    }
                }
            }
        }

//        // check xD
//        dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_xD_" + std::to_string(layerid) + ".bin");
//        compare_double(xD, ref, T, C2, CP, Sy, "layer_" + std::to_string(layerid),0.2,0.02);

        // Initialize hidden state type 1
        ivec hidden_state_type1(N * C2);
        ivec hidden_state_type1_s(N * C2T);
        for (ll n = 0; n < N; ++n) {
            for (ll c = 0; c < C2; ++c) {
                // Copy initial hidden state
                hidden_state_type1[n * C2 + c] = hidden_state[n * C2 + c];
            }
            for (ll c = 0; c < C2T; ++c) {
                 // Copy initial hidden state scaling factors
                hidden_state_type1_s[n * C2T + c] = hidden_state_s[n * C2T + c];
            }
        }

        // // Process hidden state loop
        ivec dAht(T * N * C2);
        ivec hidden_state_type2(C2 * N);
        ivec hidden_state_type2_s(C2 * NT);
        ivec htC(T * C2);
        ivec y(T * C2);
        ivec ht_copy(N * C2);
        ivec ht_copy_s(NT * C2);
        for (ll t = 0; t < T; ++t) {

            // // Compute dAht = dA * hidden_state-1
            Trunc_d = 6; // Set truncation shift for dAht
            for (ll ht = 0; ht < HT; ++ht) {
                for (ll chp = 0; chp < CP; ++chp) {
                    for (ll pt = 0; pt < PT; ++pt) {
                        for (ll n = 0; n < N; ++n) {
                            // Calculate scaling factor
                            ll scale = dAs[t * HT + ht] +
                                       hidden_state_type1_s[n * C2T + (ht * CP + chp) * PT + pt];
                            for (ll cp = 0; cp < CP; ++cp) {
                                // Multiply dA with previous hidden state
                                ll mul = dA[t * CH + ht * CP + chp] *
                                         hidden_state_type1[n * C2 + (ht * CP + chp) * P + pt * CP + cp];
                                         // Apply scaling and store in dAht
                                dAht[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp] = mul << scale;
                                // Ensure intermediate value is within valid range
                                assert(abs(dAht[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp])<=((one<<(XD_T-1))-1));
                                // Truncate the result
                                dAht[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp] >>= Trunc_d;
                                // Ensure truncated value is within valid range
                                assert(abs(dAht[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp])<=((one<<(X_T-1))-1));
                            }
                        }
                    }
                }
            }

             // Update hidden state: hidden_state = dAht + dBx
            for (ll ht = 0; ht < HT; ++ht) {
                for (ll chp = 0; chp < CP; ++chp) {
                    for (ll pt = 0; pt < PT; ++pt) {
                        for (ll n = 0; n < N; ++n) {
                            for (ll cp = 0; cp < CP; ++cp) {
                                // Add dAht and dBx to update hidden state
                                hidden_state_type1[n * C2 + (ht * CP + chp) * P + pt * CP + cp] =
                                        dAht[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp] +
                                        dBx[t * N * C2 + n * C2 + (ht * CP + chp) * P + pt * CP + cp];
                                         // Ensure updated hidden state is within valid range
                                assert(abs(hidden_state_type1[n * C2 + (ht * CP + chp) * P + pt * CP + cp])<=((one<<(X_T-1))-1));
                            }
                        }
                    }
                }
            }

           // Transpose hidden state to type 2
            for (ll n = 0; n < N; ++n) {
                for (ll c = 0; c < C2; ++c) {
                    hidden_state_type2[c * N + n] = hidden_state_type1[n * C2 + c];
                }
            }

            //copy ht
//            if(layerid == L-1&&t==1) {
//                for (ll n = 0; n < N; ++n) {
//                    for (ll c = 0; c < C2; ++c) {
//                        ht_copy[n * C2 + c] = hidden_state_type1[n * C2 + c];
//                    }
//                }
//            }
           // Quantize hidden state type 1
            two_ivec = ht_quant_type1.forward(hidden_state_type1);
            hidden_state_type1 = two_ivec.x;
            hidden_state_type1_s = two_ivec.y;

             // Quantize hidden state type 2
            two_ivec = ht_quant_type2.forward(hidden_state_type2);
            hidden_state_type2 = two_ivec.x;
            hidden_state_type2_s = two_ivec.y;

            // Copy quantized hidden states for debugging (commented out)
//            if(layerid == L-1&&t==1) {
//                for (ll n = 0; n < N; ++n) {
//                    for (ll c = 0; c < C2; ++c) {
//                        ht_copy[c * N + n] = hidden_state_type2[c * N + n];
//                    }
//                }
//                for (ll n = 0; n < NT; ++n) {
//                    for (ll c = 0; c < C2; ++c) {
//                        ht_copy_s[c * NT + n] = hidden_state_type2_s[c * NT + n];
//                    }
//                }
//            }

             // Compute htC = hidden_state_type2 * C
            Trunc_d = 17; // Set truncation shift for htC
            for (ll c = 0; c < C2; ++c) {
                // Initialize accumulator for channel
                ll acc = 0;
                 // Iterate over N channel groups 
                for (ll nt = 0; nt < NT; ++nt) { 
                    // Initialize group accumulator
                    ll acc_g = 0;
                    // Calculate scaling factor
                    ll scale = hidden_state_type2_s[c * NT + nt] + Cs[t * NT + nt];
                    // Iterate over channels in N group
                    for (ll np = 0; np < CP; ++np) {
                        // Multiply hidden state with C matrix element
                        acc_g += hidden_state_type2[c * N + nt * CP + np] * C[t * N + nt * CP + np];
                    }
                    // Apply scaling and accumulate
                    acc += acc_g << scale;
                    // Ensure intermediate accumulator is within valid range
                    assert(abs(acc)<=((one<<(HTC_T-1))-1));
                }
                // Truncate and store in htC
                htC[t * C2 + c] = acc >> Trunc_d;
                // Ensure truncated value is within valid range
                assert(abs(htC[t * C2 + c])<=((one<<(X_T-1))-1));
            }
        }
        printf("ht finished\n");

//        // check dAht
//        dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_dAht_" + std::to_string(layerid) + ".bin");
//        compare_double(dAht, ref, T * N, C2, CP, Sy, "layer_" + std::to_string(layerid),0.1,0.01);

        // check ht
//        if(layerid == L-1) {
//            ivec ref = read_tensor<ll>("./bin/refs/ht_layer" + std::to_string(layerid) + ".bin");
//            compare_v_with_shape(ht_copy, ref, N, C2);
//        }

        // check ht2
//        if(layerid == L-1) {
////            ivec ref = read_tensor<ll>("./bin/refs/ht2_q_layer" + std::to_string(layerid) + ".bin");
////            compare_v_with_shape(ht_copy, ref, C2, N);
////            ivec ref = read_tensor<ll>("./bin/refs/ht2_s_layer" + std::to_string(layerid) + ".bin");
////            compare_v_with_shape(ht_copy_s, ref, C2, NT);
//        }

        // check htC
//        if(layerid == L-1) {
//            ivec ref = read_tensor<ll>("./bin/refs/htC_layer" + std::to_string(layerid) + ".bin");
//            compare_v_with_shape(htC, ref, T, C2);
//        }

       // Compute y = htC + xD
        for (ll t = 0; t < T; ++t) {
            for (ll c = 0; c < C2; ++c) {
                // Add htC and xD to produce output
                y[t * C2 + c] = htC[t * C2 + c] + xD[t * C2 + c];

                // Ensure output value is within valid range
                assert(abs(y[t * C2 + c])<=((one<<(X_T-1))-1));
            }
        }

//        // check y before quant
//        ivec ref = read_tensor<ll>("./bin/refs/y_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(y, ref, T, C2);
        


        // Quantize y
        ivec ys(T * C2T);
        two_ivec = y_quant.forward(y);
        y = two_ivec.x;
        ys = two_ivec.y;
        printf("y finished\n");


//        // check y
//        ivec ref = read_tensor<ll>("./bin/refs/y_q_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(y, ref, T, C2);
//        ivec ref = read_tensor<ll>("./bin/refs/y_s_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(ys, ref, T, C2T);
        

        // Compute yz = y * z
        ivec yz(T * C2);
        ivec yzs(T * C2T);
        Trunc_d = 10; // Set truncation shift for yz
        for (ll t = 0; t < T; ++t) {
            for (ll ct = 0; ct < C2T; ++ct) {
                ll scale = ys[t * C2T + ct] + zs[t * C2T + ct];
                for (ll cp = 0; cp < CP; ++cp) {
                    // Multiply y with z
                    ll mul = y[t * C2 + ct * CP + cp] * z[t * C2 + ct * CP + cp];
                     // Apply scaling and store in yz
                    yz[t * C2 + ct * CP + cp] = mul << scale;
                    // Ensure intermediate value is within valid range
                    assert(abs(yz[t * C2 + ct * CP + cp])<=((one<<(XD_T-1))-1));
                    // Truncate the result
                    yz[t * C2 + ct * CP + cp] >>= Trunc_d;
                    // Ensure truncated value is within valid range
                    assert(abs(yz[t * C2 + ct * CP + cp])<=((one<<(X_T-1))-1));
                }
//                yzs[t * C2T + ct] = scale;
            }
        }

//        printf("finish ssm\n");
// Create output structure with final output and updated hidden states
        ThreeIvec three_ivec;
        three_ivec.x = yz; // Final output
        three_ivec.y = hidden_state_type1;   // Updated hidden state
        three_ivec.z = hidden_state_type1_s; // Updated hidden state scaling factors
        // Return the result
        return three_ivec;
    }
};

/**
 * Template class for RMS normalization with lookup table-based processing.
 *
 * This class implements RMS normalization for an input integer vector, using precomputed lookup tables
 * for efficient normalization and quantization of the output.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam D Number of base channels for calculating total channels.
 */
template<ll T, ll D>
class Rmsnorm2 {
public:
    static const ll C = 2 * D; //Number of input channels (2 * D).
    // Number of entries in each lookup table.
    static const ll ENTRIES = 512;
    //  Number of lookup tables.
    static const ll num_tables = 8;
    //  Truncation shift for multiplication in normalization (first stage).
    static const ll RSQRT_TRUNC_MUL1 = 12;
    //  Truncation shift for multiplication in normalization (second stage).
    static const ll RSQRT_TRUNC_MUL2 = 8;
    //  Minimum value for clamping indices.
    static const ll min_0 = 0;
// Lookup table for alpha thresholds, loaded from file.
    const ll alphas[num_tables] = {
#include "./cmake-build-debug/bin/tables/rmsnorm2_alphas.txt"
    };

    // Lookup table for log2 denominators, loaded from file.
    const ll log2denoms[num_tables] = {
#include "./cmake-build-debug/bin/tables/rmsnorm2_log2denoms.txt"
    };
    // Lookup table for offset differences, loaded from file.
    const ll offsets_diff[num_tables] = {
#include "./cmake-build-debug/bin/tables/rmsnorm2_offsets_diff.txt"
    };

    // Lookup table for normalization values, loaded from file.
    const ll tables[num_tables*ENTRIES] = {
#include "./cmake-build-debug/bin/tables/rmsnorm2_tables.txt"
    };

    ivec LNW; //Weight vector for normalization, loaded from file.
    ll layerid;
    // Quantization object for processing the normalized output.
    Quant<T, C, 4, 32> rms_quant = Quant<T, C, 4, 32>("rms2_qunat");

    /**
     * @brief Constructor for the Rmsnorm2 class.
     * @param layer_id Identifier for the layer, used to load weights.
     */
    explicit Rmsnorm2(ll layer_id) {
        // Create file path using layer_id
        const string prefix = "./bin/weights/rmsnorm2_";
        const string id = "_layer" + std::to_string(layer_id) + ".bin";
        LNW = read_tensor<ll>(prefix + "wq" + id);
        layerid=layer_id;
    }

    /**
     * @brief Performs RMS normalization and quantization on an input integer vector.
     * @param x Input integer vector of size T * C.
     * @return A TwoIvec structure containing the quantized normalized vector (x) and scaling factors (y).
     * @throws Assertion failure if weight values exceed the allowed range.
     */

    TwoIvec forward(const ivec &x) {
        printf("start rms2\n");
        // Initialize output vector for normalized values (size T * C)
        ivec y(T * C);
        // matmul
        for (ll t = 0; t < T; ++t) {
            // Calculate the sum of squares for the current token
            ll sum = 0;
            for (ll c = 0; c < C; ++c) {
                // Compute the square of the input value and add to sum
                sum += (x[t * C + c] * x[t * C + c]);
            }
            // Select the appropriate lookup table index based on sum
            ll LUT_IDX = 0;
            for (ll i = 0; i < num_tables; ++i) {
                // Check if sum exceeds or equals the alpha threshold
                if(sum >= alphas[i])
                    LUT_IDX = i;
            }
             // Retrieve parameters from lookup tables
            ll ALPHA          = alphas[LUT_IDX];  // Alpha threshold for the selected table
            ll LOG2DENOM      = log2denoms[LUT_IDX];  // Log2 denominator for scaling
            ll OFFSET_DIFF    = offsets_diff[LUT_IDX]; // Offset difference for table access
            // Calculate table index, clamping to valid range
            ll INDEX          = clamp((sum - ALPHA) >> LOG2DENOM, min_0, ENTRIES - 1);
            // Retrieve normalized value and apply offset
            ll X_RSQRT        = tables[LUT_IDX * ENTRIES + INDEX] << OFFSET_DIFF;
            // Normalize and scale each channel
            for (ll c = 0; c < C; ++c) {
                // Multiply input by normalized value and truncate
                ll X_MUL_X_RSQRT = (x[t * C + c] * X_RSQRT) >> RSQRT_TRUNC_MUL1;
                // Apply weight and truncate again
                y[t * C + c] = (X_MUL_X_RSQRT * LNW[c]) >> RSQRT_TRUNC_MUL2;
                // Ensure weight is within valid range
                assert(abs(LNW[c])<=((one<<(LNW2_T-1))-1));
            }
        }

//        ivec ref = read_tensor<ll>("./bin/refs/rms2_layer" + std::to_string(layerid) + ".bin");
//        compare_v_with_shape(y, ref, T, C);

// Quantize the normalized output
        TwoIvec two_ivec;
        two_ivec = rms_quant.forward(y);
        return two_ivec;
    }
};

/**
 * Template class for output projection with matrix multiplication and scaling.
 *
 * This class implements an output projection mechanism that applies matrix multiplication
 * with weights and scaling factors to an input integer vector, producing a transformed output vector.
 *
 * @tparam T Number of tokens (first dimension of the input tensor).
 * @tparam D Number of base channels for calculating input and output channels.
 */
template<ll T, ll D>
class OUT_PROJ {
public:
    static const ll CI = 2 * D; //Number of input channels (2 * D).
    static const ll CO = D; //Number of output channels (D).
    static const ll CIP = 8; // Number of channels per group for input processing.
    static const ll CIT = CI/CIP; // Number of input channel groups (CI / CIP).
    static const ll G = 128; // Group size for weight matrix processing.
    static const ll GT = CI/G; // Number of groups (CI / G).
    static const ll GCT = G/CIP; // Number of channel groups per group (G / CIP).
    static const ll Trunc_d = 12; // Truncation shift for output values.

    // Weight, bias, and other tensors for the MLP mechanism
    ivec scalars_s1;
    ivec scalars_s2;
    ivec Iw;

    ll layerid;

    /**
     * @brief Constructor for the OUT_PROJ class.
     * @param layer_id Identifier for the layer, used to load weights and scaling factors.
     */
    explicit OUT_PROJ(ll layer_id) {
        // Create file path using layer_id
        const string prefix = "./bin/weights/out_proj_";
        const string id = "_layer" + std::to_string(layer_id) + ".bin";
        // Load tensors from binary files
        Iw = read_tensor<ll>(prefix + "wq" + id);
        scalars_s1 = read_tensor<ll>(prefix + "s1" + id);
        scalars_s2 = read_tensor<ll>(prefix + "s2" + id);
        layerid=layer_id;
    }
    /**
     * @brief Performs output projection with matrix multiplication and scaling.
     * @param x Input integer vector of size T * CI.
     * @param xs Scaling factor vector of size T * CIT.
     * @return Output integer vector of size T * CO.
     * @throws Assertion failure if intermediate or output values exceed allowed ranges.
     */
    ivec forward(const ivec &x, const ivec &xs) {
        printf("start out_proj\n");
        // Initialize output vector for projected values (size T * CO)
        ivec y(T * CO);
        // matmul
        for (ll t = 0; t < T; ++t) {
            for (ll co = 0; co < CO; ++co) {
                 // Initialize accumulator for matrix multiplication
                ll acc = 0;
                for (ll gt = 0; gt < GT; ++gt) {
                    for (ll gct = 0; gct < GCT; ++gct) {
                         // Initialize group accumulator
                        ll acc_g = 0;
                        for (ll cip = 0; cip < CIP; ++cip) {
                            // Calculate input channel index
                            ll ci = gt * G + gct * CIP + cip;

                            // Perform matrix multiplication: input * weight
                            acc_g += x[t * CI + ci] * Iw[co * CI + ci];
                        }
                        // Calculate channel group index
                        ll cit = gt * GCT + gct;
                        // Apply first scaling factor and accumulate
                        acc += acc_g << (xs[t * CIT + cit] + scalars_s1[co * GT + gt]);
                        // Apply second scaling factor and accumulate
                        acc += acc_g << (xs[t * CIT + cit] + scalars_s2[co * GT + gt]);
                        // Ensure intermediate accumulator is within valid range
                        assert(abs(acc)<=((one<<(XD_T-1))-1));
                    }
                }
                // Truncate the accumulator to produce the output value
                y[t * CO + co] = acc >> Trunc_d;
                // Ensure output value is within valid range
                assert(abs(y[t * CO + co])<=((one<<(X_T-1))-1));
            }
        }
//        printf("in_proj finished\n");

 // Return the projected output vector
        return y;
    }
};

template<ll T, ll D, ll N, ll L, ll P>
class Mamba {
public:
    static const ll C_in = 4 * D + 2 * N + 2 * D / P; // in_proj channels
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
     Vector of RMS normalization layers (first stage).
    vector<Rmsnorm1<T, D>> rms_norm1;
    // Vector of RMS normalization layers (second stage).
    vector<Rmsnorm2<T, D>> rms_norm2;
    // Vector of input projection layers.
    vector<IN_PROJ<T, D, N, P>> in_proj;
    //  Vector of output projection layers.
    vector<OUT_PROJ<T, D>> out_proj;
    //  Quantization object for input to convolution
    Quant<T, C_conv, 8, 32> quant_before_conv = Quant<T, C_conv, 8, 32>("quant_before_conv");
    // Vector of convolution layers.
    vector<Conv<T, D, N>> conv;
    // SiLU activation layer.
    Silu<T, D, N> silu;
    // Vector of delta adaptation layers.
    vector<DtAdapt<T, CH>> dt_adapt;
    // Vector of Selective State Space Model (SSM) layers.
    vector<SSM<T, D, N, P, L>> ssm;
    /**
     * @brief Default constructor for the Mamba class.
     */
    explicit Mamba() {
        // Initialize single instances of each layer for layer 0
        rms_norm1.emplace_back(0);
        rms_norm2.emplace_back(0);
        in_proj.emplace_back(0);
        out_proj.emplace_back(0);
        conv.emplace_back(0);
        dt_adapt.emplace_back(0);
        ssm.emplace_back(0);
    }

    /**
     * @brief Performs forward pass through the Mamba model.
     * @param input Input integer vector of size T * D.
     * @param all_conv_state Convolution state tensor of size L * 3 * C_conv.
     * @param all_conv_state_s Convolution state scaling factor tensor of size L * 3 * C_conv_T.
     * @param all_hidden_state Hidden state tensor of size L * N * C2.
     * @param all_hidden_state_s Hidden state scaling factor tensor of size L * N * C2T.
     * @return Output integer vector of size T * D.
     * @throws Assertion failure if output values exceed the allowed range.
     */
    ivec forward(const ivec &input,
                 ivec &all_conv_state, ivec &all_conv_state_s,
                 ivec &all_hidden_state, ivec &all_hidden_state_s) {

        // Initialize result with input
        ivec result = input;
        ivec result_s;
        TwoIvec two_ivec;
        ThreeIvec three_ivec;
        FourIvec four_ivec;
        // Initialize convolution state
        ivec conv_state(3 * C_conv);
         // Initialize convolution state scaling factors
        ivec conv_state_s(3 * C_conv_T);
        // Initialize hidden state
        ivec hidden_state(N * C2);
        // Initialize hidden state scaling factors
        ivec hidden_state_s(N * C2T);

        // Iterate over each layer
        for (ll i = 0; i < L; ++i) {
            printf("start layer %lld!\n",i);
             // Split residual connection
            ivec res(T * D);
            for (ll t = 0; t < T; ++t) {
                for (ll d = 0; d < D; ++d) {
                    res[t * D + d] = result[t * D + d];
                }
            }

            //check before rms1
//            if(i == L-1) {
//                ivec ref = read_tensor<ll>("./bin/refs/before_rms1_layer" + std::to_string(i) + ".bin");
//                compare_v_with_shape(result, ref, T, D);
//            }


            //rmsnorm1
            rms_norm1.pop_back();
            rms_norm1.emplace_back(i);
            two_ivec = rms_norm1[0].forward(result);
            result = two_ivec.x;
            result_s = two_ivec.y;


            // check rmsnorm1
//            if(i == L-1) {
//                ivec ref = read_tensor<ll>("./bin/refs/rms1_q_layer" + std::to_string(i) + ".bin");
//                compare_v_with_shape(result, ref, T, D);
//                ivec ref = read_tensor<ll>("./bin/refs/rms1_s_layer" + std::to_string(i) + ".bin");
//                compare_v_with_shape(result_s, ref, T, D/CP);
//            }


            // Apply input projection
            in_proj.pop_back();
            in_proj.emplace_back(i);
            result = in_proj[0].forward(result,result_s);


            //check in_proj
//            if(i == L-1) {
//                ivec ref = read_tensor<ll>("./bin/refs/zxbcdt_layer" + std::to_string(i) + ".bin");
//                compare_v_with_shape(result, ref, T, C_in);
//            }

             // Split result into z, xBC, and dt
            ivec z(T * C2);
            ivec xBC(T * C_conv);
            ivec dt(T * CH);
            for (ll t = 0; t < T; ++t) {
                ll cc = 0;
                // Extract z
                for (ll c = 0; c < C2; ++c) {
                    z[t * C2 + c] = result[t * C_in + cc];
                    cc++;
                }
                // Extract xBC
                for (ll c = 0; c < C_conv; ++c) {
                    xBC[t * C_conv + c] = result[t * C_in + cc];
                    cc++;
                }
                // Extract dt
                for (ll c = 0; c < CH; ++c) {
                    dt[t * CH + c] = result[t * C_in + cc];
                    cc++;
                }
            }

//            // check BCx
//            dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_BCx_" + std::to_string(i) + ".bin");
//            compare_double(BCx, ref, T, C_conv, CP, Sy, "layer_" + std::to_string(i),0.1,0.1);

//            // check dt
//            dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_dt_" + std::to_string(i) + ".bin");
//            compare_double(dt, ref, T, CH, CP, Sy, "layer_" + std::to_string(i),0.1,0.1);

//            // check z   -0.327148
//            dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_z_" + std::to_string(i) + ".bin");
//            compare_double(z, ref, T, C2, CP, Sy, "layer_" + std::to_string(i),0.1,0.1);

             // Quantize before convolution
            two_ivec = quant_before_conv.forward(xBC);
            result = two_ivec.x;
            result_s = two_ivec.y;

             // Initialize convolution state
            for (ll t = 0; t < 3; ++t) {
                for (ll c = 0; c < C_conv; ++c) {
                    conv_state[t * C_conv + c] = all_conv_state[i * 3 * C_conv + t * C_conv + c];
                }
                for (ll c = 0; c < C_conv_T; ++c) {
                    conv_state_s[t * C_conv_T + c] = all_conv_state_s[i * 3 * C_conv_T + t * C_conv_T + c];
                }
            }

            // Apply convolution
            conv.pop_back();
            conv.emplace_back(i);
            three_ivec = conv[0].forward(result,result_s,conv_state, conv_state_s);
            xBC = three_ivec.x;
            conv_state = three_ivec.y;
            conv_state_s = three_ivec.z;

            //// Update convolution state
            for (ll t = 0; t < 3; ++t) {
                for (ll c = 0; c < C_conv; ++c) {
                    all_conv_state[i * 3 * C_conv + t * C_conv + c] = conv_state[t * C_conv + c];
                }
                for (ll c = 0; c < C_conv_T; ++c) {
                    all_conv_state_s[i * 3 * C_conv_T + t * C_conv_T + c] = conv_state_s[t * C_conv_T + c];
                }
            }

//            // check xBC conv
//            ivec ref = read_tensor<ll>("./bin/refs/xBC_conv_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(xBC, ref, T, C_conv);

            // Merge xBC and z for SiLU
            ivec xBCz(T * C_silu);
            for (ll t = 0; t < T; ++t) {
                ll cc = 0;
                // Copy xBC
                for (ll c = 0; c < C_conv; ++c) {
                    
                    xBCz[t * C_silu + cc] = xBC[t * C_conv + c];
                    cc++;
                }
                 // Copy z
                for (ll c = 0; c < C2; ++c) {
                    xBCz[t * C_silu + cc] = z[t * C2 + c];
                    cc++;
                }
            }

             // Apply SiLU activation
            two_ivec = silu.forward(xBCz);
            result = two_ivec.x;
            result_s = two_ivec.y;

            // // Split SiLU output into x, B, C, z
            ivec x(T * C2);
            ivec xs(T * C2T);
            ivec B(T * N);
            ivec Bs(T * NT);
            ivec C(T * N);
            ivec Cs(T * NT);
            //ivec z(T * C2);  // z already exist
            ivec zs(T * C2T);
            for (ll t = 0; t < T; ++t) {
                ll ct = 0;
                // Extract x and xs
                for (ll c2t = 0; c2t < C2T; ++c2t) {
                    for (ll cp = 0; cp < CP; ++cp) {
                        x[t * C2 + c2t * CP + cp] = result[t * C_silu + ct * CP + cp];
                    }
                    xs[t * C2T + c2t] = result_s[t * C_silu_T + ct];
                    ct++;
                }
                 // Extract B and Bs
                for (ll nt = 0; nt < NT; ++nt) {
                    for (ll cp = 0; cp < CP; ++cp) {
                        B[t * N + nt * CP + cp] = result[t * C_silu + ct * CP + cp];
                    }
                    Bs[t * NT + nt] = result_s[t * C_silu_T + ct];
                    ct++;
                }
                // Extract C and Cs
                for (ll nt = 0; nt < NT; ++nt) {
                    for (ll cp = 0; cp < CP; ++cp) {
                        C[t * N + nt * CP + cp] = result[t * C_silu + ct * CP + cp];
                    }
                    Cs[t * NT + nt] = result_s[t * C_silu_T + ct];
                    ct++;
                }

                // Extract z and zs
                for (ll c2t = 0; c2t < C2T; ++c2t) {
                    for (ll cp = 0; cp < CP; ++cp) {
                        z[t * C2 + c2t * CP + cp] = result[t * C_silu + ct * CP + cp];
                    }
                    zs[t * C2T + c2t] = result_s[t * C_silu_T + ct];
                    ct++;
                }
            }

            //dt adapt
            ivec dts(T * HT);
            dt_adapt.pop_back();
            dt_adapt.emplace_back(i);
            two_ivec = dt_adapt[0].forward(dt);
            dt = two_ivec.x;
            dts = two_ivec.y;

//            // check dt softplus
//            ivec ref = read_tensor<ll>("./bin/refs/dt_softplus_q_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(dt, ref, T, CH);
//            ivec ref = read_tensor<ll>("./bin/refs/dt_softplus_s_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(dts, ref, T, HT);

//            // check B silu
//            dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_B_silu_" + std::to_string(i) + ".bin");
//            compare_double2(B, Bs, ref, T, N, CP,"layer_" + std::to_string(i),0.1,0.01);

//            // check C silu
//            if(i == L-1) {
////                ivec ref = read_tensor<ll>("./bin/refs/C_silu_q_layer" + std::to_string(i) + ".bin");
////                compare_v_with_shape(C, ref, T, N);
////                ivec ref = read_tensor<ll>("./bin/refs/C_silu_s_layer" + std::to_string(i) + ".bin");
////                compare_v_with_shape(Cs, ref, T, NT);
//            }

//            // check x silu
//            dvec ref = read_tensor<double>("./refs/"+mamba_model_name+"_x_silu_" + std::to_string(i) + ".bin");
//            compare_double2(x, xs, ref, T, C2, CP,"layer_" + std::to_string(i),0.1,0.05);
//            if(i == L-1) {
////                ivec ref = read_tensor<ll>("./bin/refs/u_q_layer" + std::to_string(i) + ".bin");
////                compare_v_with_shape(x, ref, T, C2);
////                ivec ref = read_tensor<ll>("./bin/refs/u_s_layer" + std::to_string(i) + ".bin");
////                compare_v_with_shape(xs, ref, T, C2T);
//            }

//            // check z silu
//            ivec ref = read_tensor<ll>("./bin/refs/z_silu_q_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(z, ref, T, C2);
//            ivec ref = read_tensor<ll>("./bin/refs/z_silu_s_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(zs, ref, T, C2T);


            // Initialize hidden state
            for (ll n = 0; n < N; ++n) {
                for (ll c = 0; c < C2; ++c) {
                    hidden_state[n * C2 + c] = all_hidden_state[i * N * C2 + n * C2 + c];
                }
                for (ll c = 0; c < C2T; ++c) {
                    hidden_state_s[n * C2T + c] = all_hidden_state_s[i * N * C2T + n * C2T + c];
                }
            }

            //// Apply SSM
            ssm.pop_back();
            ssm.emplace_back(i);
            three_ivec = ssm[0].forward(dt,dts,B,Bs,C,Cs,x,xs,z,zs,hidden_state,hidden_state_s);
            result = three_ivec.x; // SSM output
            hidden_state = three_ivec.y;  // Updated hidden state
            hidden_state_s = three_ivec.z; // Updated hidden state scaling factors

            // Update hidden states
            for (ll n = 0; n < N; ++n) {
                for (ll c = 0; c < C2; ++c) {
                    all_hidden_state[i * N * C2 + n * C2 + c] = hidden_state[n * C2 + c];
                }
                for (ll c = 0; c < C2T; ++c) {
                    all_hidden_state_s[i * N * C2T + n * C2T + c] = hidden_state_s[n * C2T + c];
                }
            }

//            // check yz
//            if(i == L-1) {
//                ivec ref = read_tensor<ll>("./bin/refs/yz_layer" + std::to_string(i) + ".bin");
//                compare_v_with_shape(result, ref, T, C2);
//            }

            // Apply RMSNorm2
            rms_norm2.pop_back();
            rms_norm2.emplace_back(i);
            two_ivec = rms_norm2[0].forward(result);
            result = two_ivec.x;
            result_s = two_ivec.y;

//            // check rms2
//            ivec ref = read_tensor<ll>("./bin/refs/rms2_q_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(result, ref, T, C2);
//            ivec ref = read_tensor<ll>("./bin/refs/rms2_s_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(result_s, ref, T, C2T);

             // Apply output projection
            out_proj.pop_back();
            out_proj.emplace_back(i);
            result = out_proj[0].forward(result,result_s);


            // Debugging check for output projection (commented out)    
//            // check out_proj
//            ivec ref = read_tensor<ll>("./bin/refs/out_proj_layer" + std::to_string(i) + ".bin");
//            compare_v_with_shape(result, ref, T, D);

            // Apply residual connection
            for (ll t = 0; t < T; ++t) {
                for (ll d = 0; d < D; ++d) {
                    // Add residual to output
                    result[t * D + d] += res[t * D + d];
                    // Ensure output value is within valid range
                    assert(abs(result[t * D + d])<=((one<<(X_T-1))-1));
                }
            }

            // Compare final output for the last layer
            if(i == L-1) {
                string filename = "./bin/refs/output_layer" + std::to_string(i) + ".bin";
                ivec output = read_tensor<ll>(filename);
                compare_v_with_shape(result, output, T, D);
            }

        }
        // Return the final output
        return result;
    }

};

#endif //DEIT_S_LAYERS_H

/**
 * @file util.h
 * @brief Utility functions and structures for tensor operations and comparisons.
 *
 * This header file provides type definitions, structures, and functions for
 * handling tensor operations, file I/O, and comparison utilities used in the project.
 * It includes support for reading, writing, and comparing vectors of various types.
 *
 * @author hiro
 * @date 2023/09/21
 */

#ifndef DEIT_S_UTIL_H
#define DEIT_S_UTIL_H


#include <fstream>
#include <vector>
#include <iostream>
#include <cassert>
#include <cmath>
#include <cfenv>
#include <cstdint>


using namespace std;



typedef long long ll;
typedef vector<int64_t> ivec;
typedef vector<double> dvec;
typedef vector<float> fvec;

ll one=1;
int X_T =32;
int XD_T=34;
int HTC_T =38;
int DBU_T=37;
int LNW1_T =11;
int LNW2_T =13;
/**
 * @struct ThreeIvecfii
 * @brief Structure holding three vectors: one float vector and two 64-bit integer vectors.
 */
typedef struct {
    fvec x;
    ivec y;
    ivec z;
} ThreeIvecfii;

/**
 * @struct TwoIvec
 * @brief Structure holding two 64-bit integer vectors.
 */
typedef struct {
    ivec x;
    ivec y;
} TwoIvec;
/**
 * @struct ThreeIvec
 * @brief Structure holding three 64-bit integer vectors.
 */
typedef struct {
    ivec x;
    ivec y;
    ivec z;
} ThreeIvec;
/**
 * @struct FourIvec
 * @brief Structure holding four 64-bit integer vectors.
 */
typedef struct {
    ivec x;
    ivec y;
    ivec z;
    ivec w;
} FourIvec;
/**
 * @struct FiveIvec
 * @brief Structure holding five 64-bit integer vectors.
 */
typedef struct {
    ivec x;
    ivec y;
    ivec z;
    ivec w;
    ivec v;
} FiveIvec;


/**
 * @brief Converts a double vector to a float vector.
 * @param x Input vector of doubles.
 * @return A float vector containing the converted values.
 */
fvec transfer(const dvec &x) {
// Get the size of the input vector
    ll size = (ll)x.size();
    // Initialize output float vector with the same size
    fvec y(size);
    // Iterate through the input vector
    for (ll i = 0; i < size; ++i) {
        // Cast each double value to float and store in the output vector
        y[i] = (float)x[i];
    }
    return y;
}
/**
 * @brief Prints the elements of a tensor to standard output.
 * @tparam T Type of the tensor elements.
 * @param tensor Input tensor to be printed.
 */
template<typename T>
void print_tensor(const vector<T> &tensor) {
    // Get the size of the tensor
    ll size = tensor.size();
    // Iterate through each element in the tensor
    for(ll i = 0; i < size; ++i) {
        // Print the element followed by a newline
        cout<<tensor[i]<<endl;
    }
}

/**
 * @brief Reads a tensor from a binary file.
 * @tparam T Type of the tensor elements.
 * @param filePath Path to the binary file.
 * @return A vector containing the tensor data.
 * @throws Exits with code 1 if the file cannot be opened or read.
 */
template<typename T>
vector<T> read_tensor(const std::string &filePath) {
    // Open the file in binary mode and move to the end to get size
    std::ifstream file(filePath, std::ios::binary | std::ios::ate);
    // Check if the file was successfully opened
    if (!file.is_open()) {
        // Print error message and exit if file cannot be opened
        std::cerr << "Cannot open file: " << filePath << std::endl;
        exit(1);
    }
    // Get the size of the file in bytes
    std::streamsize size = file.tellg();
    // Move back to the beginning of the file
    file.seekg(0, std::ios::beg);
    // Allocate a vector with enough space for the tensor (size / sizeof(T))
    vector<T> tensor(size / sizeof(T));
     // Read the file content into the vector's data buffer
    if (!file.read(reinterpret_cast<char *>(tensor.data()), size)) {
        // Print error message and exit if reading fails
        std::cerr << "Cannot read file: " << filePath << std::endl;
        exit(1);
    }
    // Return the tensor vector
    return tensor;
}

/**
 * @brief Writes a tensor to a binary file.
 * @tparam T Type of the tensor elements.
 * @param tensor Input tensor to be written.
 * @param filePath Path to the output binary file.
 * @throws Exits with code 1 if the file cannot be opened.
 */
template<typename T>
void write_tensor(const vector<T> &tensor, const string &filePath) {
    // Open the file in binary mode for writing
    std::ofstream file(filePath, std::ios::binary);
    // Check if the file was successfully opened
    if (!file.is_open()) {
         // Print error message and exit if file cannot be opened
        std::cerr << "Cannot open file: " << filePath << std::endl;
        exit(1);
    }
     // Calculate the total size of the tensor in bytes
    std::streamsize size = tensor.size() * sizeof(T);
    // Write the tensor data to the file
    file.write(reinterpret_cast<const char *>(tensor.data()), size);
    // Close the file
    file.close();
}

/**
 * @brief Compares two integer vectors with a tolerance.
 * @param x First input vector.
 * @param ref Reference vector for comparison.
 * @param info Optional string for error message context.
 * @param tol Tolerance for comparison (default: 0).
 * @throws Assertion failure if comparison fails.
 */
void compare_v(const ivec &x, const ivec &ref, const string &info = "", ll tol = 0) {
//    assert(x.size() == ref.size());
//    if (x.size() != ref.size()) {
//        cout << "compare_v failed: " << info << endl;
//        cout << "x.size() = " << x.size() << ", ref.size() = " << ref.size() << endl;
//        assert(false);
//    }
// Iterate through each element of the vectors
    for (ll i = 0; i < x.size(); ++i) {
        // Check if the absolute difference exceeds the tolerance
        if (abs(x[i] - ref[i]) > tol) {
            // Print the differing values and their indices
            cout << "a[" << i << "] = " << x[i] << ", b[" << i << "] = " << ref[i] << endl;
            // Print failure message with optional context
            cout << "compare_v failed: " << info << endl;
            // Trigger assertion failure to halt execution
            assert(false);
        }
    }
}

/**
 * @brief Compares two integer vectors with specified shape.
 * @param x First input vector.
 * @param ref Reference vector for comparison.
 * @param T Number of tokens (first dimension).
 * @param C Number of channels (second dimension).
 * @param info Optional string for error message context.
 * @param tol Tolerance for comparison (default: 0).
 */
void compare_v_with_shape(const ivec &x, const ivec &ref, ll T, ll C, const string &info = "", ll tol = 0) {
//    assert(x.size() == T * C);
//    assert(ref.size() == T * C);
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {
            // Calculate the flattened index for the 2D tensor
            ll index = t * C + c;
            // Check if the absolute difference exceeds the tolerance
            if (abs(x[index] - ref[index]) > tol) {
                // Print the coordinates and differing values
                cout << "At [" << t << ", " << c << "]: ";
                cout << "a = " << x[index] << ", b = " << ref[index] << endl;
                // Print failure message with optional context
                cout << "compare_v failed: " << info << endl;
//                    assert(false);
            }
        }
    }
}

/**
 * @brief Compares two integer vectors with forced shape and scaling.
 * @param x First input vector.
 * @param ref Reference vector for comparison.
 * @param T Number of tokens (first dimension).
 * @param C Number of channels (second dimension).
 * @param Sy Scaling factor exponent.
 * @param info Optional string for error message context.
 * @param dp Relative difference threshold (default: 0.1).
 * @param mp Minimum relative magnitude threshold (default: 0.1).
 */
void compare_v_with_force_shape(const ivec &x, const ivec &ref, ll T, ll C, ll Sy, const string &info = "", double dp = 0.1, double mp = 0.1) {
    double ref_max=0; // Initialize maximum reference value
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {
            // Find the maximum absolute value in the scaled reference tensor
            ref_max = max(ref_max, abs(ref[t * C + c] * pow(2.0, Sy)));
        }
    }
    // Print the maximum reference value
    cout << "ref_max is " << ref_max << endl;
    ll num = 0; // Initialize error counter
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {

            // Calculate the flattened index
            ll index = t * C + c;
            // Scale the input and reference values
            double real = x[index] * pow(2.0, Sy);
            double ref_real = ref[index] * pow(2.0, Sy);
            // Calculate relative difference
            double diff = abs(real - ref_real)/abs(ref_real);
            // Check if the difference exceeds the threshold and values are significant
            if (diff > dp && (abs(ref_real)/ref_max > mp || abs(real)/ref_max > mp)) {
                num++;   // Increment error counter
                cout << "At [" << t << ", " << c << "]: "; // Print the coordinates and differing values
                cout << "a = " << real << ", b = " << ref_real << endl;
                // Print failure message with optional context
                cout << "compare_v failed: " << info << endl;
//                    assert(false);
            }
        }
    }
    // Print the maximum reference value again
    cout << "ref_max is " << ref_max << endl;
    // Print the percentage of errors
    cout << "error num is " << num*100/(T * C) << "%" << endl;
}

/**
 * @brief Compares a float vector with an integer vector with forced shape and scaling.
 * @param x First input float vector.
 * @param ref Reference integer vector for comparison.
 * @param T Number of tokens (first dimension).
 * @param C Number of channels (second dimension).
 * @param Sy Scaling factor exponent.
 * @param info Optional string for error message context.
 * @param dp Relative difference threshold (default: 0.1).
 * @param mp Minimum relative magnitude threshold (default: 0.1).
 */
void compare_v_with_force_shape(const fvec &x, const ivec &ref, ll T, ll C, ll Sy, const string &info = "", double dp = 0.1, double mp = 0.1) {
    double ref_max=0; // Initialize maximum reference value
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {

            // Find the maximum absolute value in the scaled reference tensor
            ref_max = max(ref_max, abs(ref[t * C + c] * pow(2.0, Sy)));
        }
    }

    // Print the maximum reference value
    cout << "ref_max is " << ref_max << endl;
    ll num = 0; // Initialize error counter
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {
           // Calculate the flattened index
            ll index = t * C + c;
            // Use the float input value directly
            double real = x[index]; 
            // Scale the reference value
            double ref_real = ref[index] * pow(2.0, Sy);
             // Calculate relative difference
            double diff = abs(real - ref_real)/abs(ref_real);
            // Check if the difference exceeds the threshold and values are significant
            if (diff > dp && (abs(ref_real)/ref_max > mp || abs(real)/ref_max > mp)) {
                num++;  // Increment error counter
                // Print the coordinates and differing values
                cout << "At [" << t << ", " << c << "]: ";
                cout << "a = " << real << ", b = " << ref_real << endl;
                // Print failure message with optional context
                cout << "compare_v failed: " << info << endl;
//                    assert(false);
            }
        }
    }
    // Print the maximum reference value again
    cout << "ref_max is " << ref_max << endl;
    // Print the percentage of errors
    cout << "error num is " << num * 100 / (T * C) << "%" << endl;
}

/**
 * @brief Compares an integer vector with a double vector with specified shape and scaling.
 * @param x Input integer vector.
 * @param ref Reference double vector.
 * @param T Number of tokens (first dimension).
 * @param C Number of channels (second dimension).
 * @param CP Channels per group.
 * @param Sy Scaling factor exponent.
 * @param info Optional string for error message context.
 * @param dp Relative difference threshold (default: 0.1).
 * @param mp Minimum relative magnitude threshold (default: 0.1).
 */
void compare_double(const ivec &x, const dvec &ref, ll T, ll C, ll CP, ll Sy, const string &info = "", double dp = 0.1, double mp = 0.1) {
    // Calculate channels per group
    ll CT = C / CP;
    double ref_max=0; // Initialize maximum reference value
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {
            // Find the maximum absolute value in the reference tensor
            ref_max = max(ref_max, abs(ref[t * C + c]));
        }
    }
    cout << "ref_max is " << ref_max << endl;
    ll num = 0;
    for (ll t = 0; t < T; ++t) {
        for (ll ct = 0; ct < CT; ++ct) {
            // Define the scaling factor
            double scale = pow(2.0, Sy);
            for (ll cp = 0; cp < CP; ++cp) {
                // Calculate the flattened index
                ll index = t * C + ct * CP + cp;
                double real = x[index] * scale;  // Scale the input integer value
                double diff = abs(real - ref[index])/abs(ref[index]);  // Calculate relative difference

                // Check if the difference exceeds the threshold and values are significant
                if (diff > dp && (abs(ref[index])/ref_max > mp || abs(real)/ref_max > mp)) {
                    num++;  // Increment error counter
                     // Print the coordinates and differing values
                    cout << "At [" << t << ", " << ct * CP + cp << "]: ";
                    cout << "a = " << real << ", b = " << ref[index] << endl;
                    // Print failure message with optional context
                    cout << "compare_v failed: " << info << endl;
                }
            }

        }
    }
    // Print the maximum reference value again
    cout << "ref_max is " << ref_max << endl;
    // Print the percentage of errors
    cout << "error num is " << num * 100 / (T * C) << "%" << endl;
}


/**
 * @brief Compares two double vectors with specified shape.
 * @param x Input double vector.
 * @param ref Reference double vector.
 * @param T Number of tokens (first dimension).
 * @param C Number of channels (second dimension).
 * @param CP Channels per group.
 * @param info Optional string for error message context.
 * @param dp Relative difference threshold (default: 0.1).
 * @param mp Minimum relative magnitude threshold (default: 0.1).
 */
void compare_double(const dvec &x, const dvec &ref, ll T, ll C, ll CP, const string &info = "", double dp = 0.1, double mp = 0.1) {
     // Calculate channels per group
    ll CT = C / CP;
    // Initialize maximum reference value
    double ref_max=0;
    // Find the maximum absolute value in the reference tensor
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {
            ref_max = max(ref_max, abs(ref[t * C + c]));
        }
    }
    // Print the maximum reference value
    cout << "ref_max is " << ref_max << endl;

    // Initialize error counter
    ll num = 0;
    // Iterate over the token dimension
    for (ll t = 0; t < T; ++t) {
        for (ll ct = 0; ct < CT; ++ct) {
            for (ll cp = 0; cp < CP; ++cp) {

                // Calculate the flattened index
                ll index = t * C + ct * CP + cp;
                // Use the input double value directly
                double real = x[index];
                 // Calculate relative difference
                double diff = abs(real - ref[index])/abs(ref[index]);
                // Check if the difference exceeds the threshold and values are significant
                if (diff > dp && (abs(ref[index])/ref_max > mp || abs(real)/ref_max > mp)) {
                    num++;  // Increment error counter
                    // Print the coordinates and differing values
                    cout << "At [" << t << ", " << ct * CP + cp << "]: ";
                    cout << "a = " << real << ", b = " << ref[index] << endl;
                    // Print failure message with optional context
                    cout << "compare_v failed: " << info << endl;
                }
            }

        }
    }
     // Print the maximum reference value again
    cout << "ref_max is " << ref_max << endl;
    // Print the percentage of errors
    cout << "error num is " << num*100/(T * C) << "%" << endl;
}

/**
 * @brief Compares two integer vectors with a double reference vector and dynamic scaling.
 * @param x Input integer vector.
 * @param xs Scaling vector for x.
 * @param ref Reference double vector.
 * @param T Number of tokens (first dimension).
 * @param C Number of channels (second dimension).
 * @param CP Channels per group.
 * @param info Optional string for error message context.
 * @param dp Relative difference threshold (default: 0.1).
 * @param mp Minimum relative magnitude threshold (default: 0.1).
 */
void compare_double2(const ivec &x, const ivec &xs, const dvec &ref, ll T, ll C, ll CP, const string &info = "", double dp = 0.1, double mp = 0.1) {
    // Calculate channels per group
    ll CT = C / CP;

    // Initialize maximum reference value
    double ref_max=0;

    // Find the maximum absolute value in the reference tensor
    for (ll t = 0; t < T; ++t) {
        for (ll c = 0; c < C; ++c) {
            ref_max = max(ref_max, abs(ref[t * C + c]));
        }
    }

    // Print the maximum reference value
    cout << "ref_max is " << ref_max << endl;

    // Initialize error counter
    ll num = 0;
    // Iterate over the token dimension
    for (ll t = 0; t < T; ++t) {
         // Iterate over the group dimension
        for (ll ct = 0; ct < CT; ++ct) {

            // Get the scaling factor for the current group
            double scale = pow(2.0, xs[t * CT + ct]);
            // Iterate over channels within the group
            for (ll cp = 0; cp < CP; ++cp) {

                // Calculate the flattened index
                ll index = t * C + ct * CP + cp;

                // Scale the input integer value
                double real = x[index] * scale;

                 // Calculate relative difference
                double diff = abs(real - ref[index])/abs(ref[index]);

                // Check if the difference exceeds the threshold and values are significant
                if (diff > dp && (abs(ref[index])/ref_max > mp || abs(real)/ref_max > mp)) {
                     // Increment error counter
                    num++;
                    // Print the coordinates and differing values
                    cout << "At [" << t << ", " << ct * CP + cp << "]: ";
                    cout << "a = " << real << ", b = " << ref[index] << endl;
                    // Print failure message with optional context
                    cout << "compare_v failed: " << info << endl;
                }
            }

        }
    }

    // Print the maximum reference value again
    cout << "ref_max is " << ref_max << endl;

    // Print the percentage of errors
    cout << "error num is " << num*100/(T * C) << "%" << endl;
}

/**
 * @brief Clamps a value between a minimum and maximum.
 * @tparam _typename Type of the value.
 * @param val Value to clamp.
 * @param min Minimum allowed value.
 * @param max Maximum allowed value.
 * @return Clamped value.
 */
template<typename _typename>
_typename clamp(_typename val, _typename min, _typename max) {

    // Return minimum if value is less than minimum
    if (val < min) return min;

    // Return maximum if value is greater than maximum
    if (val > max) return max;

    // Return original value if within bounds
    return val;
}

/**
 * @brief Quantizes and clamps a value to a specified bit width.
 * @tparam _typename Type of the value.
 * @param val Value to quantize.
 * @param bits Number of bits for quantization.
 * @param is_signed Whether the value is signed.
 * @return Quantized and clamped value.
 */
template<typename _typename>
_typename quantize_clamp(_typename val, ll bits, bool is_signed) {
    ll min_val, max_val;

    // Set bounds based on whether the value is signed or unsigned
    if (is_signed) {
        // Signed: [-2^(bits-1), 2^(bits-1)-1]
        min_val = -(1ll << (bits - 1));
        max_val = (1ll << (bits - 1)) - 1;
    } else {
         // Unsigned: [0, 2^bits-1]
        min_val = 0ll;
        max_val = (1ll << bits) - 1;
    }

    // Clamp the value to the quantization bounds
    return clamp(val, min_val, max_val);
}


/**
 * @brief Computes the index of the maximum value in an integer vector.
 * @param x Input integer vector.
 * @param C Number of channels
 * @return A vector containing the index of the maximum value.
 * @throws Assertion failure if x.size() != C.
 */
ivec argmax(const ivec &x, ll C) {
    // T: tokens, C: channels
    // Ensure the input vector size matches the specified number of channels
    assert(x.size() == C);
    // batched output, not initialized
    ivec y(1);
    // argmax
    // Initialize maximum value and its index with the first element
    ll max_val = x[C];
    ll max_index = 0;
    // Iterate through the vector starting from the second element
    for (ll c = 1; c < C; ++c) {
        if (x[c] > max_val) {
            // Update maximum value and index if current value is larger
            max_val = x[c];

            // Store the current maximum index in the output vector
            max_index = c;
        }

        // Return the vector containing the index of the maximum value
        y[0] = max_index;
    }
    return y;
}


#endif //DEIT_S_UTIL_H

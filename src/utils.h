#ifndef __INT_UTILS_H__
#define __INT_UTILS_H__


// ********************************************************
// ****************  DESIGN UTILS  ************************

// Clamps a value between a specified minimum and maximum range.
// @param val The value to be clamped.
// @param min_val The minimum allowable value.
// @param max_val The maximum allowable value.
// @return The clamped value, which is min_val if val is less than min_val,
//         max_val if val is greater than max_val, or val otherwise.
template<typename _typename, typename _val_t>
_typename clamp(_typename val, _val_t min_val, _val_t max_val) {
    if (val < min_val) return min_val;
    if (val > max_val) return max_val;
    return val;
}


// Quantizes and clamps a value to fit within a specified bit width, with optional signed or unsigned range.
// @param val The input value to be quantized and clamped.
// @param bits The number of bits to represent the quantized value.
// @param is_signed Boolean indicating if the value is signed (true) or unsigned (false).
// @return The clamped value within the range defined by the bit width and signed/unsigned property.

template<typename _typename>
_typename quantize_clamp(_typename val, int bits, bool is_signed) {
    int min_val, max_val;
    if (is_signed) {
        min_val = -(1 << (bits - 1));
        max_val = +(1 << (bits - 1)) - 1;
    } else {
        min_val = 0;
        max_val = (1 << bits) - 1;
    }
    return clamp(val, min_val, max_val);
}

/**
 * @brief This function reads data from an input stream and writes it into a 2D buffer for GEMM (General Matrix Multiply) processing.
 *
 * This template function is used to read data from the input stream in blocks and write it into a buffer, reshaping it
 * for efficient processing in matrix operations such as GEMM. It is optimized for hardware synthesis using HLS directives.
 * 
 * @tparam data_t Data type for the stream and buffer elements.
 * @tparam T Total number of rows in the buffer.
 * @tparam GEMM_TP Number of rows processed in each GEMM block.
 * @tparam C Total number of columns in the buffer.
 * @tparam CP Number of columns processed in each block.
 *
 * @param data_stream The input data stream from which data is read.
 * @param buffer The 2D buffer where data is written, with size [T*C].
 *  */
template<
    class data_t,
    int T,
    int GEMM_TP,
    int C,
    int CP>
void pack_gemm_tokens(
    hls::stream<hls::vector<data_t, CP> >& data_stream,
    data_t buffer[T*C]
){
     /**
     * @brief Reshape the buffer array for efficient memory access.
     *
     * This pragma optimizes the access pattern of the buffer by reshaping it along the row dimension, 
     * allowing for more efficient cyclic access in hardware.
     */
    #pragma HLS array_reshape variable=buffer cyclic factor=CP dim=1

    // some constexprs
    // Constants for number of GEMM blocks in rows (GEMM_TT) and columns (CT)
    constexpr int GEMM_TT = T / GEMM_TP;
    constexpr int CT      = C / CP;
     // Loop over all blocks (GEMM_TT: row blocks, CT: column blocks)
    for(int gemm_tt=0; gemm_tt<GEMM_TT; ++gemm_tt){
        for(int ct=0; ct<CT; ++ct){
            for(int gemm_tp=0; gemm_tp<GEMM_TP; ++gemm_tp){
                /**
                 * @brief Pipeline the inner loop for concurrency.
                 *
                 * This pragma enables pipelining of the inner loop, allowing each iteration to start without waiting for the previous one to complete.
                 * II=1 means the loop will process one element per cycle, improving throughput.
                 */
                #pragma HLS pipeline II=1
                // read data
                hls::vector<data_t, CP> data_vec = data_stream.read();
                // write to buffer
                for(int cp=0; cp<CP; ++cp){
                      /**
                     * @brief Unroll the loop for parallel execution.
                     *
                     * This pragma unrolls the loop, allowing multiple iterations to execute in parallel, speeding up the writing process.
                     */
                    #pragma HLS unroll
                     // Write data to the corresponding position in the buffer
                    buffer[(gemm_tt*GEMM_TP + gemm_tp)*C + ct*CP + cp] = data_vec[cp];
                }
            } // end of gemm_tp loop
        } // end of CT loop
    } // end of gemm_tt loop
}

/**
 * @brief This function reads data from a buffer, retiles it into blocks, and writes it to an output stream.
 *
 * This template function reads a 2D buffer and reshapes the data into smaller blocks of size TP (rows) x CP (columns),
 * which are then written to a streaming output. The function is optimized using HLS directives for hardware synthesis.
 * 
 * @tparam data_t Data type for the buffer elements.
 * @tparam T Total number of rows in the buffer.
 * @tparam TP Number of rows in each block.
 * @tparam C Total number of columns in the buffer.
 * @tparam CP Number of columns in each block.
 *
 * @param buffer The 2D buffer from which data is read, with size [T*C].
 * @param data_stream The output data stream where blocks of data are written.
 */
template<
    class data_t,  
    int T,         
    int TP,
    int C,
    int CP>
void retile_tokens(
    data_t buffer[T*C],   ///< The 2D buffer with size T*C
    hls::stream<hls::vector<data_t, TP*CP> >& data_stream ///< Vector to hold each block of data during processing
){
    #pragma HLS array_reshape variable=buffer cyclic factor=CP dim=1
    hls::vector<data_t, TP*CP> data_vec;

    // some constexprs
    constexpr int TT = T / TP;
    constexpr int CT = C / CP;

    for(int tt=0; tt<TT; ++tt){
        for(int ct=0; ct<CT; ++ct){
            for(int tp=0; tp<TP; ++tp){
                /**
                 * @brief Pipeline the inner loop for concurrency.
                 *
                 * This pragma indicates that the inner loop should be pipelined, allowing each iteration to start
                 * without waiting for the previous one to complete. II=1 ensures that one iteration is processed per cycle.
                 */
                #pragma HLS pipeline II=1
                // read from buffer
                for(int cp=0; cp<CP; ++cp){
                    #pragma HLS unroll
                    data_vec[tp*CP + cp] = buffer[(tt*TP + tp)*C + ct*CP + cp];
                }
                // write to stream
                if(tp == TP-1){
                    data_stream.write(data_vec);
                }
            } // end of TP loop
        } // end of CT loop
    } // end of TT loop
}

// Transposes a tensor stored in a buffer and writes it to a stream with a reshaped layout.
// The function changes the data layout from (T, C) to a stream of vectors with dimensions CP*TP.
// @param buffer The input buffer containing tensor data with dimensions T*C.
// @param data_stream The output stream to store vectors of type data_t with CP*TP elements.
// @tparam data_t The data type of the buffer and stream elements.
// @tparam T The time or sequence dimension of the input tensor.
// @tparam TP The number of time steps per stream vector.
// @tparam C The channel dimension of the input tensor.
// @tparam CP The number of channels per stream vector.
template<
    class data_t,
    int T,
    int TP,
    int C,
    int CP>
void transpose_tokens(
    data_t buffer[T*C],
    hls::stream<hls::vector<data_t, CP*TP> >& data_stream
){
    #pragma HLS array_reshape variable=buffer cyclic factor=TP dim=1  
    // Declare a vector to hold CP*TP elements for streaming
    hls::vector<data_t, CP*TP> data_vec;

    // some constexprs
    constexpr int TT = T / TP;
    constexpr int CT = C / CP;

    // transpose, loop nest order: TT -> CT -> TP -> CP => CT -> TT -> CP -> TP
    // Transpose the data layout: from (TT, TP, CT, CP) to (CT, TT, CP, TP)
    for(int ct=0; ct<CT; ++ct){
        for(int tt=0; tt<TT; ++tt){
            #pragma HLS pipeline II=1
            // read from buffer
            for(int cp=0; cp<CP; ++cp){
                for(int tp=0; tp<TP; ++tp){
                    #pragma HLS unroll
                    data_vec[cp*TP + tp] = buffer[(tt*TP + tp)*C + ct*CP + cp];
                }
            }
            // write to stream
            data_stream.write(data_vec);
        }
    }
}

// Splits an interleaved input stream of tensor data into two separate output streams.
// The function processes data with dimensions H*T*C, splitting it across two streams in an interleaved manner.
// @param i_stream The input stream containing vectors of type data_t with TP*CP elements.
// @param o_stream1 The first output stream to receive half of the interleaved data.
// @param o_stream2 The second output stream to receive the other half of the interleaved data.
// @tparam data_t The data type of the stream elements.
// @tparam H The height dimension of the data tensor (number of heads).
// @tparam T The time or sequence dimension of the data tensor.
// @tparam TP The number of time steps per stream vector.
// @tparam C The channel dimension of the data tensor.
// @tparam CP The number of channels per stream vector.
template<
    class data_t,
    int H,
    int T,
    int TP,
    int C,
    int CP>
void split_interleaved_heads(
    hls::stream<hls::vector<data_t, TP*CP> >& i_stream,
    hls::stream<hls::vector<data_t, TP*CP> >& o_stream1,
    hls::stream<hls::vector<data_t, TP*CP> >& o_stream2
){
    // some constexprs
    constexpr int TT = T / TP;
    constexpr int CT = C / CP;
// Iterate over the height dimension (heads)
    for(int h=0; h<H; ++h){
        for(int stream_id=0; stream_id<2; ++stream_id){
            for(int tt=0; tt<TT; ++tt){
                for(int ct=0; ct<CT; ++ct){
                    #pragma HLS pipeline II=1
                    // read from input stream
                    hls::vector<data_t, TP*CP> i_vec = i_stream.read();
                    // write to output stream
                    // Write the vector to the appropriate output stream based on stream_id
                    if(stream_id == 0){
                        o_stream1.write(i_vec);
                    } else {
                        o_stream2.write(i_vec);
                    }
                } // end of CT loop
            } // end of TT loop
        } // end of stream_id loop
    }

}



// ********************************************************
// ****************  SIMULATION UTILS  ********************

// Reads a tensor from a binary file into a vector.
// @param file_path The path to the file containing the tensor data.
// @tparam _typename The data type of the tensor elements.
// @return A vector containing the tensor data read from the file.
template<typename _typename>
vector<_typename> read_tensor(const std::string &file_path) {
    // Open the file in binary mode and position the cursor at the end to get size
    std::ifstream file(file_path, std::ios::binary | std::ios::ate);
     // Check if the file was opened successfully
    if (!file.is_open()) {
        std::cerr << "Cannot open file: " << file_path << std::endl;
        exit(1);
    }
// Get the size of the file
    std::streamsize size = file.tellg();
     // Move cursor back to the beginning of the file
    file.seekg(0, std::ios::beg);
// Initialize a vector with the appropriate size for the tensor
    vector<_typename> tensor(size / sizeof(_typename));
    // Read the file content into the vector
    if (!file.read(reinterpret_cast<char *>(tensor.data()), size)) {
        std::cerr << "Cannot read file: " << file_path << std::endl;
        exit(1);
    }
// Return the populated tensor vector
    return tensor;
}



// Saves a tensor stored in a vector to a binary file.
// @param file_path The path to the file where the tensor will be saved.
// @param tensor The input vector containing the tensor data.
// @tparam _typename The data type of the tensor elements.
template<typename _typename>
void save_tensor(const std::string &file_path, const vector<_typename> &tensor) {
    std::ofstream file(file_path, std::ios::binary);
    // Check if the file was opened successfully
    if (!file.is_open()) {
        std::cerr << "Cannot open file: " << file_path << std::endl;
        exit(1);
    }
    // Write the tensor data from the vector to the file
    file.write(reinterpret_cast<const char *>(tensor.data()), tensor.size() * sizeof(_typename));
}


// Saves a tensor to a binary file.
// @param file_path The path to the file where the tensor will be saved.
// @param tensor Pointer to the tensor data to be saved.
// @param size The number of elements in the tensor.
// @tparam _typename The data type of the tensor elements.

template<typename _typename>
void save_tensor(const std::string &file_path, const _typename *tensor, size_t size) {
     // Open the file in binary mode
    std::ofstream file(file_path, std::ios::binary);
    // Check if the file was opened successfully
    if (!file.is_open()) {
        std::cerr << "Cannot open file: " << file_path << std::endl;
        exit(1);
    }
    // Write the tensor data to the file
    file.write(reinterpret_cast<const char *>(tensor), size * sizeof(_typename));
}









// A class to display a progress bar with timing information for tracking task completion.
// The progress bar shows a visual representation of progress, percentage, and estimated time.
class ProgressBar {
private:
    std::string info;   // Descriptive string for the progress bar
    int total;          // Total number of steps for the task
    int current;        // Current number of completed steps

    int time_start;    // Start time of the task (in clock ticks)
    int time_end;      // End time of the last update (in clock ticks)

public:
    // Constructor to initialize the progress bar.
    // @param _info The descriptive string to display with the progress bar.
    // @param _total The total number of steps in the task.
    ProgressBar(const std::string& _info, int _total)
        : info(_info), total(_total), current(0), time_start(0), time_end(-1) {}
    // Updates the progress bar by incrementing the current step count and refreshing the display.
    // @param step The number of steps to increment the progress by.
    void update(int step) {
        current += step;
        // Calculate the percentage of completion
        int percentage = static_cast<int>((current * 100.0) / total);
        // Calculate the number of '=' characters for the visual bar (scaled to 50 characters)
        int progress = static_cast<int>((50 * current) / total);
         // Create the progress bar string with '=' for completed and ' ' for remaining
        std::string bar(progress, '=');
        bar.append(50 - progress, ' ');
        // get current time
        time_end = clock();
        // estimate the remaining time
        int elapsed = time_end - time_start;
        int remaining = elapsed * (total - current) / current;
        int total_time = elapsed + remaining;
        // Print the progress bar with info, visual bar, percentage, and time estimates
        std::cerr << "\r[" << std::string(info).append(20 - info.length(), ' ')
                  << "][" << bar << "] " << percentage << "%  " << "Estimated total time: " << total_time / 1000 << "s, " << "Estimated remaining time: " << remaining / 1000 << "s";
        // Move to a new line when the task is complete
        if (current >= total) {
            std::cerr << std::endl;  // Move to next line when done
        }
    }
  // Resets the progress bar and starts timing.
    void start() {
        current = 0;
        time_start = clock();
    }
// Completes the progress bar by updating it to the total steps.
    void finish() {
        update(total - current);  // Complete the progress bar
    }
};


// Converts data from a tensor (stored in a vector) to a flat array with specified dimensions.
// @param tensor The input vector containing tensor data with dimensions H_LOAD*T_LOAD*C_LOAD.
// @param array The output array to store the tensor data with dimensions H*T*C.
// @param H_LOAD The height dimension of the input tensor.
// @param H The height dimension of the output array.
// @param T_LOAD The time or sequence dimension of the input tensor.
// @param T The time or sequence dimension of the output array.
// @param C_LOAD The channel dimension of the input tensor.
// @param C The channel dimension of the output array.
// @tparam data_t The data type of the tensor and array elements.

template<class data_t>
void tensor2array(
    vector<data_t>& tensor,
    data_t array[],
    int H_LOAD,
    int H,
    int T_LOAD,
    int T,
    int C_LOAD,
    int C
){
    // Verify that the tensor size matches the expected dimensions
    assert(tensor.size() == H_LOAD * T_LOAD * C_LOAD);
    // Copy data from the tensor to the array with the specified dimensions
    for(int h=0; h<H; ++h){
        for(int t=0; t<T; ++t){
            for(int c=0; c<C; ++c){
                // Compute the linear index and assign the value from tensor to array
                array[h*T*C + t*C + c] = tensor[h*T_LOAD*C_LOAD + t*C_LOAD + c];
            }
        }
    }
}


// Reorganizes a multi-head tensor by splitting heads, transforming the shape from (T, H, C) to (H, T, C).
// @param array The input/output array containing the tensor data with dimensions H*T*C.
// @param H The number of heads in the tensor.
// @param T The time or sequence dimension of the tensor.
// @param C The channel dimension of the tensor.
// @tparam data_t The data type of the array elements.
template<class data_t>
void split_heads(
    data_t array[],
    int H,
    int T,
    int C
){
    // shape: (T, H, C) -> (H, T, C)
    // Create a temporary array to store the reshaped data
    data_t tmp_array[H*T*C];
    // Reorganize data from (T, H, C) to (H, T, C) layout
    for(int h=0; h<H; ++h){
        for(int t=0; t<T; ++t){
            for(int c=0; c<C; ++c){
                // Copy data to temporary array with new indexing
                tmp_array[h*T*C + t*C + c] = array[t*H*C + h*C + c];
            }
        }
    }
    // Copy the reshaped data back to the original array
    for(int h=0; h<H; ++h){
        for(int t=0; t<T; ++t){
            for(int c=0; c<C; ++c){
                array[h*T*C + t*C + c] = tmp_array[h*T*C + t*C + c];
            }
        }
    }
}

// Reorganizes a multi-head tensor by merging heads, transforming the shape from (H, T, C) to (T, H, C).
// @param array The input/output array containing the tensor data with dimensions H*T*C.
// @param H The number of heads in the tensor.
// @param T The time or sequence dimension of the tensor.
// @param C The channel dimension of the tensor.
// @tparam data_t The data type of the array elements.

template<class data_t>
void merge_heads(
    data_t array[],
    int H,
    int T,
    int C
){
    // shape: (H, T, C) -> (T, H, C)
    // Create a temporary array to store the reshaped data
    data_t tmp_array[H*T*C];
    // Reorganize data from (H, T, C) to (T, H, C) layout
    for(int h=0; h<H; ++h){
        for(int t=0; t<T; ++t){
            for(int c=0; c<C; ++c){
                // Copy data to temporary array with new indexing
                tmp_array[t*H*C + h*C + c] = array[h*T*C + t*C + c];
            }
        }
    }
    // Copy the reshaped data back to the original array
    for(int h=0; h<H; ++h){
        for(int t=0; t<T; ++t){
            for(int c=0; c<C; ++c){
                array[t*H*C + h*C + c] = tmp_array[t*H*C + h*C + c];
            }
        }
    }
}

// Performs a right bit-shift operation on each element of an array to truncate its value.
// @param array The input array containing elements to be truncated.
// @param size The number of elements in the array.
// @param trunc The number of bits to shift each element to the right.
// @tparam data_t The data type of the array elements.
template<class data_t>
void truncate(data_t array[], int size, int trunc){
     // Iterate through the array
    for(int i=0; i<size; ++i){
        // Right-shift each element by the specified number of bits
        array[i] = array[i] >> trunc;
    }
}

// Performs a left bit-shift operation on each element of an array.
// @param array The input array containing elements to be shifted.
// @param size The number of elements in the array.
// @param shift The number of bits to shift each element to the left.
// @tparam data_t The data type of the array elements.
template<class data_t>
void upshift(data_t array[], int size, int shift){
    // Iterate through the array
    for(int i=0; i<size; ++i){
         // Left-shift each element by the specified number of bits
        array[i] <<= shift;
    }
}





// Converts data from a flat array into a stream of vectors with specified dimensions.
// @param data The input array containing data with dimensions H*T*C.
// @param stream The output stream to store vectors of type stream_t with TP*CP elements.
// @param info A string identifier for the operation, used in the progress bar (default is empty).
// @param verbose If true, displays a progress bar during execution (default is false).
// @tparam data_t The data type of the input array elements.
// @tparam stream_t The data type of the stream vector elements.
// @tparam REPEAT The number of times to repeat the streaming process for each time tile.
// @tparam H The height dimension of the data tensor (number of heads, H=1 for single operation).
// @tparam T The time or sequence dimension of the data tensor.
// @tparam TP The number of time steps per stream vector.
// @tparam C The channel dimension of the data tensor.
// @tparam CP The number of channels per stream vector.
template<
    class data_t,
    class stream_t,
    int REPEAT,
    int H,      // number of heads, for single op, H=1
    int T,
    int TP,
    int C,
    int CP>
void array2stream(
    data_t data[],
    hls::stream<hls::vector<stream_t, TP*CP> >& stream,
    const string& info = "",
    bool verbose=false
){
    // Calculate the number of time tiles and channel tiles
    int TT = T / TP;
    int CT = C / CP;

// Initialize a progress bar for tracking operation progress
    ProgressBar progress_bar(info, H*TT);
 // Start the progress bar
    progress_bar.start();
// Iterate over height dimension (heads)
    for(int h=0; h<H; ++h){
        // Iterate over time tiles
        for(int tt=0; tt<TT; ++tt){
           
            // Update the progress bar if verbose mode is enabled
            if(verbose) progress_bar.update(1);
// Repeat the streaming process as specified
            for(int repeat=0; repeat<REPEAT; ++repeat){
                for(int ct=0; ct<CT; ++ct){
                    // write the data to stream
                     // Create a vector to hold TP*CP elements
                    hls::vector<stream_t, TP*CP> vec;
                    for(int tp=0; tp<TP; ++tp){
                        for(int cp=0; cp<CP; ++cp){
                            // Compute the linear index and assign the value to the vector
                            vec[tp*CP + cp] = data[h*T*C + (tt*TP + tp)*C + ct*CP + cp];
                        }
                    }
                     // Write the vector to the stream
                    stream.write(vec);
                }
            }
        }
    }
}

// Converts and packs data from a flat array into a stream of vectors with specified dimensions.
// @param data The input array containing data with dimensions H*T*C.
// @param stream The output stream to store vectors of type stream_t with CP elements.
// @param info A string identifier for the operation, used in the progress bar (default is empty).
// @param verbose If true, displays a progress bar during execution (default is false).
// @tparam data_t The data type of the input array elements.
// @tparam stream_t The data type of the stream vector elements.
// @tparam REPEAT The number of times to repeat the streaming process for each time tile.
// @tparam H The height dimension of the data tensor (number of heads, H=1 for single operation).
// @tparam T The time or sequence dimension of the data tensor.
// @tparam GEMM_TP The number of time steps to pack per iteration (GEMM tile parameter).
// @tparam C The channel dimension of the data tensor.
// @tparam CP The number of channels per stream vector.
template<
    class data_t,
    class stream_t,
    int REPEAT,
    int H,      // number of heads, for single op, H=1
    int T,
    int GEMM_TP,
    int C,
    int CP>
void array2stream_unpack(
    data_t data[],
    hls::stream<hls::vector<stream_t, CP> >& stream,
    const string& info = "",
    bool verbose=false
){
    // Calculate the number of time tiles and channel tiles
    int TT = T / GEMM_TP;
    int CT = C / CP;

    // instantiate a progress bar
    ProgressBar progress_bar(info, H*TT);

    progress_bar.start();
// Iterate over height dimension (heads)
    for(int h=0; h<H; ++h){
        // Iterate over time tiles
        for(int tt=0; tt<TT; ++tt){
            // update the progress bar
            if(verbose) progress_bar.update(1);
            // Repeat the streaming process as specified
            for(int repeat=0; repeat<REPEAT; ++repeat){
                // Iterate over channel tiles
                for(int ct=0; ct<CT; ++ct){
                    // unpacked
                    for(int tp=0; tp<GEMM_TP; ++tp){
                        hls::vector<stream_t, CP> vec;
                        // Pack data into the vector
                        for(int cp=0; cp<CP; ++cp){
                            // Compute the linear index and assign the value to the vector
                            vec[cp] = data[h*T*C + (tt*GEMM_TP + tp)*C + ct*CP + cp];
                        }
                        // Write the vector to the stream
                        stream.write(vec);
                    }
                }
            }
        }
    }
}

// Converts data from a stream of vectors into a flat array with specified dimensions.
// @param stream The input stream containing vectors of type stream_t with TP*CP elements.
// @param data The output array to store the unpacked data, with dimensions H*T*C.
// @param info A string identifier for the operation, used in the progress bar (default is empty).
// @param verbose If true, displays a progress bar during execution (default is false).
// @tparam data_t The data type of the output array elements.
// @tparam stream_t The data type of the stream vector elements.
// @tparam H The height dimension of the data tensor.
// @tparam T The time or sequence dimension of the data tensor.
// @tparam TP The number of time steps per stream vector.
// @tparam C The channel dimension of the data tensor.
// @tparam CP The number of channels per stream vector.

template<
    class data_t,
    class stream_t,
    int H,
    int T,
    int TP,
    int C,
    int CP>
void stream2array(
    hls::stream<hls::vector<stream_t, TP*CP> >& stream,
    data_t data[H*T*C],
    const string& info="",
    bool verbose=false
){
    int TT = T / TP;
    int CT = C / CP;

    // instantiate a progress bar
    ProgressBar progress_bar(info, H*TT);

    progress_bar.start();

    for(int h=0; h<H; ++h){
        for(int tt=0; tt<TT; ++tt){
            // update the progress bar
            if(verbose) progress_bar.update(1);
            for(int ct=0; ct<CT; ++ct){
                // read the data from stream
                hls::vector<stream_t, TP*CP> tmp_vec = stream.read();
                for(int tp=0; tp<TP; ++tp){
                    for(int cp=0; cp<CP; ++cp){
                        data[h*T*C + (tt*TP + tp)*C + ct*CP + cp] = tmp_vec[tp*CP + cp];
                    }
                }
            }
        }
    }
}

// Converts and unpacks data from a stream of vectors into a flat array with specified dimensions.
// @param stream The input stream containing vectors of type stream_t with CP elements.
// @param data The output array to store the unpacked data, with dimensions H*T*C.
// @param info A string identifier for the operation, used in the progress bar (default is empty).
// @param verbose If true, displays a progress bar during execution (default is false).
// @tparam data_t The data type of the output array elements.
// @tparam stream_t The data type of the stream vector elements.
// @tparam H The height dimension of the data tensor.
// @tparam T The time or sequence dimension of the data tensor.
// @tparam GEMM_TP The number of time steps to unpack per iteration (GEMM tile parameter).
// @tparam C The channel dimension of the data tensor.
// @tparam CP The number of channels per stream vector.
template<
    class data_t,
    class stream_t,
    int H,
    int T,
    int GEMM_TP,
    int C,
    int CP>
void stream2array_unpack(
    // GEMM_TP unpacked
    hls::stream<hls::vector<stream_t, CP> >& stream,
    data_t data[H*T*C],
    const string& info="",
    bool verbose=false
){
    int TT = T / GEMM_TP;
    int CT = C / CP;

    // instantiate a progress bar
    ProgressBar progress_bar(info, H*TT);

    progress_bar.start();

    for(int h=0; h<H; ++h){
        for(int tt=0; tt<TT; ++tt){
            // update the progress bar
            if(verbose) progress_bar.update(1);
            for(int ct=0; ct<CT; ++ct){
                // unpack or not?
                for(int tp=0; tp<GEMM_TP; ++tp){
                    // read the data from stream
                    hls::vector<stream_t, CP> tmp_vec = stream.read();
                    for(int cp=0; cp<CP; ++cp){
                        data[h*T*C + (tt*GEMM_TP + tp)*C + ct*CP + cp] = tmp_vec[cp];
                    }
                }
            }
        }
    }
}


// Compares two arrays of the same type and size for equality, with optional verbose output.
// @param data1 The first array to compare.
// @param data2 The second array to compare.
// @param N The number of elements in the arrays to compare.
// @param info A string identifier for the comparison, used in output messages.
// @param verbose If true, prints a message when arrays match; if false, only prints mismatches.

template<class data_t>
void compare(
    data_t data1[],
    data_t data2[],
    int N,
    const string& info,
    bool verbose=false
){
    bool match = true;
    for(int i=0; i<N; ++i){
        if(data1[i] != data2[i]){
            printf("%s mismatch at [%5d]: %5d vs %5d\n", info.c_str(), i, data1[i], data2[i]);
            match = false;
        }
    }
    if(match){
        if(verbose){
            printf("%s match\n", info.c_str());
        }
    } else {
        printf("%s mismatch\n", info.c_str());
    }
}

// Saves a condensed tensor from a stream to a file and reloads it back to the stream.
// @param file_path The file path where the tensor will be saved and read from.
// @param stream The input/output stream containing vector data of type _stream_t with TILE_SIZE elements.
// @tparam _dtype The data type of the tensor elements.
// @tparam _stream_t The data type of the stream elements.
// @tparam NUM_W The total number of elements in the tensor.
// @tparam TILE_SIZE The size of each tile in the stream.

template<typename _dtype, typename _stream_t, int NUM_W, int TILE_SIZE>
void save_condensed_tensor(const std::string &file_path, hls::stream<hls::vector<_stream_t, TILE_SIZE> >& stream){
    // number of tiles
    static_assert(NUM_W % TILE_SIZE == 0, "NUM_W must be multiple of TILE_SIZE");
    int NUM_TILE = NUM_W / TILE_SIZE;
    // create a vector
    static _dtype condensed_tensor[NUM_W];
    // read stream, and put it to vector
    stream2array<_dtype, _stream_t, 1, 1, 1, NUM_W, TILE_SIZE>(stream, condensed_tensor);
    // save tensor
    save_tensor<_dtype>(file_path, condensed_tensor, NUM_W);
    // read tensor
    vector<_dtype> condensed_tensor_read = read_tensor<_dtype>(file_path);
    tensor2array<_dtype>(condensed_tensor_read, condensed_tensor, 1, 1, 1, 1, NUM_W, NUM_W);
    // write back to stream
    array2stream<_dtype, _stream_t, 1, 1, 1, 1, NUM_W, TILE_SIZE>(condensed_tensor, stream);
}



#endif

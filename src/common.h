#ifndef __INT_COMMON_H__
#define __INT_COMMON_H__


#include <fstream>
#include <vector> 
#include <string> 
#include <cstdlib> // 为 exit 函数提供支持

// standard library
#include <cassert>
#include <ctime>

#include <iostream>
#include <cstdint>

// hls library
#include <ap_int.h> //
#include <ap_axi_sdata.h>
#include <hls_stream.h>
#include <hls_vector.h>

// user defined library
#include "adapter.h"

using namespace std;

const unsigned int SYSTEM_WIDTH = 64;
typedef ap_int<SYSTEM_WIDTH> system_t;

// fc related definition
typedef ap_uint<10>         class_index_t; // indexing class
typedef ap_uint<18>         case_index_t;

typedef ap_axiu<SYSTEM_WIDTH, 0, 0, 0> axis_t;

//It simulates the process of calculating how many times a number needs to be divided by 2 to get 1, which is actually calculating the upper integer value of log2(n).
constexpr int log2ce(int n){
    return (n <= 1) ? 0 : 1 + log2ce(n / 2);
}

//hls comprehensive attributes
constexpr const int BRAM_STYLE = 0;
constexpr const int URAM_STYLE = 1;
constexpr const int LRAM_STYLE = 2;

// A prime number, for auto template completion
constexpr const int NONE_CP = 47;

constexpr const int MAMBA_L = 64;

//Data width
constexpr int DW_X          = 32;
constexpr int DW_X_POW2SUM  = 64;
constexpr int DW_X_RSQRT    = 25;
constexpr int DW_LNW1       = 11;
constexpr int DW_LNW        = 13;
constexpr int DW_XLN        = 32;
constexpr int DW_AQ         = 4;
constexpr int DW_ASCALE     = 4;
constexpr int DW_WQ         = 4;
constexpr int DW_WSCALE     = 3;
constexpr int DW_XD         = 34;
constexpr int DW_HTCD       = 38;
constexpr int DW_DBU        = 37;
constexpr int DW_ACQ        = 8;
constexpr int DW_WCQ        = 8;
constexpr int DW_WSCALE_    = 5;
constexpr int DW_SILU_IN    = 32;
constexpr int DW_SILU_OUT   = 32;
constexpr int DW_WA         = 16;
constexpr int DW_EXP_IN     = 32;
constexpr int DW_EXP_OUT    = 32;
constexpr int DW_SOFTPLUS_IN     = 32;
constexpr int DW_SOFTPLUS_OUT    = 32;

// define data types
typedef ap_int<DW_X         > X_T;
typedef ap_int<DW_XD         > XD_T;
typedef ap_int<DW_HTCD         > HTC_T;
typedef ap_int<DW_DBU         > DBU_T;
typedef ap_int<DW_X_POW2SUM > X_POW2SUM_T;
typedef ap_int<DW_X_RSQRT   > X_RSQRT_T;
typedef ap_int<DW_LNW1      > LNW1_T;
typedef ap_int<DW_LNW       > LNW_T;
typedef ap_int<DW_XLN       > XLN_T;
typedef ap_uint<DW_ASCALE    > ASCALE_T;
typedef ap_int<DW_ACQ       > A_T;
typedef ap_uint<DW_WSCALE    > WSCALE_T;
typedef ap_int<DW_WCQ       > WC_T;
typedef ap_uint<DW_WSCALE_   > WSCALE_T_;
typedef ap_int <DW_AQ       > AQ_T;
typedef ap_uint<DW_ASCALE   > AS_T;
typedef ap_int<DW_SILU_IN   > SILU_IN_T;
typedef ap_int<DW_SILU_OUT  > SILU_OUT_T;
typedef ap_int<DW_WA        > AQ_T_;
typedef ap_int<DW_EXP_IN   > EXP_IN_T;
typedef ap_int<DW_EXP_OUT  > EXP_OUT_T;
typedef ap_int<DW_SOFTPLUS_IN   > SOFTPLUS_IN_T;
typedef ap_int<DW_SOFTPLUS_OUT  > SOFTPLUS_OUT_T;

#endif
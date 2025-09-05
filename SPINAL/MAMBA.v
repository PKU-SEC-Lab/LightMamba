// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : MAMBA
// Git hash  : 79e645f08db4b61f66fa178c9252b19210d0b725

`timescale 1ns/1ps

module MAMBA (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          x_stream_TVALID,
  output wire          x_stream_TREADY,
  input  wire [255:0]  x_stream_TDATA,
  input  wire          w_stream_TVALID,
  output wire          w_stream_TREADY,
  input  wire [255:0]  w_stream_TDATA,
  input  wire          s1_stream_TVALID,
  output wire          s1_stream_TREADY,
  input  wire [23:0]   s1_stream_TDATA,
  input  wire          s2_stream_TVALID,
  output wire          s2_stream_TREADY,
  input  wire [23:0]   s2_stream_TDATA,
  output wire          y_stream_TVALID,
  input  wire          y_stream_TREADY,
  output wire [255:0]  y_stream_TDATA,
  input  wire          cq_stream_TVALID,
  output wire          cq_stream_TREADY,
  input  wire [255:0]  cq_stream_TDATA,
  input  wire          cs_stream_TVALID,
  output wire          cs_stream_TREADY,
  input  wire [255:0]  cs_stream_TDATA,
  output wire          cq2_stream_TVALID,
  input  wire          cq2_stream_TREADY,
  output wire [255:0]  cq2_stream_TDATA,
  output wire          cs2_stream_TVALID,
  input  wire          cs2_stream_TREADY,
  output wire [255:0]  cs2_stream_TDATA,
  input  wire          hq_stream_TVALID,
  output wire          hq_stream_TREADY,
  input  wire [255:0]  hq_stream_TDATA,
  input  wire          hs_stream_TVALID,
  output wire          hs_stream_TREADY,
  input  wire [255:0]  hs_stream_TDATA,
  output wire          hq2_stream_TVALID,
  input  wire          hq2_stream_TREADY,
  output wire [255:0]  hq2_stream_TDATA,
  output wire          hs2_stream_TVALID,
  input  wire          hs2_stream_TREADY,
  output wire [255:0]  hs2_stream_TDATA
);

  wire                x_stream_fifo_io_flush;
  wire                w_stream_fifo_io_flush;
  wire                s1_stream_fifo_io_flush;
  wire                s2_stream_fifo_io_flush;
  wire                cq_stream_fifo_io_flush;
  wire                cs_stream_fifo_io_flush;
  wire                hq_stream_fifo_io_flush;
  wire                hs_stream_fifo_io_flush;
  wire                toplevel_B_buffer_1_q_stream_fifo_io_flush;
  wire                toplevel_B_buffer_1_s_stream_fifo_io_flush;
  wire                toplevel_C_buffer_1_q_stream_fifo_io_flush;
  wire                toplevel_C_buffer_1_s_stream_fifo_io_flush;
  wire                toplevel_conv_1_o_stream_fifo_io_flush;
  wire                toplevel_conv_state_1_o_stream_fifo_io_flush;
  wire                toplevel_conv_state_1_o_s_stream_fifo_io_flush;
  wire                toplevel_conv_state_1_w_stream_fifo_io_flush;
  wire                toplevel_conv_state_1_w_s_stream_fifo_io_flush;
  wire                toplevel_conv_state_1_conv_state_stream_fifo_io_flush;
  wire                toplevel_conv_state_1_conv_state_s_stream_fifo_io_flush;
  wire                toplevel_dAh_1_o_stream_fifo_io_flush;
  wire                toplevel_dBu_1_o_stream_fifo_io_flush;
  wire                toplevel_dtA_1_o_stream_fifo_io_flush;
  wire                toplevel_dtadapt_1_o_stream_fifo_io_flush;
  wire                toplevel_dtadapt_1_o_s_stream_fifo_io_flush;
  wire                toplevel_dtadapt_1_o_stream2_fifo_io_flush;
  wire                toplevel_dtadapt_1_o_s_stream2_fifo_io_flush;
  wire                toplevel_dtB_quant_1_o_stream_fifo_io_flush;
  wire                toplevel_dtB_quant_1_o_s_stream_fifo_io_flush;
  wire                toplevel_exp_quant_1_o_stream_fifo_io_flush;
  wire                toplevel_exp_quant_1_o_s_stream_fifo_io_flush;
  wire                toplevel_gemm_1_o_stream_fifo_io_flush;
  wire                toplevel_gemm_demux_1_dt_stream_fifo_io_flush;
  wire                toplevel_gemm_demux_1_xBC_stream_fifo_io_flush;
  wire                toplevel_gemm_demux_1_z_stream_fifo_io_flush;
  wire                toplevel_gemm_demux_1_out_stream_fifo_io_flush;
  wire                toplevel_gemm_mux_1_q_stream_fifo_io_flush;
  wire                toplevel_gemm_mux_1_s_stream_fifo_io_flush;
  wire                toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_flush;
  wire                toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_flush;
  wire                toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_flush;
  wire                toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_flush;
  wire                toplevel_ht_state_1_ht_out_stream_fifo_io_flush;
  wire                toplevel_ht_state_1_ht_out_s_stream_fifo_io_flush;
  wire                toplevel_ht_state_1_state_out_stream_fifo_io_flush;
  wire                toplevel_ht_state_1_state_out_s_stream_fifo_io_flush;
  wire                toplevel_htC_quant_1_o_q_stream_fifo_io_flush;
  wire                toplevel_htC_quant_1_o_s_stream_fifo_io_flush;
  wire                toplevel_quant_conv_1_o_stream_fifo_io_flush;
  wire                toplevel_quant_conv_1_o_s_stream_fifo_io_flush;
  wire                toplevel_residual_1_res_o_stream_fifo_io_flush;
  wire                toplevel_residual_1_y_stream_fifo_io_flush;
  wire                toplevel_rms_quant_1_xlnq_stream_fifo_io_flush;
  wire                toplevel_rms_quant_1_xlns_stream_fifo_io_flush;
  wire                toplevel_rms_quant_2_xlnq_stream_fifo_io_flush;
  wire                toplevel_rms_quant_2_xlns_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_x_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_x_s_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_x_stream2_fifo_io_flush;
  wire                toplevel_silu_demux_1_x_s_stream2_fifo_io_flush;
  wire                toplevel_silu_demux_1_B_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_B_s_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_C_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_C_s_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_z_stream_fifo_io_flush;
  wire                toplevel_silu_demux_1_z_s_stream_fifo_io_flush;
  wire                toplevel_silu_mux_1_silu_stream_fifo_io_flush;
  wire                toplevel_silu_quant_1_out_stream_fifo_io_flush;
  wire                toplevel_silu_quant_1_out_s_stream_fifo_io_flush;
  wire                toplevel_ud_1_o_stream_fifo_io_flush;
  wire                toplevel_yz_1_o_stream_fifo_io_flush;
  wire       [31:0]   B_buffer_1_signals_O_L_BEGIN;
  wire       [31:0]   B_buffer_1_signals_O_L_CLOSE;
  wire       [63:0]   B_buffer_1_signals_O_MEMORY_X;
  wire       [63:0]   B_buffer_1_signals_O_MEMORY_W;
  wire       [63:0]   B_buffer_1_signals_O_MEMORY_Y;
  wire       [63:0]   B_buffer_1_signals_O_MEMORY_C;
  wire       [63:0]   B_buffer_1_signals_O_MEMORY_H;
  wire       [11:0]   B_buffer_1_signals_O_POS;
  wire                B_buffer_1_signals_O_T;
  wire                B_buffer_1_i_stream_TREADY;
  wire                B_buffer_1_i_s_stream_TREADY;
  wire                B_buffer_1_q_stream_TVALID;
  wire       [63:0]   B_buffer_1_q_stream_TDATA;
  wire                B_buffer_1_s_stream_TVALID;
  wire       [7:0]    B_buffer_1_s_stream_TDATA;
  wire       [31:0]   C_buffer_1_signals_O_L_BEGIN;
  wire       [31:0]   C_buffer_1_signals_O_L_CLOSE;
  wire       [63:0]   C_buffer_1_signals_O_MEMORY_X;
  wire       [63:0]   C_buffer_1_signals_O_MEMORY_W;
  wire       [63:0]   C_buffer_1_signals_O_MEMORY_Y;
  wire       [63:0]   C_buffer_1_signals_O_MEMORY_C;
  wire       [63:0]   C_buffer_1_signals_O_MEMORY_H;
  wire       [11:0]   C_buffer_1_signals_O_POS;
  wire                C_buffer_1_signals_O_T;
  wire                C_buffer_1_i_stream_TREADY;
  wire                C_buffer_1_i_s_stream_TREADY;
  wire                C_buffer_1_q_stream_TVALID;
  wire       [63:0]   C_buffer_1_q_stream_TDATA;
  wire                C_buffer_1_s_stream_TVALID;
  wire       [7:0]    C_buffer_1_s_stream_TDATA;
  wire       [31:0]   conv_1_signals_O_L_BEGIN;
  wire       [31:0]   conv_1_signals_O_L_CLOSE;
  wire       [63:0]   conv_1_signals_O_MEMORY_X;
  wire       [63:0]   conv_1_signals_O_MEMORY_W;
  wire       [63:0]   conv_1_signals_O_MEMORY_Y;
  wire       [63:0]   conv_1_signals_O_MEMORY_C;
  wire       [63:0]   conv_1_signals_O_MEMORY_H;
  wire       [11:0]   conv_1_signals_O_POS;
  wire                conv_1_signals_O_T;
  wire                conv_1_i_stream_TREADY;
  wire                conv_1_s_stream_TREADY;
  wire                conv_1_w_stream_TREADY;
  wire                conv_1_w_s_stream_TREADY;
  wire                conv_1_o_stream_TVALID;
  wire       [255:0]  conv_1_o_stream_TDATA;
  wire       [31:0]   conv_state_1_signals_O_L_BEGIN;
  wire       [31:0]   conv_state_1_signals_O_L_CLOSE;
  wire       [63:0]   conv_state_1_signals_O_MEMORY_X;
  wire       [63:0]   conv_state_1_signals_O_MEMORY_W;
  wire       [63:0]   conv_state_1_signals_O_MEMORY_Y;
  wire       [63:0]   conv_state_1_signals_O_MEMORY_C;
  wire       [63:0]   conv_state_1_signals_O_MEMORY_H;
  wire       [11:0]   conv_state_1_signals_O_POS;
  wire                conv_state_1_signals_O_T;
  wire                conv_state_1_conv_stream_TREADY;
  wire                conv_state_1_conv_s_stream_TREADY;
  wire                conv_state_1_xBC_stream_TREADY;
  wire                conv_state_1_xBC_s_stream_TREADY;
  wire                conv_state_1_w_stream_TVALID;
  wire       [63:0]   conv_state_1_w_stream_TDATA;
  wire                conv_state_1_w_s_stream_TVALID;
  wire       [7:0]    conv_state_1_w_s_stream_TDATA;
  wire                conv_state_1_o_stream_TVALID;
  wire       [63:0]   conv_state_1_o_stream_TDATA;
  wire                conv_state_1_o_s_stream_TVALID;
  wire       [7:0]    conv_state_1_o_s_stream_TDATA;
  wire                conv_state_1_conv_state_stream_TVALID;
  wire       [255:0]  conv_state_1_conv_state_stream_TDATA;
  wire                conv_state_1_conv_state_s_stream_TVALID;
  wire       [255:0]  conv_state_1_conv_state_s_stream_TDATA;
  wire       [31:0]   dAh_1_signals_O_L_BEGIN;
  wire       [31:0]   dAh_1_signals_O_L_CLOSE;
  wire       [63:0]   dAh_1_signals_O_MEMORY_X;
  wire       [63:0]   dAh_1_signals_O_MEMORY_W;
  wire       [63:0]   dAh_1_signals_O_MEMORY_Y;
  wire       [63:0]   dAh_1_signals_O_MEMORY_C;
  wire       [63:0]   dAh_1_signals_O_MEMORY_H;
  wire       [11:0]   dAh_1_signals_O_POS;
  wire                dAh_1_signals_O_T;
  wire                dAh_1_dA_stream_TREADY;
  wire                dAh_1_dA_s_stream_TREADY;
  wire                dAh_1_ht_stream_TREADY;
  wire                dAh_1_ht_s_stream_TREADY;
  wire                dAh_1_o_stream_TVALID;
  wire       [255:0]  dAh_1_o_stream_TDATA;
  wire       [31:0]   dBu_1_signals_O_L_BEGIN;
  wire       [31:0]   dBu_1_signals_O_L_CLOSE;
  wire       [63:0]   dBu_1_signals_O_MEMORY_X;
  wire       [63:0]   dBu_1_signals_O_MEMORY_W;
  wire       [63:0]   dBu_1_signals_O_MEMORY_Y;
  wire       [63:0]   dBu_1_signals_O_MEMORY_C;
  wire       [63:0]   dBu_1_signals_O_MEMORY_H;
  wire       [11:0]   dBu_1_signals_O_POS;
  wire                dBu_1_signals_O_T;
  wire                dBu_1_dB_stream_TREADY;
  wire                dBu_1_dB_s_stream_TREADY;
  wire                dBu_1_u_stream_TREADY;
  wire                dBu_1_u_s_stream_TREADY;
  wire                dBu_1_o_stream_TVALID;
  wire       [255:0]  dBu_1_o_stream_TDATA;
  wire       [31:0]   dtA_1_signals_O_L_BEGIN;
  wire       [31:0]   dtA_1_signals_O_L_CLOSE;
  wire       [63:0]   dtA_1_signals_O_MEMORY_X;
  wire       [63:0]   dtA_1_signals_O_MEMORY_W;
  wire       [63:0]   dtA_1_signals_O_MEMORY_Y;
  wire       [63:0]   dtA_1_signals_O_MEMORY_C;
  wire       [63:0]   dtA_1_signals_O_MEMORY_H;
  wire       [11:0]   dtA_1_signals_O_POS;
  wire                dtA_1_signals_O_T;
  wire                dtA_1_i_stream_TREADY;
  wire                dtA_1_s_stream_TREADY;
  wire                dtA_1_o_stream_TVALID;
  wire       [255:0]  dtA_1_o_stream_TDATA;
  wire       [31:0]   dtadapt_1_signals_O_L_BEGIN;
  wire       [31:0]   dtadapt_1_signals_O_L_CLOSE;
  wire       [63:0]   dtadapt_1_signals_O_MEMORY_X;
  wire       [63:0]   dtadapt_1_signals_O_MEMORY_W;
  wire       [63:0]   dtadapt_1_signals_O_MEMORY_Y;
  wire       [63:0]   dtadapt_1_signals_O_MEMORY_C;
  wire       [63:0]   dtadapt_1_signals_O_MEMORY_H;
  wire       [11:0]   dtadapt_1_signals_O_POS;
  wire                dtadapt_1_signals_O_T;
  wire                dtadapt_1_i_stream_TREADY;
  wire                dtadapt_1_o_stream_TVALID;
  wire       [63:0]   dtadapt_1_o_stream_TDATA;
  wire                dtadapt_1_o_s_stream_TVALID;
  wire       [7:0]    dtadapt_1_o_s_stream_TDATA;
  wire                dtadapt_1_o_stream2_TVALID;
  wire       [63:0]   dtadapt_1_o_stream2_TDATA;
  wire                dtadapt_1_o_s_stream2_TVALID;
  wire       [7:0]    dtadapt_1_o_s_stream2_TDATA;
  wire       [31:0]   dtB_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   dtB_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   dtB_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   dtB_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   dtB_quant_1_signals_O_MEMORY_Y;
  wire       [63:0]   dtB_quant_1_signals_O_MEMORY_C;
  wire       [63:0]   dtB_quant_1_signals_O_MEMORY_H;
  wire       [11:0]   dtB_quant_1_signals_O_POS;
  wire                dtB_quant_1_signals_O_T;
  wire                dtB_quant_1_dt_stream_TREADY;
  wire                dtB_quant_1_dt_s_stream_TREADY;
  wire                dtB_quant_1_B_stream_TREADY;
  wire                dtB_quant_1_B_s_stream_TREADY;
  wire                dtB_quant_1_o_stream_TVALID;
  wire       [63:0]   dtB_quant_1_o_stream_TDATA;
  wire                dtB_quant_1_o_s_stream_TVALID;
  wire       [7:0]    dtB_quant_1_o_s_stream_TDATA;
  wire       [31:0]   exp_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   exp_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   exp_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   exp_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   exp_quant_1_signals_O_MEMORY_Y;
  wire       [63:0]   exp_quant_1_signals_O_MEMORY_C;
  wire       [63:0]   exp_quant_1_signals_O_MEMORY_H;
  wire       [11:0]   exp_quant_1_signals_O_POS;
  wire                exp_quant_1_signals_O_T;
  wire                exp_quant_1_i_stream_TREADY;
  wire                exp_quant_1_o_stream_TVALID;
  wire       [63:0]   exp_quant_1_o_stream_TDATA;
  wire                exp_quant_1_o_s_stream_TVALID;
  wire       [7:0]    exp_quant_1_o_s_stream_TDATA;
  wire       [31:0]   gemm_1_signals_O_L_BEGIN;
  wire       [31:0]   gemm_1_signals_O_L_CLOSE;
  wire       [63:0]   gemm_1_signals_O_MEMORY_X;
  wire       [63:0]   gemm_1_signals_O_MEMORY_W;
  wire       [63:0]   gemm_1_signals_O_MEMORY_Y;
  wire       [63:0]   gemm_1_signals_O_MEMORY_C;
  wire       [63:0]   gemm_1_signals_O_MEMORY_H;
  wire       [11:0]   gemm_1_signals_O_POS;
  wire                gemm_1_signals_O_T;
  wire                gemm_1_i_stream_TREADY;
  wire                gemm_1_w_stream_TREADY;
  wire                gemm_1_s_stream_TREADY;
  wire                gemm_1_s1_stream_TREADY;
  wire                gemm_1_s2_stream_TREADY;
  wire                gemm_1_o_stream_TVALID;
  wire       [255:0]  gemm_1_o_stream_TDATA;
  wire       [31:0]   gemm_demux_1_signals_O_L_BEGIN;
  wire       [31:0]   gemm_demux_1_signals_O_L_CLOSE;
  wire       [63:0]   gemm_demux_1_signals_O_MEMORY_X;
  wire       [63:0]   gemm_demux_1_signals_O_MEMORY_W;
  wire       [63:0]   gemm_demux_1_signals_O_MEMORY_Y;
  wire       [63:0]   gemm_demux_1_signals_O_MEMORY_C;
  wire       [63:0]   gemm_demux_1_signals_O_MEMORY_H;
  wire       [11:0]   gemm_demux_1_signals_O_POS;
  wire                gemm_demux_1_signals_O_T;
  wire                gemm_demux_1_gemm_stream_TREADY;
  wire                gemm_demux_1_dt_stream_TVALID;
  wire       [255:0]  gemm_demux_1_dt_stream_TDATA;
  wire                gemm_demux_1_xBC_stream_TVALID;
  wire       [255:0]  gemm_demux_1_xBC_stream_TDATA;
  wire                gemm_demux_1_z_stream_TVALID;
  wire       [255:0]  gemm_demux_1_z_stream_TDATA;
  wire                gemm_demux_1_out_stream_TVALID;
  wire       [255:0]  gemm_demux_1_out_stream_TDATA;
  wire       [31:0]   gemm_mux_1_signals_O_L_BEGIN;
  wire       [31:0]   gemm_mux_1_signals_O_L_CLOSE;
  wire       [63:0]   gemm_mux_1_signals_O_MEMORY_X;
  wire       [63:0]   gemm_mux_1_signals_O_MEMORY_W;
  wire       [63:0]   gemm_mux_1_signals_O_MEMORY_Y;
  wire       [63:0]   gemm_mux_1_signals_O_MEMORY_C;
  wire       [63:0]   gemm_mux_1_signals_O_MEMORY_H;
  wire       [11:0]   gemm_mux_1_signals_O_POS;
  wire                gemm_mux_1_signals_O_T;
  wire                gemm_mux_1_xlnq1_stream_TREADY;
  wire                gemm_mux_1_xlns1_stream_TREADY;
  wire                gemm_mux_1_xlnq2_stream_TREADY;
  wire                gemm_mux_1_xlns2_stream_TREADY;
  wire                gemm_mux_1_q_stream_TVALID;
  wire       [31:0]   gemm_mux_1_q_stream_TDATA;
  wire                gemm_mux_1_s_stream_TVALID;
  wire       [7:0]    gemm_mux_1_s_stream_TDATA;
  wire       [31:0]   ht_add_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   ht_add_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   ht_add_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   ht_add_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   ht_add_quant_1_signals_O_MEMORY_Y;
  wire       [63:0]   ht_add_quant_1_signals_O_MEMORY_C;
  wire       [63:0]   ht_add_quant_1_signals_O_MEMORY_H;
  wire       [11:0]   ht_add_quant_1_signals_O_POS;
  wire                ht_add_quant_1_signals_O_T;
  wire                ht_add_quant_1_dAh_stream_TREADY;
  wire                ht_add_quant_1_dBu_stream_TREADY;
  wire                ht_add_quant_1_ht1_q_stream_TVALID;
  wire       [63:0]   ht_add_quant_1_ht1_q_stream_TDATA;
  wire                ht_add_quant_1_ht1_s_stream_TVALID;
  wire       [7:0]    ht_add_quant_1_ht1_s_stream_TDATA;
  wire                ht_add_quant_1_ht2_q_stream_TVALID;
  wire       [63:0]   ht_add_quant_1_ht2_q_stream_TDATA;
  wire                ht_add_quant_1_ht2_s_stream_TVALID;
  wire       [7:0]    ht_add_quant_1_ht2_s_stream_TDATA;
  wire       [31:0]   ht_state_1_signals_O_L_BEGIN;
  wire       [31:0]   ht_state_1_signals_O_L_CLOSE;
  wire       [63:0]   ht_state_1_signals_O_MEMORY_X;
  wire       [63:0]   ht_state_1_signals_O_MEMORY_W;
  wire       [63:0]   ht_state_1_signals_O_MEMORY_Y;
  wire       [63:0]   ht_state_1_signals_O_MEMORY_C;
  wire       [63:0]   ht_state_1_signals_O_MEMORY_H;
  wire       [11:0]   ht_state_1_signals_O_POS;
  wire                ht_state_1_signals_O_T;
  wire                ht_state_1_state_in_stream_TREADY;
  wire                ht_state_1_state_in_s_stream_TREADY;
  wire                ht_state_1_ht_in_stream_TREADY;
  wire                ht_state_1_ht_in_s_stream_TREADY;
  wire                ht_state_1_ht_out_stream_TVALID;
  wire       [63:0]   ht_state_1_ht_out_stream_TDATA;
  wire                ht_state_1_ht_out_s_stream_TVALID;
  wire       [7:0]    ht_state_1_ht_out_s_stream_TDATA;
  wire                ht_state_1_state_out_stream_TVALID;
  wire       [255:0]  ht_state_1_state_out_stream_TDATA;
  wire                ht_state_1_state_out_s_stream_TVALID;
  wire       [255:0]  ht_state_1_state_out_s_stream_TDATA;
  wire       [31:0]   htC_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   htC_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   htC_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   htC_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   htC_quant_1_signals_O_MEMORY_Y;
  wire       [63:0]   htC_quant_1_signals_O_MEMORY_C;
  wire       [63:0]   htC_quant_1_signals_O_MEMORY_H;
  wire       [11:0]   htC_quant_1_signals_O_POS;
  wire                htC_quant_1_signals_O_T;
  wire                htC_quant_1_ht_stream_TREADY;
  wire                htC_quant_1_ht_s_stream_TREADY;
  wire                htC_quant_1_C_stream_TREADY;
  wire                htC_quant_1_C_s_stream_TREADY;
  wire                htC_quant_1_uD_stream_TREADY;
  wire                htC_quant_1_o_q_stream_TVALID;
  wire       [63:0]   htC_quant_1_o_q_stream_TDATA;
  wire                htC_quant_1_o_s_stream_TVALID;
  wire       [7:0]    htC_quant_1_o_s_stream_TDATA;
  wire       [31:0]   quant_conv_1_signals_O_L_BEGIN;
  wire       [31:0]   quant_conv_1_signals_O_L_CLOSE;
  wire       [63:0]   quant_conv_1_signals_O_MEMORY_X;
  wire       [63:0]   quant_conv_1_signals_O_MEMORY_W;
  wire       [63:0]   quant_conv_1_signals_O_MEMORY_Y;
  wire       [63:0]   quant_conv_1_signals_O_MEMORY_C;
  wire       [63:0]   quant_conv_1_signals_O_MEMORY_H;
  wire       [11:0]   quant_conv_1_signals_O_POS;
  wire                quant_conv_1_signals_O_T;
  wire                quant_conv_1_i_stream_TREADY;
  wire                quant_conv_1_o_stream_TVALID;
  wire       [63:0]   quant_conv_1_o_stream_TDATA;
  wire                quant_conv_1_o_s_stream_TVALID;
  wire       [7:0]    quant_conv_1_o_s_stream_TDATA;
  wire       [31:0]   residual_1_signals_O_L_BEGIN;
  wire       [31:0]   residual_1_signals_O_L_CLOSE;
  wire       [63:0]   residual_1_signals_O_MEMORY_X;
  wire       [63:0]   residual_1_signals_O_MEMORY_W;
  wire       [63:0]   residual_1_signals_O_MEMORY_Y;
  wire       [63:0]   residual_1_signals_O_MEMORY_C;
  wire       [63:0]   residual_1_signals_O_MEMORY_H;
  wire       [11:0]   residual_1_signals_O_POS;
  wire                residual_1_signals_O_T;
  wire                residual_1_x_stream_TREADY;
  wire                residual_1_res_i_stream_TREADY;
  wire                residual_1_res_o_stream_TVALID;
  wire       [255:0]  residual_1_res_o_stream_TDATA;
  wire                residual_1_y_stream_TVALID;
  wire       [255:0]  residual_1_y_stream_TDATA;
  wire       [31:0]   rms_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   rms_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   rms_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   rms_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   rms_quant_1_signals_O_MEMORY_Y;
  wire       [63:0]   rms_quant_1_signals_O_MEMORY_C;
  wire       [63:0]   rms_quant_1_signals_O_MEMORY_H;
  wire       [11:0]   rms_quant_1_signals_O_POS;
  wire                rms_quant_1_signals_O_T;
  wire                rms_quant_1_x_stream_TREADY;
  wire                rms_quant_1_xlnq_stream_TVALID;
  wire       [31:0]   rms_quant_1_xlnq_stream_TDATA;
  wire                rms_quant_1_xlns_stream_TVALID;
  wire       [7:0]    rms_quant_1_xlns_stream_TDATA;
  wire       [31:0]   rms_quant_2_signals_O_L_BEGIN;
  wire       [31:0]   rms_quant_2_signals_O_L_CLOSE;
  wire       [63:0]   rms_quant_2_signals_O_MEMORY_X;
  wire       [63:0]   rms_quant_2_signals_O_MEMORY_W;
  wire       [63:0]   rms_quant_2_signals_O_MEMORY_Y;
  wire       [63:0]   rms_quant_2_signals_O_MEMORY_C;
  wire       [63:0]   rms_quant_2_signals_O_MEMORY_H;
  wire       [11:0]   rms_quant_2_signals_O_POS;
  wire                rms_quant_2_signals_O_T;
  wire                rms_quant_2_x_stream_TREADY;
  wire                rms_quant_2_xlnq_stream_TVALID;
  wire       [31:0]   rms_quant_2_xlnq_stream_TDATA;
  wire                rms_quant_2_xlns_stream_TVALID;
  wire       [7:0]    rms_quant_2_xlns_stream_TDATA;
  wire       [31:0]   silu_demux_1_signals_O_L_BEGIN;
  wire       [31:0]   silu_demux_1_signals_O_L_CLOSE;
  wire       [63:0]   silu_demux_1_signals_O_MEMORY_X;
  wire       [63:0]   silu_demux_1_signals_O_MEMORY_W;
  wire       [63:0]   silu_demux_1_signals_O_MEMORY_Y;
  wire       [63:0]   silu_demux_1_signals_O_MEMORY_C;
  wire       [63:0]   silu_demux_1_signals_O_MEMORY_H;
  wire       [11:0]   silu_demux_1_signals_O_POS;
  wire                silu_demux_1_signals_O_T;
  wire                silu_demux_1_silu_stream_TREADY;
  wire                silu_demux_1_silu_s_stream_TREADY;
  wire                silu_demux_1_x_stream_TVALID;
  wire       [63:0]   silu_demux_1_x_stream_TDATA;
  wire                silu_demux_1_x_s_stream_TVALID;
  wire       [7:0]    silu_demux_1_x_s_stream_TDATA;
  wire                silu_demux_1_x_stream2_TVALID;
  wire       [63:0]   silu_demux_1_x_stream2_TDATA;
  wire                silu_demux_1_x_s_stream2_TVALID;
  wire       [7:0]    silu_demux_1_x_s_stream2_TDATA;
  wire                silu_demux_1_B_stream_TVALID;
  wire       [63:0]   silu_demux_1_B_stream_TDATA;
  wire                silu_demux_1_B_s_stream_TVALID;
  wire       [7:0]    silu_demux_1_B_s_stream_TDATA;
  wire                silu_demux_1_C_stream_TVALID;
  wire       [63:0]   silu_demux_1_C_stream_TDATA;
  wire                silu_demux_1_C_s_stream_TVALID;
  wire       [7:0]    silu_demux_1_C_s_stream_TDATA;
  wire                silu_demux_1_z_stream_TVALID;
  wire       [63:0]   silu_demux_1_z_stream_TDATA;
  wire                silu_demux_1_z_s_stream_TVALID;
  wire       [7:0]    silu_demux_1_z_s_stream_TDATA;
  wire       [31:0]   silu_mux_1_signals_O_L_BEGIN;
  wire       [31:0]   silu_mux_1_signals_O_L_CLOSE;
  wire       [63:0]   silu_mux_1_signals_O_MEMORY_X;
  wire       [63:0]   silu_mux_1_signals_O_MEMORY_W;
  wire       [63:0]   silu_mux_1_signals_O_MEMORY_Y;
  wire       [63:0]   silu_mux_1_signals_O_MEMORY_C;
  wire       [63:0]   silu_mux_1_signals_O_MEMORY_H;
  wire       [11:0]   silu_mux_1_signals_O_POS;
  wire                silu_mux_1_signals_O_T;
  wire                silu_mux_1_xBC_stream_TREADY;
  wire                silu_mux_1_z_stream_TREADY;
  wire                silu_mux_1_silu_stream_TVALID;
  wire       [255:0]  silu_mux_1_silu_stream_TDATA;
  wire       [31:0]   silu_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   silu_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   silu_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   silu_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   silu_quant_1_signals_O_MEMORY_Y;
  wire       [63:0]   silu_quant_1_signals_O_MEMORY_C;
  wire       [63:0]   silu_quant_1_signals_O_MEMORY_H;
  wire       [11:0]   silu_quant_1_signals_O_POS;
  wire                silu_quant_1_signals_O_T;
  wire                silu_quant_1_i_stream_TREADY;
  wire                silu_quant_1_out_stream_TVALID;
  wire       [63:0]   silu_quant_1_out_stream_TDATA;
  wire                silu_quant_1_out_s_stream_TVALID;
  wire       [7:0]    silu_quant_1_out_s_stream_TDATA;
  wire       [31:0]   ud_1_signals_O_L_BEGIN;
  wire       [31:0]   ud_1_signals_O_L_CLOSE;
  wire       [63:0]   ud_1_signals_O_MEMORY_X;
  wire       [63:0]   ud_1_signals_O_MEMORY_W;
  wire       [63:0]   ud_1_signals_O_MEMORY_Y;
  wire       [63:0]   ud_1_signals_O_MEMORY_C;
  wire       [63:0]   ud_1_signals_O_MEMORY_H;
  wire       [11:0]   ud_1_signals_O_POS;
  wire                ud_1_signals_O_T;
  wire                ud_1_i_stream_TREADY;
  wire                ud_1_s_stream_TREADY;
  wire                ud_1_o_stream_TVALID;
  wire       [255:0]  ud_1_o_stream_TDATA;
  wire       [31:0]   yz_1_signals_O_L_BEGIN;
  wire       [31:0]   yz_1_signals_O_L_CLOSE;
  wire       [63:0]   yz_1_signals_O_MEMORY_X;
  wire       [63:0]   yz_1_signals_O_MEMORY_W;
  wire       [63:0]   yz_1_signals_O_MEMORY_Y;
  wire       [63:0]   yz_1_signals_O_MEMORY_C;
  wire       [63:0]   yz_1_signals_O_MEMORY_H;
  wire       [11:0]   yz_1_signals_O_POS;
  wire                yz_1_signals_O_T;
  wire                yz_1_y_stream_TREADY;
  wire                yz_1_y_s_stream_TREADY;
  wire                yz_1_z_stream_TREADY;
  wire                yz_1_z_s_stream_TREADY;
  wire                yz_1_o_stream_TVALID;
  wire       [255:0]  yz_1_o_stream_TDATA;
  wire                x_stream_fifo_io_push_ready;
  wire                x_stream_fifo_io_pop_valid;
  wire       [255:0]  x_stream_fifo_io_pop_payload_data;
  wire       [3:0]    x_stream_fifo_io_occupancy;
  wire       [3:0]    x_stream_fifo_io_availability;
  wire                w_stream_fifo_io_push_ready;
  wire                w_stream_fifo_io_pop_valid;
  wire       [255:0]  w_stream_fifo_io_pop_payload_data;
  wire       [3:0]    w_stream_fifo_io_occupancy;
  wire       [3:0]    w_stream_fifo_io_availability;
  wire                s1_stream_fifo_io_push_ready;
  wire                s1_stream_fifo_io_pop_valid;
  wire       [23:0]   s1_stream_fifo_io_pop_payload_data;
  wire       [3:0]    s1_stream_fifo_io_occupancy;
  wire       [3:0]    s1_stream_fifo_io_availability;
  wire                s2_stream_fifo_io_push_ready;
  wire                s2_stream_fifo_io_pop_valid;
  wire       [23:0]   s2_stream_fifo_io_pop_payload_data;
  wire       [3:0]    s2_stream_fifo_io_occupancy;
  wire       [3:0]    s2_stream_fifo_io_availability;
  wire                cq_stream_fifo_io_push_ready;
  wire                cq_stream_fifo_io_pop_valid;
  wire       [255:0]  cq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    cq_stream_fifo_io_occupancy;
  wire       [3:0]    cq_stream_fifo_io_availability;
  wire                cs_stream_fifo_io_push_ready;
  wire                cs_stream_fifo_io_pop_valid;
  wire       [255:0]  cs_stream_fifo_io_pop_payload_data;
  wire       [3:0]    cs_stream_fifo_io_occupancy;
  wire       [3:0]    cs_stream_fifo_io_availability;
  wire                hq_stream_fifo_io_push_ready;
  wire                hq_stream_fifo_io_pop_valid;
  wire       [255:0]  hq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    hq_stream_fifo_io_occupancy;
  wire       [3:0]    hq_stream_fifo_io_availability;
  wire                hs_stream_fifo_io_push_ready;
  wire                hs_stream_fifo_io_pop_valid;
  wire       [255:0]  hs_stream_fifo_io_pop_payload_data;
  wire       [3:0]    hs_stream_fifo_io_occupancy;
  wire       [3:0]    hs_stream_fifo_io_availability;
  wire                toplevel_B_buffer_1_q_stream_fifo_io_push_ready;
  wire                toplevel_B_buffer_1_q_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_B_buffer_1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_B_buffer_1_q_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_B_buffer_1_q_stream_fifo_io_availability;
  wire                toplevel_B_buffer_1_s_stream_fifo_io_push_ready;
  wire                toplevel_B_buffer_1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_B_buffer_1_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_B_buffer_1_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_B_buffer_1_s_stream_fifo_io_availability;
  wire                toplevel_C_buffer_1_q_stream_fifo_io_push_ready;
  wire                toplevel_C_buffer_1_q_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_C_buffer_1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_C_buffer_1_q_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_C_buffer_1_q_stream_fifo_io_availability;
  wire                toplevel_C_buffer_1_s_stream_fifo_io_push_ready;
  wire                toplevel_C_buffer_1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_C_buffer_1_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_C_buffer_1_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_C_buffer_1_s_stream_fifo_io_availability;
  wire                toplevel_conv_1_o_stream_fifo_io_push_ready;
  wire                toplevel_conv_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_conv_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_conv_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_conv_1_o_stream_fifo_io_availability;
  wire                toplevel_conv_state_1_o_stream_fifo_io_push_ready;
  wire                toplevel_conv_state_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_conv_state_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_conv_state_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_conv_state_1_o_stream_fifo_io_availability;
  wire                toplevel_conv_state_1_o_s_stream_fifo_io_push_ready;
  wire                toplevel_conv_state_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_conv_state_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_conv_state_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_conv_state_1_o_s_stream_fifo_io_availability;
  wire                toplevel_conv_state_1_w_stream_fifo_io_push_ready;
  wire                toplevel_conv_state_1_w_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_conv_state_1_w_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_conv_state_1_w_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_conv_state_1_w_stream_fifo_io_availability;
  wire                toplevel_conv_state_1_w_s_stream_fifo_io_push_ready;
  wire                toplevel_conv_state_1_w_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_conv_state_1_w_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_conv_state_1_w_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_conv_state_1_w_s_stream_fifo_io_availability;
  wire                toplevel_conv_state_1_conv_state_stream_fifo_io_push_ready;
  wire                toplevel_conv_state_1_conv_state_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_conv_state_1_conv_state_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_conv_state_1_conv_state_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_conv_state_1_conv_state_stream_fifo_io_availability;
  wire                toplevel_conv_state_1_conv_state_s_stream_fifo_io_push_ready;
  wire                toplevel_conv_state_1_conv_state_s_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_conv_state_1_conv_state_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_conv_state_1_conv_state_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_conv_state_1_conv_state_s_stream_fifo_io_availability;
  wire                toplevel_dAh_1_o_stream_fifo_io_push_ready;
  wire                toplevel_dAh_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_dAh_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dAh_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_dAh_1_o_stream_fifo_io_availability;
  wire                toplevel_dBu_1_o_stream_fifo_io_push_ready;
  wire                toplevel_dBu_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_dBu_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dBu_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_dBu_1_o_stream_fifo_io_availability;
  wire                toplevel_dtA_1_o_stream_fifo_io_push_ready;
  wire                toplevel_dtA_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_dtA_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dtA_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_dtA_1_o_stream_fifo_io_availability;
  wire                toplevel_dtadapt_1_o_stream_fifo_io_push_ready;
  wire                toplevel_dtadapt_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_dtadapt_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dtadapt_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_dtadapt_1_o_stream_fifo_io_availability;
  wire                toplevel_dtadapt_1_o_s_stream_fifo_io_push_ready;
  wire                toplevel_dtadapt_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_dtadapt_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dtadapt_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_dtadapt_1_o_s_stream_fifo_io_availability;
  wire                toplevel_dtadapt_1_o_stream2_fifo_io_push_ready;
  wire                toplevel_dtadapt_1_o_stream2_fifo_io_pop_valid;
  wire       [63:0]   toplevel_dtadapt_1_o_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dtadapt_1_o_stream2_fifo_io_occupancy;
  wire       [3:0]    toplevel_dtadapt_1_o_stream2_fifo_io_availability;
  wire                toplevel_dtadapt_1_o_s_stream2_fifo_io_push_ready;
  wire                toplevel_dtadapt_1_o_s_stream2_fifo_io_pop_valid;
  wire       [7:0]    toplevel_dtadapt_1_o_s_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dtadapt_1_o_s_stream2_fifo_io_occupancy;
  wire       [3:0]    toplevel_dtadapt_1_o_s_stream2_fifo_io_availability;
  wire                toplevel_dtB_quant_1_o_stream_fifo_io_push_ready;
  wire                toplevel_dtB_quant_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_dtB_quant_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dtB_quant_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_dtB_quant_1_o_stream_fifo_io_availability;
  wire                toplevel_dtB_quant_1_o_s_stream_fifo_io_push_ready;
  wire                toplevel_dtB_quant_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_dtB_quant_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_dtB_quant_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_dtB_quant_1_o_s_stream_fifo_io_availability;
  wire                toplevel_exp_quant_1_o_stream_fifo_io_push_ready;
  wire                toplevel_exp_quant_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_exp_quant_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_exp_quant_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_exp_quant_1_o_stream_fifo_io_availability;
  wire                toplevel_exp_quant_1_o_s_stream_fifo_io_push_ready;
  wire                toplevel_exp_quant_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_exp_quant_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_exp_quant_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_exp_quant_1_o_s_stream_fifo_io_availability;
  wire                toplevel_gemm_1_o_stream_fifo_io_push_ready;
  wire                toplevel_gemm_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_gemm_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_gemm_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_gemm_1_o_stream_fifo_io_availability;
  wire                toplevel_gemm_demux_1_dt_stream_fifo_io_push_ready;
  wire                toplevel_gemm_demux_1_dt_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_gemm_demux_1_dt_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_gemm_demux_1_dt_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_gemm_demux_1_dt_stream_fifo_io_availability;
  wire                toplevel_gemm_demux_1_xBC_stream_fifo_io_push_ready;
  wire                toplevel_gemm_demux_1_xBC_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_gemm_demux_1_xBC_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_gemm_demux_1_xBC_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_gemm_demux_1_xBC_stream_fifo_io_availability;
  wire                toplevel_gemm_demux_1_z_stream_fifo_io_push_ready;
  wire                toplevel_gemm_demux_1_z_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_gemm_demux_1_z_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_gemm_demux_1_z_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_gemm_demux_1_z_stream_fifo_io_availability;
  wire                toplevel_gemm_demux_1_out_stream_fifo_io_push_ready;
  wire                toplevel_gemm_demux_1_out_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_gemm_demux_1_out_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_gemm_demux_1_out_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_gemm_demux_1_out_stream_fifo_io_availability;
  wire                toplevel_gemm_mux_1_q_stream_fifo_io_push_ready;
  wire                toplevel_gemm_mux_1_q_stream_fifo_io_pop_valid;
  wire       [31:0]   toplevel_gemm_mux_1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_gemm_mux_1_q_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_gemm_mux_1_q_stream_fifo_io_availability;
  wire                toplevel_gemm_mux_1_s_stream_fifo_io_push_ready;
  wire                toplevel_gemm_mux_1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_gemm_mux_1_s_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_gemm_mux_1_s_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_gemm_mux_1_s_stream_fifo_io_availability;
  wire                toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_push_ready;
  wire                toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_availability;
  wire                toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_push_ready;
  wire                toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_availability;
  wire                toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_push_ready;
  wire                toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_availability;
  wire                toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_push_ready;
  wire                toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_availability;
  wire                toplevel_ht_state_1_ht_out_stream_fifo_io_push_ready;
  wire                toplevel_ht_state_1_ht_out_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_ht_state_1_ht_out_stream_fifo_io_pop_payload_data;
  wire       [6:0]    toplevel_ht_state_1_ht_out_stream_fifo_io_occupancy;
  wire       [6:0]    toplevel_ht_state_1_ht_out_stream_fifo_io_availability;
  wire                toplevel_ht_state_1_ht_out_s_stream_fifo_io_push_ready;
  wire                toplevel_ht_state_1_ht_out_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_ht_state_1_ht_out_s_stream_fifo_io_pop_payload_data;
  wire       [6:0]    toplevel_ht_state_1_ht_out_s_stream_fifo_io_occupancy;
  wire       [6:0]    toplevel_ht_state_1_ht_out_s_stream_fifo_io_availability;
  wire                toplevel_ht_state_1_state_out_stream_fifo_io_push_ready;
  wire                toplevel_ht_state_1_state_out_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_ht_state_1_state_out_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_ht_state_1_state_out_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_ht_state_1_state_out_stream_fifo_io_availability;
  wire                toplevel_ht_state_1_state_out_s_stream_fifo_io_push_ready;
  wire                toplevel_ht_state_1_state_out_s_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_ht_state_1_state_out_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_ht_state_1_state_out_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_ht_state_1_state_out_s_stream_fifo_io_availability;
  wire                toplevel_htC_quant_1_o_q_stream_fifo_io_push_ready;
  wire                toplevel_htC_quant_1_o_q_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_htC_quant_1_o_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_htC_quant_1_o_q_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_htC_quant_1_o_q_stream_fifo_io_availability;
  wire                toplevel_htC_quant_1_o_s_stream_fifo_io_push_ready;
  wire                toplevel_htC_quant_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_htC_quant_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_htC_quant_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_htC_quant_1_o_s_stream_fifo_io_availability;
  wire                toplevel_quant_conv_1_o_stream_fifo_io_push_ready;
  wire                toplevel_quant_conv_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_quant_conv_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_quant_conv_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_quant_conv_1_o_stream_fifo_io_availability;
  wire                toplevel_quant_conv_1_o_s_stream_fifo_io_push_ready;
  wire                toplevel_quant_conv_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_quant_conv_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_quant_conv_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_quant_conv_1_o_s_stream_fifo_io_availability;
  wire                toplevel_residual_1_res_o_stream_fifo_io_push_ready;
  wire                toplevel_residual_1_res_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_residual_1_res_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_residual_1_res_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_residual_1_res_o_stream_fifo_io_availability;
  wire                toplevel_residual_1_y_stream_fifo_io_push_ready;
  wire                toplevel_residual_1_y_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_residual_1_y_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_residual_1_y_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_residual_1_y_stream_fifo_io_availability;
  wire                toplevel_rms_quant_1_xlnq_stream_fifo_io_push_ready;
  wire                toplevel_rms_quant_1_xlnq_stream_fifo_io_pop_valid;
  wire       [31:0]   toplevel_rms_quant_1_xlnq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_rms_quant_1_xlnq_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_rms_quant_1_xlnq_stream_fifo_io_availability;
  wire                toplevel_rms_quant_1_xlns_stream_fifo_io_push_ready;
  wire                toplevel_rms_quant_1_xlns_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_rms_quant_1_xlns_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_rms_quant_1_xlns_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_rms_quant_1_xlns_stream_fifo_io_availability;
  wire                toplevel_rms_quant_2_xlnq_stream_fifo_io_push_ready;
  wire                toplevel_rms_quant_2_xlnq_stream_fifo_io_pop_valid;
  wire       [31:0]   toplevel_rms_quant_2_xlnq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_rms_quant_2_xlnq_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_rms_quant_2_xlnq_stream_fifo_io_availability;
  wire                toplevel_rms_quant_2_xlns_stream_fifo_io_push_ready;
  wire                toplevel_rms_quant_2_xlns_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_rms_quant_2_xlns_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_rms_quant_2_xlns_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_rms_quant_2_xlns_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_x_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_x_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_silu_demux_1_x_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_x_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_x_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_x_s_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_x_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_silu_demux_1_x_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_x_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_x_s_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_x_stream2_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_x_stream2_fifo_io_pop_valid;
  wire       [63:0]   toplevel_silu_demux_1_x_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_x_stream2_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_x_stream2_fifo_io_availability;
  wire                toplevel_silu_demux_1_x_s_stream2_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_x_s_stream2_fifo_io_pop_valid;
  wire       [7:0]    toplevel_silu_demux_1_x_s_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_x_s_stream2_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_x_s_stream2_fifo_io_availability;
  wire                toplevel_silu_demux_1_B_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_B_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_silu_demux_1_B_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_B_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_B_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_B_s_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_B_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_silu_demux_1_B_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_B_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_B_s_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_C_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_C_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_silu_demux_1_C_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_C_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_C_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_C_s_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_C_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_silu_demux_1_C_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_C_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_C_s_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_z_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_z_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_silu_demux_1_z_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_z_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_z_stream_fifo_io_availability;
  wire                toplevel_silu_demux_1_z_s_stream_fifo_io_push_ready;
  wire                toplevel_silu_demux_1_z_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_silu_demux_1_z_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_demux_1_z_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_demux_1_z_s_stream_fifo_io_availability;
  wire                toplevel_silu_mux_1_silu_stream_fifo_io_push_ready;
  wire                toplevel_silu_mux_1_silu_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_silu_mux_1_silu_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_mux_1_silu_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_mux_1_silu_stream_fifo_io_availability;
  wire                toplevel_silu_quant_1_out_stream_fifo_io_push_ready;
  wire                toplevel_silu_quant_1_out_stream_fifo_io_pop_valid;
  wire       [63:0]   toplevel_silu_quant_1_out_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_quant_1_out_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_quant_1_out_stream_fifo_io_availability;
  wire                toplevel_silu_quant_1_out_s_stream_fifo_io_push_ready;
  wire                toplevel_silu_quant_1_out_s_stream_fifo_io_pop_valid;
  wire       [7:0]    toplevel_silu_quant_1_out_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_silu_quant_1_out_s_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_silu_quant_1_out_s_stream_fifo_io_availability;
  wire                toplevel_ud_1_o_stream_fifo_io_push_ready;
  wire                toplevel_ud_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_ud_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_ud_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_ud_1_o_stream_fifo_io_availability;
  wire                toplevel_yz_1_o_stream_fifo_io_push_ready;
  wire                toplevel_yz_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_yz_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_yz_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_yz_1_o_stream_fifo_io_availability;

  B_BUFFER_wrapper B_buffer_1 (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (signals_I_L_BEGIN[31:0]                                       ), //i
    .signals_I_L_CLOSE  (signals_I_L_CLOSE[31:0]                                       ), //i
    .signals_I_MEMORY_X (signals_I_MEMORY_X[63:0]                                      ), //i
    .signals_I_MEMORY_W (signals_I_MEMORY_W[63:0]                                      ), //i
    .signals_I_MEMORY_Y (signals_I_MEMORY_Y[63:0]                                      ), //i
    .signals_I_MEMORY_C (signals_I_MEMORY_C[63:0]                                      ), //i
    .signals_I_MEMORY_H (signals_I_MEMORY_H[63:0]                                      ), //i
    .signals_I_POS      (signals_I_POS[11:0]                                           ), //i
    .signals_I_T        (signals_I_T                                                   ), //i
    .signals_O_L_BEGIN  (B_buffer_1_signals_O_L_BEGIN[31:0]                            ), //o
    .signals_O_L_CLOSE  (B_buffer_1_signals_O_L_CLOSE[31:0]                            ), //o
    .signals_O_MEMORY_X (B_buffer_1_signals_O_MEMORY_X[63:0]                           ), //o
    .signals_O_MEMORY_W (B_buffer_1_signals_O_MEMORY_W[63:0]                           ), //o
    .signals_O_MEMORY_Y (B_buffer_1_signals_O_MEMORY_Y[63:0]                           ), //o
    .signals_O_MEMORY_C (B_buffer_1_signals_O_MEMORY_C[63:0]                           ), //o
    .signals_O_MEMORY_H (B_buffer_1_signals_O_MEMORY_H[63:0]                           ), //o
    .signals_O_POS      (B_buffer_1_signals_O_POS[11:0]                                ), //o
    .signals_O_T        (B_buffer_1_signals_O_T                                        ), //o
    .i_stream_TVALID    (toplevel_silu_demux_1_B_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (B_buffer_1_i_stream_TREADY                                    ), //o
    .i_stream_TDATA     (toplevel_silu_demux_1_B_stream_fifo_io_pop_payload_data[63:0] ), //i
    .i_s_stream_TVALID  (toplevel_silu_demux_1_B_s_stream_fifo_io_pop_valid            ), //i
    .i_s_stream_TREADY  (B_buffer_1_i_s_stream_TREADY                                  ), //o
    .i_s_stream_TDATA   (toplevel_silu_demux_1_B_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .q_stream_TVALID    (B_buffer_1_q_stream_TVALID                                    ), //o
    .q_stream_TREADY    (toplevel_B_buffer_1_q_stream_fifo_io_push_ready               ), //i
    .q_stream_TDATA     (B_buffer_1_q_stream_TDATA[63:0]                               ), //o
    .s_stream_TVALID    (B_buffer_1_s_stream_TVALID                                    ), //o
    .s_stream_TREADY    (toplevel_B_buffer_1_s_stream_fifo_io_push_ready               ), //i
    .s_stream_TDATA     (B_buffer_1_s_stream_TDATA[7:0]                                )  //o
  );
  C_BUFFER_wrapper C_buffer_1 (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (B_buffer_1_signals_O_L_BEGIN[31:0]                            ), //i
    .signals_I_L_CLOSE  (B_buffer_1_signals_O_L_CLOSE[31:0]                            ), //i
    .signals_I_MEMORY_X (B_buffer_1_signals_O_MEMORY_X[63:0]                           ), //i
    .signals_I_MEMORY_W (B_buffer_1_signals_O_MEMORY_W[63:0]                           ), //i
    .signals_I_MEMORY_Y (B_buffer_1_signals_O_MEMORY_Y[63:0]                           ), //i
    .signals_I_MEMORY_C (B_buffer_1_signals_O_MEMORY_C[63:0]                           ), //i
    .signals_I_MEMORY_H (B_buffer_1_signals_O_MEMORY_H[63:0]                           ), //i
    .signals_I_POS      (B_buffer_1_signals_O_POS[11:0]                                ), //i
    .signals_I_T        (B_buffer_1_signals_O_T                                        ), //i
    .signals_O_L_BEGIN  (C_buffer_1_signals_O_L_BEGIN[31:0]                            ), //o
    .signals_O_L_CLOSE  (C_buffer_1_signals_O_L_CLOSE[31:0]                            ), //o
    .signals_O_MEMORY_X (C_buffer_1_signals_O_MEMORY_X[63:0]                           ), //o
    .signals_O_MEMORY_W (C_buffer_1_signals_O_MEMORY_W[63:0]                           ), //o
    .signals_O_MEMORY_Y (C_buffer_1_signals_O_MEMORY_Y[63:0]                           ), //o
    .signals_O_MEMORY_C (C_buffer_1_signals_O_MEMORY_C[63:0]                           ), //o
    .signals_O_MEMORY_H (C_buffer_1_signals_O_MEMORY_H[63:0]                           ), //o
    .signals_O_POS      (C_buffer_1_signals_O_POS[11:0]                                ), //o
    .signals_O_T        (C_buffer_1_signals_O_T                                        ), //o
    .i_stream_TVALID    (toplevel_silu_demux_1_C_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (C_buffer_1_i_stream_TREADY                                    ), //o
    .i_stream_TDATA     (toplevel_silu_demux_1_C_stream_fifo_io_pop_payload_data[63:0] ), //i
    .i_s_stream_TVALID  (toplevel_silu_demux_1_C_s_stream_fifo_io_pop_valid            ), //i
    .i_s_stream_TREADY  (C_buffer_1_i_s_stream_TREADY                                  ), //o
    .i_s_stream_TDATA   (toplevel_silu_demux_1_C_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .q_stream_TVALID    (C_buffer_1_q_stream_TVALID                                    ), //o
    .q_stream_TREADY    (toplevel_C_buffer_1_q_stream_fifo_io_push_ready               ), //i
    .q_stream_TDATA     (C_buffer_1_q_stream_TDATA[63:0]                               ), //o
    .s_stream_TVALID    (C_buffer_1_s_stream_TVALID                                    ), //o
    .s_stream_TREADY    (toplevel_C_buffer_1_s_stream_fifo_io_push_ready               ), //i
    .s_stream_TDATA     (C_buffer_1_s_stream_TDATA[7:0]                                )  //o
  );
  CONV_wrapper conv_1 (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (C_buffer_1_signals_O_L_BEGIN[31:0]                            ), //i
    .signals_I_L_CLOSE  (C_buffer_1_signals_O_L_CLOSE[31:0]                            ), //i
    .signals_I_MEMORY_X (C_buffer_1_signals_O_MEMORY_X[63:0]                           ), //i
    .signals_I_MEMORY_W (C_buffer_1_signals_O_MEMORY_W[63:0]                           ), //i
    .signals_I_MEMORY_Y (C_buffer_1_signals_O_MEMORY_Y[63:0]                           ), //i
    .signals_I_MEMORY_C (C_buffer_1_signals_O_MEMORY_C[63:0]                           ), //i
    .signals_I_MEMORY_H (C_buffer_1_signals_O_MEMORY_H[63:0]                           ), //i
    .signals_I_POS      (C_buffer_1_signals_O_POS[11:0]                                ), //i
    .signals_I_T        (C_buffer_1_signals_O_T                                        ), //i
    .signals_O_L_BEGIN  (conv_1_signals_O_L_BEGIN[31:0]                                ), //o
    .signals_O_L_CLOSE  (conv_1_signals_O_L_CLOSE[31:0]                                ), //o
    .signals_O_MEMORY_X (conv_1_signals_O_MEMORY_X[63:0]                               ), //o
    .signals_O_MEMORY_W (conv_1_signals_O_MEMORY_W[63:0]                               ), //o
    .signals_O_MEMORY_Y (conv_1_signals_O_MEMORY_Y[63:0]                               ), //o
    .signals_O_MEMORY_C (conv_1_signals_O_MEMORY_C[63:0]                               ), //o
    .signals_O_MEMORY_H (conv_1_signals_O_MEMORY_H[63:0]                               ), //o
    .signals_O_POS      (conv_1_signals_O_POS[11:0]                                    ), //o
    .signals_O_T        (conv_1_signals_O_T                                            ), //o
    .i_stream_TVALID    (toplevel_conv_state_1_o_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (conv_1_i_stream_TREADY                                        ), //o
    .i_stream_TDATA     (toplevel_conv_state_1_o_stream_fifo_io_pop_payload_data[63:0] ), //i
    .s_stream_TVALID    (toplevel_conv_state_1_o_s_stream_fifo_io_pop_valid            ), //i
    .s_stream_TREADY    (conv_1_s_stream_TREADY                                        ), //o
    .s_stream_TDATA     (toplevel_conv_state_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .w_stream_TVALID    (toplevel_conv_state_1_w_stream_fifo_io_pop_valid              ), //i
    .w_stream_TREADY    (conv_1_w_stream_TREADY                                        ), //o
    .w_stream_TDATA     (toplevel_conv_state_1_w_stream_fifo_io_pop_payload_data[63:0] ), //i
    .w_s_stream_TVALID  (toplevel_conv_state_1_w_s_stream_fifo_io_pop_valid            ), //i
    .w_s_stream_TREADY  (conv_1_w_s_stream_TREADY                                      ), //o
    .w_s_stream_TDATA   (toplevel_conv_state_1_w_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (conv_1_o_stream_TVALID                                        ), //o
    .o_stream_TREADY    (toplevel_conv_1_o_stream_fifo_io_push_ready                   ), //i
    .o_stream_TDATA     (conv_1_o_stream_TDATA[255:0]                                  )  //o
  );
  CONV_STATE_wrapper conv_state_1 (
    .resetn                     (resetn                                                        ), //i
    .clk                        (clk                                                           ), //i
    .signals_I_L_BEGIN          (conv_1_signals_O_L_BEGIN[31:0]                                ), //i
    .signals_I_L_CLOSE          (conv_1_signals_O_L_CLOSE[31:0]                                ), //i
    .signals_I_MEMORY_X         (conv_1_signals_O_MEMORY_X[63:0]                               ), //i
    .signals_I_MEMORY_W         (conv_1_signals_O_MEMORY_W[63:0]                               ), //i
    .signals_I_MEMORY_Y         (conv_1_signals_O_MEMORY_Y[63:0]                               ), //i
    .signals_I_MEMORY_C         (conv_1_signals_O_MEMORY_C[63:0]                               ), //i
    .signals_I_MEMORY_H         (conv_1_signals_O_MEMORY_H[63:0]                               ), //i
    .signals_I_POS              (conv_1_signals_O_POS[11:0]                                    ), //i
    .signals_I_T                (conv_1_signals_O_T                                            ), //i
    .signals_O_L_BEGIN          (conv_state_1_signals_O_L_BEGIN[31:0]                          ), //o
    .signals_O_L_CLOSE          (conv_state_1_signals_O_L_CLOSE[31:0]                          ), //o
    .signals_O_MEMORY_X         (conv_state_1_signals_O_MEMORY_X[63:0]                         ), //o
    .signals_O_MEMORY_W         (conv_state_1_signals_O_MEMORY_W[63:0]                         ), //o
    .signals_O_MEMORY_Y         (conv_state_1_signals_O_MEMORY_Y[63:0]                         ), //o
    .signals_O_MEMORY_C         (conv_state_1_signals_O_MEMORY_C[63:0]                         ), //o
    .signals_O_MEMORY_H         (conv_state_1_signals_O_MEMORY_H[63:0]                         ), //o
    .signals_O_POS              (conv_state_1_signals_O_POS[11:0]                              ), //o
    .signals_O_T                (conv_state_1_signals_O_T                                      ), //o
    .conv_stream_TVALID         (cq_stream_fifo_io_pop_valid                                   ), //i
    .conv_stream_TREADY         (conv_state_1_conv_stream_TREADY                               ), //o
    .conv_stream_TDATA          (cq_stream_fifo_io_pop_payload_data[255:0]                     ), //i
    .conv_s_stream_TVALID       (cs_stream_fifo_io_pop_valid                                   ), //i
    .conv_s_stream_TREADY       (conv_state_1_conv_s_stream_TREADY                             ), //o
    .conv_s_stream_TDATA        (cs_stream_fifo_io_pop_payload_data[255:0]                     ), //i
    .xBC_stream_TVALID          (toplevel_quant_conv_1_o_stream_fifo_io_pop_valid              ), //i
    .xBC_stream_TREADY          (conv_state_1_xBC_stream_TREADY                                ), //o
    .xBC_stream_TDATA           (toplevel_quant_conv_1_o_stream_fifo_io_pop_payload_data[63:0] ), //i
    .xBC_s_stream_TVALID        (toplevel_quant_conv_1_o_s_stream_fifo_io_pop_valid            ), //i
    .xBC_s_stream_TREADY        (conv_state_1_xBC_s_stream_TREADY                              ), //o
    .xBC_s_stream_TDATA         (toplevel_quant_conv_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .w_stream_TVALID            (conv_state_1_w_stream_TVALID                                  ), //o
    .w_stream_TREADY            (toplevel_conv_state_1_w_stream_fifo_io_push_ready             ), //i
    .w_stream_TDATA             (conv_state_1_w_stream_TDATA[63:0]                             ), //o
    .w_s_stream_TVALID          (conv_state_1_w_s_stream_TVALID                                ), //o
    .w_s_stream_TREADY          (toplevel_conv_state_1_w_s_stream_fifo_io_push_ready           ), //i
    .w_s_stream_TDATA           (conv_state_1_w_s_stream_TDATA[7:0]                            ), //o
    .o_stream_TVALID            (conv_state_1_o_stream_TVALID                                  ), //o
    .o_stream_TREADY            (toplevel_conv_state_1_o_stream_fifo_io_push_ready             ), //i
    .o_stream_TDATA             (conv_state_1_o_stream_TDATA[63:0]                             ), //o
    .o_s_stream_TVALID          (conv_state_1_o_s_stream_TVALID                                ), //o
    .o_s_stream_TREADY          (toplevel_conv_state_1_o_s_stream_fifo_io_push_ready           ), //i
    .o_s_stream_TDATA           (conv_state_1_o_s_stream_TDATA[7:0]                            ), //o
    .conv_state_stream_TVALID   (conv_state_1_conv_state_stream_TVALID                         ), //o
    .conv_state_stream_TREADY   (toplevel_conv_state_1_conv_state_stream_fifo_io_push_ready    ), //i
    .conv_state_stream_TDATA    (conv_state_1_conv_state_stream_TDATA[255:0]                   ), //o
    .conv_state_s_stream_TVALID (conv_state_1_conv_state_s_stream_TVALID                       ), //o
    .conv_state_s_stream_TREADY (toplevel_conv_state_1_conv_state_s_stream_fifo_io_push_ready  ), //i
    .conv_state_s_stream_TDATA  (conv_state_1_conv_state_s_stream_TDATA[255:0]                 )  //o
  );
  DAH_wrapper dAh_1 (
    .resetn             (resetn                                                           ), //i
    .clk                (clk                                                              ), //i
    .signals_I_L_BEGIN  (conv_state_1_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE  (conv_state_1_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X (conv_state_1_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W (conv_state_1_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y (conv_state_1_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C (conv_state_1_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H (conv_state_1_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS      (conv_state_1_signals_O_POS[11:0]                                 ), //i
    .signals_I_T        (conv_state_1_signals_O_T                                         ), //i
    .signals_O_L_BEGIN  (dAh_1_signals_O_L_BEGIN[31:0]                                    ), //o
    .signals_O_L_CLOSE  (dAh_1_signals_O_L_CLOSE[31:0]                                    ), //o
    .signals_O_MEMORY_X (dAh_1_signals_O_MEMORY_X[63:0]                                   ), //o
    .signals_O_MEMORY_W (dAh_1_signals_O_MEMORY_W[63:0]                                   ), //o
    .signals_O_MEMORY_Y (dAh_1_signals_O_MEMORY_Y[63:0]                                   ), //o
    .signals_O_MEMORY_C (dAh_1_signals_O_MEMORY_C[63:0]                                   ), //o
    .signals_O_MEMORY_H (dAh_1_signals_O_MEMORY_H[63:0]                                   ), //o
    .signals_O_POS      (dAh_1_signals_O_POS[11:0]                                        ), //o
    .signals_O_T        (dAh_1_signals_O_T                                                ), //o
    .dA_stream_TVALID   (toplevel_exp_quant_1_o_stream_fifo_io_pop_valid                  ), //i
    .dA_stream_TREADY   (dAh_1_dA_stream_TREADY                                           ), //o
    .dA_stream_TDATA    (toplevel_exp_quant_1_o_stream_fifo_io_pop_payload_data[63:0]     ), //i
    .dA_s_stream_TVALID (toplevel_exp_quant_1_o_s_stream_fifo_io_pop_valid                ), //i
    .dA_s_stream_TREADY (dAh_1_dA_s_stream_TREADY                                         ), //o
    .dA_s_stream_TDATA  (toplevel_exp_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]    ), //i
    .ht_stream_TVALID   (toplevel_ht_state_1_ht_out_stream_fifo_io_pop_valid              ), //i
    .ht_stream_TREADY   (dAh_1_ht_stream_TREADY                                           ), //o
    .ht_stream_TDATA    (toplevel_ht_state_1_ht_out_stream_fifo_io_pop_payload_data[63:0] ), //i
    .ht_s_stream_TVALID (toplevel_ht_state_1_ht_out_s_stream_fifo_io_pop_valid            ), //i
    .ht_s_stream_TREADY (dAh_1_ht_s_stream_TREADY                                         ), //o
    .ht_s_stream_TDATA  (toplevel_ht_state_1_ht_out_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (dAh_1_o_stream_TVALID                                            ), //o
    .o_stream_TREADY    (toplevel_dAh_1_o_stream_fifo_io_push_ready                       ), //i
    .o_stream_TDATA     (dAh_1_o_stream_TDATA[255:0]                                      )  //o
  );
  DBU_wrapper dBu_1 (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (dAh_1_signals_O_L_BEGIN[31:0]                                 ), //i
    .signals_I_L_CLOSE  (dAh_1_signals_O_L_CLOSE[31:0]                                 ), //i
    .signals_I_MEMORY_X (dAh_1_signals_O_MEMORY_X[63:0]                                ), //i
    .signals_I_MEMORY_W (dAh_1_signals_O_MEMORY_W[63:0]                                ), //i
    .signals_I_MEMORY_Y (dAh_1_signals_O_MEMORY_Y[63:0]                                ), //i
    .signals_I_MEMORY_C (dAh_1_signals_O_MEMORY_C[63:0]                                ), //i
    .signals_I_MEMORY_H (dAh_1_signals_O_MEMORY_H[63:0]                                ), //i
    .signals_I_POS      (dAh_1_signals_O_POS[11:0]                                     ), //i
    .signals_I_T        (dAh_1_signals_O_T                                             ), //i
    .signals_O_L_BEGIN  (dBu_1_signals_O_L_BEGIN[31:0]                                 ), //o
    .signals_O_L_CLOSE  (dBu_1_signals_O_L_CLOSE[31:0]                                 ), //o
    .signals_O_MEMORY_X (dBu_1_signals_O_MEMORY_X[63:0]                                ), //o
    .signals_O_MEMORY_W (dBu_1_signals_O_MEMORY_W[63:0]                                ), //o
    .signals_O_MEMORY_Y (dBu_1_signals_O_MEMORY_Y[63:0]                                ), //o
    .signals_O_MEMORY_C (dBu_1_signals_O_MEMORY_C[63:0]                                ), //o
    .signals_O_MEMORY_H (dBu_1_signals_O_MEMORY_H[63:0]                                ), //o
    .signals_O_POS      (dBu_1_signals_O_POS[11:0]                                     ), //o
    .signals_O_T        (dBu_1_signals_O_T                                             ), //o
    .dB_stream_TVALID   (toplevel_dtB_quant_1_o_stream_fifo_io_pop_valid               ), //i
    .dB_stream_TREADY   (dBu_1_dB_stream_TREADY                                        ), //o
    .dB_stream_TDATA    (toplevel_dtB_quant_1_o_stream_fifo_io_pop_payload_data[63:0]  ), //i
    .dB_s_stream_TVALID (toplevel_dtB_quant_1_o_s_stream_fifo_io_pop_valid             ), //i
    .dB_s_stream_TREADY (dBu_1_dB_s_stream_TREADY                                      ), //o
    .dB_s_stream_TDATA  (toplevel_dtB_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .u_stream_TVALID    (toplevel_silu_demux_1_x_stream_fifo_io_pop_valid              ), //i
    .u_stream_TREADY    (dBu_1_u_stream_TREADY                                         ), //o
    .u_stream_TDATA     (toplevel_silu_demux_1_x_stream_fifo_io_pop_payload_data[63:0] ), //i
    .u_s_stream_TVALID  (toplevel_silu_demux_1_x_s_stream_fifo_io_pop_valid            ), //i
    .u_s_stream_TREADY  (dBu_1_u_s_stream_TREADY                                       ), //o
    .u_s_stream_TDATA   (toplevel_silu_demux_1_x_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (dBu_1_o_stream_TVALID                                         ), //o
    .o_stream_TREADY    (toplevel_dBu_1_o_stream_fifo_io_push_ready                    ), //i
    .o_stream_TDATA     (dBu_1_o_stream_TDATA[255:0]                                   )  //o
  );
  DTA_wrapper dtA_1 (
    .resetn             (resetn                                                     ), //i
    .clk                (clk                                                        ), //i
    .signals_I_L_BEGIN  (dBu_1_signals_O_L_BEGIN[31:0]                              ), //i
    .signals_I_L_CLOSE  (dBu_1_signals_O_L_CLOSE[31:0]                              ), //i
    .signals_I_MEMORY_X (dBu_1_signals_O_MEMORY_X[63:0]                             ), //i
    .signals_I_MEMORY_W (dBu_1_signals_O_MEMORY_W[63:0]                             ), //i
    .signals_I_MEMORY_Y (dBu_1_signals_O_MEMORY_Y[63:0]                             ), //i
    .signals_I_MEMORY_C (dBu_1_signals_O_MEMORY_C[63:0]                             ), //i
    .signals_I_MEMORY_H (dBu_1_signals_O_MEMORY_H[63:0]                             ), //i
    .signals_I_POS      (dBu_1_signals_O_POS[11:0]                                  ), //i
    .signals_I_T        (dBu_1_signals_O_T                                          ), //i
    .signals_O_L_BEGIN  (dtA_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE  (dtA_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X (dtA_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W (dtA_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y (dtA_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C (dtA_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H (dtA_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS      (dtA_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T        (dtA_1_signals_O_T                                          ), //o
    .i_stream_TVALID    (toplevel_dtadapt_1_o_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (dtA_1_i_stream_TREADY                                      ), //o
    .i_stream_TDATA     (toplevel_dtadapt_1_o_stream_fifo_io_pop_payload_data[63:0] ), //i
    .s_stream_TVALID    (toplevel_dtadapt_1_o_s_stream_fifo_io_pop_valid            ), //i
    .s_stream_TREADY    (dtA_1_s_stream_TREADY                                      ), //o
    .s_stream_TDATA     (toplevel_dtadapt_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (dtA_1_o_stream_TVALID                                      ), //o
    .o_stream_TREADY    (toplevel_dtA_1_o_stream_fifo_io_push_ready                 ), //i
    .o_stream_TDATA     (dtA_1_o_stream_TDATA[255:0]                                )  //o
  );
  DTADAPT_wrapper dtadapt_1 (
    .resetn             (resetn                                                         ), //i
    .clk                (clk                                                            ), //i
    .signals_I_L_BEGIN  (dtA_1_signals_O_L_BEGIN[31:0]                                  ), //i
    .signals_I_L_CLOSE  (dtA_1_signals_O_L_CLOSE[31:0]                                  ), //i
    .signals_I_MEMORY_X (dtA_1_signals_O_MEMORY_X[63:0]                                 ), //i
    .signals_I_MEMORY_W (dtA_1_signals_O_MEMORY_W[63:0]                                 ), //i
    .signals_I_MEMORY_Y (dtA_1_signals_O_MEMORY_Y[63:0]                                 ), //i
    .signals_I_MEMORY_C (dtA_1_signals_O_MEMORY_C[63:0]                                 ), //i
    .signals_I_MEMORY_H (dtA_1_signals_O_MEMORY_H[63:0]                                 ), //i
    .signals_I_POS      (dtA_1_signals_O_POS[11:0]                                      ), //i
    .signals_I_T        (dtA_1_signals_O_T                                              ), //i
    .signals_O_L_BEGIN  (dtadapt_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE  (dtadapt_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X (dtadapt_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W (dtadapt_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y (dtadapt_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C (dtadapt_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H (dtadapt_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS      (dtadapt_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T        (dtadapt_1_signals_O_T                                          ), //o
    .i_stream_TVALID    (toplevel_gemm_demux_1_dt_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (dtadapt_1_i_stream_TREADY                                      ), //o
    .i_stream_TDATA     (toplevel_gemm_demux_1_dt_stream_fifo_io_pop_payload_data[255:0]), //i
    .o_stream_TVALID    (dtadapt_1_o_stream_TVALID                                      ), //o
    .o_stream_TREADY    (toplevel_dtadapt_1_o_stream_fifo_io_push_ready                 ), //i
    .o_stream_TDATA     (dtadapt_1_o_stream_TDATA[63:0]                                 ), //o
    .o_s_stream_TVALID  (dtadapt_1_o_s_stream_TVALID                                    ), //o
    .o_s_stream_TREADY  (toplevel_dtadapt_1_o_s_stream_fifo_io_push_ready               ), //i
    .o_s_stream_TDATA   (dtadapt_1_o_s_stream_TDATA[7:0]                                ), //o
    .o_stream2_TVALID   (dtadapt_1_o_stream2_TVALID                                     ), //o
    .o_stream2_TREADY   (toplevel_dtadapt_1_o_stream2_fifo_io_push_ready                ), //i
    .o_stream2_TDATA    (dtadapt_1_o_stream2_TDATA[63:0]                                ), //o
    .o_s_stream2_TVALID (dtadapt_1_o_s_stream2_TVALID                                   ), //o
    .o_s_stream2_TREADY (toplevel_dtadapt_1_o_s_stream2_fifo_io_push_ready              ), //i
    .o_s_stream2_TDATA  (dtadapt_1_o_s_stream2_TDATA[7:0]                               )  //o
  );
  DTB_QUANT_wrapper dtB_quant_1 (
    .resetn             (resetn                                                      ), //i
    .clk                (clk                                                         ), //i
    .signals_I_L_BEGIN  (dtadapt_1_signals_O_L_BEGIN[31:0]                           ), //i
    .signals_I_L_CLOSE  (dtadapt_1_signals_O_L_CLOSE[31:0]                           ), //i
    .signals_I_MEMORY_X (dtadapt_1_signals_O_MEMORY_X[63:0]                          ), //i
    .signals_I_MEMORY_W (dtadapt_1_signals_O_MEMORY_W[63:0]                          ), //i
    .signals_I_MEMORY_Y (dtadapt_1_signals_O_MEMORY_Y[63:0]                          ), //i
    .signals_I_MEMORY_C (dtadapt_1_signals_O_MEMORY_C[63:0]                          ), //i
    .signals_I_MEMORY_H (dtadapt_1_signals_O_MEMORY_H[63:0]                          ), //i
    .signals_I_POS      (dtadapt_1_signals_O_POS[11:0]                               ), //i
    .signals_I_T        (dtadapt_1_signals_O_T                                       ), //i
    .signals_O_L_BEGIN  (dtB_quant_1_signals_O_L_BEGIN[31:0]                         ), //o
    .signals_O_L_CLOSE  (dtB_quant_1_signals_O_L_CLOSE[31:0]                         ), //o
    .signals_O_MEMORY_X (dtB_quant_1_signals_O_MEMORY_X[63:0]                        ), //o
    .signals_O_MEMORY_W (dtB_quant_1_signals_O_MEMORY_W[63:0]                        ), //o
    .signals_O_MEMORY_Y (dtB_quant_1_signals_O_MEMORY_Y[63:0]                        ), //o
    .signals_O_MEMORY_C (dtB_quant_1_signals_O_MEMORY_C[63:0]                        ), //o
    .signals_O_MEMORY_H (dtB_quant_1_signals_O_MEMORY_H[63:0]                        ), //o
    .signals_O_POS      (dtB_quant_1_signals_O_POS[11:0]                             ), //o
    .signals_O_T        (dtB_quant_1_signals_O_T                                     ), //o
    .dt_stream_TVALID   (toplevel_dtadapt_1_o_stream2_fifo_io_pop_valid              ), //i
    .dt_stream_TREADY   (dtB_quant_1_dt_stream_TREADY                                ), //o
    .dt_stream_TDATA    (toplevel_dtadapt_1_o_stream2_fifo_io_pop_payload_data[63:0] ), //i
    .dt_s_stream_TVALID (toplevel_dtadapt_1_o_s_stream2_fifo_io_pop_valid            ), //i
    .dt_s_stream_TREADY (dtB_quant_1_dt_s_stream_TREADY                              ), //o
    .dt_s_stream_TDATA  (toplevel_dtadapt_1_o_s_stream2_fifo_io_pop_payload_data[7:0]), //i
    .B_stream_TVALID    (toplevel_B_buffer_1_q_stream_fifo_io_pop_valid              ), //i
    .B_stream_TREADY    (dtB_quant_1_B_stream_TREADY                                 ), //o
    .B_stream_TDATA     (toplevel_B_buffer_1_q_stream_fifo_io_pop_payload_data[63:0] ), //i
    .B_s_stream_TVALID  (toplevel_B_buffer_1_s_stream_fifo_io_pop_valid              ), //i
    .B_s_stream_TREADY  (dtB_quant_1_B_s_stream_TREADY                               ), //o
    .B_s_stream_TDATA   (toplevel_B_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]  ), //i
    .o_stream_TVALID    (dtB_quant_1_o_stream_TVALID                                 ), //o
    .o_stream_TREADY    (toplevel_dtB_quant_1_o_stream_fifo_io_push_ready            ), //i
    .o_stream_TDATA     (dtB_quant_1_o_stream_TDATA[63:0]                            ), //o
    .o_s_stream_TVALID  (dtB_quant_1_o_s_stream_TVALID                               ), //o
    .o_s_stream_TREADY  (toplevel_dtB_quant_1_o_s_stream_fifo_io_push_ready          ), //i
    .o_s_stream_TDATA   (dtB_quant_1_o_s_stream_TDATA[7:0]                           )  //o
  );
  EXP_QUANT_wrapper exp_quant_1 (
    .resetn             (resetn                                                 ), //i
    .clk                (clk                                                    ), //i
    .signals_I_L_BEGIN  (dtB_quant_1_signals_O_L_BEGIN[31:0]                    ), //i
    .signals_I_L_CLOSE  (dtB_quant_1_signals_O_L_CLOSE[31:0]                    ), //i
    .signals_I_MEMORY_X (dtB_quant_1_signals_O_MEMORY_X[63:0]                   ), //i
    .signals_I_MEMORY_W (dtB_quant_1_signals_O_MEMORY_W[63:0]                   ), //i
    .signals_I_MEMORY_Y (dtB_quant_1_signals_O_MEMORY_Y[63:0]                   ), //i
    .signals_I_MEMORY_C (dtB_quant_1_signals_O_MEMORY_C[63:0]                   ), //i
    .signals_I_MEMORY_H (dtB_quant_1_signals_O_MEMORY_H[63:0]                   ), //i
    .signals_I_POS      (dtB_quant_1_signals_O_POS[11:0]                        ), //i
    .signals_I_T        (dtB_quant_1_signals_O_T                                ), //i
    .signals_O_L_BEGIN  (exp_quant_1_signals_O_L_BEGIN[31:0]                    ), //o
    .signals_O_L_CLOSE  (exp_quant_1_signals_O_L_CLOSE[31:0]                    ), //o
    .signals_O_MEMORY_X (exp_quant_1_signals_O_MEMORY_X[63:0]                   ), //o
    .signals_O_MEMORY_W (exp_quant_1_signals_O_MEMORY_W[63:0]                   ), //o
    .signals_O_MEMORY_Y (exp_quant_1_signals_O_MEMORY_Y[63:0]                   ), //o
    .signals_O_MEMORY_C (exp_quant_1_signals_O_MEMORY_C[63:0]                   ), //o
    .signals_O_MEMORY_H (exp_quant_1_signals_O_MEMORY_H[63:0]                   ), //o
    .signals_O_POS      (exp_quant_1_signals_O_POS[11:0]                        ), //o
    .signals_O_T        (exp_quant_1_signals_O_T                                ), //o
    .i_stream_TVALID    (toplevel_dtA_1_o_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (exp_quant_1_i_stream_TREADY                            ), //o
    .i_stream_TDATA     (toplevel_dtA_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .o_stream_TVALID    (exp_quant_1_o_stream_TVALID                            ), //o
    .o_stream_TREADY    (toplevel_exp_quant_1_o_stream_fifo_io_push_ready       ), //i
    .o_stream_TDATA     (exp_quant_1_o_stream_TDATA[63:0]                       ), //o
    .o_s_stream_TVALID  (exp_quant_1_o_s_stream_TVALID                          ), //o
    .o_s_stream_TREADY  (toplevel_exp_quant_1_o_s_stream_fifo_io_push_ready     ), //i
    .o_s_stream_TDATA   (exp_quant_1_o_s_stream_TDATA[7:0]                      )  //o
  );
  GEMM_wrapper gemm_1 (
    .resetn             (resetn                                                     ), //i
    .clk                (clk                                                        ), //i
    .signals_I_L_BEGIN  (exp_quant_1_signals_O_L_BEGIN[31:0]                        ), //i
    .signals_I_L_CLOSE  (exp_quant_1_signals_O_L_CLOSE[31:0]                        ), //i
    .signals_I_MEMORY_X (exp_quant_1_signals_O_MEMORY_X[63:0]                       ), //i
    .signals_I_MEMORY_W (exp_quant_1_signals_O_MEMORY_W[63:0]                       ), //i
    .signals_I_MEMORY_Y (exp_quant_1_signals_O_MEMORY_Y[63:0]                       ), //i
    .signals_I_MEMORY_C (exp_quant_1_signals_O_MEMORY_C[63:0]                       ), //i
    .signals_I_MEMORY_H (exp_quant_1_signals_O_MEMORY_H[63:0]                       ), //i
    .signals_I_POS      (exp_quant_1_signals_O_POS[11:0]                            ), //i
    .signals_I_T        (exp_quant_1_signals_O_T                                    ), //i
    .signals_O_L_BEGIN  (gemm_1_signals_O_L_BEGIN[31:0]                             ), //o
    .signals_O_L_CLOSE  (gemm_1_signals_O_L_CLOSE[31:0]                             ), //o
    .signals_O_MEMORY_X (gemm_1_signals_O_MEMORY_X[63:0]                            ), //o
    .signals_O_MEMORY_W (gemm_1_signals_O_MEMORY_W[63:0]                            ), //o
    .signals_O_MEMORY_Y (gemm_1_signals_O_MEMORY_Y[63:0]                            ), //o
    .signals_O_MEMORY_C (gemm_1_signals_O_MEMORY_C[63:0]                            ), //o
    .signals_O_MEMORY_H (gemm_1_signals_O_MEMORY_H[63:0]                            ), //o
    .signals_O_POS      (gemm_1_signals_O_POS[11:0]                                 ), //o
    .signals_O_T        (gemm_1_signals_O_T                                         ), //o
    .i_stream_TVALID    (toplevel_gemm_mux_1_q_stream_fifo_io_pop_valid             ), //i
    .i_stream_TREADY    (gemm_1_i_stream_TREADY                                     ), //o
    .i_stream_TDATA     (toplevel_gemm_mux_1_q_stream_fifo_io_pop_payload_data[31:0]), //i
    .w_stream_TVALID    (w_stream_fifo_io_pop_valid                                 ), //i
    .w_stream_TREADY    (gemm_1_w_stream_TREADY                                     ), //o
    .w_stream_TDATA     (w_stream_fifo_io_pop_payload_data[255:0]                   ), //i
    .s_stream_TVALID    (toplevel_gemm_mux_1_s_stream_fifo_io_pop_valid             ), //i
    .s_stream_TREADY    (gemm_1_s_stream_TREADY                                     ), //o
    .s_stream_TDATA     (toplevel_gemm_mux_1_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .s1_stream_TVALID   (s1_stream_fifo_io_pop_valid                                ), //i
    .s1_stream_TREADY   (gemm_1_s1_stream_TREADY                                    ), //o
    .s1_stream_TDATA    (s1_stream_fifo_io_pop_payload_data[23:0]                   ), //i
    .s2_stream_TVALID   (s2_stream_fifo_io_pop_valid                                ), //i
    .s2_stream_TREADY   (gemm_1_s2_stream_TREADY                                    ), //o
    .s2_stream_TDATA    (s2_stream_fifo_io_pop_payload_data[23:0]                   ), //i
    .o_stream_TVALID    (gemm_1_o_stream_TVALID                                     ), //o
    .o_stream_TREADY    (toplevel_gemm_1_o_stream_fifo_io_push_ready                ), //i
    .o_stream_TDATA     (gemm_1_o_stream_TDATA[255:0]                               )  //o
  );
  GEMM_DEMUX_wrapper gemm_demux_1 (
    .resetn             (resetn                                                  ), //i
    .clk                (clk                                                     ), //i
    .signals_I_L_BEGIN  (gemm_1_signals_O_L_BEGIN[31:0]                          ), //i
    .signals_I_L_CLOSE  (gemm_1_signals_O_L_CLOSE[31:0]                          ), //i
    .signals_I_MEMORY_X (gemm_1_signals_O_MEMORY_X[63:0]                         ), //i
    .signals_I_MEMORY_W (gemm_1_signals_O_MEMORY_W[63:0]                         ), //i
    .signals_I_MEMORY_Y (gemm_1_signals_O_MEMORY_Y[63:0]                         ), //i
    .signals_I_MEMORY_C (gemm_1_signals_O_MEMORY_C[63:0]                         ), //i
    .signals_I_MEMORY_H (gemm_1_signals_O_MEMORY_H[63:0]                         ), //i
    .signals_I_POS      (gemm_1_signals_O_POS[11:0]                              ), //i
    .signals_I_T        (gemm_1_signals_O_T                                      ), //i
    .signals_O_L_BEGIN  (gemm_demux_1_signals_O_L_BEGIN[31:0]                    ), //o
    .signals_O_L_CLOSE  (gemm_demux_1_signals_O_L_CLOSE[31:0]                    ), //o
    .signals_O_MEMORY_X (gemm_demux_1_signals_O_MEMORY_X[63:0]                   ), //o
    .signals_O_MEMORY_W (gemm_demux_1_signals_O_MEMORY_W[63:0]                   ), //o
    .signals_O_MEMORY_Y (gemm_demux_1_signals_O_MEMORY_Y[63:0]                   ), //o
    .signals_O_MEMORY_C (gemm_demux_1_signals_O_MEMORY_C[63:0]                   ), //o
    .signals_O_MEMORY_H (gemm_demux_1_signals_O_MEMORY_H[63:0]                   ), //o
    .signals_O_POS      (gemm_demux_1_signals_O_POS[11:0]                        ), //o
    .signals_O_T        (gemm_demux_1_signals_O_T                                ), //o
    .gemm_stream_TVALID (toplevel_gemm_1_o_stream_fifo_io_pop_valid              ), //i
    .gemm_stream_TREADY (gemm_demux_1_gemm_stream_TREADY                         ), //o
    .gemm_stream_TDATA  (toplevel_gemm_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .dt_stream_TVALID   (gemm_demux_1_dt_stream_TVALID                           ), //o
    .dt_stream_TREADY   (toplevel_gemm_demux_1_dt_stream_fifo_io_push_ready      ), //i
    .dt_stream_TDATA    (gemm_demux_1_dt_stream_TDATA[255:0]                     ), //o
    .xBC_stream_TVALID  (gemm_demux_1_xBC_stream_TVALID                          ), //o
    .xBC_stream_TREADY  (toplevel_gemm_demux_1_xBC_stream_fifo_io_push_ready     ), //i
    .xBC_stream_TDATA   (gemm_demux_1_xBC_stream_TDATA[255:0]                    ), //o
    .z_stream_TVALID    (gemm_demux_1_z_stream_TVALID                            ), //o
    .z_stream_TREADY    (toplevel_gemm_demux_1_z_stream_fifo_io_push_ready       ), //i
    .z_stream_TDATA     (gemm_demux_1_z_stream_TDATA[255:0]                      ), //o
    .out_stream_TVALID  (gemm_demux_1_out_stream_TVALID                          ), //o
    .out_stream_TREADY  (toplevel_gemm_demux_1_out_stream_fifo_io_push_ready     ), //i
    .out_stream_TDATA   (gemm_demux_1_out_stream_TDATA[255:0]                    )  //o
  );
  GEMM_MUX_wrapper gemm_mux_1 (
    .resetn              (resetn                                                         ), //i
    .clk                 (clk                                                            ), //i
    .signals_I_L_BEGIN   (gemm_demux_1_signals_O_L_BEGIN[31:0]                           ), //i
    .signals_I_L_CLOSE   (gemm_demux_1_signals_O_L_CLOSE[31:0]                           ), //i
    .signals_I_MEMORY_X  (gemm_demux_1_signals_O_MEMORY_X[63:0]                          ), //i
    .signals_I_MEMORY_W  (gemm_demux_1_signals_O_MEMORY_W[63:0]                          ), //i
    .signals_I_MEMORY_Y  (gemm_demux_1_signals_O_MEMORY_Y[63:0]                          ), //i
    .signals_I_MEMORY_C  (gemm_demux_1_signals_O_MEMORY_C[63:0]                          ), //i
    .signals_I_MEMORY_H  (gemm_demux_1_signals_O_MEMORY_H[63:0]                          ), //i
    .signals_I_POS       (gemm_demux_1_signals_O_POS[11:0]                               ), //i
    .signals_I_T         (gemm_demux_1_signals_O_T                                       ), //i
    .signals_O_L_BEGIN   (gemm_mux_1_signals_O_L_BEGIN[31:0]                             ), //o
    .signals_O_L_CLOSE   (gemm_mux_1_signals_O_L_CLOSE[31:0]                             ), //o
    .signals_O_MEMORY_X  (gemm_mux_1_signals_O_MEMORY_X[63:0]                            ), //o
    .signals_O_MEMORY_W  (gemm_mux_1_signals_O_MEMORY_W[63:0]                            ), //o
    .signals_O_MEMORY_Y  (gemm_mux_1_signals_O_MEMORY_Y[63:0]                            ), //o
    .signals_O_MEMORY_C  (gemm_mux_1_signals_O_MEMORY_C[63:0]                            ), //o
    .signals_O_MEMORY_H  (gemm_mux_1_signals_O_MEMORY_H[63:0]                            ), //o
    .signals_O_POS       (gemm_mux_1_signals_O_POS[11:0]                                 ), //o
    .signals_O_T         (gemm_mux_1_signals_O_T                                         ), //o
    .xlnq1_stream_TVALID (toplevel_rms_quant_1_xlnq_stream_fifo_io_pop_valid             ), //i
    .xlnq1_stream_TREADY (gemm_mux_1_xlnq1_stream_TREADY                                 ), //o
    .xlnq1_stream_TDATA  (toplevel_rms_quant_1_xlnq_stream_fifo_io_pop_payload_data[31:0]), //i
    .xlns1_stream_TVALID (toplevel_rms_quant_1_xlns_stream_fifo_io_pop_valid             ), //i
    .xlns1_stream_TREADY (gemm_mux_1_xlns1_stream_TREADY                                 ), //o
    .xlns1_stream_TDATA  (toplevel_rms_quant_1_xlns_stream_fifo_io_pop_payload_data[7:0] ), //i
    .xlnq2_stream_TVALID (toplevel_rms_quant_2_xlnq_stream_fifo_io_pop_valid             ), //i
    .xlnq2_stream_TREADY (gemm_mux_1_xlnq2_stream_TREADY                                 ), //o
    .xlnq2_stream_TDATA  (toplevel_rms_quant_2_xlnq_stream_fifo_io_pop_payload_data[31:0]), //i
    .xlns2_stream_TVALID (toplevel_rms_quant_2_xlns_stream_fifo_io_pop_valid             ), //i
    .xlns2_stream_TREADY (gemm_mux_1_xlns2_stream_TREADY                                 ), //o
    .xlns2_stream_TDATA  (toplevel_rms_quant_2_xlns_stream_fifo_io_pop_payload_data[7:0] ), //i
    .q_stream_TVALID     (gemm_mux_1_q_stream_TVALID                                     ), //o
    .q_stream_TREADY     (toplevel_gemm_mux_1_q_stream_fifo_io_push_ready                ), //i
    .q_stream_TDATA      (gemm_mux_1_q_stream_TDATA[31:0]                                ), //o
    .s_stream_TVALID     (gemm_mux_1_s_stream_TVALID                                     ), //o
    .s_stream_TREADY     (toplevel_gemm_mux_1_s_stream_fifo_io_push_ready                ), //i
    .s_stream_TDATA      (gemm_mux_1_s_stream_TDATA[7:0]                                 )  //o
  );
  HT_ADD_QUANT_wrapper ht_add_quant_1 (
    .resetn              (resetn                                                 ), //i
    .clk                 (clk                                                    ), //i
    .signals_I_L_BEGIN   (gemm_mux_1_signals_O_L_BEGIN[31:0]                     ), //i
    .signals_I_L_CLOSE   (gemm_mux_1_signals_O_L_CLOSE[31:0]                     ), //i
    .signals_I_MEMORY_X  (gemm_mux_1_signals_O_MEMORY_X[63:0]                    ), //i
    .signals_I_MEMORY_W  (gemm_mux_1_signals_O_MEMORY_W[63:0]                    ), //i
    .signals_I_MEMORY_Y  (gemm_mux_1_signals_O_MEMORY_Y[63:0]                    ), //i
    .signals_I_MEMORY_C  (gemm_mux_1_signals_O_MEMORY_C[63:0]                    ), //i
    .signals_I_MEMORY_H  (gemm_mux_1_signals_O_MEMORY_H[63:0]                    ), //i
    .signals_I_POS       (gemm_mux_1_signals_O_POS[11:0]                         ), //i
    .signals_I_T         (gemm_mux_1_signals_O_T                                 ), //i
    .signals_O_L_BEGIN   (ht_add_quant_1_signals_O_L_BEGIN[31:0]                 ), //o
    .signals_O_L_CLOSE   (ht_add_quant_1_signals_O_L_CLOSE[31:0]                 ), //o
    .signals_O_MEMORY_X  (ht_add_quant_1_signals_O_MEMORY_X[63:0]                ), //o
    .signals_O_MEMORY_W  (ht_add_quant_1_signals_O_MEMORY_W[63:0]                ), //o
    .signals_O_MEMORY_Y  (ht_add_quant_1_signals_O_MEMORY_Y[63:0]                ), //o
    .signals_O_MEMORY_C  (ht_add_quant_1_signals_O_MEMORY_C[63:0]                ), //o
    .signals_O_MEMORY_H  (ht_add_quant_1_signals_O_MEMORY_H[63:0]                ), //o
    .signals_O_POS       (ht_add_quant_1_signals_O_POS[11:0]                     ), //o
    .signals_O_T         (ht_add_quant_1_signals_O_T                             ), //o
    .dAh_stream_TVALID   (toplevel_dAh_1_o_stream_fifo_io_pop_valid              ), //i
    .dAh_stream_TREADY   (ht_add_quant_1_dAh_stream_TREADY                       ), //o
    .dAh_stream_TDATA    (toplevel_dAh_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .dBu_stream_TVALID   (toplevel_dBu_1_o_stream_fifo_io_pop_valid              ), //i
    .dBu_stream_TREADY   (ht_add_quant_1_dBu_stream_TREADY                       ), //o
    .dBu_stream_TDATA    (toplevel_dBu_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .ht1_q_stream_TVALID (ht_add_quant_1_ht1_q_stream_TVALID                     ), //o
    .ht1_q_stream_TREADY (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_push_ready), //i
    .ht1_q_stream_TDATA  (ht_add_quant_1_ht1_q_stream_TDATA[63:0]                ), //o
    .ht1_s_stream_TVALID (ht_add_quant_1_ht1_s_stream_TVALID                     ), //o
    .ht1_s_stream_TREADY (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_push_ready), //i
    .ht1_s_stream_TDATA  (ht_add_quant_1_ht1_s_stream_TDATA[7:0]                 ), //o
    .ht2_q_stream_TVALID (ht_add_quant_1_ht2_q_stream_TVALID                     ), //o
    .ht2_q_stream_TREADY (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_push_ready), //i
    .ht2_q_stream_TDATA  (ht_add_quant_1_ht2_q_stream_TDATA[63:0]                ), //o
    .ht2_s_stream_TVALID (ht_add_quant_1_ht2_s_stream_TVALID                     ), //o
    .ht2_s_stream_TREADY (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_push_ready), //i
    .ht2_s_stream_TDATA  (ht_add_quant_1_ht2_s_stream_TDATA[7:0]                 )  //o
  );
  HT_STATE_wrapper ht_state_1 (
    .resetn                    (resetn                                                             ), //i
    .clk                       (clk                                                                ), //i
    .signals_I_L_BEGIN         (ht_add_quant_1_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE         (ht_add_quant_1_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X        (ht_add_quant_1_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W        (ht_add_quant_1_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y        (ht_add_quant_1_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C        (ht_add_quant_1_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H        (ht_add_quant_1_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS             (ht_add_quant_1_signals_O_POS[11:0]                                 ), //i
    .signals_I_T               (ht_add_quant_1_signals_O_T                                         ), //i
    .signals_O_L_BEGIN         (ht_state_1_signals_O_L_BEGIN[31:0]                                 ), //o
    .signals_O_L_CLOSE         (ht_state_1_signals_O_L_CLOSE[31:0]                                 ), //o
    .signals_O_MEMORY_X        (ht_state_1_signals_O_MEMORY_X[63:0]                                ), //o
    .signals_O_MEMORY_W        (ht_state_1_signals_O_MEMORY_W[63:0]                                ), //o
    .signals_O_MEMORY_Y        (ht_state_1_signals_O_MEMORY_Y[63:0]                                ), //o
    .signals_O_MEMORY_C        (ht_state_1_signals_O_MEMORY_C[63:0]                                ), //o
    .signals_O_MEMORY_H        (ht_state_1_signals_O_MEMORY_H[63:0]                                ), //o
    .signals_O_POS             (ht_state_1_signals_O_POS[11:0]                                     ), //o
    .signals_O_T               (ht_state_1_signals_O_T                                             ), //o
    .state_in_stream_TVALID    (hq_stream_fifo_io_pop_valid                                        ), //i
    .state_in_stream_TREADY    (ht_state_1_state_in_stream_TREADY                                  ), //o
    .state_in_stream_TDATA     (hq_stream_fifo_io_pop_payload_data[255:0]                          ), //i
    .state_in_s_stream_TVALID  (hs_stream_fifo_io_pop_valid                                        ), //i
    .state_in_s_stream_TREADY  (ht_state_1_state_in_s_stream_TREADY                                ), //o
    .state_in_s_stream_TDATA   (hs_stream_fifo_io_pop_payload_data[255:0]                          ), //i
    .ht_in_stream_TVALID       (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_pop_valid             ), //i
    .ht_in_stream_TREADY       (ht_state_1_ht_in_stream_TREADY                                     ), //o
    .ht_in_stream_TDATA        (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_pop_payload_data[63:0]), //i
    .ht_in_s_stream_TVALID     (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_pop_valid             ), //i
    .ht_in_s_stream_TREADY     (ht_state_1_ht_in_s_stream_TREADY                                   ), //o
    .ht_in_s_stream_TDATA      (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .ht_out_stream_TVALID      (ht_state_1_ht_out_stream_TVALID                                    ), //o
    .ht_out_stream_TREADY      (toplevel_ht_state_1_ht_out_stream_fifo_io_push_ready               ), //i
    .ht_out_stream_TDATA       (ht_state_1_ht_out_stream_TDATA[63:0]                               ), //o
    .ht_out_s_stream_TVALID    (ht_state_1_ht_out_s_stream_TVALID                                  ), //o
    .ht_out_s_stream_TREADY    (toplevel_ht_state_1_ht_out_s_stream_fifo_io_push_ready             ), //i
    .ht_out_s_stream_TDATA     (ht_state_1_ht_out_s_stream_TDATA[7:0]                              ), //o
    .state_out_stream_TVALID   (ht_state_1_state_out_stream_TVALID                                 ), //o
    .state_out_stream_TREADY   (toplevel_ht_state_1_state_out_stream_fifo_io_push_ready            ), //i
    .state_out_stream_TDATA    (ht_state_1_state_out_stream_TDATA[255:0]                           ), //o
    .state_out_s_stream_TVALID (ht_state_1_state_out_s_stream_TVALID                               ), //o
    .state_out_s_stream_TREADY (toplevel_ht_state_1_state_out_s_stream_fifo_io_push_ready          ), //i
    .state_out_s_stream_TDATA  (ht_state_1_state_out_s_stream_TDATA[255:0]                         )  //o
  );
  HTC_QUANT_wrapper htC_quant_1 (
    .resetn             (resetn                                                             ), //i
    .clk                (clk                                                                ), //i
    .signals_I_L_BEGIN  (ht_state_1_signals_O_L_BEGIN[31:0]                                 ), //i
    .signals_I_L_CLOSE  (ht_state_1_signals_O_L_CLOSE[31:0]                                 ), //i
    .signals_I_MEMORY_X (ht_state_1_signals_O_MEMORY_X[63:0]                                ), //i
    .signals_I_MEMORY_W (ht_state_1_signals_O_MEMORY_W[63:0]                                ), //i
    .signals_I_MEMORY_Y (ht_state_1_signals_O_MEMORY_Y[63:0]                                ), //i
    .signals_I_MEMORY_C (ht_state_1_signals_O_MEMORY_C[63:0]                                ), //i
    .signals_I_MEMORY_H (ht_state_1_signals_O_MEMORY_H[63:0]                                ), //i
    .signals_I_POS      (ht_state_1_signals_O_POS[11:0]                                     ), //i
    .signals_I_T        (ht_state_1_signals_O_T                                             ), //i
    .signals_O_L_BEGIN  (htC_quant_1_signals_O_L_BEGIN[31:0]                                ), //o
    .signals_O_L_CLOSE  (htC_quant_1_signals_O_L_CLOSE[31:0]                                ), //o
    .signals_O_MEMORY_X (htC_quant_1_signals_O_MEMORY_X[63:0]                               ), //o
    .signals_O_MEMORY_W (htC_quant_1_signals_O_MEMORY_W[63:0]                               ), //o
    .signals_O_MEMORY_Y (htC_quant_1_signals_O_MEMORY_Y[63:0]                               ), //o
    .signals_O_MEMORY_C (htC_quant_1_signals_O_MEMORY_C[63:0]                               ), //o
    .signals_O_MEMORY_H (htC_quant_1_signals_O_MEMORY_H[63:0]                               ), //o
    .signals_O_POS      (htC_quant_1_signals_O_POS[11:0]                                    ), //o
    .signals_O_T        (htC_quant_1_signals_O_T                                            ), //o
    .ht_stream_TVALID   (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_pop_valid             ), //i
    .ht_stream_TREADY   (htC_quant_1_ht_stream_TREADY                                       ), //o
    .ht_stream_TDATA    (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_pop_payload_data[63:0]), //i
    .ht_s_stream_TVALID (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_pop_valid             ), //i
    .ht_s_stream_TREADY (htC_quant_1_ht_s_stream_TREADY                                     ), //o
    .ht_s_stream_TDATA  (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .C_stream_TVALID    (toplevel_C_buffer_1_q_stream_fifo_io_pop_valid                     ), //i
    .C_stream_TREADY    (htC_quant_1_C_stream_TREADY                                        ), //o
    .C_stream_TDATA     (toplevel_C_buffer_1_q_stream_fifo_io_pop_payload_data[63:0]        ), //i
    .C_s_stream_TVALID  (toplevel_C_buffer_1_s_stream_fifo_io_pop_valid                     ), //i
    .C_s_stream_TREADY  (htC_quant_1_C_s_stream_TREADY                                      ), //o
    .C_s_stream_TDATA   (toplevel_C_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]         ), //i
    .uD_stream_TVALID   (toplevel_ud_1_o_stream_fifo_io_pop_valid                           ), //i
    .uD_stream_TREADY   (htC_quant_1_uD_stream_TREADY                                       ), //o
    .uD_stream_TDATA    (toplevel_ud_1_o_stream_fifo_io_pop_payload_data[255:0]             ), //i
    .o_q_stream_TVALID  (htC_quant_1_o_q_stream_TVALID                                      ), //o
    .o_q_stream_TREADY  (toplevel_htC_quant_1_o_q_stream_fifo_io_push_ready                 ), //i
    .o_q_stream_TDATA   (htC_quant_1_o_q_stream_TDATA[63:0]                                 ), //o
    .o_s_stream_TVALID  (htC_quant_1_o_s_stream_TVALID                                      ), //o
    .o_s_stream_TREADY  (toplevel_htC_quant_1_o_s_stream_fifo_io_push_ready                 ), //i
    .o_s_stream_TDATA   (htC_quant_1_o_s_stream_TDATA[7:0]                                  )  //o
  );
  QUANT_CONV_wrapper quant_conv_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (htC_quant_1_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE  (htC_quant_1_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X (htC_quant_1_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W (htC_quant_1_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y (htC_quant_1_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C (htC_quant_1_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H (htC_quant_1_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS      (htC_quant_1_signals_O_POS[11:0]                                 ), //i
    .signals_I_T        (htC_quant_1_signals_O_T                                         ), //i
    .signals_O_L_BEGIN  (quant_conv_1_signals_O_L_BEGIN[31:0]                            ), //o
    .signals_O_L_CLOSE  (quant_conv_1_signals_O_L_CLOSE[31:0]                            ), //o
    .signals_O_MEMORY_X (quant_conv_1_signals_O_MEMORY_X[63:0]                           ), //o
    .signals_O_MEMORY_W (quant_conv_1_signals_O_MEMORY_W[63:0]                           ), //o
    .signals_O_MEMORY_Y (quant_conv_1_signals_O_MEMORY_Y[63:0]                           ), //o
    .signals_O_MEMORY_C (quant_conv_1_signals_O_MEMORY_C[63:0]                           ), //o
    .signals_O_MEMORY_H (quant_conv_1_signals_O_MEMORY_H[63:0]                           ), //o
    .signals_O_POS      (quant_conv_1_signals_O_POS[11:0]                                ), //o
    .signals_O_T        (quant_conv_1_signals_O_T                                        ), //o
    .i_stream_TVALID    (toplevel_gemm_demux_1_xBC_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (quant_conv_1_i_stream_TREADY                                    ), //o
    .i_stream_TDATA     (toplevel_gemm_demux_1_xBC_stream_fifo_io_pop_payload_data[255:0]), //i
    .o_stream_TVALID    (quant_conv_1_o_stream_TVALID                                    ), //o
    .o_stream_TREADY    (toplevel_quant_conv_1_o_stream_fifo_io_push_ready               ), //i
    .o_stream_TDATA     (quant_conv_1_o_stream_TDATA[63:0]                               ), //o
    .o_s_stream_TVALID  (quant_conv_1_o_s_stream_TVALID                                  ), //o
    .o_s_stream_TREADY  (toplevel_quant_conv_1_o_s_stream_fifo_io_push_ready             ), //i
    .o_s_stream_TDATA   (quant_conv_1_o_s_stream_TDATA[7:0]                              )  //o
  );
  RESIDUAL_wrapper residual_1 (
    .resetn              (resetn                                                          ), //i
    .clk                 (clk                                                             ), //i
    .signals_I_L_BEGIN   (quant_conv_1_signals_O_L_BEGIN[31:0]                            ), //i
    .signals_I_L_CLOSE   (quant_conv_1_signals_O_L_CLOSE[31:0]                            ), //i
    .signals_I_MEMORY_X  (quant_conv_1_signals_O_MEMORY_X[63:0]                           ), //i
    .signals_I_MEMORY_W  (quant_conv_1_signals_O_MEMORY_W[63:0]                           ), //i
    .signals_I_MEMORY_Y  (quant_conv_1_signals_O_MEMORY_Y[63:0]                           ), //i
    .signals_I_MEMORY_C  (quant_conv_1_signals_O_MEMORY_C[63:0]                           ), //i
    .signals_I_MEMORY_H  (quant_conv_1_signals_O_MEMORY_H[63:0]                           ), //i
    .signals_I_POS       (quant_conv_1_signals_O_POS[11:0]                                ), //i
    .signals_I_T         (quant_conv_1_signals_O_T                                        ), //i
    .signals_O_L_BEGIN   (residual_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE   (residual_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X  (residual_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W  (residual_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y  (residual_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C  (residual_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H  (residual_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS       (residual_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T         (residual_1_signals_O_T                                          ), //o
    .x_stream_TVALID     (x_stream_fifo_io_pop_valid                                      ), //i
    .x_stream_TREADY     (residual_1_x_stream_TREADY                                      ), //o
    .x_stream_TDATA      (x_stream_fifo_io_pop_payload_data[255:0]                        ), //i
    .res_i_stream_TVALID (toplevel_gemm_demux_1_out_stream_fifo_io_pop_valid              ), //i
    .res_i_stream_TREADY (residual_1_res_i_stream_TREADY                                  ), //o
    .res_i_stream_TDATA  (toplevel_gemm_demux_1_out_stream_fifo_io_pop_payload_data[255:0]), //i
    .res_o_stream_TVALID (residual_1_res_o_stream_TVALID                                  ), //o
    .res_o_stream_TREADY (toplevel_residual_1_res_o_stream_fifo_io_push_ready             ), //i
    .res_o_stream_TDATA  (residual_1_res_o_stream_TDATA[255:0]                            ), //o
    .y_stream_TVALID     (residual_1_y_stream_TVALID                                      ), //o
    .y_stream_TREADY     (toplevel_residual_1_y_stream_fifo_io_push_ready                 ), //i
    .y_stream_TDATA      (residual_1_y_stream_TDATA[255:0]                                )  //o
  );
  RMSNORM_QUANT_1_wrapper rms_quant_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (residual_1_signals_O_L_BEGIN[31:0]                              ), //i
    .signals_I_L_CLOSE  (residual_1_signals_O_L_CLOSE[31:0]                              ), //i
    .signals_I_MEMORY_X (residual_1_signals_O_MEMORY_X[63:0]                             ), //i
    .signals_I_MEMORY_W (residual_1_signals_O_MEMORY_W[63:0]                             ), //i
    .signals_I_MEMORY_Y (residual_1_signals_O_MEMORY_Y[63:0]                             ), //i
    .signals_I_MEMORY_C (residual_1_signals_O_MEMORY_C[63:0]                             ), //i
    .signals_I_MEMORY_H (residual_1_signals_O_MEMORY_H[63:0]                             ), //i
    .signals_I_POS      (residual_1_signals_O_POS[11:0]                                  ), //i
    .signals_I_T        (residual_1_signals_O_T                                          ), //i
    .signals_O_L_BEGIN  (rms_quant_1_signals_O_L_BEGIN[31:0]                             ), //o
    .signals_O_L_CLOSE  (rms_quant_1_signals_O_L_CLOSE[31:0]                             ), //o
    .signals_O_MEMORY_X (rms_quant_1_signals_O_MEMORY_X[63:0]                            ), //o
    .signals_O_MEMORY_W (rms_quant_1_signals_O_MEMORY_W[63:0]                            ), //o
    .signals_O_MEMORY_Y (rms_quant_1_signals_O_MEMORY_Y[63:0]                            ), //o
    .signals_O_MEMORY_C (rms_quant_1_signals_O_MEMORY_C[63:0]                            ), //o
    .signals_O_MEMORY_H (rms_quant_1_signals_O_MEMORY_H[63:0]                            ), //o
    .signals_O_POS      (rms_quant_1_signals_O_POS[11:0]                                 ), //o
    .signals_O_T        (rms_quant_1_signals_O_T                                         ), //o
    .x_stream_TVALID    (toplevel_residual_1_res_o_stream_fifo_io_pop_valid              ), //i
    .x_stream_TREADY    (rms_quant_1_x_stream_TREADY                                     ), //o
    .x_stream_TDATA     (toplevel_residual_1_res_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .xlnq_stream_TVALID (rms_quant_1_xlnq_stream_TVALID                                  ), //o
    .xlnq_stream_TREADY (toplevel_rms_quant_1_xlnq_stream_fifo_io_push_ready             ), //i
    .xlnq_stream_TDATA  (rms_quant_1_xlnq_stream_TDATA[31:0]                             ), //o
    .xlns_stream_TVALID (rms_quant_1_xlns_stream_TVALID                                  ), //o
    .xlns_stream_TREADY (toplevel_rms_quant_1_xlns_stream_fifo_io_push_ready             ), //i
    .xlns_stream_TDATA  (rms_quant_1_xlns_stream_TDATA[7:0]                              )  //o
  );
  RMSNORM_QUANT_2_wrapper rms_quant_2 (
    .resetn             (resetn                                                ), //i
    .clk                (clk                                                   ), //i
    .signals_I_L_BEGIN  (rms_quant_1_signals_O_L_BEGIN[31:0]                   ), //i
    .signals_I_L_CLOSE  (rms_quant_1_signals_O_L_CLOSE[31:0]                   ), //i
    .signals_I_MEMORY_X (rms_quant_1_signals_O_MEMORY_X[63:0]                  ), //i
    .signals_I_MEMORY_W (rms_quant_1_signals_O_MEMORY_W[63:0]                  ), //i
    .signals_I_MEMORY_Y (rms_quant_1_signals_O_MEMORY_Y[63:0]                  ), //i
    .signals_I_MEMORY_C (rms_quant_1_signals_O_MEMORY_C[63:0]                  ), //i
    .signals_I_MEMORY_H (rms_quant_1_signals_O_MEMORY_H[63:0]                  ), //i
    .signals_I_POS      (rms_quant_1_signals_O_POS[11:0]                       ), //i
    .signals_I_T        (rms_quant_1_signals_O_T                               ), //i
    .signals_O_L_BEGIN  (rms_quant_2_signals_O_L_BEGIN[31:0]                   ), //o
    .signals_O_L_CLOSE  (rms_quant_2_signals_O_L_CLOSE[31:0]                   ), //o
    .signals_O_MEMORY_X (rms_quant_2_signals_O_MEMORY_X[63:0]                  ), //o
    .signals_O_MEMORY_W (rms_quant_2_signals_O_MEMORY_W[63:0]                  ), //o
    .signals_O_MEMORY_Y (rms_quant_2_signals_O_MEMORY_Y[63:0]                  ), //o
    .signals_O_MEMORY_C (rms_quant_2_signals_O_MEMORY_C[63:0]                  ), //o
    .signals_O_MEMORY_H (rms_quant_2_signals_O_MEMORY_H[63:0]                  ), //o
    .signals_O_POS      (rms_quant_2_signals_O_POS[11:0]                       ), //o
    .signals_O_T        (rms_quant_2_signals_O_T                               ), //o
    .x_stream_TVALID    (toplevel_yz_1_o_stream_fifo_io_pop_valid              ), //i
    .x_stream_TREADY    (rms_quant_2_x_stream_TREADY                           ), //o
    .x_stream_TDATA     (toplevel_yz_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .xlnq_stream_TVALID (rms_quant_2_xlnq_stream_TVALID                        ), //o
    .xlnq_stream_TREADY (toplevel_rms_quant_2_xlnq_stream_fifo_io_push_ready   ), //i
    .xlnq_stream_TDATA  (rms_quant_2_xlnq_stream_TDATA[31:0]                   ), //o
    .xlns_stream_TVALID (rms_quant_2_xlns_stream_TVALID                        ), //o
    .xlns_stream_TREADY (toplevel_rms_quant_2_xlns_stream_fifo_io_push_ready   ), //i
    .xlns_stream_TDATA  (rms_quant_2_xlns_stream_TDATA[7:0]                    )  //o
  );
  SILU_DEMUX_wrapper silu_demux_1 (
    .resetn               (resetn                                                          ), //i
    .clk                  (clk                                                             ), //i
    .signals_I_L_BEGIN    (rms_quant_2_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE    (rms_quant_2_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X   (rms_quant_2_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W   (rms_quant_2_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y   (rms_quant_2_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C   (rms_quant_2_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H   (rms_quant_2_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS        (rms_quant_2_signals_O_POS[11:0]                                 ), //i
    .signals_I_T          (rms_quant_2_signals_O_T                                         ), //i
    .signals_O_L_BEGIN    (silu_demux_1_signals_O_L_BEGIN[31:0]                            ), //o
    .signals_O_L_CLOSE    (silu_demux_1_signals_O_L_CLOSE[31:0]                            ), //o
    .signals_O_MEMORY_X   (silu_demux_1_signals_O_MEMORY_X[63:0]                           ), //o
    .signals_O_MEMORY_W   (silu_demux_1_signals_O_MEMORY_W[63:0]                           ), //o
    .signals_O_MEMORY_Y   (silu_demux_1_signals_O_MEMORY_Y[63:0]                           ), //o
    .signals_O_MEMORY_C   (silu_demux_1_signals_O_MEMORY_C[63:0]                           ), //o
    .signals_O_MEMORY_H   (silu_demux_1_signals_O_MEMORY_H[63:0]                           ), //o
    .signals_O_POS        (silu_demux_1_signals_O_POS[11:0]                                ), //o
    .signals_O_T          (silu_demux_1_signals_O_T                                        ), //o
    .silu_stream_TVALID   (toplevel_silu_quant_1_out_stream_fifo_io_pop_valid              ), //i
    .silu_stream_TREADY   (silu_demux_1_silu_stream_TREADY                                 ), //o
    .silu_stream_TDATA    (toplevel_silu_quant_1_out_stream_fifo_io_pop_payload_data[63:0] ), //i
    .silu_s_stream_TVALID (toplevel_silu_quant_1_out_s_stream_fifo_io_pop_valid            ), //i
    .silu_s_stream_TREADY (silu_demux_1_silu_s_stream_TREADY                               ), //o
    .silu_s_stream_TDATA  (toplevel_silu_quant_1_out_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .x_stream_TVALID      (silu_demux_1_x_stream_TVALID                                    ), //o
    .x_stream_TREADY      (toplevel_silu_demux_1_x_stream_fifo_io_push_ready               ), //i
    .x_stream_TDATA       (silu_demux_1_x_stream_TDATA[63:0]                               ), //o
    .x_s_stream_TVALID    (silu_demux_1_x_s_stream_TVALID                                  ), //o
    .x_s_stream_TREADY    (toplevel_silu_demux_1_x_s_stream_fifo_io_push_ready             ), //i
    .x_s_stream_TDATA     (silu_demux_1_x_s_stream_TDATA[7:0]                              ), //o
    .x_stream2_TVALID     (silu_demux_1_x_stream2_TVALID                                   ), //o
    .x_stream2_TREADY     (toplevel_silu_demux_1_x_stream2_fifo_io_push_ready              ), //i
    .x_stream2_TDATA      (silu_demux_1_x_stream2_TDATA[63:0]                              ), //o
    .x_s_stream2_TVALID   (silu_demux_1_x_s_stream2_TVALID                                 ), //o
    .x_s_stream2_TREADY   (toplevel_silu_demux_1_x_s_stream2_fifo_io_push_ready            ), //i
    .x_s_stream2_TDATA    (silu_demux_1_x_s_stream2_TDATA[7:0]                             ), //o
    .B_stream_TVALID      (silu_demux_1_B_stream_TVALID                                    ), //o
    .B_stream_TREADY      (toplevel_silu_demux_1_B_stream_fifo_io_push_ready               ), //i
    .B_stream_TDATA       (silu_demux_1_B_stream_TDATA[63:0]                               ), //o
    .B_s_stream_TVALID    (silu_demux_1_B_s_stream_TVALID                                  ), //o
    .B_s_stream_TREADY    (toplevel_silu_demux_1_B_s_stream_fifo_io_push_ready             ), //i
    .B_s_stream_TDATA     (silu_demux_1_B_s_stream_TDATA[7:0]                              ), //o
    .C_stream_TVALID      (silu_demux_1_C_stream_TVALID                                    ), //o
    .C_stream_TREADY      (toplevel_silu_demux_1_C_stream_fifo_io_push_ready               ), //i
    .C_stream_TDATA       (silu_demux_1_C_stream_TDATA[63:0]                               ), //o
    .C_s_stream_TVALID    (silu_demux_1_C_s_stream_TVALID                                  ), //o
    .C_s_stream_TREADY    (toplevel_silu_demux_1_C_s_stream_fifo_io_push_ready             ), //i
    .C_s_stream_TDATA     (silu_demux_1_C_s_stream_TDATA[7:0]                              ), //o
    .z_stream_TVALID      (silu_demux_1_z_stream_TVALID                                    ), //o
    .z_stream_TREADY      (toplevel_silu_demux_1_z_stream_fifo_io_push_ready               ), //i
    .z_stream_TDATA       (silu_demux_1_z_stream_TDATA[63:0]                               ), //o
    .z_s_stream_TVALID    (silu_demux_1_z_s_stream_TVALID                                  ), //o
    .z_s_stream_TREADY    (toplevel_silu_demux_1_z_s_stream_fifo_io_push_ready             ), //i
    .z_s_stream_TDATA     (silu_demux_1_z_s_stream_TDATA[7:0]                              )  //o
  );
  SILU_MUX_wrapper silu_mux_1 (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (silu_demux_1_signals_O_L_BEGIN[31:0]                          ), //i
    .signals_I_L_CLOSE  (silu_demux_1_signals_O_L_CLOSE[31:0]                          ), //i
    .signals_I_MEMORY_X (silu_demux_1_signals_O_MEMORY_X[63:0]                         ), //i
    .signals_I_MEMORY_W (silu_demux_1_signals_O_MEMORY_W[63:0]                         ), //i
    .signals_I_MEMORY_Y (silu_demux_1_signals_O_MEMORY_Y[63:0]                         ), //i
    .signals_I_MEMORY_C (silu_demux_1_signals_O_MEMORY_C[63:0]                         ), //i
    .signals_I_MEMORY_H (silu_demux_1_signals_O_MEMORY_H[63:0]                         ), //i
    .signals_I_POS      (silu_demux_1_signals_O_POS[11:0]                              ), //i
    .signals_I_T        (silu_demux_1_signals_O_T                                      ), //i
    .signals_O_L_BEGIN  (silu_mux_1_signals_O_L_BEGIN[31:0]                            ), //o
    .signals_O_L_CLOSE  (silu_mux_1_signals_O_L_CLOSE[31:0]                            ), //o
    .signals_O_MEMORY_X (silu_mux_1_signals_O_MEMORY_X[63:0]                           ), //o
    .signals_O_MEMORY_W (silu_mux_1_signals_O_MEMORY_W[63:0]                           ), //o
    .signals_O_MEMORY_Y (silu_mux_1_signals_O_MEMORY_Y[63:0]                           ), //o
    .signals_O_MEMORY_C (silu_mux_1_signals_O_MEMORY_C[63:0]                           ), //o
    .signals_O_MEMORY_H (silu_mux_1_signals_O_MEMORY_H[63:0]                           ), //o
    .signals_O_POS      (silu_mux_1_signals_O_POS[11:0]                                ), //o
    .signals_O_T        (silu_mux_1_signals_O_T                                        ), //o
    .xBC_stream_TVALID  (toplevel_conv_1_o_stream_fifo_io_pop_valid                    ), //i
    .xBC_stream_TREADY  (silu_mux_1_xBC_stream_TREADY                                  ), //o
    .xBC_stream_TDATA   (toplevel_conv_1_o_stream_fifo_io_pop_payload_data[255:0]      ), //i
    .z_stream_TVALID    (toplevel_gemm_demux_1_z_stream_fifo_io_pop_valid              ), //i
    .z_stream_TREADY    (silu_mux_1_z_stream_TREADY                                    ), //o
    .z_stream_TDATA     (toplevel_gemm_demux_1_z_stream_fifo_io_pop_payload_data[255:0]), //i
    .silu_stream_TVALID (silu_mux_1_silu_stream_TVALID                                 ), //o
    .silu_stream_TREADY (toplevel_silu_mux_1_silu_stream_fifo_io_push_ready            ), //i
    .silu_stream_TDATA  (silu_mux_1_silu_stream_TDATA[255:0]                           )  //o
  );
  SILU_QUANT_wrapper silu_quant_1 (
    .resetn              (resetn                                                         ), //i
    .clk                 (clk                                                            ), //i
    .signals_I_L_BEGIN   (silu_mux_1_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE   (silu_mux_1_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X  (silu_mux_1_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W  (silu_mux_1_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y  (silu_mux_1_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C  (silu_mux_1_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H  (silu_mux_1_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS       (silu_mux_1_signals_O_POS[11:0]                                 ), //i
    .signals_I_T         (silu_mux_1_signals_O_T                                         ), //i
    .signals_O_L_BEGIN   (silu_quant_1_signals_O_L_BEGIN[31:0]                           ), //o
    .signals_O_L_CLOSE   (silu_quant_1_signals_O_L_CLOSE[31:0]                           ), //o
    .signals_O_MEMORY_X  (silu_quant_1_signals_O_MEMORY_X[63:0]                          ), //o
    .signals_O_MEMORY_W  (silu_quant_1_signals_O_MEMORY_W[63:0]                          ), //o
    .signals_O_MEMORY_Y  (silu_quant_1_signals_O_MEMORY_Y[63:0]                          ), //o
    .signals_O_MEMORY_C  (silu_quant_1_signals_O_MEMORY_C[63:0]                          ), //o
    .signals_O_MEMORY_H  (silu_quant_1_signals_O_MEMORY_H[63:0]                          ), //o
    .signals_O_POS       (silu_quant_1_signals_O_POS[11:0]                               ), //o
    .signals_O_T         (silu_quant_1_signals_O_T                                       ), //o
    .i_stream_TVALID     (toplevel_silu_mux_1_silu_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY     (silu_quant_1_i_stream_TREADY                                   ), //o
    .i_stream_TDATA      (toplevel_silu_mux_1_silu_stream_fifo_io_pop_payload_data[255:0]), //i
    .out_stream_TVALID   (silu_quant_1_out_stream_TVALID                                 ), //o
    .out_stream_TREADY   (toplevel_silu_quant_1_out_stream_fifo_io_push_ready            ), //i
    .out_stream_TDATA    (silu_quant_1_out_stream_TDATA[63:0]                            ), //o
    .out_s_stream_TVALID (silu_quant_1_out_s_stream_TVALID                               ), //o
    .out_s_stream_TREADY (toplevel_silu_quant_1_out_s_stream_fifo_io_push_ready          ), //i
    .out_s_stream_TDATA  (silu_quant_1_out_s_stream_TDATA[7:0]                           )  //o
  );
  UD_wrapper ud_1 (
    .resetn             (resetn                                                         ), //i
    .clk                (clk                                                            ), //i
    .signals_I_L_BEGIN  (silu_quant_1_signals_O_L_BEGIN[31:0]                           ), //i
    .signals_I_L_CLOSE  (silu_quant_1_signals_O_L_CLOSE[31:0]                           ), //i
    .signals_I_MEMORY_X (silu_quant_1_signals_O_MEMORY_X[63:0]                          ), //i
    .signals_I_MEMORY_W (silu_quant_1_signals_O_MEMORY_W[63:0]                          ), //i
    .signals_I_MEMORY_Y (silu_quant_1_signals_O_MEMORY_Y[63:0]                          ), //i
    .signals_I_MEMORY_C (silu_quant_1_signals_O_MEMORY_C[63:0]                          ), //i
    .signals_I_MEMORY_H (silu_quant_1_signals_O_MEMORY_H[63:0]                          ), //i
    .signals_I_POS      (silu_quant_1_signals_O_POS[11:0]                               ), //i
    .signals_I_T        (silu_quant_1_signals_O_T                                       ), //i
    .signals_O_L_BEGIN  (ud_1_signals_O_L_BEGIN[31:0]                                   ), //o
    .signals_O_L_CLOSE  (ud_1_signals_O_L_CLOSE[31:0]                                   ), //o
    .signals_O_MEMORY_X (ud_1_signals_O_MEMORY_X[63:0]                                  ), //o
    .signals_O_MEMORY_W (ud_1_signals_O_MEMORY_W[63:0]                                  ), //o
    .signals_O_MEMORY_Y (ud_1_signals_O_MEMORY_Y[63:0]                                  ), //o
    .signals_O_MEMORY_C (ud_1_signals_O_MEMORY_C[63:0]                                  ), //o
    .signals_O_MEMORY_H (ud_1_signals_O_MEMORY_H[63:0]                                  ), //o
    .signals_O_POS      (ud_1_signals_O_POS[11:0]                                       ), //o
    .signals_O_T        (ud_1_signals_O_T                                               ), //o
    .i_stream_TVALID    (toplevel_silu_demux_1_x_stream2_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (ud_1_i_stream_TREADY                                           ), //o
    .i_stream_TDATA     (toplevel_silu_demux_1_x_stream2_fifo_io_pop_payload_data[63:0] ), //i
    .s_stream_TVALID    (toplevel_silu_demux_1_x_s_stream2_fifo_io_pop_valid            ), //i
    .s_stream_TREADY    (ud_1_s_stream_TREADY                                           ), //o
    .s_stream_TDATA     (toplevel_silu_demux_1_x_s_stream2_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (ud_1_o_stream_TVALID                                           ), //o
    .o_stream_TREADY    (toplevel_ud_1_o_stream_fifo_io_push_ready                      ), //i
    .o_stream_TDATA     (ud_1_o_stream_TDATA[255:0]                                     )  //o
  );
  YZ_wrapper yz_1 (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (ud_1_signals_O_L_BEGIN[31:0]                                  ), //i
    .signals_I_L_CLOSE  (ud_1_signals_O_L_CLOSE[31:0]                                  ), //i
    .signals_I_MEMORY_X (ud_1_signals_O_MEMORY_X[63:0]                                 ), //i
    .signals_I_MEMORY_W (ud_1_signals_O_MEMORY_W[63:0]                                 ), //i
    .signals_I_MEMORY_Y (ud_1_signals_O_MEMORY_Y[63:0]                                 ), //i
    .signals_I_MEMORY_C (ud_1_signals_O_MEMORY_C[63:0]                                 ), //i
    .signals_I_MEMORY_H (ud_1_signals_O_MEMORY_H[63:0]                                 ), //i
    .signals_I_POS      (ud_1_signals_O_POS[11:0]                                      ), //i
    .signals_I_T        (ud_1_signals_O_T                                              ), //i
    .signals_O_L_BEGIN  (yz_1_signals_O_L_BEGIN[31:0]                                  ), //o
    .signals_O_L_CLOSE  (yz_1_signals_O_L_CLOSE[31:0]                                  ), //o
    .signals_O_MEMORY_X (yz_1_signals_O_MEMORY_X[63:0]                                 ), //o
    .signals_O_MEMORY_W (yz_1_signals_O_MEMORY_W[63:0]                                 ), //o
    .signals_O_MEMORY_Y (yz_1_signals_O_MEMORY_Y[63:0]                                 ), //o
    .signals_O_MEMORY_C (yz_1_signals_O_MEMORY_C[63:0]                                 ), //o
    .signals_O_MEMORY_H (yz_1_signals_O_MEMORY_H[63:0]                                 ), //o
    .signals_O_POS      (yz_1_signals_O_POS[11:0]                                      ), //o
    .signals_O_T        (yz_1_signals_O_T                                              ), //o
    .y_stream_TVALID    (toplevel_htC_quant_1_o_q_stream_fifo_io_pop_valid             ), //i
    .y_stream_TREADY    (yz_1_y_stream_TREADY                                          ), //o
    .y_stream_TDATA     (toplevel_htC_quant_1_o_q_stream_fifo_io_pop_payload_data[63:0]), //i
    .y_s_stream_TVALID  (toplevel_htC_quant_1_o_s_stream_fifo_io_pop_valid             ), //i
    .y_s_stream_TREADY  (yz_1_y_s_stream_TREADY                                        ), //o
    .y_s_stream_TDATA   (toplevel_htC_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .z_stream_TVALID    (toplevel_silu_demux_1_z_stream_fifo_io_pop_valid              ), //i
    .z_stream_TREADY    (yz_1_z_stream_TREADY                                          ), //o
    .z_stream_TDATA     (toplevel_silu_demux_1_z_stream_fifo_io_pop_payload_data[63:0] ), //i
    .z_s_stream_TVALID  (toplevel_silu_demux_1_z_s_stream_fifo_io_pop_valid            ), //i
    .z_s_stream_TREADY  (yz_1_z_s_stream_TREADY                                        ), //o
    .z_s_stream_TDATA   (toplevel_silu_demux_1_z_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (yz_1_o_stream_TVALID                                          ), //o
    .o_stream_TREADY    (toplevel_yz_1_o_stream_fifo_io_push_ready                     ), //i
    .o_stream_TDATA     (yz_1_o_stream_TDATA[255:0]                                    )  //o
  );
  StreamFifo x_stream_fifo (
    .io_push_valid        (x_stream_TVALID                         ), //i
    .io_push_ready        (x_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (x_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (x_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (residual_1_x_stream_TREADY              ), //i
    .io_pop_payload_data  (x_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (x_stream_fifo_io_flush                  ), //i
    .io_occupancy         (x_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (x_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                     ), //i
    .resetn               (resetn                                  )  //i
  );
  StreamFifo w_stream_fifo (
    .io_push_valid        (w_stream_TVALID                         ), //i
    .io_push_ready        (w_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (w_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (w_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (gemm_1_w_stream_TREADY                  ), //i
    .io_pop_payload_data  (w_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (w_stream_fifo_io_flush                  ), //i
    .io_occupancy         (w_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (w_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                     ), //i
    .resetn               (resetn                                  )  //i
  );
  StreamFifo_2 s1_stream_fifo (
    .io_push_valid        (s1_stream_TVALID                        ), //i
    .io_push_ready        (s1_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (s1_stream_TDATA[23:0]                   ), //i
    .io_pop_valid         (s1_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_1_s1_stream_TREADY                 ), //i
    .io_pop_payload_data  (s1_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (s1_stream_fifo_io_flush                 ), //i
    .io_occupancy         (s1_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (s1_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                     ), //i
    .resetn               (resetn                                  )  //i
  );
  StreamFifo_2 s2_stream_fifo (
    .io_push_valid        (s2_stream_TVALID                        ), //i
    .io_push_ready        (s2_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (s2_stream_TDATA[23:0]                   ), //i
    .io_pop_valid         (s2_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_1_s2_stream_TREADY                 ), //i
    .io_pop_payload_data  (s2_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (s2_stream_fifo_io_flush                 ), //i
    .io_occupancy         (s2_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (s2_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                     ), //i
    .resetn               (resetn                                  )  //i
  );
  StreamFifo cq_stream_fifo (
    .io_push_valid        (cq_stream_TVALID                         ), //i
    .io_push_ready        (cq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (cq_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (cq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (conv_state_1_conv_stream_TREADY          ), //i
    .io_pop_payload_data  (cq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (cq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (cq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (cq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                      ), //i
    .resetn               (resetn                                   )  //i
  );
  StreamFifo cs_stream_fifo (
    .io_push_valid        (cs_stream_TVALID                         ), //i
    .io_push_ready        (cs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (cs_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (cs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (conv_state_1_conv_s_stream_TREADY        ), //i
    .io_pop_payload_data  (cs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (cs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (cs_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (cs_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                      ), //i
    .resetn               (resetn                                   )  //i
  );
  StreamFifo hq_stream_fifo (
    .io_push_valid        (hq_stream_TVALID                         ), //i
    .io_push_ready        (hq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (hq_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (hq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (ht_state_1_state_in_stream_TREADY        ), //i
    .io_pop_payload_data  (hq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (hq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (hq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (hq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                      ), //i
    .resetn               (resetn                                   )  //i
  );
  StreamFifo hs_stream_fifo (
    .io_push_valid        (hs_stream_TVALID                         ), //i
    .io_push_ready        (hs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (hs_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (hs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (ht_state_1_state_in_s_stream_TREADY      ), //i
    .io_pop_payload_data  (hs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (hs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (hs_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (hs_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                      ), //i
    .resetn               (resetn                                   )  //i
  );
  StreamFifo_8 toplevel_B_buffer_1_q_stream_fifo (
    .io_push_valid        (B_buffer_1_q_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_B_buffer_1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (B_buffer_1_q_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_B_buffer_1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dtB_quant_1_B_stream_TREADY                                ), //i
    .io_pop_payload_data  (toplevel_B_buffer_1_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_B_buffer_1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_B_buffer_1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_B_buffer_1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                        ), //i
    .resetn               (resetn                                                     )  //i
  );
  StreamFifo_9 toplevel_B_buffer_1_s_stream_fifo (
    .io_push_valid        (B_buffer_1_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_B_buffer_1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (B_buffer_1_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_B_buffer_1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dtB_quant_1_B_s_stream_TREADY                             ), //i
    .io_pop_payload_data  (toplevel_B_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_B_buffer_1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_B_buffer_1_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_B_buffer_1_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                       ), //i
    .resetn               (resetn                                                    )  //i
  );
  StreamFifo_8 toplevel_C_buffer_1_q_stream_fifo (
    .io_push_valid        (C_buffer_1_q_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_C_buffer_1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (C_buffer_1_q_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_C_buffer_1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (htC_quant_1_C_stream_TREADY                                ), //i
    .io_pop_payload_data  (toplevel_C_buffer_1_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_C_buffer_1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_C_buffer_1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_C_buffer_1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                        ), //i
    .resetn               (resetn                                                     )  //i
  );
  StreamFifo_9 toplevel_C_buffer_1_s_stream_fifo (
    .io_push_valid        (C_buffer_1_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_C_buffer_1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (C_buffer_1_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_C_buffer_1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (htC_quant_1_C_s_stream_TREADY                             ), //i
    .io_pop_payload_data  (toplevel_C_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_C_buffer_1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_C_buffer_1_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_C_buffer_1_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                       ), //i
    .resetn               (resetn                                                    )  //i
  );
  StreamFifo toplevel_conv_1_o_stream_fifo (
    .io_push_valid        (conv_1_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_conv_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (conv_1_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_conv_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (silu_mux_1_xBC_stream_TREADY                            ), //i
    .io_pop_payload_data  (toplevel_conv_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_conv_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_conv_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_conv_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                     ), //i
    .resetn               (resetn                                                  )  //i
  );
  StreamFifo_8 toplevel_conv_state_1_o_stream_fifo (
    .io_push_valid        (conv_state_1_o_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_conv_state_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (conv_state_1_o_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_conv_state_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (conv_1_i_stream_TREADY                                       ), //i
    .io_pop_payload_data  (toplevel_conv_state_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_conv_state_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_conv_state_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_conv_state_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_9 toplevel_conv_state_1_o_s_stream_fifo (
    .io_push_valid        (conv_state_1_o_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_conv_state_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (conv_state_1_o_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_conv_state_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (conv_1_s_stream_TREADY                                        ), //i
    .io_pop_payload_data  (toplevel_conv_state_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_conv_state_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_conv_state_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_conv_state_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_8 toplevel_conv_state_1_w_stream_fifo (
    .io_push_valid        (conv_state_1_w_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_conv_state_1_w_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (conv_state_1_w_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_conv_state_1_w_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (conv_1_w_stream_TREADY                                       ), //i
    .io_pop_payload_data  (toplevel_conv_state_1_w_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_conv_state_1_w_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_conv_state_1_w_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_conv_state_1_w_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_9 toplevel_conv_state_1_w_s_stream_fifo (
    .io_push_valid        (conv_state_1_w_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_conv_state_1_w_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (conv_state_1_w_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_conv_state_1_w_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (conv_1_w_s_stream_TREADY                                      ), //i
    .io_pop_payload_data  (toplevel_conv_state_1_w_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_conv_state_1_w_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_conv_state_1_w_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_conv_state_1_w_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_conv_state_1_conv_state_stream_fifo (
    .io_push_valid        (conv_state_1_conv_state_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_conv_state_1_conv_state_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (conv_state_1_conv_state_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_conv_state_1_conv_state_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cq2_stream_TREADY                                                      ), //i
    .io_pop_payload_data  (toplevel_conv_state_1_conv_state_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_conv_state_1_conv_state_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_conv_state_1_conv_state_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_conv_state_1_conv_state_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                    ), //i
    .resetn               (resetn                                                                 )  //i
  );
  StreamFifo toplevel_conv_state_1_conv_state_s_stream_fifo (
    .io_push_valid        (conv_state_1_conv_state_s_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_conv_state_1_conv_state_s_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (conv_state_1_conv_state_s_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_conv_state_1_conv_state_s_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cs2_stream_TREADY                                                        ), //i
    .io_pop_payload_data  (toplevel_conv_state_1_conv_state_s_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_conv_state_1_conv_state_s_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_conv_state_1_conv_state_s_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_conv_state_1_conv_state_s_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                      ), //i
    .resetn               (resetn                                                                   )  //i
  );
  StreamFifo toplevel_dAh_1_o_stream_fifo (
    .io_push_valid        (dAh_1_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_dAh_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (dAh_1_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_dAh_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (ht_add_quant_1_dAh_stream_TREADY                       ), //i
    .io_pop_payload_data  (toplevel_dAh_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_dAh_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_dAh_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_dAh_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                    ), //i
    .resetn               (resetn                                                 )  //i
  );
  StreamFifo toplevel_dBu_1_o_stream_fifo (
    .io_push_valid        (dBu_1_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_dBu_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (dBu_1_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_dBu_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (ht_add_quant_1_dBu_stream_TREADY                       ), //i
    .io_pop_payload_data  (toplevel_dBu_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_dBu_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_dBu_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_dBu_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                    ), //i
    .resetn               (resetn                                                 )  //i
  );
  StreamFifo toplevel_dtA_1_o_stream_fifo (
    .io_push_valid        (dtA_1_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_dtA_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (dtA_1_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_dtA_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (exp_quant_1_i_stream_TREADY                            ), //i
    .io_pop_payload_data  (toplevel_dtA_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_dtA_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_dtA_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_dtA_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                    ), //i
    .resetn               (resetn                                                 )  //i
  );
  StreamFifo_8 toplevel_dtadapt_1_o_stream_fifo (
    .io_push_valid        (dtadapt_1_o_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_dtadapt_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (dtadapt_1_o_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_dtadapt_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dtA_1_i_stream_TREADY                                     ), //i
    .io_pop_payload_data  (toplevel_dtadapt_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_dtadapt_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_dtadapt_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_dtadapt_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                       ), //i
    .resetn               (resetn                                                    )  //i
  );
  StreamFifo_9 toplevel_dtadapt_1_o_s_stream_fifo (
    .io_push_valid        (dtadapt_1_o_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_dtadapt_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (dtadapt_1_o_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_dtadapt_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dtA_1_s_stream_TREADY                                      ), //i
    .io_pop_payload_data  (toplevel_dtadapt_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_dtadapt_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_dtadapt_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_dtadapt_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                        ), //i
    .resetn               (resetn                                                     )  //i
  );
  StreamFifo_8 toplevel_dtadapt_1_o_stream2_fifo (
    .io_push_valid        (dtadapt_1_o_stream2_TVALID                                 ), //i
    .io_push_ready        (toplevel_dtadapt_1_o_stream2_fifo_io_push_ready            ), //o
    .io_push_payload_data (dtadapt_1_o_stream2_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_dtadapt_1_o_stream2_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dtB_quant_1_dt_stream_TREADY                               ), //i
    .io_pop_payload_data  (toplevel_dtadapt_1_o_stream2_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_dtadapt_1_o_stream2_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_dtadapt_1_o_stream2_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_dtadapt_1_o_stream2_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                        ), //i
    .resetn               (resetn                                                     )  //i
  );
  StreamFifo_9 toplevel_dtadapt_1_o_s_stream2_fifo (
    .io_push_valid        (dtadapt_1_o_s_stream2_TVALID                                ), //i
    .io_push_ready        (toplevel_dtadapt_1_o_s_stream2_fifo_io_push_ready           ), //o
    .io_push_payload_data (dtadapt_1_o_s_stream2_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_dtadapt_1_o_s_stream2_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dtB_quant_1_dt_s_stream_TREADY                              ), //i
    .io_pop_payload_data  (toplevel_dtadapt_1_o_s_stream2_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_dtadapt_1_o_s_stream2_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_dtadapt_1_o_s_stream2_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_dtadapt_1_o_s_stream2_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_8 toplevel_dtB_quant_1_o_stream_fifo (
    .io_push_valid        (dtB_quant_1_o_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_dtB_quant_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (dtB_quant_1_o_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_dtB_quant_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dBu_1_dB_stream_TREADY                                      ), //i
    .io_pop_payload_data  (toplevel_dtB_quant_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_dtB_quant_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_dtB_quant_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_dtB_quant_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_9 toplevel_dtB_quant_1_o_s_stream_fifo (
    .io_push_valid        (dtB_quant_1_o_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_dtB_quant_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (dtB_quant_1_o_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_dtB_quant_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dBu_1_dB_s_stream_TREADY                                     ), //i
    .io_pop_payload_data  (toplevel_dtB_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_dtB_quant_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_dtB_quant_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_dtB_quant_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_8 toplevel_exp_quant_1_o_stream_fifo (
    .io_push_valid        (exp_quant_1_o_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_exp_quant_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (exp_quant_1_o_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_exp_quant_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dAh_1_dA_stream_TREADY                                      ), //i
    .io_pop_payload_data  (toplevel_exp_quant_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_exp_quant_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_exp_quant_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_exp_quant_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_9 toplevel_exp_quant_1_o_s_stream_fifo (
    .io_push_valid        (exp_quant_1_o_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_exp_quant_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (exp_quant_1_o_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_exp_quant_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dAh_1_dA_s_stream_TREADY                                     ), //i
    .io_pop_payload_data  (toplevel_exp_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_exp_quant_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_exp_quant_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_exp_quant_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_gemm_1_o_stream_fifo (
    .io_push_valid        (gemm_1_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_gemm_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_1_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_gemm_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (gemm_demux_1_gemm_stream_TREADY                         ), //i
    .io_pop_payload_data  (toplevel_gemm_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_gemm_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_gemm_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_gemm_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                     ), //i
    .resetn               (resetn                                                  )  //i
  );
  StreamFifo toplevel_gemm_demux_1_dt_stream_fifo (
    .io_push_valid        (gemm_demux_1_dt_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_gemm_demux_1_dt_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_dt_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_gemm_demux_1_dt_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (dtadapt_1_i_stream_TREADY                                      ), //i
    .io_pop_payload_data  (toplevel_gemm_demux_1_dt_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_gemm_demux_1_dt_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_gemm_demux_1_dt_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_gemm_demux_1_dt_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo toplevel_gemm_demux_1_xBC_stream_fifo (
    .io_push_valid        (gemm_demux_1_xBC_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_gemm_demux_1_xBC_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_xBC_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_gemm_demux_1_xBC_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (quant_conv_1_i_stream_TREADY                                    ), //i
    .io_pop_payload_data  (toplevel_gemm_demux_1_xBC_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_gemm_demux_1_xBC_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_gemm_demux_1_xBC_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_gemm_demux_1_xBC_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo toplevel_gemm_demux_1_z_stream_fifo (
    .io_push_valid        (gemm_demux_1_z_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_gemm_demux_1_z_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_z_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_gemm_demux_1_z_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (silu_mux_1_z_stream_TREADY                                    ), //i
    .io_pop_payload_data  (toplevel_gemm_demux_1_z_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_gemm_demux_1_z_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_gemm_demux_1_z_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_gemm_demux_1_z_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_gemm_demux_1_out_stream_fifo (
    .io_push_valid        (gemm_demux_1_out_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_gemm_demux_1_out_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_out_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_gemm_demux_1_out_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (residual_1_res_i_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_gemm_demux_1_out_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_gemm_demux_1_out_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_gemm_demux_1_out_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_gemm_demux_1_out_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_35 toplevel_gemm_mux_1_q_stream_fifo (
    .io_push_valid        (gemm_mux_1_q_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_gemm_mux_1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (gemm_mux_1_q_stream_TDATA[31:0]                            ), //i
    .io_pop_valid         (toplevel_gemm_mux_1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_1_i_stream_TREADY                                     ), //i
    .io_pop_payload_data  (toplevel_gemm_mux_1_q_stream_fifo_io_pop_payload_data[31:0]), //o
    .io_flush             (toplevel_gemm_mux_1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_gemm_mux_1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_gemm_mux_1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                        ), //i
    .resetn               (resetn                                                     )  //i
  );
  StreamFifo_36 toplevel_gemm_mux_1_s_stream_fifo (
    .io_push_valid        (gemm_mux_1_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_gemm_mux_1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (gemm_mux_1_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_gemm_mux_1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (gemm_1_s_stream_TREADY                                    ), //i
    .io_pop_payload_data  (toplevel_gemm_mux_1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_gemm_mux_1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_gemm_mux_1_s_stream_fifo_io_occupancy[9:0]       ), //o
    .io_availability      (toplevel_gemm_mux_1_s_stream_fifo_io_availability[9:0]    ), //o
    .clk                  (clk                                                       ), //i
    .resetn               (resetn                                                    )  //i
  );
  StreamFifo_8 toplevel_ht_add_quant_1_ht1_q_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht1_q_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (ht_add_quant_1_ht1_q_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ht_state_1_ht_in_stream_TREADY                                     ), //i
    .io_pop_payload_data  (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                                ), //i
    .resetn               (resetn                                                             )  //i
  );
  StreamFifo_9 toplevel_ht_add_quant_1_ht1_s_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht1_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (ht_add_quant_1_ht1_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (ht_state_1_ht_in_s_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                               ), //i
    .resetn               (resetn                                                            )  //i
  );
  StreamFifo_8 toplevel_ht_add_quant_1_ht2_q_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht2_q_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (ht_add_quant_1_ht2_q_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (htC_quant_1_ht_stream_TREADY                                       ), //i
    .io_pop_payload_data  (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                                ), //i
    .resetn               (resetn                                                             )  //i
  );
  StreamFifo_9 toplevel_ht_add_quant_1_ht2_s_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht2_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (ht_add_quant_1_ht2_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (htC_quant_1_ht_s_stream_TREADY                                    ), //i
    .io_pop_payload_data  (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                               ), //i
    .resetn               (resetn                                                            )  //i
  );
  StreamFifo_41 toplevel_ht_state_1_ht_out_stream_fifo (
    .io_push_valid        (ht_state_1_ht_out_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_ht_state_1_ht_out_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (ht_state_1_ht_out_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_ht_state_1_ht_out_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dAh_1_ht_stream_TREADY                                          ), //i
    .io_pop_payload_data  (toplevel_ht_state_1_ht_out_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_ht_state_1_ht_out_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_ht_state_1_ht_out_stream_fifo_io_occupancy[6:0]        ), //o
    .io_availability      (toplevel_ht_state_1_ht_out_stream_fifo_io_availability[6:0]     ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_42 toplevel_ht_state_1_ht_out_s_stream_fifo (
    .io_push_valid        (ht_state_1_ht_out_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_ht_state_1_ht_out_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (ht_state_1_ht_out_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_ht_state_1_ht_out_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dAh_1_ht_s_stream_TREADY                                         ), //i
    .io_pop_payload_data  (toplevel_ht_state_1_ht_out_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_ht_state_1_ht_out_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_ht_state_1_ht_out_s_stream_fifo_io_occupancy[6:0]       ), //o
    .io_availability      (toplevel_ht_state_1_ht_out_s_stream_fifo_io_availability[6:0]    ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo toplevel_ht_state_1_state_out_stream_fifo (
    .io_push_valid        (ht_state_1_state_out_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_ht_state_1_state_out_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (ht_state_1_state_out_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_ht_state_1_state_out_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hq2_stream_TREADY                                                   ), //i
    .io_pop_payload_data  (toplevel_ht_state_1_state_out_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_ht_state_1_state_out_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_ht_state_1_state_out_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_ht_state_1_state_out_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                 ), //i
    .resetn               (resetn                                                              )  //i
  );
  StreamFifo toplevel_ht_state_1_state_out_s_stream_fifo (
    .io_push_valid        (ht_state_1_state_out_s_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_ht_state_1_state_out_s_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (ht_state_1_state_out_s_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_ht_state_1_state_out_s_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hs2_stream_TREADY                                                     ), //i
    .io_pop_payload_data  (toplevel_ht_state_1_state_out_s_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_ht_state_1_state_out_s_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_ht_state_1_state_out_s_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_ht_state_1_state_out_s_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                   ), //i
    .resetn               (resetn                                                                )  //i
  );
  StreamFifo_8 toplevel_htC_quant_1_o_q_stream_fifo (
    .io_push_valid        (htC_quant_1_o_q_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_htC_quant_1_o_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (htC_quant_1_o_q_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_htC_quant_1_o_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (yz_1_y_stream_TREADY                                          ), //i
    .io_pop_payload_data  (toplevel_htC_quant_1_o_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_htC_quant_1_o_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_htC_quant_1_o_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_htC_quant_1_o_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_9 toplevel_htC_quant_1_o_s_stream_fifo (
    .io_push_valid        (htC_quant_1_o_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_htC_quant_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (htC_quant_1_o_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_htC_quant_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (yz_1_y_s_stream_TREADY                                       ), //i
    .io_pop_payload_data  (toplevel_htC_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_htC_quant_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_htC_quant_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_htC_quant_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_8 toplevel_quant_conv_1_o_stream_fifo (
    .io_push_valid        (quant_conv_1_o_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_quant_conv_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (quant_conv_1_o_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_quant_conv_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (conv_state_1_xBC_stream_TREADY                               ), //i
    .io_pop_payload_data  (toplevel_quant_conv_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_quant_conv_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_quant_conv_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_quant_conv_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_9 toplevel_quant_conv_1_o_s_stream_fifo (
    .io_push_valid        (quant_conv_1_o_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_quant_conv_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (quant_conv_1_o_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_quant_conv_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (conv_state_1_xBC_s_stream_TREADY                              ), //i
    .io_pop_payload_data  (toplevel_quant_conv_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_quant_conv_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_quant_conv_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_quant_conv_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_residual_1_res_o_stream_fifo (
    .io_push_valid        (residual_1_res_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_residual_1_res_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (residual_1_res_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_residual_1_res_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (rms_quant_1_x_stream_TREADY                                     ), //i
    .io_pop_payload_data  (toplevel_residual_1_res_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_residual_1_res_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_residual_1_res_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_residual_1_res_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo toplevel_residual_1_y_stream_fifo (
    .io_push_valid        (residual_1_y_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_residual_1_y_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (residual_1_y_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_residual_1_y_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (y_stream_TREADY                                             ), //i
    .io_pop_payload_data  (toplevel_residual_1_y_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_residual_1_y_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_residual_1_y_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_residual_1_y_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_35 toplevel_rms_quant_1_xlnq_stream_fifo (
    .io_push_valid        (rms_quant_1_xlnq_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_rms_quant_1_xlnq_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (rms_quant_1_xlnq_stream_TDATA[31:0]                            ), //i
    .io_pop_valid         (toplevel_rms_quant_1_xlnq_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_mux_1_xlnq1_stream_TREADY                                 ), //i
    .io_pop_payload_data  (toplevel_rms_quant_1_xlnq_stream_fifo_io_pop_payload_data[31:0]), //o
    .io_flush             (toplevel_rms_quant_1_xlnq_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_rms_quant_1_xlnq_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_rms_quant_1_xlnq_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_9 toplevel_rms_quant_1_xlns_stream_fifo (
    .io_push_valid        (rms_quant_1_xlns_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_rms_quant_1_xlns_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (rms_quant_1_xlns_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_rms_quant_1_xlns_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (gemm_mux_1_xlns1_stream_TREADY                                ), //i
    .io_pop_payload_data  (toplevel_rms_quant_1_xlns_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_rms_quant_1_xlns_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_rms_quant_1_xlns_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_rms_quant_1_xlns_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_35 toplevel_rms_quant_2_xlnq_stream_fifo (
    .io_push_valid        (rms_quant_2_xlnq_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_rms_quant_2_xlnq_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (rms_quant_2_xlnq_stream_TDATA[31:0]                            ), //i
    .io_pop_valid         (toplevel_rms_quant_2_xlnq_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_mux_1_xlnq2_stream_TREADY                                 ), //i
    .io_pop_payload_data  (toplevel_rms_quant_2_xlnq_stream_fifo_io_pop_payload_data[31:0]), //o
    .io_flush             (toplevel_rms_quant_2_xlnq_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_rms_quant_2_xlnq_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_rms_quant_2_xlnq_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_9 toplevel_rms_quant_2_xlns_stream_fifo (
    .io_push_valid        (rms_quant_2_xlns_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_rms_quant_2_xlns_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (rms_quant_2_xlns_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_rms_quant_2_xlns_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (gemm_mux_1_xlns2_stream_TREADY                                ), //i
    .io_pop_payload_data  (toplevel_rms_quant_2_xlns_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_rms_quant_2_xlns_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_rms_quant_2_xlns_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_rms_quant_2_xlns_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_8 toplevel_silu_demux_1_x_stream_fifo (
    .io_push_valid        (silu_demux_1_x_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_silu_demux_1_x_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_x_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_x_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dBu_1_u_stream_TREADY                                        ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_x_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_silu_demux_1_x_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_silu_demux_1_x_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_silu_demux_1_x_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_9 toplevel_silu_demux_1_x_s_stream_fifo (
    .io_push_valid        (silu_demux_1_x_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_silu_demux_1_x_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_x_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_x_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dBu_1_u_s_stream_TREADY                                       ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_x_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_silu_demux_1_x_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_silu_demux_1_x_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_silu_demux_1_x_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_8 toplevel_silu_demux_1_x_stream2_fifo (
    .io_push_valid        (silu_demux_1_x_stream2_TVALID                                 ), //i
    .io_push_ready        (toplevel_silu_demux_1_x_stream2_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_x_stream2_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_x_stream2_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ud_1_i_stream_TREADY                                          ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_x_stream2_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_silu_demux_1_x_stream2_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_silu_demux_1_x_stream2_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_silu_demux_1_x_stream2_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_9 toplevel_silu_demux_1_x_s_stream2_fifo (
    .io_push_valid        (silu_demux_1_x_s_stream2_TVALID                                ), //i
    .io_push_ready        (toplevel_silu_demux_1_x_s_stream2_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_x_s_stream2_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_x_s_stream2_fifo_io_pop_valid            ), //o
    .io_pop_ready         (ud_1_s_stream_TREADY                                           ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_x_s_stream2_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_silu_demux_1_x_s_stream2_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_silu_demux_1_x_s_stream2_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_silu_demux_1_x_s_stream2_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_8 toplevel_silu_demux_1_B_stream_fifo (
    .io_push_valid        (silu_demux_1_B_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_silu_demux_1_B_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_B_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_B_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (B_buffer_1_i_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_B_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_silu_demux_1_B_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_silu_demux_1_B_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_silu_demux_1_B_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_9 toplevel_silu_demux_1_B_s_stream_fifo (
    .io_push_valid        (silu_demux_1_B_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_silu_demux_1_B_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_B_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_B_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (B_buffer_1_i_s_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_B_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_silu_demux_1_B_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_silu_demux_1_B_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_silu_demux_1_B_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_8 toplevel_silu_demux_1_C_stream_fifo (
    .io_push_valid        (silu_demux_1_C_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_silu_demux_1_C_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_C_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_C_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (C_buffer_1_i_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_C_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_silu_demux_1_C_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_silu_demux_1_C_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_silu_demux_1_C_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_9 toplevel_silu_demux_1_C_s_stream_fifo (
    .io_push_valid        (silu_demux_1_C_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_silu_demux_1_C_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_C_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_C_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (C_buffer_1_i_s_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_C_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_silu_demux_1_C_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_silu_demux_1_C_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_silu_demux_1_C_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_8 toplevel_silu_demux_1_z_stream_fifo (
    .io_push_valid        (silu_demux_1_z_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_silu_demux_1_z_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_z_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_z_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (yz_1_z_stream_TREADY                                         ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_z_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_silu_demux_1_z_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_silu_demux_1_z_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_silu_demux_1_z_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_9 toplevel_silu_demux_1_z_s_stream_fifo (
    .io_push_valid        (silu_demux_1_z_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_silu_demux_1_z_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_z_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_silu_demux_1_z_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (yz_1_z_s_stream_TREADY                                        ), //i
    .io_pop_payload_data  (toplevel_silu_demux_1_z_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_silu_demux_1_z_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_silu_demux_1_z_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_silu_demux_1_z_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_silu_mux_1_silu_stream_fifo (
    .io_push_valid        (silu_mux_1_silu_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_silu_mux_1_silu_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (silu_mux_1_silu_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_silu_mux_1_silu_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (silu_quant_1_i_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_silu_mux_1_silu_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_silu_mux_1_silu_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_silu_mux_1_silu_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_silu_mux_1_silu_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_8 toplevel_silu_quant_1_out_stream_fifo (
    .io_push_valid        (silu_quant_1_out_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_silu_quant_1_out_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_quant_1_out_stream_TDATA[63:0]                            ), //i
    .io_pop_valid         (toplevel_silu_quant_1_out_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (silu_demux_1_silu_stream_TREADY                                ), //i
    .io_pop_payload_data  (toplevel_silu_quant_1_out_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (toplevel_silu_quant_1_out_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_silu_quant_1_out_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_silu_quant_1_out_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_9 toplevel_silu_quant_1_out_s_stream_fifo (
    .io_push_valid        (silu_quant_1_out_s_stream_TVALID                                ), //i
    .io_push_ready        (toplevel_silu_quant_1_out_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_quant_1_out_s_stream_TDATA[7:0]                            ), //i
    .io_pop_valid         (toplevel_silu_quant_1_out_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (silu_demux_1_silu_s_stream_TREADY                               ), //i
    .io_pop_payload_data  (toplevel_silu_quant_1_out_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (toplevel_silu_quant_1_out_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (toplevel_silu_quant_1_out_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (toplevel_silu_quant_1_out_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo toplevel_ud_1_o_stream_fifo (
    .io_push_valid        (ud_1_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_ud_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (ud_1_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_ud_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (htC_quant_1_uD_stream_TREADY                          ), //i
    .io_pop_payload_data  (toplevel_ud_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_ud_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_ud_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_ud_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                   ), //i
    .resetn               (resetn                                                )  //i
  );
  StreamFifo toplevel_yz_1_o_stream_fifo (
    .io_push_valid        (yz_1_o_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_yz_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (yz_1_o_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_yz_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (rms_quant_2_x_stream_TREADY                           ), //i
    .io_pop_payload_data  (toplevel_yz_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_yz_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_yz_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_yz_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                   ), //i
    .resetn               (resetn                                                )  //i
  );
  assign signals_O_L_BEGIN = yz_1_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = yz_1_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = yz_1_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = yz_1_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = yz_1_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = yz_1_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = yz_1_signals_O_MEMORY_H;
  assign signals_O_POS = yz_1_signals_O_POS;
  assign signals_O_T = yz_1_signals_O_T;
  assign x_stream_TREADY = x_stream_fifo_io_push_ready;
  assign w_stream_TREADY = w_stream_fifo_io_push_ready;
  assign s1_stream_TREADY = s1_stream_fifo_io_push_ready;
  assign s2_stream_TREADY = s2_stream_fifo_io_push_ready;
  assign cq_stream_TREADY = cq_stream_fifo_io_push_ready;
  assign cs_stream_TREADY = cs_stream_fifo_io_push_ready;
  assign hq_stream_TREADY = hq_stream_fifo_io_push_ready;
  assign hs_stream_TREADY = hs_stream_fifo_io_push_ready;
  assign cq2_stream_TVALID = toplevel_conv_state_1_conv_state_stream_fifo_io_pop_valid;
  assign cq2_stream_TDATA = toplevel_conv_state_1_conv_state_stream_fifo_io_pop_payload_data;
  assign cs2_stream_TVALID = toplevel_conv_state_1_conv_state_s_stream_fifo_io_pop_valid;
  assign cs2_stream_TDATA = toplevel_conv_state_1_conv_state_s_stream_fifo_io_pop_payload_data;
  assign hq2_stream_TVALID = toplevel_ht_state_1_state_out_stream_fifo_io_pop_valid;
  assign hq2_stream_TDATA = toplevel_ht_state_1_state_out_stream_fifo_io_pop_payload_data;
  assign hs2_stream_TVALID = toplevel_ht_state_1_state_out_s_stream_fifo_io_pop_valid;
  assign hs2_stream_TDATA = toplevel_ht_state_1_state_out_s_stream_fifo_io_pop_payload_data;
  assign y_stream_TVALID = toplevel_residual_1_y_stream_fifo_io_pop_valid;
  assign y_stream_TDATA = toplevel_residual_1_y_stream_fifo_io_pop_payload_data;
  assign x_stream_fifo_io_flush = 1'b0;
  assign w_stream_fifo_io_flush = 1'b0;
  assign s1_stream_fifo_io_flush = 1'b0;
  assign s2_stream_fifo_io_flush = 1'b0;
  assign cq_stream_fifo_io_flush = 1'b0;
  assign cs_stream_fifo_io_flush = 1'b0;
  assign hq_stream_fifo_io_flush = 1'b0;
  assign hs_stream_fifo_io_flush = 1'b0;
  assign toplevel_B_buffer_1_q_stream_fifo_io_flush = 1'b0;
  assign toplevel_B_buffer_1_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_C_buffer_1_q_stream_fifo_io_flush = 1'b0;
  assign toplevel_C_buffer_1_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_conv_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_conv_state_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_conv_state_1_o_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_conv_state_1_w_stream_fifo_io_flush = 1'b0;
  assign toplevel_conv_state_1_w_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_conv_state_1_conv_state_stream_fifo_io_flush = 1'b0;
  assign toplevel_conv_state_1_conv_state_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_dAh_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_dBu_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_dtA_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_dtadapt_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_dtadapt_1_o_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_dtadapt_1_o_stream2_fifo_io_flush = 1'b0;
  assign toplevel_dtadapt_1_o_s_stream2_fifo_io_flush = 1'b0;
  assign toplevel_dtB_quant_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_dtB_quant_1_o_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_exp_quant_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_exp_quant_1_o_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_gemm_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_gemm_demux_1_dt_stream_fifo_io_flush = 1'b0;
  assign toplevel_gemm_demux_1_xBC_stream_fifo_io_flush = 1'b0;
  assign toplevel_gemm_demux_1_z_stream_fifo_io_flush = 1'b0;
  assign toplevel_gemm_demux_1_out_stream_fifo_io_flush = 1'b0;
  assign toplevel_gemm_mux_1_q_stream_fifo_io_flush = 1'b0;
  assign toplevel_gemm_mux_1_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_add_quant_1_ht1_q_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_add_quant_1_ht1_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_add_quant_1_ht2_q_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_add_quant_1_ht2_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_state_1_ht_out_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_state_1_ht_out_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_state_1_state_out_stream_fifo_io_flush = 1'b0;
  assign toplevel_ht_state_1_state_out_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_htC_quant_1_o_q_stream_fifo_io_flush = 1'b0;
  assign toplevel_htC_quant_1_o_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_quant_conv_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_quant_conv_1_o_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_residual_1_res_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_residual_1_y_stream_fifo_io_flush = 1'b0;
  assign toplevel_rms_quant_1_xlnq_stream_fifo_io_flush = 1'b0;
  assign toplevel_rms_quant_1_xlns_stream_fifo_io_flush = 1'b0;
  assign toplevel_rms_quant_2_xlnq_stream_fifo_io_flush = 1'b0;
  assign toplevel_rms_quant_2_xlns_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_x_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_x_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_x_stream2_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_x_s_stream2_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_B_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_B_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_C_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_C_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_z_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_demux_1_z_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_mux_1_silu_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_quant_1_out_stream_fifo_io_flush = 1'b0;
  assign toplevel_silu_quant_1_out_s_stream_fifo_io_flush = 1'b0;
  assign toplevel_ud_1_o_stream_fifo_io_flush = 1'b0;
  assign toplevel_yz_1_o_stream_fifo_io_flush = 1'b0;

endmodule

//StreamFifo_69 replaced by StreamFifo

//StreamFifo_68 replaced by StreamFifo

//StreamFifo_67 replaced by StreamFifo_9

//StreamFifo_66 replaced by StreamFifo_8

//StreamFifo_65 replaced by StreamFifo

//StreamFifo_64 replaced by StreamFifo_9

//StreamFifo_63 replaced by StreamFifo_8

//StreamFifo_62 replaced by StreamFifo_9

//StreamFifo_61 replaced by StreamFifo_8

//StreamFifo_60 replaced by StreamFifo_9

//StreamFifo_59 replaced by StreamFifo_8

//StreamFifo_58 replaced by StreamFifo_9

//StreamFifo_57 replaced by StreamFifo_8

//StreamFifo_56 replaced by StreamFifo_9

//StreamFifo_55 replaced by StreamFifo_8

//StreamFifo_54 replaced by StreamFifo_9

//StreamFifo_53 replaced by StreamFifo_35

//StreamFifo_52 replaced by StreamFifo_9

//StreamFifo_51 replaced by StreamFifo_35

//StreamFifo_50 replaced by StreamFifo

//StreamFifo_49 replaced by StreamFifo

//StreamFifo_48 replaced by StreamFifo_9

//StreamFifo_47 replaced by StreamFifo_8

//StreamFifo_46 replaced by StreamFifo_9

//StreamFifo_45 replaced by StreamFifo_8

//StreamFifo_44 replaced by StreamFifo

//StreamFifo_43 replaced by StreamFifo

module StreamFifo_42 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload_data,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [7:0]    _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [6:0]    logic_ptr_push;
  reg        [6:0]    logic_ptr_pop;
  wire       [6:0]    logic_ptr_occupancy;
  wire       [6:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [5:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [5:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [5:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [5:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [5:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [6:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:63];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 7'h40) == 7'h00);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[5:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[5:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[7 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (7'h40 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 7'h00;
      logic_ptr_pop <= 7'h00;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 7'h00;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 7'h01);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 7'h01);
      end
      if(io_flush) begin
        logic_ptr_push <= 7'h00;
        logic_ptr_pop <= 7'h00;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 7'h00;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

module StreamFifo_41 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [63:0]   io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [63:0]   io_pop_payload_data,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [63:0]   _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [6:0]    logic_ptr_push;
  reg        [6:0]    logic_ptr_pop;
  wire       [6:0]    logic_ptr_occupancy;
  wire       [6:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [5:0]    logic_push_onRam_write_payload_address;
  wire       [63:0]   logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [5:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [5:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [5:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [5:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [63:0]   logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [63:0]   logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [6:0]    logic_pop_sync_popReg;
  reg [63:0] logic_ram [0:63];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 7'h40) == 7'h00);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[5:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[5:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[63 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (7'h40 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 7'h00;
      logic_ptr_pop <= 7'h00;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 7'h00;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 7'h01);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 7'h01);
      end
      if(io_flush) begin
        logic_ptr_push <= 7'h00;
        logic_ptr_pop <= 7'h00;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 7'h00;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

//StreamFifo_40 replaced by StreamFifo_9

//StreamFifo_39 replaced by StreamFifo_8

//StreamFifo_38 replaced by StreamFifo_9

//StreamFifo_37 replaced by StreamFifo_8

module StreamFifo_36 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload_data,
  input  wire          io_flush,
  output wire [9:0]    io_occupancy,
  output wire [9:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [7:0]    _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [9:0]    logic_ptr_push;
  reg        [9:0]    logic_ptr_pop;
  wire       [9:0]    logic_ptr_occupancy;
  wire       [9:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [8:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [8:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [8:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [8:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [8:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [9:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:511];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 10'h200) == 10'h000);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[8:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[8:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[7 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (10'h200 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 10'h000;
      logic_ptr_pop <= 10'h000;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 10'h000;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 10'h001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 10'h001);
      end
      if(io_flush) begin
        logic_ptr_push <= 10'h000;
        logic_ptr_pop <= 10'h000;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 10'h000;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

module StreamFifo_35 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [31:0]   io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [31:0]   io_pop_payload_data,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [31:0]   _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [31:0]   logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [31:0]   logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [31:0]   logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [31:0] logic_ram [0:7];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[31 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (4'b1000 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 4'b0000;
      logic_ptr_pop <= 4'b0000;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 4'b0000;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001);
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000;
        logic_ptr_pop <= 4'b0000;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

//StreamFifo_34 replaced by StreamFifo

//StreamFifo_33 replaced by StreamFifo

//StreamFifo_32 replaced by StreamFifo

//StreamFifo_31 replaced by StreamFifo

//StreamFifo_30 replaced by StreamFifo

//StreamFifo_29 replaced by StreamFifo_9

//StreamFifo_28 replaced by StreamFifo_8

//StreamFifo_27 replaced by StreamFifo_9

//StreamFifo_26 replaced by StreamFifo_8

//StreamFifo_25 replaced by StreamFifo_9

//StreamFifo_24 replaced by StreamFifo_8

//StreamFifo_23 replaced by StreamFifo_9

//StreamFifo_22 replaced by StreamFifo_8

//StreamFifo_21 replaced by StreamFifo

//StreamFifo_20 replaced by StreamFifo

//StreamFifo_19 replaced by StreamFifo

//StreamFifo_18 replaced by StreamFifo

//StreamFifo_17 replaced by StreamFifo

//StreamFifo_16 replaced by StreamFifo_9

//StreamFifo_15 replaced by StreamFifo_8

//StreamFifo_14 replaced by StreamFifo_9

//StreamFifo_13 replaced by StreamFifo_8

//StreamFifo_12 replaced by StreamFifo

//StreamFifo_11 replaced by StreamFifo_9

//StreamFifo_10 replaced by StreamFifo_8

module StreamFifo_9 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload_data,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [7:0]    _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:7];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[7 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (4'b1000 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 4'b0000;
      logic_ptr_pop <= 4'b0000;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 4'b0000;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001);
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000;
        logic_ptr_pop <= 4'b0000;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

module StreamFifo_8 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [63:0]   io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [63:0]   io_pop_payload_data,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [63:0]   _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [63:0]   logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [63:0]   logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [63:0]   logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [63:0] logic_ram [0:7];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[63 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (4'b1000 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 4'b0000;
      logic_ptr_pop <= 4'b0000;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 4'b0000;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001);
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000;
        logic_ptr_pop <= 4'b0000;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

//StreamFifo_7 replaced by StreamFifo

//StreamFifo_6 replaced by StreamFifo

//StreamFifo_5 replaced by StreamFifo

//StreamFifo_4 replaced by StreamFifo

//StreamFifo_3 replaced by StreamFifo_2

module StreamFifo_2 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [23:0]   io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [23:0]   io_pop_payload_data,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [23:0]   _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [23:0]   logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [23:0]   logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [23:0]   logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [23:0] logic_ram [0:7];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[23 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (4'b1000 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 4'b0000;
      logic_ptr_pop <= 4'b0000;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 4'b0000;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001);
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000;
        logic_ptr_pop <= 4'b0000;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

//StreamFifo_1 replaced by StreamFifo

module StreamFifo (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [255:0]  io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [255:0]  io_pop_payload_data,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [255:0]  _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [255:0]  logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [255:0]  logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [255:0]  logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [255:0] logic_ram [0:7];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      _zz_logic_ram_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1205 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l369) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[255 : 0];
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_data = logic_pop_sync_readPort_rsp_data;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_data = logic_pop_sync_readArbitation_translated_payload_data;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (4'b1000 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 4'b0000;
      logic_ptr_pop <= 4'b0000;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 4'b0000;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001);
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000;
        logic_ptr_pop <= 4'b0000;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

module YZ_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          y_stream_TVALID,
  output wire          y_stream_TREADY,
  input  wire [63:0]   y_stream_TDATA,
  input  wire          y_s_stream_TVALID,
  output wire          y_s_stream_TREADY,
  input  wire [7:0]    y_s_stream_TDATA,
  input  wire          z_stream_TVALID,
  output wire          z_stream_TREADY,
  input  wire [63:0]   z_stream_TDATA,
  input  wire          z_s_stream_TVALID,
  output wire          z_s_stream_TREADY,
  input  wire [7:0]    z_s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [255:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_y_stream_TREADY;
  wire                black_box_y_s_stream_TREADY;
  wire                black_box_z_stream_TREADY;
  wire                black_box_z_s_stream_TREADY;
  wire       [255:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  YZ black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .ap_start          (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle           (black_box_ap_idle              ), //o
    .ap_ready          (black_box_ap_ready             ), //o
    .ap_done           (black_box_ap_done              ), //o
    .y_stream_TDATA    (y_stream_TDATA[63:0]           ), //i
    .y_stream_TVALID   (y_stream_TVALID                ), //i
    .y_stream_TREADY   (black_box_y_stream_TREADY      ), //o
    .y_s_stream_TDATA  (y_s_stream_TDATA[7:0]          ), //i
    .y_s_stream_TVALID (y_s_stream_TVALID              ), //i
    .y_s_stream_TREADY (black_box_y_s_stream_TREADY    ), //o
    .z_stream_TDATA    (z_stream_TDATA[63:0]           ), //i
    .z_stream_TVALID   (z_stream_TVALID                ), //i
    .z_stream_TREADY   (black_box_z_stream_TREADY      ), //o
    .z_s_stream_TDATA  (z_s_stream_TDATA[7:0]          ), //i
    .z_s_stream_TVALID (z_s_stream_TVALID              ), //i
    .z_s_stream_TREADY (black_box_z_s_stream_TREADY    ), //o
    .o_stream_TDATA    (black_box_o_stream_TDATA[255:0]), //o
    .o_stream_TVALID   (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY   (o_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign y_stream_TREADY = black_box_y_stream_TREADY;
  assign y_s_stream_TREADY = black_box_y_s_stream_TREADY;
  assign z_stream_TREADY = black_box_z_stream_TREADY;
  assign z_s_stream_TREADY = black_box_z_s_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

module UD_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [63:0]   i_stream_TDATA,
  input  wire          s_stream_TVALID,
  output wire          s_stream_TREADY,
  input  wire [7:0]    s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [255:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire                black_box_s_stream_TREADY;
  wire       [255:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  UD black_box (
    .ap_clk          (clk                            ), //i
    .ap_rst_n        (resetn                         ), //i
    .l               (manager_25_l[31:0]             ), //i
    .ap_start        (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue     (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle         (black_box_ap_idle              ), //o
    .ap_ready        (black_box_ap_ready             ), //o
    .ap_done         (black_box_ap_done              ), //o
    .i_stream_TDATA  (i_stream_TDATA[63:0]           ), //i
    .i_stream_TVALID (i_stream_TVALID                ), //i
    .i_stream_TREADY (black_box_i_stream_TREADY      ), //o
    .s_stream_TDATA  (s_stream_TDATA[7:0]            ), //i
    .s_stream_TVALID (s_stream_TVALID                ), //i
    .s_stream_TREADY (black_box_s_stream_TREADY      ), //o
    .o_stream_TDATA  (black_box_o_stream_TDATA[255:0]), //o
    .o_stream_TVALID (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY (o_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign s_stream_TREADY = black_box_s_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

module SILU_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [255:0]  i_stream_TDATA,
  output wire          out_stream_TVALID,
  input  wire          out_stream_TREADY,
  output wire [63:0]   out_stream_TDATA,
  output wire          out_s_stream_TVALID,
  input  wire          out_s_stream_TREADY,
  output wire [7:0]    out_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire       [63:0]   black_box_out_stream_TDATA;
  wire                black_box_out_stream_TVALID;
  wire       [7:0]    black_box_out_s_stream_TDATA;
  wire                black_box_out_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  SILU_QUANT black_box (
    .ap_clk              (clk                              ), //i
    .ap_rst_n            (resetn                           ), //i
    .ap_start            (manager_25_ap_ctrl_ap_start      ), //i
    .ap_continue         (manager_25_ap_ctrl_ap_continue   ), //i
    .ap_idle             (black_box_ap_idle                ), //o
    .ap_ready            (black_box_ap_ready               ), //o
    .ap_done             (black_box_ap_done                ), //o
    .i_stream_TDATA      (i_stream_TDATA[255:0]            ), //i
    .i_stream_TVALID     (i_stream_TVALID                  ), //i
    .i_stream_TREADY     (black_box_i_stream_TREADY        ), //o
    .out_stream_TDATA    (black_box_out_stream_TDATA[63:0] ), //o
    .out_stream_TVALID   (black_box_out_stream_TVALID      ), //o
    .out_stream_TREADY   (out_stream_TREADY                ), //i
    .out_s_stream_TDATA  (black_box_out_s_stream_TDATA[7:0]), //o
    .out_s_stream_TVALID (black_box_out_s_stream_TVALID    ), //o
    .out_s_stream_TREADY (out_s_stream_TREADY              )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign out_stream_TDATA = black_box_out_stream_TDATA;
  assign out_stream_TVALID = black_box_out_stream_TVALID;
  assign out_s_stream_TDATA = black_box_out_s_stream_TDATA;
  assign out_s_stream_TVALID = black_box_out_s_stream_TVALID;

endmodule

module SILU_MUX_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          xBC_stream_TVALID,
  output wire          xBC_stream_TREADY,
  input  wire [255:0]  xBC_stream_TDATA,
  input  wire          z_stream_TVALID,
  output wire          z_stream_TREADY,
  input  wire [255:0]  z_stream_TDATA,
  output wire          silu_stream_TVALID,
  input  wire          silu_stream_TREADY,
  output wire [255:0]  silu_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_xBC_stream_TREADY;
  wire                black_box_z_stream_TREADY;
  wire       [255:0]  black_box_silu_stream_TDATA;
  wire                black_box_silu_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  SILU_MUX black_box (
    .ap_clk             (clk                               ), //i
    .ap_rst_n           (resetn                            ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start       ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue    ), //i
    .ap_idle            (black_box_ap_idle                 ), //o
    .ap_ready           (black_box_ap_ready                ), //o
    .ap_done            (black_box_ap_done                 ), //o
    .xBC_stream_TDATA   (xBC_stream_TDATA[255:0]           ), //i
    .xBC_stream_TVALID  (xBC_stream_TVALID                 ), //i
    .xBC_stream_TREADY  (black_box_xBC_stream_TREADY       ), //o
    .z_stream_TDATA     (z_stream_TDATA[255:0]             ), //i
    .z_stream_TVALID    (z_stream_TVALID                   ), //i
    .z_stream_TREADY    (black_box_z_stream_TREADY         ), //o
    .silu_stream_TDATA  (black_box_silu_stream_TDATA[255:0]), //o
    .silu_stream_TVALID (black_box_silu_stream_TVALID      ), //o
    .silu_stream_TREADY (silu_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign xBC_stream_TREADY = black_box_xBC_stream_TREADY;
  assign z_stream_TREADY = black_box_z_stream_TREADY;
  assign silu_stream_TDATA = black_box_silu_stream_TDATA;
  assign silu_stream_TVALID = black_box_silu_stream_TVALID;

endmodule

module SILU_DEMUX_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          silu_stream_TVALID,
  output wire          silu_stream_TREADY,
  input  wire [63:0]   silu_stream_TDATA,
  input  wire          silu_s_stream_TVALID,
  output wire          silu_s_stream_TREADY,
  input  wire [7:0]    silu_s_stream_TDATA,
  output wire          x_stream_TVALID,
  input  wire          x_stream_TREADY,
  output wire [63:0]   x_stream_TDATA,
  output wire          x_s_stream_TVALID,
  input  wire          x_s_stream_TREADY,
  output wire [7:0]    x_s_stream_TDATA,
  output wire          x_stream2_TVALID,
  input  wire          x_stream2_TREADY,
  output wire [63:0]   x_stream2_TDATA,
  output wire          x_s_stream2_TVALID,
  input  wire          x_s_stream2_TREADY,
  output wire [7:0]    x_s_stream2_TDATA,
  output wire          B_stream_TVALID,
  input  wire          B_stream_TREADY,
  output wire [63:0]   B_stream_TDATA,
  output wire          B_s_stream_TVALID,
  input  wire          B_s_stream_TREADY,
  output wire [7:0]    B_s_stream_TDATA,
  output wire          C_stream_TVALID,
  input  wire          C_stream_TREADY,
  output wire [63:0]   C_stream_TDATA,
  output wire          C_s_stream_TVALID,
  input  wire          C_s_stream_TREADY,
  output wire [7:0]    C_s_stream_TDATA,
  output wire          z_stream_TVALID,
  input  wire          z_stream_TREADY,
  output wire [63:0]   z_stream_TDATA,
  output wire          z_s_stream_TVALID,
  input  wire          z_s_stream_TREADY,
  output wire [7:0]    z_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_silu_stream_TREADY;
  wire                black_box_silu_s_stream_TREADY;
  wire       [63:0]   black_box_x_stream_TDATA;
  wire                black_box_x_stream_TVALID;
  wire       [7:0]    black_box_x_s_stream_TDATA;
  wire                black_box_x_s_stream_TVALID;
  wire       [63:0]   black_box_x_stream2_TDATA;
  wire                black_box_x_stream2_TVALID;
  wire       [7:0]    black_box_x_s_stream2_TDATA;
  wire                black_box_x_s_stream2_TVALID;
  wire       [63:0]   black_box_B_stream_TDATA;
  wire                black_box_B_stream_TVALID;
  wire       [7:0]    black_box_B_s_stream_TDATA;
  wire                black_box_B_s_stream_TVALID;
  wire       [63:0]   black_box_C_stream_TDATA;
  wire                black_box_C_stream_TVALID;
  wire       [7:0]    black_box_C_s_stream_TDATA;
  wire                black_box_C_s_stream_TVALID;
  wire       [63:0]   black_box_z_stream_TDATA;
  wire                black_box_z_stream_TVALID;
  wire       [7:0]    black_box_z_s_stream_TDATA;
  wire                black_box_z_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  SILU_DEMUX black_box (
    .ap_clk               (clk                             ), //i
    .ap_rst_n             (resetn                          ), //i
    .ap_start             (manager_25_ap_ctrl_ap_start     ), //i
    .ap_continue          (manager_25_ap_ctrl_ap_continue  ), //i
    .ap_idle              (black_box_ap_idle               ), //o
    .ap_ready             (black_box_ap_ready              ), //o
    .ap_done              (black_box_ap_done               ), //o
    .silu_stream_TDATA    (silu_stream_TDATA[63:0]         ), //i
    .silu_stream_TVALID   (silu_stream_TVALID              ), //i
    .silu_stream_TREADY   (black_box_silu_stream_TREADY    ), //o
    .silu_s_stream_TDATA  (silu_s_stream_TDATA[7:0]        ), //i
    .silu_s_stream_TVALID (silu_s_stream_TVALID            ), //i
    .silu_s_stream_TREADY (black_box_silu_s_stream_TREADY  ), //o
    .x_stream_TDATA       (black_box_x_stream_TDATA[63:0]  ), //o
    .x_stream_TVALID      (black_box_x_stream_TVALID       ), //o
    .x_stream_TREADY      (x_stream_TREADY                 ), //i
    .x_s_stream_TDATA     (black_box_x_s_stream_TDATA[7:0] ), //o
    .x_s_stream_TVALID    (black_box_x_s_stream_TVALID     ), //o
    .x_s_stream_TREADY    (x_s_stream_TREADY               ), //i
    .x_stream2_TDATA      (black_box_x_stream2_TDATA[63:0] ), //o
    .x_stream2_TVALID     (black_box_x_stream2_TVALID      ), //o
    .x_stream2_TREADY     (x_stream2_TREADY                ), //i
    .x_s_stream2_TDATA    (black_box_x_s_stream2_TDATA[7:0]), //o
    .x_s_stream2_TVALID   (black_box_x_s_stream2_TVALID    ), //o
    .x_s_stream2_TREADY   (x_s_stream2_TREADY              ), //i
    .B_stream_TDATA       (black_box_B_stream_TDATA[63:0]  ), //o
    .B_stream_TVALID      (black_box_B_stream_TVALID       ), //o
    .B_stream_TREADY      (B_stream_TREADY                 ), //i
    .B_s_stream_TDATA     (black_box_B_s_stream_TDATA[7:0] ), //o
    .B_s_stream_TVALID    (black_box_B_s_stream_TVALID     ), //o
    .B_s_stream_TREADY    (B_s_stream_TREADY               ), //i
    .C_stream_TDATA       (black_box_C_stream_TDATA[63:0]  ), //o
    .C_stream_TVALID      (black_box_C_stream_TVALID       ), //o
    .C_stream_TREADY      (C_stream_TREADY                 ), //i
    .C_s_stream_TDATA     (black_box_C_s_stream_TDATA[7:0] ), //o
    .C_s_stream_TVALID    (black_box_C_s_stream_TVALID     ), //o
    .C_s_stream_TREADY    (C_s_stream_TREADY               ), //i
    .z_stream_TDATA       (black_box_z_stream_TDATA[63:0]  ), //o
    .z_stream_TVALID      (black_box_z_stream_TVALID       ), //o
    .z_stream_TREADY      (z_stream_TREADY                 ), //i
    .z_s_stream_TDATA     (black_box_z_s_stream_TDATA[7:0] ), //o
    .z_s_stream_TVALID    (black_box_z_s_stream_TVALID     ), //o
    .z_s_stream_TREADY    (z_s_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign silu_stream_TREADY = black_box_silu_stream_TREADY;
  assign silu_s_stream_TREADY = black_box_silu_s_stream_TREADY;
  assign x_stream_TDATA = black_box_x_stream_TDATA;
  assign x_stream_TVALID = black_box_x_stream_TVALID;
  assign x_s_stream_TDATA = black_box_x_s_stream_TDATA;
  assign x_s_stream_TVALID = black_box_x_s_stream_TVALID;
  assign x_stream2_TDATA = black_box_x_stream2_TDATA;
  assign x_stream2_TVALID = black_box_x_stream2_TVALID;
  assign x_s_stream2_TDATA = black_box_x_s_stream2_TDATA;
  assign x_s_stream2_TVALID = black_box_x_s_stream2_TVALID;
  assign B_stream_TDATA = black_box_B_stream_TDATA;
  assign B_stream_TVALID = black_box_B_stream_TVALID;
  assign B_s_stream_TDATA = black_box_B_s_stream_TDATA;
  assign B_s_stream_TVALID = black_box_B_s_stream_TVALID;
  assign C_stream_TDATA = black_box_C_stream_TDATA;
  assign C_stream_TVALID = black_box_C_stream_TVALID;
  assign C_s_stream_TDATA = black_box_C_s_stream_TDATA;
  assign C_s_stream_TVALID = black_box_C_s_stream_TVALID;
  assign z_stream_TDATA = black_box_z_stream_TDATA;
  assign z_stream_TVALID = black_box_z_stream_TVALID;
  assign z_s_stream_TDATA = black_box_z_s_stream_TDATA;
  assign z_s_stream_TVALID = black_box_z_s_stream_TVALID;

endmodule

module RMSNORM_QUANT_2_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          x_stream_TVALID,
  output wire          x_stream_TREADY,
  input  wire [255:0]  x_stream_TDATA,
  output wire          xlnq_stream_TVALID,
  input  wire          xlnq_stream_TREADY,
  output wire [31:0]   xlnq_stream_TDATA,
  output wire          xlns_stream_TVALID,
  input  wire          xlns_stream_TREADY,
  output wire [7:0]    xlns_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_x_stream_TREADY;
  wire       [31:0]   black_box_xlnq_stream_TDATA;
  wire                black_box_xlnq_stream_TVALID;
  wire       [7:0]    black_box_xlns_stream_TDATA;
  wire                black_box_xlns_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  RMSNORM_QUANT_2 black_box (
    .ap_clk             (clk                              ), //i
    .ap_rst_n           (resetn                           ), //i
    .l                  (manager_25_l[31:0]               ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start      ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue   ), //i
    .ap_idle            (black_box_ap_idle                ), //o
    .ap_ready           (black_box_ap_ready               ), //o
    .ap_done            (black_box_ap_done                ), //o
    .x_stream_TDATA     (x_stream_TDATA[255:0]            ), //i
    .x_stream_TVALID    (x_stream_TVALID                  ), //i
    .x_stream_TREADY    (black_box_x_stream_TREADY        ), //o
    .xlnq_stream_TDATA  (black_box_xlnq_stream_TDATA[31:0]), //o
    .xlnq_stream_TVALID (black_box_xlnq_stream_TVALID     ), //o
    .xlnq_stream_TREADY (xlnq_stream_TREADY               ), //i
    .xlns_stream_TDATA  (black_box_xlns_stream_TDATA[7:0] ), //o
    .xlns_stream_TVALID (black_box_xlns_stream_TVALID     ), //o
    .xlns_stream_TREADY (xlns_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign x_stream_TREADY = black_box_x_stream_TREADY;
  assign xlnq_stream_TDATA = black_box_xlnq_stream_TDATA;
  assign xlnq_stream_TVALID = black_box_xlnq_stream_TVALID;
  assign xlns_stream_TDATA = black_box_xlns_stream_TDATA;
  assign xlns_stream_TVALID = black_box_xlns_stream_TVALID;

endmodule

module RMSNORM_QUANT_1_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          x_stream_TVALID,
  output wire          x_stream_TREADY,
  input  wire [255:0]  x_stream_TDATA,
  output wire          xlnq_stream_TVALID,
  input  wire          xlnq_stream_TREADY,
  output wire [31:0]   xlnq_stream_TDATA,
  output wire          xlns_stream_TVALID,
  input  wire          xlns_stream_TREADY,
  output wire [7:0]    xlns_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_x_stream_TREADY;
  wire       [31:0]   black_box_xlnq_stream_TDATA;
  wire                black_box_xlnq_stream_TVALID;
  wire       [7:0]    black_box_xlns_stream_TDATA;
  wire                black_box_xlns_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  RMSNORM_QUANT_1 black_box (
    .ap_clk             (clk                              ), //i
    .ap_rst_n           (resetn                           ), //i
    .l                  (manager_25_l[31:0]               ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start      ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue   ), //i
    .ap_idle            (black_box_ap_idle                ), //o
    .ap_ready           (black_box_ap_ready               ), //o
    .ap_done            (black_box_ap_done                ), //o
    .x_stream_TDATA     (x_stream_TDATA[255:0]            ), //i
    .x_stream_TVALID    (x_stream_TVALID                  ), //i
    .x_stream_TREADY    (black_box_x_stream_TREADY        ), //o
    .xlnq_stream_TDATA  (black_box_xlnq_stream_TDATA[31:0]), //o
    .xlnq_stream_TVALID (black_box_xlnq_stream_TVALID     ), //o
    .xlnq_stream_TREADY (xlnq_stream_TREADY               ), //i
    .xlns_stream_TDATA  (black_box_xlns_stream_TDATA[7:0] ), //o
    .xlns_stream_TVALID (black_box_xlns_stream_TVALID     ), //o
    .xlns_stream_TREADY (xlns_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign x_stream_TREADY = black_box_x_stream_TREADY;
  assign xlnq_stream_TDATA = black_box_xlnq_stream_TDATA;
  assign xlnq_stream_TVALID = black_box_xlnq_stream_TVALID;
  assign xlns_stream_TDATA = black_box_xlns_stream_TDATA;
  assign xlns_stream_TVALID = black_box_xlns_stream_TVALID;

endmodule

module RESIDUAL_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          x_stream_TVALID,
  output wire          x_stream_TREADY,
  input  wire [255:0]  x_stream_TDATA,
  input  wire          res_i_stream_TVALID,
  output wire          res_i_stream_TREADY,
  input  wire [255:0]  res_i_stream_TDATA,
  output wire          res_o_stream_TVALID,
  input  wire          res_o_stream_TREADY,
  output wire [255:0]  res_o_stream_TDATA,
  output wire          y_stream_TVALID,
  input  wire          y_stream_TREADY,
  output wire [255:0]  y_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_x_stream_TREADY;
  wire                black_box_res_i_stream_TREADY;
  wire       [255:0]  black_box_res_o_stream_TDATA;
  wire                black_box_res_o_stream_TVALID;
  wire       [255:0]  black_box_y_stream_TDATA;
  wire                black_box_y_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  RESIDUAL black_box (
    .ap_clk              (clk                                ), //i
    .ap_rst_n            (resetn                             ), //i
    .l_begin             (manager_25_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_25_signals_O_L_CLOSE[31:0] ), //i
    .ap_start            (manager_25_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_25_ap_ctrl_ap_continue     ), //i
    .ap_idle             (black_box_ap_idle                  ), //o
    .ap_ready            (black_box_ap_ready                 ), //o
    .ap_done             (black_box_ap_done                  ), //o
    .x_stream_TDATA      (x_stream_TDATA[255:0]              ), //i
    .x_stream_TVALID     (x_stream_TVALID                    ), //i
    .x_stream_TREADY     (black_box_x_stream_TREADY          ), //o
    .res_i_stream_TDATA  (res_i_stream_TDATA[255:0]          ), //i
    .res_i_stream_TVALID (res_i_stream_TVALID                ), //i
    .res_i_stream_TREADY (black_box_res_i_stream_TREADY      ), //o
    .res_o_stream_TDATA  (black_box_res_o_stream_TDATA[255:0]), //o
    .res_o_stream_TVALID (black_box_res_o_stream_TVALID      ), //o
    .res_o_stream_TREADY (res_o_stream_TREADY                ), //i
    .y_stream_TDATA      (black_box_y_stream_TDATA[255:0]    ), //o
    .y_stream_TVALID     (black_box_y_stream_TVALID          ), //o
    .y_stream_TREADY     (y_stream_TREADY                    )  //i
  );
  Manager_7 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign x_stream_TREADY = black_box_x_stream_TREADY;
  assign res_i_stream_TREADY = black_box_res_i_stream_TREADY;
  assign res_o_stream_TDATA = black_box_res_o_stream_TDATA;
  assign res_o_stream_TVALID = black_box_res_o_stream_TVALID;
  assign y_stream_TDATA = black_box_y_stream_TDATA;
  assign y_stream_TVALID = black_box_y_stream_TVALID;

endmodule

module QUANT_CONV_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [255:0]  i_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [63:0]   o_stream_TDATA,
  output wire          o_s_stream_TVALID,
  input  wire          o_s_stream_TREADY,
  output wire [7:0]    o_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire       [63:0]   black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [7:0]    black_box_o_s_stream_TDATA;
  wire                black_box_o_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  QUANT_CONV black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .ap_start          (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle           (black_box_ap_idle              ), //o
    .ap_ready          (black_box_ap_ready             ), //o
    .ap_done           (black_box_ap_done              ), //o
    .i_stream_TDATA    (i_stream_TDATA[255:0]          ), //i
    .i_stream_TVALID   (i_stream_TVALID                ), //i
    .i_stream_TREADY   (black_box_i_stream_TREADY      ), //o
    .o_stream_TDATA    (black_box_o_stream_TDATA[63:0] ), //o
    .o_stream_TVALID   (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY   (o_stream_TREADY                ), //i
    .o_s_stream_TDATA  (black_box_o_s_stream_TDATA[7:0]), //o
    .o_s_stream_TVALID (black_box_o_s_stream_TVALID    ), //o
    .o_s_stream_TREADY (o_s_stream_TREADY              )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;
  assign o_s_stream_TDATA = black_box_o_s_stream_TDATA;
  assign o_s_stream_TVALID = black_box_o_s_stream_TVALID;

endmodule

module HTC_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          ht_stream_TVALID,
  output wire          ht_stream_TREADY,
  input  wire [63:0]   ht_stream_TDATA,
  input  wire          ht_s_stream_TVALID,
  output wire          ht_s_stream_TREADY,
  input  wire [7:0]    ht_s_stream_TDATA,
  input  wire          C_stream_TVALID,
  output wire          C_stream_TREADY,
  input  wire [63:0]   C_stream_TDATA,
  input  wire          C_s_stream_TVALID,
  output wire          C_s_stream_TREADY,
  input  wire [7:0]    C_s_stream_TDATA,
  input  wire          uD_stream_TVALID,
  output wire          uD_stream_TREADY,
  input  wire [255:0]  uD_stream_TDATA,
  output wire          o_q_stream_TVALID,
  input  wire          o_q_stream_TREADY,
  output wire [63:0]   o_q_stream_TDATA,
  output wire          o_s_stream_TVALID,
  input  wire          o_s_stream_TREADY,
  output wire [7:0]    o_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_ht_stream_TREADY;
  wire                black_box_ht_s_stream_TREADY;
  wire                black_box_C_stream_TREADY;
  wire                black_box_C_s_stream_TREADY;
  wire                black_box_uD_stream_TREADY;
  wire       [63:0]   black_box_o_q_stream_TDATA;
  wire                black_box_o_q_stream_TVALID;
  wire       [7:0]    black_box_o_s_stream_TDATA;
  wire                black_box_o_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  HTC_QUANT black_box (
    .ap_clk             (clk                             ), //i
    .ap_rst_n           (resetn                          ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start     ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue  ), //i
    .ap_idle            (black_box_ap_idle               ), //o
    .ap_ready           (black_box_ap_ready              ), //o
    .ap_done            (black_box_ap_done               ), //o
    .ht_stream_TDATA    (ht_stream_TDATA[63:0]           ), //i
    .ht_stream_TVALID   (ht_stream_TVALID                ), //i
    .ht_stream_TREADY   (black_box_ht_stream_TREADY      ), //o
    .ht_s_stream_TDATA  (ht_s_stream_TDATA[7:0]          ), //i
    .ht_s_stream_TVALID (ht_s_stream_TVALID              ), //i
    .ht_s_stream_TREADY (black_box_ht_s_stream_TREADY    ), //o
    .C_stream_TDATA     (C_stream_TDATA[63:0]            ), //i
    .C_stream_TVALID    (C_stream_TVALID                 ), //i
    .C_stream_TREADY    (black_box_C_stream_TREADY       ), //o
    .C_s_stream_TDATA   (C_s_stream_TDATA[7:0]           ), //i
    .C_s_stream_TVALID  (C_s_stream_TVALID               ), //i
    .C_s_stream_TREADY  (black_box_C_s_stream_TREADY     ), //o
    .uD_stream_TDATA    (uD_stream_TDATA[255:0]          ), //i
    .uD_stream_TVALID   (uD_stream_TVALID                ), //i
    .uD_stream_TREADY   (black_box_uD_stream_TREADY      ), //o
    .o_q_stream_TDATA   (black_box_o_q_stream_TDATA[63:0]), //o
    .o_q_stream_TVALID  (black_box_o_q_stream_TVALID     ), //o
    .o_q_stream_TREADY  (o_q_stream_TREADY               ), //i
    .o_s_stream_TDATA   (black_box_o_s_stream_TDATA[7:0] ), //o
    .o_s_stream_TVALID  (black_box_o_s_stream_TVALID     ), //o
    .o_s_stream_TREADY  (o_s_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign ht_stream_TREADY = black_box_ht_stream_TREADY;
  assign ht_s_stream_TREADY = black_box_ht_s_stream_TREADY;
  assign C_stream_TREADY = black_box_C_stream_TREADY;
  assign C_s_stream_TREADY = black_box_C_s_stream_TREADY;
  assign uD_stream_TREADY = black_box_uD_stream_TREADY;
  assign o_q_stream_TDATA = black_box_o_q_stream_TDATA;
  assign o_q_stream_TVALID = black_box_o_q_stream_TVALID;
  assign o_s_stream_TDATA = black_box_o_s_stream_TDATA;
  assign o_s_stream_TVALID = black_box_o_s_stream_TVALID;

endmodule

module HT_STATE_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          state_in_stream_TVALID,
  output wire          state_in_stream_TREADY,
  input  wire [255:0]  state_in_stream_TDATA,
  input  wire          state_in_s_stream_TVALID,
  output wire          state_in_s_stream_TREADY,
  input  wire [255:0]  state_in_s_stream_TDATA,
  input  wire          ht_in_stream_TVALID,
  output wire          ht_in_stream_TREADY,
  input  wire [63:0]   ht_in_stream_TDATA,
  input  wire          ht_in_s_stream_TVALID,
  output wire          ht_in_s_stream_TREADY,
  input  wire [7:0]    ht_in_s_stream_TDATA,
  output wire          ht_out_stream_TVALID,
  input  wire          ht_out_stream_TREADY,
  output wire [63:0]   ht_out_stream_TDATA,
  output wire          ht_out_s_stream_TVALID,
  input  wire          ht_out_s_stream_TREADY,
  output wire [7:0]    ht_out_s_stream_TDATA,
  output wire          state_out_stream_TVALID,
  input  wire          state_out_stream_TREADY,
  output wire [255:0]  state_out_stream_TDATA,
  output wire          state_out_s_stream_TVALID,
  input  wire          state_out_s_stream_TREADY,
  output wire [255:0]  state_out_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_state_in_stream_TREADY;
  wire                black_box_state_in_s_stream_TREADY;
  wire                black_box_ht_in_stream_TREADY;
  wire                black_box_ht_in_s_stream_TREADY;
  wire       [63:0]   black_box_ht_out_stream_TDATA;
  wire                black_box_ht_out_stream_TVALID;
  wire       [7:0]    black_box_ht_out_s_stream_TDATA;
  wire                black_box_ht_out_s_stream_TVALID;
  wire       [255:0]  black_box_state_out_stream_TDATA;
  wire                black_box_state_out_stream_TVALID;
  wire       [255:0]  black_box_state_out_s_stream_TDATA;
  wire                black_box_state_out_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  HT_STATE black_box (
    .ap_clk                    (clk                                      ), //i
    .ap_rst_n                  (resetn                                   ), //i
    .ap_start                  (manager_25_ap_ctrl_ap_start              ), //i
    .ap_continue               (manager_25_ap_ctrl_ap_continue           ), //i
    .ap_idle                   (black_box_ap_idle                        ), //o
    .ap_ready                  (black_box_ap_ready                       ), //o
    .ap_done                   (black_box_ap_done                        ), //o
    .state_in_stream_TDATA     (state_in_stream_TDATA[255:0]             ), //i
    .state_in_stream_TVALID    (state_in_stream_TVALID                   ), //i
    .state_in_stream_TREADY    (black_box_state_in_stream_TREADY         ), //o
    .state_in_s_stream_TDATA   (state_in_s_stream_TDATA[255:0]           ), //i
    .state_in_s_stream_TVALID  (state_in_s_stream_TVALID                 ), //i
    .state_in_s_stream_TREADY  (black_box_state_in_s_stream_TREADY       ), //o
    .ht_in_stream_TDATA        (ht_in_stream_TDATA[63:0]                 ), //i
    .ht_in_stream_TVALID       (ht_in_stream_TVALID                      ), //i
    .ht_in_stream_TREADY       (black_box_ht_in_stream_TREADY            ), //o
    .ht_in_s_stream_TDATA      (ht_in_s_stream_TDATA[7:0]                ), //i
    .ht_in_s_stream_TVALID     (ht_in_s_stream_TVALID                    ), //i
    .ht_in_s_stream_TREADY     (black_box_ht_in_s_stream_TREADY          ), //o
    .ht_out_stream_TDATA       (black_box_ht_out_stream_TDATA[63:0]      ), //o
    .ht_out_stream_TVALID      (black_box_ht_out_stream_TVALID           ), //o
    .ht_out_stream_TREADY      (ht_out_stream_TREADY                     ), //i
    .ht_out_s_stream_TDATA     (black_box_ht_out_s_stream_TDATA[7:0]     ), //o
    .ht_out_s_stream_TVALID    (black_box_ht_out_s_stream_TVALID         ), //o
    .ht_out_s_stream_TREADY    (ht_out_s_stream_TREADY                   ), //i
    .state_out_stream_TDATA    (black_box_state_out_stream_TDATA[255:0]  ), //o
    .state_out_stream_TVALID   (black_box_state_out_stream_TVALID        ), //o
    .state_out_stream_TREADY   (state_out_stream_TREADY                  ), //i
    .state_out_s_stream_TDATA  (black_box_state_out_s_stream_TDATA[255:0]), //o
    .state_out_s_stream_TVALID (black_box_state_out_s_stream_TVALID      ), //o
    .state_out_s_stream_TREADY (state_out_s_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign state_in_stream_TREADY = black_box_state_in_stream_TREADY;
  assign state_in_s_stream_TREADY = black_box_state_in_s_stream_TREADY;
  assign ht_in_stream_TREADY = black_box_ht_in_stream_TREADY;
  assign ht_in_s_stream_TREADY = black_box_ht_in_s_stream_TREADY;
  assign ht_out_stream_TDATA = black_box_ht_out_stream_TDATA;
  assign ht_out_stream_TVALID = black_box_ht_out_stream_TVALID;
  assign ht_out_s_stream_TDATA = black_box_ht_out_s_stream_TDATA;
  assign ht_out_s_stream_TVALID = black_box_ht_out_s_stream_TVALID;
  assign state_out_stream_TDATA = black_box_state_out_stream_TDATA;
  assign state_out_stream_TVALID = black_box_state_out_stream_TVALID;
  assign state_out_s_stream_TDATA = black_box_state_out_s_stream_TDATA;
  assign state_out_s_stream_TVALID = black_box_state_out_s_stream_TVALID;

endmodule

module HT_ADD_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          dAh_stream_TVALID,
  output wire          dAh_stream_TREADY,
  input  wire [255:0]  dAh_stream_TDATA,
  input  wire          dBu_stream_TVALID,
  output wire          dBu_stream_TREADY,
  input  wire [255:0]  dBu_stream_TDATA,
  output wire          ht1_q_stream_TVALID,
  input  wire          ht1_q_stream_TREADY,
  output wire [63:0]   ht1_q_stream_TDATA,
  output wire          ht1_s_stream_TVALID,
  input  wire          ht1_s_stream_TREADY,
  output wire [7:0]    ht1_s_stream_TDATA,
  output wire          ht2_q_stream_TVALID,
  input  wire          ht2_q_stream_TREADY,
  output wire [63:0]   ht2_q_stream_TDATA,
  output wire          ht2_s_stream_TVALID,
  input  wire          ht2_s_stream_TREADY,
  output wire [7:0]    ht2_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_dAh_stream_TREADY;
  wire                black_box_dBu_stream_TREADY;
  wire       [63:0]   black_box_ht1_q_stream_TDATA;
  wire                black_box_ht1_q_stream_TVALID;
  wire       [7:0]    black_box_ht1_s_stream_TDATA;
  wire                black_box_ht1_s_stream_TVALID;
  wire       [63:0]   black_box_ht2_q_stream_TDATA;
  wire                black_box_ht2_q_stream_TVALID;
  wire       [7:0]    black_box_ht2_s_stream_TDATA;
  wire                black_box_ht2_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  HT_ADD_QUANT black_box (
    .ap_clk              (clk                               ), //i
    .ap_rst_n            (resetn                            ), //i
    .ap_start            (manager_25_ap_ctrl_ap_start       ), //i
    .ap_continue         (manager_25_ap_ctrl_ap_continue    ), //i
    .ap_idle             (black_box_ap_idle                 ), //o
    .ap_ready            (black_box_ap_ready                ), //o
    .ap_done             (black_box_ap_done                 ), //o
    .dAh_stream_TDATA    (dAh_stream_TDATA[255:0]           ), //i
    .dAh_stream_TVALID   (dAh_stream_TVALID                 ), //i
    .dAh_stream_TREADY   (black_box_dAh_stream_TREADY       ), //o
    .dBu_stream_TDATA    (dBu_stream_TDATA[255:0]           ), //i
    .dBu_stream_TVALID   (dBu_stream_TVALID                 ), //i
    .dBu_stream_TREADY   (black_box_dBu_stream_TREADY       ), //o
    .ht1_q_stream_TDATA  (black_box_ht1_q_stream_TDATA[63:0]), //o
    .ht1_q_stream_TVALID (black_box_ht1_q_stream_TVALID     ), //o
    .ht1_q_stream_TREADY (ht1_q_stream_TREADY               ), //i
    .ht1_s_stream_TDATA  (black_box_ht1_s_stream_TDATA[7:0] ), //o
    .ht1_s_stream_TVALID (black_box_ht1_s_stream_TVALID     ), //o
    .ht1_s_stream_TREADY (ht1_s_stream_TREADY               ), //i
    .ht2_q_stream_TDATA  (black_box_ht2_q_stream_TDATA[63:0]), //o
    .ht2_q_stream_TVALID (black_box_ht2_q_stream_TVALID     ), //o
    .ht2_q_stream_TREADY (ht2_q_stream_TREADY               ), //i
    .ht2_s_stream_TDATA  (black_box_ht2_s_stream_TDATA[7:0] ), //o
    .ht2_s_stream_TVALID (black_box_ht2_s_stream_TVALID     ), //o
    .ht2_s_stream_TREADY (ht2_s_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign dAh_stream_TREADY = black_box_dAh_stream_TREADY;
  assign dBu_stream_TREADY = black_box_dBu_stream_TREADY;
  assign ht1_q_stream_TDATA = black_box_ht1_q_stream_TDATA;
  assign ht1_q_stream_TVALID = black_box_ht1_q_stream_TVALID;
  assign ht1_s_stream_TDATA = black_box_ht1_s_stream_TDATA;
  assign ht1_s_stream_TVALID = black_box_ht1_s_stream_TVALID;
  assign ht2_q_stream_TDATA = black_box_ht2_q_stream_TDATA;
  assign ht2_q_stream_TVALID = black_box_ht2_q_stream_TVALID;
  assign ht2_s_stream_TDATA = black_box_ht2_s_stream_TDATA;
  assign ht2_s_stream_TVALID = black_box_ht2_s_stream_TVALID;

endmodule

module GEMM_MUX_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          xlnq1_stream_TVALID,
  output wire          xlnq1_stream_TREADY,
  input  wire [31:0]   xlnq1_stream_TDATA,
  input  wire          xlns1_stream_TVALID,
  output wire          xlns1_stream_TREADY,
  input  wire [7:0]    xlns1_stream_TDATA,
  input  wire          xlnq2_stream_TVALID,
  output wire          xlnq2_stream_TREADY,
  input  wire [31:0]   xlnq2_stream_TDATA,
  input  wire          xlns2_stream_TVALID,
  output wire          xlns2_stream_TREADY,
  input  wire [7:0]    xlns2_stream_TDATA,
  output wire          q_stream_TVALID,
  input  wire          q_stream_TREADY,
  output wire [31:0]   q_stream_TDATA,
  output wire          s_stream_TVALID,
  input  wire          s_stream_TREADY,
  output wire [7:0]    s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_xlnq1_stream_TREADY;
  wire                black_box_xlns1_stream_TREADY;
  wire                black_box_xlnq2_stream_TREADY;
  wire                black_box_xlns2_stream_TREADY;
  wire       [31:0]   black_box_q_stream_TDATA;
  wire                black_box_q_stream_TVALID;
  wire       [7:0]    black_box_s_stream_TDATA;
  wire                black_box_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  GEMM_MUX black_box (
    .ap_clk              (clk                           ), //i
    .ap_rst_n            (resetn                        ), //i
    .ap_start            (manager_25_ap_ctrl_ap_start   ), //i
    .ap_continue         (manager_25_ap_ctrl_ap_continue), //i
    .ap_idle             (black_box_ap_idle             ), //o
    .ap_ready            (black_box_ap_ready            ), //o
    .ap_done             (black_box_ap_done             ), //o
    .xlnq1_stream_TDATA  (xlnq1_stream_TDATA[31:0]      ), //i
    .xlnq1_stream_TVALID (xlnq1_stream_TVALID           ), //i
    .xlnq1_stream_TREADY (black_box_xlnq1_stream_TREADY ), //o
    .xlns1_stream_TDATA  (xlns1_stream_TDATA[7:0]       ), //i
    .xlns1_stream_TVALID (xlns1_stream_TVALID           ), //i
    .xlns1_stream_TREADY (black_box_xlns1_stream_TREADY ), //o
    .xlnq2_stream_TDATA  (xlnq2_stream_TDATA[31:0]      ), //i
    .xlnq2_stream_TVALID (xlnq2_stream_TVALID           ), //i
    .xlnq2_stream_TREADY (black_box_xlnq2_stream_TREADY ), //o
    .xlns2_stream_TDATA  (xlns2_stream_TDATA[7:0]       ), //i
    .xlns2_stream_TVALID (xlns2_stream_TVALID           ), //i
    .xlns2_stream_TREADY (black_box_xlns2_stream_TREADY ), //o
    .q_stream_TDATA      (black_box_q_stream_TDATA[31:0]), //o
    .q_stream_TVALID     (black_box_q_stream_TVALID     ), //o
    .q_stream_TREADY     (q_stream_TREADY               ), //i
    .s_stream_TDATA      (black_box_s_stream_TDATA[7:0] ), //o
    .s_stream_TVALID     (black_box_s_stream_TVALID     ), //o
    .s_stream_TREADY     (s_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign xlnq1_stream_TREADY = black_box_xlnq1_stream_TREADY;
  assign xlns1_stream_TREADY = black_box_xlns1_stream_TREADY;
  assign xlnq2_stream_TREADY = black_box_xlnq2_stream_TREADY;
  assign xlns2_stream_TREADY = black_box_xlns2_stream_TREADY;
  assign q_stream_TDATA = black_box_q_stream_TDATA;
  assign q_stream_TVALID = black_box_q_stream_TVALID;
  assign s_stream_TDATA = black_box_s_stream_TDATA;
  assign s_stream_TVALID = black_box_s_stream_TVALID;

endmodule

module GEMM_DEMUX_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          gemm_stream_TVALID,
  output wire          gemm_stream_TREADY,
  input  wire [255:0]  gemm_stream_TDATA,
  output wire          dt_stream_TVALID,
  input  wire          dt_stream_TREADY,
  output wire [255:0]  dt_stream_TDATA,
  output wire          xBC_stream_TVALID,
  input  wire          xBC_stream_TREADY,
  output wire [255:0]  xBC_stream_TDATA,
  output wire          z_stream_TVALID,
  input  wire          z_stream_TREADY,
  output wire [255:0]  z_stream_TDATA,
  output wire          out_stream_TVALID,
  input  wire          out_stream_TREADY,
  output wire [255:0]  out_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_gemm_stream_TREADY;
  wire       [255:0]  black_box_dt_stream_TDATA;
  wire                black_box_dt_stream_TVALID;
  wire       [255:0]  black_box_xBC_stream_TDATA;
  wire                black_box_xBC_stream_TVALID;
  wire       [255:0]  black_box_z_stream_TDATA;
  wire                black_box_z_stream_TVALID;
  wire       [255:0]  black_box_out_stream_TDATA;
  wire                black_box_out_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  GEMM_DEMUX black_box (
    .ap_clk             (clk                              ), //i
    .ap_rst_n           (resetn                           ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start      ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue   ), //i
    .ap_idle            (black_box_ap_idle                ), //o
    .ap_ready           (black_box_ap_ready               ), //o
    .ap_done            (black_box_ap_done                ), //o
    .gemm_stream_TDATA  (gemm_stream_TDATA[255:0]         ), //i
    .gemm_stream_TVALID (gemm_stream_TVALID               ), //i
    .gemm_stream_TREADY (black_box_gemm_stream_TREADY     ), //o
    .dt_stream_TDATA    (black_box_dt_stream_TDATA[255:0] ), //o
    .dt_stream_TVALID   (black_box_dt_stream_TVALID       ), //o
    .dt_stream_TREADY   (dt_stream_TREADY                 ), //i
    .xBC_stream_TDATA   (black_box_xBC_stream_TDATA[255:0]), //o
    .xBC_stream_TVALID  (black_box_xBC_stream_TVALID      ), //o
    .xBC_stream_TREADY  (xBC_stream_TREADY                ), //i
    .z_stream_TDATA     (black_box_z_stream_TDATA[255:0]  ), //o
    .z_stream_TVALID    (black_box_z_stream_TVALID        ), //o
    .z_stream_TREADY    (z_stream_TREADY                  ), //i
    .out_stream_TDATA   (black_box_out_stream_TDATA[255:0]), //o
    .out_stream_TVALID  (black_box_out_stream_TVALID      ), //o
    .out_stream_TREADY  (out_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign gemm_stream_TREADY = black_box_gemm_stream_TREADY;
  assign dt_stream_TDATA = black_box_dt_stream_TDATA;
  assign dt_stream_TVALID = black_box_dt_stream_TVALID;
  assign xBC_stream_TDATA = black_box_xBC_stream_TDATA;
  assign xBC_stream_TVALID = black_box_xBC_stream_TVALID;
  assign z_stream_TDATA = black_box_z_stream_TDATA;
  assign z_stream_TVALID = black_box_z_stream_TVALID;
  assign out_stream_TDATA = black_box_out_stream_TDATA;
  assign out_stream_TVALID = black_box_out_stream_TVALID;

endmodule

module GEMM_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [31:0]   i_stream_TDATA,
  input  wire          w_stream_TVALID,
  output wire          w_stream_TREADY,
  input  wire [255:0]  w_stream_TDATA,
  input  wire          s_stream_TVALID,
  output wire          s_stream_TREADY,
  input  wire [7:0]    s_stream_TDATA,
  input  wire          s1_stream_TVALID,
  output wire          s1_stream_TREADY,
  input  wire [23:0]   s1_stream_TDATA,
  input  wire          s2_stream_TVALID,
  output wire          s2_stream_TREADY,
  input  wire [23:0]   s2_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [255:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire                black_box_w_stream_TREADY;
  wire                black_box_s_stream_TREADY;
  wire                black_box_s1_stream_TREADY;
  wire                black_box_s2_stream_TREADY;
  wire       [255:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  GEMM black_box (
    .ap_clk           (clk                            ), //i
    .ap_rst_n         (resetn                         ), //i
    .ap_start         (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue      (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle          (black_box_ap_idle              ), //o
    .ap_ready         (black_box_ap_ready             ), //o
    .ap_done          (black_box_ap_done              ), //o
    .i_stream_TDATA   (i_stream_TDATA[31:0]           ), //i
    .i_stream_TVALID  (i_stream_TVALID                ), //i
    .i_stream_TREADY  (black_box_i_stream_TREADY      ), //o
    .w_stream_TDATA   (w_stream_TDATA[255:0]          ), //i
    .w_stream_TVALID  (w_stream_TVALID                ), //i
    .w_stream_TREADY  (black_box_w_stream_TREADY      ), //o
    .s_stream_TDATA   (s_stream_TDATA[7:0]            ), //i
    .s_stream_TVALID  (s_stream_TVALID                ), //i
    .s_stream_TREADY  (black_box_s_stream_TREADY      ), //o
    .s1_stream_TDATA  (s1_stream_TDATA[23:0]          ), //i
    .s1_stream_TVALID (s1_stream_TVALID               ), //i
    .s1_stream_TREADY (black_box_s1_stream_TREADY     ), //o
    .s2_stream_TDATA  (s2_stream_TDATA[23:0]          ), //i
    .s2_stream_TVALID (s2_stream_TVALID               ), //i
    .s2_stream_TREADY (black_box_s2_stream_TREADY     ), //o
    .o_stream_TDATA   (black_box_o_stream_TDATA[255:0]), //o
    .o_stream_TVALID  (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY  (o_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign w_stream_TREADY = black_box_w_stream_TREADY;
  assign s_stream_TREADY = black_box_s_stream_TREADY;
  assign s1_stream_TREADY = black_box_s1_stream_TREADY;
  assign s2_stream_TREADY = black_box_s2_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

module EXP_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [255:0]  i_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [63:0]   o_stream_TDATA,
  output wire          o_s_stream_TVALID,
  input  wire          o_s_stream_TREADY,
  output wire [7:0]    o_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire       [63:0]   black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [7:0]    black_box_o_s_stream_TDATA;
  wire                black_box_o_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  EXP_QUANT black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .ap_start          (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle           (black_box_ap_idle              ), //o
    .ap_ready          (black_box_ap_ready             ), //o
    .ap_done           (black_box_ap_done              ), //o
    .i_stream_TDATA    (i_stream_TDATA[255:0]          ), //i
    .i_stream_TVALID   (i_stream_TVALID                ), //i
    .i_stream_TREADY   (black_box_i_stream_TREADY      ), //o
    .o_stream_TDATA    (black_box_o_stream_TDATA[63:0] ), //o
    .o_stream_TVALID   (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY   (o_stream_TREADY                ), //i
    .o_s_stream_TDATA  (black_box_o_s_stream_TDATA[7:0]), //o
    .o_s_stream_TVALID (black_box_o_s_stream_TVALID    ), //o
    .o_s_stream_TREADY (o_s_stream_TREADY              )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;
  assign o_s_stream_TDATA = black_box_o_s_stream_TDATA;
  assign o_s_stream_TVALID = black_box_o_s_stream_TVALID;

endmodule

module DTB_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          dt_stream_TVALID,
  output wire          dt_stream_TREADY,
  input  wire [63:0]   dt_stream_TDATA,
  input  wire          dt_s_stream_TVALID,
  output wire          dt_s_stream_TREADY,
  input  wire [7:0]    dt_s_stream_TDATA,
  input  wire          B_stream_TVALID,
  output wire          B_stream_TREADY,
  input  wire [63:0]   B_stream_TDATA,
  input  wire          B_s_stream_TVALID,
  output wire          B_s_stream_TREADY,
  input  wire [7:0]    B_s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [63:0]   o_stream_TDATA,
  output wire          o_s_stream_TVALID,
  input  wire          o_s_stream_TREADY,
  output wire [7:0]    o_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_dt_stream_TREADY;
  wire                black_box_dt_s_stream_TREADY;
  wire                black_box_B_stream_TREADY;
  wire                black_box_B_s_stream_TREADY;
  wire       [63:0]   black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [7:0]    black_box_o_s_stream_TDATA;
  wire                black_box_o_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  DTB_QUANT black_box (
    .ap_clk             (clk                            ), //i
    .ap_rst_n           (resetn                         ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle            (black_box_ap_idle              ), //o
    .ap_ready           (black_box_ap_ready             ), //o
    .ap_done            (black_box_ap_done              ), //o
    .dt_stream_TDATA    (dt_stream_TDATA[63:0]          ), //i
    .dt_stream_TVALID   (dt_stream_TVALID               ), //i
    .dt_stream_TREADY   (black_box_dt_stream_TREADY     ), //o
    .dt_s_stream_TDATA  (dt_s_stream_TDATA[7:0]         ), //i
    .dt_s_stream_TVALID (dt_s_stream_TVALID             ), //i
    .dt_s_stream_TREADY (black_box_dt_s_stream_TREADY   ), //o
    .B_stream_TDATA     (B_stream_TDATA[63:0]           ), //i
    .B_stream_TVALID    (B_stream_TVALID                ), //i
    .B_stream_TREADY    (black_box_B_stream_TREADY      ), //o
    .B_s_stream_TDATA   (B_s_stream_TDATA[7:0]          ), //i
    .B_s_stream_TVALID  (B_s_stream_TVALID              ), //i
    .B_s_stream_TREADY  (black_box_B_s_stream_TREADY    ), //o
    .o_stream_TDATA     (black_box_o_stream_TDATA[63:0] ), //o
    .o_stream_TVALID    (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY    (o_stream_TREADY                ), //i
    .o_s_stream_TDATA   (black_box_o_s_stream_TDATA[7:0]), //o
    .o_s_stream_TVALID  (black_box_o_s_stream_TVALID    ), //o
    .o_s_stream_TREADY  (o_s_stream_TREADY              )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign dt_stream_TREADY = black_box_dt_stream_TREADY;
  assign dt_s_stream_TREADY = black_box_dt_s_stream_TREADY;
  assign B_stream_TREADY = black_box_B_stream_TREADY;
  assign B_s_stream_TREADY = black_box_B_s_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;
  assign o_s_stream_TDATA = black_box_o_s_stream_TDATA;
  assign o_s_stream_TVALID = black_box_o_s_stream_TVALID;

endmodule

module DTADAPT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [255:0]  i_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [63:0]   o_stream_TDATA,
  output wire          o_s_stream_TVALID,
  input  wire          o_s_stream_TREADY,
  output wire [7:0]    o_s_stream_TDATA,
  output wire          o_stream2_TVALID,
  input  wire          o_stream2_TREADY,
  output wire [63:0]   o_stream2_TDATA,
  output wire          o_s_stream2_TVALID,
  input  wire          o_s_stream2_TREADY,
  output wire [7:0]    o_s_stream2_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire       [63:0]   black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [7:0]    black_box_o_s_stream_TDATA;
  wire                black_box_o_s_stream_TVALID;
  wire       [63:0]   black_box_o_stream2_TDATA;
  wire                black_box_o_stream2_TVALID;
  wire       [7:0]    black_box_o_s_stream2_TDATA;
  wire                black_box_o_s_stream2_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  DTADAPT black_box (
    .ap_clk             (clk                             ), //i
    .ap_rst_n           (resetn                          ), //i
    .l                  (manager_25_l[31:0]              ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start     ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue  ), //i
    .ap_idle            (black_box_ap_idle               ), //o
    .ap_ready           (black_box_ap_ready              ), //o
    .ap_done            (black_box_ap_done               ), //o
    .i_stream_TDATA     (i_stream_TDATA[255:0]           ), //i
    .i_stream_TVALID    (i_stream_TVALID                 ), //i
    .i_stream_TREADY    (black_box_i_stream_TREADY       ), //o
    .o_stream_TDATA     (black_box_o_stream_TDATA[63:0]  ), //o
    .o_stream_TVALID    (black_box_o_stream_TVALID       ), //o
    .o_stream_TREADY    (o_stream_TREADY                 ), //i
    .o_s_stream_TDATA   (black_box_o_s_stream_TDATA[7:0] ), //o
    .o_s_stream_TVALID  (black_box_o_s_stream_TVALID     ), //o
    .o_s_stream_TREADY  (o_s_stream_TREADY               ), //i
    .o_stream2_TDATA    (black_box_o_stream2_TDATA[63:0] ), //o
    .o_stream2_TVALID   (black_box_o_stream2_TVALID      ), //o
    .o_stream2_TREADY   (o_stream2_TREADY                ), //i
    .o_s_stream2_TDATA  (black_box_o_s_stream2_TDATA[7:0]), //o
    .o_s_stream2_TVALID (black_box_o_s_stream2_TVALID    ), //o
    .o_s_stream2_TREADY (o_s_stream2_TREADY              )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;
  assign o_s_stream_TDATA = black_box_o_s_stream_TDATA;
  assign o_s_stream_TVALID = black_box_o_s_stream_TVALID;
  assign o_stream2_TDATA = black_box_o_stream2_TDATA;
  assign o_stream2_TVALID = black_box_o_stream2_TVALID;
  assign o_s_stream2_TDATA = black_box_o_s_stream2_TDATA;
  assign o_s_stream2_TVALID = black_box_o_s_stream2_TVALID;

endmodule

module DTA_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [63:0]   i_stream_TDATA,
  input  wire          s_stream_TVALID,
  output wire          s_stream_TREADY,
  input  wire [7:0]    s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [255:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire                black_box_s_stream_TREADY;
  wire       [255:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  DTA black_box (
    .ap_clk          (clk                            ), //i
    .ap_rst_n        (resetn                         ), //i
    .l               (manager_25_l[31:0]             ), //i
    .ap_start        (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue     (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle         (black_box_ap_idle              ), //o
    .ap_ready        (black_box_ap_ready             ), //o
    .ap_done         (black_box_ap_done              ), //o
    .i_stream_TDATA  (i_stream_TDATA[63:0]           ), //i
    .i_stream_TVALID (i_stream_TVALID                ), //i
    .i_stream_TREADY (black_box_i_stream_TREADY      ), //o
    .s_stream_TDATA  (s_stream_TDATA[7:0]            ), //i
    .s_stream_TVALID (s_stream_TVALID                ), //i
    .s_stream_TREADY (black_box_s_stream_TREADY      ), //o
    .o_stream_TDATA  (black_box_o_stream_TDATA[255:0]), //o
    .o_stream_TVALID (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY (o_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign s_stream_TREADY = black_box_s_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

module DBU_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          dB_stream_TVALID,
  output wire          dB_stream_TREADY,
  input  wire [63:0]   dB_stream_TDATA,
  input  wire          dB_s_stream_TVALID,
  output wire          dB_s_stream_TREADY,
  input  wire [7:0]    dB_s_stream_TDATA,
  input  wire          u_stream_TVALID,
  output wire          u_stream_TREADY,
  input  wire [63:0]   u_stream_TDATA,
  input  wire          u_s_stream_TVALID,
  output wire          u_s_stream_TREADY,
  input  wire [7:0]    u_s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [255:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_dB_stream_TREADY;
  wire                black_box_dB_s_stream_TREADY;
  wire                black_box_u_stream_TREADY;
  wire                black_box_u_s_stream_TREADY;
  wire       [255:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  DBU black_box (
    .ap_clk             (clk                            ), //i
    .ap_rst_n           (resetn                         ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle            (black_box_ap_idle              ), //o
    .ap_ready           (black_box_ap_ready             ), //o
    .ap_done            (black_box_ap_done              ), //o
    .dB_stream_TDATA    (dB_stream_TDATA[63:0]          ), //i
    .dB_stream_TVALID   (dB_stream_TVALID               ), //i
    .dB_stream_TREADY   (black_box_dB_stream_TREADY     ), //o
    .dB_s_stream_TDATA  (dB_s_stream_TDATA[7:0]         ), //i
    .dB_s_stream_TVALID (dB_s_stream_TVALID             ), //i
    .dB_s_stream_TREADY (black_box_dB_s_stream_TREADY   ), //o
    .u_stream_TDATA     (u_stream_TDATA[63:0]           ), //i
    .u_stream_TVALID    (u_stream_TVALID                ), //i
    .u_stream_TREADY    (black_box_u_stream_TREADY      ), //o
    .u_s_stream_TDATA   (u_s_stream_TDATA[7:0]          ), //i
    .u_s_stream_TVALID  (u_s_stream_TVALID              ), //i
    .u_s_stream_TREADY  (black_box_u_s_stream_TREADY    ), //o
    .o_stream_TDATA     (black_box_o_stream_TDATA[255:0]), //o
    .o_stream_TVALID    (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY    (o_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign dB_stream_TREADY = black_box_dB_stream_TREADY;
  assign dB_s_stream_TREADY = black_box_dB_s_stream_TREADY;
  assign u_stream_TREADY = black_box_u_stream_TREADY;
  assign u_s_stream_TREADY = black_box_u_s_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

module DAH_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          dA_stream_TVALID,
  output wire          dA_stream_TREADY,
  input  wire [63:0]   dA_stream_TDATA,
  input  wire          dA_s_stream_TVALID,
  output wire          dA_s_stream_TREADY,
  input  wire [7:0]    dA_s_stream_TDATA,
  input  wire          ht_stream_TVALID,
  output wire          ht_stream_TREADY,
  input  wire [63:0]   ht_stream_TDATA,
  input  wire          ht_s_stream_TVALID,
  output wire          ht_s_stream_TREADY,
  input  wire [7:0]    ht_s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [255:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_dA_stream_TREADY;
  wire                black_box_dA_s_stream_TREADY;
  wire                black_box_ht_stream_TREADY;
  wire                black_box_ht_s_stream_TREADY;
  wire       [255:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  DAH black_box (
    .ap_clk             (clk                            ), //i
    .ap_rst_n           (resetn                         ), //i
    .ap_start           (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue        (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle            (black_box_ap_idle              ), //o
    .ap_ready           (black_box_ap_ready             ), //o
    .ap_done            (black_box_ap_done              ), //o
    .dA_stream_TDATA    (dA_stream_TDATA[63:0]          ), //i
    .dA_stream_TVALID   (dA_stream_TVALID               ), //i
    .dA_stream_TREADY   (black_box_dA_stream_TREADY     ), //o
    .dA_s_stream_TDATA  (dA_s_stream_TDATA[7:0]         ), //i
    .dA_s_stream_TVALID (dA_s_stream_TVALID             ), //i
    .dA_s_stream_TREADY (black_box_dA_s_stream_TREADY   ), //o
    .ht_stream_TDATA    (ht_stream_TDATA[63:0]          ), //i
    .ht_stream_TVALID   (ht_stream_TVALID               ), //i
    .ht_stream_TREADY   (black_box_ht_stream_TREADY     ), //o
    .ht_s_stream_TDATA  (ht_s_stream_TDATA[7:0]         ), //i
    .ht_s_stream_TVALID (ht_s_stream_TVALID             ), //i
    .ht_s_stream_TREADY (black_box_ht_s_stream_TREADY   ), //o
    .o_stream_TDATA     (black_box_o_stream_TDATA[255:0]), //o
    .o_stream_TVALID    (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY    (o_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign dA_stream_TREADY = black_box_dA_stream_TREADY;
  assign dA_s_stream_TREADY = black_box_dA_s_stream_TREADY;
  assign ht_stream_TREADY = black_box_ht_stream_TREADY;
  assign ht_s_stream_TREADY = black_box_ht_s_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

module CONV_STATE_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          conv_stream_TVALID,
  output wire          conv_stream_TREADY,
  input  wire [255:0]  conv_stream_TDATA,
  input  wire          conv_s_stream_TVALID,
  output wire          conv_s_stream_TREADY,
  input  wire [255:0]  conv_s_stream_TDATA,
  input  wire          xBC_stream_TVALID,
  output wire          xBC_stream_TREADY,
  input  wire [63:0]   xBC_stream_TDATA,
  input  wire          xBC_s_stream_TVALID,
  output wire          xBC_s_stream_TREADY,
  input  wire [7:0]    xBC_s_stream_TDATA,
  output wire          w_stream_TVALID,
  input  wire          w_stream_TREADY,
  output wire [63:0]   w_stream_TDATA,
  output wire          w_s_stream_TVALID,
  input  wire          w_s_stream_TREADY,
  output wire [7:0]    w_s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [63:0]   o_stream_TDATA,
  output wire          o_s_stream_TVALID,
  input  wire          o_s_stream_TREADY,
  output wire [7:0]    o_s_stream_TDATA,
  output wire          conv_state_stream_TVALID,
  input  wire          conv_state_stream_TREADY,
  output wire [255:0]  conv_state_stream_TDATA,
  output wire          conv_state_s_stream_TVALID,
  input  wire          conv_state_s_stream_TREADY,
  output wire [255:0]  conv_state_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_conv_stream_TREADY;
  wire                black_box_conv_s_stream_TREADY;
  wire                black_box_xBC_stream_TREADY;
  wire                black_box_xBC_s_stream_TREADY;
  wire       [63:0]   black_box_w_stream_TDATA;
  wire                black_box_w_stream_TVALID;
  wire       [7:0]    black_box_w_s_stream_TDATA;
  wire                black_box_w_s_stream_TVALID;
  wire       [63:0]   black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [7:0]    black_box_o_s_stream_TDATA;
  wire                black_box_o_s_stream_TVALID;
  wire       [255:0]  black_box_conv_state_stream_TDATA;
  wire                black_box_conv_state_stream_TVALID;
  wire       [255:0]  black_box_conv_state_s_stream_TDATA;
  wire                black_box_conv_state_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  CONV_STATE black_box (
    .ap_clk                     (clk                                       ), //i
    .ap_rst_n                   (resetn                                    ), //i
    .ap_start                   (manager_25_ap_ctrl_ap_start               ), //i
    .ap_continue                (manager_25_ap_ctrl_ap_continue            ), //i
    .ap_idle                    (black_box_ap_idle                         ), //o
    .ap_ready                   (black_box_ap_ready                        ), //o
    .ap_done                    (black_box_ap_done                         ), //o
    .conv_stream_TDATA          (conv_stream_TDATA[255:0]                  ), //i
    .conv_stream_TVALID         (conv_stream_TVALID                        ), //i
    .conv_stream_TREADY         (black_box_conv_stream_TREADY              ), //o
    .conv_s_stream_TDATA        (conv_s_stream_TDATA[255:0]                ), //i
    .conv_s_stream_TVALID       (conv_s_stream_TVALID                      ), //i
    .conv_s_stream_TREADY       (black_box_conv_s_stream_TREADY            ), //o
    .xBC_stream_TDATA           (xBC_stream_TDATA[63:0]                    ), //i
    .xBC_stream_TVALID          (xBC_stream_TVALID                         ), //i
    .xBC_stream_TREADY          (black_box_xBC_stream_TREADY               ), //o
    .xBC_s_stream_TDATA         (xBC_s_stream_TDATA[7:0]                   ), //i
    .xBC_s_stream_TVALID        (xBC_s_stream_TVALID                       ), //i
    .xBC_s_stream_TREADY        (black_box_xBC_s_stream_TREADY             ), //o
    .w_stream_TDATA             (black_box_w_stream_TDATA[63:0]            ), //o
    .w_stream_TVALID            (black_box_w_stream_TVALID                 ), //o
    .w_stream_TREADY            (w_stream_TREADY                           ), //i
    .w_s_stream_TDATA           (black_box_w_s_stream_TDATA[7:0]           ), //o
    .w_s_stream_TVALID          (black_box_w_s_stream_TVALID               ), //o
    .w_s_stream_TREADY          (w_s_stream_TREADY                         ), //i
    .o_stream_TDATA             (black_box_o_stream_TDATA[63:0]            ), //o
    .o_stream_TVALID            (black_box_o_stream_TVALID                 ), //o
    .o_stream_TREADY            (o_stream_TREADY                           ), //i
    .o_s_stream_TDATA           (black_box_o_s_stream_TDATA[7:0]           ), //o
    .o_s_stream_TVALID          (black_box_o_s_stream_TVALID               ), //o
    .o_s_stream_TREADY          (o_s_stream_TREADY                         ), //i
    .conv_state_stream_TDATA    (black_box_conv_state_stream_TDATA[255:0]  ), //o
    .conv_state_stream_TVALID   (black_box_conv_state_stream_TVALID        ), //o
    .conv_state_stream_TREADY   (conv_state_stream_TREADY                  ), //i
    .conv_state_s_stream_TDATA  (black_box_conv_state_s_stream_TDATA[255:0]), //o
    .conv_state_s_stream_TVALID (black_box_conv_state_s_stream_TVALID      ), //o
    .conv_state_s_stream_TREADY (conv_state_s_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign conv_stream_TREADY = black_box_conv_stream_TREADY;
  assign conv_s_stream_TREADY = black_box_conv_s_stream_TREADY;
  assign xBC_stream_TREADY = black_box_xBC_stream_TREADY;
  assign xBC_s_stream_TREADY = black_box_xBC_s_stream_TREADY;
  assign w_stream_TDATA = black_box_w_stream_TDATA;
  assign w_stream_TVALID = black_box_w_stream_TVALID;
  assign w_s_stream_TDATA = black_box_w_s_stream_TDATA;
  assign w_s_stream_TVALID = black_box_w_s_stream_TVALID;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;
  assign o_s_stream_TDATA = black_box_o_s_stream_TDATA;
  assign o_s_stream_TVALID = black_box_o_s_stream_TVALID;
  assign conv_state_stream_TDATA = black_box_conv_state_stream_TDATA;
  assign conv_state_stream_TVALID = black_box_conv_state_stream_TVALID;
  assign conv_state_s_stream_TDATA = black_box_conv_state_s_stream_TDATA;
  assign conv_state_s_stream_TVALID = black_box_conv_state_s_stream_TVALID;

endmodule

module CONV_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [63:0]   i_stream_TDATA,
  input  wire          s_stream_TVALID,
  output wire          s_stream_TREADY,
  input  wire [7:0]    s_stream_TDATA,
  input  wire          w_stream_TVALID,
  output wire          w_stream_TREADY,
  input  wire [63:0]   w_stream_TDATA,
  input  wire          w_s_stream_TVALID,
  output wire          w_s_stream_TREADY,
  input  wire [7:0]    w_s_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [255:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire                black_box_s_stream_TREADY;
  wire                black_box_w_stream_TREADY;
  wire                black_box_w_s_stream_TREADY;
  wire       [255:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  CONV black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .l                 (manager_25_l[31:0]             ), //i
    .ap_start          (manager_25_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_25_ap_ctrl_ap_continue ), //i
    .ap_idle           (black_box_ap_idle              ), //o
    .ap_ready          (black_box_ap_ready             ), //o
    .ap_done           (black_box_ap_done              ), //o
    .i_stream_TDATA    (i_stream_TDATA[63:0]           ), //i
    .i_stream_TVALID   (i_stream_TVALID                ), //i
    .i_stream_TREADY   (black_box_i_stream_TREADY      ), //o
    .s_stream_TDATA    (s_stream_TDATA[7:0]            ), //i
    .s_stream_TVALID   (s_stream_TVALID                ), //i
    .s_stream_TREADY   (black_box_s_stream_TREADY      ), //o
    .w_stream_TDATA    (w_stream_TDATA[63:0]           ), //i
    .w_stream_TVALID   (w_stream_TVALID                ), //i
    .w_stream_TREADY   (black_box_w_stream_TREADY      ), //o
    .w_s_stream_TDATA  (w_s_stream_TDATA[7:0]          ), //i
    .w_s_stream_TVALID (w_s_stream_TVALID              ), //i
    .w_s_stream_TREADY (black_box_w_s_stream_TREADY    ), //o
    .o_stream_TDATA    (black_box_o_stream_TDATA[255:0]), //o
    .o_stream_TVALID   (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY   (o_stream_TREADY                )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign s_stream_TREADY = black_box_s_stream_TREADY;
  assign w_stream_TREADY = black_box_w_stream_TREADY;
  assign w_s_stream_TREADY = black_box_w_s_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

module C_BUFFER_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [63:0]   i_stream_TDATA,
  input  wire          i_s_stream_TVALID,
  output wire          i_s_stream_TREADY,
  input  wire [7:0]    i_s_stream_TDATA,
  output wire          q_stream_TVALID,
  input  wire          q_stream_TREADY,
  output wire [63:0]   q_stream_TDATA,
  output wire          s_stream_TVALID,
  input  wire          s_stream_TREADY,
  output wire [7:0]    s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire                black_box_i_s_stream_TREADY;
  wire       [63:0]   black_box_q_stream_TDATA;
  wire                black_box_q_stream_TVALID;
  wire       [7:0]    black_box_s_stream_TDATA;
  wire                black_box_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  C_BUFFER black_box (
    .ap_clk            (clk                           ), //i
    .ap_rst_n          (resetn                        ), //i
    .ap_start          (manager_25_ap_ctrl_ap_start   ), //i
    .ap_continue       (manager_25_ap_ctrl_ap_continue), //i
    .ap_idle           (black_box_ap_idle             ), //o
    .ap_ready          (black_box_ap_ready            ), //o
    .ap_done           (black_box_ap_done             ), //o
    .i_stream_TDATA    (i_stream_TDATA[63:0]          ), //i
    .i_stream_TVALID   (i_stream_TVALID               ), //i
    .i_stream_TREADY   (black_box_i_stream_TREADY     ), //o
    .i_s_stream_TDATA  (i_s_stream_TDATA[7:0]         ), //i
    .i_s_stream_TVALID (i_s_stream_TVALID             ), //i
    .i_s_stream_TREADY (black_box_i_s_stream_TREADY   ), //o
    .q_stream_TDATA    (black_box_q_stream_TDATA[63:0]), //o
    .q_stream_TVALID   (black_box_q_stream_TVALID     ), //o
    .q_stream_TREADY   (q_stream_TREADY               ), //i
    .s_stream_TDATA    (black_box_s_stream_TDATA[7:0] ), //o
    .s_stream_TVALID   (black_box_s_stream_TVALID     ), //o
    .s_stream_TREADY   (s_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign i_s_stream_TREADY = black_box_i_s_stream_TREADY;
  assign q_stream_TDATA = black_box_q_stream_TDATA;
  assign q_stream_TVALID = black_box_q_stream_TVALID;
  assign s_stream_TDATA = black_box_s_stream_TDATA;
  assign s_stream_TVALID = black_box_s_stream_TVALID;

endmodule

module B_BUFFER_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [63:0]   i_stream_TDATA,
  input  wire          i_s_stream_TVALID,
  output wire          i_s_stream_TREADY,
  input  wire [7:0]    i_s_stream_TDATA,
  output wire          q_stream_TVALID,
  input  wire          q_stream_TREADY,
  output wire [63:0]   q_stream_TDATA,
  output wire          s_stream_TVALID,
  input  wire          s_stream_TREADY,
  output wire [7:0]    s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire                black_box_i_s_stream_TREADY;
  wire       [63:0]   black_box_q_stream_TDATA;
  wire                black_box_q_stream_TVALID;
  wire       [7:0]    black_box_s_stream_TDATA;
  wire                black_box_s_stream_TVALID;
  wire       [31:0]   manager_25_signals_O_L_BEGIN;
  wire       [31:0]   manager_25_signals_O_L_CLOSE;
  wire       [63:0]   manager_25_signals_O_MEMORY_X;
  wire       [63:0]   manager_25_signals_O_MEMORY_W;
  wire       [63:0]   manager_25_signals_O_MEMORY_Y;
  wire       [63:0]   manager_25_signals_O_MEMORY_C;
  wire       [63:0]   manager_25_signals_O_MEMORY_H;
  wire       [11:0]   manager_25_signals_O_POS;
  wire                manager_25_signals_O_T;
  wire                manager_25_ap_ctrl_ap_start;
  wire                manager_25_ap_ctrl_ap_continue;
  wire       [31:0]   manager_25_l;

  B_BUFFER black_box (
    .ap_clk            (clk                           ), //i
    .ap_rst_n          (resetn                        ), //i
    .ap_start          (manager_25_ap_ctrl_ap_start   ), //i
    .ap_continue       (manager_25_ap_ctrl_ap_continue), //i
    .ap_idle           (black_box_ap_idle             ), //o
    .ap_ready          (black_box_ap_ready            ), //o
    .ap_done           (black_box_ap_done             ), //o
    .i_stream_TDATA    (i_stream_TDATA[63:0]          ), //i
    .i_stream_TVALID   (i_stream_TVALID               ), //i
    .i_stream_TREADY   (black_box_i_stream_TREADY     ), //o
    .i_s_stream_TDATA  (i_s_stream_TDATA[7:0]         ), //i
    .i_s_stream_TVALID (i_s_stream_TVALID             ), //i
    .i_s_stream_TREADY (black_box_i_s_stream_TREADY   ), //o
    .q_stream_TDATA    (black_box_q_stream_TDATA[63:0]), //o
    .q_stream_TVALID   (black_box_q_stream_TVALID     ), //o
    .q_stream_TREADY   (q_stream_TREADY               ), //i
    .s_stream_TDATA    (black_box_s_stream_TDATA[7:0] ), //o
    .s_stream_TVALID   (black_box_s_stream_TVALID     ), //o
    .s_stream_TREADY   (s_stream_TREADY               )  //i
  );
  Manager_24 manager_25 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_25_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_25_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_25_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_25_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_25_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_25_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_25_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_25_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_25_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_25_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_25_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_25_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_25_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_25_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_25_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_25_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_25_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_25_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_25_signals_O_MEMORY_H;
  assign signals_O_POS = manager_25_signals_O_POS;
  assign signals_O_T = manager_25_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign i_s_stream_TREADY = black_box_i_s_stream_TREADY;
  assign q_stream_TDATA = black_box_q_stream_TDATA;
  assign q_stream_TVALID = black_box_q_stream_TVALID;
  assign s_stream_TDATA = black_box_s_stream_TDATA;
  assign s_stream_TVALID = black_box_s_stream_TVALID;

endmodule

//Manager replaced by Manager_24

//Manager_1 replaced by Manager_24

//Manager_2 replaced by Manager_24

//Manager_3 replaced by Manager_24

//Manager_4 replaced by Manager_24

//Manager_5 replaced by Manager_24

//Manager_6 replaced by Manager_24

module Manager_7 (
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  output reg           ap_ctrl_ap_start,
  output wire          ap_ctrl_ap_continue,
  input  wire          ap_ctrl_ap_idle,
  input  wire          ap_ctrl_ap_ready,
  input  wire          ap_ctrl_ap_done,
  output wire [31:0]   l,
  input  wire          clk,
  input  wire          resetn
);
  localparam fsm_enumDef_BOOT = 2'd0;
  localparam fsm_enumDef_s_idle = 2'd1;
  localparam fsm_enumDef_s_work = 2'd2;
  localparam fsm_enumDef_s_wait = 2'd3;

  reg        [31:0]   signals_I_L_BEGIN_regNext;
  reg        [31:0]   signals_I_L_CLOSE_regNext;
  reg        [63:0]   signals_I_MEMORY_X_regNext;
  reg        [63:0]   signals_I_MEMORY_W_regNext;
  reg        [63:0]   signals_I_MEMORY_Y_regNext;
  reg        [63:0]   signals_I_MEMORY_C_regNext;
  reg        [63:0]   signals_I_MEMORY_H_regNext;
  reg        [11:0]   signals_I_POS_regNext;
  reg                 signals_I_T_regNext;
  reg        [31:0]   l_counter;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                when_Manager_l147;
  `ifndef SYNTHESIS
  reg [47:0] fsm_stateReg_string;
  reg [47:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT  ";
      fsm_enumDef_s_idle : fsm_stateReg_string = "s_idle";
      fsm_enumDef_s_work : fsm_stateReg_string = "s_work";
      fsm_enumDef_s_wait : fsm_stateReg_string = "s_wait";
      default : fsm_stateReg_string = "??????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT  ";
      fsm_enumDef_s_idle : fsm_stateNext_string = "s_idle";
      fsm_enumDef_s_work : fsm_stateNext_string = "s_work";
      fsm_enumDef_s_wait : fsm_stateNext_string = "s_wait";
      default : fsm_stateNext_string = "??????";
    endcase
  end
  `endif

  assign signals_O_L_BEGIN = signals_I_L_BEGIN_regNext;
  assign signals_O_L_CLOSE = signals_I_L_CLOSE_regNext;
  assign signals_O_MEMORY_X = signals_I_MEMORY_X_regNext;
  assign signals_O_MEMORY_W = signals_I_MEMORY_W_regNext;
  assign signals_O_MEMORY_Y = signals_I_MEMORY_Y_regNext;
  assign signals_O_MEMORY_C = signals_I_MEMORY_C_regNext;
  assign signals_O_MEMORY_H = signals_I_MEMORY_H_regNext;
  assign signals_O_POS = signals_I_POS_regNext;
  assign signals_O_T = signals_I_T_regNext;
  assign l = l_counter;
  assign ap_ctrl_ap_continue = 1'b1;
  always @(*) begin
    ap_ctrl_ap_start = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
      end
      fsm_enumDef_s_work : begin
        ap_ctrl_ap_start = 1'b1;
      end
      fsm_enumDef_s_wait : begin
        ap_ctrl_ap_start = 1'b0;
      end
      default : begin
      end
    endcase
  end

  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
      end
      fsm_enumDef_s_work : begin
      end
      fsm_enumDef_s_wait : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
        if(signals_I_T) begin
          fsm_stateNext = fsm_enumDef_s_work;
        end
      end
      fsm_enumDef_s_work : begin
        if(ap_ctrl_ap_ready) begin
          if(when_Manager_l147) begin
            fsm_stateNext = fsm_enumDef_s_idle;
          end else begin
            fsm_stateNext = fsm_enumDef_s_wait;
          end
        end
      end
      fsm_enumDef_s_wait : begin
        if(ap_ctrl_ap_idle) begin
          fsm_stateNext = fsm_enumDef_s_work;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_s_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  assign when_Manager_l147 = 1'b1;
  always @(posedge clk) begin
    signals_I_L_BEGIN_regNext <= signals_I_L_BEGIN;
    signals_I_L_CLOSE_regNext <= signals_I_L_CLOSE;
    signals_I_MEMORY_X_regNext <= signals_I_MEMORY_X;
    signals_I_MEMORY_W_regNext <= signals_I_MEMORY_W;
    signals_I_MEMORY_Y_regNext <= signals_I_MEMORY_Y;
    signals_I_MEMORY_C_regNext <= signals_I_MEMORY_C;
    signals_I_MEMORY_H_regNext <= signals_I_MEMORY_H;
    signals_I_POS_regNext <= signals_I_POS;
    signals_I_T_regNext <= signals_I_T;
  end

  always @(posedge clk) begin
    if(!resetn) begin
      l_counter <= 32'h00000000;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_s_idle : begin
          if(signals_I_T) begin
            l_counter <= signals_I_L_BEGIN;
          end
        end
        fsm_enumDef_s_work : begin
          if(ap_ctrl_ap_ready) begin
            if(!when_Manager_l147) begin
              l_counter <= (l_counter + 32'h00000001);
            end
          end
        end
        fsm_enumDef_s_wait : begin
        end
        default : begin
        end
      endcase
    end
  end


endmodule

//Manager_8 replaced by Manager_24

//Manager_9 replaced by Manager_24

//Manager_10 replaced by Manager_24

//Manager_11 replaced by Manager_24

//Manager_12 replaced by Manager_24

//Manager_13 replaced by Manager_24

//Manager_14 replaced by Manager_24

//Manager_15 replaced by Manager_24

//Manager_16 replaced by Manager_24

//Manager_17 replaced by Manager_24

//Manager_18 replaced by Manager_24

//Manager_19 replaced by Manager_24

//Manager_20 replaced by Manager_24

//Manager_21 replaced by Manager_24

//Manager_22 replaced by Manager_24

//Manager_23 replaced by Manager_24

module Manager_24 (
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [63:0]   signals_I_MEMORY_C,
  input  wire [63:0]   signals_I_MEMORY_H,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [63:0]   signals_O_MEMORY_C,
  output wire [63:0]   signals_O_MEMORY_H,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  output reg           ap_ctrl_ap_start,
  output wire          ap_ctrl_ap_continue,
  input  wire          ap_ctrl_ap_idle,
  input  wire          ap_ctrl_ap_ready,
  input  wire          ap_ctrl_ap_done,
  output wire [31:0]   l,
  input  wire          clk,
  input  wire          resetn
);
  localparam fsm_enumDef_BOOT = 2'd0;
  localparam fsm_enumDef_s_idle = 2'd1;
  localparam fsm_enumDef_s_work = 2'd2;
  localparam fsm_enumDef_s_wait = 2'd3;

  wire       [31:0]   _zz_when_Manager_l147;
  reg        [31:0]   signals_I_L_BEGIN_regNext;
  reg        [31:0]   signals_I_L_CLOSE_regNext;
  reg        [63:0]   signals_I_MEMORY_X_regNext;
  reg        [63:0]   signals_I_MEMORY_W_regNext;
  reg        [63:0]   signals_I_MEMORY_Y_regNext;
  reg        [63:0]   signals_I_MEMORY_C_regNext;
  reg        [63:0]   signals_I_MEMORY_H_regNext;
  reg        [11:0]   signals_I_POS_regNext;
  reg                 signals_I_T_regNext;
  reg        [31:0]   l_counter;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                when_Manager_l147;
  `ifndef SYNTHESIS
  reg [47:0] fsm_stateReg_string;
  reg [47:0] fsm_stateNext_string;
  `endif


  assign _zz_when_Manager_l147 = (signals_I_L_CLOSE - 32'h00000001);
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT  ";
      fsm_enumDef_s_idle : fsm_stateReg_string = "s_idle";
      fsm_enumDef_s_work : fsm_stateReg_string = "s_work";
      fsm_enumDef_s_wait : fsm_stateReg_string = "s_wait";
      default : fsm_stateReg_string = "??????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT  ";
      fsm_enumDef_s_idle : fsm_stateNext_string = "s_idle";
      fsm_enumDef_s_work : fsm_stateNext_string = "s_work";
      fsm_enumDef_s_wait : fsm_stateNext_string = "s_wait";
      default : fsm_stateNext_string = "??????";
    endcase
  end
  `endif

  assign signals_O_L_BEGIN = signals_I_L_BEGIN_regNext;
  assign signals_O_L_CLOSE = signals_I_L_CLOSE_regNext;
  assign signals_O_MEMORY_X = signals_I_MEMORY_X_regNext;
  assign signals_O_MEMORY_W = signals_I_MEMORY_W_regNext;
  assign signals_O_MEMORY_Y = signals_I_MEMORY_Y_regNext;
  assign signals_O_MEMORY_C = signals_I_MEMORY_C_regNext;
  assign signals_O_MEMORY_H = signals_I_MEMORY_H_regNext;
  assign signals_O_POS = signals_I_POS_regNext;
  assign signals_O_T = signals_I_T_regNext;
  assign l = l_counter;
  assign ap_ctrl_ap_continue = 1'b1;
  always @(*) begin
    ap_ctrl_ap_start = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
      end
      fsm_enumDef_s_work : begin
        ap_ctrl_ap_start = 1'b1;
      end
      fsm_enumDef_s_wait : begin
        ap_ctrl_ap_start = 1'b0;
      end
      default : begin
      end
    endcase
  end

  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
      end
      fsm_enumDef_s_work : begin
      end
      fsm_enumDef_s_wait : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
        if(signals_I_T) begin
          fsm_stateNext = fsm_enumDef_s_work;
        end
      end
      fsm_enumDef_s_work : begin
        if(ap_ctrl_ap_ready) begin
          if(when_Manager_l147) begin
            fsm_stateNext = fsm_enumDef_s_idle;
          end else begin
            fsm_stateNext = fsm_enumDef_s_wait;
          end
        end
      end
      fsm_enumDef_s_wait : begin
        if(ap_ctrl_ap_idle) begin
          fsm_stateNext = fsm_enumDef_s_work;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_s_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  assign when_Manager_l147 = (l_counter == _zz_when_Manager_l147);
  always @(posedge clk) begin
    signals_I_L_BEGIN_regNext <= signals_I_L_BEGIN;
    signals_I_L_CLOSE_regNext <= signals_I_L_CLOSE;
    signals_I_MEMORY_X_regNext <= signals_I_MEMORY_X;
    signals_I_MEMORY_W_regNext <= signals_I_MEMORY_W;
    signals_I_MEMORY_Y_regNext <= signals_I_MEMORY_Y;
    signals_I_MEMORY_C_regNext <= signals_I_MEMORY_C;
    signals_I_MEMORY_H_regNext <= signals_I_MEMORY_H;
    signals_I_POS_regNext <= signals_I_POS;
    signals_I_T_regNext <= signals_I_T;
  end

  always @(posedge clk) begin
    if(!resetn) begin
      l_counter <= 32'h00000000;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_s_idle : begin
          if(signals_I_T) begin
            l_counter <= signals_I_L_BEGIN;
          end
        end
        fsm_enumDef_s_work : begin
          if(ap_ctrl_ap_ready) begin
            if(!when_Manager_l147) begin
              l_counter <= (l_counter + 32'h00000001);
            end
          end
        end
        fsm_enumDef_s_wait : begin
        end
        default : begin
        end
      endcase
    end
  end


endmodule

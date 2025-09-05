// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : ACCELERATOR
// Git hash  : 79e645f08db4b61f66fa178c9252b19210d0b725

`timescale 1ns/1ps

module ACCELERATOR (
  input  wire          resetn,
  input  wire          clk,
  input  wire          axilite_awvalid,
  output wire          axilite_awready,
  input  wire [15:0]   axilite_awaddr,
  input  wire [2:0]    axilite_awprot,
  input  wire          axilite_wvalid,
  output wire          axilite_wready,
  input  wire [63:0]   axilite_wdata,
  input  wire [7:0]    axilite_wstrb,
  output wire          axilite_bvalid,
  input  wire          axilite_bready,
  output wire [1:0]    axilite_bresp,
  input  wire          axilite_arvalid,
  output wire          axilite_arready,
  input  wire [15:0]   axilite_araddr,
  input  wire [2:0]    axilite_arprot,
  output wire          axilite_rvalid,
  input  wire          axilite_rready,
  output wire [63:0]   axilite_rdata,
  output wire [1:0]    axilite_rresp,
  output wire          m_axi_awvalid,
  input  wire          m_axi_awready,
  output wire [47:0]   m_axi_awaddr,
  output wire [0:0]    m_axi_awid,
  output wire [3:0]    m_axi_awregion,
  output wire [7:0]    m_axi_awlen,
  output wire [2:0]    m_axi_awsize,
  output wire [1:0]    m_axi_awburst,
  output wire [0:0]    m_axi_awlock,
  output wire [3:0]    m_axi_awcache,
  output wire [3:0]    m_axi_awqos,
  output wire [0:0]    m_axi_awuser,
  output wire [2:0]    m_axi_awprot,
  output wire          m_axi_wvalid,
  input  wire          m_axi_wready,
  output wire [255:0]  m_axi_wdata,
  output wire [31:0]   m_axi_wstrb,
  output wire [0:0]    m_axi_wuser,
  output wire          m_axi_wlast,
  input  wire          m_axi_bvalid,
  output wire          m_axi_bready,
  input  wire [0:0]    m_axi_bid,
  input  wire [1:0]    m_axi_bresp,
  input  wire [0:0]    m_axi_buser,
  output wire          m_axi_arvalid,
  input  wire          m_axi_arready,
  output wire [47:0]   m_axi_araddr,
  output wire [0:0]    m_axi_arid,
  output wire [3:0]    m_axi_arregion,
  output wire [7:0]    m_axi_arlen,
  output wire [2:0]    m_axi_arsize,
  output wire [1:0]    m_axi_arburst,
  output wire [0:0]    m_axi_arlock,
  output wire [3:0]    m_axi_arcache,
  output wire [3:0]    m_axi_arqos,
  output wire [0:0]    m_axi_aruser,
  output wire [2:0]    m_axi_arprot,
  input  wire          m_axi_rvalid,
  output wire          m_axi_rready,
  input  wire [255:0]  m_axi_rdata,
  input  wire [0:0]    m_axi_rid,
  input  wire [1:0]    m_axi_rresp,
  input  wire          m_axi_rlast,
  input  wire [0:0]    m_axi_ruser,
  output wire          idle
);

  wire                toplevel_inst_m_axi_wq_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_ws1_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_ws2_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_cq_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_cs_stream_fifo_io_flush;
  wire                toplevel_inst_mamba_cq2_stream_fifo_io_flush;
  wire                toplevel_inst_mamba_cs2_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_hq_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_hs_stream_fifo_io_flush;
  wire                toplevel_inst_mamba_hq2_stream_fifo_io_flush;
  wire                toplevel_inst_mamba_hs2_stream_fifo_io_flush;
  wire                toplevel_inst_mamba_y_stream_fifo_io_flush;
  wire       [31:0]   inst_mamba_signals_O_L_BEGIN;
  wire       [31:0]   inst_mamba_signals_O_L_CLOSE;
  wire       [63:0]   inst_mamba_signals_O_MEMORY_X;
  wire       [63:0]   inst_mamba_signals_O_MEMORY_W;
  wire       [63:0]   inst_mamba_signals_O_MEMORY_Y;
  wire       [63:0]   inst_mamba_signals_O_MEMORY_C;
  wire       [63:0]   inst_mamba_signals_O_MEMORY_H;
  wire       [11:0]   inst_mamba_signals_O_POS;
  wire                inst_mamba_signals_O_T;
  wire                inst_mamba_x_stream_TREADY;
  wire                inst_mamba_w_stream_TREADY;
  wire                inst_mamba_s1_stream_TREADY;
  wire                inst_mamba_s2_stream_TREADY;
  wire                inst_mamba_y_stream_TVALID;
  wire       [255:0]  inst_mamba_y_stream_TDATA;
  wire                inst_mamba_cq_stream_TREADY;
  wire                inst_mamba_cs_stream_TREADY;
  wire                inst_mamba_cq2_stream_TVALID;
  wire       [255:0]  inst_mamba_cq2_stream_TDATA;
  wire                inst_mamba_cs2_stream_TVALID;
  wire       [255:0]  inst_mamba_cs2_stream_TDATA;
  wire                inst_mamba_hq_stream_TREADY;
  wire                inst_mamba_hs_stream_TREADY;
  wire                inst_mamba_hq2_stream_TVALID;
  wire       [255:0]  inst_mamba_hq2_stream_TDATA;
  wire                inst_mamba_hs2_stream_TVALID;
  wire       [255:0]  inst_mamba_hs2_stream_TDATA;
  wire       [31:0]   inst_m_axi_signals_O_L_BEGIN;
  wire       [31:0]   inst_m_axi_signals_O_L_CLOSE;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_X;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_W;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_Y;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_C;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_H;
  wire       [11:0]   inst_m_axi_signals_O_POS;
  wire                inst_m_axi_signals_O_T;
  wire                inst_m_axi_m_axi_arvalid;
  wire       [47:0]   inst_m_axi_m_axi_araddr;
  wire       [0:0]    inst_m_axi_m_axi_arid;
  wire       [3:0]    inst_m_axi_m_axi_arregion;
  wire       [7:0]    inst_m_axi_m_axi_arlen;
  wire       [2:0]    inst_m_axi_m_axi_arsize;
  wire       [1:0]    inst_m_axi_m_axi_arburst;
  wire       [0:0]    inst_m_axi_m_axi_arlock;
  wire       [3:0]    inst_m_axi_m_axi_arcache;
  wire       [3:0]    inst_m_axi_m_axi_arqos;
  wire       [0:0]    inst_m_axi_m_axi_aruser;
  wire       [2:0]    inst_m_axi_m_axi_arprot;
  wire                inst_m_axi_m_axi_awvalid;
  wire       [47:0]   inst_m_axi_m_axi_awaddr;
  wire       [0:0]    inst_m_axi_m_axi_awid;
  wire       [3:0]    inst_m_axi_m_axi_awregion;
  wire       [7:0]    inst_m_axi_m_axi_awlen;
  wire       [2:0]    inst_m_axi_m_axi_awsize;
  wire       [1:0]    inst_m_axi_m_axi_awburst;
  wire       [0:0]    inst_m_axi_m_axi_awlock;
  wire       [3:0]    inst_m_axi_m_axi_awcache;
  wire       [3:0]    inst_m_axi_m_axi_awqos;
  wire       [0:0]    inst_m_axi_m_axi_awuser;
  wire       [2:0]    inst_m_axi_m_axi_awprot;
  wire                inst_m_axi_m_axi_wvalid;
  wire       [255:0]  inst_m_axi_m_axi_wdata;
  wire       [31:0]   inst_m_axi_m_axi_wstrb;
  wire       [0:0]    inst_m_axi_m_axi_wuser;
  wire                inst_m_axi_m_axi_wlast;
  wire                inst_m_axi_m_axi_rready;
  wire                inst_m_axi_m_axi_bready;
  wire                inst_m_axi_x_stream_TVALID;
  wire       [255:0]  inst_m_axi_x_stream_TDATA;
  wire                inst_m_axi_wq_stream_TVALID;
  wire       [255:0]  inst_m_axi_wq_stream_TDATA;
  wire                inst_m_axi_ws1_stream_TVALID;
  wire       [23:0]   inst_m_axi_ws1_stream_TDATA;
  wire                inst_m_axi_ws2_stream_TVALID;
  wire       [23:0]   inst_m_axi_ws2_stream_TDATA;
  wire                inst_m_axi_y_stream_TREADY;
  wire                inst_m_axi_cq_stream_TVALID;
  wire       [255:0]  inst_m_axi_cq_stream_TDATA;
  wire                inst_m_axi_cs_stream_TVALID;
  wire       [255:0]  inst_m_axi_cs_stream_TDATA;
  wire                inst_m_axi_cq2_stream_TREADY;
  wire                inst_m_axi_cs2_stream_TREADY;
  wire                inst_m_axi_hq_stream_TVALID;
  wire       [255:0]  inst_m_axi_hq_stream_TDATA;
  wire                inst_m_axi_hs_stream_TVALID;
  wire       [255:0]  inst_m_axi_hs_stream_TDATA;
  wire                inst_m_axi_hq2_stream_TREADY;
  wire                inst_m_axi_hs2_stream_TREADY;
  wire                inst_m_axi_idle;
  wire                inst_controller_axilite_awready;
  wire                inst_controller_axilite_wready;
  wire                inst_controller_axilite_bvalid;
  wire       [1:0]    inst_controller_axilite_bresp;
  wire                inst_controller_axilite_arready;
  wire                inst_controller_axilite_rvalid;
  wire       [63:0]   inst_controller_axilite_rdata;
  wire       [1:0]    inst_controller_axilite_rresp;
  wire       [31:0]   inst_controller_signals_L_BEGIN;
  wire       [31:0]   inst_controller_signals_L_CLOSE;
  wire       [63:0]   inst_controller_signals_MEMORY_X;
  wire       [63:0]   inst_controller_signals_MEMORY_W;
  wire       [63:0]   inst_controller_signals_MEMORY_Y;
  wire       [63:0]   inst_controller_signals_MEMORY_C;
  wire       [63:0]   inst_controller_signals_MEMORY_H;
  wire       [11:0]   inst_controller_signals_POS;
  wire                inst_controller_signals_T;
  wire                toplevel_inst_m_axi_wq_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_wq_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_m_axi_wq_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_wq_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_wq_stream_fifo_io_availability;
  wire                toplevel_inst_m_axi_ws1_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_ws1_stream_fifo_io_pop_valid;
  wire       [23:0]   toplevel_inst_m_axi_ws1_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_ws1_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_ws1_stream_fifo_io_availability;
  wire                toplevel_inst_m_axi_ws2_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_ws2_stream_fifo_io_pop_valid;
  wire       [23:0]   toplevel_inst_m_axi_ws2_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_ws2_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_ws2_stream_fifo_io_availability;
  wire                toplevel_inst_m_axi_cq_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_cq_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_m_axi_cq_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_cq_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_cq_stream_fifo_io_availability;
  wire                toplevel_inst_m_axi_cs_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_cs_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_m_axi_cs_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_cs_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_cs_stream_fifo_io_availability;
  wire                toplevel_inst_mamba_cq2_stream_fifo_io_push_ready;
  wire                toplevel_inst_mamba_cq2_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_mamba_cq2_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_mamba_cq2_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_mamba_cq2_stream_fifo_io_availability;
  wire                toplevel_inst_mamba_cs2_stream_fifo_io_push_ready;
  wire                toplevel_inst_mamba_cs2_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_mamba_cs2_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_mamba_cs2_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_mamba_cs2_stream_fifo_io_availability;
  wire                toplevel_inst_m_axi_hq_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_hq_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_m_axi_hq_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_hq_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_hq_stream_fifo_io_availability;
  wire                toplevel_inst_m_axi_hs_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_hs_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_m_axi_hs_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_hs_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_hs_stream_fifo_io_availability;
  wire                toplevel_inst_mamba_hq2_stream_fifo_io_push_ready;
  wire                toplevel_inst_mamba_hq2_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_mamba_hq2_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_mamba_hq2_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_mamba_hq2_stream_fifo_io_availability;
  wire                toplevel_inst_mamba_hs2_stream_fifo_io_push_ready;
  wire                toplevel_inst_mamba_hs2_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_mamba_hs2_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_mamba_hs2_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_mamba_hs2_stream_fifo_io_availability;
  wire                toplevel_inst_mamba_y_stream_fifo_io_push_ready;
  wire                toplevel_inst_mamba_y_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_mamba_y_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_mamba_y_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_mamba_y_stream_fifo_io_availability;

  MAMBA inst_mamba (
    .resetn             (resetn                                                       ), //i
    .clk                (clk                                                          ), //i
    .signals_I_L_BEGIN  (inst_m_axi_signals_O_L_BEGIN[31:0]                           ), //i
    .signals_I_L_CLOSE  (inst_m_axi_signals_O_L_CLOSE[31:0]                           ), //i
    .signals_I_MEMORY_X (inst_m_axi_signals_O_MEMORY_X[63:0]                          ), //i
    .signals_I_MEMORY_W (inst_m_axi_signals_O_MEMORY_W[63:0]                          ), //i
    .signals_I_MEMORY_Y (inst_m_axi_signals_O_MEMORY_Y[63:0]                          ), //i
    .signals_I_MEMORY_C (inst_m_axi_signals_O_MEMORY_C[63:0]                          ), //i
    .signals_I_MEMORY_H (inst_m_axi_signals_O_MEMORY_H[63:0]                          ), //i
    .signals_I_POS      (inst_m_axi_signals_O_POS[11:0]                               ), //i
    .signals_I_T        (inst_m_axi_signals_O_T                                       ), //i
    .signals_O_L_BEGIN  (inst_mamba_signals_O_L_BEGIN[31:0]                           ), //o
    .signals_O_L_CLOSE  (inst_mamba_signals_O_L_CLOSE[31:0]                           ), //o
    .signals_O_MEMORY_X (inst_mamba_signals_O_MEMORY_X[63:0]                          ), //o
    .signals_O_MEMORY_W (inst_mamba_signals_O_MEMORY_W[63:0]                          ), //o
    .signals_O_MEMORY_Y (inst_mamba_signals_O_MEMORY_Y[63:0]                          ), //o
    .signals_O_MEMORY_C (inst_mamba_signals_O_MEMORY_C[63:0]                          ), //o
    .signals_O_MEMORY_H (inst_mamba_signals_O_MEMORY_H[63:0]                          ), //o
    .signals_O_POS      (inst_mamba_signals_O_POS[11:0]                               ), //o
    .signals_O_T        (inst_mamba_signals_O_T                                       ), //o
    .x_stream_TVALID    (inst_m_axi_x_stream_TVALID                                   ), //i
    .x_stream_TREADY    (inst_mamba_x_stream_TREADY                                   ), //o
    .x_stream_TDATA     (inst_m_axi_x_stream_TDATA[255:0]                             ), //i
    .w_stream_TVALID    (toplevel_inst_m_axi_wq_stream_fifo_io_pop_valid              ), //i
    .w_stream_TREADY    (inst_mamba_w_stream_TREADY                                   ), //o
    .w_stream_TDATA     (toplevel_inst_m_axi_wq_stream_fifo_io_pop_payload_data[255:0]), //i
    .s1_stream_TVALID   (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_valid             ), //i
    .s1_stream_TREADY   (inst_mamba_s1_stream_TREADY                                  ), //o
    .s1_stream_TDATA    (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_payload_data[23:0]), //i
    .s2_stream_TVALID   (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_valid             ), //i
    .s2_stream_TREADY   (inst_mamba_s2_stream_TREADY                                  ), //o
    .s2_stream_TDATA    (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_payload_data[23:0]), //i
    .y_stream_TVALID    (inst_mamba_y_stream_TVALID                                   ), //o
    .y_stream_TREADY    (toplevel_inst_mamba_y_stream_fifo_io_push_ready              ), //i
    .y_stream_TDATA     (inst_mamba_y_stream_TDATA[255:0]                             ), //o
    .cq_stream_TVALID   (toplevel_inst_m_axi_cq_stream_fifo_io_pop_valid              ), //i
    .cq_stream_TREADY   (inst_mamba_cq_stream_TREADY                                  ), //o
    .cq_stream_TDATA    (toplevel_inst_m_axi_cq_stream_fifo_io_pop_payload_data[255:0]), //i
    .cs_stream_TVALID   (toplevel_inst_m_axi_cs_stream_fifo_io_pop_valid              ), //i
    .cs_stream_TREADY   (inst_mamba_cs_stream_TREADY                                  ), //o
    .cs_stream_TDATA    (toplevel_inst_m_axi_cs_stream_fifo_io_pop_payload_data[255:0]), //i
    .cq2_stream_TVALID  (inst_mamba_cq2_stream_TVALID                                 ), //o
    .cq2_stream_TREADY  (toplevel_inst_mamba_cq2_stream_fifo_io_push_ready            ), //i
    .cq2_stream_TDATA   (inst_mamba_cq2_stream_TDATA[255:0]                           ), //o
    .cs2_stream_TVALID  (inst_mamba_cs2_stream_TVALID                                 ), //o
    .cs2_stream_TREADY  (toplevel_inst_mamba_cs2_stream_fifo_io_push_ready            ), //i
    .cs2_stream_TDATA   (inst_mamba_cs2_stream_TDATA[255:0]                           ), //o
    .hq_stream_TVALID   (toplevel_inst_m_axi_hq_stream_fifo_io_pop_valid              ), //i
    .hq_stream_TREADY   (inst_mamba_hq_stream_TREADY                                  ), //o
    .hq_stream_TDATA    (toplevel_inst_m_axi_hq_stream_fifo_io_pop_payload_data[255:0]), //i
    .hs_stream_TVALID   (toplevel_inst_m_axi_hs_stream_fifo_io_pop_valid              ), //i
    .hs_stream_TREADY   (inst_mamba_hs_stream_TREADY                                  ), //o
    .hs_stream_TDATA    (toplevel_inst_m_axi_hs_stream_fifo_io_pop_payload_data[255:0]), //i
    .hq2_stream_TVALID  (inst_mamba_hq2_stream_TVALID                                 ), //o
    .hq2_stream_TREADY  (toplevel_inst_mamba_hq2_stream_fifo_io_push_ready            ), //i
    .hq2_stream_TDATA   (inst_mamba_hq2_stream_TDATA[255:0]                           ), //o
    .hs2_stream_TVALID  (inst_mamba_hs2_stream_TVALID                                 ), //o
    .hs2_stream_TREADY  (toplevel_inst_mamba_hs2_stream_fifo_io_push_ready            ), //i
    .hs2_stream_TDATA   (inst_mamba_hs2_stream_TDATA[255:0]                           )  //o
  );
  M_AXI inst_m_axi (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (inst_controller_signals_L_BEGIN[31:0]                         ), //i
    .signals_I_L_CLOSE  (inst_controller_signals_L_CLOSE[31:0]                         ), //i
    .signals_I_MEMORY_X (inst_controller_signals_MEMORY_X[63:0]                        ), //i
    .signals_I_MEMORY_W (inst_controller_signals_MEMORY_W[63:0]                        ), //i
    .signals_I_MEMORY_Y (inst_controller_signals_MEMORY_Y[63:0]                        ), //i
    .signals_I_MEMORY_C (inst_controller_signals_MEMORY_C[63:0]                        ), //i
    .signals_I_MEMORY_H (inst_controller_signals_MEMORY_H[63:0]                        ), //i
    .signals_I_POS      (inst_controller_signals_POS[11:0]                             ), //i
    .signals_I_T        (inst_controller_signals_T                                     ), //i
    .signals_O_L_BEGIN  (inst_m_axi_signals_O_L_BEGIN[31:0]                            ), //o
    .signals_O_L_CLOSE  (inst_m_axi_signals_O_L_CLOSE[31:0]                            ), //o
    .signals_O_MEMORY_X (inst_m_axi_signals_O_MEMORY_X[63:0]                           ), //o
    .signals_O_MEMORY_W (inst_m_axi_signals_O_MEMORY_W[63:0]                           ), //o
    .signals_O_MEMORY_Y (inst_m_axi_signals_O_MEMORY_Y[63:0]                           ), //o
    .signals_O_MEMORY_C (inst_m_axi_signals_O_MEMORY_C[63:0]                           ), //o
    .signals_O_MEMORY_H (inst_m_axi_signals_O_MEMORY_H[63:0]                           ), //o
    .signals_O_POS      (inst_m_axi_signals_O_POS[11:0]                                ), //o
    .signals_O_T        (inst_m_axi_signals_O_T                                        ), //o
    .m_axi_awvalid      (inst_m_axi_m_axi_awvalid                                      ), //o
    .m_axi_awready      (m_axi_awready                                                 ), //i
    .m_axi_awaddr       (inst_m_axi_m_axi_awaddr[47:0]                                 ), //o
    .m_axi_awid         (inst_m_axi_m_axi_awid                                         ), //o
    .m_axi_awregion     (inst_m_axi_m_axi_awregion[3:0]                                ), //o
    .m_axi_awlen        (inst_m_axi_m_axi_awlen[7:0]                                   ), //o
    .m_axi_awsize       (inst_m_axi_m_axi_awsize[2:0]                                  ), //o
    .m_axi_awburst      (inst_m_axi_m_axi_awburst[1:0]                                 ), //o
    .m_axi_awlock       (inst_m_axi_m_axi_awlock                                       ), //o
    .m_axi_awcache      (inst_m_axi_m_axi_awcache[3:0]                                 ), //o
    .m_axi_awqos        (inst_m_axi_m_axi_awqos[3:0]                                   ), //o
    .m_axi_awuser       (inst_m_axi_m_axi_awuser                                       ), //o
    .m_axi_awprot       (inst_m_axi_m_axi_awprot[2:0]                                  ), //o
    .m_axi_wvalid       (inst_m_axi_m_axi_wvalid                                       ), //o
    .m_axi_wready       (m_axi_wready                                                  ), //i
    .m_axi_wdata        (inst_m_axi_m_axi_wdata[255:0]                                 ), //o
    .m_axi_wstrb        (inst_m_axi_m_axi_wstrb[31:0]                                  ), //o
    .m_axi_wuser        (inst_m_axi_m_axi_wuser                                        ), //o
    .m_axi_wlast        (inst_m_axi_m_axi_wlast                                        ), //o
    .m_axi_bvalid       (m_axi_bvalid                                                  ), //i
    .m_axi_bready       (inst_m_axi_m_axi_bready                                       ), //o
    .m_axi_bid          (m_axi_bid                                                     ), //i
    .m_axi_bresp        (m_axi_bresp[1:0]                                              ), //i
    .m_axi_buser        (m_axi_buser                                                   ), //i
    .m_axi_arvalid      (inst_m_axi_m_axi_arvalid                                      ), //o
    .m_axi_arready      (m_axi_arready                                                 ), //i
    .m_axi_araddr       (inst_m_axi_m_axi_araddr[47:0]                                 ), //o
    .m_axi_arid         (inst_m_axi_m_axi_arid                                         ), //o
    .m_axi_arregion     (inst_m_axi_m_axi_arregion[3:0]                                ), //o
    .m_axi_arlen        (inst_m_axi_m_axi_arlen[7:0]                                   ), //o
    .m_axi_arsize       (inst_m_axi_m_axi_arsize[2:0]                                  ), //o
    .m_axi_arburst      (inst_m_axi_m_axi_arburst[1:0]                                 ), //o
    .m_axi_arlock       (inst_m_axi_m_axi_arlock                                       ), //o
    .m_axi_arcache      (inst_m_axi_m_axi_arcache[3:0]                                 ), //o
    .m_axi_arqos        (inst_m_axi_m_axi_arqos[3:0]                                   ), //o
    .m_axi_aruser       (inst_m_axi_m_axi_aruser                                       ), //o
    .m_axi_arprot       (inst_m_axi_m_axi_arprot[2:0]                                  ), //o
    .m_axi_rvalid       (m_axi_rvalid                                                  ), //i
    .m_axi_rready       (inst_m_axi_m_axi_rready                                       ), //o
    .m_axi_rdata        (m_axi_rdata[255:0]                                            ), //i
    .m_axi_rid          (m_axi_rid                                                     ), //i
    .m_axi_rresp        (m_axi_rresp[1:0]                                              ), //i
    .m_axi_rlast        (m_axi_rlast                                                   ), //i
    .m_axi_ruser        (m_axi_ruser                                                   ), //i
    .x_stream_TVALID    (inst_m_axi_x_stream_TVALID                                    ), //o
    .x_stream_TREADY    (inst_mamba_x_stream_TREADY                                    ), //i
    .x_stream_TDATA     (inst_m_axi_x_stream_TDATA[255:0]                              ), //o
    .wq_stream_TVALID   (inst_m_axi_wq_stream_TVALID                                   ), //o
    .wq_stream_TREADY   (toplevel_inst_m_axi_wq_stream_fifo_io_push_ready              ), //i
    .wq_stream_TDATA    (inst_m_axi_wq_stream_TDATA[255:0]                             ), //o
    .ws1_stream_TVALID  (inst_m_axi_ws1_stream_TVALID                                  ), //o
    .ws1_stream_TREADY  (toplevel_inst_m_axi_ws1_stream_fifo_io_push_ready             ), //i
    .ws1_stream_TDATA   (inst_m_axi_ws1_stream_TDATA[23:0]                             ), //o
    .ws2_stream_TVALID  (inst_m_axi_ws2_stream_TVALID                                  ), //o
    .ws2_stream_TREADY  (toplevel_inst_m_axi_ws2_stream_fifo_io_push_ready             ), //i
    .ws2_stream_TDATA   (inst_m_axi_ws2_stream_TDATA[23:0]                             ), //o
    .y_stream_TVALID    (toplevel_inst_mamba_y_stream_fifo_io_pop_valid                ), //i
    .y_stream_TREADY    (inst_m_axi_y_stream_TREADY                                    ), //o
    .y_stream_TDATA     (toplevel_inst_mamba_y_stream_fifo_io_pop_payload_data[255:0]  ), //i
    .cq_stream_TVALID   (inst_m_axi_cq_stream_TVALID                                   ), //o
    .cq_stream_TREADY   (toplevel_inst_m_axi_cq_stream_fifo_io_push_ready              ), //i
    .cq_stream_TDATA    (inst_m_axi_cq_stream_TDATA[255:0]                             ), //o
    .cs_stream_TVALID   (inst_m_axi_cs_stream_TVALID                                   ), //o
    .cs_stream_TREADY   (toplevel_inst_m_axi_cs_stream_fifo_io_push_ready              ), //i
    .cs_stream_TDATA    (inst_m_axi_cs_stream_TDATA[255:0]                             ), //o
    .cq2_stream_TVALID  (toplevel_inst_mamba_cq2_stream_fifo_io_pop_valid              ), //i
    .cq2_stream_TREADY  (inst_m_axi_cq2_stream_TREADY                                  ), //o
    .cq2_stream_TDATA   (toplevel_inst_mamba_cq2_stream_fifo_io_pop_payload_data[255:0]), //i
    .cs2_stream_TVALID  (toplevel_inst_mamba_cs2_stream_fifo_io_pop_valid              ), //i
    .cs2_stream_TREADY  (inst_m_axi_cs2_stream_TREADY                                  ), //o
    .cs2_stream_TDATA   (toplevel_inst_mamba_cs2_stream_fifo_io_pop_payload_data[255:0]), //i
    .hq_stream_TVALID   (inst_m_axi_hq_stream_TVALID                                   ), //o
    .hq_stream_TREADY   (toplevel_inst_m_axi_hq_stream_fifo_io_push_ready              ), //i
    .hq_stream_TDATA    (inst_m_axi_hq_stream_TDATA[255:0]                             ), //o
    .hs_stream_TVALID   (inst_m_axi_hs_stream_TVALID                                   ), //o
    .hs_stream_TREADY   (toplevel_inst_m_axi_hs_stream_fifo_io_push_ready              ), //i
    .hs_stream_TDATA    (inst_m_axi_hs_stream_TDATA[255:0]                             ), //o
    .hq2_stream_TVALID  (toplevel_inst_mamba_hq2_stream_fifo_io_pop_valid              ), //i
    .hq2_stream_TREADY  (inst_m_axi_hq2_stream_TREADY                                  ), //o
    .hq2_stream_TDATA   (toplevel_inst_mamba_hq2_stream_fifo_io_pop_payload_data[255:0]), //i
    .hs2_stream_TVALID  (toplevel_inst_mamba_hs2_stream_fifo_io_pop_valid              ), //i
    .hs2_stream_TREADY  (inst_m_axi_hs2_stream_TREADY                                  ), //o
    .hs2_stream_TDATA   (toplevel_inst_mamba_hs2_stream_fifo_io_pop_payload_data[255:0]), //i
    .idle               (inst_m_axi_idle                                               )  //o
  );
  Controller inst_controller (
    .axilite_awvalid  (axilite_awvalid                       ), //i
    .axilite_awready  (inst_controller_axilite_awready       ), //o
    .axilite_awaddr   (axilite_awaddr[15:0]                  ), //i
    .axilite_awprot   (axilite_awprot[2:0]                   ), //i
    .axilite_wvalid   (axilite_wvalid                        ), //i
    .axilite_wready   (inst_controller_axilite_wready        ), //o
    .axilite_wdata    (axilite_wdata[63:0]                   ), //i
    .axilite_wstrb    (axilite_wstrb[7:0]                    ), //i
    .axilite_bvalid   (inst_controller_axilite_bvalid        ), //o
    .axilite_bready   (axilite_bready                        ), //i
    .axilite_bresp    (inst_controller_axilite_bresp[1:0]    ), //o
    .axilite_arvalid  (axilite_arvalid                       ), //i
    .axilite_arready  (inst_controller_axilite_arready       ), //o
    .axilite_araddr   (axilite_araddr[15:0]                  ), //i
    .axilite_arprot   (axilite_arprot[2:0]                   ), //i
    .axilite_rvalid   (inst_controller_axilite_rvalid        ), //o
    .axilite_rready   (axilite_rready                        ), //i
    .axilite_rdata    (inst_controller_axilite_rdata[63:0]   ), //o
    .axilite_rresp    (inst_controller_axilite_rresp[1:0]    ), //o
    .signals_L_BEGIN  (inst_controller_signals_L_BEGIN[31:0] ), //o
    .signals_L_CLOSE  (inst_controller_signals_L_CLOSE[31:0] ), //o
    .signals_MEMORY_X (inst_controller_signals_MEMORY_X[63:0]), //o
    .signals_MEMORY_W (inst_controller_signals_MEMORY_W[63:0]), //o
    .signals_MEMORY_Y (inst_controller_signals_MEMORY_Y[63:0]), //o
    .signals_MEMORY_C (inst_controller_signals_MEMORY_C[63:0]), //o
    .signals_MEMORY_H (inst_controller_signals_MEMORY_H[63:0]), //o
    .signals_POS      (inst_controller_signals_POS[11:0]     ), //o
    .signals_T        (inst_controller_signals_T             ), //o
    .idle             (inst_m_axi_idle                       ), //i
    .clk              (clk                                   ), //i
    .resetn           (resetn                                )  //i
  );
  StreamFifo toplevel_inst_m_axi_wq_stream_fifo (
    .io_push_valid        (inst_m_axi_wq_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_m_axi_wq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_m_axi_wq_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_wq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_mamba_w_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_wq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_m_axi_wq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_m_axi_wq_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_m_axi_wq_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_1 toplevel_inst_m_axi_ws1_stream_fifo (
    .io_push_valid        (inst_m_axi_ws1_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_inst_m_axi_ws1_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_m_axi_ws1_stream_TDATA[23:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (inst_mamba_s1_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (toplevel_inst_m_axi_ws1_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_inst_m_axi_ws1_stream_fifo_io_occupancy[9:0]        ), //o
    .io_availability      (toplevel_inst_m_axi_ws1_stream_fifo_io_availability[9:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_1 toplevel_inst_m_axi_ws2_stream_fifo (
    .io_push_valid        (inst_m_axi_ws2_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_inst_m_axi_ws2_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_m_axi_ws2_stream_TDATA[23:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (inst_mamba_s2_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (toplevel_inst_m_axi_ws2_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_inst_m_axi_ws2_stream_fifo_io_occupancy[9:0]        ), //o
    .io_availability      (toplevel_inst_m_axi_ws2_stream_fifo_io_availability[9:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_inst_m_axi_cq_stream_fifo (
    .io_push_valid        (inst_m_axi_cq_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_m_axi_cq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_m_axi_cq_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_cq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_mamba_cq_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_cq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_m_axi_cq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_m_axi_cq_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_m_axi_cq_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_inst_m_axi_cs_stream_fifo (
    .io_push_valid        (inst_m_axi_cs_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_m_axi_cs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_m_axi_cs_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_cs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_mamba_cs_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_cs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_m_axi_cs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_m_axi_cs_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_m_axi_cs_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_inst_mamba_cq2_stream_fifo (
    .io_push_valid        (inst_mamba_cq2_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_mamba_cq2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_mamba_cq2_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_mamba_cq2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_m_axi_cq2_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_mamba_cq2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_mamba_cq2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_mamba_cq2_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_mamba_cq2_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_inst_mamba_cs2_stream_fifo (
    .io_push_valid        (inst_mamba_cs2_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_mamba_cs2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_mamba_cs2_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_mamba_cs2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_m_axi_cs2_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_mamba_cs2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_mamba_cs2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_mamba_cs2_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_mamba_cs2_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_inst_m_axi_hq_stream_fifo (
    .io_push_valid        (inst_m_axi_hq_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_m_axi_hq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_m_axi_hq_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_hq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_mamba_hq_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_hq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_m_axi_hq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_m_axi_hq_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_m_axi_hq_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_inst_m_axi_hs_stream_fifo (
    .io_push_valid        (inst_m_axi_hs_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_m_axi_hs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_m_axi_hs_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_hs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_mamba_hs_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_hs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_m_axi_hs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_m_axi_hs_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_m_axi_hs_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_inst_mamba_hq2_stream_fifo (
    .io_push_valid        (inst_mamba_hq2_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_mamba_hq2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_mamba_hq2_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_mamba_hq2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_m_axi_hq2_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_mamba_hq2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_mamba_hq2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_mamba_hq2_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_mamba_hq2_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_inst_mamba_hs2_stream_fifo (
    .io_push_valid        (inst_mamba_hs2_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_mamba_hs2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_mamba_hs2_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_mamba_hs2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_m_axi_hs2_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_mamba_hs2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_mamba_hs2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_mamba_hs2_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_mamba_hs2_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo toplevel_inst_mamba_y_stream_fifo (
    .io_push_valid        (inst_mamba_y_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_mamba_y_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_mamba_y_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_mamba_y_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_m_axi_y_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_mamba_y_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_mamba_y_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_mamba_y_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_mamba_y_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  assign axilite_awready = inst_controller_axilite_awready;
  assign axilite_wready = inst_controller_axilite_wready;
  assign axilite_bvalid = inst_controller_axilite_bvalid;
  assign axilite_bresp = inst_controller_axilite_bresp;
  assign axilite_arready = inst_controller_axilite_arready;
  assign axilite_rvalid = inst_controller_axilite_rvalid;
  assign axilite_rdata = inst_controller_axilite_rdata;
  assign axilite_rresp = inst_controller_axilite_rresp;
  assign m_axi_awvalid = inst_m_axi_m_axi_awvalid;
  assign m_axi_awaddr = inst_m_axi_m_axi_awaddr;
  assign m_axi_awid = inst_m_axi_m_axi_awid;
  assign m_axi_awregion = inst_m_axi_m_axi_awregion;
  assign m_axi_awlen = inst_m_axi_m_axi_awlen;
  assign m_axi_awsize = inst_m_axi_m_axi_awsize;
  assign m_axi_awburst = inst_m_axi_m_axi_awburst;
  assign m_axi_awlock = inst_m_axi_m_axi_awlock;
  assign m_axi_awcache = inst_m_axi_m_axi_awcache;
  assign m_axi_awqos = inst_m_axi_m_axi_awqos;
  assign m_axi_awuser = inst_m_axi_m_axi_awuser;
  assign m_axi_awprot = inst_m_axi_m_axi_awprot;
  assign m_axi_wvalid = inst_m_axi_m_axi_wvalid;
  assign m_axi_wdata = inst_m_axi_m_axi_wdata;
  assign m_axi_wstrb = inst_m_axi_m_axi_wstrb;
  assign m_axi_wuser = inst_m_axi_m_axi_wuser;
  assign m_axi_wlast = inst_m_axi_m_axi_wlast;
  assign m_axi_bready = inst_m_axi_m_axi_bready;
  assign m_axi_arvalid = inst_m_axi_m_axi_arvalid;
  assign m_axi_araddr = inst_m_axi_m_axi_araddr;
  assign m_axi_arid = inst_m_axi_m_axi_arid;
  assign m_axi_arregion = inst_m_axi_m_axi_arregion;
  assign m_axi_arlen = inst_m_axi_m_axi_arlen;
  assign m_axi_arsize = inst_m_axi_m_axi_arsize;
  assign m_axi_arburst = inst_m_axi_m_axi_arburst;
  assign m_axi_arlock = inst_m_axi_m_axi_arlock;
  assign m_axi_arcache = inst_m_axi_m_axi_arcache;
  assign m_axi_arqos = inst_m_axi_m_axi_arqos;
  assign m_axi_aruser = inst_m_axi_m_axi_aruser;
  assign m_axi_arprot = inst_m_axi_m_axi_arprot;
  assign m_axi_rready = inst_m_axi_m_axi_rready;
  assign idle = inst_m_axi_idle;
  assign toplevel_inst_m_axi_wq_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_ws1_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_ws2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_cq_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_cs_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_mamba_cq2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_mamba_cs2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_hq_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_hs_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_mamba_hq2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_mamba_hs2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_mamba_y_stream_fifo_io_flush = 1'b0;

endmodule

//StreamFifo_11 replaced by StreamFifo

//StreamFifo_10 replaced by StreamFifo

//StreamFifo_9 replaced by StreamFifo

//StreamFifo_8 replaced by StreamFifo

//StreamFifo_7 replaced by StreamFifo

//StreamFifo_6 replaced by StreamFifo

//StreamFifo_5 replaced by StreamFifo

//StreamFifo_4 replaced by StreamFifo

//StreamFifo_3 replaced by StreamFifo

//StreamFifo_2 replaced by StreamFifo_1

module StreamFifo_1 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [23:0]   io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [23:0]   io_pop_payload_data,
  input  wire          io_flush,
  output wire [9:0]    io_occupancy,
  output wire [9:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [23:0]   _zz_logic_ram_port1;
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
  wire       [23:0]   logic_push_onRam_write_payload_data_data;
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
  wire       [23:0]   logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [23:0]   logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [9:0]    logic_pop_sync_popReg;
  reg [23:0] logic_ram [0:511];

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

module StreamFifo (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [255:0]  io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [255:0]  io_pop_payload_data,
  input  wire          io_flush,
  output wire [9:0]    io_occupancy,
  output wire [9:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [255:0]  _zz_logic_ram_port1;
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
  wire       [255:0]  logic_push_onRam_write_payload_data_data;
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
  wire       [255:0]  logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [255:0]  logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [9:0]    logic_pop_sync_popReg;
  reg [255:0] logic_ram [0:511];

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

module Controller (
  input  wire          axilite_awvalid,
  output wire          axilite_awready,
  input  wire [15:0]   axilite_awaddr,
  input  wire [2:0]    axilite_awprot,
  input  wire          axilite_wvalid,
  output wire          axilite_wready,
  input  wire [63:0]   axilite_wdata,
  input  wire [7:0]    axilite_wstrb,
  output wire          axilite_bvalid,
  input  wire          axilite_bready,
  output wire [1:0]    axilite_bresp,
  input  wire          axilite_arvalid,
  output reg           axilite_arready,
  input  wire [15:0]   axilite_araddr,
  input  wire [2:0]    axilite_arprot,
  output wire          axilite_rvalid,
  input  wire          axilite_rready,
  output wire [63:0]   axilite_rdata,
  output wire [1:0]    axilite_rresp,
  output wire [31:0]   signals_L_BEGIN,
  output wire [31:0]   signals_L_CLOSE,
  output wire [63:0]   signals_MEMORY_X,
  output wire [63:0]   signals_MEMORY_W,
  output wire [63:0]   signals_MEMORY_Y,
  output wire [63:0]   signals_MEMORY_C,
  output wire [63:0]   signals_MEMORY_H,
  output wire [11:0]   signals_POS,
  output reg           signals_T,
  input  wire          idle,
  input  wire          clk,
  input  wire          resetn
);

  wire                busCtrl_readErrorFlag;
  wire                busCtrl_writeErrorFlag;
  wire                busCtrl_readHaltRequest;
  wire                busCtrl_writeHaltRequest;
  wire                busCtrl_writeJoinEvent_valid;
  wire                busCtrl_writeJoinEvent_ready;
  wire                busCtrl_writeOccur;
  reg        [1:0]    busCtrl_writeRsp_resp;
  wire                busCtrl_writeJoinEvent_translated_valid;
  wire                busCtrl_writeJoinEvent_translated_ready;
  wire       [1:0]    busCtrl_writeJoinEvent_translated_payload_resp;
  wire                _zz_busCtrl_writeJoinEvent_translated_ready;
  reg                 _zz_busCtrl_writeJoinEvent_translated_ready_1;
  wire                _zz_axilite_bvalid;
  reg                 _zz_axilite_bvalid_1;
  reg        [1:0]    _zz_axilite_bresp;
  wire                when_Stream_l369;
  wire                busCtrl_readDataStage_valid;
  wire                busCtrl_readDataStage_ready;
  wire       [15:0]   busCtrl_readDataStage_payload_addr;
  wire       [2:0]    busCtrl_readDataStage_payload_prot;
  reg                 axilite_ar_rValid;
  reg        [15:0]   axilite_ar_rData_addr;
  reg        [2:0]    axilite_ar_rData_prot;
  wire                when_Stream_l369_1;
  reg        [63:0]   busCtrl_readRsp_data;
  reg        [1:0]    busCtrl_readRsp_resp;
  wire                _zz_axilite_rvalid;
  wire       [15:0]   busCtrl_readAddressMasked;
  wire       [15:0]   busCtrl_writeAddressMasked;
  wire                busCtrl_readOccur;
  reg        [31:0]   signals_L_BEGIN_driver;
  reg        [31:0]   signals_L_CLOSE_driver;
  reg        [63:0]   signals_MEMORY_X_driver;
  reg        [63:0]   signals_MEMORY_W_driver;
  reg        [63:0]   signals_MEMORY_Y_driver;
  reg        [63:0]   signals_MEMORY_C_driver;
  reg        [63:0]   signals_MEMORY_H_driver;
  reg        [11:0]   signals_POS_driver;

  assign busCtrl_readErrorFlag = 1'b0;
  assign busCtrl_writeErrorFlag = 1'b0;
  assign busCtrl_readHaltRequest = 1'b0;
  assign busCtrl_writeHaltRequest = 1'b0;
  assign busCtrl_writeOccur = (busCtrl_writeJoinEvent_valid && busCtrl_writeJoinEvent_ready);
  assign busCtrl_writeJoinEvent_valid = (axilite_awvalid && axilite_wvalid);
  assign axilite_awready = busCtrl_writeOccur;
  assign axilite_wready = busCtrl_writeOccur;
  assign busCtrl_writeJoinEvent_translated_valid = busCtrl_writeJoinEvent_valid;
  assign busCtrl_writeJoinEvent_ready = busCtrl_writeJoinEvent_translated_ready;
  assign busCtrl_writeJoinEvent_translated_payload_resp = busCtrl_writeRsp_resp;
  assign _zz_busCtrl_writeJoinEvent_translated_ready = (! busCtrl_writeHaltRequest);
  assign busCtrl_writeJoinEvent_translated_ready = (_zz_busCtrl_writeJoinEvent_translated_ready_1 && _zz_busCtrl_writeJoinEvent_translated_ready);
  always @(*) begin
    _zz_busCtrl_writeJoinEvent_translated_ready_1 = axilite_bready;
    if(when_Stream_l369) begin
      _zz_busCtrl_writeJoinEvent_translated_ready_1 = 1'b1;
    end
  end

  assign when_Stream_l369 = (! _zz_axilite_bvalid);
  assign _zz_axilite_bvalid = _zz_axilite_bvalid_1;
  assign axilite_bvalid = _zz_axilite_bvalid;
  assign axilite_bresp = _zz_axilite_bresp;
  always @(*) begin
    axilite_arready = busCtrl_readDataStage_ready;
    if(when_Stream_l369_1) begin
      axilite_arready = 1'b1;
    end
  end

  assign when_Stream_l369_1 = (! busCtrl_readDataStage_valid);
  assign busCtrl_readDataStage_valid = axilite_ar_rValid;
  assign busCtrl_readDataStage_payload_addr = axilite_ar_rData_addr;
  assign busCtrl_readDataStage_payload_prot = axilite_ar_rData_prot;
  assign _zz_axilite_rvalid = (! busCtrl_readHaltRequest);
  assign busCtrl_readDataStage_ready = (axilite_rready && _zz_axilite_rvalid);
  assign axilite_rvalid = (busCtrl_readDataStage_valid && _zz_axilite_rvalid);
  assign axilite_rdata = busCtrl_readRsp_data;
  assign axilite_rresp = busCtrl_readRsp_resp;
  always @(*) begin
    if(busCtrl_writeErrorFlag) begin
      busCtrl_writeRsp_resp = 2'b10;
    end else begin
      busCtrl_writeRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    if(busCtrl_readErrorFlag) begin
      busCtrl_readRsp_resp = 2'b10;
    end else begin
      busCtrl_readRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    busCtrl_readRsp_data = 64'h0000000000000000;
    case(busCtrl_readAddressMasked)
      16'h0000 : begin
        busCtrl_readRsp_data[31 : 0] = signals_L_BEGIN_driver;
      end
      16'h0010 : begin
        busCtrl_readRsp_data[31 : 0] = signals_L_CLOSE_driver;
      end
      16'h0020 : begin
        busCtrl_readRsp_data[63 : 0] = signals_MEMORY_X_driver;
      end
      16'h0030 : begin
        busCtrl_readRsp_data[63 : 0] = signals_MEMORY_W_driver;
      end
      16'h0040 : begin
        busCtrl_readRsp_data[63 : 0] = signals_MEMORY_Y_driver;
      end
      16'h0080 : begin
        busCtrl_readRsp_data[63 : 0] = signals_MEMORY_C_driver;
      end
      16'h0090 : begin
        busCtrl_readRsp_data[63 : 0] = signals_MEMORY_H_driver;
      end
      16'h0050 : begin
        busCtrl_readRsp_data[11 : 0] = signals_POS_driver;
      end
      16'h0070 : begin
        busCtrl_readRsp_data[0 : 0] = idle;
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_readAddressMasked = (busCtrl_readDataStage_payload_addr & (~ 16'h0007));
  assign busCtrl_writeAddressMasked = (axilite_awaddr & (~ 16'h0007));
  assign busCtrl_readOccur = (axilite_rvalid && axilite_rready);
  always @(*) begin
    signals_T = 1'b0;
    case(busCtrl_writeAddressMasked)
      16'h0060 : begin
        if(busCtrl_writeOccur) begin
          signals_T = axilite_wdata[0];
        end
      end
      default : begin
      end
    endcase
  end

  assign signals_L_BEGIN = signals_L_BEGIN_driver;
  assign signals_L_CLOSE = signals_L_CLOSE_driver;
  assign signals_MEMORY_X = signals_MEMORY_X_driver;
  assign signals_MEMORY_W = signals_MEMORY_W_driver;
  assign signals_MEMORY_Y = signals_MEMORY_Y_driver;
  assign signals_MEMORY_C = signals_MEMORY_C_driver;
  assign signals_MEMORY_H = signals_MEMORY_H_driver;
  assign signals_POS = signals_POS_driver;
  always @(posedge clk) begin
    if(!resetn) begin
      _zz_axilite_bvalid_1 <= 1'b0;
      axilite_ar_rValid <= 1'b0;
    end else begin
      if(_zz_busCtrl_writeJoinEvent_translated_ready_1) begin
        _zz_axilite_bvalid_1 <= (busCtrl_writeJoinEvent_translated_valid && _zz_busCtrl_writeJoinEvent_translated_ready);
      end
      if(axilite_arready) begin
        axilite_ar_rValid <= axilite_arvalid;
      end
    end
  end

  always @(posedge clk) begin
    if(_zz_busCtrl_writeJoinEvent_translated_ready_1) begin
      _zz_axilite_bresp <= busCtrl_writeJoinEvent_translated_payload_resp;
    end
    if(axilite_arready) begin
      axilite_ar_rData_addr <= axilite_araddr;
      axilite_ar_rData_prot <= axilite_arprot;
    end
    case(busCtrl_writeAddressMasked)
      16'h0000 : begin
        if(busCtrl_writeOccur) begin
          signals_L_BEGIN_driver <= axilite_wdata[31 : 0];
        end
      end
      16'h0010 : begin
        if(busCtrl_writeOccur) begin
          signals_L_CLOSE_driver <= axilite_wdata[31 : 0];
        end
      end
      16'h0020 : begin
        if(busCtrl_writeOccur) begin
          signals_MEMORY_X_driver <= axilite_wdata[63 : 0];
        end
      end
      16'h0030 : begin
        if(busCtrl_writeOccur) begin
          signals_MEMORY_W_driver <= axilite_wdata[63 : 0];
        end
      end
      16'h0040 : begin
        if(busCtrl_writeOccur) begin
          signals_MEMORY_Y_driver <= axilite_wdata[63 : 0];
        end
      end
      16'h0080 : begin
        if(busCtrl_writeOccur) begin
          signals_MEMORY_C_driver <= axilite_wdata[63 : 0];
        end
      end
      16'h0090 : begin
        if(busCtrl_writeOccur) begin
          signals_MEMORY_H_driver <= axilite_wdata[63 : 0];
        end
      end
      16'h0050 : begin
        if(busCtrl_writeOccur) begin
          signals_POS_driver <= axilite_wdata[11 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module M_AXI (
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
  output wire          m_axi_awvalid,
  input  wire          m_axi_awready,
  output wire [47:0]   m_axi_awaddr,
  output wire [0:0]    m_axi_awid,
  output wire [3:0]    m_axi_awregion,
  output wire [7:0]    m_axi_awlen,
  output wire [2:0]    m_axi_awsize,
  output wire [1:0]    m_axi_awburst,
  output wire [0:0]    m_axi_awlock,
  output wire [3:0]    m_axi_awcache,
  output wire [3:0]    m_axi_awqos,
  output wire [0:0]    m_axi_awuser,
  output wire [2:0]    m_axi_awprot,
  output wire          m_axi_wvalid,
  input  wire          m_axi_wready,
  output wire [255:0]  m_axi_wdata,
  output wire [31:0]   m_axi_wstrb,
  output wire [0:0]    m_axi_wuser,
  output wire          m_axi_wlast,
  input  wire          m_axi_bvalid,
  output wire          m_axi_bready,
  input  wire [0:0]    m_axi_bid,
  input  wire [1:0]    m_axi_bresp,
  input  wire [0:0]    m_axi_buser,
  output wire          m_axi_arvalid,
  input  wire          m_axi_arready,
  output wire [47:0]   m_axi_araddr,
  output wire [0:0]    m_axi_arid,
  output wire [3:0]    m_axi_arregion,
  output wire [7:0]    m_axi_arlen,
  output wire [2:0]    m_axi_arsize,
  output wire [1:0]    m_axi_arburst,
  output wire [0:0]    m_axi_arlock,
  output wire [3:0]    m_axi_arcache,
  output wire [3:0]    m_axi_arqos,
  output wire [0:0]    m_axi_aruser,
  output wire [2:0]    m_axi_arprot,
  input  wire          m_axi_rvalid,
  output wire          m_axi_rready,
  input  wire [255:0]  m_axi_rdata,
  input  wire [0:0]    m_axi_rid,
  input  wire [1:0]    m_axi_rresp,
  input  wire          m_axi_rlast,
  input  wire [0:0]    m_axi_ruser,
  output wire          x_stream_TVALID,
  input  wire          x_stream_TREADY,
  output wire [255:0]  x_stream_TDATA,
  output wire          wq_stream_TVALID,
  input  wire          wq_stream_TREADY,
  output wire [255:0]  wq_stream_TDATA,
  output wire          ws1_stream_TVALID,
  input  wire          ws1_stream_TREADY,
  output wire [23:0]   ws1_stream_TDATA,
  output wire          ws2_stream_TVALID,
  input  wire          ws2_stream_TREADY,
  output wire [23:0]   ws2_stream_TDATA,
  input  wire          y_stream_TVALID,
  output wire          y_stream_TREADY,
  input  wire [255:0]  y_stream_TDATA,
  output wire          cq_stream_TVALID,
  input  wire          cq_stream_TREADY,
  output wire [255:0]  cq_stream_TDATA,
  output wire          cs_stream_TVALID,
  input  wire          cs_stream_TREADY,
  output wire [255:0]  cs_stream_TDATA,
  input  wire          cq2_stream_TVALID,
  output wire          cq2_stream_TREADY,
  input  wire [255:0]  cq2_stream_TDATA,
  input  wire          cs2_stream_TVALID,
  output wire          cs2_stream_TREADY,
  input  wire [255:0]  cs2_stream_TDATA,
  output wire          hq_stream_TVALID,
  input  wire          hq_stream_TREADY,
  output wire [255:0]  hq_stream_TDATA,
  output wire          hs_stream_TVALID,
  input  wire          hs_stream_TREADY,
  output wire [255:0]  hs_stream_TDATA,
  input  wire          hq2_stream_TVALID,
  output wire          hq2_stream_TREADY,
  input  wire [255:0]  hq2_stream_TDATA,
  input  wire          hs2_stream_TVALID,
  output wire          hs2_stream_TREADY,
  input  wire [255:0]  hs2_stream_TDATA,
  output wire          idle
);

  wire                y_stream_fifo_io_flush;
  wire                cq2_stream_fifo_io_flush;
  wire                cs2_stream_fifo_io_flush;
  wire                hq2_stream_fifo_io_flush;
  wire                hs2_stream_fifo_io_flush;
  wire                inst_m_axi_inst_state_x_stream_fifo_io_flush;
  wire                inst_m_axi_inst_state_mem_stream_fifo_io_flush;
  wire                inst_m_axi_inst_state_conv_stream_fifo_io_flush;
  wire                inst_m_axi_inst_state_ht_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_conv2_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_ht2_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_wq_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_ws1_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_ws2_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_cq_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_cs_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_hq_stream_fifo_io_flush;
  wire                inst_m_axi_inst_flow_hs_stream_fifo_io_flush;
  wire       [31:0]   inst_state_signals_O_L_BEGIN;
  wire       [31:0]   inst_state_signals_O_L_CLOSE;
  wire       [63:0]   inst_state_signals_O_MEMORY_X;
  wire       [63:0]   inst_state_signals_O_MEMORY_W;
  wire       [63:0]   inst_state_signals_O_MEMORY_Y;
  wire       [63:0]   inst_state_signals_O_MEMORY_C;
  wire       [63:0]   inst_state_signals_O_MEMORY_H;
  wire       [11:0]   inst_state_signals_O_POS;
  wire                inst_state_signals_O_T;
  wire                inst_state_m_axi_arvalid;
  wire       [47:0]   inst_state_m_axi_araddr;
  wire       [0:0]    inst_state_m_axi_arid;
  wire       [3:0]    inst_state_m_axi_arregion;
  wire       [7:0]    inst_state_m_axi_arlen;
  wire       [2:0]    inst_state_m_axi_arsize;
  wire       [1:0]    inst_state_m_axi_arburst;
  wire       [0:0]    inst_state_m_axi_arlock;
  wire       [3:0]    inst_state_m_axi_arcache;
  wire       [3:0]    inst_state_m_axi_arqos;
  wire       [0:0]    inst_state_m_axi_aruser;
  wire       [2:0]    inst_state_m_axi_arprot;
  wire                inst_state_m_axi_awvalid;
  wire       [47:0]   inst_state_m_axi_awaddr;
  wire       [0:0]    inst_state_m_axi_awid;
  wire       [3:0]    inst_state_m_axi_awregion;
  wire       [7:0]    inst_state_m_axi_awlen;
  wire       [2:0]    inst_state_m_axi_awsize;
  wire       [1:0]    inst_state_m_axi_awburst;
  wire       [0:0]    inst_state_m_axi_awlock;
  wire       [3:0]    inst_state_m_axi_awcache;
  wire       [3:0]    inst_state_m_axi_awqos;
  wire       [0:0]    inst_state_m_axi_awuser;
  wire       [2:0]    inst_state_m_axi_awprot;
  wire                inst_state_m_axi_wvalid;
  wire       [255:0]  inst_state_m_axi_wdata;
  wire       [31:0]   inst_state_m_axi_wstrb;
  wire       [0:0]    inst_state_m_axi_wuser;
  wire                inst_state_m_axi_wlast;
  wire                inst_state_m_axi_rready;
  wire                inst_state_m_axi_bready;
  wire                inst_state_x_stream_TVALID;
  wire       [255:0]  inst_state_x_stream_TDATA;
  wire                inst_state_mem_stream_TVALID;
  wire       [255:0]  inst_state_mem_stream_TDATA;
  wire                inst_state_conv_stream_TVALID;
  wire       [255:0]  inst_state_conv_stream_TDATA;
  wire                inst_state_conv2_stream_TREADY;
  wire                inst_state_ht_stream_TVALID;
  wire       [255:0]  inst_state_ht_stream_TDATA;
  wire                inst_state_ht2_stream_TREADY;
  wire                inst_state_y_stream_TREADY;
  wire                inst_state_idle;
  wire       [31:0]   inst_flow_signals_O_L_BEGIN;
  wire       [31:0]   inst_flow_signals_O_L_CLOSE;
  wire       [63:0]   inst_flow_signals_O_MEMORY_X;
  wire       [63:0]   inst_flow_signals_O_MEMORY_W;
  wire       [63:0]   inst_flow_signals_O_MEMORY_Y;
  wire       [63:0]   inst_flow_signals_O_MEMORY_C;
  wire       [63:0]   inst_flow_signals_O_MEMORY_H;
  wire       [11:0]   inst_flow_signals_O_POS;
  wire                inst_flow_signals_O_T;
  wire                inst_flow_mem_stream_TREADY;
  wire                inst_flow_conv_stream_TREADY;
  wire                inst_flow_conv2_stream_TVALID;
  wire       [255:0]  inst_flow_conv2_stream_TDATA;
  wire                inst_flow_ht_stream_TREADY;
  wire                inst_flow_ht2_stream_TVALID;
  wire       [255:0]  inst_flow_ht2_stream_TDATA;
  wire                inst_flow_wq_stream_TVALID;
  wire       [255:0]  inst_flow_wq_stream_TDATA;
  wire                inst_flow_ws1_stream_TVALID;
  wire       [23:0]   inst_flow_ws1_stream_TDATA;
  wire                inst_flow_ws2_stream_TVALID;
  wire       [23:0]   inst_flow_ws2_stream_TDATA;
  wire                inst_flow_cq_stream_TVALID;
  wire       [255:0]  inst_flow_cq_stream_TDATA;
  wire                inst_flow_cs_stream_TVALID;
  wire       [255:0]  inst_flow_cs_stream_TDATA;
  wire                inst_flow_cq2_stream_TREADY;
  wire                inst_flow_cs2_stream_TREADY;
  wire                inst_flow_hq_stream_TVALID;
  wire       [255:0]  inst_flow_hq_stream_TDATA;
  wire                inst_flow_hs_stream_TVALID;
  wire       [255:0]  inst_flow_hs_stream_TDATA;
  wire                inst_flow_hq2_stream_TREADY;
  wire                inst_flow_hs2_stream_TREADY;
  wire                y_stream_fifo_io_push_ready;
  wire                y_stream_fifo_io_pop_valid;
  wire       [255:0]  y_stream_fifo_io_pop_payload_data;
  wire       [3:0]    y_stream_fifo_io_occupancy;
  wire       [3:0]    y_stream_fifo_io_availability;
  wire                cq2_stream_fifo_io_push_ready;
  wire                cq2_stream_fifo_io_pop_valid;
  wire       [255:0]  cq2_stream_fifo_io_pop_payload_data;
  wire       [3:0]    cq2_stream_fifo_io_occupancy;
  wire       [3:0]    cq2_stream_fifo_io_availability;
  wire                cs2_stream_fifo_io_push_ready;
  wire                cs2_stream_fifo_io_pop_valid;
  wire       [255:0]  cs2_stream_fifo_io_pop_payload_data;
  wire       [3:0]    cs2_stream_fifo_io_occupancy;
  wire       [3:0]    cs2_stream_fifo_io_availability;
  wire                hq2_stream_fifo_io_push_ready;
  wire                hq2_stream_fifo_io_pop_valid;
  wire       [255:0]  hq2_stream_fifo_io_pop_payload_data;
  wire       [3:0]    hq2_stream_fifo_io_occupancy;
  wire       [3:0]    hq2_stream_fifo_io_availability;
  wire                hs2_stream_fifo_io_push_ready;
  wire                hs2_stream_fifo_io_pop_valid;
  wire       [255:0]  hs2_stream_fifo_io_pop_payload_data;
  wire       [3:0]    hs2_stream_fifo_io_occupancy;
  wire       [3:0]    hs2_stream_fifo_io_availability;
  wire                inst_m_axi_inst_state_x_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_state_x_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_state_x_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_state_x_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_state_x_stream_fifo_io_availability;
  wire                inst_m_axi_inst_state_mem_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_state_mem_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_state_mem_stream_fifo_io_pop_payload_data;
  wire       [10:0]   inst_m_axi_inst_state_mem_stream_fifo_io_occupancy;
  wire       [10:0]   inst_m_axi_inst_state_mem_stream_fifo_io_availability;
  wire                inst_m_axi_inst_state_conv_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_state_conv_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_state_conv_stream_fifo_io_pop_payload_data;
  wire       [10:0]   inst_m_axi_inst_state_conv_stream_fifo_io_occupancy;
  wire       [10:0]   inst_m_axi_inst_state_conv_stream_fifo_io_availability;
  wire                inst_m_axi_inst_state_ht_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_state_ht_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_state_ht_stream_fifo_io_pop_payload_data;
  wire       [10:0]   inst_m_axi_inst_state_ht_stream_fifo_io_occupancy;
  wire       [10:0]   inst_m_axi_inst_state_ht_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_conv2_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_conv2_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_flow_conv2_stream_fifo_io_pop_payload_data;
  wire       [10:0]   inst_m_axi_inst_flow_conv2_stream_fifo_io_occupancy;
  wire       [10:0]   inst_m_axi_inst_flow_conv2_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_ht2_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_ht2_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_flow_ht2_stream_fifo_io_pop_payload_data;
  wire       [10:0]   inst_m_axi_inst_flow_ht2_stream_fifo_io_occupancy;
  wire       [10:0]   inst_m_axi_inst_flow_ht2_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_wq_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_wq_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_flow_wq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_flow_wq_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_flow_wq_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_ws1_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_ws1_stream_fifo_io_pop_valid;
  wire       [23:0]   inst_m_axi_inst_flow_ws1_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_flow_ws1_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_flow_ws1_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_ws2_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_ws2_stream_fifo_io_pop_valid;
  wire       [23:0]   inst_m_axi_inst_flow_ws2_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_flow_ws2_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_flow_ws2_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_cq_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_cq_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_flow_cq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_flow_cq_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_flow_cq_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_cs_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_cs_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_flow_cs_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_flow_cs_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_flow_cs_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_hq_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_hq_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_flow_hq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_flow_hq_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_flow_hq_stream_fifo_io_availability;
  wire                inst_m_axi_inst_flow_hs_stream_fifo_io_push_ready;
  wire                inst_m_axi_inst_flow_hs_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_m_axi_inst_flow_hs_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_m_axi_inst_flow_hs_stream_fifo_io_occupancy;
  wire       [3:0]    inst_m_axi_inst_flow_hs_stream_fifo_io_availability;

  M_AXI_STATIC_wrapper inst_state (
    .resetn              (resetn                                                           ), //i
    .clk                 (clk                                                              ), //i
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]                                          ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]                                          ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]                                         ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]                                         ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]                                         ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]                                         ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]                                         ), //i
    .signals_I_POS       (signals_I_POS[11:0]                                              ), //i
    .signals_I_T         (signals_I_T                                                      ), //i
    .signals_O_L_BEGIN   (inst_state_signals_O_L_BEGIN[31:0]                               ), //o
    .signals_O_L_CLOSE   (inst_state_signals_O_L_CLOSE[31:0]                               ), //o
    .signals_O_MEMORY_X  (inst_state_signals_O_MEMORY_X[63:0]                              ), //o
    .signals_O_MEMORY_W  (inst_state_signals_O_MEMORY_W[63:0]                              ), //o
    .signals_O_MEMORY_Y  (inst_state_signals_O_MEMORY_Y[63:0]                              ), //o
    .signals_O_MEMORY_C  (inst_state_signals_O_MEMORY_C[63:0]                              ), //o
    .signals_O_MEMORY_H  (inst_state_signals_O_MEMORY_H[63:0]                              ), //o
    .signals_O_POS       (inst_state_signals_O_POS[11:0]                                   ), //o
    .signals_O_T         (inst_state_signals_O_T                                           ), //o
    .m_axi_awvalid       (inst_state_m_axi_awvalid                                         ), //o
    .m_axi_awready       (m_axi_awready                                                    ), //i
    .m_axi_awaddr        (inst_state_m_axi_awaddr[47:0]                                    ), //o
    .m_axi_awid          (inst_state_m_axi_awid                                            ), //o
    .m_axi_awregion      (inst_state_m_axi_awregion[3:0]                                   ), //o
    .m_axi_awlen         (inst_state_m_axi_awlen[7:0]                                      ), //o
    .m_axi_awsize        (inst_state_m_axi_awsize[2:0]                                     ), //o
    .m_axi_awburst       (inst_state_m_axi_awburst[1:0]                                    ), //o
    .m_axi_awlock        (inst_state_m_axi_awlock                                          ), //o
    .m_axi_awcache       (inst_state_m_axi_awcache[3:0]                                    ), //o
    .m_axi_awqos         (inst_state_m_axi_awqos[3:0]                                      ), //o
    .m_axi_awuser        (inst_state_m_axi_awuser                                          ), //o
    .m_axi_awprot        (inst_state_m_axi_awprot[2:0]                                     ), //o
    .m_axi_wvalid        (inst_state_m_axi_wvalid                                          ), //o
    .m_axi_wready        (m_axi_wready                                                     ), //i
    .m_axi_wdata         (inst_state_m_axi_wdata[255:0]                                    ), //o
    .m_axi_wstrb         (inst_state_m_axi_wstrb[31:0]                                     ), //o
    .m_axi_wuser         (inst_state_m_axi_wuser                                           ), //o
    .m_axi_wlast         (inst_state_m_axi_wlast                                           ), //o
    .m_axi_bvalid        (m_axi_bvalid                                                     ), //i
    .m_axi_bready        (inst_state_m_axi_bready                                          ), //o
    .m_axi_bid           (m_axi_bid                                                        ), //i
    .m_axi_bresp         (m_axi_bresp[1:0]                                                 ), //i
    .m_axi_buser         (m_axi_buser                                                      ), //i
    .m_axi_arvalid       (inst_state_m_axi_arvalid                                         ), //o
    .m_axi_arready       (m_axi_arready                                                    ), //i
    .m_axi_araddr        (inst_state_m_axi_araddr[47:0]                                    ), //o
    .m_axi_arid          (inst_state_m_axi_arid                                            ), //o
    .m_axi_arregion      (inst_state_m_axi_arregion[3:0]                                   ), //o
    .m_axi_arlen         (inst_state_m_axi_arlen[7:0]                                      ), //o
    .m_axi_arsize        (inst_state_m_axi_arsize[2:0]                                     ), //o
    .m_axi_arburst       (inst_state_m_axi_arburst[1:0]                                    ), //o
    .m_axi_arlock        (inst_state_m_axi_arlock                                          ), //o
    .m_axi_arcache       (inst_state_m_axi_arcache[3:0]                                    ), //o
    .m_axi_arqos         (inst_state_m_axi_arqos[3:0]                                      ), //o
    .m_axi_aruser        (inst_state_m_axi_aruser                                          ), //o
    .m_axi_arprot        (inst_state_m_axi_arprot[2:0]                                     ), //o
    .m_axi_rvalid        (m_axi_rvalid                                                     ), //i
    .m_axi_rready        (inst_state_m_axi_rready                                          ), //o
    .m_axi_rdata         (m_axi_rdata[255:0]                                               ), //i
    .m_axi_rid           (m_axi_rid                                                        ), //i
    .m_axi_rresp         (m_axi_rresp[1:0]                                                 ), //i
    .m_axi_rlast         (m_axi_rlast                                                      ), //i
    .m_axi_ruser         (m_axi_ruser                                                      ), //i
    .x_stream_TVALID     (inst_state_x_stream_TVALID                                       ), //o
    .x_stream_TREADY     (inst_m_axi_inst_state_x_stream_fifo_io_push_ready                ), //i
    .x_stream_TDATA      (inst_state_x_stream_TDATA[255:0]                                 ), //o
    .mem_stream_TVALID   (inst_state_mem_stream_TVALID                                     ), //o
    .mem_stream_TREADY   (inst_m_axi_inst_state_mem_stream_fifo_io_push_ready              ), //i
    .mem_stream_TDATA    (inst_state_mem_stream_TDATA[255:0]                               ), //o
    .conv_stream_TVALID  (inst_state_conv_stream_TVALID                                    ), //o
    .conv_stream_TREADY  (inst_m_axi_inst_state_conv_stream_fifo_io_push_ready             ), //i
    .conv_stream_TDATA   (inst_state_conv_stream_TDATA[255:0]                              ), //o
    .conv2_stream_TVALID (inst_m_axi_inst_flow_conv2_stream_fifo_io_pop_valid              ), //i
    .conv2_stream_TREADY (inst_state_conv2_stream_TREADY                                   ), //o
    .conv2_stream_TDATA  (inst_m_axi_inst_flow_conv2_stream_fifo_io_pop_payload_data[255:0]), //i
    .ht_stream_TVALID    (inst_state_ht_stream_TVALID                                      ), //o
    .ht_stream_TREADY    (inst_m_axi_inst_state_ht_stream_fifo_io_push_ready               ), //i
    .ht_stream_TDATA     (inst_state_ht_stream_TDATA[255:0]                                ), //o
    .ht2_stream_TVALID   (inst_m_axi_inst_flow_ht2_stream_fifo_io_pop_valid                ), //i
    .ht2_stream_TREADY   (inst_state_ht2_stream_TREADY                                     ), //o
    .ht2_stream_TDATA    (inst_m_axi_inst_flow_ht2_stream_fifo_io_pop_payload_data[255:0]  ), //i
    .y_stream_TVALID     (y_stream_fifo_io_pop_valid                                       ), //i
    .y_stream_TREADY     (inst_state_y_stream_TREADY                                       ), //o
    .y_stream_TDATA      (y_stream_fifo_io_pop_payload_data[255:0]                         ), //i
    .idle                (inst_state_idle                                                  )  //o
  );
  M_AXI_FLOW_wrapper inst_flow (
    .resetn              (resetn                                                           ), //i
    .clk                 (clk                                                              ), //i
    .signals_I_L_BEGIN   (inst_state_signals_O_L_BEGIN[31:0]                               ), //i
    .signals_I_L_CLOSE   (inst_state_signals_O_L_CLOSE[31:0]                               ), //i
    .signals_I_MEMORY_X  (inst_state_signals_O_MEMORY_X[63:0]                              ), //i
    .signals_I_MEMORY_W  (inst_state_signals_O_MEMORY_W[63:0]                              ), //i
    .signals_I_MEMORY_Y  (inst_state_signals_O_MEMORY_Y[63:0]                              ), //i
    .signals_I_MEMORY_C  (inst_state_signals_O_MEMORY_C[63:0]                              ), //i
    .signals_I_MEMORY_H  (inst_state_signals_O_MEMORY_H[63:0]                              ), //i
    .signals_I_POS       (inst_state_signals_O_POS[11:0]                                   ), //i
    .signals_I_T         (inst_state_signals_O_T                                           ), //i
    .signals_O_L_BEGIN   (inst_flow_signals_O_L_BEGIN[31:0]                                ), //o
    .signals_O_L_CLOSE   (inst_flow_signals_O_L_CLOSE[31:0]                                ), //o
    .signals_O_MEMORY_X  (inst_flow_signals_O_MEMORY_X[63:0]                               ), //o
    .signals_O_MEMORY_W  (inst_flow_signals_O_MEMORY_W[63:0]                               ), //o
    .signals_O_MEMORY_Y  (inst_flow_signals_O_MEMORY_Y[63:0]                               ), //o
    .signals_O_MEMORY_C  (inst_flow_signals_O_MEMORY_C[63:0]                               ), //o
    .signals_O_MEMORY_H  (inst_flow_signals_O_MEMORY_H[63:0]                               ), //o
    .signals_O_POS       (inst_flow_signals_O_POS[11:0]                                    ), //o
    .signals_O_T         (inst_flow_signals_O_T                                            ), //o
    .mem_stream_TVALID   (inst_m_axi_inst_state_mem_stream_fifo_io_pop_valid               ), //i
    .mem_stream_TREADY   (inst_flow_mem_stream_TREADY                                      ), //o
    .mem_stream_TDATA    (inst_m_axi_inst_state_mem_stream_fifo_io_pop_payload_data[255:0] ), //i
    .conv_stream_TVALID  (inst_m_axi_inst_state_conv_stream_fifo_io_pop_valid              ), //i
    .conv_stream_TREADY  (inst_flow_conv_stream_TREADY                                     ), //o
    .conv_stream_TDATA   (inst_m_axi_inst_state_conv_stream_fifo_io_pop_payload_data[255:0]), //i
    .conv2_stream_TVALID (inst_flow_conv2_stream_TVALID                                    ), //o
    .conv2_stream_TREADY (inst_m_axi_inst_flow_conv2_stream_fifo_io_push_ready             ), //i
    .conv2_stream_TDATA  (inst_flow_conv2_stream_TDATA[255:0]                              ), //o
    .ht_stream_TVALID    (inst_m_axi_inst_state_ht_stream_fifo_io_pop_valid                ), //i
    .ht_stream_TREADY    (inst_flow_ht_stream_TREADY                                       ), //o
    .ht_stream_TDATA     (inst_m_axi_inst_state_ht_stream_fifo_io_pop_payload_data[255:0]  ), //i
    .ht2_stream_TVALID   (inst_flow_ht2_stream_TVALID                                      ), //o
    .ht2_stream_TREADY   (inst_m_axi_inst_flow_ht2_stream_fifo_io_push_ready               ), //i
    .ht2_stream_TDATA    (inst_flow_ht2_stream_TDATA[255:0]                                ), //o
    .wq_stream_TVALID    (inst_flow_wq_stream_TVALID                                       ), //o
    .wq_stream_TREADY    (inst_m_axi_inst_flow_wq_stream_fifo_io_push_ready                ), //i
    .wq_stream_TDATA     (inst_flow_wq_stream_TDATA[255:0]                                 ), //o
    .ws1_stream_TVALID   (inst_flow_ws1_stream_TVALID                                      ), //o
    .ws1_stream_TREADY   (inst_m_axi_inst_flow_ws1_stream_fifo_io_push_ready               ), //i
    .ws1_stream_TDATA    (inst_flow_ws1_stream_TDATA[23:0]                                 ), //o
    .ws2_stream_TVALID   (inst_flow_ws2_stream_TVALID                                      ), //o
    .ws2_stream_TREADY   (inst_m_axi_inst_flow_ws2_stream_fifo_io_push_ready               ), //i
    .ws2_stream_TDATA    (inst_flow_ws2_stream_TDATA[23:0]                                 ), //o
    .cq_stream_TVALID    (inst_flow_cq_stream_TVALID                                       ), //o
    .cq_stream_TREADY    (inst_m_axi_inst_flow_cq_stream_fifo_io_push_ready                ), //i
    .cq_stream_TDATA     (inst_flow_cq_stream_TDATA[255:0]                                 ), //o
    .cs_stream_TVALID    (inst_flow_cs_stream_TVALID                                       ), //o
    .cs_stream_TREADY    (inst_m_axi_inst_flow_cs_stream_fifo_io_push_ready                ), //i
    .cs_stream_TDATA     (inst_flow_cs_stream_TDATA[255:0]                                 ), //o
    .cq2_stream_TVALID   (cq2_stream_fifo_io_pop_valid                                     ), //i
    .cq2_stream_TREADY   (inst_flow_cq2_stream_TREADY                                      ), //o
    .cq2_stream_TDATA    (cq2_stream_fifo_io_pop_payload_data[255:0]                       ), //i
    .cs2_stream_TVALID   (cs2_stream_fifo_io_pop_valid                                     ), //i
    .cs2_stream_TREADY   (inst_flow_cs2_stream_TREADY                                      ), //o
    .cs2_stream_TDATA    (cs2_stream_fifo_io_pop_payload_data[255:0]                       ), //i
    .hq_stream_TVALID    (inst_flow_hq_stream_TVALID                                       ), //o
    .hq_stream_TREADY    (inst_m_axi_inst_flow_hq_stream_fifo_io_push_ready                ), //i
    .hq_stream_TDATA     (inst_flow_hq_stream_TDATA[255:0]                                 ), //o
    .hs_stream_TVALID    (inst_flow_hs_stream_TVALID                                       ), //o
    .hs_stream_TREADY    (inst_m_axi_inst_flow_hs_stream_fifo_io_push_ready                ), //i
    .hs_stream_TDATA     (inst_flow_hs_stream_TDATA[255:0]                                 ), //o
    .hq2_stream_TVALID   (hq2_stream_fifo_io_pop_valid                                     ), //i
    .hq2_stream_TREADY   (inst_flow_hq2_stream_TREADY                                      ), //o
    .hq2_stream_TDATA    (hq2_stream_fifo_io_pop_payload_data[255:0]                       ), //i
    .hs2_stream_TVALID   (hs2_stream_fifo_io_pop_valid                                     ), //i
    .hs2_stream_TREADY   (inst_flow_hs2_stream_TREADY                                      ), //o
    .hs2_stream_TDATA    (hs2_stream_fifo_io_pop_payload_data[255:0]                       )  //i
  );
  StreamFifo_30 y_stream_fifo (
    .io_push_valid        (y_stream_TVALID                         ), //i
    .io_push_ready        (y_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (y_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (y_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_state_y_stream_TREADY              ), //i
    .io_pop_payload_data  (y_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (y_stream_fifo_io_flush                  ), //i
    .io_occupancy         (y_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (y_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                     ), //i
    .resetn               (resetn                                  )  //i
  );
  StreamFifo_30 cq2_stream_fifo (
    .io_push_valid        (cq2_stream_TVALID                         ), //i
    .io_push_ready        (cq2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (cq2_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (cq2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_cq2_stream_TREADY               ), //i
    .io_pop_payload_data  (cq2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (cq2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (cq2_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (cq2_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                       ), //i
    .resetn               (resetn                                    )  //i
  );
  StreamFifo_30 cs2_stream_fifo (
    .io_push_valid        (cs2_stream_TVALID                         ), //i
    .io_push_ready        (cs2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (cs2_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (cs2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_cs2_stream_TREADY               ), //i
    .io_pop_payload_data  (cs2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (cs2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (cs2_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (cs2_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                       ), //i
    .resetn               (resetn                                    )  //i
  );
  StreamFifo_30 hq2_stream_fifo (
    .io_push_valid        (hq2_stream_TVALID                         ), //i
    .io_push_ready        (hq2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (hq2_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (hq2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_hq2_stream_TREADY               ), //i
    .io_pop_payload_data  (hq2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (hq2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (hq2_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (hq2_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                       ), //i
    .resetn               (resetn                                    )  //i
  );
  StreamFifo_30 hs2_stream_fifo (
    .io_push_valid        (hs2_stream_TVALID                         ), //i
    .io_push_ready        (hs2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (hs2_stream_TDATA[255:0]                   ), //i
    .io_pop_valid         (hs2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_hs2_stream_TREADY               ), //i
    .io_pop_payload_data  (hs2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (hs2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (hs2_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (hs2_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                       ), //i
    .resetn               (resetn                                    )  //i
  );
  StreamFifo_30 inst_m_axi_inst_state_x_stream_fifo (
    .io_push_valid        (inst_state_x_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_state_x_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_x_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_state_x_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (x_stream_TREADY                                               ), //i
    .io_pop_payload_data  (inst_m_axi_inst_state_x_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_state_x_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_state_x_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_m_axi_inst_state_x_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_18 inst_m_axi_inst_state_mem_stream_fifo (
    .io_push_valid        (inst_state_mem_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_state_mem_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_mem_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_state_mem_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_mem_stream_TREADY                                     ), //i
    .io_pop_payload_data  (inst_m_axi_inst_state_mem_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_state_mem_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_state_mem_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (inst_m_axi_inst_state_mem_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_18 inst_m_axi_inst_state_conv_stream_fifo (
    .io_push_valid        (inst_state_conv_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_state_conv_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_conv_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_state_conv_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_conv_stream_TREADY                                     ), //i
    .io_pop_payload_data  (inst_m_axi_inst_state_conv_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_state_conv_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_state_conv_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (inst_m_axi_inst_state_conv_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_18 inst_m_axi_inst_state_ht_stream_fifo (
    .io_push_valid        (inst_state_ht_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_state_ht_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_ht_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_state_ht_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_ht_stream_TREADY                                     ), //i
    .io_pop_payload_data  (inst_m_axi_inst_state_ht_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_state_ht_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_state_ht_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (inst_m_axi_inst_state_ht_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_18 inst_m_axi_inst_flow_conv2_stream_fifo (
    .io_push_valid        (inst_flow_conv2_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_flow_conv2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_conv2_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_conv2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_state_conv2_stream_TREADY                                   ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_conv2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_flow_conv2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_flow_conv2_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (inst_m_axi_inst_flow_conv2_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_18 inst_m_axi_inst_flow_ht2_stream_fifo (
    .io_push_valid        (inst_flow_ht2_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_flow_ht2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_ht2_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_ht2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_state_ht2_stream_TREADY                                   ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_ht2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_flow_ht2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_flow_ht2_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (inst_m_axi_inst_flow_ht2_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_30 inst_m_axi_inst_flow_wq_stream_fifo (
    .io_push_valid        (inst_flow_wq_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_flow_wq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_wq_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_wq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (wq_stream_TREADY                                              ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_wq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_flow_wq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_flow_wq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_m_axi_inst_flow_wq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_32 inst_m_axi_inst_flow_ws1_stream_fifo (
    .io_push_valid        (inst_flow_ws1_stream_TVALID                                   ), //i
    .io_push_ready        (inst_m_axi_inst_flow_ws1_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_flow_ws1_stream_TDATA[23:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_ws1_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ws1_stream_TREADY                                             ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_ws1_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (inst_m_axi_inst_flow_ws1_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_m_axi_inst_flow_ws1_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_m_axi_inst_flow_ws1_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_32 inst_m_axi_inst_flow_ws2_stream_fifo (
    .io_push_valid        (inst_flow_ws2_stream_TVALID                                   ), //i
    .io_push_ready        (inst_m_axi_inst_flow_ws2_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_flow_ws2_stream_TDATA[23:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_ws2_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ws2_stream_TREADY                                             ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_ws2_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (inst_m_axi_inst_flow_ws2_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_m_axi_inst_flow_ws2_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_m_axi_inst_flow_ws2_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_30 inst_m_axi_inst_flow_cq_stream_fifo (
    .io_push_valid        (inst_flow_cq_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_flow_cq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_cq_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_cq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cq_stream_TREADY                                              ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_cq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_flow_cq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_flow_cq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_m_axi_inst_flow_cq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_30 inst_m_axi_inst_flow_cs_stream_fifo (
    .io_push_valid        (inst_flow_cs_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_flow_cs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_cs_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_cs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cs_stream_TREADY                                              ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_cs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_flow_cs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_flow_cs_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_m_axi_inst_flow_cs_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_30 inst_m_axi_inst_flow_hq_stream_fifo (
    .io_push_valid        (inst_flow_hq_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_flow_hq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_hq_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_hq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hq_stream_TREADY                                              ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_hq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_flow_hq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_flow_hq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_m_axi_inst_flow_hq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_30 inst_m_axi_inst_flow_hs_stream_fifo (
    .io_push_valid        (inst_flow_hs_stream_TVALID                                    ), //i
    .io_push_ready        (inst_m_axi_inst_flow_hs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_hs_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_m_axi_inst_flow_hs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hs_stream_TREADY                                              ), //i
    .io_pop_payload_data  (inst_m_axi_inst_flow_hs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_m_axi_inst_flow_hs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_m_axi_inst_flow_hs_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_m_axi_inst_flow_hs_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  assign idle = inst_state_idle;
  assign signals_O_L_BEGIN = inst_flow_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = inst_flow_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = inst_flow_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = inst_flow_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = inst_flow_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = inst_flow_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = inst_flow_signals_O_MEMORY_H;
  assign signals_O_POS = inst_flow_signals_O_POS;
  assign signals_O_T = inst_flow_signals_O_T;
  assign y_stream_TREADY = y_stream_fifo_io_push_ready;
  assign cq2_stream_TREADY = cq2_stream_fifo_io_push_ready;
  assign cs2_stream_TREADY = cs2_stream_fifo_io_push_ready;
  assign hq2_stream_TREADY = hq2_stream_fifo_io_push_ready;
  assign hs2_stream_TREADY = hs2_stream_fifo_io_push_ready;
  assign m_axi_awvalid = inst_state_m_axi_awvalid;
  assign m_axi_awaddr = inst_state_m_axi_awaddr;
  assign m_axi_awid = inst_state_m_axi_awid;
  assign m_axi_awregion = inst_state_m_axi_awregion;
  assign m_axi_awlen = inst_state_m_axi_awlen;
  assign m_axi_awsize = inst_state_m_axi_awsize;
  assign m_axi_awburst = inst_state_m_axi_awburst;
  assign m_axi_awlock = inst_state_m_axi_awlock;
  assign m_axi_awcache = inst_state_m_axi_awcache;
  assign m_axi_awqos = inst_state_m_axi_awqos;
  assign m_axi_awuser = inst_state_m_axi_awuser;
  assign m_axi_awprot = inst_state_m_axi_awprot;
  assign m_axi_wvalid = inst_state_m_axi_wvalid;
  assign m_axi_wdata = inst_state_m_axi_wdata;
  assign m_axi_wstrb = inst_state_m_axi_wstrb;
  assign m_axi_wuser = inst_state_m_axi_wuser;
  assign m_axi_wlast = inst_state_m_axi_wlast;
  assign m_axi_bready = inst_state_m_axi_bready;
  assign m_axi_arvalid = inst_state_m_axi_arvalid;
  assign m_axi_araddr = inst_state_m_axi_araddr;
  assign m_axi_arid = inst_state_m_axi_arid;
  assign m_axi_arregion = inst_state_m_axi_arregion;
  assign m_axi_arlen = inst_state_m_axi_arlen;
  assign m_axi_arsize = inst_state_m_axi_arsize;
  assign m_axi_arburst = inst_state_m_axi_arburst;
  assign m_axi_arlock = inst_state_m_axi_arlock;
  assign m_axi_arcache = inst_state_m_axi_arcache;
  assign m_axi_arqos = inst_state_m_axi_arqos;
  assign m_axi_aruser = inst_state_m_axi_aruser;
  assign m_axi_arprot = inst_state_m_axi_arprot;
  assign m_axi_rready = inst_state_m_axi_rready;
  assign x_stream_TVALID = inst_m_axi_inst_state_x_stream_fifo_io_pop_valid;
  assign x_stream_TDATA = inst_m_axi_inst_state_x_stream_fifo_io_pop_payload_data;
  assign wq_stream_TVALID = inst_m_axi_inst_flow_wq_stream_fifo_io_pop_valid;
  assign wq_stream_TDATA = inst_m_axi_inst_flow_wq_stream_fifo_io_pop_payload_data;
  assign ws1_stream_TVALID = inst_m_axi_inst_flow_ws1_stream_fifo_io_pop_valid;
  assign ws1_stream_TDATA = inst_m_axi_inst_flow_ws1_stream_fifo_io_pop_payload_data;
  assign ws2_stream_TVALID = inst_m_axi_inst_flow_ws2_stream_fifo_io_pop_valid;
  assign ws2_stream_TDATA = inst_m_axi_inst_flow_ws2_stream_fifo_io_pop_payload_data;
  assign cq_stream_TVALID = inst_m_axi_inst_flow_cq_stream_fifo_io_pop_valid;
  assign cq_stream_TDATA = inst_m_axi_inst_flow_cq_stream_fifo_io_pop_payload_data;
  assign cs_stream_TVALID = inst_m_axi_inst_flow_cs_stream_fifo_io_pop_valid;
  assign cs_stream_TDATA = inst_m_axi_inst_flow_cs_stream_fifo_io_pop_payload_data;
  assign hq_stream_TVALID = inst_m_axi_inst_flow_hq_stream_fifo_io_pop_valid;
  assign hq_stream_TDATA = inst_m_axi_inst_flow_hq_stream_fifo_io_pop_payload_data;
  assign hs_stream_TVALID = inst_m_axi_inst_flow_hs_stream_fifo_io_pop_valid;
  assign hs_stream_TDATA = inst_m_axi_inst_flow_hs_stream_fifo_io_pop_payload_data;
  assign y_stream_fifo_io_flush = 1'b0;
  assign cq2_stream_fifo_io_flush = 1'b0;
  assign cs2_stream_fifo_io_flush = 1'b0;
  assign hq2_stream_fifo_io_flush = 1'b0;
  assign hs2_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_state_x_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_state_mem_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_state_conv_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_state_ht_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_conv2_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_ht2_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_wq_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_ws1_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_ws2_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_cq_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_cs_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_hq_stream_fifo_io_flush = 1'b0;
  assign inst_m_axi_inst_flow_hs_stream_fifo_io_flush = 1'b0;

endmodule

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
  wire                inst_mamba_B_buffer_1_q_stream_fifo_io_flush;
  wire                inst_mamba_B_buffer_1_s_stream_fifo_io_flush;
  wire                inst_mamba_C_buffer_1_q_stream_fifo_io_flush;
  wire                inst_mamba_C_buffer_1_s_stream_fifo_io_flush;
  wire                inst_mamba_conv_1_o_stream_fifo_io_flush;
  wire                inst_mamba_conv_state_1_o_stream_fifo_io_flush;
  wire                inst_mamba_conv_state_1_o_s_stream_fifo_io_flush;
  wire                inst_mamba_conv_state_1_w_stream_fifo_io_flush;
  wire                inst_mamba_conv_state_1_w_s_stream_fifo_io_flush;
  wire                inst_mamba_conv_state_1_conv_state_stream_fifo_io_flush;
  wire                inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_flush;
  wire                inst_mamba_dAh_1_o_stream_fifo_io_flush;
  wire                inst_mamba_dBu_1_o_stream_fifo_io_flush;
  wire                inst_mamba_dtA_1_o_stream_fifo_io_flush;
  wire                inst_mamba_dtadapt_1_o_stream_fifo_io_flush;
  wire                inst_mamba_dtadapt_1_o_s_stream_fifo_io_flush;
  wire                inst_mamba_dtadapt_1_o_stream2_fifo_io_flush;
  wire                inst_mamba_dtadapt_1_o_s_stream2_fifo_io_flush;
  wire                inst_mamba_dtB_quant_1_o_stream_fifo_io_flush;
  wire                inst_mamba_dtB_quant_1_o_s_stream_fifo_io_flush;
  wire                inst_mamba_exp_quant_1_o_stream_fifo_io_flush;
  wire                inst_mamba_exp_quant_1_o_s_stream_fifo_io_flush;
  wire                inst_mamba_gemm_1_o_stream_fifo_io_flush;
  wire                inst_mamba_gemm_demux_1_dt_stream_fifo_io_flush;
  wire                inst_mamba_gemm_demux_1_xBC_stream_fifo_io_flush;
  wire                inst_mamba_gemm_demux_1_z_stream_fifo_io_flush;
  wire                inst_mamba_gemm_demux_1_out_stream_fifo_io_flush;
  wire                inst_mamba_gemm_mux_1_q_stream_fifo_io_flush;
  wire                inst_mamba_gemm_mux_1_s_stream_fifo_io_flush;
  wire                inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_flush;
  wire                inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_flush;
  wire                inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_flush;
  wire                inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_flush;
  wire                inst_mamba_ht_state_1_ht_out_stream_fifo_io_flush;
  wire                inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_flush;
  wire                inst_mamba_ht_state_1_state_out_stream_fifo_io_flush;
  wire                inst_mamba_ht_state_1_state_out_s_stream_fifo_io_flush;
  wire                inst_mamba_htC_quant_1_o_q_stream_fifo_io_flush;
  wire                inst_mamba_htC_quant_1_o_s_stream_fifo_io_flush;
  wire                inst_mamba_quant_conv_1_o_stream_fifo_io_flush;
  wire                inst_mamba_quant_conv_1_o_s_stream_fifo_io_flush;
  wire                inst_mamba_residual_1_res_o_stream_fifo_io_flush;
  wire                inst_mamba_residual_1_y_stream_fifo_io_flush;
  wire                inst_mamba_rms_quant_1_xlnq_stream_fifo_io_flush;
  wire                inst_mamba_rms_quant_1_xlns_stream_fifo_io_flush;
  wire                inst_mamba_rms_quant_2_xlnq_stream_fifo_io_flush;
  wire                inst_mamba_rms_quant_2_xlns_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_x_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_x_s_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_x_stream2_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_x_s_stream2_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_B_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_B_s_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_C_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_C_s_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_z_stream_fifo_io_flush;
  wire                inst_mamba_silu_demux_1_z_s_stream_fifo_io_flush;
  wire                inst_mamba_silu_mux_1_silu_stream_fifo_io_flush;
  wire                inst_mamba_silu_quant_1_out_stream_fifo_io_flush;
  wire                inst_mamba_silu_quant_1_out_s_stream_fifo_io_flush;
  wire                inst_mamba_ud_1_o_stream_fifo_io_flush;
  wire                inst_mamba_yz_1_o_stream_fifo_io_flush;
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
  wire                inst_mamba_B_buffer_1_q_stream_fifo_io_push_ready;
  wire                inst_mamba_B_buffer_1_q_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_B_buffer_1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_B_buffer_1_q_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_B_buffer_1_q_stream_fifo_io_availability;
  wire                inst_mamba_B_buffer_1_s_stream_fifo_io_push_ready;
  wire                inst_mamba_B_buffer_1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_B_buffer_1_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_B_buffer_1_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_B_buffer_1_s_stream_fifo_io_availability;
  wire                inst_mamba_C_buffer_1_q_stream_fifo_io_push_ready;
  wire                inst_mamba_C_buffer_1_q_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_C_buffer_1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_C_buffer_1_q_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_C_buffer_1_q_stream_fifo_io_availability;
  wire                inst_mamba_C_buffer_1_s_stream_fifo_io_push_ready;
  wire                inst_mamba_C_buffer_1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_C_buffer_1_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_C_buffer_1_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_C_buffer_1_s_stream_fifo_io_availability;
  wire                inst_mamba_conv_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_conv_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_conv_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_conv_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_conv_1_o_stream_fifo_io_availability;
  wire                inst_mamba_conv_state_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_conv_state_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_conv_state_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_conv_state_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_conv_state_1_o_stream_fifo_io_availability;
  wire                inst_mamba_conv_state_1_o_s_stream_fifo_io_push_ready;
  wire                inst_mamba_conv_state_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_conv_state_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_conv_state_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_conv_state_1_o_s_stream_fifo_io_availability;
  wire                inst_mamba_conv_state_1_w_stream_fifo_io_push_ready;
  wire                inst_mamba_conv_state_1_w_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_conv_state_1_w_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_conv_state_1_w_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_conv_state_1_w_stream_fifo_io_availability;
  wire                inst_mamba_conv_state_1_w_s_stream_fifo_io_push_ready;
  wire                inst_mamba_conv_state_1_w_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_conv_state_1_w_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_conv_state_1_w_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_conv_state_1_w_s_stream_fifo_io_availability;
  wire                inst_mamba_conv_state_1_conv_state_stream_fifo_io_push_ready;
  wire                inst_mamba_conv_state_1_conv_state_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_conv_state_1_conv_state_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_conv_state_1_conv_state_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_conv_state_1_conv_state_stream_fifo_io_availability;
  wire                inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_push_ready;
  wire                inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_availability;
  wire                inst_mamba_dAh_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_dAh_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_dAh_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dAh_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dAh_1_o_stream_fifo_io_availability;
  wire                inst_mamba_dBu_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_dBu_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_dBu_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dBu_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dBu_1_o_stream_fifo_io_availability;
  wire                inst_mamba_dtA_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_dtA_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_dtA_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dtA_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dtA_1_o_stream_fifo_io_availability;
  wire                inst_mamba_dtadapt_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_dtadapt_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_dtadapt_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dtadapt_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dtadapt_1_o_stream_fifo_io_availability;
  wire                inst_mamba_dtadapt_1_o_s_stream_fifo_io_push_ready;
  wire                inst_mamba_dtadapt_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_dtadapt_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dtadapt_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dtadapt_1_o_s_stream_fifo_io_availability;
  wire                inst_mamba_dtadapt_1_o_stream2_fifo_io_push_ready;
  wire                inst_mamba_dtadapt_1_o_stream2_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_dtadapt_1_o_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dtadapt_1_o_stream2_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dtadapt_1_o_stream2_fifo_io_availability;
  wire                inst_mamba_dtadapt_1_o_s_stream2_fifo_io_push_ready;
  wire                inst_mamba_dtadapt_1_o_s_stream2_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_dtadapt_1_o_s_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dtadapt_1_o_s_stream2_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dtadapt_1_o_s_stream2_fifo_io_availability;
  wire                inst_mamba_dtB_quant_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_dtB_quant_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_dtB_quant_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dtB_quant_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dtB_quant_1_o_stream_fifo_io_availability;
  wire                inst_mamba_dtB_quant_1_o_s_stream_fifo_io_push_ready;
  wire                inst_mamba_dtB_quant_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_dtB_quant_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_dtB_quant_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_dtB_quant_1_o_s_stream_fifo_io_availability;
  wire                inst_mamba_exp_quant_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_exp_quant_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_exp_quant_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_exp_quant_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_exp_quant_1_o_stream_fifo_io_availability;
  wire                inst_mamba_exp_quant_1_o_s_stream_fifo_io_push_ready;
  wire                inst_mamba_exp_quant_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_exp_quant_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_exp_quant_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_exp_quant_1_o_s_stream_fifo_io_availability;
  wire                inst_mamba_gemm_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_gemm_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_gemm_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_gemm_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_gemm_1_o_stream_fifo_io_availability;
  wire                inst_mamba_gemm_demux_1_dt_stream_fifo_io_push_ready;
  wire                inst_mamba_gemm_demux_1_dt_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_gemm_demux_1_dt_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_gemm_demux_1_dt_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_gemm_demux_1_dt_stream_fifo_io_availability;
  wire                inst_mamba_gemm_demux_1_xBC_stream_fifo_io_push_ready;
  wire                inst_mamba_gemm_demux_1_xBC_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_gemm_demux_1_xBC_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_gemm_demux_1_xBC_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_gemm_demux_1_xBC_stream_fifo_io_availability;
  wire                inst_mamba_gemm_demux_1_z_stream_fifo_io_push_ready;
  wire                inst_mamba_gemm_demux_1_z_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_gemm_demux_1_z_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_gemm_demux_1_z_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_gemm_demux_1_z_stream_fifo_io_availability;
  wire                inst_mamba_gemm_demux_1_out_stream_fifo_io_push_ready;
  wire                inst_mamba_gemm_demux_1_out_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_gemm_demux_1_out_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_gemm_demux_1_out_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_gemm_demux_1_out_stream_fifo_io_availability;
  wire                inst_mamba_gemm_mux_1_q_stream_fifo_io_push_ready;
  wire                inst_mamba_gemm_mux_1_q_stream_fifo_io_pop_valid;
  wire       [31:0]   inst_mamba_gemm_mux_1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_gemm_mux_1_q_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_gemm_mux_1_q_stream_fifo_io_availability;
  wire                inst_mamba_gemm_mux_1_s_stream_fifo_io_push_ready;
  wire                inst_mamba_gemm_mux_1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_gemm_mux_1_s_stream_fifo_io_pop_payload_data;
  wire       [9:0]    inst_mamba_gemm_mux_1_s_stream_fifo_io_occupancy;
  wire       [9:0]    inst_mamba_gemm_mux_1_s_stream_fifo_io_availability;
  wire                inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_availability;
  wire                inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_availability;
  wire                inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_availability;
  wire                inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_availability;
  wire                inst_mamba_ht_state_1_ht_out_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_state_1_ht_out_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_ht_state_1_ht_out_stream_fifo_io_pop_payload_data;
  wire       [6:0]    inst_mamba_ht_state_1_ht_out_stream_fifo_io_occupancy;
  wire       [6:0]    inst_mamba_ht_state_1_ht_out_stream_fifo_io_availability;
  wire                inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_pop_payload_data;
  wire       [6:0]    inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_occupancy;
  wire       [6:0]    inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_availability;
  wire                inst_mamba_ht_state_1_state_out_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_state_1_state_out_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_ht_state_1_state_out_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_ht_state_1_state_out_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_ht_state_1_state_out_stream_fifo_io_availability;
  wire                inst_mamba_ht_state_1_state_out_s_stream_fifo_io_push_ready;
  wire                inst_mamba_ht_state_1_state_out_s_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_ht_state_1_state_out_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_ht_state_1_state_out_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_ht_state_1_state_out_s_stream_fifo_io_availability;
  wire                inst_mamba_htC_quant_1_o_q_stream_fifo_io_push_ready;
  wire                inst_mamba_htC_quant_1_o_q_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_htC_quant_1_o_q_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_htC_quant_1_o_q_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_htC_quant_1_o_q_stream_fifo_io_availability;
  wire                inst_mamba_htC_quant_1_o_s_stream_fifo_io_push_ready;
  wire                inst_mamba_htC_quant_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_htC_quant_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_htC_quant_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_htC_quant_1_o_s_stream_fifo_io_availability;
  wire                inst_mamba_quant_conv_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_quant_conv_1_o_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_quant_conv_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_quant_conv_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_quant_conv_1_o_stream_fifo_io_availability;
  wire                inst_mamba_quant_conv_1_o_s_stream_fifo_io_push_ready;
  wire                inst_mamba_quant_conv_1_o_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_quant_conv_1_o_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_quant_conv_1_o_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_quant_conv_1_o_s_stream_fifo_io_availability;
  wire                inst_mamba_residual_1_res_o_stream_fifo_io_push_ready;
  wire                inst_mamba_residual_1_res_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_residual_1_res_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_residual_1_res_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_residual_1_res_o_stream_fifo_io_availability;
  wire                inst_mamba_residual_1_y_stream_fifo_io_push_ready;
  wire                inst_mamba_residual_1_y_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_residual_1_y_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_residual_1_y_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_residual_1_y_stream_fifo_io_availability;
  wire                inst_mamba_rms_quant_1_xlnq_stream_fifo_io_push_ready;
  wire                inst_mamba_rms_quant_1_xlnq_stream_fifo_io_pop_valid;
  wire       [31:0]   inst_mamba_rms_quant_1_xlnq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_rms_quant_1_xlnq_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_rms_quant_1_xlnq_stream_fifo_io_availability;
  wire                inst_mamba_rms_quant_1_xlns_stream_fifo_io_push_ready;
  wire                inst_mamba_rms_quant_1_xlns_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_rms_quant_1_xlns_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_rms_quant_1_xlns_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_rms_quant_1_xlns_stream_fifo_io_availability;
  wire                inst_mamba_rms_quant_2_xlnq_stream_fifo_io_push_ready;
  wire                inst_mamba_rms_quant_2_xlnq_stream_fifo_io_pop_valid;
  wire       [31:0]   inst_mamba_rms_quant_2_xlnq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_rms_quant_2_xlnq_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_rms_quant_2_xlnq_stream_fifo_io_availability;
  wire                inst_mamba_rms_quant_2_xlns_stream_fifo_io_push_ready;
  wire                inst_mamba_rms_quant_2_xlns_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_rms_quant_2_xlns_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_rms_quant_2_xlns_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_rms_quant_2_xlns_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_x_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_x_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_silu_demux_1_x_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_x_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_x_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_x_s_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_x_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_silu_demux_1_x_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_x_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_x_s_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_x_stream2_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_x_stream2_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_silu_demux_1_x_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_x_stream2_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_x_stream2_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_x_s_stream2_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_x_s_stream2_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_silu_demux_1_x_s_stream2_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_x_s_stream2_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_x_s_stream2_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_B_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_B_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_silu_demux_1_B_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_B_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_B_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_B_s_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_B_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_silu_demux_1_B_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_B_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_B_s_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_C_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_C_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_silu_demux_1_C_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_C_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_C_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_C_s_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_C_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_silu_demux_1_C_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_C_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_C_s_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_z_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_z_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_silu_demux_1_z_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_z_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_z_stream_fifo_io_availability;
  wire                inst_mamba_silu_demux_1_z_s_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_demux_1_z_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_silu_demux_1_z_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_demux_1_z_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_demux_1_z_s_stream_fifo_io_availability;
  wire                inst_mamba_silu_mux_1_silu_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_mux_1_silu_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_silu_mux_1_silu_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_mux_1_silu_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_mux_1_silu_stream_fifo_io_availability;
  wire                inst_mamba_silu_quant_1_out_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_quant_1_out_stream_fifo_io_pop_valid;
  wire       [63:0]   inst_mamba_silu_quant_1_out_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_quant_1_out_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_quant_1_out_stream_fifo_io_availability;
  wire                inst_mamba_silu_quant_1_out_s_stream_fifo_io_push_ready;
  wire                inst_mamba_silu_quant_1_out_s_stream_fifo_io_pop_valid;
  wire       [7:0]    inst_mamba_silu_quant_1_out_s_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_silu_quant_1_out_s_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_silu_quant_1_out_s_stream_fifo_io_availability;
  wire                inst_mamba_ud_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_ud_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_ud_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_ud_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_ud_1_o_stream_fifo_io_availability;
  wire                inst_mamba_yz_1_o_stream_fifo_io_push_ready;
  wire                inst_mamba_yz_1_o_stream_fifo_io_pop_valid;
  wire       [255:0]  inst_mamba_yz_1_o_stream_fifo_io_pop_payload_data;
  wire       [3:0]    inst_mamba_yz_1_o_stream_fifo_io_occupancy;
  wire       [3:0]    inst_mamba_yz_1_o_stream_fifo_io_availability;

  B_BUFFER_wrapper B_buffer_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (signals_I_L_BEGIN[31:0]                                         ), //i
    .signals_I_L_CLOSE  (signals_I_L_CLOSE[31:0]                                         ), //i
    .signals_I_MEMORY_X (signals_I_MEMORY_X[63:0]                                        ), //i
    .signals_I_MEMORY_W (signals_I_MEMORY_W[63:0]                                        ), //i
    .signals_I_MEMORY_Y (signals_I_MEMORY_Y[63:0]                                        ), //i
    .signals_I_MEMORY_C (signals_I_MEMORY_C[63:0]                                        ), //i
    .signals_I_MEMORY_H (signals_I_MEMORY_H[63:0]                                        ), //i
    .signals_I_POS      (signals_I_POS[11:0]                                             ), //i
    .signals_I_T        (signals_I_T                                                     ), //i
    .signals_O_L_BEGIN  (B_buffer_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE  (B_buffer_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X (B_buffer_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W (B_buffer_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y (B_buffer_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C (B_buffer_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H (B_buffer_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS      (B_buffer_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T        (B_buffer_1_signals_O_T                                          ), //o
    .i_stream_TVALID    (inst_mamba_silu_demux_1_B_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (B_buffer_1_i_stream_TREADY                                      ), //o
    .i_stream_TDATA     (inst_mamba_silu_demux_1_B_stream_fifo_io_pop_payload_data[63:0] ), //i
    .i_s_stream_TVALID  (inst_mamba_silu_demux_1_B_s_stream_fifo_io_pop_valid            ), //i
    .i_s_stream_TREADY  (B_buffer_1_i_s_stream_TREADY                                    ), //o
    .i_s_stream_TDATA   (inst_mamba_silu_demux_1_B_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .q_stream_TVALID    (B_buffer_1_q_stream_TVALID                                      ), //o
    .q_stream_TREADY    (inst_mamba_B_buffer_1_q_stream_fifo_io_push_ready               ), //i
    .q_stream_TDATA     (B_buffer_1_q_stream_TDATA[63:0]                                 ), //o
    .s_stream_TVALID    (B_buffer_1_s_stream_TVALID                                      ), //o
    .s_stream_TREADY    (inst_mamba_B_buffer_1_s_stream_fifo_io_push_ready               ), //i
    .s_stream_TDATA     (B_buffer_1_s_stream_TDATA[7:0]                                  )  //o
  );
  C_BUFFER_wrapper C_buffer_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (B_buffer_1_signals_O_L_BEGIN[31:0]                              ), //i
    .signals_I_L_CLOSE  (B_buffer_1_signals_O_L_CLOSE[31:0]                              ), //i
    .signals_I_MEMORY_X (B_buffer_1_signals_O_MEMORY_X[63:0]                             ), //i
    .signals_I_MEMORY_W (B_buffer_1_signals_O_MEMORY_W[63:0]                             ), //i
    .signals_I_MEMORY_Y (B_buffer_1_signals_O_MEMORY_Y[63:0]                             ), //i
    .signals_I_MEMORY_C (B_buffer_1_signals_O_MEMORY_C[63:0]                             ), //i
    .signals_I_MEMORY_H (B_buffer_1_signals_O_MEMORY_H[63:0]                             ), //i
    .signals_I_POS      (B_buffer_1_signals_O_POS[11:0]                                  ), //i
    .signals_I_T        (B_buffer_1_signals_O_T                                          ), //i
    .signals_O_L_BEGIN  (C_buffer_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE  (C_buffer_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X (C_buffer_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W (C_buffer_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y (C_buffer_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C (C_buffer_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H (C_buffer_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS      (C_buffer_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T        (C_buffer_1_signals_O_T                                          ), //o
    .i_stream_TVALID    (inst_mamba_silu_demux_1_C_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (C_buffer_1_i_stream_TREADY                                      ), //o
    .i_stream_TDATA     (inst_mamba_silu_demux_1_C_stream_fifo_io_pop_payload_data[63:0] ), //i
    .i_s_stream_TVALID  (inst_mamba_silu_demux_1_C_s_stream_fifo_io_pop_valid            ), //i
    .i_s_stream_TREADY  (C_buffer_1_i_s_stream_TREADY                                    ), //o
    .i_s_stream_TDATA   (inst_mamba_silu_demux_1_C_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .q_stream_TVALID    (C_buffer_1_q_stream_TVALID                                      ), //o
    .q_stream_TREADY    (inst_mamba_C_buffer_1_q_stream_fifo_io_push_ready               ), //i
    .q_stream_TDATA     (C_buffer_1_q_stream_TDATA[63:0]                                 ), //o
    .s_stream_TVALID    (C_buffer_1_s_stream_TVALID                                      ), //o
    .s_stream_TREADY    (inst_mamba_C_buffer_1_s_stream_fifo_io_push_ready               ), //i
    .s_stream_TDATA     (C_buffer_1_s_stream_TDATA[7:0]                                  )  //o
  );
  CONV_wrapper conv_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (C_buffer_1_signals_O_L_BEGIN[31:0]                              ), //i
    .signals_I_L_CLOSE  (C_buffer_1_signals_O_L_CLOSE[31:0]                              ), //i
    .signals_I_MEMORY_X (C_buffer_1_signals_O_MEMORY_X[63:0]                             ), //i
    .signals_I_MEMORY_W (C_buffer_1_signals_O_MEMORY_W[63:0]                             ), //i
    .signals_I_MEMORY_Y (C_buffer_1_signals_O_MEMORY_Y[63:0]                             ), //i
    .signals_I_MEMORY_C (C_buffer_1_signals_O_MEMORY_C[63:0]                             ), //i
    .signals_I_MEMORY_H (C_buffer_1_signals_O_MEMORY_H[63:0]                             ), //i
    .signals_I_POS      (C_buffer_1_signals_O_POS[11:0]                                  ), //i
    .signals_I_T        (C_buffer_1_signals_O_T                                          ), //i
    .signals_O_L_BEGIN  (conv_1_signals_O_L_BEGIN[31:0]                                  ), //o
    .signals_O_L_CLOSE  (conv_1_signals_O_L_CLOSE[31:0]                                  ), //o
    .signals_O_MEMORY_X (conv_1_signals_O_MEMORY_X[63:0]                                 ), //o
    .signals_O_MEMORY_W (conv_1_signals_O_MEMORY_W[63:0]                                 ), //o
    .signals_O_MEMORY_Y (conv_1_signals_O_MEMORY_Y[63:0]                                 ), //o
    .signals_O_MEMORY_C (conv_1_signals_O_MEMORY_C[63:0]                                 ), //o
    .signals_O_MEMORY_H (conv_1_signals_O_MEMORY_H[63:0]                                 ), //o
    .signals_O_POS      (conv_1_signals_O_POS[11:0]                                      ), //o
    .signals_O_T        (conv_1_signals_O_T                                              ), //o
    .i_stream_TVALID    (inst_mamba_conv_state_1_o_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (conv_1_i_stream_TREADY                                          ), //o
    .i_stream_TDATA     (inst_mamba_conv_state_1_o_stream_fifo_io_pop_payload_data[63:0] ), //i
    .s_stream_TVALID    (inst_mamba_conv_state_1_o_s_stream_fifo_io_pop_valid            ), //i
    .s_stream_TREADY    (conv_1_s_stream_TREADY                                          ), //o
    .s_stream_TDATA     (inst_mamba_conv_state_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .w_stream_TVALID    (inst_mamba_conv_state_1_w_stream_fifo_io_pop_valid              ), //i
    .w_stream_TREADY    (conv_1_w_stream_TREADY                                          ), //o
    .w_stream_TDATA     (inst_mamba_conv_state_1_w_stream_fifo_io_pop_payload_data[63:0] ), //i
    .w_s_stream_TVALID  (inst_mamba_conv_state_1_w_s_stream_fifo_io_pop_valid            ), //i
    .w_s_stream_TREADY  (conv_1_w_s_stream_TREADY                                        ), //o
    .w_s_stream_TDATA   (inst_mamba_conv_state_1_w_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (conv_1_o_stream_TVALID                                          ), //o
    .o_stream_TREADY    (inst_mamba_conv_1_o_stream_fifo_io_push_ready                   ), //i
    .o_stream_TDATA     (conv_1_o_stream_TDATA[255:0]                                    )  //o
  );
  CONV_STATE_wrapper conv_state_1 (
    .resetn                     (resetn                                                          ), //i
    .clk                        (clk                                                             ), //i
    .signals_I_L_BEGIN          (conv_1_signals_O_L_BEGIN[31:0]                                  ), //i
    .signals_I_L_CLOSE          (conv_1_signals_O_L_CLOSE[31:0]                                  ), //i
    .signals_I_MEMORY_X         (conv_1_signals_O_MEMORY_X[63:0]                                 ), //i
    .signals_I_MEMORY_W         (conv_1_signals_O_MEMORY_W[63:0]                                 ), //i
    .signals_I_MEMORY_Y         (conv_1_signals_O_MEMORY_Y[63:0]                                 ), //i
    .signals_I_MEMORY_C         (conv_1_signals_O_MEMORY_C[63:0]                                 ), //i
    .signals_I_MEMORY_H         (conv_1_signals_O_MEMORY_H[63:0]                                 ), //i
    .signals_I_POS              (conv_1_signals_O_POS[11:0]                                      ), //i
    .signals_I_T                (conv_1_signals_O_T                                              ), //i
    .signals_O_L_BEGIN          (conv_state_1_signals_O_L_BEGIN[31:0]                            ), //o
    .signals_O_L_CLOSE          (conv_state_1_signals_O_L_CLOSE[31:0]                            ), //o
    .signals_O_MEMORY_X         (conv_state_1_signals_O_MEMORY_X[63:0]                           ), //o
    .signals_O_MEMORY_W         (conv_state_1_signals_O_MEMORY_W[63:0]                           ), //o
    .signals_O_MEMORY_Y         (conv_state_1_signals_O_MEMORY_Y[63:0]                           ), //o
    .signals_O_MEMORY_C         (conv_state_1_signals_O_MEMORY_C[63:0]                           ), //o
    .signals_O_MEMORY_H         (conv_state_1_signals_O_MEMORY_H[63:0]                           ), //o
    .signals_O_POS              (conv_state_1_signals_O_POS[11:0]                                ), //o
    .signals_O_T                (conv_state_1_signals_O_T                                        ), //o
    .conv_stream_TVALID         (cq_stream_fifo_io_pop_valid                                     ), //i
    .conv_stream_TREADY         (conv_state_1_conv_stream_TREADY                                 ), //o
    .conv_stream_TDATA          (cq_stream_fifo_io_pop_payload_data[255:0]                       ), //i
    .conv_s_stream_TVALID       (cs_stream_fifo_io_pop_valid                                     ), //i
    .conv_s_stream_TREADY       (conv_state_1_conv_s_stream_TREADY                               ), //o
    .conv_s_stream_TDATA        (cs_stream_fifo_io_pop_payload_data[255:0]                       ), //i
    .xBC_stream_TVALID          (inst_mamba_quant_conv_1_o_stream_fifo_io_pop_valid              ), //i
    .xBC_stream_TREADY          (conv_state_1_xBC_stream_TREADY                                  ), //o
    .xBC_stream_TDATA           (inst_mamba_quant_conv_1_o_stream_fifo_io_pop_payload_data[63:0] ), //i
    .xBC_s_stream_TVALID        (inst_mamba_quant_conv_1_o_s_stream_fifo_io_pop_valid            ), //i
    .xBC_s_stream_TREADY        (conv_state_1_xBC_s_stream_TREADY                                ), //o
    .xBC_s_stream_TDATA         (inst_mamba_quant_conv_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .w_stream_TVALID            (conv_state_1_w_stream_TVALID                                    ), //o
    .w_stream_TREADY            (inst_mamba_conv_state_1_w_stream_fifo_io_push_ready             ), //i
    .w_stream_TDATA             (conv_state_1_w_stream_TDATA[63:0]                               ), //o
    .w_s_stream_TVALID          (conv_state_1_w_s_stream_TVALID                                  ), //o
    .w_s_stream_TREADY          (inst_mamba_conv_state_1_w_s_stream_fifo_io_push_ready           ), //i
    .w_s_stream_TDATA           (conv_state_1_w_s_stream_TDATA[7:0]                              ), //o
    .o_stream_TVALID            (conv_state_1_o_stream_TVALID                                    ), //o
    .o_stream_TREADY            (inst_mamba_conv_state_1_o_stream_fifo_io_push_ready             ), //i
    .o_stream_TDATA             (conv_state_1_o_stream_TDATA[63:0]                               ), //o
    .o_s_stream_TVALID          (conv_state_1_o_s_stream_TVALID                                  ), //o
    .o_s_stream_TREADY          (inst_mamba_conv_state_1_o_s_stream_fifo_io_push_ready           ), //i
    .o_s_stream_TDATA           (conv_state_1_o_s_stream_TDATA[7:0]                              ), //o
    .conv_state_stream_TVALID   (conv_state_1_conv_state_stream_TVALID                           ), //o
    .conv_state_stream_TREADY   (inst_mamba_conv_state_1_conv_state_stream_fifo_io_push_ready    ), //i
    .conv_state_stream_TDATA    (conv_state_1_conv_state_stream_TDATA[255:0]                     ), //o
    .conv_state_s_stream_TVALID (conv_state_1_conv_state_s_stream_TVALID                         ), //o
    .conv_state_s_stream_TREADY (inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_push_ready  ), //i
    .conv_state_s_stream_TDATA  (conv_state_1_conv_state_s_stream_TDATA[255:0]                   )  //o
  );
  DAH_wrapper dAh_1 (
    .resetn             (resetn                                                             ), //i
    .clk                (clk                                                                ), //i
    .signals_I_L_BEGIN  (conv_state_1_signals_O_L_BEGIN[31:0]                               ), //i
    .signals_I_L_CLOSE  (conv_state_1_signals_O_L_CLOSE[31:0]                               ), //i
    .signals_I_MEMORY_X (conv_state_1_signals_O_MEMORY_X[63:0]                              ), //i
    .signals_I_MEMORY_W (conv_state_1_signals_O_MEMORY_W[63:0]                              ), //i
    .signals_I_MEMORY_Y (conv_state_1_signals_O_MEMORY_Y[63:0]                              ), //i
    .signals_I_MEMORY_C (conv_state_1_signals_O_MEMORY_C[63:0]                              ), //i
    .signals_I_MEMORY_H (conv_state_1_signals_O_MEMORY_H[63:0]                              ), //i
    .signals_I_POS      (conv_state_1_signals_O_POS[11:0]                                   ), //i
    .signals_I_T        (conv_state_1_signals_O_T                                           ), //i
    .signals_O_L_BEGIN  (dAh_1_signals_O_L_BEGIN[31:0]                                      ), //o
    .signals_O_L_CLOSE  (dAh_1_signals_O_L_CLOSE[31:0]                                      ), //o
    .signals_O_MEMORY_X (dAh_1_signals_O_MEMORY_X[63:0]                                     ), //o
    .signals_O_MEMORY_W (dAh_1_signals_O_MEMORY_W[63:0]                                     ), //o
    .signals_O_MEMORY_Y (dAh_1_signals_O_MEMORY_Y[63:0]                                     ), //o
    .signals_O_MEMORY_C (dAh_1_signals_O_MEMORY_C[63:0]                                     ), //o
    .signals_O_MEMORY_H (dAh_1_signals_O_MEMORY_H[63:0]                                     ), //o
    .signals_O_POS      (dAh_1_signals_O_POS[11:0]                                          ), //o
    .signals_O_T        (dAh_1_signals_O_T                                                  ), //o
    .dA_stream_TVALID   (inst_mamba_exp_quant_1_o_stream_fifo_io_pop_valid                  ), //i
    .dA_stream_TREADY   (dAh_1_dA_stream_TREADY                                             ), //o
    .dA_stream_TDATA    (inst_mamba_exp_quant_1_o_stream_fifo_io_pop_payload_data[63:0]     ), //i
    .dA_s_stream_TVALID (inst_mamba_exp_quant_1_o_s_stream_fifo_io_pop_valid                ), //i
    .dA_s_stream_TREADY (dAh_1_dA_s_stream_TREADY                                           ), //o
    .dA_s_stream_TDATA  (inst_mamba_exp_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]    ), //i
    .ht_stream_TVALID   (inst_mamba_ht_state_1_ht_out_stream_fifo_io_pop_valid              ), //i
    .ht_stream_TREADY   (dAh_1_ht_stream_TREADY                                             ), //o
    .ht_stream_TDATA    (inst_mamba_ht_state_1_ht_out_stream_fifo_io_pop_payload_data[63:0] ), //i
    .ht_s_stream_TVALID (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_pop_valid            ), //i
    .ht_s_stream_TREADY (dAh_1_ht_s_stream_TREADY                                           ), //o
    .ht_s_stream_TDATA  (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (dAh_1_o_stream_TVALID                                              ), //o
    .o_stream_TREADY    (inst_mamba_dAh_1_o_stream_fifo_io_push_ready                       ), //i
    .o_stream_TDATA     (dAh_1_o_stream_TDATA[255:0]                                        )  //o
  );
  DBU_wrapper dBu_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (dAh_1_signals_O_L_BEGIN[31:0]                                   ), //i
    .signals_I_L_CLOSE  (dAh_1_signals_O_L_CLOSE[31:0]                                   ), //i
    .signals_I_MEMORY_X (dAh_1_signals_O_MEMORY_X[63:0]                                  ), //i
    .signals_I_MEMORY_W (dAh_1_signals_O_MEMORY_W[63:0]                                  ), //i
    .signals_I_MEMORY_Y (dAh_1_signals_O_MEMORY_Y[63:0]                                  ), //i
    .signals_I_MEMORY_C (dAh_1_signals_O_MEMORY_C[63:0]                                  ), //i
    .signals_I_MEMORY_H (dAh_1_signals_O_MEMORY_H[63:0]                                  ), //i
    .signals_I_POS      (dAh_1_signals_O_POS[11:0]                                       ), //i
    .signals_I_T        (dAh_1_signals_O_T                                               ), //i
    .signals_O_L_BEGIN  (dBu_1_signals_O_L_BEGIN[31:0]                                   ), //o
    .signals_O_L_CLOSE  (dBu_1_signals_O_L_CLOSE[31:0]                                   ), //o
    .signals_O_MEMORY_X (dBu_1_signals_O_MEMORY_X[63:0]                                  ), //o
    .signals_O_MEMORY_W (dBu_1_signals_O_MEMORY_W[63:0]                                  ), //o
    .signals_O_MEMORY_Y (dBu_1_signals_O_MEMORY_Y[63:0]                                  ), //o
    .signals_O_MEMORY_C (dBu_1_signals_O_MEMORY_C[63:0]                                  ), //o
    .signals_O_MEMORY_H (dBu_1_signals_O_MEMORY_H[63:0]                                  ), //o
    .signals_O_POS      (dBu_1_signals_O_POS[11:0]                                       ), //o
    .signals_O_T        (dBu_1_signals_O_T                                               ), //o
    .dB_stream_TVALID   (inst_mamba_dtB_quant_1_o_stream_fifo_io_pop_valid               ), //i
    .dB_stream_TREADY   (dBu_1_dB_stream_TREADY                                          ), //o
    .dB_stream_TDATA    (inst_mamba_dtB_quant_1_o_stream_fifo_io_pop_payload_data[63:0]  ), //i
    .dB_s_stream_TVALID (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_pop_valid             ), //i
    .dB_s_stream_TREADY (dBu_1_dB_s_stream_TREADY                                        ), //o
    .dB_s_stream_TDATA  (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .u_stream_TVALID    (inst_mamba_silu_demux_1_x_stream_fifo_io_pop_valid              ), //i
    .u_stream_TREADY    (dBu_1_u_stream_TREADY                                           ), //o
    .u_stream_TDATA     (inst_mamba_silu_demux_1_x_stream_fifo_io_pop_payload_data[63:0] ), //i
    .u_s_stream_TVALID  (inst_mamba_silu_demux_1_x_s_stream_fifo_io_pop_valid            ), //i
    .u_s_stream_TREADY  (dBu_1_u_s_stream_TREADY                                         ), //o
    .u_s_stream_TDATA   (inst_mamba_silu_demux_1_x_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (dBu_1_o_stream_TVALID                                           ), //o
    .o_stream_TREADY    (inst_mamba_dBu_1_o_stream_fifo_io_push_ready                    ), //i
    .o_stream_TDATA     (dBu_1_o_stream_TDATA[255:0]                                     )  //o
  );
  DTA_wrapper dtA_1 (
    .resetn             (resetn                                                       ), //i
    .clk                (clk                                                          ), //i
    .signals_I_L_BEGIN  (dBu_1_signals_O_L_BEGIN[31:0]                                ), //i
    .signals_I_L_CLOSE  (dBu_1_signals_O_L_CLOSE[31:0]                                ), //i
    .signals_I_MEMORY_X (dBu_1_signals_O_MEMORY_X[63:0]                               ), //i
    .signals_I_MEMORY_W (dBu_1_signals_O_MEMORY_W[63:0]                               ), //i
    .signals_I_MEMORY_Y (dBu_1_signals_O_MEMORY_Y[63:0]                               ), //i
    .signals_I_MEMORY_C (dBu_1_signals_O_MEMORY_C[63:0]                               ), //i
    .signals_I_MEMORY_H (dBu_1_signals_O_MEMORY_H[63:0]                               ), //i
    .signals_I_POS      (dBu_1_signals_O_POS[11:0]                                    ), //i
    .signals_I_T        (dBu_1_signals_O_T                                            ), //i
    .signals_O_L_BEGIN  (dtA_1_signals_O_L_BEGIN[31:0]                                ), //o
    .signals_O_L_CLOSE  (dtA_1_signals_O_L_CLOSE[31:0]                                ), //o
    .signals_O_MEMORY_X (dtA_1_signals_O_MEMORY_X[63:0]                               ), //o
    .signals_O_MEMORY_W (dtA_1_signals_O_MEMORY_W[63:0]                               ), //o
    .signals_O_MEMORY_Y (dtA_1_signals_O_MEMORY_Y[63:0]                               ), //o
    .signals_O_MEMORY_C (dtA_1_signals_O_MEMORY_C[63:0]                               ), //o
    .signals_O_MEMORY_H (dtA_1_signals_O_MEMORY_H[63:0]                               ), //o
    .signals_O_POS      (dtA_1_signals_O_POS[11:0]                                    ), //o
    .signals_O_T        (dtA_1_signals_O_T                                            ), //o
    .i_stream_TVALID    (inst_mamba_dtadapt_1_o_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (dtA_1_i_stream_TREADY                                        ), //o
    .i_stream_TDATA     (inst_mamba_dtadapt_1_o_stream_fifo_io_pop_payload_data[63:0] ), //i
    .s_stream_TVALID    (inst_mamba_dtadapt_1_o_s_stream_fifo_io_pop_valid            ), //i
    .s_stream_TREADY    (dtA_1_s_stream_TREADY                                        ), //o
    .s_stream_TDATA     (inst_mamba_dtadapt_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (dtA_1_o_stream_TVALID                                        ), //o
    .o_stream_TREADY    (inst_mamba_dtA_1_o_stream_fifo_io_push_ready                 ), //i
    .o_stream_TDATA     (dtA_1_o_stream_TDATA[255:0]                                  )  //o
  );
  DTADAPT_wrapper dtadapt_1 (
    .resetn             (resetn                                                           ), //i
    .clk                (clk                                                              ), //i
    .signals_I_L_BEGIN  (dtA_1_signals_O_L_BEGIN[31:0]                                    ), //i
    .signals_I_L_CLOSE  (dtA_1_signals_O_L_CLOSE[31:0]                                    ), //i
    .signals_I_MEMORY_X (dtA_1_signals_O_MEMORY_X[63:0]                                   ), //i
    .signals_I_MEMORY_W (dtA_1_signals_O_MEMORY_W[63:0]                                   ), //i
    .signals_I_MEMORY_Y (dtA_1_signals_O_MEMORY_Y[63:0]                                   ), //i
    .signals_I_MEMORY_C (dtA_1_signals_O_MEMORY_C[63:0]                                   ), //i
    .signals_I_MEMORY_H (dtA_1_signals_O_MEMORY_H[63:0]                                   ), //i
    .signals_I_POS      (dtA_1_signals_O_POS[11:0]                                        ), //i
    .signals_I_T        (dtA_1_signals_O_T                                                ), //i
    .signals_O_L_BEGIN  (dtadapt_1_signals_O_L_BEGIN[31:0]                                ), //o
    .signals_O_L_CLOSE  (dtadapt_1_signals_O_L_CLOSE[31:0]                                ), //o
    .signals_O_MEMORY_X (dtadapt_1_signals_O_MEMORY_X[63:0]                               ), //o
    .signals_O_MEMORY_W (dtadapt_1_signals_O_MEMORY_W[63:0]                               ), //o
    .signals_O_MEMORY_Y (dtadapt_1_signals_O_MEMORY_Y[63:0]                               ), //o
    .signals_O_MEMORY_C (dtadapt_1_signals_O_MEMORY_C[63:0]                               ), //o
    .signals_O_MEMORY_H (dtadapt_1_signals_O_MEMORY_H[63:0]                               ), //o
    .signals_O_POS      (dtadapt_1_signals_O_POS[11:0]                                    ), //o
    .signals_O_T        (dtadapt_1_signals_O_T                                            ), //o
    .i_stream_TVALID    (inst_mamba_gemm_demux_1_dt_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (dtadapt_1_i_stream_TREADY                                        ), //o
    .i_stream_TDATA     (inst_mamba_gemm_demux_1_dt_stream_fifo_io_pop_payload_data[255:0]), //i
    .o_stream_TVALID    (dtadapt_1_o_stream_TVALID                                        ), //o
    .o_stream_TREADY    (inst_mamba_dtadapt_1_o_stream_fifo_io_push_ready                 ), //i
    .o_stream_TDATA     (dtadapt_1_o_stream_TDATA[63:0]                                   ), //o
    .o_s_stream_TVALID  (dtadapt_1_o_s_stream_TVALID                                      ), //o
    .o_s_stream_TREADY  (inst_mamba_dtadapt_1_o_s_stream_fifo_io_push_ready               ), //i
    .o_s_stream_TDATA   (dtadapt_1_o_s_stream_TDATA[7:0]                                  ), //o
    .o_stream2_TVALID   (dtadapt_1_o_stream2_TVALID                                       ), //o
    .o_stream2_TREADY   (inst_mamba_dtadapt_1_o_stream2_fifo_io_push_ready                ), //i
    .o_stream2_TDATA    (dtadapt_1_o_stream2_TDATA[63:0]                                  ), //o
    .o_s_stream2_TVALID (dtadapt_1_o_s_stream2_TVALID                                     ), //o
    .o_s_stream2_TREADY (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_push_ready              ), //i
    .o_s_stream2_TDATA  (dtadapt_1_o_s_stream2_TDATA[7:0]                                 )  //o
  );
  DTB_QUANT_wrapper dtB_quant_1 (
    .resetn             (resetn                                                        ), //i
    .clk                (clk                                                           ), //i
    .signals_I_L_BEGIN  (dtadapt_1_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE  (dtadapt_1_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X (dtadapt_1_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W (dtadapt_1_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y (dtadapt_1_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C (dtadapt_1_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H (dtadapt_1_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS      (dtadapt_1_signals_O_POS[11:0]                                 ), //i
    .signals_I_T        (dtadapt_1_signals_O_T                                         ), //i
    .signals_O_L_BEGIN  (dtB_quant_1_signals_O_L_BEGIN[31:0]                           ), //o
    .signals_O_L_CLOSE  (dtB_quant_1_signals_O_L_CLOSE[31:0]                           ), //o
    .signals_O_MEMORY_X (dtB_quant_1_signals_O_MEMORY_X[63:0]                          ), //o
    .signals_O_MEMORY_W (dtB_quant_1_signals_O_MEMORY_W[63:0]                          ), //o
    .signals_O_MEMORY_Y (dtB_quant_1_signals_O_MEMORY_Y[63:0]                          ), //o
    .signals_O_MEMORY_C (dtB_quant_1_signals_O_MEMORY_C[63:0]                          ), //o
    .signals_O_MEMORY_H (dtB_quant_1_signals_O_MEMORY_H[63:0]                          ), //o
    .signals_O_POS      (dtB_quant_1_signals_O_POS[11:0]                               ), //o
    .signals_O_T        (dtB_quant_1_signals_O_T                                       ), //o
    .dt_stream_TVALID   (inst_mamba_dtadapt_1_o_stream2_fifo_io_pop_valid              ), //i
    .dt_stream_TREADY   (dtB_quant_1_dt_stream_TREADY                                  ), //o
    .dt_stream_TDATA    (inst_mamba_dtadapt_1_o_stream2_fifo_io_pop_payload_data[63:0] ), //i
    .dt_s_stream_TVALID (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_pop_valid            ), //i
    .dt_s_stream_TREADY (dtB_quant_1_dt_s_stream_TREADY                                ), //o
    .dt_s_stream_TDATA  (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_pop_payload_data[7:0]), //i
    .B_stream_TVALID    (inst_mamba_B_buffer_1_q_stream_fifo_io_pop_valid              ), //i
    .B_stream_TREADY    (dtB_quant_1_B_stream_TREADY                                   ), //o
    .B_stream_TDATA     (inst_mamba_B_buffer_1_q_stream_fifo_io_pop_payload_data[63:0] ), //i
    .B_s_stream_TVALID  (inst_mamba_B_buffer_1_s_stream_fifo_io_pop_valid              ), //i
    .B_s_stream_TREADY  (dtB_quant_1_B_s_stream_TREADY                                 ), //o
    .B_s_stream_TDATA   (inst_mamba_B_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]  ), //i
    .o_stream_TVALID    (dtB_quant_1_o_stream_TVALID                                   ), //o
    .o_stream_TREADY    (inst_mamba_dtB_quant_1_o_stream_fifo_io_push_ready            ), //i
    .o_stream_TDATA     (dtB_quant_1_o_stream_TDATA[63:0]                              ), //o
    .o_s_stream_TVALID  (dtB_quant_1_o_s_stream_TVALID                                 ), //o
    .o_s_stream_TREADY  (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_push_ready          ), //i
    .o_s_stream_TDATA   (dtB_quant_1_o_s_stream_TDATA[7:0]                             )  //o
  );
  EXP_QUANT_wrapper exp_quant_1 (
    .resetn             (resetn                                                   ), //i
    .clk                (clk                                                      ), //i
    .signals_I_L_BEGIN  (dtB_quant_1_signals_O_L_BEGIN[31:0]                      ), //i
    .signals_I_L_CLOSE  (dtB_quant_1_signals_O_L_CLOSE[31:0]                      ), //i
    .signals_I_MEMORY_X (dtB_quant_1_signals_O_MEMORY_X[63:0]                     ), //i
    .signals_I_MEMORY_W (dtB_quant_1_signals_O_MEMORY_W[63:0]                     ), //i
    .signals_I_MEMORY_Y (dtB_quant_1_signals_O_MEMORY_Y[63:0]                     ), //i
    .signals_I_MEMORY_C (dtB_quant_1_signals_O_MEMORY_C[63:0]                     ), //i
    .signals_I_MEMORY_H (dtB_quant_1_signals_O_MEMORY_H[63:0]                     ), //i
    .signals_I_POS      (dtB_quant_1_signals_O_POS[11:0]                          ), //i
    .signals_I_T        (dtB_quant_1_signals_O_T                                  ), //i
    .signals_O_L_BEGIN  (exp_quant_1_signals_O_L_BEGIN[31:0]                      ), //o
    .signals_O_L_CLOSE  (exp_quant_1_signals_O_L_CLOSE[31:0]                      ), //o
    .signals_O_MEMORY_X (exp_quant_1_signals_O_MEMORY_X[63:0]                     ), //o
    .signals_O_MEMORY_W (exp_quant_1_signals_O_MEMORY_W[63:0]                     ), //o
    .signals_O_MEMORY_Y (exp_quant_1_signals_O_MEMORY_Y[63:0]                     ), //o
    .signals_O_MEMORY_C (exp_quant_1_signals_O_MEMORY_C[63:0]                     ), //o
    .signals_O_MEMORY_H (exp_quant_1_signals_O_MEMORY_H[63:0]                     ), //o
    .signals_O_POS      (exp_quant_1_signals_O_POS[11:0]                          ), //o
    .signals_O_T        (exp_quant_1_signals_O_T                                  ), //o
    .i_stream_TVALID    (inst_mamba_dtA_1_o_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (exp_quant_1_i_stream_TREADY                              ), //o
    .i_stream_TDATA     (inst_mamba_dtA_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .o_stream_TVALID    (exp_quant_1_o_stream_TVALID                              ), //o
    .o_stream_TREADY    (inst_mamba_exp_quant_1_o_stream_fifo_io_push_ready       ), //i
    .o_stream_TDATA     (exp_quant_1_o_stream_TDATA[63:0]                         ), //o
    .o_s_stream_TVALID  (exp_quant_1_o_s_stream_TVALID                            ), //o
    .o_s_stream_TREADY  (inst_mamba_exp_quant_1_o_s_stream_fifo_io_push_ready     ), //i
    .o_s_stream_TDATA   (exp_quant_1_o_s_stream_TDATA[7:0]                        )  //o
  );
  GEMM_wrapper gemm_1 (
    .resetn             (resetn                                                       ), //i
    .clk                (clk                                                          ), //i
    .signals_I_L_BEGIN  (exp_quant_1_signals_O_L_BEGIN[31:0]                          ), //i
    .signals_I_L_CLOSE  (exp_quant_1_signals_O_L_CLOSE[31:0]                          ), //i
    .signals_I_MEMORY_X (exp_quant_1_signals_O_MEMORY_X[63:0]                         ), //i
    .signals_I_MEMORY_W (exp_quant_1_signals_O_MEMORY_W[63:0]                         ), //i
    .signals_I_MEMORY_Y (exp_quant_1_signals_O_MEMORY_Y[63:0]                         ), //i
    .signals_I_MEMORY_C (exp_quant_1_signals_O_MEMORY_C[63:0]                         ), //i
    .signals_I_MEMORY_H (exp_quant_1_signals_O_MEMORY_H[63:0]                         ), //i
    .signals_I_POS      (exp_quant_1_signals_O_POS[11:0]                              ), //i
    .signals_I_T        (exp_quant_1_signals_O_T                                      ), //i
    .signals_O_L_BEGIN  (gemm_1_signals_O_L_BEGIN[31:0]                               ), //o
    .signals_O_L_CLOSE  (gemm_1_signals_O_L_CLOSE[31:0]                               ), //o
    .signals_O_MEMORY_X (gemm_1_signals_O_MEMORY_X[63:0]                              ), //o
    .signals_O_MEMORY_W (gemm_1_signals_O_MEMORY_W[63:0]                              ), //o
    .signals_O_MEMORY_Y (gemm_1_signals_O_MEMORY_Y[63:0]                              ), //o
    .signals_O_MEMORY_C (gemm_1_signals_O_MEMORY_C[63:0]                              ), //o
    .signals_O_MEMORY_H (gemm_1_signals_O_MEMORY_H[63:0]                              ), //o
    .signals_O_POS      (gemm_1_signals_O_POS[11:0]                                   ), //o
    .signals_O_T        (gemm_1_signals_O_T                                           ), //o
    .i_stream_TVALID    (inst_mamba_gemm_mux_1_q_stream_fifo_io_pop_valid             ), //i
    .i_stream_TREADY    (gemm_1_i_stream_TREADY                                       ), //o
    .i_stream_TDATA     (inst_mamba_gemm_mux_1_q_stream_fifo_io_pop_payload_data[31:0]), //i
    .w_stream_TVALID    (w_stream_fifo_io_pop_valid                                   ), //i
    .w_stream_TREADY    (gemm_1_w_stream_TREADY                                       ), //o
    .w_stream_TDATA     (w_stream_fifo_io_pop_payload_data[255:0]                     ), //i
    .s_stream_TVALID    (inst_mamba_gemm_mux_1_s_stream_fifo_io_pop_valid             ), //i
    .s_stream_TREADY    (gemm_1_s_stream_TREADY                                       ), //o
    .s_stream_TDATA     (inst_mamba_gemm_mux_1_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .s1_stream_TVALID   (s1_stream_fifo_io_pop_valid                                  ), //i
    .s1_stream_TREADY   (gemm_1_s1_stream_TREADY                                      ), //o
    .s1_stream_TDATA    (s1_stream_fifo_io_pop_payload_data[23:0]                     ), //i
    .s2_stream_TVALID   (s2_stream_fifo_io_pop_valid                                  ), //i
    .s2_stream_TREADY   (gemm_1_s2_stream_TREADY                                      ), //o
    .s2_stream_TDATA    (s2_stream_fifo_io_pop_payload_data[23:0]                     ), //i
    .o_stream_TVALID    (gemm_1_o_stream_TVALID                                       ), //o
    .o_stream_TREADY    (inst_mamba_gemm_1_o_stream_fifo_io_push_ready                ), //i
    .o_stream_TDATA     (gemm_1_o_stream_TDATA[255:0]                                 )  //o
  );
  GEMM_DEMUX_wrapper gemm_demux_1 (
    .resetn             (resetn                                                    ), //i
    .clk                (clk                                                       ), //i
    .signals_I_L_BEGIN  (gemm_1_signals_O_L_BEGIN[31:0]                            ), //i
    .signals_I_L_CLOSE  (gemm_1_signals_O_L_CLOSE[31:0]                            ), //i
    .signals_I_MEMORY_X (gemm_1_signals_O_MEMORY_X[63:0]                           ), //i
    .signals_I_MEMORY_W (gemm_1_signals_O_MEMORY_W[63:0]                           ), //i
    .signals_I_MEMORY_Y (gemm_1_signals_O_MEMORY_Y[63:0]                           ), //i
    .signals_I_MEMORY_C (gemm_1_signals_O_MEMORY_C[63:0]                           ), //i
    .signals_I_MEMORY_H (gemm_1_signals_O_MEMORY_H[63:0]                           ), //i
    .signals_I_POS      (gemm_1_signals_O_POS[11:0]                                ), //i
    .signals_I_T        (gemm_1_signals_O_T                                        ), //i
    .signals_O_L_BEGIN  (gemm_demux_1_signals_O_L_BEGIN[31:0]                      ), //o
    .signals_O_L_CLOSE  (gemm_demux_1_signals_O_L_CLOSE[31:0]                      ), //o
    .signals_O_MEMORY_X (gemm_demux_1_signals_O_MEMORY_X[63:0]                     ), //o
    .signals_O_MEMORY_W (gemm_demux_1_signals_O_MEMORY_W[63:0]                     ), //o
    .signals_O_MEMORY_Y (gemm_demux_1_signals_O_MEMORY_Y[63:0]                     ), //o
    .signals_O_MEMORY_C (gemm_demux_1_signals_O_MEMORY_C[63:0]                     ), //o
    .signals_O_MEMORY_H (gemm_demux_1_signals_O_MEMORY_H[63:0]                     ), //o
    .signals_O_POS      (gemm_demux_1_signals_O_POS[11:0]                          ), //o
    .signals_O_T        (gemm_demux_1_signals_O_T                                  ), //o
    .gemm_stream_TVALID (inst_mamba_gemm_1_o_stream_fifo_io_pop_valid              ), //i
    .gemm_stream_TREADY (gemm_demux_1_gemm_stream_TREADY                           ), //o
    .gemm_stream_TDATA  (inst_mamba_gemm_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .dt_stream_TVALID   (gemm_demux_1_dt_stream_TVALID                             ), //o
    .dt_stream_TREADY   (inst_mamba_gemm_demux_1_dt_stream_fifo_io_push_ready      ), //i
    .dt_stream_TDATA    (gemm_demux_1_dt_stream_TDATA[255:0]                       ), //o
    .xBC_stream_TVALID  (gemm_demux_1_xBC_stream_TVALID                            ), //o
    .xBC_stream_TREADY  (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_push_ready     ), //i
    .xBC_stream_TDATA   (gemm_demux_1_xBC_stream_TDATA[255:0]                      ), //o
    .z_stream_TVALID    (gemm_demux_1_z_stream_TVALID                              ), //o
    .z_stream_TREADY    (inst_mamba_gemm_demux_1_z_stream_fifo_io_push_ready       ), //i
    .z_stream_TDATA     (gemm_demux_1_z_stream_TDATA[255:0]                        ), //o
    .out_stream_TVALID  (gemm_demux_1_out_stream_TVALID                            ), //o
    .out_stream_TREADY  (inst_mamba_gemm_demux_1_out_stream_fifo_io_push_ready     ), //i
    .out_stream_TDATA   (gemm_demux_1_out_stream_TDATA[255:0]                      )  //o
  );
  GEMM_MUX_wrapper gemm_mux_1 (
    .resetn              (resetn                                                           ), //i
    .clk                 (clk                                                              ), //i
    .signals_I_L_BEGIN   (gemm_demux_1_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE   (gemm_demux_1_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X  (gemm_demux_1_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W  (gemm_demux_1_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y  (gemm_demux_1_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C  (gemm_demux_1_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H  (gemm_demux_1_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS       (gemm_demux_1_signals_O_POS[11:0]                                 ), //i
    .signals_I_T         (gemm_demux_1_signals_O_T                                         ), //i
    .signals_O_L_BEGIN   (gemm_mux_1_signals_O_L_BEGIN[31:0]                               ), //o
    .signals_O_L_CLOSE   (gemm_mux_1_signals_O_L_CLOSE[31:0]                               ), //o
    .signals_O_MEMORY_X  (gemm_mux_1_signals_O_MEMORY_X[63:0]                              ), //o
    .signals_O_MEMORY_W  (gemm_mux_1_signals_O_MEMORY_W[63:0]                              ), //o
    .signals_O_MEMORY_Y  (gemm_mux_1_signals_O_MEMORY_Y[63:0]                              ), //o
    .signals_O_MEMORY_C  (gemm_mux_1_signals_O_MEMORY_C[63:0]                              ), //o
    .signals_O_MEMORY_H  (gemm_mux_1_signals_O_MEMORY_H[63:0]                              ), //o
    .signals_O_POS       (gemm_mux_1_signals_O_POS[11:0]                                   ), //o
    .signals_O_T         (gemm_mux_1_signals_O_T                                           ), //o
    .xlnq1_stream_TVALID (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_pop_valid             ), //i
    .xlnq1_stream_TREADY (gemm_mux_1_xlnq1_stream_TREADY                                   ), //o
    .xlnq1_stream_TDATA  (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_pop_payload_data[31:0]), //i
    .xlns1_stream_TVALID (inst_mamba_rms_quant_1_xlns_stream_fifo_io_pop_valid             ), //i
    .xlns1_stream_TREADY (gemm_mux_1_xlns1_stream_TREADY                                   ), //o
    .xlns1_stream_TDATA  (inst_mamba_rms_quant_1_xlns_stream_fifo_io_pop_payload_data[7:0] ), //i
    .xlnq2_stream_TVALID (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_pop_valid             ), //i
    .xlnq2_stream_TREADY (gemm_mux_1_xlnq2_stream_TREADY                                   ), //o
    .xlnq2_stream_TDATA  (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_pop_payload_data[31:0]), //i
    .xlns2_stream_TVALID (inst_mamba_rms_quant_2_xlns_stream_fifo_io_pop_valid             ), //i
    .xlns2_stream_TREADY (gemm_mux_1_xlns2_stream_TREADY                                   ), //o
    .xlns2_stream_TDATA  (inst_mamba_rms_quant_2_xlns_stream_fifo_io_pop_payload_data[7:0] ), //i
    .q_stream_TVALID     (gemm_mux_1_q_stream_TVALID                                       ), //o
    .q_stream_TREADY     (inst_mamba_gemm_mux_1_q_stream_fifo_io_push_ready                ), //i
    .q_stream_TDATA      (gemm_mux_1_q_stream_TDATA[31:0]                                  ), //o
    .s_stream_TVALID     (gemm_mux_1_s_stream_TVALID                                       ), //o
    .s_stream_TREADY     (inst_mamba_gemm_mux_1_s_stream_fifo_io_push_ready                ), //i
    .s_stream_TDATA      (gemm_mux_1_s_stream_TDATA[7:0]                                   )  //o
  );
  HT_ADD_QUANT_wrapper ht_add_quant_1 (
    .resetn              (resetn                                                   ), //i
    .clk                 (clk                                                      ), //i
    .signals_I_L_BEGIN   (gemm_mux_1_signals_O_L_BEGIN[31:0]                       ), //i
    .signals_I_L_CLOSE   (gemm_mux_1_signals_O_L_CLOSE[31:0]                       ), //i
    .signals_I_MEMORY_X  (gemm_mux_1_signals_O_MEMORY_X[63:0]                      ), //i
    .signals_I_MEMORY_W  (gemm_mux_1_signals_O_MEMORY_W[63:0]                      ), //i
    .signals_I_MEMORY_Y  (gemm_mux_1_signals_O_MEMORY_Y[63:0]                      ), //i
    .signals_I_MEMORY_C  (gemm_mux_1_signals_O_MEMORY_C[63:0]                      ), //i
    .signals_I_MEMORY_H  (gemm_mux_1_signals_O_MEMORY_H[63:0]                      ), //i
    .signals_I_POS       (gemm_mux_1_signals_O_POS[11:0]                           ), //i
    .signals_I_T         (gemm_mux_1_signals_O_T                                   ), //i
    .signals_O_L_BEGIN   (ht_add_quant_1_signals_O_L_BEGIN[31:0]                   ), //o
    .signals_O_L_CLOSE   (ht_add_quant_1_signals_O_L_CLOSE[31:0]                   ), //o
    .signals_O_MEMORY_X  (ht_add_quant_1_signals_O_MEMORY_X[63:0]                  ), //o
    .signals_O_MEMORY_W  (ht_add_quant_1_signals_O_MEMORY_W[63:0]                  ), //o
    .signals_O_MEMORY_Y  (ht_add_quant_1_signals_O_MEMORY_Y[63:0]                  ), //o
    .signals_O_MEMORY_C  (ht_add_quant_1_signals_O_MEMORY_C[63:0]                  ), //o
    .signals_O_MEMORY_H  (ht_add_quant_1_signals_O_MEMORY_H[63:0]                  ), //o
    .signals_O_POS       (ht_add_quant_1_signals_O_POS[11:0]                       ), //o
    .signals_O_T         (ht_add_quant_1_signals_O_T                               ), //o
    .dAh_stream_TVALID   (inst_mamba_dAh_1_o_stream_fifo_io_pop_valid              ), //i
    .dAh_stream_TREADY   (ht_add_quant_1_dAh_stream_TREADY                         ), //o
    .dAh_stream_TDATA    (inst_mamba_dAh_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .dBu_stream_TVALID   (inst_mamba_dBu_1_o_stream_fifo_io_pop_valid              ), //i
    .dBu_stream_TREADY   (ht_add_quant_1_dBu_stream_TREADY                         ), //o
    .dBu_stream_TDATA    (inst_mamba_dBu_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .ht1_q_stream_TVALID (ht_add_quant_1_ht1_q_stream_TVALID                       ), //o
    .ht1_q_stream_TREADY (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_push_ready), //i
    .ht1_q_stream_TDATA  (ht_add_quant_1_ht1_q_stream_TDATA[63:0]                  ), //o
    .ht1_s_stream_TVALID (ht_add_quant_1_ht1_s_stream_TVALID                       ), //o
    .ht1_s_stream_TREADY (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_push_ready), //i
    .ht1_s_stream_TDATA  (ht_add_quant_1_ht1_s_stream_TDATA[7:0]                   ), //o
    .ht2_q_stream_TVALID (ht_add_quant_1_ht2_q_stream_TVALID                       ), //o
    .ht2_q_stream_TREADY (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_push_ready), //i
    .ht2_q_stream_TDATA  (ht_add_quant_1_ht2_q_stream_TDATA[63:0]                  ), //o
    .ht2_s_stream_TVALID (ht_add_quant_1_ht2_s_stream_TVALID                       ), //o
    .ht2_s_stream_TREADY (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_push_ready), //i
    .ht2_s_stream_TDATA  (ht_add_quant_1_ht2_s_stream_TDATA[7:0]                   )  //o
  );
  HT_STATE_wrapper ht_state_1 (
    .resetn                    (resetn                                                               ), //i
    .clk                       (clk                                                                  ), //i
    .signals_I_L_BEGIN         (ht_add_quant_1_signals_O_L_BEGIN[31:0]                               ), //i
    .signals_I_L_CLOSE         (ht_add_quant_1_signals_O_L_CLOSE[31:0]                               ), //i
    .signals_I_MEMORY_X        (ht_add_quant_1_signals_O_MEMORY_X[63:0]                              ), //i
    .signals_I_MEMORY_W        (ht_add_quant_1_signals_O_MEMORY_W[63:0]                              ), //i
    .signals_I_MEMORY_Y        (ht_add_quant_1_signals_O_MEMORY_Y[63:0]                              ), //i
    .signals_I_MEMORY_C        (ht_add_quant_1_signals_O_MEMORY_C[63:0]                              ), //i
    .signals_I_MEMORY_H        (ht_add_quant_1_signals_O_MEMORY_H[63:0]                              ), //i
    .signals_I_POS             (ht_add_quant_1_signals_O_POS[11:0]                                   ), //i
    .signals_I_T               (ht_add_quant_1_signals_O_T                                           ), //i
    .signals_O_L_BEGIN         (ht_state_1_signals_O_L_BEGIN[31:0]                                   ), //o
    .signals_O_L_CLOSE         (ht_state_1_signals_O_L_CLOSE[31:0]                                   ), //o
    .signals_O_MEMORY_X        (ht_state_1_signals_O_MEMORY_X[63:0]                                  ), //o
    .signals_O_MEMORY_W        (ht_state_1_signals_O_MEMORY_W[63:0]                                  ), //o
    .signals_O_MEMORY_Y        (ht_state_1_signals_O_MEMORY_Y[63:0]                                  ), //o
    .signals_O_MEMORY_C        (ht_state_1_signals_O_MEMORY_C[63:0]                                  ), //o
    .signals_O_MEMORY_H        (ht_state_1_signals_O_MEMORY_H[63:0]                                  ), //o
    .signals_O_POS             (ht_state_1_signals_O_POS[11:0]                                       ), //o
    .signals_O_T               (ht_state_1_signals_O_T                                               ), //o
    .state_in_stream_TVALID    (hq_stream_fifo_io_pop_valid                                          ), //i
    .state_in_stream_TREADY    (ht_state_1_state_in_stream_TREADY                                    ), //o
    .state_in_stream_TDATA     (hq_stream_fifo_io_pop_payload_data[255:0]                            ), //i
    .state_in_s_stream_TVALID  (hs_stream_fifo_io_pop_valid                                          ), //i
    .state_in_s_stream_TREADY  (ht_state_1_state_in_s_stream_TREADY                                  ), //o
    .state_in_s_stream_TDATA   (hs_stream_fifo_io_pop_payload_data[255:0]                            ), //i
    .ht_in_stream_TVALID       (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_pop_valid             ), //i
    .ht_in_stream_TREADY       (ht_state_1_ht_in_stream_TREADY                                       ), //o
    .ht_in_stream_TDATA        (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_pop_payload_data[63:0]), //i
    .ht_in_s_stream_TVALID     (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_pop_valid             ), //i
    .ht_in_s_stream_TREADY     (ht_state_1_ht_in_s_stream_TREADY                                     ), //o
    .ht_in_s_stream_TDATA      (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .ht_out_stream_TVALID      (ht_state_1_ht_out_stream_TVALID                                      ), //o
    .ht_out_stream_TREADY      (inst_mamba_ht_state_1_ht_out_stream_fifo_io_push_ready               ), //i
    .ht_out_stream_TDATA       (ht_state_1_ht_out_stream_TDATA[63:0]                                 ), //o
    .ht_out_s_stream_TVALID    (ht_state_1_ht_out_s_stream_TVALID                                    ), //o
    .ht_out_s_stream_TREADY    (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_push_ready             ), //i
    .ht_out_s_stream_TDATA     (ht_state_1_ht_out_s_stream_TDATA[7:0]                                ), //o
    .state_out_stream_TVALID   (ht_state_1_state_out_stream_TVALID                                   ), //o
    .state_out_stream_TREADY   (inst_mamba_ht_state_1_state_out_stream_fifo_io_push_ready            ), //i
    .state_out_stream_TDATA    (ht_state_1_state_out_stream_TDATA[255:0]                             ), //o
    .state_out_s_stream_TVALID (ht_state_1_state_out_s_stream_TVALID                                 ), //o
    .state_out_s_stream_TREADY (inst_mamba_ht_state_1_state_out_s_stream_fifo_io_push_ready          ), //i
    .state_out_s_stream_TDATA  (ht_state_1_state_out_s_stream_TDATA[255:0]                           )  //o
  );
  HTC_QUANT_wrapper htC_quant_1 (
    .resetn             (resetn                                                               ), //i
    .clk                (clk                                                                  ), //i
    .signals_I_L_BEGIN  (ht_state_1_signals_O_L_BEGIN[31:0]                                   ), //i
    .signals_I_L_CLOSE  (ht_state_1_signals_O_L_CLOSE[31:0]                                   ), //i
    .signals_I_MEMORY_X (ht_state_1_signals_O_MEMORY_X[63:0]                                  ), //i
    .signals_I_MEMORY_W (ht_state_1_signals_O_MEMORY_W[63:0]                                  ), //i
    .signals_I_MEMORY_Y (ht_state_1_signals_O_MEMORY_Y[63:0]                                  ), //i
    .signals_I_MEMORY_C (ht_state_1_signals_O_MEMORY_C[63:0]                                  ), //i
    .signals_I_MEMORY_H (ht_state_1_signals_O_MEMORY_H[63:0]                                  ), //i
    .signals_I_POS      (ht_state_1_signals_O_POS[11:0]                                       ), //i
    .signals_I_T        (ht_state_1_signals_O_T                                               ), //i
    .signals_O_L_BEGIN  (htC_quant_1_signals_O_L_BEGIN[31:0]                                  ), //o
    .signals_O_L_CLOSE  (htC_quant_1_signals_O_L_CLOSE[31:0]                                  ), //o
    .signals_O_MEMORY_X (htC_quant_1_signals_O_MEMORY_X[63:0]                                 ), //o
    .signals_O_MEMORY_W (htC_quant_1_signals_O_MEMORY_W[63:0]                                 ), //o
    .signals_O_MEMORY_Y (htC_quant_1_signals_O_MEMORY_Y[63:0]                                 ), //o
    .signals_O_MEMORY_C (htC_quant_1_signals_O_MEMORY_C[63:0]                                 ), //o
    .signals_O_MEMORY_H (htC_quant_1_signals_O_MEMORY_H[63:0]                                 ), //o
    .signals_O_POS      (htC_quant_1_signals_O_POS[11:0]                                      ), //o
    .signals_O_T        (htC_quant_1_signals_O_T                                              ), //o
    .ht_stream_TVALID   (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_pop_valid             ), //i
    .ht_stream_TREADY   (htC_quant_1_ht_stream_TREADY                                         ), //o
    .ht_stream_TDATA    (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_pop_payload_data[63:0]), //i
    .ht_s_stream_TVALID (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_pop_valid             ), //i
    .ht_s_stream_TREADY (htC_quant_1_ht_s_stream_TREADY                                       ), //o
    .ht_s_stream_TDATA  (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .C_stream_TVALID    (inst_mamba_C_buffer_1_q_stream_fifo_io_pop_valid                     ), //i
    .C_stream_TREADY    (htC_quant_1_C_stream_TREADY                                          ), //o
    .C_stream_TDATA     (inst_mamba_C_buffer_1_q_stream_fifo_io_pop_payload_data[63:0]        ), //i
    .C_s_stream_TVALID  (inst_mamba_C_buffer_1_s_stream_fifo_io_pop_valid                     ), //i
    .C_s_stream_TREADY  (htC_quant_1_C_s_stream_TREADY                                        ), //o
    .C_s_stream_TDATA   (inst_mamba_C_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]         ), //i
    .uD_stream_TVALID   (inst_mamba_ud_1_o_stream_fifo_io_pop_valid                           ), //i
    .uD_stream_TREADY   (htC_quant_1_uD_stream_TREADY                                         ), //o
    .uD_stream_TDATA    (inst_mamba_ud_1_o_stream_fifo_io_pop_payload_data[255:0]             ), //i
    .o_q_stream_TVALID  (htC_quant_1_o_q_stream_TVALID                                        ), //o
    .o_q_stream_TREADY  (inst_mamba_htC_quant_1_o_q_stream_fifo_io_push_ready                 ), //i
    .o_q_stream_TDATA   (htC_quant_1_o_q_stream_TDATA[63:0]                                   ), //o
    .o_s_stream_TVALID  (htC_quant_1_o_s_stream_TVALID                                        ), //o
    .o_s_stream_TREADY  (inst_mamba_htC_quant_1_o_s_stream_fifo_io_push_ready                 ), //i
    .o_s_stream_TDATA   (htC_quant_1_o_s_stream_TDATA[7:0]                                    )  //o
  );
  QUANT_CONV_wrapper quant_conv_1 (
    .resetn             (resetn                                                            ), //i
    .clk                (clk                                                               ), //i
    .signals_I_L_BEGIN  (htC_quant_1_signals_O_L_BEGIN[31:0]                               ), //i
    .signals_I_L_CLOSE  (htC_quant_1_signals_O_L_CLOSE[31:0]                               ), //i
    .signals_I_MEMORY_X (htC_quant_1_signals_O_MEMORY_X[63:0]                              ), //i
    .signals_I_MEMORY_W (htC_quant_1_signals_O_MEMORY_W[63:0]                              ), //i
    .signals_I_MEMORY_Y (htC_quant_1_signals_O_MEMORY_Y[63:0]                              ), //i
    .signals_I_MEMORY_C (htC_quant_1_signals_O_MEMORY_C[63:0]                              ), //i
    .signals_I_MEMORY_H (htC_quant_1_signals_O_MEMORY_H[63:0]                              ), //i
    .signals_I_POS      (htC_quant_1_signals_O_POS[11:0]                                   ), //i
    .signals_I_T        (htC_quant_1_signals_O_T                                           ), //i
    .signals_O_L_BEGIN  (quant_conv_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE  (quant_conv_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X (quant_conv_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W (quant_conv_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y (quant_conv_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C (quant_conv_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H (quant_conv_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS      (quant_conv_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T        (quant_conv_1_signals_O_T                                          ), //o
    .i_stream_TVALID    (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (quant_conv_1_i_stream_TREADY                                      ), //o
    .i_stream_TDATA     (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_pop_payload_data[255:0]), //i
    .o_stream_TVALID    (quant_conv_1_o_stream_TVALID                                      ), //o
    .o_stream_TREADY    (inst_mamba_quant_conv_1_o_stream_fifo_io_push_ready               ), //i
    .o_stream_TDATA     (quant_conv_1_o_stream_TDATA[63:0]                                 ), //o
    .o_s_stream_TVALID  (quant_conv_1_o_s_stream_TVALID                                    ), //o
    .o_s_stream_TREADY  (inst_mamba_quant_conv_1_o_s_stream_fifo_io_push_ready             ), //i
    .o_s_stream_TDATA   (quant_conv_1_o_s_stream_TDATA[7:0]                                )  //o
  );
  RESIDUAL_wrapper residual_1 (
    .resetn              (resetn                                                            ), //i
    .clk                 (clk                                                               ), //i
    .signals_I_L_BEGIN   (quant_conv_1_signals_O_L_BEGIN[31:0]                              ), //i
    .signals_I_L_CLOSE   (quant_conv_1_signals_O_L_CLOSE[31:0]                              ), //i
    .signals_I_MEMORY_X  (quant_conv_1_signals_O_MEMORY_X[63:0]                             ), //i
    .signals_I_MEMORY_W  (quant_conv_1_signals_O_MEMORY_W[63:0]                             ), //i
    .signals_I_MEMORY_Y  (quant_conv_1_signals_O_MEMORY_Y[63:0]                             ), //i
    .signals_I_MEMORY_C  (quant_conv_1_signals_O_MEMORY_C[63:0]                             ), //i
    .signals_I_MEMORY_H  (quant_conv_1_signals_O_MEMORY_H[63:0]                             ), //i
    .signals_I_POS       (quant_conv_1_signals_O_POS[11:0]                                  ), //i
    .signals_I_T         (quant_conv_1_signals_O_T                                          ), //i
    .signals_O_L_BEGIN   (residual_1_signals_O_L_BEGIN[31:0]                                ), //o
    .signals_O_L_CLOSE   (residual_1_signals_O_L_CLOSE[31:0]                                ), //o
    .signals_O_MEMORY_X  (residual_1_signals_O_MEMORY_X[63:0]                               ), //o
    .signals_O_MEMORY_W  (residual_1_signals_O_MEMORY_W[63:0]                               ), //o
    .signals_O_MEMORY_Y  (residual_1_signals_O_MEMORY_Y[63:0]                               ), //o
    .signals_O_MEMORY_C  (residual_1_signals_O_MEMORY_C[63:0]                               ), //o
    .signals_O_MEMORY_H  (residual_1_signals_O_MEMORY_H[63:0]                               ), //o
    .signals_O_POS       (residual_1_signals_O_POS[11:0]                                    ), //o
    .signals_O_T         (residual_1_signals_O_T                                            ), //o
    .x_stream_TVALID     (x_stream_fifo_io_pop_valid                                        ), //i
    .x_stream_TREADY     (residual_1_x_stream_TREADY                                        ), //o
    .x_stream_TDATA      (x_stream_fifo_io_pop_payload_data[255:0]                          ), //i
    .res_i_stream_TVALID (inst_mamba_gemm_demux_1_out_stream_fifo_io_pop_valid              ), //i
    .res_i_stream_TREADY (residual_1_res_i_stream_TREADY                                    ), //o
    .res_i_stream_TDATA  (inst_mamba_gemm_demux_1_out_stream_fifo_io_pop_payload_data[255:0]), //i
    .res_o_stream_TVALID (residual_1_res_o_stream_TVALID                                    ), //o
    .res_o_stream_TREADY (inst_mamba_residual_1_res_o_stream_fifo_io_push_ready             ), //i
    .res_o_stream_TDATA  (residual_1_res_o_stream_TDATA[255:0]                              ), //o
    .y_stream_TVALID     (residual_1_y_stream_TVALID                                        ), //o
    .y_stream_TREADY     (inst_mamba_residual_1_y_stream_fifo_io_push_ready                 ), //i
    .y_stream_TDATA      (residual_1_y_stream_TDATA[255:0]                                  )  //o
  );
  RMSNORM_QUANT_1_wrapper rms_quant_1 (
    .resetn             (resetn                                                            ), //i
    .clk                (clk                                                               ), //i
    .signals_I_L_BEGIN  (residual_1_signals_O_L_BEGIN[31:0]                                ), //i
    .signals_I_L_CLOSE  (residual_1_signals_O_L_CLOSE[31:0]                                ), //i
    .signals_I_MEMORY_X (residual_1_signals_O_MEMORY_X[63:0]                               ), //i
    .signals_I_MEMORY_W (residual_1_signals_O_MEMORY_W[63:0]                               ), //i
    .signals_I_MEMORY_Y (residual_1_signals_O_MEMORY_Y[63:0]                               ), //i
    .signals_I_MEMORY_C (residual_1_signals_O_MEMORY_C[63:0]                               ), //i
    .signals_I_MEMORY_H (residual_1_signals_O_MEMORY_H[63:0]                               ), //i
    .signals_I_POS      (residual_1_signals_O_POS[11:0]                                    ), //i
    .signals_I_T        (residual_1_signals_O_T                                            ), //i
    .signals_O_L_BEGIN  (rms_quant_1_signals_O_L_BEGIN[31:0]                               ), //o
    .signals_O_L_CLOSE  (rms_quant_1_signals_O_L_CLOSE[31:0]                               ), //o
    .signals_O_MEMORY_X (rms_quant_1_signals_O_MEMORY_X[63:0]                              ), //o
    .signals_O_MEMORY_W (rms_quant_1_signals_O_MEMORY_W[63:0]                              ), //o
    .signals_O_MEMORY_Y (rms_quant_1_signals_O_MEMORY_Y[63:0]                              ), //o
    .signals_O_MEMORY_C (rms_quant_1_signals_O_MEMORY_C[63:0]                              ), //o
    .signals_O_MEMORY_H (rms_quant_1_signals_O_MEMORY_H[63:0]                              ), //o
    .signals_O_POS      (rms_quant_1_signals_O_POS[11:0]                                   ), //o
    .signals_O_T        (rms_quant_1_signals_O_T                                           ), //o
    .x_stream_TVALID    (inst_mamba_residual_1_res_o_stream_fifo_io_pop_valid              ), //i
    .x_stream_TREADY    (rms_quant_1_x_stream_TREADY                                       ), //o
    .x_stream_TDATA     (inst_mamba_residual_1_res_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .xlnq_stream_TVALID (rms_quant_1_xlnq_stream_TVALID                                    ), //o
    .xlnq_stream_TREADY (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_push_ready             ), //i
    .xlnq_stream_TDATA  (rms_quant_1_xlnq_stream_TDATA[31:0]                               ), //o
    .xlns_stream_TVALID (rms_quant_1_xlns_stream_TVALID                                    ), //o
    .xlns_stream_TREADY (inst_mamba_rms_quant_1_xlns_stream_fifo_io_push_ready             ), //i
    .xlns_stream_TDATA  (rms_quant_1_xlns_stream_TDATA[7:0]                                )  //o
  );
  RMSNORM_QUANT_2_wrapper rms_quant_2 (
    .resetn             (resetn                                                  ), //i
    .clk                (clk                                                     ), //i
    .signals_I_L_BEGIN  (rms_quant_1_signals_O_L_BEGIN[31:0]                     ), //i
    .signals_I_L_CLOSE  (rms_quant_1_signals_O_L_CLOSE[31:0]                     ), //i
    .signals_I_MEMORY_X (rms_quant_1_signals_O_MEMORY_X[63:0]                    ), //i
    .signals_I_MEMORY_W (rms_quant_1_signals_O_MEMORY_W[63:0]                    ), //i
    .signals_I_MEMORY_Y (rms_quant_1_signals_O_MEMORY_Y[63:0]                    ), //i
    .signals_I_MEMORY_C (rms_quant_1_signals_O_MEMORY_C[63:0]                    ), //i
    .signals_I_MEMORY_H (rms_quant_1_signals_O_MEMORY_H[63:0]                    ), //i
    .signals_I_POS      (rms_quant_1_signals_O_POS[11:0]                         ), //i
    .signals_I_T        (rms_quant_1_signals_O_T                                 ), //i
    .signals_O_L_BEGIN  (rms_quant_2_signals_O_L_BEGIN[31:0]                     ), //o
    .signals_O_L_CLOSE  (rms_quant_2_signals_O_L_CLOSE[31:0]                     ), //o
    .signals_O_MEMORY_X (rms_quant_2_signals_O_MEMORY_X[63:0]                    ), //o
    .signals_O_MEMORY_W (rms_quant_2_signals_O_MEMORY_W[63:0]                    ), //o
    .signals_O_MEMORY_Y (rms_quant_2_signals_O_MEMORY_Y[63:0]                    ), //o
    .signals_O_MEMORY_C (rms_quant_2_signals_O_MEMORY_C[63:0]                    ), //o
    .signals_O_MEMORY_H (rms_quant_2_signals_O_MEMORY_H[63:0]                    ), //o
    .signals_O_POS      (rms_quant_2_signals_O_POS[11:0]                         ), //o
    .signals_O_T        (rms_quant_2_signals_O_T                                 ), //o
    .x_stream_TVALID    (inst_mamba_yz_1_o_stream_fifo_io_pop_valid              ), //i
    .x_stream_TREADY    (rms_quant_2_x_stream_TREADY                             ), //o
    .x_stream_TDATA     (inst_mamba_yz_1_o_stream_fifo_io_pop_payload_data[255:0]), //i
    .xlnq_stream_TVALID (rms_quant_2_xlnq_stream_TVALID                          ), //o
    .xlnq_stream_TREADY (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_push_ready   ), //i
    .xlnq_stream_TDATA  (rms_quant_2_xlnq_stream_TDATA[31:0]                     ), //o
    .xlns_stream_TVALID (rms_quant_2_xlns_stream_TVALID                          ), //o
    .xlns_stream_TREADY (inst_mamba_rms_quant_2_xlns_stream_fifo_io_push_ready   ), //i
    .xlns_stream_TDATA  (rms_quant_2_xlns_stream_TDATA[7:0]                      )  //o
  );
  SILU_DEMUX_wrapper silu_demux_1 (
    .resetn               (resetn                                                            ), //i
    .clk                  (clk                                                               ), //i
    .signals_I_L_BEGIN    (rms_quant_2_signals_O_L_BEGIN[31:0]                               ), //i
    .signals_I_L_CLOSE    (rms_quant_2_signals_O_L_CLOSE[31:0]                               ), //i
    .signals_I_MEMORY_X   (rms_quant_2_signals_O_MEMORY_X[63:0]                              ), //i
    .signals_I_MEMORY_W   (rms_quant_2_signals_O_MEMORY_W[63:0]                              ), //i
    .signals_I_MEMORY_Y   (rms_quant_2_signals_O_MEMORY_Y[63:0]                              ), //i
    .signals_I_MEMORY_C   (rms_quant_2_signals_O_MEMORY_C[63:0]                              ), //i
    .signals_I_MEMORY_H   (rms_quant_2_signals_O_MEMORY_H[63:0]                              ), //i
    .signals_I_POS        (rms_quant_2_signals_O_POS[11:0]                                   ), //i
    .signals_I_T          (rms_quant_2_signals_O_T                                           ), //i
    .signals_O_L_BEGIN    (silu_demux_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE    (silu_demux_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X   (silu_demux_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W   (silu_demux_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y   (silu_demux_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C   (silu_demux_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H   (silu_demux_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS        (silu_demux_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T          (silu_demux_1_signals_O_T                                          ), //o
    .silu_stream_TVALID   (inst_mamba_silu_quant_1_out_stream_fifo_io_pop_valid              ), //i
    .silu_stream_TREADY   (silu_demux_1_silu_stream_TREADY                                   ), //o
    .silu_stream_TDATA    (inst_mamba_silu_quant_1_out_stream_fifo_io_pop_payload_data[63:0] ), //i
    .silu_s_stream_TVALID (inst_mamba_silu_quant_1_out_s_stream_fifo_io_pop_valid            ), //i
    .silu_s_stream_TREADY (silu_demux_1_silu_s_stream_TREADY                                 ), //o
    .silu_s_stream_TDATA  (inst_mamba_silu_quant_1_out_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .x_stream_TVALID      (silu_demux_1_x_stream_TVALID                                      ), //o
    .x_stream_TREADY      (inst_mamba_silu_demux_1_x_stream_fifo_io_push_ready               ), //i
    .x_stream_TDATA       (silu_demux_1_x_stream_TDATA[63:0]                                 ), //o
    .x_s_stream_TVALID    (silu_demux_1_x_s_stream_TVALID                                    ), //o
    .x_s_stream_TREADY    (inst_mamba_silu_demux_1_x_s_stream_fifo_io_push_ready             ), //i
    .x_s_stream_TDATA     (silu_demux_1_x_s_stream_TDATA[7:0]                                ), //o
    .x_stream2_TVALID     (silu_demux_1_x_stream2_TVALID                                     ), //o
    .x_stream2_TREADY     (inst_mamba_silu_demux_1_x_stream2_fifo_io_push_ready              ), //i
    .x_stream2_TDATA      (silu_demux_1_x_stream2_TDATA[63:0]                                ), //o
    .x_s_stream2_TVALID   (silu_demux_1_x_s_stream2_TVALID                                   ), //o
    .x_s_stream2_TREADY   (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_push_ready            ), //i
    .x_s_stream2_TDATA    (silu_demux_1_x_s_stream2_TDATA[7:0]                               ), //o
    .B_stream_TVALID      (silu_demux_1_B_stream_TVALID                                      ), //o
    .B_stream_TREADY      (inst_mamba_silu_demux_1_B_stream_fifo_io_push_ready               ), //i
    .B_stream_TDATA       (silu_demux_1_B_stream_TDATA[63:0]                                 ), //o
    .B_s_stream_TVALID    (silu_demux_1_B_s_stream_TVALID                                    ), //o
    .B_s_stream_TREADY    (inst_mamba_silu_demux_1_B_s_stream_fifo_io_push_ready             ), //i
    .B_s_stream_TDATA     (silu_demux_1_B_s_stream_TDATA[7:0]                                ), //o
    .C_stream_TVALID      (silu_demux_1_C_stream_TVALID                                      ), //o
    .C_stream_TREADY      (inst_mamba_silu_demux_1_C_stream_fifo_io_push_ready               ), //i
    .C_stream_TDATA       (silu_demux_1_C_stream_TDATA[63:0]                                 ), //o
    .C_s_stream_TVALID    (silu_demux_1_C_s_stream_TVALID                                    ), //o
    .C_s_stream_TREADY    (inst_mamba_silu_demux_1_C_s_stream_fifo_io_push_ready             ), //i
    .C_s_stream_TDATA     (silu_demux_1_C_s_stream_TDATA[7:0]                                ), //o
    .z_stream_TVALID      (silu_demux_1_z_stream_TVALID                                      ), //o
    .z_stream_TREADY      (inst_mamba_silu_demux_1_z_stream_fifo_io_push_ready               ), //i
    .z_stream_TDATA       (silu_demux_1_z_stream_TDATA[63:0]                                 ), //o
    .z_s_stream_TVALID    (silu_demux_1_z_s_stream_TVALID                                    ), //o
    .z_s_stream_TREADY    (inst_mamba_silu_demux_1_z_s_stream_fifo_io_push_ready             ), //i
    .z_s_stream_TDATA     (silu_demux_1_z_s_stream_TDATA[7:0]                                )  //o
  );
  SILU_MUX_wrapper silu_mux_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (silu_demux_1_signals_O_L_BEGIN[31:0]                            ), //i
    .signals_I_L_CLOSE  (silu_demux_1_signals_O_L_CLOSE[31:0]                            ), //i
    .signals_I_MEMORY_X (silu_demux_1_signals_O_MEMORY_X[63:0]                           ), //i
    .signals_I_MEMORY_W (silu_demux_1_signals_O_MEMORY_W[63:0]                           ), //i
    .signals_I_MEMORY_Y (silu_demux_1_signals_O_MEMORY_Y[63:0]                           ), //i
    .signals_I_MEMORY_C (silu_demux_1_signals_O_MEMORY_C[63:0]                           ), //i
    .signals_I_MEMORY_H (silu_demux_1_signals_O_MEMORY_H[63:0]                           ), //i
    .signals_I_POS      (silu_demux_1_signals_O_POS[11:0]                                ), //i
    .signals_I_T        (silu_demux_1_signals_O_T                                        ), //i
    .signals_O_L_BEGIN  (silu_mux_1_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE  (silu_mux_1_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X (silu_mux_1_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W (silu_mux_1_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y (silu_mux_1_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C (silu_mux_1_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H (silu_mux_1_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS      (silu_mux_1_signals_O_POS[11:0]                                  ), //o
    .signals_O_T        (silu_mux_1_signals_O_T                                          ), //o
    .xBC_stream_TVALID  (inst_mamba_conv_1_o_stream_fifo_io_pop_valid                    ), //i
    .xBC_stream_TREADY  (silu_mux_1_xBC_stream_TREADY                                    ), //o
    .xBC_stream_TDATA   (inst_mamba_conv_1_o_stream_fifo_io_pop_payload_data[255:0]      ), //i
    .z_stream_TVALID    (inst_mamba_gemm_demux_1_z_stream_fifo_io_pop_valid              ), //i
    .z_stream_TREADY    (silu_mux_1_z_stream_TREADY                                      ), //o
    .z_stream_TDATA     (inst_mamba_gemm_demux_1_z_stream_fifo_io_pop_payload_data[255:0]), //i
    .silu_stream_TVALID (silu_mux_1_silu_stream_TVALID                                   ), //o
    .silu_stream_TREADY (inst_mamba_silu_mux_1_silu_stream_fifo_io_push_ready            ), //i
    .silu_stream_TDATA  (silu_mux_1_silu_stream_TDATA[255:0]                             )  //o
  );
  SILU_QUANT_wrapper silu_quant_1 (
    .resetn              (resetn                                                           ), //i
    .clk                 (clk                                                              ), //i
    .signals_I_L_BEGIN   (silu_mux_1_signals_O_L_BEGIN[31:0]                               ), //i
    .signals_I_L_CLOSE   (silu_mux_1_signals_O_L_CLOSE[31:0]                               ), //i
    .signals_I_MEMORY_X  (silu_mux_1_signals_O_MEMORY_X[63:0]                              ), //i
    .signals_I_MEMORY_W  (silu_mux_1_signals_O_MEMORY_W[63:0]                              ), //i
    .signals_I_MEMORY_Y  (silu_mux_1_signals_O_MEMORY_Y[63:0]                              ), //i
    .signals_I_MEMORY_C  (silu_mux_1_signals_O_MEMORY_C[63:0]                              ), //i
    .signals_I_MEMORY_H  (silu_mux_1_signals_O_MEMORY_H[63:0]                              ), //i
    .signals_I_POS       (silu_mux_1_signals_O_POS[11:0]                                   ), //i
    .signals_I_T         (silu_mux_1_signals_O_T                                           ), //i
    .signals_O_L_BEGIN   (silu_quant_1_signals_O_L_BEGIN[31:0]                             ), //o
    .signals_O_L_CLOSE   (silu_quant_1_signals_O_L_CLOSE[31:0]                             ), //o
    .signals_O_MEMORY_X  (silu_quant_1_signals_O_MEMORY_X[63:0]                            ), //o
    .signals_O_MEMORY_W  (silu_quant_1_signals_O_MEMORY_W[63:0]                            ), //o
    .signals_O_MEMORY_Y  (silu_quant_1_signals_O_MEMORY_Y[63:0]                            ), //o
    .signals_O_MEMORY_C  (silu_quant_1_signals_O_MEMORY_C[63:0]                            ), //o
    .signals_O_MEMORY_H  (silu_quant_1_signals_O_MEMORY_H[63:0]                            ), //o
    .signals_O_POS       (silu_quant_1_signals_O_POS[11:0]                                 ), //o
    .signals_O_T         (silu_quant_1_signals_O_T                                         ), //o
    .i_stream_TVALID     (inst_mamba_silu_mux_1_silu_stream_fifo_io_pop_valid              ), //i
    .i_stream_TREADY     (silu_quant_1_i_stream_TREADY                                     ), //o
    .i_stream_TDATA      (inst_mamba_silu_mux_1_silu_stream_fifo_io_pop_payload_data[255:0]), //i
    .out_stream_TVALID   (silu_quant_1_out_stream_TVALID                                   ), //o
    .out_stream_TREADY   (inst_mamba_silu_quant_1_out_stream_fifo_io_push_ready            ), //i
    .out_stream_TDATA    (silu_quant_1_out_stream_TDATA[63:0]                              ), //o
    .out_s_stream_TVALID (silu_quant_1_out_s_stream_TVALID                                 ), //o
    .out_s_stream_TREADY (inst_mamba_silu_quant_1_out_s_stream_fifo_io_push_ready          ), //i
    .out_s_stream_TDATA  (silu_quant_1_out_s_stream_TDATA[7:0]                             )  //o
  );
  UD_wrapper ud_1 (
    .resetn             (resetn                                                           ), //i
    .clk                (clk                                                              ), //i
    .signals_I_L_BEGIN  (silu_quant_1_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE  (silu_quant_1_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X (silu_quant_1_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W (silu_quant_1_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y (silu_quant_1_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C (silu_quant_1_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H (silu_quant_1_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS      (silu_quant_1_signals_O_POS[11:0]                                 ), //i
    .signals_I_T        (silu_quant_1_signals_O_T                                         ), //i
    .signals_O_L_BEGIN  (ud_1_signals_O_L_BEGIN[31:0]                                     ), //o
    .signals_O_L_CLOSE  (ud_1_signals_O_L_CLOSE[31:0]                                     ), //o
    .signals_O_MEMORY_X (ud_1_signals_O_MEMORY_X[63:0]                                    ), //o
    .signals_O_MEMORY_W (ud_1_signals_O_MEMORY_W[63:0]                                    ), //o
    .signals_O_MEMORY_Y (ud_1_signals_O_MEMORY_Y[63:0]                                    ), //o
    .signals_O_MEMORY_C (ud_1_signals_O_MEMORY_C[63:0]                                    ), //o
    .signals_O_MEMORY_H (ud_1_signals_O_MEMORY_H[63:0]                                    ), //o
    .signals_O_POS      (ud_1_signals_O_POS[11:0]                                         ), //o
    .signals_O_T        (ud_1_signals_O_T                                                 ), //o
    .i_stream_TVALID    (inst_mamba_silu_demux_1_x_stream2_fifo_io_pop_valid              ), //i
    .i_stream_TREADY    (ud_1_i_stream_TREADY                                             ), //o
    .i_stream_TDATA     (inst_mamba_silu_demux_1_x_stream2_fifo_io_pop_payload_data[63:0] ), //i
    .s_stream_TVALID    (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_pop_valid            ), //i
    .s_stream_TREADY    (ud_1_s_stream_TREADY                                             ), //o
    .s_stream_TDATA     (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (ud_1_o_stream_TVALID                                             ), //o
    .o_stream_TREADY    (inst_mamba_ud_1_o_stream_fifo_io_push_ready                      ), //i
    .o_stream_TDATA     (ud_1_o_stream_TDATA[255:0]                                       )  //o
  );
  YZ_wrapper yz_1 (
    .resetn             (resetn                                                          ), //i
    .clk                (clk                                                             ), //i
    .signals_I_L_BEGIN  (ud_1_signals_O_L_BEGIN[31:0]                                    ), //i
    .signals_I_L_CLOSE  (ud_1_signals_O_L_CLOSE[31:0]                                    ), //i
    .signals_I_MEMORY_X (ud_1_signals_O_MEMORY_X[63:0]                                   ), //i
    .signals_I_MEMORY_W (ud_1_signals_O_MEMORY_W[63:0]                                   ), //i
    .signals_I_MEMORY_Y (ud_1_signals_O_MEMORY_Y[63:0]                                   ), //i
    .signals_I_MEMORY_C (ud_1_signals_O_MEMORY_C[63:0]                                   ), //i
    .signals_I_MEMORY_H (ud_1_signals_O_MEMORY_H[63:0]                                   ), //i
    .signals_I_POS      (ud_1_signals_O_POS[11:0]                                        ), //i
    .signals_I_T        (ud_1_signals_O_T                                                ), //i
    .signals_O_L_BEGIN  (yz_1_signals_O_L_BEGIN[31:0]                                    ), //o
    .signals_O_L_CLOSE  (yz_1_signals_O_L_CLOSE[31:0]                                    ), //o
    .signals_O_MEMORY_X (yz_1_signals_O_MEMORY_X[63:0]                                   ), //o
    .signals_O_MEMORY_W (yz_1_signals_O_MEMORY_W[63:0]                                   ), //o
    .signals_O_MEMORY_Y (yz_1_signals_O_MEMORY_Y[63:0]                                   ), //o
    .signals_O_MEMORY_C (yz_1_signals_O_MEMORY_C[63:0]                                   ), //o
    .signals_O_MEMORY_H (yz_1_signals_O_MEMORY_H[63:0]                                   ), //o
    .signals_O_POS      (yz_1_signals_O_POS[11:0]                                        ), //o
    .signals_O_T        (yz_1_signals_O_T                                                ), //o
    .y_stream_TVALID    (inst_mamba_htC_quant_1_o_q_stream_fifo_io_pop_valid             ), //i
    .y_stream_TREADY    (yz_1_y_stream_TREADY                                            ), //o
    .y_stream_TDATA     (inst_mamba_htC_quant_1_o_q_stream_fifo_io_pop_payload_data[63:0]), //i
    .y_s_stream_TVALID  (inst_mamba_htC_quant_1_o_s_stream_fifo_io_pop_valid             ), //i
    .y_s_stream_TREADY  (yz_1_y_s_stream_TREADY                                          ), //o
    .y_s_stream_TDATA   (inst_mamba_htC_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0] ), //i
    .z_stream_TVALID    (inst_mamba_silu_demux_1_z_stream_fifo_io_pop_valid              ), //i
    .z_stream_TREADY    (yz_1_z_stream_TREADY                                            ), //o
    .z_stream_TDATA     (inst_mamba_silu_demux_1_z_stream_fifo_io_pop_payload_data[63:0] ), //i
    .z_s_stream_TVALID  (inst_mamba_silu_demux_1_z_s_stream_fifo_io_pop_valid            ), //i
    .z_s_stream_TREADY  (yz_1_z_s_stream_TREADY                                          ), //o
    .z_s_stream_TDATA   (inst_mamba_silu_demux_1_z_s_stream_fifo_io_pop_payload_data[7:0]), //i
    .o_stream_TVALID    (yz_1_o_stream_TVALID                                            ), //o
    .o_stream_TREADY    (inst_mamba_yz_1_o_stream_fifo_io_push_ready                     ), //i
    .o_stream_TDATA     (yz_1_o_stream_TDATA[255:0]                                      )  //o
  );
  StreamFifo_30 x_stream_fifo (
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
  StreamFifo_30 w_stream_fifo (
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
  StreamFifo_32 s1_stream_fifo (
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
  StreamFifo_32 s2_stream_fifo (
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
  StreamFifo_30 cq_stream_fifo (
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
  StreamFifo_30 cs_stream_fifo (
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
  StreamFifo_30 hq_stream_fifo (
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
  StreamFifo_30 hs_stream_fifo (
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
  StreamFifo_38 inst_mamba_B_buffer_1_q_stream_fifo (
    .io_push_valid        (B_buffer_1_q_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_B_buffer_1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (B_buffer_1_q_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_B_buffer_1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dtB_quant_1_B_stream_TREADY                                  ), //i
    .io_pop_payload_data  (inst_mamba_B_buffer_1_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_B_buffer_1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_B_buffer_1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_B_buffer_1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_39 inst_mamba_B_buffer_1_s_stream_fifo (
    .io_push_valid        (B_buffer_1_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_B_buffer_1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (B_buffer_1_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_B_buffer_1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dtB_quant_1_B_s_stream_TREADY                               ), //i
    .io_pop_payload_data  (inst_mamba_B_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_B_buffer_1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_B_buffer_1_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_B_buffer_1_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_38 inst_mamba_C_buffer_1_q_stream_fifo (
    .io_push_valid        (C_buffer_1_q_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_C_buffer_1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (C_buffer_1_q_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_C_buffer_1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (htC_quant_1_C_stream_TREADY                                  ), //i
    .io_pop_payload_data  (inst_mamba_C_buffer_1_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_C_buffer_1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_C_buffer_1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_C_buffer_1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_39 inst_mamba_C_buffer_1_s_stream_fifo (
    .io_push_valid        (C_buffer_1_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_C_buffer_1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (C_buffer_1_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_C_buffer_1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (htC_quant_1_C_s_stream_TREADY                               ), //i
    .io_pop_payload_data  (inst_mamba_C_buffer_1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_C_buffer_1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_C_buffer_1_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_C_buffer_1_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_30 inst_mamba_conv_1_o_stream_fifo (
    .io_push_valid        (conv_1_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_conv_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (conv_1_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_conv_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (silu_mux_1_xBC_stream_TREADY                              ), //i
    .io_pop_payload_data  (inst_mamba_conv_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_conv_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_conv_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_conv_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                       ), //i
    .resetn               (resetn                                                    )  //i
  );
  StreamFifo_38 inst_mamba_conv_state_1_o_stream_fifo (
    .io_push_valid        (conv_state_1_o_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_conv_state_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (conv_state_1_o_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_conv_state_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (conv_1_i_stream_TREADY                                         ), //i
    .io_pop_payload_data  (inst_mamba_conv_state_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_conv_state_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_conv_state_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_conv_state_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_39 inst_mamba_conv_state_1_o_s_stream_fifo (
    .io_push_valid        (conv_state_1_o_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_conv_state_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (conv_state_1_o_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_conv_state_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (conv_1_s_stream_TREADY                                          ), //i
    .io_pop_payload_data  (inst_mamba_conv_state_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_conv_state_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_conv_state_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_conv_state_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_38 inst_mamba_conv_state_1_w_stream_fifo (
    .io_push_valid        (conv_state_1_w_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_conv_state_1_w_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (conv_state_1_w_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_conv_state_1_w_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (conv_1_w_stream_TREADY                                         ), //i
    .io_pop_payload_data  (inst_mamba_conv_state_1_w_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_conv_state_1_w_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_conv_state_1_w_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_conv_state_1_w_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_39 inst_mamba_conv_state_1_w_s_stream_fifo (
    .io_push_valid        (conv_state_1_w_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_conv_state_1_w_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (conv_state_1_w_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_conv_state_1_w_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (conv_1_w_s_stream_TREADY                                        ), //i
    .io_pop_payload_data  (inst_mamba_conv_state_1_w_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_conv_state_1_w_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_conv_state_1_w_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_conv_state_1_w_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_30 inst_mamba_conv_state_1_conv_state_stream_fifo (
    .io_push_valid        (conv_state_1_conv_state_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_conv_state_1_conv_state_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (conv_state_1_conv_state_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_conv_state_1_conv_state_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cq2_stream_TREADY                                                        ), //i
    .io_pop_payload_data  (inst_mamba_conv_state_1_conv_state_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_conv_state_1_conv_state_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_conv_state_1_conv_state_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_conv_state_1_conv_state_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                      ), //i
    .resetn               (resetn                                                                   )  //i
  );
  StreamFifo_30 inst_mamba_conv_state_1_conv_state_s_stream_fifo (
    .io_push_valid        (conv_state_1_conv_state_s_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (conv_state_1_conv_state_s_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cs2_stream_TREADY                                                          ), //i
    .io_pop_payload_data  (inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                        ), //i
    .resetn               (resetn                                                                     )  //i
  );
  StreamFifo_30 inst_mamba_dAh_1_o_stream_fifo (
    .io_push_valid        (dAh_1_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_dAh_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (dAh_1_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_dAh_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (ht_add_quant_1_dAh_stream_TREADY                         ), //i
    .io_pop_payload_data  (inst_mamba_dAh_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_dAh_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_dAh_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_dAh_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                      ), //i
    .resetn               (resetn                                                   )  //i
  );
  StreamFifo_30 inst_mamba_dBu_1_o_stream_fifo (
    .io_push_valid        (dBu_1_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_dBu_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (dBu_1_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_dBu_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (ht_add_quant_1_dBu_stream_TREADY                         ), //i
    .io_pop_payload_data  (inst_mamba_dBu_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_dBu_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_dBu_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_dBu_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                      ), //i
    .resetn               (resetn                                                   )  //i
  );
  StreamFifo_30 inst_mamba_dtA_1_o_stream_fifo (
    .io_push_valid        (dtA_1_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_dtA_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (dtA_1_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_dtA_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (exp_quant_1_i_stream_TREADY                              ), //i
    .io_pop_payload_data  (inst_mamba_dtA_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_dtA_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_dtA_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_dtA_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                      ), //i
    .resetn               (resetn                                                   )  //i
  );
  StreamFifo_38 inst_mamba_dtadapt_1_o_stream_fifo (
    .io_push_valid        (dtadapt_1_o_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_dtadapt_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (dtadapt_1_o_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_dtadapt_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dtA_1_i_stream_TREADY                                       ), //i
    .io_pop_payload_data  (inst_mamba_dtadapt_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_dtadapt_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_dtadapt_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_dtadapt_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_39 inst_mamba_dtadapt_1_o_s_stream_fifo (
    .io_push_valid        (dtadapt_1_o_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_dtadapt_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (dtadapt_1_o_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_dtadapt_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dtA_1_s_stream_TREADY                                        ), //i
    .io_pop_payload_data  (inst_mamba_dtadapt_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_dtadapt_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_dtadapt_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_dtadapt_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_38 inst_mamba_dtadapt_1_o_stream2_fifo (
    .io_push_valid        (dtadapt_1_o_stream2_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_dtadapt_1_o_stream2_fifo_io_push_ready            ), //o
    .io_push_payload_data (dtadapt_1_o_stream2_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_dtadapt_1_o_stream2_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dtB_quant_1_dt_stream_TREADY                                 ), //i
    .io_pop_payload_data  (inst_mamba_dtadapt_1_o_stream2_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_dtadapt_1_o_stream2_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_dtadapt_1_o_stream2_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_dtadapt_1_o_stream2_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_39 inst_mamba_dtadapt_1_o_s_stream2_fifo (
    .io_push_valid        (dtadapt_1_o_s_stream2_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_push_ready           ), //o
    .io_push_payload_data (dtadapt_1_o_s_stream2_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dtB_quant_1_dt_s_stream_TREADY                                ), //i
    .io_pop_payload_data  (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_dtadapt_1_o_s_stream2_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_38 inst_mamba_dtB_quant_1_o_stream_fifo (
    .io_push_valid        (dtB_quant_1_o_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_dtB_quant_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (dtB_quant_1_o_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_dtB_quant_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dBu_1_dB_stream_TREADY                                        ), //i
    .io_pop_payload_data  (inst_mamba_dtB_quant_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_dtB_quant_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_dtB_quant_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_dtB_quant_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_39 inst_mamba_dtB_quant_1_o_s_stream_fifo (
    .io_push_valid        (dtB_quant_1_o_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (dtB_quant_1_o_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dBu_1_dB_s_stream_TREADY                                       ), //i
    .io_pop_payload_data  (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_dtB_quant_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_38 inst_mamba_exp_quant_1_o_stream_fifo (
    .io_push_valid        (exp_quant_1_o_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_exp_quant_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (exp_quant_1_o_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_exp_quant_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dAh_1_dA_stream_TREADY                                        ), //i
    .io_pop_payload_data  (inst_mamba_exp_quant_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_exp_quant_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_exp_quant_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_exp_quant_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_39 inst_mamba_exp_quant_1_o_s_stream_fifo (
    .io_push_valid        (exp_quant_1_o_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_exp_quant_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (exp_quant_1_o_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_exp_quant_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dAh_1_dA_s_stream_TREADY                                       ), //i
    .io_pop_payload_data  (inst_mamba_exp_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_exp_quant_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_exp_quant_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_exp_quant_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_30 inst_mamba_gemm_1_o_stream_fifo (
    .io_push_valid        (gemm_1_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_gemm_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_1_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_gemm_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (gemm_demux_1_gemm_stream_TREADY                           ), //i
    .io_pop_payload_data  (inst_mamba_gemm_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_gemm_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_gemm_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_gemm_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                       ), //i
    .resetn               (resetn                                                    )  //i
  );
  StreamFifo_30 inst_mamba_gemm_demux_1_dt_stream_fifo (
    .io_push_valid        (gemm_demux_1_dt_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_gemm_demux_1_dt_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_dt_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_gemm_demux_1_dt_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (dtadapt_1_i_stream_TREADY                                        ), //i
    .io_pop_payload_data  (inst_mamba_gemm_demux_1_dt_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_gemm_demux_1_dt_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_gemm_demux_1_dt_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_gemm_demux_1_dt_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_30 inst_mamba_gemm_demux_1_xBC_stream_fifo (
    .io_push_valid        (gemm_demux_1_xBC_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_xBC_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (quant_conv_1_i_stream_TREADY                                      ), //i
    .io_pop_payload_data  (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_gemm_demux_1_xBC_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                               ), //i
    .resetn               (resetn                                                            )  //i
  );
  StreamFifo_30 inst_mamba_gemm_demux_1_z_stream_fifo (
    .io_push_valid        (gemm_demux_1_z_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_gemm_demux_1_z_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_z_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_gemm_demux_1_z_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (silu_mux_1_z_stream_TREADY                                      ), //i
    .io_pop_payload_data  (inst_mamba_gemm_demux_1_z_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_gemm_demux_1_z_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_gemm_demux_1_z_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_gemm_demux_1_z_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_30 inst_mamba_gemm_demux_1_out_stream_fifo (
    .io_push_valid        (gemm_demux_1_out_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_gemm_demux_1_out_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (gemm_demux_1_out_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_gemm_demux_1_out_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (residual_1_res_i_stream_TREADY                                    ), //i
    .io_pop_payload_data  (inst_mamba_gemm_demux_1_out_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_gemm_demux_1_out_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_gemm_demux_1_out_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_gemm_demux_1_out_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                               ), //i
    .resetn               (resetn                                                            )  //i
  );
  StreamFifo_65 inst_mamba_gemm_mux_1_q_stream_fifo (
    .io_push_valid        (gemm_mux_1_q_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_gemm_mux_1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (gemm_mux_1_q_stream_TDATA[31:0]                              ), //i
    .io_pop_valid         (inst_mamba_gemm_mux_1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_1_i_stream_TREADY                                       ), //i
    .io_pop_payload_data  (inst_mamba_gemm_mux_1_q_stream_fifo_io_pop_payload_data[31:0]), //o
    .io_flush             (inst_mamba_gemm_mux_1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_gemm_mux_1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_gemm_mux_1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_66 inst_mamba_gemm_mux_1_s_stream_fifo (
    .io_push_valid        (gemm_mux_1_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_gemm_mux_1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (gemm_mux_1_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_gemm_mux_1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (gemm_1_s_stream_TREADY                                      ), //i
    .io_pop_payload_data  (inst_mamba_gemm_mux_1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_gemm_mux_1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_gemm_mux_1_s_stream_fifo_io_occupancy[9:0]       ), //o
    .io_availability      (inst_mamba_gemm_mux_1_s_stream_fifo_io_availability[9:0]    ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_38 inst_mamba_ht_add_quant_1_ht1_q_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht1_q_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (ht_add_quant_1_ht1_q_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ht_state_1_ht_in_stream_TREADY                                       ), //i
    .io_pop_payload_data  (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                                  ), //i
    .resetn               (resetn                                                               )  //i
  );
  StreamFifo_39 inst_mamba_ht_add_quant_1_ht1_s_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht1_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (ht_add_quant_1_ht1_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (ht_state_1_ht_in_s_stream_TREADY                                    ), //i
    .io_pop_payload_data  (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                                 ), //i
    .resetn               (resetn                                                              )  //i
  );
  StreamFifo_38 inst_mamba_ht_add_quant_1_ht2_q_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht2_q_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (ht_add_quant_1_ht2_q_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (htC_quant_1_ht_stream_TREADY                                         ), //i
    .io_pop_payload_data  (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                                  ), //i
    .resetn               (resetn                                                               )  //i
  );
  StreamFifo_39 inst_mamba_ht_add_quant_1_ht2_s_stream_fifo (
    .io_push_valid        (ht_add_quant_1_ht2_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (ht_add_quant_1_ht2_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (htC_quant_1_ht_s_stream_TREADY                                      ), //i
    .io_pop_payload_data  (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                                 ), //i
    .resetn               (resetn                                                              )  //i
  );
  StreamFifo_71 inst_mamba_ht_state_1_ht_out_stream_fifo (
    .io_push_valid        (ht_state_1_ht_out_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_ht_state_1_ht_out_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (ht_state_1_ht_out_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_state_1_ht_out_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dAh_1_ht_stream_TREADY                                            ), //i
    .io_pop_payload_data  (inst_mamba_ht_state_1_ht_out_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_ht_state_1_ht_out_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_ht_state_1_ht_out_stream_fifo_io_occupancy[6:0]        ), //o
    .io_availability      (inst_mamba_ht_state_1_ht_out_stream_fifo_io_availability[6:0]     ), //o
    .clk                  (clk                                                               ), //i
    .resetn               (resetn                                                            )  //i
  );
  StreamFifo_72 inst_mamba_ht_state_1_ht_out_s_stream_fifo (
    .io_push_valid        (ht_state_1_ht_out_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (ht_state_1_ht_out_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dAh_1_ht_s_stream_TREADY                                           ), //i
    .io_pop_payload_data  (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_occupancy[6:0]       ), //o
    .io_availability      (inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_availability[6:0]    ), //o
    .clk                  (clk                                                                ), //i
    .resetn               (resetn                                                             )  //i
  );
  StreamFifo_30 inst_mamba_ht_state_1_state_out_stream_fifo (
    .io_push_valid        (ht_state_1_state_out_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_ht_state_1_state_out_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (ht_state_1_state_out_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_state_1_state_out_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hq2_stream_TREADY                                                     ), //i
    .io_pop_payload_data  (inst_mamba_ht_state_1_state_out_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_ht_state_1_state_out_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_ht_state_1_state_out_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_ht_state_1_state_out_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                   ), //i
    .resetn               (resetn                                                                )  //i
  );
  StreamFifo_30 inst_mamba_ht_state_1_state_out_s_stream_fifo (
    .io_push_valid        (ht_state_1_state_out_s_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_ht_state_1_state_out_s_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (ht_state_1_state_out_s_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_ht_state_1_state_out_s_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hs2_stream_TREADY                                                       ), //i
    .io_pop_payload_data  (inst_mamba_ht_state_1_state_out_s_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_ht_state_1_state_out_s_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_ht_state_1_state_out_s_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_ht_state_1_state_out_s_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                                     ), //i
    .resetn               (resetn                                                                  )  //i
  );
  StreamFifo_38 inst_mamba_htC_quant_1_o_q_stream_fifo (
    .io_push_valid        (htC_quant_1_o_q_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_htC_quant_1_o_q_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (htC_quant_1_o_q_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_htC_quant_1_o_q_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (yz_1_y_stream_TREADY                                            ), //i
    .io_pop_payload_data  (inst_mamba_htC_quant_1_o_q_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_htC_quant_1_o_q_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_htC_quant_1_o_q_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_htC_quant_1_o_q_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_39 inst_mamba_htC_quant_1_o_s_stream_fifo (
    .io_push_valid        (htC_quant_1_o_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_htC_quant_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (htC_quant_1_o_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_htC_quant_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (yz_1_y_s_stream_TREADY                                         ), //i
    .io_pop_payload_data  (inst_mamba_htC_quant_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_htC_quant_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_htC_quant_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_htC_quant_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_38 inst_mamba_quant_conv_1_o_stream_fifo (
    .io_push_valid        (quant_conv_1_o_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_quant_conv_1_o_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (quant_conv_1_o_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_quant_conv_1_o_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (conv_state_1_xBC_stream_TREADY                                 ), //i
    .io_pop_payload_data  (inst_mamba_quant_conv_1_o_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_quant_conv_1_o_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_quant_conv_1_o_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_quant_conv_1_o_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_39 inst_mamba_quant_conv_1_o_s_stream_fifo (
    .io_push_valid        (quant_conv_1_o_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_quant_conv_1_o_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (quant_conv_1_o_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_quant_conv_1_o_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (conv_state_1_xBC_s_stream_TREADY                                ), //i
    .io_pop_payload_data  (inst_mamba_quant_conv_1_o_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_quant_conv_1_o_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_quant_conv_1_o_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_quant_conv_1_o_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_30 inst_mamba_residual_1_res_o_stream_fifo (
    .io_push_valid        (residual_1_res_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_residual_1_res_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (residual_1_res_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_residual_1_res_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (rms_quant_1_x_stream_TREADY                                       ), //i
    .io_pop_payload_data  (inst_mamba_residual_1_res_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_residual_1_res_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_residual_1_res_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_residual_1_res_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                               ), //i
    .resetn               (resetn                                                            )  //i
  );
  StreamFifo_30 inst_mamba_residual_1_y_stream_fifo (
    .io_push_valid        (residual_1_y_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_residual_1_y_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (residual_1_y_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_residual_1_y_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (y_stream_TREADY                                               ), //i
    .io_pop_payload_data  (inst_mamba_residual_1_y_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_residual_1_y_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_residual_1_y_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_residual_1_y_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_65 inst_mamba_rms_quant_1_xlnq_stream_fifo (
    .io_push_valid        (rms_quant_1_xlnq_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (rms_quant_1_xlnq_stream_TDATA[31:0]                              ), //i
    .io_pop_valid         (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_mux_1_xlnq1_stream_TREADY                                   ), //i
    .io_pop_payload_data  (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_pop_payload_data[31:0]), //o
    .io_flush             (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_rms_quant_1_xlnq_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_39 inst_mamba_rms_quant_1_xlns_stream_fifo (
    .io_push_valid        (rms_quant_1_xlns_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_rms_quant_1_xlns_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (rms_quant_1_xlns_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_rms_quant_1_xlns_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (gemm_mux_1_xlns1_stream_TREADY                                  ), //i
    .io_pop_payload_data  (inst_mamba_rms_quant_1_xlns_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_rms_quant_1_xlns_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_rms_quant_1_xlns_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_rms_quant_1_xlns_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_65 inst_mamba_rms_quant_2_xlnq_stream_fifo (
    .io_push_valid        (rms_quant_2_xlnq_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (rms_quant_2_xlnq_stream_TDATA[31:0]                              ), //i
    .io_pop_valid         (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (gemm_mux_1_xlnq2_stream_TREADY                                   ), //i
    .io_pop_payload_data  (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_pop_payload_data[31:0]), //o
    .io_flush             (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_rms_quant_2_xlnq_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_39 inst_mamba_rms_quant_2_xlns_stream_fifo (
    .io_push_valid        (rms_quant_2_xlns_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_rms_quant_2_xlns_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (rms_quant_2_xlns_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_rms_quant_2_xlns_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (gemm_mux_1_xlns2_stream_TREADY                                  ), //i
    .io_pop_payload_data  (inst_mamba_rms_quant_2_xlns_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_rms_quant_2_xlns_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_rms_quant_2_xlns_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_rms_quant_2_xlns_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_38 inst_mamba_silu_demux_1_x_stream_fifo (
    .io_push_valid        (silu_demux_1_x_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_x_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_x_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_x_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (dBu_1_u_stream_TREADY                                          ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_x_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_x_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_x_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_silu_demux_1_x_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_39 inst_mamba_silu_demux_1_x_s_stream_fifo (
    .io_push_valid        (silu_demux_1_x_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_x_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_x_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_x_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (dBu_1_u_s_stream_TREADY                                         ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_x_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_x_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_x_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_silu_demux_1_x_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_38 inst_mamba_silu_demux_1_x_stream2_fifo (
    .io_push_valid        (silu_demux_1_x_stream2_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_x_stream2_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_x_stream2_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_x_stream2_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ud_1_i_stream_TREADY                                            ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_x_stream2_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_x_stream2_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_x_stream2_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_silu_demux_1_x_stream2_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_39 inst_mamba_silu_demux_1_x_s_stream2_fifo (
    .io_push_valid        (silu_demux_1_x_s_stream2_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_x_s_stream2_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_pop_valid            ), //o
    .io_pop_ready         (ud_1_s_stream_TREADY                                             ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_silu_demux_1_x_s_stream2_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_38 inst_mamba_silu_demux_1_B_stream_fifo (
    .io_push_valid        (silu_demux_1_B_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_B_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_B_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_B_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (B_buffer_1_i_stream_TREADY                                     ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_B_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_B_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_B_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_silu_demux_1_B_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_39 inst_mamba_silu_demux_1_B_s_stream_fifo (
    .io_push_valid        (silu_demux_1_B_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_B_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_B_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_B_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (B_buffer_1_i_s_stream_TREADY                                    ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_B_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_B_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_B_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_silu_demux_1_B_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_38 inst_mamba_silu_demux_1_C_stream_fifo (
    .io_push_valid        (silu_demux_1_C_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_C_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_C_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_C_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (C_buffer_1_i_stream_TREADY                                     ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_C_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_C_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_C_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_silu_demux_1_C_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_39 inst_mamba_silu_demux_1_C_s_stream_fifo (
    .io_push_valid        (silu_demux_1_C_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_C_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_C_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_C_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (C_buffer_1_i_s_stream_TREADY                                    ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_C_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_C_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_C_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_silu_demux_1_C_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_38 inst_mamba_silu_demux_1_z_stream_fifo (
    .io_push_valid        (silu_demux_1_z_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_z_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_demux_1_z_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_z_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (yz_1_z_stream_TREADY                                           ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_z_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_z_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_z_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_silu_demux_1_z_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_39 inst_mamba_silu_demux_1_z_s_stream_fifo (
    .io_push_valid        (silu_demux_1_z_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_silu_demux_1_z_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_demux_1_z_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_demux_1_z_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (yz_1_z_s_stream_TREADY                                          ), //i
    .io_pop_payload_data  (inst_mamba_silu_demux_1_z_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_silu_demux_1_z_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_silu_demux_1_z_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_silu_demux_1_z_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                             ), //i
    .resetn               (resetn                                                          )  //i
  );
  StreamFifo_30 inst_mamba_silu_mux_1_silu_stream_fifo (
    .io_push_valid        (silu_mux_1_silu_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_silu_mux_1_silu_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (silu_mux_1_silu_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_mux_1_silu_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (silu_quant_1_i_stream_TREADY                                     ), //i
    .io_pop_payload_data  (inst_mamba_silu_mux_1_silu_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_silu_mux_1_silu_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_silu_mux_1_silu_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_silu_mux_1_silu_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_38 inst_mamba_silu_quant_1_out_stream_fifo (
    .io_push_valid        (silu_quant_1_out_stream_TVALID                                   ), //i
    .io_push_ready        (inst_mamba_silu_quant_1_out_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (silu_quant_1_out_stream_TDATA[63:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_quant_1_out_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (silu_demux_1_silu_stream_TREADY                                  ), //i
    .io_pop_payload_data  (inst_mamba_silu_quant_1_out_stream_fifo_io_pop_payload_data[63:0]), //o
    .io_flush             (inst_mamba_silu_quant_1_out_stream_fifo_io_flush                 ), //i
    .io_occupancy         (inst_mamba_silu_quant_1_out_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (inst_mamba_silu_quant_1_out_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                              ), //i
    .resetn               (resetn                                                           )  //i
  );
  StreamFifo_39 inst_mamba_silu_quant_1_out_s_stream_fifo (
    .io_push_valid        (silu_quant_1_out_s_stream_TVALID                                  ), //i
    .io_push_ready        (inst_mamba_silu_quant_1_out_s_stream_fifo_io_push_ready           ), //o
    .io_push_payload_data (silu_quant_1_out_s_stream_TDATA[7:0]                              ), //i
    .io_pop_valid         (inst_mamba_silu_quant_1_out_s_stream_fifo_io_pop_valid            ), //o
    .io_pop_ready         (silu_demux_1_silu_s_stream_TREADY                                 ), //i
    .io_pop_payload_data  (inst_mamba_silu_quant_1_out_s_stream_fifo_io_pop_payload_data[7:0]), //o
    .io_flush             (inst_mamba_silu_quant_1_out_s_stream_fifo_io_flush                ), //i
    .io_occupancy         (inst_mamba_silu_quant_1_out_s_stream_fifo_io_occupancy[3:0]       ), //o
    .io_availability      (inst_mamba_silu_quant_1_out_s_stream_fifo_io_availability[3:0]    ), //o
    .clk                  (clk                                                               ), //i
    .resetn               (resetn                                                            )  //i
  );
  StreamFifo_30 inst_mamba_ud_1_o_stream_fifo (
    .io_push_valid        (ud_1_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_ud_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (ud_1_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_ud_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (htC_quant_1_uD_stream_TREADY                            ), //i
    .io_pop_payload_data  (inst_mamba_ud_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_ud_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_ud_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_ud_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                     ), //i
    .resetn               (resetn                                                  )  //i
  );
  StreamFifo_30 inst_mamba_yz_1_o_stream_fifo (
    .io_push_valid        (yz_1_o_stream_TVALID                                    ), //i
    .io_push_ready        (inst_mamba_yz_1_o_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (yz_1_o_stream_TDATA[255:0]                              ), //i
    .io_pop_valid         (inst_mamba_yz_1_o_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (rms_quant_2_x_stream_TREADY                             ), //i
    .io_pop_payload_data  (inst_mamba_yz_1_o_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (inst_mamba_yz_1_o_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_mamba_yz_1_o_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (inst_mamba_yz_1_o_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                     ), //i
    .resetn               (resetn                                                  )  //i
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
  assign cq2_stream_TVALID = inst_mamba_conv_state_1_conv_state_stream_fifo_io_pop_valid;
  assign cq2_stream_TDATA = inst_mamba_conv_state_1_conv_state_stream_fifo_io_pop_payload_data;
  assign cs2_stream_TVALID = inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_pop_valid;
  assign cs2_stream_TDATA = inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_pop_payload_data;
  assign hq2_stream_TVALID = inst_mamba_ht_state_1_state_out_stream_fifo_io_pop_valid;
  assign hq2_stream_TDATA = inst_mamba_ht_state_1_state_out_stream_fifo_io_pop_payload_data;
  assign hs2_stream_TVALID = inst_mamba_ht_state_1_state_out_s_stream_fifo_io_pop_valid;
  assign hs2_stream_TDATA = inst_mamba_ht_state_1_state_out_s_stream_fifo_io_pop_payload_data;
  assign y_stream_TVALID = inst_mamba_residual_1_y_stream_fifo_io_pop_valid;
  assign y_stream_TDATA = inst_mamba_residual_1_y_stream_fifo_io_pop_payload_data;
  assign x_stream_fifo_io_flush = 1'b0;
  assign w_stream_fifo_io_flush = 1'b0;
  assign s1_stream_fifo_io_flush = 1'b0;
  assign s2_stream_fifo_io_flush = 1'b0;
  assign cq_stream_fifo_io_flush = 1'b0;
  assign cs_stream_fifo_io_flush = 1'b0;
  assign hq_stream_fifo_io_flush = 1'b0;
  assign hs_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_B_buffer_1_q_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_B_buffer_1_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_C_buffer_1_q_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_C_buffer_1_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_conv_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_conv_state_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_conv_state_1_o_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_conv_state_1_w_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_conv_state_1_w_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_conv_state_1_conv_state_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_conv_state_1_conv_state_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_dAh_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_dBu_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_dtA_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_dtadapt_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_dtadapt_1_o_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_dtadapt_1_o_stream2_fifo_io_flush = 1'b0;
  assign inst_mamba_dtadapt_1_o_s_stream2_fifo_io_flush = 1'b0;
  assign inst_mamba_dtB_quant_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_dtB_quant_1_o_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_exp_quant_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_exp_quant_1_o_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_gemm_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_gemm_demux_1_dt_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_gemm_demux_1_xBC_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_gemm_demux_1_z_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_gemm_demux_1_out_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_gemm_mux_1_q_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_gemm_mux_1_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_add_quant_1_ht1_q_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_add_quant_1_ht1_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_add_quant_1_ht2_q_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_add_quant_1_ht2_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_state_1_ht_out_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_state_1_ht_out_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_state_1_state_out_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ht_state_1_state_out_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_htC_quant_1_o_q_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_htC_quant_1_o_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_quant_conv_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_quant_conv_1_o_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_residual_1_res_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_residual_1_y_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_rms_quant_1_xlnq_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_rms_quant_1_xlns_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_rms_quant_2_xlnq_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_rms_quant_2_xlns_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_x_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_x_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_x_stream2_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_x_s_stream2_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_B_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_B_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_C_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_C_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_z_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_demux_1_z_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_mux_1_silu_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_quant_1_out_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_silu_quant_1_out_s_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_ud_1_o_stream_fifo_io_flush = 1'b0;
  assign inst_mamba_yz_1_o_stream_fifo_io_flush = 1'b0;

endmodule

//StreamFifo_29 replaced by StreamFifo_30

//StreamFifo_28 replaced by StreamFifo_30

//StreamFifo_27 replaced by StreamFifo_30

//StreamFifo_26 replaced by StreamFifo_30

//StreamFifo_25 replaced by StreamFifo_32

//StreamFifo_24 replaced by StreamFifo_32

//StreamFifo_23 replaced by StreamFifo_30

//StreamFifo_22 replaced by StreamFifo_18

//StreamFifo_21 replaced by StreamFifo_18

//StreamFifo_20 replaced by StreamFifo_18

//StreamFifo_19 replaced by StreamFifo_18

module StreamFifo_18 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [255:0]  io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [255:0]  io_pop_payload_data,
  input  wire          io_flush,
  output wire [10:0]   io_occupancy,
  output wire [10:0]   io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [255:0]  _zz_logic_ram_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [10:0]   logic_ptr_push;
  reg        [10:0]   logic_ptr_pop;
  wire       [10:0]   logic_ptr_occupancy;
  wire       [10:0]   logic_ptr_popOnIo;
  wire                when_Stream_l1205;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [9:0]    logic_push_onRam_write_payload_address;
  wire       [255:0]  logic_push_onRam_write_payload_data_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [9:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [9:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [9:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l369;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [9:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [255:0]  logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [255:0]  logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [10:0]   logic_pop_sync_popReg;
  reg [255:0] logic_ram [0:1023];

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
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 11'h400) == 11'h000);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[9:0];
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[9:0];
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
  assign io_availability = (11'h400 - logic_ptr_occupancy);
  always @(posedge clk) begin
    if(!resetn) begin
      logic_ptr_push <= 11'h000;
      logic_ptr_pop <= 11'h000;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 11'h000;
    end else begin
      if(when_Stream_l1205) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 11'h001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 11'h001);
      end
      if(io_flush) begin
        logic_ptr_push <= 11'h000;
        logic_ptr_pop <= 11'h000;
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
        logic_pop_sync_popReg <= 11'h000;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

//StreamFifo_17 replaced by StreamFifo_30

//StreamFifo_16 replaced by StreamFifo_30

//StreamFifo_15 replaced by StreamFifo_30

//StreamFifo_14 replaced by StreamFifo_30

//StreamFifo_13 replaced by StreamFifo_30

//StreamFifo_12 replaced by StreamFifo_30

module M_AXI_FLOW_wrapper (
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
  input  wire          mem_stream_TVALID,
  output wire          mem_stream_TREADY,
  input  wire [255:0]  mem_stream_TDATA,
  input  wire          conv_stream_TVALID,
  output wire          conv_stream_TREADY,
  input  wire [255:0]  conv_stream_TDATA,
  output wire          conv2_stream_TVALID,
  input  wire          conv2_stream_TREADY,
  output wire [255:0]  conv2_stream_TDATA,
  input  wire          ht_stream_TVALID,
  output wire          ht_stream_TREADY,
  input  wire [255:0]  ht_stream_TDATA,
  output wire          ht2_stream_TVALID,
  input  wire          ht2_stream_TREADY,
  output wire [255:0]  ht2_stream_TDATA,
  output wire          wq_stream_TVALID,
  input  wire          wq_stream_TREADY,
  output wire [255:0]  wq_stream_TDATA,
  output wire          ws1_stream_TVALID,
  input  wire          ws1_stream_TREADY,
  output wire [23:0]   ws1_stream_TDATA,
  output wire          ws2_stream_TVALID,
  input  wire          ws2_stream_TREADY,
  output wire [23:0]   ws2_stream_TDATA,
  output wire          cq_stream_TVALID,
  input  wire          cq_stream_TREADY,
  output wire [255:0]  cq_stream_TDATA,
  output wire          cs_stream_TVALID,
  input  wire          cs_stream_TREADY,
  output wire [255:0]  cs_stream_TDATA,
  input  wire          cq2_stream_TVALID,
  output wire          cq2_stream_TREADY,
  input  wire [255:0]  cq2_stream_TDATA,
  input  wire          cs2_stream_TVALID,
  output wire          cs2_stream_TREADY,
  input  wire [255:0]  cs2_stream_TDATA,
  output wire          hq_stream_TVALID,
  input  wire          hq_stream_TREADY,
  output wire [255:0]  hq_stream_TDATA,
  output wire          hs_stream_TVALID,
  input  wire          hs_stream_TREADY,
  output wire [255:0]  hs_stream_TDATA,
  input  wire          hq2_stream_TVALID,
  output wire          hq2_stream_TREADY,
  input  wire [255:0]  hq2_stream_TDATA,
  input  wire          hs2_stream_TVALID,
  output wire          hs2_stream_TREADY,
  input  wire [255:0]  hs2_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_mem_stream_TREADY;
  wire                black_box_conv_stream_TREADY;
  wire       [255:0]  black_box_conv2_stream_TDATA;
  wire                black_box_conv2_stream_TVALID;
  wire                black_box_ht_stream_TREADY;
  wire       [255:0]  black_box_ht2_stream_TDATA;
  wire                black_box_ht2_stream_TVALID;
  wire       [255:0]  black_box_wq_stream_TDATA;
  wire                black_box_wq_stream_TVALID;
  wire       [23:0]   black_box_ws1_stream_TDATA;
  wire                black_box_ws1_stream_TVALID;
  wire       [23:0]   black_box_ws2_stream_TDATA;
  wire                black_box_ws2_stream_TVALID;
  wire       [255:0]  black_box_cq_stream_TDATA;
  wire                black_box_cq_stream_TVALID;
  wire       [255:0]  black_box_cs_stream_TDATA;
  wire                black_box_cs_stream_TVALID;
  wire                black_box_cq2_stream_TREADY;
  wire                black_box_cs2_stream_TREADY;
  wire       [255:0]  black_box_hq_stream_TDATA;
  wire                black_box_hq_stream_TVALID;
  wire       [255:0]  black_box_hs_stream_TDATA;
  wire                black_box_hs_stream_TVALID;
  wire                black_box_hq2_stream_TREADY;
  wire                black_box_hs2_stream_TREADY;
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  M_AXI_FLOW black_box (
    .ap_clk              (clk                                ), //i
    .ap_rst_n            (resetn                             ), //i
    .l_begin             (manager_27_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_27_signals_O_L_CLOSE[31:0] ), //i
    .ap_start            (manager_27_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_27_ap_ctrl_ap_continue     ), //i
    .ap_idle             (black_box_ap_idle                  ), //o
    .ap_ready            (black_box_ap_ready                 ), //o
    .ap_done             (black_box_ap_done                  ), //o
    .mem_stream_TDATA    (mem_stream_TDATA[255:0]            ), //i
    .mem_stream_TVALID   (mem_stream_TVALID                  ), //i
    .mem_stream_TREADY   (black_box_mem_stream_TREADY        ), //o
    .conv_stream_TDATA   (conv_stream_TDATA[255:0]           ), //i
    .conv_stream_TVALID  (conv_stream_TVALID                 ), //i
    .conv_stream_TREADY  (black_box_conv_stream_TREADY       ), //o
    .conv2_stream_TDATA  (black_box_conv2_stream_TDATA[255:0]), //o
    .conv2_stream_TVALID (black_box_conv2_stream_TVALID      ), //o
    .conv2_stream_TREADY (conv2_stream_TREADY                ), //i
    .ht_stream_TDATA     (ht_stream_TDATA[255:0]             ), //i
    .ht_stream_TVALID    (ht_stream_TVALID                   ), //i
    .ht_stream_TREADY    (black_box_ht_stream_TREADY         ), //o
    .ht2_stream_TDATA    (black_box_ht2_stream_TDATA[255:0]  ), //o
    .ht2_stream_TVALID   (black_box_ht2_stream_TVALID        ), //o
    .ht2_stream_TREADY   (ht2_stream_TREADY                  ), //i
    .wq_stream_TDATA     (black_box_wq_stream_TDATA[255:0]   ), //o
    .wq_stream_TVALID    (black_box_wq_stream_TVALID         ), //o
    .wq_stream_TREADY    (wq_stream_TREADY                   ), //i
    .ws1_stream_TDATA    (black_box_ws1_stream_TDATA[23:0]   ), //o
    .ws1_stream_TVALID   (black_box_ws1_stream_TVALID        ), //o
    .ws1_stream_TREADY   (ws1_stream_TREADY                  ), //i
    .ws2_stream_TDATA    (black_box_ws2_stream_TDATA[23:0]   ), //o
    .ws2_stream_TVALID   (black_box_ws2_stream_TVALID        ), //o
    .ws2_stream_TREADY   (ws2_stream_TREADY                  ), //i
    .cq_stream_TDATA     (black_box_cq_stream_TDATA[255:0]   ), //o
    .cq_stream_TVALID    (black_box_cq_stream_TVALID         ), //o
    .cq_stream_TREADY    (cq_stream_TREADY                   ), //i
    .cs_stream_TDATA     (black_box_cs_stream_TDATA[255:0]   ), //o
    .cs_stream_TVALID    (black_box_cs_stream_TVALID         ), //o
    .cs_stream_TREADY    (cs_stream_TREADY                   ), //i
    .cq2_stream_TDATA    (cq2_stream_TDATA[255:0]            ), //i
    .cq2_stream_TVALID   (cq2_stream_TVALID                  ), //i
    .cq2_stream_TREADY   (black_box_cq2_stream_TREADY        ), //o
    .cs2_stream_TDATA    (cs2_stream_TDATA[255:0]            ), //i
    .cs2_stream_TVALID   (cs2_stream_TVALID                  ), //i
    .cs2_stream_TREADY   (black_box_cs2_stream_TREADY        ), //o
    .hq_stream_TDATA     (black_box_hq_stream_TDATA[255:0]   ), //o
    .hq_stream_TVALID    (black_box_hq_stream_TVALID         ), //o
    .hq_stream_TREADY    (hq_stream_TREADY                   ), //i
    .hs_stream_TDATA     (black_box_hs_stream_TDATA[255:0]   ), //o
    .hs_stream_TVALID    (black_box_hs_stream_TVALID         ), //o
    .hs_stream_TREADY    (hs_stream_TREADY                   ), //i
    .hq2_stream_TDATA    (hq2_stream_TDATA[255:0]            ), //i
    .hq2_stream_TVALID   (hq2_stream_TVALID                  ), //i
    .hq2_stream_TREADY   (black_box_hq2_stream_TREADY        ), //o
    .hs2_stream_TDATA    (hs2_stream_TDATA[255:0]            ), //i
    .hs2_stream_TVALID   (hs2_stream_TVALID                  ), //i
    .hs2_stream_TREADY   (black_box_hs2_stream_TREADY        )  //o
  );
  Manager_9 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
  assign mem_stream_TREADY = black_box_mem_stream_TREADY;
  assign conv_stream_TREADY = black_box_conv_stream_TREADY;
  assign conv2_stream_TDATA = black_box_conv2_stream_TDATA;
  assign conv2_stream_TVALID = black_box_conv2_stream_TVALID;
  assign ht_stream_TREADY = black_box_ht_stream_TREADY;
  assign ht2_stream_TDATA = black_box_ht2_stream_TDATA;
  assign ht2_stream_TVALID = black_box_ht2_stream_TVALID;
  assign wq_stream_TDATA = black_box_wq_stream_TDATA;
  assign wq_stream_TVALID = black_box_wq_stream_TVALID;
  assign ws1_stream_TDATA = black_box_ws1_stream_TDATA;
  assign ws1_stream_TVALID = black_box_ws1_stream_TVALID;
  assign ws2_stream_TDATA = black_box_ws2_stream_TDATA;
  assign ws2_stream_TVALID = black_box_ws2_stream_TVALID;
  assign cq_stream_TDATA = black_box_cq_stream_TDATA;
  assign cq_stream_TVALID = black_box_cq_stream_TVALID;
  assign cs_stream_TDATA = black_box_cs_stream_TDATA;
  assign cs_stream_TVALID = black_box_cs_stream_TVALID;
  assign cq2_stream_TREADY = black_box_cq2_stream_TREADY;
  assign cs2_stream_TREADY = black_box_cs2_stream_TREADY;
  assign hq_stream_TDATA = black_box_hq_stream_TDATA;
  assign hq_stream_TVALID = black_box_hq_stream_TVALID;
  assign hs_stream_TDATA = black_box_hs_stream_TDATA;
  assign hs_stream_TVALID = black_box_hs_stream_TVALID;
  assign hq2_stream_TREADY = black_box_hq2_stream_TREADY;
  assign hs2_stream_TREADY = black_box_hs2_stream_TREADY;

endmodule

module M_AXI_STATIC_wrapper (
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
  output wire          m_axi_awvalid,
  input  wire          m_axi_awready,
  output wire [47:0]   m_axi_awaddr,
  output wire [0:0]    m_axi_awid,
  output wire [3:0]    m_axi_awregion,
  output wire [7:0]    m_axi_awlen,
  output wire [2:0]    m_axi_awsize,
  output wire [1:0]    m_axi_awburst,
  output wire [0:0]    m_axi_awlock,
  output wire [3:0]    m_axi_awcache,
  output wire [3:0]    m_axi_awqos,
  output wire [0:0]    m_axi_awuser,
  output wire [2:0]    m_axi_awprot,
  output wire          m_axi_wvalid,
  input  wire          m_axi_wready,
  output wire [255:0]  m_axi_wdata,
  output wire [31:0]   m_axi_wstrb,
  output wire [0:0]    m_axi_wuser,
  output wire          m_axi_wlast,
  input  wire          m_axi_bvalid,
  output wire          m_axi_bready,
  input  wire [0:0]    m_axi_bid,
  input  wire [1:0]    m_axi_bresp,
  input  wire [0:0]    m_axi_buser,
  output wire          m_axi_arvalid,
  input  wire          m_axi_arready,
  output wire [47:0]   m_axi_araddr,
  output wire [0:0]    m_axi_arid,
  output wire [3:0]    m_axi_arregion,
  output wire [7:0]    m_axi_arlen,
  output wire [2:0]    m_axi_arsize,
  output wire [1:0]    m_axi_arburst,
  output wire [0:0]    m_axi_arlock,
  output wire [3:0]    m_axi_arcache,
  output wire [3:0]    m_axi_arqos,
  output wire [0:0]    m_axi_aruser,
  output wire [2:0]    m_axi_arprot,
  input  wire          m_axi_rvalid,
  output wire          m_axi_rready,
  input  wire [255:0]  m_axi_rdata,
  input  wire [0:0]    m_axi_rid,
  input  wire [1:0]    m_axi_rresp,
  input  wire          m_axi_rlast,
  input  wire [0:0]    m_axi_ruser,
  output wire          x_stream_TVALID,
  input  wire          x_stream_TREADY,
  output wire [255:0]  x_stream_TDATA,
  output wire          mem_stream_TVALID,
  input  wire          mem_stream_TREADY,
  output wire [255:0]  mem_stream_TDATA,
  output wire          conv_stream_TVALID,
  input  wire          conv_stream_TREADY,
  output wire [255:0]  conv_stream_TDATA,
  input  wire          conv2_stream_TVALID,
  output wire          conv2_stream_TREADY,
  input  wire [255:0]  conv2_stream_TDATA,
  output wire          ht_stream_TVALID,
  input  wire          ht_stream_TREADY,
  output wire [255:0]  ht_stream_TDATA,
  input  wire          ht2_stream_TVALID,
  output wire          ht2_stream_TREADY,
  input  wire [255:0]  ht2_stream_TDATA,
  input  wire          y_stream_TVALID,
  output wire          y_stream_TREADY,
  input  wire [255:0]  y_stream_TDATA,
  output wire          idle
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_m_axi_gmem_AWVALID;
  wire       [47:0]   black_box_m_axi_gmem_AWADDR;
  wire       [0:0]    black_box_m_axi_gmem_AWID;
  wire       [0:0]    black_box_m_axi_gmem_AWUSER;
  wire       [3:0]    black_box_m_axi_gmem_AWREGION;
  wire       [7:0]    black_box_m_axi_gmem_AWLEN;
  wire       [2:0]    black_box_m_axi_gmem_AWSIZE;
  wire       [1:0]    black_box_m_axi_gmem_AWBURST;
  wire       [0:0]    black_box_m_axi_gmem_AWLOCK;
  wire       [3:0]    black_box_m_axi_gmem_AWCACHE;
  wire       [3:0]    black_box_m_axi_gmem_AWQOS;
  wire       [2:0]    black_box_m_axi_gmem_AWPROT;
  wire                black_box_m_axi_gmem_WVALID;
  wire       [255:0]  black_box_m_axi_gmem_WDATA;
  wire       [31:0]   black_box_m_axi_gmem_WSTRB;
  wire                black_box_m_axi_gmem_WLAST;
  wire       [0:0]    black_box_m_axi_gmem_WID;
  wire       [0:0]    black_box_m_axi_gmem_WUSER;
  wire                black_box_m_axi_gmem_ARVALID;
  wire       [47:0]   black_box_m_axi_gmem_ARADDR;
  wire       [0:0]    black_box_m_axi_gmem_ARID;
  wire       [0:0]    black_box_m_axi_gmem_ARUSER;
  wire       [3:0]    black_box_m_axi_gmem_ARREGION;
  wire       [7:0]    black_box_m_axi_gmem_ARLEN;
  wire       [2:0]    black_box_m_axi_gmem_ARSIZE;
  wire       [1:0]    black_box_m_axi_gmem_ARBURST;
  wire       [0:0]    black_box_m_axi_gmem_ARLOCK;
  wire       [3:0]    black_box_m_axi_gmem_ARCACHE;
  wire       [3:0]    black_box_m_axi_gmem_ARQOS;
  wire       [2:0]    black_box_m_axi_gmem_ARPROT;
  wire                black_box_m_axi_gmem_RREADY;
  wire                black_box_m_axi_gmem_BREADY;
  wire       [255:0]  black_box_x_stream_TDATA;
  wire                black_box_x_stream_TVALID;
  wire       [255:0]  black_box_mem_stream_TDATA;
  wire                black_box_mem_stream_TVALID;
  wire       [255:0]  black_box_conv_stream_TDATA;
  wire                black_box_conv_stream_TVALID;
  wire                black_box_conv2_stream_TREADY;
  wire       [255:0]  black_box_ht_stream_TDATA;
  wire                black_box_ht_stream_TVALID;
  wire                black_box_ht2_stream_TREADY;
  wire                black_box_y_stream_TREADY;
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  M_AXI_STATIC black_box (
    .ap_clk              (clk                                ), //i
    .ap_rst_n            (resetn                             ), //i
    .l_begin             (manager_27_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_27_signals_O_L_CLOSE[31:0] ), //i
    .memory_x            (manager_27_signals_O_MEMORY_X[63:0]), //i
    .memory_w            (manager_27_signals_O_MEMORY_W[63:0]), //i
    .memory_y            (manager_27_signals_O_MEMORY_Y[63:0]), //i
    .memory_c            (manager_27_signals_O_MEMORY_C[63:0]), //i
    .memory_h            (manager_27_signals_O_MEMORY_H[63:0]), //i
    .ap_start            (manager_27_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_27_ap_ctrl_ap_continue     ), //i
    .ap_idle             (black_box_ap_idle                  ), //o
    .ap_ready            (black_box_ap_ready                 ), //o
    .ap_done             (black_box_ap_done                  ), //o
    .m_axi_gmem_AWVALID  (black_box_m_axi_gmem_AWVALID       ), //o
    .m_axi_gmem_AWREADY  (m_axi_awready                      ), //i
    .m_axi_gmem_AWADDR   (black_box_m_axi_gmem_AWADDR[47:0]  ), //o
    .m_axi_gmem_AWID     (black_box_m_axi_gmem_AWID          ), //o
    .m_axi_gmem_AWUSER   (black_box_m_axi_gmem_AWUSER        ), //o
    .m_axi_gmem_AWREGION (black_box_m_axi_gmem_AWREGION[3:0] ), //o
    .m_axi_gmem_AWLEN    (black_box_m_axi_gmem_AWLEN[7:0]    ), //o
    .m_axi_gmem_AWSIZE   (black_box_m_axi_gmem_AWSIZE[2:0]   ), //o
    .m_axi_gmem_AWBURST  (black_box_m_axi_gmem_AWBURST[1:0]  ), //o
    .m_axi_gmem_AWLOCK   (black_box_m_axi_gmem_AWLOCK        ), //o
    .m_axi_gmem_AWCACHE  (black_box_m_axi_gmem_AWCACHE[3:0]  ), //o
    .m_axi_gmem_AWQOS    (black_box_m_axi_gmem_AWQOS[3:0]    ), //o
    .m_axi_gmem_AWPROT   (black_box_m_axi_gmem_AWPROT[2:0]   ), //o
    .m_axi_gmem_WVALID   (black_box_m_axi_gmem_WVALID        ), //o
    .m_axi_gmem_WREADY   (m_axi_wready                       ), //i
    .m_axi_gmem_WDATA    (black_box_m_axi_gmem_WDATA[255:0]  ), //o
    .m_axi_gmem_WSTRB    (black_box_m_axi_gmem_WSTRB[31:0]   ), //o
    .m_axi_gmem_WLAST    (black_box_m_axi_gmem_WLAST         ), //o
    .m_axi_gmem_WID      (black_box_m_axi_gmem_WID           ), //o
    .m_axi_gmem_WUSER    (black_box_m_axi_gmem_WUSER         ), //o
    .m_axi_gmem_ARVALID  (black_box_m_axi_gmem_ARVALID       ), //o
    .m_axi_gmem_ARREADY  (m_axi_arready                      ), //i
    .m_axi_gmem_ARADDR   (black_box_m_axi_gmem_ARADDR[47:0]  ), //o
    .m_axi_gmem_ARID     (black_box_m_axi_gmem_ARID          ), //o
    .m_axi_gmem_ARUSER   (black_box_m_axi_gmem_ARUSER        ), //o
    .m_axi_gmem_ARREGION (black_box_m_axi_gmem_ARREGION[3:0] ), //o
    .m_axi_gmem_ARLEN    (black_box_m_axi_gmem_ARLEN[7:0]    ), //o
    .m_axi_gmem_ARSIZE   (black_box_m_axi_gmem_ARSIZE[2:0]   ), //o
    .m_axi_gmem_ARBURST  (black_box_m_axi_gmem_ARBURST[1:0]  ), //o
    .m_axi_gmem_ARLOCK   (black_box_m_axi_gmem_ARLOCK        ), //o
    .m_axi_gmem_ARCACHE  (black_box_m_axi_gmem_ARCACHE[3:0]  ), //o
    .m_axi_gmem_ARQOS    (black_box_m_axi_gmem_ARQOS[3:0]    ), //o
    .m_axi_gmem_ARPROT   (black_box_m_axi_gmem_ARPROT[2:0]   ), //o
    .m_axi_gmem_RVALID   (m_axi_rvalid                       ), //i
    .m_axi_gmem_RREADY   (black_box_m_axi_gmem_RREADY        ), //o
    .m_axi_gmem_RDATA    (m_axi_rdata[255:0]                 ), //i
    .m_axi_gmem_RLAST    (m_axi_rlast                        ), //i
    .m_axi_gmem_RID      (m_axi_rid                          ), //i
    .m_axi_gmem_RUSER    (m_axi_ruser                        ), //i
    .m_axi_gmem_RRESP    (m_axi_rresp[1:0]                   ), //i
    .m_axi_gmem_BVALID   (m_axi_bvalid                       ), //i
    .m_axi_gmem_BREADY   (black_box_m_axi_gmem_BREADY        ), //o
    .m_axi_gmem_BID      (m_axi_bid                          ), //i
    .m_axi_gmem_BUSER    (m_axi_buser                        ), //i
    .m_axi_gmem_BRESP    (m_axi_bresp[1:0]                   ), //i
    .x_stream_TDATA      (black_box_x_stream_TDATA[255:0]    ), //o
    .x_stream_TVALID     (black_box_x_stream_TVALID          ), //o
    .x_stream_TREADY     (x_stream_TREADY                    ), //i
    .mem_stream_TDATA    (black_box_mem_stream_TDATA[255:0]  ), //o
    .mem_stream_TVALID   (black_box_mem_stream_TVALID        ), //o
    .mem_stream_TREADY   (mem_stream_TREADY                  ), //i
    .conv_stream_TDATA   (black_box_conv_stream_TDATA[255:0] ), //o
    .conv_stream_TVALID  (black_box_conv_stream_TVALID       ), //o
    .conv_stream_TREADY  (conv_stream_TREADY                 ), //i
    .conv2_stream_TDATA  (conv2_stream_TDATA[255:0]          ), //i
    .conv2_stream_TVALID (conv2_stream_TVALID                ), //i
    .conv2_stream_TREADY (black_box_conv2_stream_TREADY      ), //o
    .ht_stream_TDATA     (black_box_ht_stream_TDATA[255:0]   ), //o
    .ht_stream_TVALID    (black_box_ht_stream_TVALID         ), //o
    .ht_stream_TREADY    (ht_stream_TREADY                   ), //i
    .ht2_stream_TDATA    (ht2_stream_TDATA[255:0]            ), //i
    .ht2_stream_TVALID   (ht2_stream_TVALID                  ), //i
    .ht2_stream_TREADY   (black_box_ht2_stream_TREADY        ), //o
    .y_stream_TDATA      (y_stream_TDATA[255:0]              ), //i
    .y_stream_TVALID     (y_stream_TVALID                    ), //i
    .y_stream_TREADY     (black_box_y_stream_TREADY          )  //o
  );
  Manager_9 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
  assign idle = black_box_ap_idle;
  assign m_axi_awvalid = black_box_m_axi_gmem_AWVALID;
  assign m_axi_awaddr = black_box_m_axi_gmem_AWADDR;
  assign m_axi_awid = black_box_m_axi_gmem_AWID;
  assign m_axi_awlen = black_box_m_axi_gmem_AWLEN;
  assign m_axi_awsize = black_box_m_axi_gmem_AWSIZE;
  assign m_axi_awburst = black_box_m_axi_gmem_AWBURST;
  assign m_axi_awlock = black_box_m_axi_gmem_AWLOCK;
  assign m_axi_awcache = black_box_m_axi_gmem_AWCACHE;
  assign m_axi_awprot = black_box_m_axi_gmem_AWPROT;
  assign m_axi_awqos = black_box_m_axi_gmem_AWQOS;
  assign m_axi_awregion = black_box_m_axi_gmem_AWREGION;
  assign m_axi_awuser = black_box_m_axi_gmem_AWUSER;
  assign m_axi_wvalid = black_box_m_axi_gmem_WVALID;
  assign m_axi_wdata = black_box_m_axi_gmem_WDATA;
  assign m_axi_wstrb = black_box_m_axi_gmem_WSTRB;
  assign m_axi_wlast = black_box_m_axi_gmem_WLAST;
  assign m_axi_wuser = black_box_m_axi_gmem_WUSER;
  assign m_axi_arvalid = black_box_m_axi_gmem_ARVALID;
  assign m_axi_araddr = black_box_m_axi_gmem_ARADDR;
  assign m_axi_arid = black_box_m_axi_gmem_ARID;
  assign m_axi_arlen = black_box_m_axi_gmem_ARLEN;
  assign m_axi_arsize = black_box_m_axi_gmem_ARSIZE;
  assign m_axi_arburst = black_box_m_axi_gmem_ARBURST;
  assign m_axi_arlock = black_box_m_axi_gmem_ARLOCK;
  assign m_axi_arcache = black_box_m_axi_gmem_ARCACHE;
  assign m_axi_arprot = black_box_m_axi_gmem_ARPROT;
  assign m_axi_arqos = black_box_m_axi_gmem_ARQOS;
  assign m_axi_arregion = black_box_m_axi_gmem_ARREGION;
  assign m_axi_aruser = black_box_m_axi_gmem_ARUSER;
  assign m_axi_rready = black_box_m_axi_gmem_RREADY;
  assign m_axi_bready = black_box_m_axi_gmem_BREADY;
  assign x_stream_TDATA = black_box_x_stream_TDATA;
  assign x_stream_TVALID = black_box_x_stream_TVALID;
  assign y_stream_TREADY = black_box_y_stream_TREADY;
  assign mem_stream_TDATA = black_box_mem_stream_TDATA;
  assign mem_stream_TVALID = black_box_mem_stream_TVALID;
  assign conv_stream_TDATA = black_box_conv_stream_TDATA;
  assign conv_stream_TVALID = black_box_conv_stream_TVALID;
  assign conv2_stream_TREADY = black_box_conv2_stream_TREADY;
  assign ht_stream_TDATA = black_box_ht_stream_TDATA;
  assign ht_stream_TVALID = black_box_ht_stream_TVALID;
  assign ht2_stream_TREADY = black_box_ht2_stream_TREADY;

endmodule

//StreamFifo_99 replaced by StreamFifo_30

//StreamFifo_98 replaced by StreamFifo_30

//StreamFifo_97 replaced by StreamFifo_39

//StreamFifo_96 replaced by StreamFifo_38

//StreamFifo_95 replaced by StreamFifo_30

//StreamFifo_94 replaced by StreamFifo_39

//StreamFifo_93 replaced by StreamFifo_38

//StreamFifo_92 replaced by StreamFifo_39

//StreamFifo_91 replaced by StreamFifo_38

//StreamFifo_90 replaced by StreamFifo_39

//StreamFifo_89 replaced by StreamFifo_38

//StreamFifo_88 replaced by StreamFifo_39

//StreamFifo_87 replaced by StreamFifo_38

//StreamFifo_86 replaced by StreamFifo_39

//StreamFifo_85 replaced by StreamFifo_38

//StreamFifo_84 replaced by StreamFifo_39

//StreamFifo_83 replaced by StreamFifo_65

//StreamFifo_82 replaced by StreamFifo_39

//StreamFifo_81 replaced by StreamFifo_65

//StreamFifo_80 replaced by StreamFifo_30

//StreamFifo_79 replaced by StreamFifo_30

//StreamFifo_78 replaced by StreamFifo_39

//StreamFifo_77 replaced by StreamFifo_38

//StreamFifo_76 replaced by StreamFifo_39

//StreamFifo_75 replaced by StreamFifo_38

//StreamFifo_74 replaced by StreamFifo_30

//StreamFifo_73 replaced by StreamFifo_30

module StreamFifo_72 (
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

module StreamFifo_71 (
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

//StreamFifo_70 replaced by StreamFifo_39

//StreamFifo_69 replaced by StreamFifo_38

//StreamFifo_68 replaced by StreamFifo_39

//StreamFifo_67 replaced by StreamFifo_38

module StreamFifo_66 (
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

module StreamFifo_65 (
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

//StreamFifo_64 replaced by StreamFifo_30

//StreamFifo_63 replaced by StreamFifo_30

//StreamFifo_62 replaced by StreamFifo_30

//StreamFifo_61 replaced by StreamFifo_30

//StreamFifo_60 replaced by StreamFifo_30

//StreamFifo_59 replaced by StreamFifo_39

//StreamFifo_58 replaced by StreamFifo_38

//StreamFifo_57 replaced by StreamFifo_39

//StreamFifo_56 replaced by StreamFifo_38

//StreamFifo_55 replaced by StreamFifo_39

//StreamFifo_54 replaced by StreamFifo_38

//StreamFifo_53 replaced by StreamFifo_39

//StreamFifo_52 replaced by StreamFifo_38

//StreamFifo_51 replaced by StreamFifo_30

//StreamFifo_50 replaced by StreamFifo_30

//StreamFifo_49 replaced by StreamFifo_30

//StreamFifo_48 replaced by StreamFifo_30

//StreamFifo_47 replaced by StreamFifo_30

//StreamFifo_46 replaced by StreamFifo_39

//StreamFifo_45 replaced by StreamFifo_38

//StreamFifo_44 replaced by StreamFifo_39

//StreamFifo_43 replaced by StreamFifo_38

//StreamFifo_42 replaced by StreamFifo_30

//StreamFifo_41 replaced by StreamFifo_39

//StreamFifo_40 replaced by StreamFifo_38

module StreamFifo_39 (
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

module StreamFifo_38 (
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

//StreamFifo_37 replaced by StreamFifo_30

//StreamFifo_36 replaced by StreamFifo_30

//StreamFifo_35 replaced by StreamFifo_30

//StreamFifo_34 replaced by StreamFifo_30

//StreamFifo_33 replaced by StreamFifo_32

module StreamFifo_32 (
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

//StreamFifo_31 replaced by StreamFifo_30

module StreamFifo_30 (
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  YZ black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .ap_start          (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  UD black_box (
    .ap_clk          (clk                            ), //i
    .ap_rst_n        (resetn                         ), //i
    .l               (manager_27_l[31:0]             ), //i
    .ap_start        (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue     (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  SILU_QUANT black_box (
    .ap_clk              (clk                              ), //i
    .ap_rst_n            (resetn                           ), //i
    .ap_start            (manager_27_ap_ctrl_ap_start      ), //i
    .ap_continue         (manager_27_ap_ctrl_ap_continue   ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  SILU_MUX black_box (
    .ap_clk             (clk                               ), //i
    .ap_rst_n           (resetn                            ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start       ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue    ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  SILU_DEMUX black_box (
    .ap_clk               (clk                             ), //i
    .ap_rst_n             (resetn                          ), //i
    .ap_start             (manager_27_ap_ctrl_ap_start     ), //i
    .ap_continue          (manager_27_ap_ctrl_ap_continue  ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  RMSNORM_QUANT_2 black_box (
    .ap_clk             (clk                              ), //i
    .ap_rst_n           (resetn                           ), //i
    .l                  (manager_27_l[31:0]               ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start      ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue   ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  RMSNORM_QUANT_1 black_box (
    .ap_clk             (clk                              ), //i
    .ap_rst_n           (resetn                           ), //i
    .l                  (manager_27_l[31:0]               ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start      ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue   ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  RESIDUAL black_box (
    .ap_clk              (clk                                ), //i
    .ap_rst_n            (resetn                             ), //i
    .l_begin             (manager_27_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_27_signals_O_L_CLOSE[31:0] ), //i
    .ap_start            (manager_27_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_27_ap_ctrl_ap_continue     ), //i
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
  Manager_9 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  QUANT_CONV black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .ap_start          (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  HTC_QUANT black_box (
    .ap_clk             (clk                             ), //i
    .ap_rst_n           (resetn                          ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start     ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue  ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  HT_STATE black_box (
    .ap_clk                    (clk                                      ), //i
    .ap_rst_n                  (resetn                                   ), //i
    .ap_start                  (manager_27_ap_ctrl_ap_start              ), //i
    .ap_continue               (manager_27_ap_ctrl_ap_continue           ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  HT_ADD_QUANT black_box (
    .ap_clk              (clk                               ), //i
    .ap_rst_n            (resetn                            ), //i
    .ap_start            (manager_27_ap_ctrl_ap_start       ), //i
    .ap_continue         (manager_27_ap_ctrl_ap_continue    ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  GEMM_MUX black_box (
    .ap_clk              (clk                           ), //i
    .ap_rst_n            (resetn                        ), //i
    .ap_start            (manager_27_ap_ctrl_ap_start   ), //i
    .ap_continue         (manager_27_ap_ctrl_ap_continue), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  GEMM_DEMUX black_box (
    .ap_clk             (clk                              ), //i
    .ap_rst_n           (resetn                           ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start      ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue   ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  GEMM black_box (
    .ap_clk           (clk                            ), //i
    .ap_rst_n         (resetn                         ), //i
    .ap_start         (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue      (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  EXP_QUANT black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .ap_start          (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  DTB_QUANT black_box (
    .ap_clk             (clk                            ), //i
    .ap_rst_n           (resetn                         ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  DTADAPT black_box (
    .ap_clk             (clk                             ), //i
    .ap_rst_n           (resetn                          ), //i
    .l                  (manager_27_l[31:0]              ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start     ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue  ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  DTA black_box (
    .ap_clk          (clk                            ), //i
    .ap_rst_n        (resetn                         ), //i
    .l               (manager_27_l[31:0]             ), //i
    .ap_start        (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue     (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  DBU black_box (
    .ap_clk             (clk                            ), //i
    .ap_rst_n           (resetn                         ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  DAH black_box (
    .ap_clk             (clk                            ), //i
    .ap_rst_n           (resetn                         ), //i
    .ap_start           (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue        (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  CONV_STATE black_box (
    .ap_clk                     (clk                                       ), //i
    .ap_rst_n                   (resetn                                    ), //i
    .ap_start                   (manager_27_ap_ctrl_ap_start               ), //i
    .ap_continue                (manager_27_ap_ctrl_ap_continue            ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  CONV black_box (
    .ap_clk            (clk                            ), //i
    .ap_rst_n          (resetn                         ), //i
    .l                 (manager_27_l[31:0]             ), //i
    .ap_start          (manager_27_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_27_ap_ctrl_ap_continue ), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  C_BUFFER black_box (
    .ap_clk            (clk                           ), //i
    .ap_rst_n          (resetn                        ), //i
    .ap_start          (manager_27_ap_ctrl_ap_start   ), //i
    .ap_continue       (manager_27_ap_ctrl_ap_continue), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
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
  wire       [31:0]   manager_27_signals_O_L_BEGIN;
  wire       [31:0]   manager_27_signals_O_L_CLOSE;
  wire       [63:0]   manager_27_signals_O_MEMORY_X;
  wire       [63:0]   manager_27_signals_O_MEMORY_W;
  wire       [63:0]   manager_27_signals_O_MEMORY_Y;
  wire       [63:0]   manager_27_signals_O_MEMORY_C;
  wire       [63:0]   manager_27_signals_O_MEMORY_H;
  wire       [11:0]   manager_27_signals_O_POS;
  wire                manager_27_signals_O_T;
  wire                manager_27_ap_ctrl_ap_start;
  wire                manager_27_ap_ctrl_ap_continue;
  wire       [31:0]   manager_27_l;

  B_BUFFER black_box (
    .ap_clk            (clk                           ), //i
    .ap_rst_n          (resetn                        ), //i
    .ap_start          (manager_27_ap_ctrl_ap_start   ), //i
    .ap_continue       (manager_27_ap_ctrl_ap_continue), //i
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
  Manager_26 manager_27 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]           ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_27_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_27_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_27_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_27_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_27_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_27_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_27_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_27_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_27_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_27_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_27_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_27_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_27_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_27_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_27_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_27_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_27_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_27_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_27_signals_O_MEMORY_H;
  assign signals_O_POS = manager_27_signals_O_POS;
  assign signals_O_T = manager_27_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign i_s_stream_TREADY = black_box_i_s_stream_TREADY;
  assign q_stream_TDATA = black_box_q_stream_TDATA;
  assign q_stream_TVALID = black_box_q_stream_TVALID;
  assign s_stream_TDATA = black_box_s_stream_TDATA;
  assign s_stream_TVALID = black_box_s_stream_TVALID;

endmodule

//Manager replaced by Manager_9

//Manager_1 replaced by Manager_9

//Manager_2 replaced by Manager_26

//Manager_3 replaced by Manager_26

//Manager_4 replaced by Manager_26

//Manager_5 replaced by Manager_26

//Manager_6 replaced by Manager_26

//Manager_7 replaced by Manager_26

//Manager_8 replaced by Manager_26

module Manager_9 (
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

//Manager_10 replaced by Manager_26

//Manager_11 replaced by Manager_26

//Manager_12 replaced by Manager_26

//Manager_13 replaced by Manager_26

//Manager_14 replaced by Manager_26

//Manager_15 replaced by Manager_26

//Manager_16 replaced by Manager_26

//Manager_17 replaced by Manager_26

//Manager_18 replaced by Manager_26

//Manager_19 replaced by Manager_26

//Manager_20 replaced by Manager_26

//Manager_21 replaced by Manager_26

//Manager_22 replaced by Manager_26

//Manager_23 replaced by Manager_26

//Manager_24 replaced by Manager_26

//Manager_25 replaced by Manager_26

module Manager_26 (
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

// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : M_AXI
// Git hash  : 79e645f08db4b61f66fa178c9252b19210d0b725

`timescale 1ns/1ps

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
  wire                toplevel_inst_state_x_stream_fifo_io_flush;
  wire                toplevel_inst_state_mem_stream_fifo_io_flush;
  wire                toplevel_inst_state_conv_stream_fifo_io_flush;
  wire                toplevel_inst_state_ht_stream_fifo_io_flush;
  wire                toplevel_inst_flow_conv2_stream_fifo_io_flush;
  wire                toplevel_inst_flow_ht2_stream_fifo_io_flush;
  wire                toplevel_inst_flow_wq_stream_fifo_io_flush;
  wire                toplevel_inst_flow_ws1_stream_fifo_io_flush;
  wire                toplevel_inst_flow_ws2_stream_fifo_io_flush;
  wire                toplevel_inst_flow_cq_stream_fifo_io_flush;
  wire                toplevel_inst_flow_cs_stream_fifo_io_flush;
  wire                toplevel_inst_flow_hq_stream_fifo_io_flush;
  wire                toplevel_inst_flow_hs_stream_fifo_io_flush;
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
  wire                toplevel_inst_state_x_stream_fifo_io_push_ready;
  wire                toplevel_inst_state_x_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_state_x_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_state_x_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_state_x_stream_fifo_io_availability;
  wire                toplevel_inst_state_mem_stream_fifo_io_push_ready;
  wire                toplevel_inst_state_mem_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_state_mem_stream_fifo_io_pop_payload_data;
  wire       [10:0]   toplevel_inst_state_mem_stream_fifo_io_occupancy;
  wire       [10:0]   toplevel_inst_state_mem_stream_fifo_io_availability;
  wire                toplevel_inst_state_conv_stream_fifo_io_push_ready;
  wire                toplevel_inst_state_conv_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_state_conv_stream_fifo_io_pop_payload_data;
  wire       [10:0]   toplevel_inst_state_conv_stream_fifo_io_occupancy;
  wire       [10:0]   toplevel_inst_state_conv_stream_fifo_io_availability;
  wire                toplevel_inst_state_ht_stream_fifo_io_push_ready;
  wire                toplevel_inst_state_ht_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_state_ht_stream_fifo_io_pop_payload_data;
  wire       [10:0]   toplevel_inst_state_ht_stream_fifo_io_occupancy;
  wire       [10:0]   toplevel_inst_state_ht_stream_fifo_io_availability;
  wire                toplevel_inst_flow_conv2_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_conv2_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_flow_conv2_stream_fifo_io_pop_payload_data;
  wire       [10:0]   toplevel_inst_flow_conv2_stream_fifo_io_occupancy;
  wire       [10:0]   toplevel_inst_flow_conv2_stream_fifo_io_availability;
  wire                toplevel_inst_flow_ht2_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_ht2_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_flow_ht2_stream_fifo_io_pop_payload_data;
  wire       [10:0]   toplevel_inst_flow_ht2_stream_fifo_io_occupancy;
  wire       [10:0]   toplevel_inst_flow_ht2_stream_fifo_io_availability;
  wire                toplevel_inst_flow_wq_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_wq_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_flow_wq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_flow_wq_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_flow_wq_stream_fifo_io_availability;
  wire                toplevel_inst_flow_ws1_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_ws1_stream_fifo_io_pop_valid;
  wire       [23:0]   toplevel_inst_flow_ws1_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_flow_ws1_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_flow_ws1_stream_fifo_io_availability;
  wire                toplevel_inst_flow_ws2_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_ws2_stream_fifo_io_pop_valid;
  wire       [23:0]   toplevel_inst_flow_ws2_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_flow_ws2_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_flow_ws2_stream_fifo_io_availability;
  wire                toplevel_inst_flow_cq_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_cq_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_flow_cq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_flow_cq_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_flow_cq_stream_fifo_io_availability;
  wire                toplevel_inst_flow_cs_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_cs_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_flow_cs_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_flow_cs_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_flow_cs_stream_fifo_io_availability;
  wire                toplevel_inst_flow_hq_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_hq_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_flow_hq_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_flow_hq_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_flow_hq_stream_fifo_io_availability;
  wire                toplevel_inst_flow_hs_stream_fifo_io_push_ready;
  wire                toplevel_inst_flow_hs_stream_fifo_io_pop_valid;
  wire       [255:0]  toplevel_inst_flow_hs_stream_fifo_io_pop_payload_data;
  wire       [3:0]    toplevel_inst_flow_hs_stream_fifo_io_occupancy;
  wire       [3:0]    toplevel_inst_flow_hs_stream_fifo_io_availability;

  M_AXI_STATIC_wrapper inst_state (
    .resetn              (resetn                                                         ), //i
    .clk                 (clk                                                            ), //i
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]                                        ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]                                        ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]                                       ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]                                       ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]                                       ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]                                       ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]                                       ), //i
    .signals_I_POS       (signals_I_POS[11:0]                                            ), //i
    .signals_I_T         (signals_I_T                                                    ), //i
    .signals_O_L_BEGIN   (inst_state_signals_O_L_BEGIN[31:0]                             ), //o
    .signals_O_L_CLOSE   (inst_state_signals_O_L_CLOSE[31:0]                             ), //o
    .signals_O_MEMORY_X  (inst_state_signals_O_MEMORY_X[63:0]                            ), //o
    .signals_O_MEMORY_W  (inst_state_signals_O_MEMORY_W[63:0]                            ), //o
    .signals_O_MEMORY_Y  (inst_state_signals_O_MEMORY_Y[63:0]                            ), //o
    .signals_O_MEMORY_C  (inst_state_signals_O_MEMORY_C[63:0]                            ), //o
    .signals_O_MEMORY_H  (inst_state_signals_O_MEMORY_H[63:0]                            ), //o
    .signals_O_POS       (inst_state_signals_O_POS[11:0]                                 ), //o
    .signals_O_T         (inst_state_signals_O_T                                         ), //o
    .m_axi_awvalid       (inst_state_m_axi_awvalid                                       ), //o
    .m_axi_awready       (m_axi_awready                                                  ), //i
    .m_axi_awaddr        (inst_state_m_axi_awaddr[47:0]                                  ), //o
    .m_axi_awid          (inst_state_m_axi_awid                                          ), //o
    .m_axi_awregion      (inst_state_m_axi_awregion[3:0]                                 ), //o
    .m_axi_awlen         (inst_state_m_axi_awlen[7:0]                                    ), //o
    .m_axi_awsize        (inst_state_m_axi_awsize[2:0]                                   ), //o
    .m_axi_awburst       (inst_state_m_axi_awburst[1:0]                                  ), //o
    .m_axi_awlock        (inst_state_m_axi_awlock                                        ), //o
    .m_axi_awcache       (inst_state_m_axi_awcache[3:0]                                  ), //o
    .m_axi_awqos         (inst_state_m_axi_awqos[3:0]                                    ), //o
    .m_axi_awuser        (inst_state_m_axi_awuser                                        ), //o
    .m_axi_awprot        (inst_state_m_axi_awprot[2:0]                                   ), //o
    .m_axi_wvalid        (inst_state_m_axi_wvalid                                        ), //o
    .m_axi_wready        (m_axi_wready                                                   ), //i
    .m_axi_wdata         (inst_state_m_axi_wdata[255:0]                                  ), //o
    .m_axi_wstrb         (inst_state_m_axi_wstrb[31:0]                                   ), //o
    .m_axi_wuser         (inst_state_m_axi_wuser                                         ), //o
    .m_axi_wlast         (inst_state_m_axi_wlast                                         ), //o
    .m_axi_bvalid        (m_axi_bvalid                                                   ), //i
    .m_axi_bready        (inst_state_m_axi_bready                                        ), //o
    .m_axi_bid           (m_axi_bid                                                      ), //i
    .m_axi_bresp         (m_axi_bresp[1:0]                                               ), //i
    .m_axi_buser         (m_axi_buser                                                    ), //i
    .m_axi_arvalid       (inst_state_m_axi_arvalid                                       ), //o
    .m_axi_arready       (m_axi_arready                                                  ), //i
    .m_axi_araddr        (inst_state_m_axi_araddr[47:0]                                  ), //o
    .m_axi_arid          (inst_state_m_axi_arid                                          ), //o
    .m_axi_arregion      (inst_state_m_axi_arregion[3:0]                                 ), //o
    .m_axi_arlen         (inst_state_m_axi_arlen[7:0]                                    ), //o
    .m_axi_arsize        (inst_state_m_axi_arsize[2:0]                                   ), //o
    .m_axi_arburst       (inst_state_m_axi_arburst[1:0]                                  ), //o
    .m_axi_arlock        (inst_state_m_axi_arlock                                        ), //o
    .m_axi_arcache       (inst_state_m_axi_arcache[3:0]                                  ), //o
    .m_axi_arqos         (inst_state_m_axi_arqos[3:0]                                    ), //o
    .m_axi_aruser        (inst_state_m_axi_aruser                                        ), //o
    .m_axi_arprot        (inst_state_m_axi_arprot[2:0]                                   ), //o
    .m_axi_rvalid        (m_axi_rvalid                                                   ), //i
    .m_axi_rready        (inst_state_m_axi_rready                                        ), //o
    .m_axi_rdata         (m_axi_rdata[255:0]                                             ), //i
    .m_axi_rid           (m_axi_rid                                                      ), //i
    .m_axi_rresp         (m_axi_rresp[1:0]                                               ), //i
    .m_axi_rlast         (m_axi_rlast                                                    ), //i
    .m_axi_ruser         (m_axi_ruser                                                    ), //i
    .x_stream_TVALID     (inst_state_x_stream_TVALID                                     ), //o
    .x_stream_TREADY     (toplevel_inst_state_x_stream_fifo_io_push_ready                ), //i
    .x_stream_TDATA      (inst_state_x_stream_TDATA[255:0]                               ), //o
    .mem_stream_TVALID   (inst_state_mem_stream_TVALID                                   ), //o
    .mem_stream_TREADY   (toplevel_inst_state_mem_stream_fifo_io_push_ready              ), //i
    .mem_stream_TDATA    (inst_state_mem_stream_TDATA[255:0]                             ), //o
    .conv_stream_TVALID  (inst_state_conv_stream_TVALID                                  ), //o
    .conv_stream_TREADY  (toplevel_inst_state_conv_stream_fifo_io_push_ready             ), //i
    .conv_stream_TDATA   (inst_state_conv_stream_TDATA[255:0]                            ), //o
    .conv2_stream_TVALID (toplevel_inst_flow_conv2_stream_fifo_io_pop_valid              ), //i
    .conv2_stream_TREADY (inst_state_conv2_stream_TREADY                                 ), //o
    .conv2_stream_TDATA  (toplevel_inst_flow_conv2_stream_fifo_io_pop_payload_data[255:0]), //i
    .ht_stream_TVALID    (inst_state_ht_stream_TVALID                                    ), //o
    .ht_stream_TREADY    (toplevel_inst_state_ht_stream_fifo_io_push_ready               ), //i
    .ht_stream_TDATA     (inst_state_ht_stream_TDATA[255:0]                              ), //o
    .ht2_stream_TVALID   (toplevel_inst_flow_ht2_stream_fifo_io_pop_valid                ), //i
    .ht2_stream_TREADY   (inst_state_ht2_stream_TREADY                                   ), //o
    .ht2_stream_TDATA    (toplevel_inst_flow_ht2_stream_fifo_io_pop_payload_data[255:0]  ), //i
    .y_stream_TVALID     (y_stream_fifo_io_pop_valid                                     ), //i
    .y_stream_TREADY     (inst_state_y_stream_TREADY                                     ), //o
    .y_stream_TDATA      (y_stream_fifo_io_pop_payload_data[255:0]                       ), //i
    .idle                (inst_state_idle                                                )  //o
  );
  M_AXI_FLOW_wrapper inst_flow (
    .resetn              (resetn                                                         ), //i
    .clk                 (clk                                                            ), //i
    .signals_I_L_BEGIN   (inst_state_signals_O_L_BEGIN[31:0]                             ), //i
    .signals_I_L_CLOSE   (inst_state_signals_O_L_CLOSE[31:0]                             ), //i
    .signals_I_MEMORY_X  (inst_state_signals_O_MEMORY_X[63:0]                            ), //i
    .signals_I_MEMORY_W  (inst_state_signals_O_MEMORY_W[63:0]                            ), //i
    .signals_I_MEMORY_Y  (inst_state_signals_O_MEMORY_Y[63:0]                            ), //i
    .signals_I_MEMORY_C  (inst_state_signals_O_MEMORY_C[63:0]                            ), //i
    .signals_I_MEMORY_H  (inst_state_signals_O_MEMORY_H[63:0]                            ), //i
    .signals_I_POS       (inst_state_signals_O_POS[11:0]                                 ), //i
    .signals_I_T         (inst_state_signals_O_T                                         ), //i
    .signals_O_L_BEGIN   (inst_flow_signals_O_L_BEGIN[31:0]                              ), //o
    .signals_O_L_CLOSE   (inst_flow_signals_O_L_CLOSE[31:0]                              ), //o
    .signals_O_MEMORY_X  (inst_flow_signals_O_MEMORY_X[63:0]                             ), //o
    .signals_O_MEMORY_W  (inst_flow_signals_O_MEMORY_W[63:0]                             ), //o
    .signals_O_MEMORY_Y  (inst_flow_signals_O_MEMORY_Y[63:0]                             ), //o
    .signals_O_MEMORY_C  (inst_flow_signals_O_MEMORY_C[63:0]                             ), //o
    .signals_O_MEMORY_H  (inst_flow_signals_O_MEMORY_H[63:0]                             ), //o
    .signals_O_POS       (inst_flow_signals_O_POS[11:0]                                  ), //o
    .signals_O_T         (inst_flow_signals_O_T                                          ), //o
    .mem_stream_TVALID   (toplevel_inst_state_mem_stream_fifo_io_pop_valid               ), //i
    .mem_stream_TREADY   (inst_flow_mem_stream_TREADY                                    ), //o
    .mem_stream_TDATA    (toplevel_inst_state_mem_stream_fifo_io_pop_payload_data[255:0] ), //i
    .conv_stream_TVALID  (toplevel_inst_state_conv_stream_fifo_io_pop_valid              ), //i
    .conv_stream_TREADY  (inst_flow_conv_stream_TREADY                                   ), //o
    .conv_stream_TDATA   (toplevel_inst_state_conv_stream_fifo_io_pop_payload_data[255:0]), //i
    .conv2_stream_TVALID (inst_flow_conv2_stream_TVALID                                  ), //o
    .conv2_stream_TREADY (toplevel_inst_flow_conv2_stream_fifo_io_push_ready             ), //i
    .conv2_stream_TDATA  (inst_flow_conv2_stream_TDATA[255:0]                            ), //o
    .ht_stream_TVALID    (toplevel_inst_state_ht_stream_fifo_io_pop_valid                ), //i
    .ht_stream_TREADY    (inst_flow_ht_stream_TREADY                                     ), //o
    .ht_stream_TDATA     (toplevel_inst_state_ht_stream_fifo_io_pop_payload_data[255:0]  ), //i
    .ht2_stream_TVALID   (inst_flow_ht2_stream_TVALID                                    ), //o
    .ht2_stream_TREADY   (toplevel_inst_flow_ht2_stream_fifo_io_push_ready               ), //i
    .ht2_stream_TDATA    (inst_flow_ht2_stream_TDATA[255:0]                              ), //o
    .wq_stream_TVALID    (inst_flow_wq_stream_TVALID                                     ), //o
    .wq_stream_TREADY    (toplevel_inst_flow_wq_stream_fifo_io_push_ready                ), //i
    .wq_stream_TDATA     (inst_flow_wq_stream_TDATA[255:0]                               ), //o
    .ws1_stream_TVALID   (inst_flow_ws1_stream_TVALID                                    ), //o
    .ws1_stream_TREADY   (toplevel_inst_flow_ws1_stream_fifo_io_push_ready               ), //i
    .ws1_stream_TDATA    (inst_flow_ws1_stream_TDATA[23:0]                               ), //o
    .ws2_stream_TVALID   (inst_flow_ws2_stream_TVALID                                    ), //o
    .ws2_stream_TREADY   (toplevel_inst_flow_ws2_stream_fifo_io_push_ready               ), //i
    .ws2_stream_TDATA    (inst_flow_ws2_stream_TDATA[23:0]                               ), //o
    .cq_stream_TVALID    (inst_flow_cq_stream_TVALID                                     ), //o
    .cq_stream_TREADY    (toplevel_inst_flow_cq_stream_fifo_io_push_ready                ), //i
    .cq_stream_TDATA     (inst_flow_cq_stream_TDATA[255:0]                               ), //o
    .cs_stream_TVALID    (inst_flow_cs_stream_TVALID                                     ), //o
    .cs_stream_TREADY    (toplevel_inst_flow_cs_stream_fifo_io_push_ready                ), //i
    .cs_stream_TDATA     (inst_flow_cs_stream_TDATA[255:0]                               ), //o
    .cq2_stream_TVALID   (cq2_stream_fifo_io_pop_valid                                   ), //i
    .cq2_stream_TREADY   (inst_flow_cq2_stream_TREADY                                    ), //o
    .cq2_stream_TDATA    (cq2_stream_fifo_io_pop_payload_data[255:0]                     ), //i
    .cs2_stream_TVALID   (cs2_stream_fifo_io_pop_valid                                   ), //i
    .cs2_stream_TREADY   (inst_flow_cs2_stream_TREADY                                    ), //o
    .cs2_stream_TDATA    (cs2_stream_fifo_io_pop_payload_data[255:0]                     ), //i
    .hq_stream_TVALID    (inst_flow_hq_stream_TVALID                                     ), //o
    .hq_stream_TREADY    (toplevel_inst_flow_hq_stream_fifo_io_push_ready                ), //i
    .hq_stream_TDATA     (inst_flow_hq_stream_TDATA[255:0]                               ), //o
    .hs_stream_TVALID    (inst_flow_hs_stream_TVALID                                     ), //o
    .hs_stream_TREADY    (toplevel_inst_flow_hs_stream_fifo_io_push_ready                ), //i
    .hs_stream_TDATA     (inst_flow_hs_stream_TDATA[255:0]                               ), //o
    .hq2_stream_TVALID   (hq2_stream_fifo_io_pop_valid                                   ), //i
    .hq2_stream_TREADY   (inst_flow_hq2_stream_TREADY                                    ), //o
    .hq2_stream_TDATA    (hq2_stream_fifo_io_pop_payload_data[255:0]                     ), //i
    .hs2_stream_TVALID   (hs2_stream_fifo_io_pop_valid                                   ), //i
    .hs2_stream_TREADY   (inst_flow_hs2_stream_TREADY                                    ), //o
    .hs2_stream_TDATA    (hs2_stream_fifo_io_pop_payload_data[255:0]                     )  //i
  );
  StreamFifo y_stream_fifo (
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
  StreamFifo cq2_stream_fifo (
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
  StreamFifo cs2_stream_fifo (
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
  StreamFifo hq2_stream_fifo (
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
  StreamFifo hs2_stream_fifo (
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
  StreamFifo toplevel_inst_state_x_stream_fifo (
    .io_push_valid        (inst_state_x_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_state_x_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_x_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_state_x_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (x_stream_TREADY                                             ), //i
    .io_pop_payload_data  (toplevel_inst_state_x_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_state_x_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_state_x_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_inst_state_x_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_6 toplevel_inst_state_mem_stream_fifo (
    .io_push_valid        (inst_state_mem_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_state_mem_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_mem_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_state_mem_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_mem_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_inst_state_mem_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_state_mem_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_state_mem_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (toplevel_inst_state_mem_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                           ), //i
    .resetn               (resetn                                                        )  //i
  );
  StreamFifo_6 toplevel_inst_state_conv_stream_fifo (
    .io_push_valid        (inst_state_conv_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_state_conv_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_conv_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_state_conv_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_conv_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_inst_state_conv_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_state_conv_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_state_conv_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (toplevel_inst_state_conv_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_6 toplevel_inst_state_ht_stream_fifo (
    .io_push_valid        (inst_state_ht_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_state_ht_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_state_ht_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_state_ht_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_flow_ht_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_inst_state_ht_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_state_ht_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_state_ht_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (toplevel_inst_state_ht_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_6 toplevel_inst_flow_conv2_stream_fifo (
    .io_push_valid        (inst_flow_conv2_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_flow_conv2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_conv2_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_conv2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_state_conv2_stream_TREADY                                 ), //i
    .io_pop_payload_data  (toplevel_inst_flow_conv2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_flow_conv2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_flow_conv2_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (toplevel_inst_flow_conv2_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                            ), //i
    .resetn               (resetn                                                         )  //i
  );
  StreamFifo_6 toplevel_inst_flow_ht2_stream_fifo (
    .io_push_valid        (inst_flow_ht2_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_flow_ht2_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_ht2_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_ht2_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_state_ht2_stream_TREADY                                 ), //i
    .io_pop_payload_data  (toplevel_inst_flow_ht2_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_flow_ht2_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_flow_ht2_stream_fifo_io_occupancy[10:0]        ), //o
    .io_availability      (toplevel_inst_flow_ht2_stream_fifo_io_availability[10:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_inst_flow_wq_stream_fifo (
    .io_push_valid        (inst_flow_wq_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_flow_wq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_wq_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_wq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (wq_stream_TREADY                                            ), //i
    .io_pop_payload_data  (toplevel_inst_flow_wq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_flow_wq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_flow_wq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_inst_flow_wq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_12 toplevel_inst_flow_ws1_stream_fifo (
    .io_push_valid        (inst_flow_ws1_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_inst_flow_ws1_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_flow_ws1_stream_TDATA[23:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_ws1_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ws1_stream_TREADY                                           ), //i
    .io_pop_payload_data  (toplevel_inst_flow_ws1_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (toplevel_inst_flow_ws1_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_inst_flow_ws1_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_inst_flow_ws1_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_12 toplevel_inst_flow_ws2_stream_fifo (
    .io_push_valid        (inst_flow_ws2_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_inst_flow_ws2_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_flow_ws2_stream_TDATA[23:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_ws2_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (ws2_stream_TREADY                                           ), //i
    .io_pop_payload_data  (toplevel_inst_flow_ws2_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (toplevel_inst_flow_ws2_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_inst_flow_ws2_stream_fifo_io_occupancy[3:0]        ), //o
    .io_availability      (toplevel_inst_flow_ws2_stream_fifo_io_availability[3:0]     ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo toplevel_inst_flow_cq_stream_fifo (
    .io_push_valid        (inst_flow_cq_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_flow_cq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_cq_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_cq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cq_stream_TREADY                                            ), //i
    .io_pop_payload_data  (toplevel_inst_flow_cq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_flow_cq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_flow_cq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_inst_flow_cq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo toplevel_inst_flow_cs_stream_fifo (
    .io_push_valid        (inst_flow_cs_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_flow_cs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_cs_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_cs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (cs_stream_TREADY                                            ), //i
    .io_pop_payload_data  (toplevel_inst_flow_cs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_flow_cs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_flow_cs_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_inst_flow_cs_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo toplevel_inst_flow_hq_stream_fifo (
    .io_push_valid        (inst_flow_hq_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_flow_hq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_hq_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_hq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hq_stream_TREADY                                            ), //i
    .io_pop_payload_data  (toplevel_inst_flow_hq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_flow_hq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_flow_hq_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_inst_flow_hq_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo toplevel_inst_flow_hs_stream_fifo (
    .io_push_valid        (inst_flow_hs_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_flow_hs_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_flow_hs_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_flow_hs_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (hs_stream_TREADY                                            ), //i
    .io_pop_payload_data  (toplevel_inst_flow_hs_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_flow_hs_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_flow_hs_stream_fifo_io_occupancy[3:0]         ), //o
    .io_availability      (toplevel_inst_flow_hs_stream_fifo_io_availability[3:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
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
  assign x_stream_TVALID = toplevel_inst_state_x_stream_fifo_io_pop_valid;
  assign x_stream_TDATA = toplevel_inst_state_x_stream_fifo_io_pop_payload_data;
  assign wq_stream_TVALID = toplevel_inst_flow_wq_stream_fifo_io_pop_valid;
  assign wq_stream_TDATA = toplevel_inst_flow_wq_stream_fifo_io_pop_payload_data;
  assign ws1_stream_TVALID = toplevel_inst_flow_ws1_stream_fifo_io_pop_valid;
  assign ws1_stream_TDATA = toplevel_inst_flow_ws1_stream_fifo_io_pop_payload_data;
  assign ws2_stream_TVALID = toplevel_inst_flow_ws2_stream_fifo_io_pop_valid;
  assign ws2_stream_TDATA = toplevel_inst_flow_ws2_stream_fifo_io_pop_payload_data;
  assign cq_stream_TVALID = toplevel_inst_flow_cq_stream_fifo_io_pop_valid;
  assign cq_stream_TDATA = toplevel_inst_flow_cq_stream_fifo_io_pop_payload_data;
  assign cs_stream_TVALID = toplevel_inst_flow_cs_stream_fifo_io_pop_valid;
  assign cs_stream_TDATA = toplevel_inst_flow_cs_stream_fifo_io_pop_payload_data;
  assign hq_stream_TVALID = toplevel_inst_flow_hq_stream_fifo_io_pop_valid;
  assign hq_stream_TDATA = toplevel_inst_flow_hq_stream_fifo_io_pop_payload_data;
  assign hs_stream_TVALID = toplevel_inst_flow_hs_stream_fifo_io_pop_valid;
  assign hs_stream_TDATA = toplevel_inst_flow_hs_stream_fifo_io_pop_payload_data;
  assign y_stream_fifo_io_flush = 1'b0;
  assign cq2_stream_fifo_io_flush = 1'b0;
  assign cs2_stream_fifo_io_flush = 1'b0;
  assign hq2_stream_fifo_io_flush = 1'b0;
  assign hs2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_state_x_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_state_mem_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_state_conv_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_state_ht_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_conv2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_ht2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_wq_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_ws1_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_ws2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_cq_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_cs_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_hq_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_flow_hs_stream_fifo_io_flush = 1'b0;

endmodule

//StreamFifo_17 replaced by StreamFifo

//StreamFifo_16 replaced by StreamFifo

//StreamFifo_15 replaced by StreamFifo

//StreamFifo_14 replaced by StreamFifo

//StreamFifo_13 replaced by StreamFifo_12

module StreamFifo_12 (
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

//StreamFifo_11 replaced by StreamFifo

//StreamFifo_10 replaced by StreamFifo_6

//StreamFifo_9 replaced by StreamFifo_6

//StreamFifo_8 replaced by StreamFifo_6

//StreamFifo_7 replaced by StreamFifo_6

module StreamFifo_6 (
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

//StreamFifo_5 replaced by StreamFifo

//StreamFifo_4 replaced by StreamFifo

//StreamFifo_3 replaced by StreamFifo

//StreamFifo_2 replaced by StreamFifo

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
  wire       [31:0]   manager_2_signals_O_L_BEGIN;
  wire       [31:0]   manager_2_signals_O_L_CLOSE;
  wire       [63:0]   manager_2_signals_O_MEMORY_X;
  wire       [63:0]   manager_2_signals_O_MEMORY_W;
  wire       [63:0]   manager_2_signals_O_MEMORY_Y;
  wire       [63:0]   manager_2_signals_O_MEMORY_C;
  wire       [63:0]   manager_2_signals_O_MEMORY_H;
  wire       [11:0]   manager_2_signals_O_POS;
  wire                manager_2_signals_O_T;
  wire                manager_2_ap_ctrl_ap_start;
  wire                manager_2_ap_ctrl_ap_continue;
  wire       [31:0]   manager_2_l;

  M_AXI_FLOW black_box (
    .ap_clk              (clk                                ), //i
    .ap_rst_n            (resetn                             ), //i
    .l_begin             (manager_2_signals_O_L_BEGIN[31:0]  ), //i
    .l_close             (manager_2_signals_O_L_CLOSE[31:0]  ), //i
    .ap_start            (manager_2_ap_ctrl_ap_start         ), //i
    .ap_continue         (manager_2_ap_ctrl_ap_continue      ), //i
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
  Manager_1 manager_2 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]           ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]           ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]          ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]          ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]          ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]          ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]          ), //i
    .signals_I_POS       (signals_I_POS[11:0]               ), //i
    .signals_I_T         (signals_I_T                       ), //i
    .signals_O_L_BEGIN   (manager_2_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_2_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_2_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_2_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_2_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_2_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_2_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_2_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_2_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_2_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_2_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                 ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                 ), //i
    .l                   (manager_2_l[31:0]                 ), //o
    .clk                 (clk                               ), //i
    .resetn              (resetn                            )  //i
  );
  assign signals_O_L_BEGIN = manager_2_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_2_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_2_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_2_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_2_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_2_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_2_signals_O_MEMORY_H;
  assign signals_O_POS = manager_2_signals_O_POS;
  assign signals_O_T = manager_2_signals_O_T;
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
  wire       [31:0]   manager_2_signals_O_L_BEGIN;
  wire       [31:0]   manager_2_signals_O_L_CLOSE;
  wire       [63:0]   manager_2_signals_O_MEMORY_X;
  wire       [63:0]   manager_2_signals_O_MEMORY_W;
  wire       [63:0]   manager_2_signals_O_MEMORY_Y;
  wire       [63:0]   manager_2_signals_O_MEMORY_C;
  wire       [63:0]   manager_2_signals_O_MEMORY_H;
  wire       [11:0]   manager_2_signals_O_POS;
  wire                manager_2_signals_O_T;
  wire                manager_2_ap_ctrl_ap_start;
  wire                manager_2_ap_ctrl_ap_continue;
  wire       [31:0]   manager_2_l;

  M_AXI_STATIC black_box (
    .ap_clk              (clk                               ), //i
    .ap_rst_n            (resetn                            ), //i
    .l_begin             (manager_2_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_2_signals_O_L_CLOSE[31:0] ), //i
    .memory_x            (manager_2_signals_O_MEMORY_X[63:0]), //i
    .memory_w            (manager_2_signals_O_MEMORY_W[63:0]), //i
    .memory_y            (manager_2_signals_O_MEMORY_Y[63:0]), //i
    .memory_c            (manager_2_signals_O_MEMORY_C[63:0]), //i
    .memory_h            (manager_2_signals_O_MEMORY_H[63:0]), //i
    .ap_start            (manager_2_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_2_ap_ctrl_ap_continue     ), //i
    .ap_idle             (black_box_ap_idle                 ), //o
    .ap_ready            (black_box_ap_ready                ), //o
    .ap_done             (black_box_ap_done                 ), //o
    .m_axi_gmem_AWVALID  (black_box_m_axi_gmem_AWVALID      ), //o
    .m_axi_gmem_AWREADY  (m_axi_awready                     ), //i
    .m_axi_gmem_AWADDR   (black_box_m_axi_gmem_AWADDR[47:0] ), //o
    .m_axi_gmem_AWID     (black_box_m_axi_gmem_AWID         ), //o
    .m_axi_gmem_AWUSER   (black_box_m_axi_gmem_AWUSER       ), //o
    .m_axi_gmem_AWREGION (black_box_m_axi_gmem_AWREGION[3:0]), //o
    .m_axi_gmem_AWLEN    (black_box_m_axi_gmem_AWLEN[7:0]   ), //o
    .m_axi_gmem_AWSIZE   (black_box_m_axi_gmem_AWSIZE[2:0]  ), //o
    .m_axi_gmem_AWBURST  (black_box_m_axi_gmem_AWBURST[1:0] ), //o
    .m_axi_gmem_AWLOCK   (black_box_m_axi_gmem_AWLOCK       ), //o
    .m_axi_gmem_AWCACHE  (black_box_m_axi_gmem_AWCACHE[3:0] ), //o
    .m_axi_gmem_AWQOS    (black_box_m_axi_gmem_AWQOS[3:0]   ), //o
    .m_axi_gmem_AWPROT   (black_box_m_axi_gmem_AWPROT[2:0]  ), //o
    .m_axi_gmem_WVALID   (black_box_m_axi_gmem_WVALID       ), //o
    .m_axi_gmem_WREADY   (m_axi_wready                      ), //i
    .m_axi_gmem_WDATA    (black_box_m_axi_gmem_WDATA[255:0] ), //o
    .m_axi_gmem_WSTRB    (black_box_m_axi_gmem_WSTRB[31:0]  ), //o
    .m_axi_gmem_WLAST    (black_box_m_axi_gmem_WLAST        ), //o
    .m_axi_gmem_WID      (black_box_m_axi_gmem_WID          ), //o
    .m_axi_gmem_WUSER    (black_box_m_axi_gmem_WUSER        ), //o
    .m_axi_gmem_ARVALID  (black_box_m_axi_gmem_ARVALID      ), //o
    .m_axi_gmem_ARREADY  (m_axi_arready                     ), //i
    .m_axi_gmem_ARADDR   (black_box_m_axi_gmem_ARADDR[47:0] ), //o
    .m_axi_gmem_ARID     (black_box_m_axi_gmem_ARID         ), //o
    .m_axi_gmem_ARUSER   (black_box_m_axi_gmem_ARUSER       ), //o
    .m_axi_gmem_ARREGION (black_box_m_axi_gmem_ARREGION[3:0]), //o
    .m_axi_gmem_ARLEN    (black_box_m_axi_gmem_ARLEN[7:0]   ), //o
    .m_axi_gmem_ARSIZE   (black_box_m_axi_gmem_ARSIZE[2:0]  ), //o
    .m_axi_gmem_ARBURST  (black_box_m_axi_gmem_ARBURST[1:0] ), //o
    .m_axi_gmem_ARLOCK   (black_box_m_axi_gmem_ARLOCK       ), //o
    .m_axi_gmem_ARCACHE  (black_box_m_axi_gmem_ARCACHE[3:0] ), //o
    .m_axi_gmem_ARQOS    (black_box_m_axi_gmem_ARQOS[3:0]   ), //o
    .m_axi_gmem_ARPROT   (black_box_m_axi_gmem_ARPROT[2:0]  ), //o
    .m_axi_gmem_RVALID   (m_axi_rvalid                      ), //i
    .m_axi_gmem_RREADY   (black_box_m_axi_gmem_RREADY       ), //o
    .m_axi_gmem_RDATA    (m_axi_rdata[255:0]                ), //i
    .m_axi_gmem_RLAST    (m_axi_rlast                       ), //i
    .m_axi_gmem_RID      (m_axi_rid                         ), //i
    .m_axi_gmem_RUSER    (m_axi_ruser                       ), //i
    .m_axi_gmem_RRESP    (m_axi_rresp[1:0]                  ), //i
    .m_axi_gmem_BVALID   (m_axi_bvalid                      ), //i
    .m_axi_gmem_BREADY   (black_box_m_axi_gmem_BREADY       ), //o
    .m_axi_gmem_BID      (m_axi_bid                         ), //i
    .m_axi_gmem_BUSER    (m_axi_buser                       ), //i
    .m_axi_gmem_BRESP    (m_axi_bresp[1:0]                  ), //i
    .x_stream_TDATA      (black_box_x_stream_TDATA[255:0]   ), //o
    .x_stream_TVALID     (black_box_x_stream_TVALID         ), //o
    .x_stream_TREADY     (x_stream_TREADY                   ), //i
    .mem_stream_TDATA    (black_box_mem_stream_TDATA[255:0] ), //o
    .mem_stream_TVALID   (black_box_mem_stream_TVALID       ), //o
    .mem_stream_TREADY   (mem_stream_TREADY                 ), //i
    .conv_stream_TDATA   (black_box_conv_stream_TDATA[255:0]), //o
    .conv_stream_TVALID  (black_box_conv_stream_TVALID      ), //o
    .conv_stream_TREADY  (conv_stream_TREADY                ), //i
    .conv2_stream_TDATA  (conv2_stream_TDATA[255:0]         ), //i
    .conv2_stream_TVALID (conv2_stream_TVALID               ), //i
    .conv2_stream_TREADY (black_box_conv2_stream_TREADY     ), //o
    .ht_stream_TDATA     (black_box_ht_stream_TDATA[255:0]  ), //o
    .ht_stream_TVALID    (black_box_ht_stream_TVALID        ), //o
    .ht_stream_TREADY    (ht_stream_TREADY                  ), //i
    .ht2_stream_TDATA    (ht2_stream_TDATA[255:0]           ), //i
    .ht2_stream_TVALID   (ht2_stream_TVALID                 ), //i
    .ht2_stream_TREADY   (black_box_ht2_stream_TREADY       ), //o
    .y_stream_TDATA      (y_stream_TDATA[255:0]             ), //i
    .y_stream_TVALID     (y_stream_TVALID                   ), //i
    .y_stream_TREADY     (black_box_y_stream_TREADY         )  //o
  );
  Manager_1 manager_2 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]           ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]           ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]          ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]          ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]          ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]          ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]          ), //i
    .signals_I_POS       (signals_I_POS[11:0]               ), //i
    .signals_I_T         (signals_I_T                       ), //i
    .signals_O_L_BEGIN   (manager_2_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_2_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_2_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_2_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_2_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_2_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_2_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_2_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_2_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_2_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_2_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                 ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                 ), //i
    .l                   (manager_2_l[31:0]                 ), //o
    .clk                 (clk                               ), //i
    .resetn              (resetn                            )  //i
  );
  assign signals_O_L_BEGIN = manager_2_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_2_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_2_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_2_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_2_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_2_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_2_signals_O_MEMORY_H;
  assign signals_O_POS = manager_2_signals_O_POS;
  assign signals_O_T = manager_2_signals_O_T;
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

//Manager replaced by Manager_1

module Manager_1 (
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

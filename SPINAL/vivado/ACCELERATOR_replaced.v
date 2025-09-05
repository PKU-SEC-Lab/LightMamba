// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : ACCELERATOR
// Git hash  : 931ae4c9794c8356d3971a161cbdc69f14a5bf26

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

  wire                toplevel_inst_m_axi_x_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_wq_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_ws1_stream_fifo_io_flush;
  wire                toplevel_inst_m_axi_ws2_stream_fifo_io_flush;
  wire                toplevel_inst_llama_y_stream_fifo_io_flush;
  wire       [31:0]   inst_llama_signals_O_L_BEGIN;
  wire       [31:0]   inst_llama_signals_O_L_CLOSE;
  wire       [63:0]   inst_llama_signals_O_MEMORY_X;
  wire       [63:0]   inst_llama_signals_O_MEMORY_W;
  wire       [63:0]   inst_llama_signals_O_MEMORY_Y;
  wire       [11:0]   inst_llama_signals_O_POS;
  wire                inst_llama_signals_O_T;
  wire                inst_llama_x_stream_TREADY;
  wire                inst_llama_w_stream_TREADY;
  wire                inst_llama_s1_stream_TREADY;
  wire                inst_llama_s2_stream_TREADY;
  wire                inst_llama_y_stream_TVALID;
  wire       [735:0]  inst_llama_y_stream_TDATA;
  wire       [31:0]   inst_m_axi_signals_O_L_BEGIN;
  wire       [31:0]   inst_m_axi_signals_O_L_CLOSE;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_X;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_W;
  wire       [63:0]   inst_m_axi_signals_O_MEMORY_Y;
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
  wire       [735:0]  inst_m_axi_x_stream_TDATA;
  wire                inst_m_axi_wq_stream_TVALID;
  wire       [255:0]  inst_m_axi_wq_stream_TDATA;
  wire                inst_m_axi_ws1_stream_TVALID;
  wire       [23:0]   inst_m_axi_ws1_stream_TDATA;
  wire                inst_m_axi_ws2_stream_TVALID;
  wire       [23:0]   inst_m_axi_ws2_stream_TDATA;
  wire                inst_m_axi_y_stream_TREADY;
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
  wire       [11:0]   inst_controller_signals_POS;
  wire                inst_controller_signals_T;
  wire                toplevel_inst_m_axi_x_stream_fifo_io_push_ready;
  wire                toplevel_inst_m_axi_x_stream_fifo_io_pop_valid;
  wire       [735:0]  toplevel_inst_m_axi_x_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_m_axi_x_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_m_axi_x_stream_fifo_io_availability;
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
  wire                toplevel_inst_llama_y_stream_fifo_io_push_ready;
  wire                toplevel_inst_llama_y_stream_fifo_io_pop_valid;
  wire       [735:0]  toplevel_inst_llama_y_stream_fifo_io_pop_payload_data;
  wire       [9:0]    toplevel_inst_llama_y_stream_fifo_io_occupancy;
  wire       [9:0]    toplevel_inst_llama_y_stream_fifo_io_availability;

  LLAMA inst_llama (
    .resetn             (resetn                                                       ), //i
    .clk                (clk                                                          ), //i
    .signals_I_L_BEGIN  (inst_m_axi_signals_O_L_BEGIN[31:0]                           ), //i
    .signals_I_L_CLOSE  (inst_m_axi_signals_O_L_CLOSE[31:0]                           ), //i
    .signals_I_MEMORY_X (inst_m_axi_signals_O_MEMORY_X[63:0]                          ), //i
    .signals_I_MEMORY_W (inst_m_axi_signals_O_MEMORY_W[63:0]                          ), //i
    .signals_I_MEMORY_Y (inst_m_axi_signals_O_MEMORY_Y[63:0]                          ), //i
    .signals_I_POS      (inst_m_axi_signals_O_POS[11:0]                               ), //i
    .signals_I_T        (inst_m_axi_signals_O_T                                       ), //i
    .signals_O_L_BEGIN  (inst_llama_signals_O_L_BEGIN[31:0]                           ), //o
    .signals_O_L_CLOSE  (inst_llama_signals_O_L_CLOSE[31:0]                           ), //o
    .signals_O_MEMORY_X (inst_llama_signals_O_MEMORY_X[63:0]                          ), //o
    .signals_O_MEMORY_W (inst_llama_signals_O_MEMORY_W[63:0]                          ), //o
    .signals_O_MEMORY_Y (inst_llama_signals_O_MEMORY_Y[63:0]                          ), //o
    .signals_O_POS      (inst_llama_signals_O_POS[11:0]                               ), //o
    .signals_O_T        (inst_llama_signals_O_T                                       ), //o
    .x_stream_TVALID    (toplevel_inst_m_axi_x_stream_fifo_io_pop_valid               ), //i
    .x_stream_TREADY    (inst_llama_x_stream_TREADY                                   ), //o
    .x_stream_TDATA     (toplevel_inst_m_axi_x_stream_fifo_io_pop_payload_data[735:0] ), //i
    .w_stream_TVALID    (toplevel_inst_m_axi_wq_stream_fifo_io_pop_valid              ), //i
    .w_stream_TREADY    (inst_llama_w_stream_TREADY                                   ), //o
    .w_stream_TDATA     (toplevel_inst_m_axi_wq_stream_fifo_io_pop_payload_data[255:0]), //i
    .s1_stream_TVALID   (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_valid             ), //i
    .s1_stream_TREADY   (inst_llama_s1_stream_TREADY                                  ), //o
    .s1_stream_TDATA    (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_payload_data[23:0]), //i
    .s2_stream_TVALID   (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_valid             ), //i
    .s2_stream_TREADY   (inst_llama_s2_stream_TREADY                                  ), //o
    .s2_stream_TDATA    (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_payload_data[23:0]), //i
    .y_stream_TVALID    (inst_llama_y_stream_TVALID                                   ), //o
    .y_stream_TREADY    (toplevel_inst_llama_y_stream_fifo_io_push_ready              ), //i
    .y_stream_TDATA     (inst_llama_y_stream_TDATA[735:0]                             )  //o
  );
  M_AXI_wrapper inst_m_axi (
    .resetn             (resetn                                                      ), //i
    .clk                (clk                                                         ), //i
    .signals_I_L_BEGIN  (inst_controller_signals_L_BEGIN[31:0]                       ), //i
    .signals_I_L_CLOSE  (inst_controller_signals_L_CLOSE[31:0]                       ), //i
    .signals_I_MEMORY_X (inst_controller_signals_MEMORY_X[63:0]                      ), //i
    .signals_I_MEMORY_W (inst_controller_signals_MEMORY_W[63:0]                      ), //i
    .signals_I_MEMORY_Y (inst_controller_signals_MEMORY_Y[63:0]                      ), //i
    .signals_I_POS      (inst_controller_signals_POS[11:0]                           ), //i
    .signals_I_T        (inst_controller_signals_T                                   ), //i
    .signals_O_L_BEGIN  (inst_m_axi_signals_O_L_BEGIN[31:0]                          ), //o
    .signals_O_L_CLOSE  (inst_m_axi_signals_O_L_CLOSE[31:0]                          ), //o
    .signals_O_MEMORY_X (inst_m_axi_signals_O_MEMORY_X[63:0]                         ), //o
    .signals_O_MEMORY_W (inst_m_axi_signals_O_MEMORY_W[63:0]                         ), //o
    .signals_O_MEMORY_Y (inst_m_axi_signals_O_MEMORY_Y[63:0]                         ), //o
    .signals_O_POS      (inst_m_axi_signals_O_POS[11:0]                              ), //o
    .signals_O_T        (inst_m_axi_signals_O_T                                      ), //o
    .m_axi_awvalid      (inst_m_axi_m_axi_awvalid                                    ), //o
    .m_axi_awready      (m_axi_awready                                               ), //i
    .m_axi_awaddr       (inst_m_axi_m_axi_awaddr[47:0]                               ), //o
    .m_axi_awid         (inst_m_axi_m_axi_awid                                       ), //o
    .m_axi_awregion     (inst_m_axi_m_axi_awregion[3:0]                              ), //o
    .m_axi_awlen        (inst_m_axi_m_axi_awlen[7:0]                                 ), //o
    .m_axi_awsize       (inst_m_axi_m_axi_awsize[2:0]                                ), //o
    .m_axi_awburst      (inst_m_axi_m_axi_awburst[1:0]                               ), //o
    .m_axi_awlock       (inst_m_axi_m_axi_awlock                                     ), //o
    .m_axi_awcache      (inst_m_axi_m_axi_awcache[3:0]                               ), //o
    .m_axi_awqos        (inst_m_axi_m_axi_awqos[3:0]                                 ), //o
    .m_axi_awuser       (inst_m_axi_m_axi_awuser                                     ), //o
    .m_axi_awprot       (inst_m_axi_m_axi_awprot[2:0]                                ), //o
    .m_axi_wvalid       (inst_m_axi_m_axi_wvalid                                     ), //o
    .m_axi_wready       (m_axi_wready                                                ), //i
    .m_axi_wdata        (inst_m_axi_m_axi_wdata[255:0]                               ), //o
    .m_axi_wstrb        (inst_m_axi_m_axi_wstrb[31:0]                                ), //o
    .m_axi_wuser        (inst_m_axi_m_axi_wuser                                      ), //o
    .m_axi_wlast        (inst_m_axi_m_axi_wlast                                      ), //o
    .m_axi_bvalid       (m_axi_bvalid                                                ), //i
    .m_axi_bready       (inst_m_axi_m_axi_bready                                     ), //o
    .m_axi_bid          (m_axi_bid                                                   ), //i
    .m_axi_bresp        (m_axi_bresp[1:0]                                            ), //i
    .m_axi_buser        (m_axi_buser                                                 ), //i
    .m_axi_arvalid      (inst_m_axi_m_axi_arvalid                                    ), //o
    .m_axi_arready      (m_axi_arready                                               ), //i
    .m_axi_araddr       (inst_m_axi_m_axi_araddr[47:0]                               ), //o
    .m_axi_arid         (inst_m_axi_m_axi_arid                                       ), //o
    .m_axi_arregion     (inst_m_axi_m_axi_arregion[3:0]                              ), //o
    .m_axi_arlen        (inst_m_axi_m_axi_arlen[7:0]                                 ), //o
    .m_axi_arsize       (inst_m_axi_m_axi_arsize[2:0]                                ), //o
    .m_axi_arburst      (inst_m_axi_m_axi_arburst[1:0]                               ), //o
    .m_axi_arlock       (inst_m_axi_m_axi_arlock                                     ), //o
    .m_axi_arcache      (inst_m_axi_m_axi_arcache[3:0]                               ), //o
    .m_axi_arqos        (inst_m_axi_m_axi_arqos[3:0]                                 ), //o
    .m_axi_aruser       (inst_m_axi_m_axi_aruser                                     ), //o
    .m_axi_arprot       (inst_m_axi_m_axi_arprot[2:0]                                ), //o
    .m_axi_rvalid       (m_axi_rvalid                                                ), //i
    .m_axi_rready       (inst_m_axi_m_axi_rready                                     ), //o
    .m_axi_rdata        (m_axi_rdata[255:0]                                          ), //i
    .m_axi_rid          (m_axi_rid                                                   ), //i
    .m_axi_rresp        (m_axi_rresp[1:0]                                            ), //i
    .m_axi_rlast        (m_axi_rlast                                                 ), //i
    .m_axi_ruser        (m_axi_ruser                                                 ), //i
    .x_stream_TVALID    (inst_m_axi_x_stream_TVALID                                  ), //o
    .x_stream_TREADY    (toplevel_inst_m_axi_x_stream_fifo_io_push_ready             ), //i
    .x_stream_TDATA     (inst_m_axi_x_stream_TDATA[735:0]                            ), //o
    .wq_stream_TVALID   (inst_m_axi_wq_stream_TVALID                                 ), //o
    .wq_stream_TREADY   (toplevel_inst_m_axi_wq_stream_fifo_io_push_ready            ), //i
    .wq_stream_TDATA    (inst_m_axi_wq_stream_TDATA[255:0]                           ), //o
    .ws1_stream_TVALID  (inst_m_axi_ws1_stream_TVALID                                ), //o
    .ws1_stream_TREADY  (toplevel_inst_m_axi_ws1_stream_fifo_io_push_ready           ), //i
    .ws1_stream_TDATA   (inst_m_axi_ws1_stream_TDATA[23:0]                           ), //o
    .ws2_stream_TVALID  (inst_m_axi_ws2_stream_TVALID                                ), //o
    .ws2_stream_TREADY  (toplevel_inst_m_axi_ws2_stream_fifo_io_push_ready           ), //i
    .ws2_stream_TDATA   (inst_m_axi_ws2_stream_TDATA[23:0]                           ), //o
    .y_stream_TVALID    (toplevel_inst_llama_y_stream_fifo_io_pop_valid              ), //i
    .y_stream_TREADY    (inst_m_axi_y_stream_TREADY                                  ), //o
    .y_stream_TDATA     (toplevel_inst_llama_y_stream_fifo_io_pop_payload_data[735:0]), //i
    .idle               (inst_m_axi_idle                                             )  //o
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
    .signals_POS      (inst_controller_signals_POS[11:0]     ), //o
    .signals_T        (inst_controller_signals_T             ), //o
    .idle             (inst_m_axi_idle                       ), //i
    .clk              (clk                                   ), //i
    .resetn           (resetn                                )  //i
  );
  StreamFifo toplevel_inst_m_axi_x_stream_fifo (
    .io_push_valid        (inst_m_axi_x_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_m_axi_x_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_m_axi_x_stream_TDATA[735:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_x_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_llama_x_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_x_stream_fifo_io_pop_payload_data[735:0]), //o
    .io_flush             (toplevel_inst_m_axi_x_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_m_axi_x_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_m_axi_x_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                         ), //i
    .resetn               (resetn                                                      )  //i
  );
  StreamFifo_1 toplevel_inst_m_axi_wq_stream_fifo (
    .io_push_valid        (inst_m_axi_wq_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_m_axi_wq_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_m_axi_wq_stream_TDATA[255:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_wq_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_llama_w_stream_TREADY                                   ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_wq_stream_fifo_io_pop_payload_data[255:0]), //o
    .io_flush             (toplevel_inst_m_axi_wq_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_m_axi_wq_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_m_axi_wq_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_2 toplevel_inst_m_axi_ws1_stream_fifo (
    .io_push_valid        (inst_m_axi_ws1_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_inst_m_axi_ws1_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_m_axi_ws1_stream_TDATA[23:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (inst_llama_s1_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_ws1_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (toplevel_inst_m_axi_ws1_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_inst_m_axi_ws1_stream_fifo_io_occupancy[9:0]        ), //o
    .io_availability      (toplevel_inst_m_axi_ws1_stream_fifo_io_availability[9:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo_2 toplevel_inst_m_axi_ws2_stream_fifo (
    .io_push_valid        (inst_m_axi_ws2_stream_TVALID                                 ), //i
    .io_push_ready        (toplevel_inst_m_axi_ws2_stream_fifo_io_push_ready            ), //o
    .io_push_payload_data (inst_m_axi_ws2_stream_TDATA[23:0]                            ), //i
    .io_pop_valid         (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_valid             ), //o
    .io_pop_ready         (inst_llama_s2_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_m_axi_ws2_stream_fifo_io_pop_payload_data[23:0]), //o
    .io_flush             (toplevel_inst_m_axi_ws2_stream_fifo_io_flush                 ), //i
    .io_occupancy         (toplevel_inst_m_axi_ws2_stream_fifo_io_occupancy[9:0]        ), //o
    .io_availability      (toplevel_inst_m_axi_ws2_stream_fifo_io_availability[9:0]     ), //o
    .clk                  (clk                                                          ), //i
    .resetn               (resetn                                                       )  //i
  );
  StreamFifo toplevel_inst_llama_y_stream_fifo (
    .io_push_valid        (inst_llama_y_stream_TVALID                                  ), //i
    .io_push_ready        (toplevel_inst_llama_y_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (inst_llama_y_stream_TDATA[735:0]                            ), //i
    .io_pop_valid         (toplevel_inst_llama_y_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (inst_m_axi_y_stream_TREADY                                  ), //i
    .io_pop_payload_data  (toplevel_inst_llama_y_stream_fifo_io_pop_payload_data[735:0]), //o
    .io_flush             (toplevel_inst_llama_y_stream_fifo_io_flush                  ), //i
    .io_occupancy         (toplevel_inst_llama_y_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (toplevel_inst_llama_y_stream_fifo_io_availability[9:0]      ), //o
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
  assign toplevel_inst_m_axi_x_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_wq_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_ws1_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_m_axi_ws2_stream_fifo_io_flush = 1'b0;
  assign toplevel_inst_llama_y_stream_fifo_io_flush = 1'b0;

endmodule

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

module StreamFifo_1 (
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

module StreamFifo (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [735:0]  io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [735:0]  io_pop_payload_data,
  input  wire          io_flush,
  output wire [9:0]    io_occupancy,
  output wire [9:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [735:0]  _zz_logic_ram_port1;
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
  wire       [735:0]  logic_push_onRam_write_payload_data_data;
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
  wire       [735:0]  logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [735:0]  logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [9:0]    logic_pop_sync_popReg;
  reg [735:0] logic_ram [0:511];

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
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[735 : 0];
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

module M_AXI_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
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
  output wire [735:0]  x_stream_TDATA,
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
  input  wire [735:0]  y_stream_TDATA,
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
  wire       [735:0]  black_box_x_stream_TDATA;
  wire                black_box_x_stream_TVALID;
  wire       [255:0]  black_box_wq_stream_TDATA;
  wire                black_box_wq_stream_TVALID;
  wire       [23:0]   black_box_ws1_stream_TDATA;
  wire                black_box_ws1_stream_TVALID;
  wire       [23:0]   black_box_ws2_stream_TDATA;
  wire                black_box_ws2_stream_TVALID;
  wire                black_box_y_stream_TREADY;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  M_AXI black_box (
    .ap_clk              (clk                                ), //i
    .ap_rst_n            (resetn                             ), //i
    .l_begin             (manager_11_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_11_signals_O_L_CLOSE[31:0] ), //i
    .memory_x            (manager_11_signals_O_MEMORY_X[63:0]), //i
    .memory_w            (manager_11_signals_O_MEMORY_W[63:0]), //i
    .memory_y            (manager_11_signals_O_MEMORY_Y[63:0]), //i
    .ap_start            (manager_11_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_11_ap_ctrl_ap_continue     ), //i
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
    .x_stream_TDATA      (black_box_x_stream_TDATA[735:0]    ), //o
    .x_stream_TVALID     (black_box_x_stream_TVALID          ), //o
    .x_stream_TREADY     (x_stream_TREADY                    ), //i
    .wq_stream_TDATA     (black_box_wq_stream_TDATA[255:0]   ), //o
    .wq_stream_TVALID    (black_box_wq_stream_TVALID         ), //o
    .wq_stream_TREADY    (wq_stream_TREADY                   ), //i
    .ws1_stream_TDATA    (black_box_ws1_stream_TDATA[23:0]   ), //o
    .ws1_stream_TVALID   (black_box_ws1_stream_TVALID        ), //o
    .ws1_stream_TREADY   (ws1_stream_TREADY                  ), //i
    .ws2_stream_TDATA    (black_box_ws2_stream_TDATA[23:0]   ), //o
    .ws2_stream_TVALID   (black_box_ws2_stream_TVALID        ), //o
    .ws2_stream_TREADY   (ws2_stream_TREADY                  ), //i
    .y_stream_TDATA      (y_stream_TDATA[735:0]              ), //i
    .y_stream_TVALID     (y_stream_TVALID                    ), //i
    .y_stream_TREADY     (black_box_y_stream_TREADY          )  //o
  );
  Manager_3 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
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
  assign wq_stream_TDATA = black_box_wq_stream_TDATA;
  assign wq_stream_TVALID = black_box_wq_stream_TVALID;
  assign ws1_stream_TDATA = black_box_ws1_stream_TDATA;
  assign ws1_stream_TVALID = black_box_ws1_stream_TVALID;
  assign ws2_stream_TDATA = black_box_ws2_stream_TDATA;
  assign ws2_stream_TVALID = black_box_ws2_stream_TVALID;
  assign y_stream_TREADY = black_box_y_stream_TREADY;

endmodule

module LLAMA (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          x_stream_TVALID,
  output wire          x_stream_TREADY,
  input  wire [735:0]  x_stream_TDATA,
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
  output wire [735:0]  y_stream_TDATA
);

  wire                inst_llama_mux_1_s_stream_fifo_io_flush;
  wire       [31:0]   gemm_signals_O_L_BEGIN;
  wire       [31:0]   gemm_signals_O_L_CLOSE;
  wire       [63:0]   gemm_signals_O_MEMORY_X;
  wire       [63:0]   gemm_signals_O_MEMORY_W;
  wire       [63:0]   gemm_signals_O_MEMORY_Y;
  wire       [11:0]   gemm_signals_O_POS;
  wire                gemm_signals_O_T;
  wire                gemm_i_stream_TREADY;
  wire                gemm_w_stream_TREADY;
  wire                gemm_s_stream_TREADY;
  wire                gemm_s1_stream_TREADY;
  wire                gemm_s2_stream_TREADY;
  wire                gemm_o_stream_TVALID;
  wire       [183:0]  gemm_o_stream_TDATA;
  wire       [31:0]   demux_1_signals_O_L_BEGIN;
  wire       [31:0]   demux_1_signals_O_L_CLOSE;
  wire       [63:0]   demux_1_signals_O_MEMORY_X;
  wire       [63:0]   demux_1_signals_O_MEMORY_W;
  wire       [63:0]   demux_1_signals_O_MEMORY_Y;
  wire       [11:0]   demux_1_signals_O_POS;
  wire                demux_1_signals_O_T;
  wire                demux_1_gemm_stream_TREADY;
  wire                demux_1_qk_stream_TVALID;
  wire       [127:0]  demux_1_qk_stream_TDATA;
  wire                demux_1_v_stream_TVALID;
  wire       [127:0]  demux_1_v_stream_TDATA;
  wire                demux_1_ug_stream_TVALID;
  wire       [127:0]  demux_1_ug_stream_TDATA;
  wire                demux_1_od_stream_TVALID;
  wire       [183:0]  demux_1_od_stream_TDATA;
  wire       [31:0]   rope_qk_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   rope_qk_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   rope_qk_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   rope_qk_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   rope_qk_quant_1_signals_O_MEMORY_Y;
  wire       [11:0]   rope_qk_quant_1_signals_O_POS;
  wire                rope_qk_quant_1_signals_O_T;
  wire                rope_qk_quant_1_qk_stream_TREADY;
  wire                rope_qk_quant_1_rot_q_stream_TVALID;
  wire       [47:0]   rope_qk_quant_1_rot_q_stream_TDATA;
  wire                rope_qk_quant_1_rot_s_stream_TVALID;
  wire       [7:0]    rope_qk_quant_1_rot_s_stream_TDATA;
  wire       [31:0]   qk_gemm_1_signals_O_L_BEGIN;
  wire       [31:0]   qk_gemm_1_signals_O_L_CLOSE;
  wire       [63:0]   qk_gemm_1_signals_O_MEMORY_X;
  wire       [63:0]   qk_gemm_1_signals_O_MEMORY_W;
  wire       [63:0]   qk_gemm_1_signals_O_MEMORY_Y;
  wire       [11:0]   qk_gemm_1_signals_O_POS;
  wire                qk_gemm_1_signals_O_T;
  wire                qk_gemm_1_qk_q_stream_TREADY;
  wire                qk_gemm_1_qk_s_stream_TREADY;
  wire                qk_gemm_1_r_stream_TVALID;
  wire       [447:0]  qk_gemm_1_r_stream_TDATA;
  wire       [31:0]   softmax_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   softmax_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   softmax_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   softmax_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   softmax_quant_1_signals_O_MEMORY_Y;
  wire       [11:0]   softmax_quant_1_signals_O_POS;
  wire                softmax_quant_1_signals_O_T;
  wire                softmax_quant_1_r_stream_TREADY;
  wire                softmax_quant_1_rq_stream_TVALID;
  wire       [191:0]  softmax_quant_1_rq_stream_TDATA;
  wire                softmax_quant_1_rs_stream_TVALID;
  wire       [15:0]   softmax_quant_1_rs_stream_TDATA;
  wire       [31:0]   rv_gemm_1_signals_O_L_BEGIN;
  wire       [31:0]   rv_gemm_1_signals_O_L_CLOSE;
  wire       [63:0]   rv_gemm_1_signals_O_MEMORY_X;
  wire       [63:0]   rv_gemm_1_signals_O_MEMORY_W;
  wire       [63:0]   rv_gemm_1_signals_O_MEMORY_Y;
  wire       [11:0]   rv_gemm_1_signals_O_POS;
  wire                rv_gemm_1_signals_O_T;
  wire                rv_gemm_1_rq_stream_TREADY;
  wire                rv_gemm_1_v_stream_TREADY;
  wire                rv_gemm_1_rs_stream_TREADY;
  wire                rv_gemm_1_aq_stream_TVALID;
  wire       [191:0]  rv_gemm_1_aq_stream_TDATA;
  wire                rv_gemm_1_as_stream_TVALID;
  wire       [15:0]   rv_gemm_1_as_stream_TDATA;
  wire       [31:0]   silu_em_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   silu_em_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   silu_em_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   silu_em_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   silu_em_quant_1_signals_O_MEMORY_Y;
  wire       [11:0]   silu_em_quant_1_signals_O_POS;
  wire                silu_em_quant_1_signals_O_T;
  wire                silu_em_quant_1_ug_stream_TREADY;
  wire                silu_em_quant_1_q_stream_TVALID;
  wire       [47:0]   silu_em_quant_1_q_stream_TDATA;
  wire                silu_em_quant_1_s_stream_TVALID;
  wire       [7:0]    silu_em_quant_1_s_stream_TDATA;
  wire       [31:0]   residual_1_signals_O_L_BEGIN;
  wire       [31:0]   residual_1_signals_O_L_CLOSE;
  wire       [63:0]   residual_1_signals_O_MEMORY_X;
  wire       [63:0]   residual_1_signals_O_MEMORY_W;
  wire       [63:0]   residual_1_signals_O_MEMORY_Y;
  wire       [11:0]   residual_1_signals_O_POS;
  wire                residual_1_signals_O_T;
  wire                residual_1_x_stream_TREADY;
  wire                residual_1_res_i_stream_TREADY;
  wire                residual_1_res_o_stream_TVALID;
  wire       [735:0]  residual_1_res_o_stream_TDATA;
  wire                residual_1_y_stream_TVALID;
  wire       [735:0]  residual_1_y_stream_TDATA;
  wire       [31:0]   rmsnorm_quant_1_signals_O_L_BEGIN;
  wire       [31:0]   rmsnorm_quant_1_signals_O_L_CLOSE;
  wire       [63:0]   rmsnorm_quant_1_signals_O_MEMORY_X;
  wire       [63:0]   rmsnorm_quant_1_signals_O_MEMORY_W;
  wire       [63:0]   rmsnorm_quant_1_signals_O_MEMORY_Y;
  wire       [11:0]   rmsnorm_quant_1_signals_O_POS;
  wire                rmsnorm_quant_1_signals_O_T;
  wire                rmsnorm_quant_1_x_stream_TREADY;
  wire                rmsnorm_quant_1_xlnq_stream_TVALID;
  wire       [191:0]  rmsnorm_quant_1_xlnq_stream_TDATA;
  wire                rmsnorm_quant_1_xlns_stream_TVALID;
  wire       [15:0]   rmsnorm_quant_1_xlns_stream_TDATA;
  wire       [31:0]   mux_1_signals_O_L_BEGIN;
  wire       [31:0]   mux_1_signals_O_L_CLOSE;
  wire       [63:0]   mux_1_signals_O_MEMORY_X;
  wire       [63:0]   mux_1_signals_O_MEMORY_W;
  wire       [63:0]   mux_1_signals_O_MEMORY_Y;
  wire       [11:0]   mux_1_signals_O_POS;
  wire                mux_1_signals_O_T;
  wire                mux_1_xlnq_stream_TREADY;
  wire                mux_1_xlns_stream_TREADY;
  wire                mux_1_aq_stream_TREADY;
  wire                mux_1_as_stream_TREADY;
  wire                mux_1_xmq_stream_TREADY;
  wire                mux_1_xms_stream_TREADY;
  wire                mux_1_q_stream_TVALID;
  wire       [1535:0] mux_1_q_stream_TDATA;
  wire                mux_1_s_stream_TVALID;
  wire       [127:0]  mux_1_s_stream_TDATA;
  wire                inst_llama_mux_1_s_stream_fifo_io_push_ready;
  wire                inst_llama_mux_1_s_stream_fifo_io_pop_valid;
  wire       [127:0]  inst_llama_mux_1_s_stream_fifo_io_pop_payload_data;
  wire       [9:0]    inst_llama_mux_1_s_stream_fifo_io_occupancy;
  wire       [9:0]    inst_llama_mux_1_s_stream_fifo_io_availability;

  GEMM_wrapper gemm (
    .resetn             (resetn                                                   ), //i
    .clk                (clk                                                      ), //i
    .signals_I_L_BEGIN  (mux_1_signals_O_L_BEGIN[31:0]                            ), //i
    .signals_I_L_CLOSE  (mux_1_signals_O_L_CLOSE[31:0]                            ), //i
    .signals_I_MEMORY_X (mux_1_signals_O_MEMORY_X[63:0]                           ), //i
    .signals_I_MEMORY_W (mux_1_signals_O_MEMORY_W[63:0]                           ), //i
    .signals_I_MEMORY_Y (mux_1_signals_O_MEMORY_Y[63:0]                           ), //i
    .signals_I_POS      (mux_1_signals_O_POS[11:0]                                ), //i
    .signals_I_T        (mux_1_signals_O_T                                        ), //i
    .signals_O_L_BEGIN  (gemm_signals_O_L_BEGIN[31:0]                             ), //o
    .signals_O_L_CLOSE  (gemm_signals_O_L_CLOSE[31:0]                             ), //o
    .signals_O_MEMORY_X (gemm_signals_O_MEMORY_X[63:0]                            ), //o
    .signals_O_MEMORY_W (gemm_signals_O_MEMORY_W[63:0]                            ), //o
    .signals_O_MEMORY_Y (gemm_signals_O_MEMORY_Y[63:0]                            ), //o
    .signals_O_POS      (gemm_signals_O_POS[11:0]                                 ), //o
    .signals_O_T        (gemm_signals_O_T                                         ), //o
    .i_stream_TVALID    (mux_1_q_stream_TVALID                                    ), //i
    .i_stream_TREADY    (gemm_i_stream_TREADY                                     ), //o
    .i_stream_TDATA     (mux_1_q_stream_TDATA[1535:0]                             ), //i
    .w_stream_TVALID    (w_stream_TVALID                                          ), //i
    .w_stream_TREADY    (gemm_w_stream_TREADY                                     ), //o
    .w_stream_TDATA     (w_stream_TDATA[255:0]                                    ), //i
    .s_stream_TVALID    (inst_llama_mux_1_s_stream_fifo_io_pop_valid              ), //i
    .s_stream_TREADY    (gemm_s_stream_TREADY                                     ), //o
    .s_stream_TDATA     (inst_llama_mux_1_s_stream_fifo_io_pop_payload_data[127:0]), //i
    .s1_stream_TVALID   (s1_stream_TVALID                                         ), //i
    .s1_stream_TREADY   (gemm_s1_stream_TREADY                                    ), //o
    .s1_stream_TDATA    (s1_stream_TDATA[23:0]                                    ), //i
    .s2_stream_TVALID   (s2_stream_TVALID                                         ), //i
    .s2_stream_TREADY   (gemm_s2_stream_TREADY                                    ), //o
    .s2_stream_TDATA    (s2_stream_TDATA[23:0]                                    ), //i
    .o_stream_TVALID    (gemm_o_stream_TVALID                                     ), //o
    .o_stream_TREADY    (demux_1_gemm_stream_TREADY                               ), //i
    .o_stream_TDATA     (gemm_o_stream_TDATA[183:0]                               )  //o
  );
  DEMUX_wrapper demux_1 (
    .resetn             (resetn                          ), //i
    .clk                (clk                             ), //i
    .signals_I_L_BEGIN  (gemm_signals_O_L_BEGIN[31:0]    ), //i
    .signals_I_L_CLOSE  (gemm_signals_O_L_CLOSE[31:0]    ), //i
    .signals_I_MEMORY_X (gemm_signals_O_MEMORY_X[63:0]   ), //i
    .signals_I_MEMORY_W (gemm_signals_O_MEMORY_W[63:0]   ), //i
    .signals_I_MEMORY_Y (gemm_signals_O_MEMORY_Y[63:0]   ), //i
    .signals_I_POS      (gemm_signals_O_POS[11:0]        ), //i
    .signals_I_T        (gemm_signals_O_T                ), //i
    .signals_O_L_BEGIN  (demux_1_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE  (demux_1_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X (demux_1_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W (demux_1_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y (demux_1_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS      (demux_1_signals_O_POS[11:0]     ), //o
    .signals_O_T        (demux_1_signals_O_T             ), //o
    .gemm_stream_TVALID (gemm_o_stream_TVALID            ), //i
    .gemm_stream_TREADY (demux_1_gemm_stream_TREADY      ), //o
    .gemm_stream_TDATA  (gemm_o_stream_TDATA[183:0]      ), //i
    .qk_stream_TVALID   (demux_1_qk_stream_TVALID        ), //o
    .qk_stream_TREADY   (rope_qk_quant_1_qk_stream_TREADY), //i
    .qk_stream_TDATA    (demux_1_qk_stream_TDATA[127:0]  ), //o
    .v_stream_TVALID    (demux_1_v_stream_TVALID         ), //o
    .v_stream_TREADY    (rv_gemm_1_v_stream_TREADY       ), //i
    .v_stream_TDATA     (demux_1_v_stream_TDATA[127:0]   ), //o
    .ug_stream_TVALID   (demux_1_ug_stream_TVALID        ), //o
    .ug_stream_TREADY   (silu_em_quant_1_ug_stream_TREADY), //i
    .ug_stream_TDATA    (demux_1_ug_stream_TDATA[127:0]  ), //o
    .od_stream_TVALID   (demux_1_od_stream_TVALID        ), //o
    .od_stream_TREADY   (residual_1_res_i_stream_TREADY  ), //i
    .od_stream_TDATA    (demux_1_od_stream_TDATA[183:0]  )  //o
  );
  ROPE_QK_QUANT_wrapper rope_qk_quant_1 (
    .resetn              (resetn                                  ), //i
    .clk                 (clk                                     ), //i
    .signals_I_L_BEGIN   (demux_1_signals_O_L_BEGIN[31:0]         ), //i
    .signals_I_L_CLOSE   (demux_1_signals_O_L_CLOSE[31:0]         ), //i
    .signals_I_MEMORY_X  (demux_1_signals_O_MEMORY_X[63:0]        ), //i
    .signals_I_MEMORY_W  (demux_1_signals_O_MEMORY_W[63:0]        ), //i
    .signals_I_MEMORY_Y  (demux_1_signals_O_MEMORY_Y[63:0]        ), //i
    .signals_I_POS       (demux_1_signals_O_POS[11:0]             ), //i
    .signals_I_T         (demux_1_signals_O_T                     ), //i
    .signals_O_L_BEGIN   (rope_qk_quant_1_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (rope_qk_quant_1_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (rope_qk_quant_1_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (rope_qk_quant_1_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (rope_qk_quant_1_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (rope_qk_quant_1_signals_O_POS[11:0]     ), //o
    .signals_O_T         (rope_qk_quant_1_signals_O_T             ), //o
    .qk_stream_TVALID    (demux_1_qk_stream_TVALID                ), //i
    .qk_stream_TREADY    (rope_qk_quant_1_qk_stream_TREADY        ), //o
    .qk_stream_TDATA     (demux_1_qk_stream_TDATA[127:0]          ), //i
    .rot_q_stream_TVALID (rope_qk_quant_1_rot_q_stream_TVALID     ), //o
    .rot_q_stream_TREADY (qk_gemm_1_qk_q_stream_TREADY            ), //i
    .rot_q_stream_TDATA  (rope_qk_quant_1_rot_q_stream_TDATA[47:0]), //o
    .rot_s_stream_TVALID (rope_qk_quant_1_rot_s_stream_TVALID     ), //o
    .rot_s_stream_TREADY (qk_gemm_1_qk_s_stream_TREADY            ), //i
    .rot_s_stream_TDATA  (rope_qk_quant_1_rot_s_stream_TDATA[7:0] )  //o
  );
  QK_GEMM_wrapper qk_gemm_1 (
    .resetn             (resetn                                  ), //i
    .clk                (clk                                     ), //i
    .signals_I_L_BEGIN  (rope_qk_quant_1_signals_O_L_BEGIN[31:0] ), //i
    .signals_I_L_CLOSE  (rope_qk_quant_1_signals_O_L_CLOSE[31:0] ), //i
    .signals_I_MEMORY_X (rope_qk_quant_1_signals_O_MEMORY_X[63:0]), //i
    .signals_I_MEMORY_W (rope_qk_quant_1_signals_O_MEMORY_W[63:0]), //i
    .signals_I_MEMORY_Y (rope_qk_quant_1_signals_O_MEMORY_Y[63:0]), //i
    .signals_I_POS      (rope_qk_quant_1_signals_O_POS[11:0]     ), //i
    .signals_I_T        (rope_qk_quant_1_signals_O_T             ), //i
    .signals_O_L_BEGIN  (qk_gemm_1_signals_O_L_BEGIN[31:0]       ), //o
    .signals_O_L_CLOSE  (qk_gemm_1_signals_O_L_CLOSE[31:0]       ), //o
    .signals_O_MEMORY_X (qk_gemm_1_signals_O_MEMORY_X[63:0]      ), //o
    .signals_O_MEMORY_W (qk_gemm_1_signals_O_MEMORY_W[63:0]      ), //o
    .signals_O_MEMORY_Y (qk_gemm_1_signals_O_MEMORY_Y[63:0]      ), //o
    .signals_O_POS      (qk_gemm_1_signals_O_POS[11:0]           ), //o
    .signals_O_T        (qk_gemm_1_signals_O_T                   ), //o
    .qk_q_stream_TVALID (rope_qk_quant_1_rot_q_stream_TVALID     ), //i
    .qk_q_stream_TREADY (qk_gemm_1_qk_q_stream_TREADY            ), //o
    .qk_q_stream_TDATA  (rope_qk_quant_1_rot_q_stream_TDATA[47:0]), //i
    .qk_s_stream_TVALID (rope_qk_quant_1_rot_s_stream_TVALID     ), //i
    .qk_s_stream_TREADY (qk_gemm_1_qk_s_stream_TREADY            ), //o
    .qk_s_stream_TDATA  (rope_qk_quant_1_rot_s_stream_TDATA[7:0] ), //i
    .r_stream_TVALID    (qk_gemm_1_r_stream_TVALID               ), //o
    .r_stream_TREADY    (softmax_quant_1_r_stream_TREADY         ), //i
    .r_stream_TDATA     (qk_gemm_1_r_stream_TDATA[447:0]         )  //o
  );
  SOFTMAX_QUANT_wrapper softmax_quant_1 (
    .resetn             (resetn                                  ), //i
    .clk                (clk                                     ), //i
    .signals_I_L_BEGIN  (qk_gemm_1_signals_O_L_BEGIN[31:0]       ), //i
    .signals_I_L_CLOSE  (qk_gemm_1_signals_O_L_CLOSE[31:0]       ), //i
    .signals_I_MEMORY_X (qk_gemm_1_signals_O_MEMORY_X[63:0]      ), //i
    .signals_I_MEMORY_W (qk_gemm_1_signals_O_MEMORY_W[63:0]      ), //i
    .signals_I_MEMORY_Y (qk_gemm_1_signals_O_MEMORY_Y[63:0]      ), //i
    .signals_I_POS      (qk_gemm_1_signals_O_POS[11:0]           ), //i
    .signals_I_T        (qk_gemm_1_signals_O_T                   ), //i
    .signals_O_L_BEGIN  (softmax_quant_1_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE  (softmax_quant_1_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X (softmax_quant_1_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W (softmax_quant_1_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y (softmax_quant_1_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS      (softmax_quant_1_signals_O_POS[11:0]     ), //o
    .signals_O_T        (softmax_quant_1_signals_O_T             ), //o
    .r_stream_TVALID    (qk_gemm_1_r_stream_TVALID               ), //i
    .r_stream_TREADY    (softmax_quant_1_r_stream_TREADY         ), //o
    .r_stream_TDATA     (qk_gemm_1_r_stream_TDATA[447:0]         ), //i
    .rq_stream_TVALID   (softmax_quant_1_rq_stream_TVALID        ), //o
    .rq_stream_TREADY   (rv_gemm_1_rq_stream_TREADY              ), //i
    .rq_stream_TDATA    (softmax_quant_1_rq_stream_TDATA[191:0]  ), //o
    .rs_stream_TVALID   (softmax_quant_1_rs_stream_TVALID        ), //o
    .rs_stream_TREADY   (rv_gemm_1_rs_stream_TREADY              ), //i
    .rs_stream_TDATA    (softmax_quant_1_rs_stream_TDATA[15:0]   )  //o
  );
  RV_GEMM_wrapper rv_gemm_1 (
    .resetn             (resetn                                  ), //i
    .clk                (clk                                     ), //i
    .signals_I_L_BEGIN  (softmax_quant_1_signals_O_L_BEGIN[31:0] ), //i
    .signals_I_L_CLOSE  (softmax_quant_1_signals_O_L_CLOSE[31:0] ), //i
    .signals_I_MEMORY_X (softmax_quant_1_signals_O_MEMORY_X[63:0]), //i
    .signals_I_MEMORY_W (softmax_quant_1_signals_O_MEMORY_W[63:0]), //i
    .signals_I_MEMORY_Y (softmax_quant_1_signals_O_MEMORY_Y[63:0]), //i
    .signals_I_POS      (softmax_quant_1_signals_O_POS[11:0]     ), //i
    .signals_I_T        (softmax_quant_1_signals_O_T             ), //i
    .signals_O_L_BEGIN  (rv_gemm_1_signals_O_L_BEGIN[31:0]       ), //o
    .signals_O_L_CLOSE  (rv_gemm_1_signals_O_L_CLOSE[31:0]       ), //o
    .signals_O_MEMORY_X (rv_gemm_1_signals_O_MEMORY_X[63:0]      ), //o
    .signals_O_MEMORY_W (rv_gemm_1_signals_O_MEMORY_W[63:0]      ), //o
    .signals_O_MEMORY_Y (rv_gemm_1_signals_O_MEMORY_Y[63:0]      ), //o
    .signals_O_POS      (rv_gemm_1_signals_O_POS[11:0]           ), //o
    .signals_O_T        (rv_gemm_1_signals_O_T                   ), //o
    .rq_stream_TVALID   (softmax_quant_1_rq_stream_TVALID        ), //i
    .rq_stream_TREADY   (rv_gemm_1_rq_stream_TREADY              ), //o
    .rq_stream_TDATA    (softmax_quant_1_rq_stream_TDATA[191:0]  ), //i
    .v_stream_TVALID    (demux_1_v_stream_TVALID                 ), //i
    .v_stream_TREADY    (rv_gemm_1_v_stream_TREADY               ), //o
    .v_stream_TDATA     (demux_1_v_stream_TDATA[127:0]           ), //i
    .rs_stream_TVALID   (softmax_quant_1_rs_stream_TVALID        ), //i
    .rs_stream_TREADY   (rv_gemm_1_rs_stream_TREADY              ), //o
    .rs_stream_TDATA    (softmax_quant_1_rs_stream_TDATA[15:0]   ), //i
    .aq_stream_TVALID   (rv_gemm_1_aq_stream_TVALID              ), //o
    .aq_stream_TREADY   (mux_1_aq_stream_TREADY                  ), //i
    .aq_stream_TDATA    (rv_gemm_1_aq_stream_TDATA[191:0]        ), //o
    .as_stream_TVALID   (rv_gemm_1_as_stream_TVALID              ), //o
    .as_stream_TREADY   (mux_1_as_stream_TREADY                  ), //i
    .as_stream_TDATA    (rv_gemm_1_as_stream_TDATA[15:0]         )  //o
  );
  SILU_EM_QUANT_wrapper silu_em_quant_1 (
    .resetn             (resetn                                  ), //i
    .clk                (clk                                     ), //i
    .signals_I_L_BEGIN  (rv_gemm_1_signals_O_L_BEGIN[31:0]       ), //i
    .signals_I_L_CLOSE  (rv_gemm_1_signals_O_L_CLOSE[31:0]       ), //i
    .signals_I_MEMORY_X (rv_gemm_1_signals_O_MEMORY_X[63:0]      ), //i
    .signals_I_MEMORY_W (rv_gemm_1_signals_O_MEMORY_W[63:0]      ), //i
    .signals_I_MEMORY_Y (rv_gemm_1_signals_O_MEMORY_Y[63:0]      ), //i
    .signals_I_POS      (rv_gemm_1_signals_O_POS[11:0]           ), //i
    .signals_I_T        (rv_gemm_1_signals_O_T                   ), //i
    .signals_O_L_BEGIN  (silu_em_quant_1_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE  (silu_em_quant_1_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X (silu_em_quant_1_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W (silu_em_quant_1_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y (silu_em_quant_1_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS      (silu_em_quant_1_signals_O_POS[11:0]     ), //o
    .signals_O_T        (silu_em_quant_1_signals_O_T             ), //o
    .ug_stream_TVALID   (demux_1_ug_stream_TVALID                ), //i
    .ug_stream_TREADY   (silu_em_quant_1_ug_stream_TREADY        ), //o
    .ug_stream_TDATA    (demux_1_ug_stream_TDATA[127:0]          ), //i
    .q_stream_TVALID    (silu_em_quant_1_q_stream_TVALID         ), //o
    .q_stream_TREADY    (mux_1_xmq_stream_TREADY                 ), //i
    .q_stream_TDATA     (silu_em_quant_1_q_stream_TDATA[47:0]    ), //o
    .s_stream_TVALID    (silu_em_quant_1_s_stream_TVALID         ), //o
    .s_stream_TREADY    (mux_1_xms_stream_TREADY                 ), //i
    .s_stream_TDATA     (silu_em_quant_1_s_stream_TDATA[7:0]     )  //o
  );
  RESIDUAL_wrapper residual_1 (
    .resetn              (resetn                                  ), //i
    .clk                 (clk                                     ), //i
    .signals_I_L_BEGIN   (silu_em_quant_1_signals_O_L_BEGIN[31:0] ), //i
    .signals_I_L_CLOSE   (silu_em_quant_1_signals_O_L_CLOSE[31:0] ), //i
    .signals_I_MEMORY_X  (silu_em_quant_1_signals_O_MEMORY_X[63:0]), //i
    .signals_I_MEMORY_W  (silu_em_quant_1_signals_O_MEMORY_W[63:0]), //i
    .signals_I_MEMORY_Y  (silu_em_quant_1_signals_O_MEMORY_Y[63:0]), //i
    .signals_I_POS       (silu_em_quant_1_signals_O_POS[11:0]     ), //i
    .signals_I_T         (silu_em_quant_1_signals_O_T             ), //i
    .signals_O_L_BEGIN   (residual_1_signals_O_L_BEGIN[31:0]      ), //o
    .signals_O_L_CLOSE   (residual_1_signals_O_L_CLOSE[31:0]      ), //o
    .signals_O_MEMORY_X  (residual_1_signals_O_MEMORY_X[63:0]     ), //o
    .signals_O_MEMORY_W  (residual_1_signals_O_MEMORY_W[63:0]     ), //o
    .signals_O_MEMORY_Y  (residual_1_signals_O_MEMORY_Y[63:0]     ), //o
    .signals_O_POS       (residual_1_signals_O_POS[11:0]          ), //o
    .signals_O_T         (residual_1_signals_O_T                  ), //o
    .x_stream_TVALID     (x_stream_TVALID                         ), //i
    .x_stream_TREADY     (residual_1_x_stream_TREADY              ), //o
    .x_stream_TDATA      (x_stream_TDATA[735:0]                   ), //i
    .res_i_stream_TVALID (demux_1_od_stream_TVALID                ), //i
    .res_i_stream_TREADY (residual_1_res_i_stream_TREADY          ), //o
    .res_i_stream_TDATA  (demux_1_od_stream_TDATA[183:0]          ), //i
    .res_o_stream_TVALID (residual_1_res_o_stream_TVALID          ), //o
    .res_o_stream_TREADY (rmsnorm_quant_1_x_stream_TREADY         ), //i
    .res_o_stream_TDATA  (residual_1_res_o_stream_TDATA[735:0]    ), //o
    .y_stream_TVALID     (residual_1_y_stream_TVALID              ), //o
    .y_stream_TREADY     (y_stream_TREADY                         ), //i
    .y_stream_TDATA      (residual_1_y_stream_TDATA[735:0]        )  //o
  );
  RMSNORM_QUANT_wrapper rmsnorm_quant_1 (
    .resetn             (resetn                                  ), //i
    .clk                (clk                                     ), //i
    .signals_I_L_BEGIN  (residual_1_signals_O_L_BEGIN[31:0]      ), //i
    .signals_I_L_CLOSE  (residual_1_signals_O_L_CLOSE[31:0]      ), //i
    .signals_I_MEMORY_X (residual_1_signals_O_MEMORY_X[63:0]     ), //i
    .signals_I_MEMORY_W (residual_1_signals_O_MEMORY_W[63:0]     ), //i
    .signals_I_MEMORY_Y (residual_1_signals_O_MEMORY_Y[63:0]     ), //i
    .signals_I_POS      (residual_1_signals_O_POS[11:0]          ), //i
    .signals_I_T        (residual_1_signals_O_T                  ), //i
    .signals_O_L_BEGIN  (rmsnorm_quant_1_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE  (rmsnorm_quant_1_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X (rmsnorm_quant_1_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W (rmsnorm_quant_1_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y (rmsnorm_quant_1_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS      (rmsnorm_quant_1_signals_O_POS[11:0]     ), //o
    .signals_O_T        (rmsnorm_quant_1_signals_O_T             ), //o
    .x_stream_TVALID    (residual_1_res_o_stream_TVALID          ), //i
    .x_stream_TREADY    (rmsnorm_quant_1_x_stream_TREADY         ), //o
    .x_stream_TDATA     (residual_1_res_o_stream_TDATA[735:0]    ), //i
    .xlnq_stream_TVALID (rmsnorm_quant_1_xlnq_stream_TVALID      ), //o
    .xlnq_stream_TREADY (mux_1_xlnq_stream_TREADY                ), //i
    .xlnq_stream_TDATA  (rmsnorm_quant_1_xlnq_stream_TDATA[191:0]), //o
    .xlns_stream_TVALID (rmsnorm_quant_1_xlns_stream_TVALID      ), //o
    .xlns_stream_TREADY (mux_1_xlns_stream_TREADY                ), //i
    .xlns_stream_TDATA  (rmsnorm_quant_1_xlns_stream_TDATA[15:0] )  //o
  );
  MUX_wrapper mux_1 (
    .resetn             (resetn                                      ), //i
    .clk                (clk                                         ), //i
    .signals_I_L_BEGIN  (signals_I_L_BEGIN[31:0]                     ), //i
    .signals_I_L_CLOSE  (signals_I_L_CLOSE[31:0]                     ), //i
    .signals_I_MEMORY_X (signals_I_MEMORY_X[63:0]                    ), //i
    .signals_I_MEMORY_W (signals_I_MEMORY_W[63:0]                    ), //i
    .signals_I_MEMORY_Y (signals_I_MEMORY_Y[63:0]                    ), //i
    .signals_I_POS      (signals_I_POS[11:0]                         ), //i
    .signals_I_T        (signals_I_T                                 ), //i
    .signals_O_L_BEGIN  (mux_1_signals_O_L_BEGIN[31:0]               ), //o
    .signals_O_L_CLOSE  (mux_1_signals_O_L_CLOSE[31:0]               ), //o
    .signals_O_MEMORY_X (mux_1_signals_O_MEMORY_X[63:0]              ), //o
    .signals_O_MEMORY_W (mux_1_signals_O_MEMORY_W[63:0]              ), //o
    .signals_O_MEMORY_Y (mux_1_signals_O_MEMORY_Y[63:0]              ), //o
    .signals_O_POS      (mux_1_signals_O_POS[11:0]                   ), //o
    .signals_O_T        (mux_1_signals_O_T                           ), //o
    .xlnq_stream_TVALID (rmsnorm_quant_1_xlnq_stream_TVALID          ), //i
    .xlnq_stream_TREADY (mux_1_xlnq_stream_TREADY                    ), //o
    .xlnq_stream_TDATA  (rmsnorm_quant_1_xlnq_stream_TDATA[191:0]    ), //i
    .xlns_stream_TVALID (rmsnorm_quant_1_xlns_stream_TVALID          ), //i
    .xlns_stream_TREADY (mux_1_xlns_stream_TREADY                    ), //o
    .xlns_stream_TDATA  (rmsnorm_quant_1_xlns_stream_TDATA[15:0]     ), //i
    .aq_stream_TVALID   (rv_gemm_1_aq_stream_TVALID                  ), //i
    .aq_stream_TREADY   (mux_1_aq_stream_TREADY                      ), //o
    .aq_stream_TDATA    (rv_gemm_1_aq_stream_TDATA[191:0]            ), //i
    .as_stream_TVALID   (rv_gemm_1_as_stream_TVALID                  ), //i
    .as_stream_TREADY   (mux_1_as_stream_TREADY                      ), //o
    .as_stream_TDATA    (rv_gemm_1_as_stream_TDATA[15:0]             ), //i
    .xmq_stream_TVALID  (silu_em_quant_1_q_stream_TVALID             ), //i
    .xmq_stream_TREADY  (mux_1_xmq_stream_TREADY                     ), //o
    .xmq_stream_TDATA   (silu_em_quant_1_q_stream_TDATA[47:0]        ), //i
    .xms_stream_TVALID  (silu_em_quant_1_s_stream_TVALID             ), //i
    .xms_stream_TREADY  (mux_1_xms_stream_TREADY                     ), //o
    .xms_stream_TDATA   (silu_em_quant_1_s_stream_TDATA[7:0]         ), //i
    .q_stream_TVALID    (mux_1_q_stream_TVALID                       ), //o
    .q_stream_TREADY    (gemm_i_stream_TREADY                        ), //i
    .q_stream_TDATA     (mux_1_q_stream_TDATA[1535:0]                ), //o
    .s_stream_TVALID    (mux_1_s_stream_TVALID                       ), //o
    .s_stream_TREADY    (inst_llama_mux_1_s_stream_fifo_io_push_ready), //i
    .s_stream_TDATA     (mux_1_s_stream_TDATA[127:0]                 )  //o
  );
  StreamFifo_5 inst_llama_mux_1_s_stream_fifo (
    .io_push_valid        (mux_1_s_stream_TVALID                                    ), //i
    .io_push_ready        (inst_llama_mux_1_s_stream_fifo_io_push_ready             ), //o
    .io_push_payload_data (mux_1_s_stream_TDATA[127:0]                              ), //i
    .io_pop_valid         (inst_llama_mux_1_s_stream_fifo_io_pop_valid              ), //o
    .io_pop_ready         (gemm_s_stream_TREADY                                     ), //i
    .io_pop_payload_data  (inst_llama_mux_1_s_stream_fifo_io_pop_payload_data[127:0]), //o
    .io_flush             (inst_llama_mux_1_s_stream_fifo_io_flush                  ), //i
    .io_occupancy         (inst_llama_mux_1_s_stream_fifo_io_occupancy[9:0]         ), //o
    .io_availability      (inst_llama_mux_1_s_stream_fifo_io_availability[9:0]      ), //o
    .clk                  (clk                                                      ), //i
    .resetn               (resetn                                                   )  //i
  );
  assign signals_O_L_BEGIN = rmsnorm_quant_1_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = rmsnorm_quant_1_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = rmsnorm_quant_1_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = rmsnorm_quant_1_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = rmsnorm_quant_1_signals_O_MEMORY_Y;
  assign signals_O_POS = rmsnorm_quant_1_signals_O_POS;
  assign signals_O_T = rmsnorm_quant_1_signals_O_T;
  assign x_stream_TREADY = residual_1_x_stream_TREADY;
  assign w_stream_TREADY = gemm_w_stream_TREADY;
  assign s1_stream_TREADY = gemm_s1_stream_TREADY;
  assign s2_stream_TREADY = gemm_s2_stream_TREADY;
  assign y_stream_TVALID = residual_1_y_stream_TVALID;
  assign y_stream_TDATA = residual_1_y_stream_TDATA;
  assign inst_llama_mux_1_s_stream_fifo_io_flush = 1'b0;

endmodule

//Manager replaced by Manager_3

module StreamFifo_5 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [127:0]  io_push_payload_data,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [127:0]  io_pop_payload_data,
  input  wire          io_flush,
  output wire [9:0]    io_occupancy,
  output wire [9:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [127:0]  _zz_logic_ram_port1;
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
  wire       [127:0]  logic_push_onRam_write_payload_data_data;
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
  wire       [127:0]  logic_pop_sync_readPort_rsp_data;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [127:0]  logic_pop_sync_readArbitation_translated_payload_data;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [9:0]    logic_pop_sync_popReg;
  reg [127:0] logic_ram [0:511];

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
  assign logic_pop_sync_readPort_rsp_data = _zz_logic_ram_port1[127 : 0];
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

module MUX_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          xlnq_stream_TVALID,
  output wire          xlnq_stream_TREADY,
  input  wire [191:0]  xlnq_stream_TDATA,
  input  wire          xlns_stream_TVALID,
  output wire          xlns_stream_TREADY,
  input  wire [15:0]   xlns_stream_TDATA,
  input  wire          aq_stream_TVALID,
  output wire          aq_stream_TREADY,
  input  wire [191:0]  aq_stream_TDATA,
  input  wire          as_stream_TVALID,
  output wire          as_stream_TREADY,
  input  wire [15:0]   as_stream_TDATA,
  input  wire          xmq_stream_TVALID,
  output wire          xmq_stream_TREADY,
  input  wire [47:0]   xmq_stream_TDATA,
  input  wire          xms_stream_TVALID,
  output wire          xms_stream_TREADY,
  input  wire [7:0]    xms_stream_TDATA,
  output wire          q_stream_TVALID,
  input  wire          q_stream_TREADY,
  output wire [1535:0] q_stream_TDATA,
  output wire          s_stream_TVALID,
  input  wire          s_stream_TREADY,
  output wire [127:0]  s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_xlnq_stream_TREADY;
  wire                black_box_xlns_stream_TREADY;
  wire                black_box_aq_stream_TREADY;
  wire                black_box_as_stream_TREADY;
  wire                black_box_xmq_stream_TREADY;
  wire                black_box_xms_stream_TREADY;
  wire       [1535:0] black_box_q_stream_TDATA;
  wire                black_box_q_stream_TVALID;
  wire       [127:0]  black_box_s_stream_TDATA;
  wire                black_box_s_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  MUX black_box (
    .ap_clk             (clk                             ), //i
    .ap_rst_n           (resetn                          ), //i
    .ap_start           (manager_11_ap_ctrl_ap_start     ), //i
    .ap_continue        (manager_11_ap_ctrl_ap_continue  ), //i
    .ap_idle            (black_box_ap_idle               ), //o
    .ap_ready           (black_box_ap_ready              ), //o
    .ap_done            (black_box_ap_done               ), //o
    .xlnq_stream_TDATA  (xlnq_stream_TDATA[191:0]        ), //i
    .xlnq_stream_TVALID (xlnq_stream_TVALID              ), //i
    .xlnq_stream_TREADY (black_box_xlnq_stream_TREADY    ), //o
    .xlns_stream_TDATA  (xlns_stream_TDATA[15:0]         ), //i
    .xlns_stream_TVALID (xlns_stream_TVALID              ), //i
    .xlns_stream_TREADY (black_box_xlns_stream_TREADY    ), //o
    .aq_stream_TDATA    (aq_stream_TDATA[191:0]          ), //i
    .aq_stream_TVALID   (aq_stream_TVALID                ), //i
    .aq_stream_TREADY   (black_box_aq_stream_TREADY      ), //o
    .as_stream_TDATA    (as_stream_TDATA[15:0]           ), //i
    .as_stream_TVALID   (as_stream_TVALID                ), //i
    .as_stream_TREADY   (black_box_as_stream_TREADY      ), //o
    .xmq_stream_TDATA   (xmq_stream_TDATA[47:0]          ), //i
    .xmq_stream_TVALID  (xmq_stream_TVALID               ), //i
    .xmq_stream_TREADY  (black_box_xmq_stream_TREADY     ), //o
    .xms_stream_TDATA   (xms_stream_TDATA[7:0]           ), //i
    .xms_stream_TVALID  (xms_stream_TVALID               ), //i
    .xms_stream_TREADY  (black_box_xms_stream_TREADY     ), //o
    .q_stream_TDATA     (black_box_q_stream_TDATA[1535:0]), //o
    .q_stream_TVALID    (black_box_q_stream_TVALID       ), //o
    .q_stream_TREADY    (q_stream_TREADY                 ), //i
    .s_stream_TDATA     (black_box_s_stream_TDATA[127:0] ), //o
    .s_stream_TVALID    (black_box_s_stream_TVALID       ), //o
    .s_stream_TREADY    (s_stream_TREADY                 )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign xlnq_stream_TREADY = black_box_xlnq_stream_TREADY;
  assign xlns_stream_TREADY = black_box_xlns_stream_TREADY;
  assign aq_stream_TREADY = black_box_aq_stream_TREADY;
  assign as_stream_TREADY = black_box_as_stream_TREADY;
  assign xmq_stream_TREADY = black_box_xmq_stream_TREADY;
  assign xms_stream_TREADY = black_box_xms_stream_TREADY;
  assign q_stream_TDATA = black_box_q_stream_TDATA;
  assign q_stream_TVALID = black_box_q_stream_TVALID;
  assign s_stream_TDATA = black_box_s_stream_TDATA;
  assign s_stream_TVALID = black_box_s_stream_TVALID;

endmodule

module RMSNORM_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          x_stream_TVALID,
  output wire          x_stream_TREADY,
  input  wire [735:0]  x_stream_TDATA,
  output wire          xlnq_stream_TVALID,
  input  wire          xlnq_stream_TREADY,
  output wire [191:0]  xlnq_stream_TDATA,
  output wire          xlns_stream_TVALID,
  input  wire          xlns_stream_TREADY,
  output wire [15:0]   xlns_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_x_stream_TREADY;
  wire       [191:0]  black_box_xlnq_stream_TDATA;
  wire                black_box_xlnq_stream_TVALID;
  wire       [15:0]   black_box_xlns_stream_TDATA;
  wire                black_box_xlns_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  RMSNORM_QUANT black_box (
    .ap_clk             (clk                               ), //i
    .ap_rst_n           (resetn                            ), //i
    .l                  (manager_11_l[31:0]                ), //i
    .ap_start           (manager_11_ap_ctrl_ap_start       ), //i
    .ap_continue        (manager_11_ap_ctrl_ap_continue    ), //i
    .ap_idle            (black_box_ap_idle                 ), //o
    .ap_ready           (black_box_ap_ready                ), //o
    .ap_done            (black_box_ap_done                 ), //o
    .x_stream_TDATA     (x_stream_TDATA[735:0]             ), //i
    .x_stream_TVALID    (x_stream_TVALID                   ), //i
    .x_stream_TREADY    (black_box_x_stream_TREADY         ), //o
    .xlnq_stream_TDATA  (black_box_xlnq_stream_TDATA[191:0]), //o
    .xlnq_stream_TVALID (black_box_xlnq_stream_TVALID      ), //o
    .xlnq_stream_TREADY (xlnq_stream_TREADY                ), //i
    .xlns_stream_TDATA  (black_box_xlns_stream_TDATA[15:0] ), //o
    .xlns_stream_TVALID (black_box_xlns_stream_TVALID      ), //o
    .xlns_stream_TREADY (xlns_stream_TREADY                )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
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
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          x_stream_TVALID,
  output wire          x_stream_TREADY,
  input  wire [735:0]  x_stream_TDATA,
  input  wire          res_i_stream_TVALID,
  output wire          res_i_stream_TREADY,
  input  wire [183:0]  res_i_stream_TDATA,
  output wire          res_o_stream_TVALID,
  input  wire          res_o_stream_TREADY,
  output wire [735:0]  res_o_stream_TDATA,
  output wire          y_stream_TVALID,
  input  wire          y_stream_TREADY,
  output wire [735:0]  y_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_x_stream_TREADY;
  wire                black_box_res_i_stream_TREADY;
  wire       [735:0]  black_box_res_o_stream_TDATA;
  wire                black_box_res_o_stream_TVALID;
  wire       [735:0]  black_box_y_stream_TDATA;
  wire                black_box_y_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  RESIDUAL black_box (
    .ap_clk              (clk                                ), //i
    .ap_rst_n            (resetn                             ), //i
    .l_begin             (manager_11_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_11_signals_O_L_CLOSE[31:0] ), //i
    .ap_start            (manager_11_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_11_ap_ctrl_ap_continue     ), //i
    .ap_idle             (black_box_ap_idle                  ), //o
    .ap_ready            (black_box_ap_ready                 ), //o
    .ap_done             (black_box_ap_done                  ), //o
    .x_stream_TDATA      (x_stream_TDATA[735:0]              ), //i
    .x_stream_TVALID     (x_stream_TVALID                    ), //i
    .x_stream_TREADY     (black_box_x_stream_TREADY          ), //o
    .res_i_stream_TDATA  (res_i_stream_TDATA[183:0]          ), //i
    .res_i_stream_TVALID (res_i_stream_TVALID                ), //i
    .res_i_stream_TREADY (black_box_res_i_stream_TREADY      ), //o
    .res_o_stream_TDATA  (black_box_res_o_stream_TDATA[735:0]), //o
    .res_o_stream_TVALID (black_box_res_o_stream_TVALID      ), //o
    .res_o_stream_TREADY (res_o_stream_TREADY                ), //i
    .y_stream_TDATA      (black_box_y_stream_TDATA[735:0]    ), //o
    .y_stream_TVALID     (black_box_y_stream_TVALID          ), //o
    .y_stream_TREADY     (y_stream_TREADY                    )  //i
  );
  Manager_3 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign x_stream_TREADY = black_box_x_stream_TREADY;
  assign res_i_stream_TREADY = black_box_res_i_stream_TREADY;
  assign res_o_stream_TDATA = black_box_res_o_stream_TDATA;
  assign res_o_stream_TVALID = black_box_res_o_stream_TVALID;
  assign y_stream_TDATA = black_box_y_stream_TDATA;
  assign y_stream_TVALID = black_box_y_stream_TVALID;

endmodule

module SILU_EM_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          ug_stream_TVALID,
  output wire          ug_stream_TREADY,
  input  wire [127:0]  ug_stream_TDATA,
  output wire          q_stream_TVALID,
  input  wire          q_stream_TREADY,
  output wire [47:0]   q_stream_TDATA,
  output wire          s_stream_TVALID,
  input  wire          s_stream_TREADY,
  output wire [7:0]    s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_ug_stream_TREADY;
  wire       [47:0]   black_box_q_stream_TDATA;
  wire                black_box_q_stream_TVALID;
  wire       [7:0]    black_box_s_stream_TDATA;
  wire                black_box_s_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  SILU_EM_QUANT black_box (
    .ap_clk           (clk                           ), //i
    .ap_rst_n         (resetn                        ), //i
    .ap_start         (manager_11_ap_ctrl_ap_start   ), //i
    .ap_continue      (manager_11_ap_ctrl_ap_continue), //i
    .ap_idle          (black_box_ap_idle             ), //o
    .ap_ready         (black_box_ap_ready            ), //o
    .ap_done          (black_box_ap_done             ), //o
    .ug_stream_TDATA  (ug_stream_TDATA[127:0]        ), //i
    .ug_stream_TVALID (ug_stream_TVALID              ), //i
    .ug_stream_TREADY (black_box_ug_stream_TREADY    ), //o
    .q_stream_TDATA   (black_box_q_stream_TDATA[47:0]), //o
    .q_stream_TVALID  (black_box_q_stream_TVALID     ), //o
    .q_stream_TREADY  (q_stream_TREADY               ), //i
    .s_stream_TDATA   (black_box_s_stream_TDATA[7:0] ), //o
    .s_stream_TVALID  (black_box_s_stream_TVALID     ), //o
    .s_stream_TREADY  (s_stream_TREADY               )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign ug_stream_TREADY = black_box_ug_stream_TREADY;
  assign q_stream_TDATA = black_box_q_stream_TDATA;
  assign q_stream_TVALID = black_box_q_stream_TVALID;
  assign s_stream_TDATA = black_box_s_stream_TDATA;
  assign s_stream_TVALID = black_box_s_stream_TVALID;

endmodule

module RV_GEMM_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          rq_stream_TVALID,
  output wire          rq_stream_TREADY,
  input  wire [191:0]  rq_stream_TDATA,
  input  wire          v_stream_TVALID,
  output wire          v_stream_TREADY,
  input  wire [127:0]  v_stream_TDATA,
  input  wire          rs_stream_TVALID,
  output wire          rs_stream_TREADY,
  input  wire [15:0]   rs_stream_TDATA,
  output wire          aq_stream_TVALID,
  input  wire          aq_stream_TREADY,
  output wire [191:0]  aq_stream_TDATA,
  output wire          as_stream_TVALID,
  input  wire          as_stream_TREADY,
  output wire [15:0]   as_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_rq_stream_TREADY;
  wire                black_box_rs_stream_TREADY;
  wire                black_box_v_stream_TREADY;
  wire       [191:0]  black_box_aq_stream_TDATA;
  wire                black_box_aq_stream_TVALID;
  wire       [15:0]   black_box_as_stream_TDATA;
  wire                black_box_as_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  RV_GEMM black_box (
    .ap_clk           (clk                             ), //i
    .ap_rst_n         (resetn                          ), //i
    .ap_start         (manager_11_ap_ctrl_ap_start     ), //i
    .ap_continue      (manager_11_ap_ctrl_ap_continue  ), //i
    .ap_idle          (black_box_ap_idle               ), //o
    .ap_ready         (black_box_ap_ready              ), //o
    .ap_done          (black_box_ap_done               ), //o
    .rq_stream_TDATA  (rq_stream_TDATA[191:0]          ), //i
    .rq_stream_TVALID (rq_stream_TVALID                ), //i
    .rq_stream_TREADY (black_box_rq_stream_TREADY      ), //o
    .rs_stream_TDATA  (rs_stream_TDATA[15:0]           ), //i
    .rs_stream_TVALID (rs_stream_TVALID                ), //i
    .rs_stream_TREADY (black_box_rs_stream_TREADY      ), //o
    .v_stream_TDATA   (v_stream_TDATA[127:0]           ), //i
    .v_stream_TVALID  (v_stream_TVALID                 ), //i
    .v_stream_TREADY  (black_box_v_stream_TREADY       ), //o
    .aq_stream_TDATA  (black_box_aq_stream_TDATA[191:0]), //o
    .aq_stream_TVALID (black_box_aq_stream_TVALID      ), //o
    .aq_stream_TREADY (aq_stream_TREADY                ), //i
    .as_stream_TDATA  (black_box_as_stream_TDATA[15:0] ), //o
    .as_stream_TVALID (black_box_as_stream_TVALID      ), //o
    .as_stream_TREADY (as_stream_TREADY                )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign rq_stream_TREADY = black_box_rq_stream_TREADY;
  assign v_stream_TREADY = black_box_v_stream_TREADY;
  assign rs_stream_TREADY = black_box_rs_stream_TREADY;
  assign aq_stream_TDATA = black_box_aq_stream_TDATA;
  assign aq_stream_TVALID = black_box_aq_stream_TVALID;
  assign as_stream_TDATA = black_box_as_stream_TDATA;
  assign as_stream_TVALID = black_box_as_stream_TVALID;

endmodule

module SOFTMAX_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          r_stream_TVALID,
  output wire          r_stream_TREADY,
  input  wire [447:0]  r_stream_TDATA,
  output wire          rq_stream_TVALID,
  input  wire          rq_stream_TREADY,
  output wire [191:0]  rq_stream_TDATA,
  output wire          rs_stream_TVALID,
  input  wire          rs_stream_TREADY,
  output wire [15:0]   rs_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_r_stream_TREADY;
  wire       [191:0]  black_box_rq_stream_TDATA;
  wire                black_box_rq_stream_TVALID;
  wire       [15:0]   black_box_rs_stream_TDATA;
  wire                black_box_rs_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  SOFTMAX_QUANT black_box (
    .ap_clk           (clk                             ), //i
    .ap_rst_n         (resetn                          ), //i
    .ap_start         (manager_11_ap_ctrl_ap_start     ), //i
    .ap_continue      (manager_11_ap_ctrl_ap_continue  ), //i
    .ap_idle          (black_box_ap_idle               ), //o
    .ap_ready         (black_box_ap_ready              ), //o
    .ap_done          (black_box_ap_done               ), //o
    .r_stream_TDATA   (r_stream_TDATA[447:0]           ), //i
    .r_stream_TVALID  (r_stream_TVALID                 ), //i
    .r_stream_TREADY  (black_box_r_stream_TREADY       ), //o
    .rq_stream_TDATA  (black_box_rq_stream_TDATA[191:0]), //o
    .rq_stream_TVALID (black_box_rq_stream_TVALID      ), //o
    .rq_stream_TREADY (rq_stream_TREADY                ), //i
    .rs_stream_TDATA  (black_box_rs_stream_TDATA[15:0] ), //o
    .rs_stream_TVALID (black_box_rs_stream_TVALID      ), //o
    .rs_stream_TREADY (rs_stream_TREADY                )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign r_stream_TREADY = black_box_r_stream_TREADY;
  assign rq_stream_TDATA = black_box_rq_stream_TDATA;
  assign rq_stream_TVALID = black_box_rq_stream_TVALID;
  assign rs_stream_TDATA = black_box_rs_stream_TDATA;
  assign rs_stream_TVALID = black_box_rs_stream_TVALID;

endmodule

module QK_GEMM_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          qk_q_stream_TVALID,
  output wire          qk_q_stream_TREADY,
  input  wire [47:0]   qk_q_stream_TDATA,
  input  wire          qk_s_stream_TVALID,
  output wire          qk_s_stream_TREADY,
  input  wire [7:0]    qk_s_stream_TDATA,
  output wire          r_stream_TVALID,
  input  wire          r_stream_TREADY,
  output wire [447:0]  r_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_qk_q_stream_TREADY;
  wire                black_box_qk_s_stream_TREADY;
  wire       [447:0]  black_box_r_stream_TDATA;
  wire                black_box_r_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  QK_GEMM black_box (
    .ap_clk             (clk                            ), //i
    .ap_rst_n           (resetn                         ), //i
    .ap_start           (manager_11_ap_ctrl_ap_start    ), //i
    .ap_continue        (manager_11_ap_ctrl_ap_continue ), //i
    .ap_idle            (black_box_ap_idle              ), //o
    .ap_ready           (black_box_ap_ready             ), //o
    .ap_done            (black_box_ap_done              ), //o
    .qk_q_stream_TDATA  (qk_q_stream_TDATA[47:0]        ), //i
    .qk_q_stream_TVALID (qk_q_stream_TVALID             ), //i
    .qk_q_stream_TREADY (black_box_qk_q_stream_TREADY   ), //o
    .qk_s_stream_TDATA  (qk_s_stream_TDATA[7:0]         ), //i
    .qk_s_stream_TVALID (qk_s_stream_TVALID             ), //i
    .qk_s_stream_TREADY (black_box_qk_s_stream_TREADY   ), //o
    .r_stream_TDATA     (black_box_r_stream_TDATA[447:0]), //o
    .r_stream_TVALID    (black_box_r_stream_TVALID      ), //o
    .r_stream_TREADY    (r_stream_TREADY                )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign qk_q_stream_TREADY = black_box_qk_q_stream_TREADY;
  assign qk_s_stream_TREADY = black_box_qk_s_stream_TREADY;
  assign r_stream_TDATA = black_box_r_stream_TDATA;
  assign r_stream_TVALID = black_box_r_stream_TVALID;

endmodule

module ROPE_QK_QUANT_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          qk_stream_TVALID,
  output wire          qk_stream_TREADY,
  input  wire [127:0]  qk_stream_TDATA,
  output wire          rot_q_stream_TVALID,
  input  wire          rot_q_stream_TREADY,
  output wire [47:0]   rot_q_stream_TDATA,
  output wire          rot_s_stream_TVALID,
  input  wire          rot_s_stream_TREADY,
  output wire [7:0]    rot_s_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_qk_stream_TREADY;
  wire       [47:0]   black_box_rot_q_stream_TDATA;
  wire                black_box_rot_q_stream_TVALID;
  wire       [7:0]    black_box_rot_s_stream_TDATA;
  wire                black_box_rot_s_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  ROPE_QK_QUANT black_box (
    .ap_clk              (clk                               ), //i
    .ap_rst_n            (resetn                            ), //i
    .pos_id              (manager_11_signals_O_POS[11:0]    ), //i
    .ap_start            (manager_11_ap_ctrl_ap_start       ), //i
    .ap_continue         (manager_11_ap_ctrl_ap_continue    ), //i
    .ap_idle             (black_box_ap_idle                 ), //o
    .ap_ready            (black_box_ap_ready                ), //o
    .ap_done             (black_box_ap_done                 ), //o
    .qk_stream_TDATA     (qk_stream_TDATA[127:0]            ), //i
    .qk_stream_TVALID    (qk_stream_TVALID                  ), //i
    .qk_stream_TREADY    (black_box_qk_stream_TREADY        ), //o
    .rot_q_stream_TDATA  (black_box_rot_q_stream_TDATA[47:0]), //o
    .rot_q_stream_TVALID (black_box_rot_q_stream_TVALID     ), //o
    .rot_q_stream_TREADY (rot_q_stream_TREADY               ), //i
    .rot_s_stream_TDATA  (black_box_rot_s_stream_TDATA[7:0] ), //o
    .rot_s_stream_TVALID (black_box_rot_s_stream_TVALID     ), //o
    .rot_s_stream_TREADY (rot_s_stream_TREADY               )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign qk_stream_TREADY = black_box_qk_stream_TREADY;
  assign rot_q_stream_TDATA = black_box_rot_q_stream_TDATA;
  assign rot_q_stream_TVALID = black_box_rot_q_stream_TVALID;
  assign rot_s_stream_TDATA = black_box_rot_s_stream_TDATA;
  assign rot_s_stream_TVALID = black_box_rot_s_stream_TVALID;

endmodule

module DEMUX_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          gemm_stream_TVALID,
  output wire          gemm_stream_TREADY,
  input  wire [183:0]  gemm_stream_TDATA,
  output wire          qk_stream_TVALID,
  input  wire          qk_stream_TREADY,
  output wire [127:0]  qk_stream_TDATA,
  output wire          v_stream_TVALID,
  input  wire          v_stream_TREADY,
  output wire [127:0]  v_stream_TDATA,
  output wire          ug_stream_TVALID,
  input  wire          ug_stream_TREADY,
  output wire [127:0]  ug_stream_TDATA,
  output wire          od_stream_TVALID,
  input  wire          od_stream_TREADY,
  output wire [183:0]  od_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_gemm_stream_TREADY;
  wire       [127:0]  black_box_qk_stream_TDATA;
  wire                black_box_qk_stream_TVALID;
  wire       [127:0]  black_box_v_stream_TDATA;
  wire                black_box_v_stream_TVALID;
  wire       [127:0]  black_box_ug_stream_TDATA;
  wire                black_box_ug_stream_TVALID;
  wire       [183:0]  black_box_od_stream_TDATA;
  wire                black_box_od_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  DEMUX black_box (
    .ap_clk             (clk                             ), //i
    .ap_rst_n           (resetn                          ), //i
    .ap_start           (manager_11_ap_ctrl_ap_start     ), //i
    .ap_continue        (manager_11_ap_ctrl_ap_continue  ), //i
    .ap_idle            (black_box_ap_idle               ), //o
    .ap_ready           (black_box_ap_ready              ), //o
    .ap_done            (black_box_ap_done               ), //o
    .gemm_stream_TDATA  (gemm_stream_TDATA[183:0]        ), //i
    .gemm_stream_TVALID (gemm_stream_TVALID              ), //i
    .gemm_stream_TREADY (black_box_gemm_stream_TREADY    ), //o
    .qk_stream_TDATA    (black_box_qk_stream_TDATA[127:0]), //o
    .qk_stream_TVALID   (black_box_qk_stream_TVALID      ), //o
    .qk_stream_TREADY   (qk_stream_TREADY                ), //i
    .v_stream_TDATA     (black_box_v_stream_TDATA[127:0] ), //o
    .v_stream_TVALID    (black_box_v_stream_TVALID       ), //o
    .v_stream_TREADY    (v_stream_TREADY                 ), //i
    .ug_stream_TDATA    (black_box_ug_stream_TDATA[127:0]), //o
    .ug_stream_TVALID   (black_box_ug_stream_TVALID      ), //o
    .ug_stream_TREADY   (ug_stream_TREADY                ), //i
    .od_stream_TDATA    (black_box_od_stream_TDATA[183:0]), //o
    .od_stream_TVALID   (black_box_od_stream_TVALID      ), //o
    .od_stream_TREADY   (od_stream_TREADY                )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign gemm_stream_TREADY = black_box_gemm_stream_TREADY;
  assign qk_stream_TDATA = black_box_qk_stream_TDATA;
  assign qk_stream_TVALID = black_box_qk_stream_TVALID;
  assign v_stream_TDATA = black_box_v_stream_TDATA;
  assign v_stream_TVALID = black_box_v_stream_TVALID;
  assign ug_stream_TDATA = black_box_ug_stream_TDATA;
  assign ug_stream_TVALID = black_box_ug_stream_TVALID;
  assign od_stream_TDATA = black_box_od_stream_TDATA;
  assign od_stream_TVALID = black_box_od_stream_TVALID;

endmodule

module GEMM_wrapper (
  input  wire          resetn,
  input  wire          clk,
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
  output wire [11:0]   signals_O_POS,
  output wire          signals_O_T,
  input  wire          i_stream_TVALID,
  output wire          i_stream_TREADY,
  input  wire [1535:0] i_stream_TDATA,
  input  wire          w_stream_TVALID,
  output wire          w_stream_TREADY,
  input  wire [255:0]  w_stream_TDATA,
  input  wire          s_stream_TVALID,
  output wire          s_stream_TREADY,
  input  wire [127:0]  s_stream_TDATA,
  input  wire          s1_stream_TVALID,
  output wire          s1_stream_TREADY,
  input  wire [23:0]   s1_stream_TDATA,
  input  wire          s2_stream_TVALID,
  output wire          s2_stream_TREADY,
  input  wire [23:0]   s2_stream_TDATA,
  output wire          o_stream_TVALID,
  input  wire          o_stream_TREADY,
  output wire [183:0]  o_stream_TDATA
);

  wire                black_box_ap_idle;
  wire                black_box_ap_ready;
  wire                black_box_ap_done;
  wire                black_box_i_stream_TREADY;
  wire                black_box_w_stream_TREADY;
  wire                black_box_s_stream_TREADY;
  wire                black_box_s1_stream_TREADY;
  wire                black_box_s2_stream_TREADY;
  wire       [183:0]  black_box_o_stream_TDATA;
  wire                black_box_o_stream_TVALID;
  wire       [31:0]   manager_11_signals_O_L_BEGIN;
  wire       [31:0]   manager_11_signals_O_L_CLOSE;
  wire       [63:0]   manager_11_signals_O_MEMORY_X;
  wire       [63:0]   manager_11_signals_O_MEMORY_W;
  wire       [63:0]   manager_11_signals_O_MEMORY_Y;
  wire       [11:0]   manager_11_signals_O_POS;
  wire                manager_11_signals_O_T;
  wire                manager_11_ap_ctrl_ap_start;
  wire                manager_11_ap_ctrl_ap_continue;
  wire       [31:0]   manager_11_l;

  GEMM_PERMUTE black_box (
    .ap_clk           (clk                            ), //i
    .ap_rst_n         (resetn                         ), //i
    .ap_start         (manager_11_ap_ctrl_ap_start    ), //i
    .ap_continue      (manager_11_ap_ctrl_ap_continue ), //i
    .ap_idle          (black_box_ap_idle              ), //o
    .ap_ready         (black_box_ap_ready             ), //o
    .ap_done          (black_box_ap_done              ), //o
    .i_stream_TDATA   (i_stream_TDATA[1535:0]         ), //i
    .i_stream_TVALID  (i_stream_TVALID                ), //i
    .i_stream_TREADY  (black_box_i_stream_TREADY      ), //o
    .w_stream_TDATA   (w_stream_TDATA[255:0]          ), //i
    .w_stream_TVALID  (w_stream_TVALID                ), //i
    .w_stream_TREADY  (black_box_w_stream_TREADY      ), //o
    .s_stream_TDATA   (s_stream_TDATA[127:0]          ), //i
    .s_stream_TVALID  (s_stream_TVALID                ), //i
    .s_stream_TREADY  (black_box_s_stream_TREADY      ), //o
    .s1_stream_TDATA  (s1_stream_TDATA[23:0]          ), //i
    .s1_stream_TVALID (s1_stream_TVALID               ), //i
    .s1_stream_TREADY (black_box_s1_stream_TREADY     ), //o
    .s2_stream_TDATA  (s2_stream_TDATA[23:0]          ), //i
    .s2_stream_TVALID (s2_stream_TVALID               ), //i
    .s2_stream_TREADY (black_box_s2_stream_TREADY     ), //o
    .o_stream_TDATA   (black_box_o_stream_TDATA[183:0]), //o
    .o_stream_TVALID  (black_box_o_stream_TVALID      ), //o
    .o_stream_TREADY  (o_stream_TREADY                )  //i
  );
  Manager_10 manager_11 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]            ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]            ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]           ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]           ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]           ), //i
    .signals_I_POS       (signals_I_POS[11:0]                ), //i
    .signals_I_T         (signals_I_T                        ), //i
    .signals_O_L_BEGIN   (manager_11_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_11_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_11_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_11_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_11_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_POS       (manager_11_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_11_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_11_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_11_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                  ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                 ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                  ), //i
    .l                   (manager_11_l[31:0]                 ), //o
    .clk                 (clk                                ), //i
    .resetn              (resetn                             )  //i
  );
  assign signals_O_L_BEGIN = manager_11_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_11_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_11_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_11_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_11_signals_O_MEMORY_Y;
  assign signals_O_POS = manager_11_signals_O_POS;
  assign signals_O_T = manager_11_signals_O_T;
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign w_stream_TREADY = black_box_w_stream_TREADY;
  assign s_stream_TREADY = black_box_s_stream_TREADY;
  assign s1_stream_TREADY = black_box_s1_stream_TREADY;
  assign s2_stream_TREADY = black_box_s2_stream_TREADY;
  assign o_stream_TDATA = black_box_o_stream_TDATA;
  assign o_stream_TVALID = black_box_o_stream_TVALID;

endmodule

//Manager_1 replaced by Manager_10

//Manager_2 replaced by Manager_10

module Manager_3 (
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
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
  reg        [11:0]   signals_I_POS_regNext;
  reg                 signals_I_T_regNext;
  reg        [31:0]   l_counter;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                when_Manager_l141;
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
          if(when_Manager_l141) begin
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

  assign when_Manager_l141 = 1'b1;
  always @(posedge clk) begin
    signals_I_L_BEGIN_regNext <= signals_I_L_BEGIN;
    signals_I_L_CLOSE_regNext <= signals_I_L_CLOSE;
    signals_I_MEMORY_X_regNext <= signals_I_MEMORY_X;
    signals_I_MEMORY_W_regNext <= signals_I_MEMORY_W;
    signals_I_MEMORY_Y_regNext <= signals_I_MEMORY_Y;
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
            if(!when_Manager_l141) begin
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

//Manager_4 replaced by Manager_10

//Manager_5 replaced by Manager_10

//Manager_6 replaced by Manager_10

//Manager_7 replaced by Manager_10

//Manager_8 replaced by Manager_10

//Manager_9 replaced by Manager_10

module Manager_10 (
  input  wire [31:0]   signals_I_L_BEGIN,
  input  wire [31:0]   signals_I_L_CLOSE,
  input  wire [63:0]   signals_I_MEMORY_X,
  input  wire [63:0]   signals_I_MEMORY_W,
  input  wire [63:0]   signals_I_MEMORY_Y,
  input  wire [11:0]   signals_I_POS,
  input  wire          signals_I_T,
  output wire [31:0]   signals_O_L_BEGIN,
  output wire [31:0]   signals_O_L_CLOSE,
  output wire [63:0]   signals_O_MEMORY_X,
  output wire [63:0]   signals_O_MEMORY_W,
  output wire [63:0]   signals_O_MEMORY_Y,
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

  wire       [31:0]   _zz_when_Manager_l141;
  reg        [31:0]   signals_I_L_BEGIN_regNext;
  reg        [31:0]   signals_I_L_CLOSE_regNext;
  reg        [63:0]   signals_I_MEMORY_X_regNext;
  reg        [63:0]   signals_I_MEMORY_W_regNext;
  reg        [63:0]   signals_I_MEMORY_Y_regNext;
  reg        [11:0]   signals_I_POS_regNext;
  reg                 signals_I_T_regNext;
  reg        [31:0]   l_counter;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                when_Manager_l141;
  `ifndef SYNTHESIS
  reg [47:0] fsm_stateReg_string;
  reg [47:0] fsm_stateNext_string;
  `endif


  assign _zz_when_Manager_l141 = (signals_I_L_CLOSE - 32'h00000001);
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
          if(when_Manager_l141) begin
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

  assign when_Manager_l141 = (l_counter == _zz_when_Manager_l141);
  always @(posedge clk) begin
    signals_I_L_BEGIN_regNext <= signals_I_L_BEGIN;
    signals_I_L_CLOSE_regNext <= signals_I_L_CLOSE;
    signals_I_MEMORY_X_regNext <= signals_I_MEMORY_X;
    signals_I_MEMORY_W_regNext <= signals_I_MEMORY_W;
    signals_I_MEMORY_Y_regNext <= signals_I_MEMORY_Y;
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
            if(!when_Manager_l141) begin
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

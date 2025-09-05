// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : M_AXI_wrapper
// Git hash  : d4a6ec38cc380ffeae6f6507839071d472a474af

`timescale 1ns/1ps

module M_AXI_wrapper (
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
  wire       [255:0]  black_box_wq_stream_TDATA;
  wire                black_box_wq_stream_TVALID;
  wire       [23:0]   black_box_ws1_stream_TDATA;
  wire                black_box_ws1_stream_TVALID;
  wire       [23:0]   black_box_ws2_stream_TDATA;
  wire                black_box_ws2_stream_TVALID;
  wire                black_box_y_stream_TREADY;
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
  wire       [31:0]   manager_1_signals_O_L_BEGIN;
  wire       [31:0]   manager_1_signals_O_L_CLOSE;
  wire       [63:0]   manager_1_signals_O_MEMORY_X;
  wire       [63:0]   manager_1_signals_O_MEMORY_W;
  wire       [63:0]   manager_1_signals_O_MEMORY_Y;
  wire       [63:0]   manager_1_signals_O_MEMORY_C;
  wire       [63:0]   manager_1_signals_O_MEMORY_H;
  wire       [11:0]   manager_1_signals_O_POS;
  wire                manager_1_signals_O_T;
  wire                manager_1_ap_ctrl_ap_start;
  wire                manager_1_ap_ctrl_ap_continue;
  wire       [31:0]   manager_1_l;

  M_AXI black_box (
    .ap_clk              (clk                               ), //i
    .ap_rst_n            (resetn                            ), //i
    .l_begin             (manager_1_signals_O_L_BEGIN[31:0] ), //i
    .l_close             (manager_1_signals_O_L_CLOSE[31:0] ), //i
    .memory_x            (manager_1_signals_O_MEMORY_X[63:0]), //i
    .memory_w            (manager_1_signals_O_MEMORY_W[63:0]), //i
    .memory_y            (manager_1_signals_O_MEMORY_Y[63:0]), //i
    .memory_c            (manager_1_signals_O_MEMORY_C[63:0]), //i
    .memory_h            (manager_1_signals_O_MEMORY_H[63:0]), //i
    .ap_start            (manager_1_ap_ctrl_ap_start        ), //i
    .ap_continue         (manager_1_ap_ctrl_ap_continue     ), //i
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
    .wq_stream_TDATA     (black_box_wq_stream_TDATA[255:0]  ), //o
    .wq_stream_TVALID    (black_box_wq_stream_TVALID        ), //o
    .wq_stream_TREADY    (wq_stream_TREADY                  ), //i
    .ws1_stream_TDATA    (black_box_ws1_stream_TDATA[23:0]  ), //o
    .ws1_stream_TVALID   (black_box_ws1_stream_TVALID       ), //o
    .ws1_stream_TREADY   (ws1_stream_TREADY                 ), //i
    .ws2_stream_TDATA    (black_box_ws2_stream_TDATA[23:0]  ), //o
    .ws2_stream_TVALID   (black_box_ws2_stream_TVALID       ), //o
    .ws2_stream_TREADY   (ws2_stream_TREADY                 ), //i
    .y_stream_TDATA      (y_stream_TDATA[255:0]             ), //i
    .y_stream_TVALID     (y_stream_TVALID                   ), //i
    .y_stream_TREADY     (black_box_y_stream_TREADY         ), //o
    .cq_stream_TDATA     (black_box_cq_stream_TDATA[255:0]  ), //o
    .cq_stream_TVALID    (black_box_cq_stream_TVALID        ), //o
    .cq_stream_TREADY    (cq_stream_TREADY                  ), //i
    .cs_stream_TDATA     (black_box_cs_stream_TDATA[255:0]  ), //o
    .cs_stream_TVALID    (black_box_cs_stream_TVALID        ), //o
    .cs_stream_TREADY    (cs_stream_TREADY                  ), //i
    .cq2_stream_TDATA    (cq2_stream_TDATA[255:0]           ), //i
    .cq2_stream_TVALID   (cq2_stream_TVALID                 ), //i
    .cq2_stream_TREADY   (black_box_cq2_stream_TREADY       ), //o
    .cs2_stream_TDATA    (cs2_stream_TDATA[255:0]           ), //i
    .cs2_stream_TVALID   (cs2_stream_TVALID                 ), //i
    .cs2_stream_TREADY   (black_box_cs2_stream_TREADY       ), //o
    .hq_stream_TDATA     (black_box_hq_stream_TDATA[255:0]  ), //o
    .hq_stream_TVALID    (black_box_hq_stream_TVALID        ), //o
    .hq_stream_TREADY    (hq_stream_TREADY                  ), //i
    .hs_stream_TDATA     (black_box_hs_stream_TDATA[255:0]  ), //o
    .hs_stream_TVALID    (black_box_hs_stream_TVALID        ), //o
    .hs_stream_TREADY    (hs_stream_TREADY                  ), //i
    .hq2_stream_TDATA    (hq2_stream_TDATA[255:0]           ), //i
    .hq2_stream_TVALID   (hq2_stream_TVALID                 ), //i
    .hq2_stream_TREADY   (black_box_hq2_stream_TREADY       ), //o
    .hs2_stream_TDATA    (hs2_stream_TDATA[255:0]           ), //i
    .hs2_stream_TVALID   (hs2_stream_TVALID                 ), //i
    .hs2_stream_TREADY   (black_box_hs2_stream_TREADY       )  //o
  );
  Manager manager_1 (
    .signals_I_L_BEGIN   (signals_I_L_BEGIN[31:0]           ), //i
    .signals_I_L_CLOSE   (signals_I_L_CLOSE[31:0]           ), //i
    .signals_I_MEMORY_X  (signals_I_MEMORY_X[63:0]          ), //i
    .signals_I_MEMORY_W  (signals_I_MEMORY_W[63:0]          ), //i
    .signals_I_MEMORY_Y  (signals_I_MEMORY_Y[63:0]          ), //i
    .signals_I_MEMORY_C  (signals_I_MEMORY_C[63:0]          ), //i
    .signals_I_MEMORY_H  (signals_I_MEMORY_H[63:0]          ), //i
    .signals_I_POS       (signals_I_POS[11:0]               ), //i
    .signals_I_T         (signals_I_T                       ), //i
    .signals_O_L_BEGIN   (manager_1_signals_O_L_BEGIN[31:0] ), //o
    .signals_O_L_CLOSE   (manager_1_signals_O_L_CLOSE[31:0] ), //o
    .signals_O_MEMORY_X  (manager_1_signals_O_MEMORY_X[63:0]), //o
    .signals_O_MEMORY_W  (manager_1_signals_O_MEMORY_W[63:0]), //o
    .signals_O_MEMORY_Y  (manager_1_signals_O_MEMORY_Y[63:0]), //o
    .signals_O_MEMORY_C  (manager_1_signals_O_MEMORY_C[63:0]), //o
    .signals_O_MEMORY_H  (manager_1_signals_O_MEMORY_H[63:0]), //o
    .signals_O_POS       (manager_1_signals_O_POS[11:0]     ), //o
    .signals_O_T         (manager_1_signals_O_T             ), //o
    .ap_ctrl_ap_start    (manager_1_ap_ctrl_ap_start        ), //o
    .ap_ctrl_ap_continue (manager_1_ap_ctrl_ap_continue     ), //o
    .ap_ctrl_ap_idle     (black_box_ap_idle                 ), //i
    .ap_ctrl_ap_ready    (black_box_ap_ready                ), //i
    .ap_ctrl_ap_done     (black_box_ap_done                 ), //i
    .l                   (manager_1_l[31:0]                 ), //o
    .clk                 (clk                               ), //i
    .resetn              (resetn                            )  //i
  );
  assign signals_O_L_BEGIN = manager_1_signals_O_L_BEGIN;
  assign signals_O_L_CLOSE = manager_1_signals_O_L_CLOSE;
  assign signals_O_MEMORY_X = manager_1_signals_O_MEMORY_X;
  assign signals_O_MEMORY_W = manager_1_signals_O_MEMORY_W;
  assign signals_O_MEMORY_Y = manager_1_signals_O_MEMORY_Y;
  assign signals_O_MEMORY_C = manager_1_signals_O_MEMORY_C;
  assign signals_O_MEMORY_H = manager_1_signals_O_MEMORY_H;
  assign signals_O_POS = manager_1_signals_O_POS;
  assign signals_O_T = manager_1_signals_O_T;
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

module Manager (
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

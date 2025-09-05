// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : C_BUFFER_wrapper
// Git hash  : e2ef8cc2f1cbdac0820a4d9cf5fd5d295403aa52

`timescale 1ns/1ps

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

  C_BUFFER black_box (
    .ap_clk            (clk                           ), //i
    .ap_rst_n          (resetn                        ), //i
    .ap_start          (manager_1_ap_ctrl_ap_start    ), //i
    .ap_continue       (manager_1_ap_ctrl_ap_continue ), //i
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
  assign i_stream_TREADY = black_box_i_stream_TREADY;
  assign i_s_stream_TREADY = black_box_i_s_stream_TREADY;
  assign q_stream_TDATA = black_box_q_stream_TDATA;
  assign q_stream_TVALID = black_box_q_stream_TVALID;
  assign s_stream_TDATA = black_box_s_stream_TDATA;
  assign s_stream_TVALID = black_box_s_stream_TVALID;

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

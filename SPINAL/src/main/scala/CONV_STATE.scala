import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class CONV_STATE_Blackbox extends BlackBox {
  val top_name: String = "CONV_STATE"
  setDefinitionName(top_name)
  // source file
  private val verilog_file_path: String = s"src/main/verilog/$top_name/all.v"
  // define the IO of verilog entity
  val io = new Bundle {
    // clock and reset
    val ap_clk: Bool = in Bool()
    val ap_rst_n: Bool = in Bool()
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    val ap_ctrl: ApChain = slave(ApChain())
    val conv_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("conv_stream", verilog_file_path)))
    val conv_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("conv_s_stream", verilog_file_path)))
    val xBC_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("xBC_stream", verilog_file_path)))
    val xBC_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("xBC_s_stream", verilog_file_path)))
    val w_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("w_stream", verilog_file_path)))
    val w_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("w_s_stream", verilog_file_path)))
    val o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
    val o_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_s_stream", verilog_file_path)))
    val conv_state_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("conv_state_stream", verilog_file_path)))
    val conv_state_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("conv_state_s_stream", verilog_file_path)))
  }
  // no io prefix, this is essential for name matching
  noIoPrefix()
  // FIXME: here, renaming is for blackbox name matching, modify the name to match the verilog interface
  ApChainRenamer(io.ap_ctrl)
  // map clock domain, reset is active low
  mapClockDomain(clock = io.ap_clk, reset = io.ap_rst_n, resetActiveLevel = LOW)
  // add RTL code
  addRTLPath(verilog_file_path)
}

class CONV_STATE extends Component {
  val top_name: String = "CONV_STATE"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new CONV_STATE_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val conv_stream: Axi4Stream = slave(Axi4Stream(black_box.io.conv_stream.config.to_std_config()))
    val conv_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.conv_s_stream.config.to_std_config()))
    val xBC_stream: Axi4Stream = slave(Axi4Stream(black_box.io.xBC_stream.config.to_std_config()))
    val xBC_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.xBC_s_stream.config.to_std_config()))
    val w_stream: Axi4Stream = master(Axi4Stream(black_box.io.w_stream.config.to_std_config()))
    val w_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.w_s_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
    val o_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_s_stream.config.to_std_config()))
    val conv_state_stream: Axi4Stream = master(Axi4Stream(black_box.io.conv_state_stream.config.to_std_config()))
    val conv_state_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.conv_state_s_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.conv_stream.connect2std(io.conv_stream)
  black_box.io.conv_s_stream.connect2std(io.conv_s_stream)
  black_box.io.xBC_stream.connect2std(io.xBC_stream)
  black_box.io.xBC_s_stream.connect2std(io.xBC_s_stream)
  black_box.io.w_stream.connect2std(io.w_stream)
  black_box.io.w_s_stream.connect2std(io.w_s_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  black_box.io.o_s_stream.connect2std(io.o_s_stream)
  black_box.io.conv_state_stream.connect2std(io.conv_state_stream)
  black_box.io.conv_state_s_stream.connect2std(io.conv_state_s_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.conv_stream)
  Axi4StreamSpecRenamer(io.conv_s_stream)
  Axi4StreamSpecRenamer(io.xBC_stream)
  Axi4StreamSpecRenamer(io.xBC_s_stream)
  Axi4StreamSpecRenamer(io.w_stream)
  Axi4StreamSpecRenamer(io.w_s_stream)
  Axi4StreamSpecRenamer(io.o_stream)
  Axi4StreamSpecRenamer(io.o_s_stream)
  Axi4StreamSpecRenamer(io.conv_state_stream)
  Axi4StreamSpecRenamer(io.conv_state_s_stream)
}

object simulate_conv_state extends App {
  redirect_std("CONV_STATE.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new CONV_STATE)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new CONV_STATE)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      //      val L = 32
      val L = 2

      val T_LOAD = 512
      val T = 1
      val TP = 1

      val C = 5376
      val CP = G
      val N = 128
      val D = 4

      val STATE_P = 32
      val STATE_P_S = 64

      val CT = C / CP
      val NT = N / CP

      val ST = 4 * C / STATE_P
      val ST_S = 4 * CT / STATE_P_S

      val data_path_prefix = "D:/file/project/git/light-mamba/ref"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val xBC_q = read_multi_int64_files(format_str, L, "/activations/xBC_q_layer", 4 * C)
      val xBC_s = read_multi_int64_files(format_str, L, "/activations/xBC_s_layer", 4 * CT)
      val w_q = read_multi_int64_files(format_str, L, "/weights/conv_wq_layer", 4 * C)
      val w_s = read_multi_int64_files(format_str, L, "/weights/conv_ws_layer", 4 * CT)

      val ref_conv_q  = Array.ofDim[Long](L, 4 * C)
      val ref_conv_s  = Array.ofDim[Long](L, 4 * CT)
      for (l <- 0 until L) {
        for (ct <- 0 until ST) {
          for (cp <- 0 until STATE_P) {
            val index: Int=ct*STATE_P+cp
            val d2: Int=index/CP%D
            val ct2: Int=index/CP/D
            val cp2: Int=index%CP
            ref_conv_q(l)(index) = xBC_q(l)(d2*C+ct2*CP+cp2)
          }
        }
      }
      for (l <- 0 until L) {
        for (ct <- 0 until ST_S) {
          for (cp <- 0 until STATE_P_S) {
            val index: Int=ct*STATE_P_S+cp
            val d2: Int=index%D
            val ct2: Int=index/D
            ref_conv_s(l)(index) = xBC_s(l)(d2*CT+ct2)
          }
        }
      }
      val ref_w_q  = Array.ofDim[Long](L, 4 * C)
      val ref_w_s  = Array.ofDim[Long](L, 4 * CT)
      for (l <- 0 until L) {
        for (ct <- 0 until ST) {
          for (cp <- 0 until STATE_P) {
            val index: Int=ct*STATE_P+cp
            val d2: Int=index/CP%D
            val ct2: Int=index/CP/D
            val cp2: Int=index%CP
            ref_w_q(l)(index) = w_q(l)(d2*C+ct2*CP+cp2)
          }
        }
      }
      for (l <- 0 until L) {
        for (ct <- 0 until ST_S) {
          for (cp <- 0 until STATE_P_S) {
            val index: Int=ct*STATE_P_S+cp
            val d2: Int=index%D
            val ct2: Int=index/D
            ref_w_s(l)(index) = w_s(l)(d2*CT+ct2)
          }
        }
      }

      val ref_xBC_q  = Array.ofDim[Long](L, T * C)
      val ref_xBC_s  = Array.ofDim[Long](L, T * CT)
      for (l <- 0 until L) {
        for (c <- 0 until C) {
          ref_xBC_q(l)(c) = xBC_q(l)(3*C + c)
        }
        for (c <- 0 until CT) {
          ref_xBC_s(l)(c) = xBC_s(l)(3*CT + c)
        }
      }

      val ref_o_q  = Array.ofDim[Long](L, 4 * C)
      val ref_o_s  = Array.ofDim[Long](L, 4 * CT)
      for (l <- 0 until L) {
        for (ct <- 0 until CT) {
          for (d <- 0 until D) {
            for (cp <- 0 until CP) {
              ref_o_q(l)(ct*D*CP+d*CP+cp) = xBC_q(l)(d*C+ct*CP+cp)
            }
            ref_o_s(l)(ct*D+d) = xBC_s(l)(d*CT+ct)

          }
        }
      }

//      val ref_conv_out_q  = Array.ofDim[Long](L, 4 * C)
//      val ref_conv_out_s  = Array.ofDim[Long](L, 4 * CT)

      // dut arrays
      val DUT_o_Q  = Array.ofDim[Long](L, 4 * C)
      val DUT_o_S  = Array.ofDim[Long](L, 4 * CT)
      val DUT_w_Q  = Array.ofDim[Long](L, 4 * C)
      val DUT_w_S  = Array.ofDim[Long](L, 4 * CT)
      val DUT_conv_Q  = Array.ofDim[Long](L, 4 * C)
      val DUT_conv_S  = Array.ofDim[Long](L, 4 * CT)

      // init ap_ctrl and streams
      init_i_stream(dut.io.conv_stream)
      init_i_stream(dut.io.conv_s_stream)
      init_i_stream(dut.io.xBC_stream)
      init_i_stream(dut.io.xBC_s_stream)
      init_o_stream(dut.io.w_stream)
      init_o_stream(dut.io.w_s_stream)
      init_o_stream(dut.io.o_stream)
      init_o_stream(dut.io.o_s_stream)
      init_o_stream(dut.io.conv_state_stream)
      init_o_stream(dut.io.conv_state_s_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      init_clock(dut.clockDomain, 10)
      // threads
      Array(
        fork {
          dut.io.signals.I.L_BEGIN #= 0
          dut.io.signals.I.L_CLOSE #= L
          // delay 20 cycles to make sure the signals are set
          dut.clockDomain.waitSampling(20)
          // launch with trigger
          dut.io.signals.I.T #= true
          dut.clockDomain.waitSampling()
          dut.io.signals.I.T #= false
        },
        // @formatter:off
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.conv_stream, dut.clockDomain, ref_conv_q(l), 1, 1, TP, 1, C*4,  STATE_P, info="conv_in stream", verbose=true)
            array2stream(dut.io.conv_s_stream, dut.clockDomain, ref_conv_s(l), 1, 1, TP, 1, CT*4,  STATE_P_S, info="conv_in_s stream",verbose=true)
            array2stream(dut.io.conv_stream, dut.clockDomain, ref_w_q(l), 1, 1, TP, 1, C*4,  STATE_P, info="w_in stream", verbose=true)
            array2stream(dut.io.conv_s_stream, dut.clockDomain, ref_w_s(l), 1, 1, TP, 1, CT*4,  STATE_P_S, info="w_in_s stream",verbose=true)
          }
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.xBC_stream, dut.clockDomain, ref_xBC_q(l), 1, 1, TP, 1, C,  CP, info="xBC stream", verbose=true,DELAY=2000)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.xBC_s_stream, dut.clockDomain, ref_xBC_s(l), 1, 1, TP, 1, CT,  1, info="xBC_s stream",DELAY=2000)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_stream,  dut.clockDomain, ref_o_q(l), DUT_o_Q(l),  1, TP, 1, C*4,  CP, info="o stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_s_stream,  dut.clockDomain, ref_o_s(l), DUT_o_S(l),  1, TP, 1, CT*4, 1, info="o_s stream",is_signed =false)
        } ,
        fork {
          for (l <- 0 until L) stream2array(dut.io.w_stream,  dut.clockDomain, ref_w_q(l), DUT_w_Q(l),  1, TP, 1, C*4,  CP, info="w stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.w_s_stream,  dut.clockDomain, ref_w_s(l), DUT_w_S(l),  1, TP, 1, CT*4, 1, info="w_s stream",is_signed =false)
        } ,
        fork {
          for (l <- 0 until L) {
            stream2array(dut.io.conv_state_stream,  dut.clockDomain, ref_conv_q(l), DUT_conv_Q(l),  1, TP, 1, C*4,  STATE_P, info="conv stream", verbose=true)
            stream2array(dut.io.conv_state_s_stream,  dut.clockDomain, ref_conv_s(l), DUT_conv_S(l),  1, TP, 1, CT*4, STATE_P_S, info="conv_s stream",verbose=true,is_signed = false)
          }
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_conv_Q.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


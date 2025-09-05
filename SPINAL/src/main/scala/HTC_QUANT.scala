import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class HTC_QUANT_Blackbox extends BlackBox {
  val top_name: String = "HTC_QUANT"
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
    val ht_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht_stream", verilog_file_path)))
    val ht_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht_s_stream", verilog_file_path)))
    val C_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("C_stream", verilog_file_path)))
    val C_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("C_s_stream", verilog_file_path)))
    val uD_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("uD_stream", verilog_file_path)))
    val o_q_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_q_stream", verilog_file_path)))
    val o_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_s_stream", verilog_file_path)))
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

class HTC_QUANT extends Component {
  val top_name: String = "HTC_QUANT"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new HTC_QUANT_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val ht_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht_stream.config.to_std_config()))
    val ht_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht_s_stream.config.to_std_config()))
    val C_stream: Axi4Stream = slave(Axi4Stream(black_box.io.C_stream.config.to_std_config()))
    val C_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.C_s_stream.config.to_std_config()))
    val uD_stream: Axi4Stream = slave(Axi4Stream(black_box.io.uD_stream.config.to_std_config()))
    val o_q_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_q_stream.config.to_std_config()))
    val o_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_s_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.ht_stream.connect2std(io.ht_stream)
  black_box.io.ht_s_stream.connect2std(io.ht_s_stream)
  black_box.io.C_stream.connect2std(io.C_stream)
  black_box.io.C_s_stream.connect2std(io.C_s_stream)
  black_box.io.uD_stream.connect2std(io.uD_stream)
  black_box.io.o_q_stream.connect2std(io.o_q_stream)
  black_box.io.o_s_stream.connect2std(io.o_s_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.ht_stream)
  Axi4StreamSpecRenamer(io.ht_s_stream)
  Axi4StreamSpecRenamer(io.C_stream)
  Axi4StreamSpecRenamer(io.C_s_stream)
  Axi4StreamSpecRenamer(io.uD_stream)
  Axi4StreamSpecRenamer(io.o_q_stream)
  Axi4StreamSpecRenamer(io.o_s_stream)
}

object simulate_htC_quant extends App {
  redirect_std("HTC_QUANT.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new HTC_QUANT)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new HTC_QUANT)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      //      val L = 32
      val L = 6

      val T_LOAD = 512
      val T = 1
      val TP = 1

      val C = 80
      val N = 128
      val P = 64
      val CP = G


      val CT = C / CP
      val NT = N / CP
      val PT = P / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val ht_q = read_multi_int64_files(format_str, L, "/ht2_q0_layer", T * C*P*N)
      val ht_s = read_multi_int64_files(format_str, L, "/ht2_s0_layer", T * C*P*NT)
      val C_q = read_multi_int64_files(format_str, L, "/C_q_layer", T * N)
      val C_s = read_multi_int64_files(format_str, L, "/C_s_layer", T * NT)
      val uD = read_multi_int64_files(format_str, L, "/uD_layer", T * C*P)
      val y_q = read_multi_int64_files(format_str, L, "/y_q_layer", T * C*P)
      val y_s = read_multi_int64_files(format_str, L, "/y_s_layer", T * C*PT)

      // dut arrays
      val DUT_y_q  = Array.ofDim[Long](L, T * C*P)
      val DUT_y_s  = Array.ofDim[Long](L, T * C*PT)

      // init ap_ctrl and streams
      init_i_stream(dut.io.ht_stream)
      init_i_stream(dut.io.ht_s_stream)
      init_i_stream(dut.io.C_stream)
      init_i_stream(dut.io.C_s_stream)
      init_i_stream(dut.io.uD_stream)
      init_o_stream(dut.io.o_q_stream)
      init_o_stream(dut.io.o_s_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      init_clock(dut.clockDomain, 10)
      // threads
      Array(
        fork {
          dut.io.signals.I.L_BEGIN #= L-1
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
          for (l <- L-1 until L) array2stream(dut.io.ht_stream, dut.clockDomain, ht_q(l), 1, 1, TP, 1, C*N*P,  CP, info="ht stream", verbose=true)
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.ht_s_stream, dut.clockDomain, ht_s(l), 1, 1, TP, 1, C*NT*P,  1, info="ht_s stream")
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.C_stream, dut.clockDomain, C_q(l), C*PT, 1, TP, 1, N,  CP, info="C stream", verbose=true)
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.C_s_stream, dut.clockDomain, C_s(l), C*PT, 1, TP, 1, NT,  1, info="C_s stream")
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.uD_stream, dut.clockDomain, uD(l), 1, 1, TP, 1, C*P,  CP, info="uD stream", verbose=true)
        },
        fork {
          for (l <- L-1 until L) stream2array(dut.io.o_q_stream,  dut.clockDomain, y_q(l), DUT_y_q(l),  1, TP, 1, C*P,  CP, info="y_q stream", verbose=true)
        },
        fork {
          for (l <- L-1 until L) stream2array(dut.io.o_s_stream,  dut.clockDomain, y_s(l), DUT_y_s(l),  1, TP, 1, C*PT,  1, info="y_s stream",is_signed = false)
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_y_q.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


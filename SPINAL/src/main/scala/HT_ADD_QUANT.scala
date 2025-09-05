import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class HT_ADD_QUANT_Blackbox extends BlackBox {
  val top_name: String = "HT_ADD_QUANT"
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
    val dAh_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dAh_stream", verilog_file_path)))
    val dBu_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dBu_stream", verilog_file_path)))
    val ht1_q_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht1_q_stream", verilog_file_path)))
    val ht1_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht1_s_stream", verilog_file_path)))
    val ht2_q_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht2_q_stream", verilog_file_path)))
    val ht2_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht2_s_stream", verilog_file_path)))
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

class HT_ADD_QUANT extends Component {
  val top_name: String = "HT_ADD_QUANT"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new HT_ADD_QUANT_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val dAh_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dAh_stream.config.to_std_config()))
    val dBu_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dBu_stream.config.to_std_config()))
    val ht1_q_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht1_q_stream.config.to_std_config()))
    val ht1_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht1_s_stream.config.to_std_config()))
    val ht2_q_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht2_q_stream.config.to_std_config()))
    val ht2_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht2_s_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.dAh_stream.connect2std(io.dAh_stream)
  black_box.io.dBu_stream.connect2std(io.dBu_stream)
  black_box.io.ht1_q_stream.connect2std(io.ht1_q_stream)
  black_box.io.ht1_s_stream.connect2std(io.ht1_s_stream)
  black_box.io.ht2_q_stream.connect2std(io.ht2_q_stream)
  black_box.io.ht2_s_stream.connect2std(io.ht2_s_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.dAh_stream)
  Axi4StreamSpecRenamer(io.dBu_stream)
  Axi4StreamSpecRenamer(io.ht1_q_stream)
  Axi4StreamSpecRenamer(io.ht1_s_stream)
  Axi4StreamSpecRenamer(io.ht2_q_stream)
  Axi4StreamSpecRenamer(io.ht2_s_stream)
}

object simulate_ht_add_quant extends App {
  redirect_std("HT_ADD_QUANT.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new HT_ADD_QUANT)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new HT_ADD_QUANT)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      //      val L = 32
      val L = 2

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
      val dAh = read_multi_int64_files(format_str, L, "/dAh1_layer", T * C*P*N)
      val dBu = read_multi_int64_files(format_str, L, "/dBu1_layer", T * C*P*N)
      val ht1_q = read_multi_int64_files(format_str, L, "/ht1_q1_layer", T * C*P*N)
      val ht1_s = read_multi_int64_files(format_str, L, "/ht1_s1_layer", T * C*PT*N)
      val ht2_q = read_multi_int64_files(format_str, L, "/ht2_q1_layer", T * C*P*N)
      val ht2_s = read_multi_int64_files(format_str, L, "/ht2_s1_layer", T * C*P*NT)

      // dut arrays
      val DUT_ht1_q  = Array.ofDim[Long](L, T * C*P*N)
      val DUT_ht1_s  = Array.ofDim[Long](L, T * C*PT*N)
      val DUT_ht2_q  = Array.ofDim[Long](L, T * C*P*N)
      val DUT_ht2_s  = Array.ofDim[Long](L, T * C*P*NT)

      // init ap_ctrl and streams
      init_i_stream(dut.io.dAh_stream)
      init_i_stream(dut.io.dBu_stream)
      init_o_stream(dut.io.ht1_q_stream)
      init_o_stream(dut.io.ht1_s_stream)
      init_o_stream(dut.io.ht2_q_stream)
      init_o_stream(dut.io.ht2_s_stream)
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
          for (l <- 0 until L) array2stream(dut.io.dAh_stream, dut.clockDomain, dAh(l), 1, 1, TP, 1, C*N*P,  CP, info="dAh stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.dBu_stream, dut.clockDomain, dBu(l), 1, 1, TP, 1, C*N*P,  CP, info="dBu stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.ht1_q_stream,  dut.clockDomain, ht1_q(l), DUT_ht1_q(l),  1, TP, 1, C*P*N,  CP, info="ht1_q stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.ht1_s_stream,  dut.clockDomain, ht1_s(l), DUT_ht1_s(l),  1, TP, 1, C*PT*N,  1, info="ht1_s stream",is_signed = false)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.ht2_q_stream,  dut.clockDomain, ht2_q(l), DUT_ht2_q(l),  1, TP, 1, C*P*N,  CP, info="ht2_q stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.ht2_s_stream,  dut.clockDomain, ht2_s(l), DUT_ht2_s(l),  1, TP, 1, C*P*NT,  1, info="ht2_s stream",is_signed = false)
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_ht1_q.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


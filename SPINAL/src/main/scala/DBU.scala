import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class DBU_Blackbox extends BlackBox {
  val top_name: String = "DBU"
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
    val dB_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dB_stream", verilog_file_path)))
    val dB_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dB_s_stream", verilog_file_path)))
    val u_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("u_stream", verilog_file_path)))
    val u_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("u_s_stream", verilog_file_path)))
    val o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
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

class DBU extends Component {
  val top_name: String = "DBU"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new DBU_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val dB_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dB_stream.config.to_std_config()))
    val dB_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dB_s_stream.config.to_std_config()))
    val u_stream: Axi4Stream = slave(Axi4Stream(black_box.io.u_stream.config.to_std_config()))
    val u_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.u_s_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.dB_stream.connect2std(io.dB_stream)
  black_box.io.dB_s_stream.connect2std(io.dB_s_stream)
  black_box.io.u_stream.connect2std(io.u_stream)
  black_box.io.u_s_stream.connect2std(io.u_s_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.dB_stream)
  Axi4StreamSpecRenamer(io.dB_s_stream)
  Axi4StreamSpecRenamer(io.u_stream)
  Axi4StreamSpecRenamer(io.u_s_stream)
  Axi4StreamSpecRenamer(io.o_stream)
}

object simulate_dBu extends App {
  redirect_std("DBU.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new DBU)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new DBU)
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
      val dB_q = read_multi_int64_files(format_str, L, "/dB_q_layer", T * C*N)
      val dB_s = read_multi_int64_files(format_str, L, "/dB_s_layer", T * CT*N)
      val u_q = read_multi_int64_files(format_str, L, "/u_q_layer", T * C*P)
      val u_s = read_multi_int64_files(format_str, L, "/u_s_layer", T * C*PT)
      val dBu = read_multi_int64_files(format_str, L, "/dBu0_layer", T * C*P*N)

      // dut arrays
      val DUT_dBu  = Array.ofDim[Long](L, T * C*P*N)

      // init ap_ctrl and streams
      init_i_stream(dut.io.dB_stream)
      init_i_stream(dut.io.dB_s_stream)
      init_i_stream(dut.io.u_stream)
      init_i_stream(dut.io.u_s_stream)
      init_o_stream(dut.io.o_stream)
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
          for (l <- L-1 until L) array2stream(dut.io.dB_stream, dut.clockDomain, dB_q(l), 1, 1, TP, 1, C*N,  CP, info="dB stream", verbose=true)
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.dB_s_stream, dut.clockDomain, dB_s(l), 1, 1, TP, 1, CT*N,  1, info="dB_s stream")
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.u_stream, dut.clockDomain, u_q(l), 1, 1, TP, 1, C*P,  CP, info="u stream", verbose=true)
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.u_s_stream, dut.clockDomain, u_s(l), 1, 1, TP, 1, C*PT,  1, info="u_s stream")
        },
        fork {
          for (l <- L-1 until L) stream2array(dut.io.o_stream,  dut.clockDomain, dBu(l), DUT_dBu(l),  1, TP, 1, C*P*N,  CP, info="o stream", verbose=true)
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_dBu.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class DTB_QUANT_Blackbox extends BlackBox {
  val top_name: String = "DTB_QUANT"
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
    val dt_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dt_stream", verilog_file_path)))
    val dt_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dt_s_stream", verilog_file_path)))
    val B_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("B_stream", verilog_file_path)))
    val B_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("B_s_stream", verilog_file_path)))
    val o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
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

class DTB_QUANT extends Component {
  val top_name: String = "DTB_QUANT"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new DTB_QUANT_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val dt_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dt_stream.config.to_std_config()))
    val dt_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dt_s_stream.config.to_std_config()))
    val B_stream: Axi4Stream = slave(Axi4Stream(black_box.io.B_stream.config.to_std_config()))
    val B_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.B_s_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
    val o_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_s_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.dt_stream.connect2std(io.dt_stream)
  black_box.io.dt_s_stream.connect2std(io.dt_s_stream)
  black_box.io.B_stream.connect2std(io.B_stream)
  black_box.io.B_s_stream.connect2std(io.B_s_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  black_box.io.o_s_stream.connect2std(io.o_s_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.dt_stream)
  Axi4StreamSpecRenamer(io.dt_s_stream)
  Axi4StreamSpecRenamer(io.B_stream)
  Axi4StreamSpecRenamer(io.B_s_stream)
  Axi4StreamSpecRenamer(io.o_stream)
  Axi4StreamSpecRenamer(io.o_s_stream)
}

object simulate_dtB_quant extends App {
  redirect_std("DTB_QUANT.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new DTB_QUANT)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new DTB_QUANT)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      //      val L = 32
      val L = 6

      val T_LOAD = 512
      val T = 1
      val TP = 1

      val C = 80
      val CP = G
      val N = 128

      val CT = C / CP
      val NT = N / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val dt_q = read_multi_int64_files(format_str, L, "/dt_softplus_q_layer", T * C)
      val dt_s = read_multi_int64_files(format_str, L, "/dt_softplus_s_layer", T * CT)
      val B_q = read_multi_int64_files(format_str, L, "/B_q_layer", T * N)
      val B_s = read_multi_int64_files(format_str, L, "/B_s_layer", T * NT)
      val dB_q = read_multi_int64_files(format_str, L, "/dB_q_layer", T * C*N)
      val dB_s = read_multi_int64_files(format_str, L, "/dB_s_layer", T * CT*N)
      // dut arrays
      val DUT_dB_Q  = Array.ofDim[Long](L, T * C*N)
      val DUT_dB_S  = Array.ofDim[Long](L, T * CT*N)

      // init ap_ctrl and streams
      init_i_stream(dut.io.dt_stream)
      init_i_stream(dut.io.dt_s_stream)
      init_i_stream(dut.io.B_stream)
      init_i_stream(dut.io.B_s_stream)
      init_o_stream(dut.io.o_stream)
      init_o_stream(dut.io.o_s_stream)
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
          for (l <- 0 until L) array2stream(dut.io.dt_stream, dut.clockDomain, dt_q(l), 1, 1, TP, 1, C,  CP, info="dt stream", verbose=true, WAIT=320)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.dt_s_stream, dut.clockDomain, dt_s(l), 1, 1, TP, 1, CT,  1, info="dt_s stream", WAIT=320)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.B_stream, dut.clockDomain, B_q(l), CT, 1, TP, 1, N,  CP, info="B stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.B_s_stream, dut.clockDomain, B_s(l), CT, 1, TP, 1, NT,  1, info="B_s stream")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_stream,  dut.clockDomain, dB_q(l), DUT_dB_Q(l),  1, TP, 1, C*N,  CP, info="o stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_s_stream,  dut.clockDomain, dB_s(l), DUT_dB_S(l),  1, TP, 1, CT*N, 1, info="o_s stream")
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_dB_Q.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


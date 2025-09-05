import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, RMSNORM_QUANT requires l input, which indicates the order of layer
class UD_Blackbox extends BlackBox {
  val top_name: String = "UD"
  setDefinitionName(top_name)
  // source file
  private val rtl_file_path: String = s"src/main/verilog/$top_name"
  private val verilog_file_path: String = s"$rtl_file_path/all.v"
  // define the IO of verilog entity
  val io = new Bundle {
    // clock and reset
    val ap_clk: Bool = in Bool()
    val ap_rst_n: Bool = in Bool()
    // the l signal
    val l: UInt = in UInt (32 bits)
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    val ap_ctrl: ApChain = slave(ApChain())
    // @formatter:off
    val i_stream: BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("i_stream", verilog_file_path)))
    val s_stream: BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("s_stream", verilog_file_path)))
    val o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
    // @formatter:on
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

class UD extends Component {
  val top_name: String = "UD"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new UD_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val i_stream: Axi4Stream = slave(Axi4Stream(black_box.io.i_stream.config.to_std_config()))
    val s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.s_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  manager.io.l <> black_box.io.l
  black_box.io.i_stream.connect2std(io.i_stream)
  black_box.io.s_stream.connect2std(io.s_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.i_stream)
  Axi4StreamSpecRenamer(io.s_stream)
  Axi4StreamSpecRenamer(io.o_stream)
}

object simulate_uD extends App {
  redirect_std("UD.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new UD)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new UD)
    .doSimUntilVoid { dut =>
      // some hyper parameters
      //      val L = 64
      val L = 6
      val L_BEGIN = L-1
      val L_CLOSE = L

      val T = 1
      val TP = 1
      val C = 80
      val P = 64
      val CP = 8

      val CT = C / CP
      val PT = P / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      val U_Q = read_multi_int64_files(format_str, L, "/u_q_layer", T * C*P)
      val U_S = read_multi_int64_files(format_str, L, "/u_s_layer", T * C*PT)
      val UD  = read_multi_int64_files(format_str, L, "/uD_layer", T * C*P)

      val DUT_UD = Array.ofDim[Long](L, TP * C*P)

      // init ap_ctrl and streams
      init_i_stream(dut.io.i_stream)
      init_i_stream(dut.io.s_stream)
      init_o_stream(dut.io.o_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      init_clock(dut.clockDomain, 10)
      // threads
      Array(
        fork {
          // set scalar parameters
          dut.io.signals.I.L_BEGIN #= L_BEGIN
          dut.io.signals.I.L_CLOSE #= L_CLOSE
          // delay 20 cycles to make sure the signals are set
          dut.clockDomain.waitSampling(20)
          // launch with trigger
          dut.io.signals.I.T #= true
          dut.clockDomain.waitSampling()
          dut.io.signals.I.T #= false
        },
        // @formatter:off
        fork {
          for (l <- L-1 until L) array2stream(dut.io.i_stream,    dut.clockDomain, U_Q(l),                1, 1, TP, TP, C*P, CP,verbose = true)
        },
        fork {
          for (l <- L-1 until L) array2stream(dut.io.s_stream,    dut.clockDomain, U_S(l),                1, 1, TP, TP, C*PT, 1)
        },
        fork {
          for (l <- L-1 until L) stream2array(dut.io.o_stream, dut.clockDomain, UD(l), DUT_UD(l), 1, TP, TP, C*P,CP,  verbose = true, info = s"UD of layer $l", is_signed=false)
        }
        // @formatter:on
      ).foreach(_.join())
      simSuccess()
    }
}


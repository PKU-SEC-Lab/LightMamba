import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, RMSNORM_QUANT requires l input, which indicates the order of layer
class RMSNORM_QUANT_2_Blackbox extends BlackBox {
  val top_name: String = "RMSNORM_QUANT_2"
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
    val x_stream:    BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("x_stream",    verilog_file_path)))
    val xlnq_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("xlnq_stream", verilog_file_path)))
    val xlns_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("xlns_stream", verilog_file_path)))
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

class RMSNORM_QUANT_2 extends Component {
  val top_name: String = "RMSNORM_QUANT_2"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new RMSNORM_QUANT_2_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val x_stream:    Axi4Stream = slave(Axi4Stream(black_box.io.x_stream.config.to_std_config()))
    val xlnq_stream: Axi4Stream = master(Axi4Stream(black_box.io.xlnq_stream.config.to_std_config()))
    val xlns_stream: Axi4Stream = master(Axi4Stream(black_box.io.xlns_stream.config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  manager.io.l <> black_box.io.l
  black_box.io.x_stream.connect2std(io.x_stream)
  black_box.io.xlnq_stream.connect2std(io.xlnq_stream)
  black_box.io.xlns_stream.connect2std(io.xlns_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.x_stream)
  Axi4StreamSpecRenamer(io.xlnq_stream)
  Axi4StreamSpecRenamer(io.xlns_stream)
}

object simulate_rmsnorm_quant_2 extends App {
  redirect_std("RMSNORM_QUANT_2.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new RMSNORM_QUANT_2)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new RMSNORM_QUANT_2)
    .doSimUntilVoid { dut =>
      // some hyper parameters
      //      val L = 64
      val L = 2
      val L_BEGIN = 0
      val L_CLOSE = L

      val T = 1
      val TP = 1
      val C = 5120
      val CP = 8

      val CT = C / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      val x = read_multi_int64_files(format_str, L, "/yz_layer", T * C)
      val xln_q = read_multi_int64_files(format_str, L, "/rms2_q_layer", T * C)
      val xln_s  = read_multi_int64_files(format_str, L, "/rms2_s_layer", T * CT)

      val DUT_xln_q = Array.ofDim[Long](L, T * C)
      val DUT_xln_s = Array.ofDim[Long](L, T * CT)

      // init ap_ctrl and streams
      init_i_stream(dut.io.x_stream)
      init_o_stream(dut.io.xlnq_stream)
      init_o_stream(dut.io.xlns_stream)
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
          for (l <- 0 until L) array2stream(dut.io.x_stream,    dut.clockDomain, x(l),                1, 1, TP, TP, C, CP,verbose = true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.xlnq_stream, dut.clockDomain, xln_q(l), DUT_xln_q(l), 1, T, TP, C, CP, verbose = true, info = s"Q of layer $l", is_signed=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.xlns_stream, dut.clockDomain, xln_s(l), DUT_xln_s(l), 1, TP, TP, CT,1, info = s"S of layer $l", is_signed=false)
        }
        // @formatter:on
      ).foreach(_.join())
      simSuccess()
    }
}


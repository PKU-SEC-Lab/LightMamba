import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, RESIDUAL requires l input, which indicates the order of layer
class RESIDUAL_Blackbox extends BlackBox {
  val top_name: String = "RESIDUAL"
  setDefinitionName(top_name)
  // source file
  private val verilog_file_path: String = s"src/main/verilog/$top_name/all.v"
  // define the IO of verilog entity
  val io = new Bundle {
    // clock and reset
    val ap_clk: Bool = in Bool()
    val ap_rst_n: Bool = in Bool()
    // the l signal
    val l_begin: UInt = in UInt (32 bits)
    val l_close: UInt = in UInt (32 bits)
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    val ap_ctrl: ApChain = slave(ApChain())
    // @formatter:off
    val x_stream:     BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("x_stream",     verilog_file_path)))
    val res_i_stream: BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("res_i_stream", verilog_file_path)))
    val res_o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("res_o_stream", verilog_file_path)))
    val y_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("y_stream",     verilog_file_path)))
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

class RESIDUAL extends Component {
  val top_name: String = "RESIDUAL"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new RESIDUAL_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val x_stream:     Axi4Stream = slave (Axi4Stream(black_box.io.x_stream    .config.to_std_config()))
    val res_i_stream: Axi4Stream = slave (Axi4Stream(black_box.io.res_i_stream.config.to_std_config()))
    val res_o_stream: Axi4Stream = master(Axi4Stream(black_box.io.res_o_stream.config.to_std_config()))
    val y_stream:     Axi4Stream = master(Axi4Stream(black_box.io.y_stream    .config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager(single = true)
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  manager.io.signals.O.L_BEGIN <> black_box.io.l_begin
  manager.io.signals.O.L_CLOSE <> black_box.io.l_close
  black_box.io.x_stream.connect2std(io.x_stream)
  black_box.io.res_i_stream.connect2std(io.res_i_stream)
  black_box.io.res_o_stream.connect2std(io.res_o_stream)
  black_box.io.y_stream.connect2std(io.y_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.x_stream)
  Axi4StreamSpecRenamer(io.res_i_stream)
  Axi4StreamSpecRenamer(io.res_o_stream)
  Axi4StreamSpecRenamer(io.y_stream)
}

object simulate_residual extends App {
  redirect_std("RESIDUAL.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new RESIDUAL)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new RESIDUAL)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8
      val L = 2

      val T = 1
      val TP = 1

      val C = 2560
      val CP = G

      val TT = T / TP
      val CT = C / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      // @formatter:off
      val ref_x = read_multi_int64_files(format_str, L, "/before_rms1_layer", T * C)
      val ref_y = read_multi_int64_files(format_str, L, "/output_layer", T * C)
      val out_proj = read_multi_int64_files(format_str, L, "/out_proj_layer", T * C)

      val DUT_RES_O  = Array.ofDim[Long](L, T*C)
      val DUT_Y      = Array.ofDim[Long](T*C)
      // @formatter:on

      // init ap_ctrl and streams
      init_i_stream(dut.io.x_stream)
      init_i_stream(dut.io.res_i_stream)
      init_o_stream(dut.io.res_o_stream)
      init_o_stream(dut.io.y_stream)

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
          array2stream(dut.io.x_stream,     dut.clockDomain, ref_x(0),  1,  1, T, TP, C, CP,  info="x stream", verbose=true)
          for(l <- 0 until L) {
            stream2array(dut.io.res_o_stream, dut.clockDomain, ref_x(l), DUT_RES_O(l), 1, 1, 1, T*C, TP*CP,  info="res_o stream", verbose=true)
            array2stream(dut.io.res_i_stream, dut.clockDomain, out_proj(l), 1,  1, 1, 1, T*C,  CP, info="res_i stream", verbose=true)
          }
          stream2array(dut.io.y_stream,     dut.clockDomain, ref_y(L-1),  DUT_Y,  1, 1, 1,   T*C, TP*CP,  info="y stream", verbose=true)
        }
        // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)
      simSuccess()
    }
}


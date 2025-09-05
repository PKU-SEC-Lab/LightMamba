import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class SILU_QUANT_Blackbox extends BlackBox {
  val top_name: String = "SILU_QUANT"
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
    val i_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("i_stream", verilog_file_path)))
    val out_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("out_stream", verilog_file_path)))
    val out_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("out_s_stream", verilog_file_path)))
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

class SILU_QUANT extends Component {
  val top_name: String = "SILU_QUANT"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new SILU_QUANT_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val i_stream: Axi4Stream = slave(Axi4Stream(black_box.io.i_stream.config.to_std_config()))
    val out_stream: Axi4Stream = master(Axi4Stream(black_box.io.out_stream.config.to_std_config()))
    val out_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.out_s_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.i_stream.connect2std(io.i_stream)
  black_box.io.out_stream.connect2std(io.out_stream)
  black_box.io.out_s_stream.connect2std(io.out_s_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.i_stream)
  Axi4StreamSpecRenamer(io.out_stream)
  Axi4StreamSpecRenamer(io.out_s_stream)
}

object simulate_silu_quant extends App {
  redirect_std("SILU_QUANT.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new SILU_QUANT)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new SILU_QUANT)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      //      val L = 32
      val L = 2

      val T_LOAD = 512
      val T = 512
      val TP = 1
      val GEMM_TP = T // fully unrolled in GEMM

      val C = 5376+5120
      val CP = G

      val TT = T / GEMM_TP
      val CT = C / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val silu_in = read_multi_int64_files(format_str, L, "/xBCz_layer", T * C)
      val silu_out_q = read_multi_int64_files(format_str, L, "/xBCz_silu_q_layer", T * C)
      val silu_out_s  = read_multi_int64_files(format_str, L, "/xBCz_silu_s_layer", T * CT)
      // dut arrays
      val DUT_SILU_Q  = Array.ofDim[Long](L, TP * C)
      val DUT_SILU_S  = Array.ofDim[Long](L, TP * CT)

      // init ap_ctrl and streams
      init_i_stream(dut.io.i_stream)
      init_o_stream(dut.io.out_stream)
      init_o_stream(dut.io.out_s_stream)
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
          for (l <- 0 until L) array2stream(dut.io.i_stream, dut.clockDomain, silu_in(l), 1, 1, TP, 1, C,  CP, info="i stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.out_stream,  dut.clockDomain, silu_out_q(l), DUT_SILU_Q(l),  1, TP, 1, C,  CP, info="o stream")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.out_s_stream,  dut.clockDomain, silu_out_s(l), DUT_SILU_S(l),  1, TP, 1, CT, 1, info="o_s stream",is_signed = false)
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_SILU_Q.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


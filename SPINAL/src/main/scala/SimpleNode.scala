import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// simple node include: SiLU, Softmax, RMSNorm, CORDIC
class SimpleNodeBlackbox(top_name: String) extends BlackBox {
  // FIXME: this module is for simple ApCtrl + 2*AxiStream component, you must use ap_chain, and set name "i_stream" and "o_stream"
  setDefinitionName(top_name)
  // source file
  private val rtl_file_path: String = s"src/main/verilog/$top_name"
  private val verilog_file_path: String = s"$rtl_file_path/all.v"
  // define the IO of verilog entity
  val io = new Bundle {
    // clock and reset
    val ap_clk: Bool = in Bool()
    val ap_rst_n: Bool = in Bool()
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    val ap_ctrl: ApChain = slave(ApChain())
    val i_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("i_stream", verilog_file_path)))
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

class SimpleNode(top_name: String) extends Component {
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new SimpleNodeBlackbox(top_name)
  val io = new Bundle {
    val ap_ctrl: ApChain = slave(ApChain())
    val i_stream: Axi4Stream = slave(Axi4Stream(black_box.io.i_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
  }
  noIoPrefix()
  // connect interface
  io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.i_stream.connect2std(io.i_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  ApChainRenamer(io.ap_ctrl)
  Axi4StreamSpecRenamer(io.i_stream)
  Axi4StreamSpecRenamer(io.o_stream)
}

object simulate_simple_node extends App {
  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )

  private def simulate_silu = {
    redirect_std("SILU.log")
    SimConfig
      .withConfig(spinalConfig)
      //      .withFstWave
      .allOptimisation
      .withVerilator
      .addSimulatorFlag("--unroll-count 1024")
      .addSimulatorFlag("-j 16")
      .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
      .compile(new SimpleNode("SILU"))
      .doSimUntilVoid { dut =>
        // some hyper parameters
        val L_MLP = 32

        val T = 32
        val CM = 11008
        val TP = 1
        val CMP = 8 // interface parallelism
        //        val data_path = "C:/projects/ClionProjects/LLM/cmake-build-debug/binaries_renamed/"
        val data_path_prefix = "C:/projects/ClionProjects/LLM/cmake-build-debug/binaries_renamed/decoder_"
        val format_str = s"$data_path_prefix%d/%s.bin"
        // arrays
        val i_array = read_multi_int64_files(format_str, L_MLP, "MLP_XG", T * CM)
        val o_array = read_multi_int64_files(format_str, L_MLP, "MLP_XG_SILU", T * CM)
        val dut_array = Array.ofDim[Long](L_MLP, T * CM)

        // init ap_ctrl and streams
        init_ap_ctrl(dut.io.ap_ctrl)
        init_stream(dut.io.i_stream)
        init_stream(dut.io.o_stream)
        // fork clock
        init_clock(dut.clockDomain, 10)
        // threads
        Array(
          // @formatter:off
          fork {
            for (l <- 0 until L_MLP) launch_ap_ctrl(dut.io.ap_ctrl, dut.clockDomain)
          },
          fork {
            for (l <- 0 until L_MLP) array2stream(dut.io.i_stream, dut.clockDomain, i_array(l), 1, 1, T, TP, CM, CMP, verbose = true, info=s"Input layer $l")
          },
          fork {
            for (l <- 0 until L_MLP) stream2array(dut.io.o_stream, dut.clockDomain, o_array(l), dut_array(l),     1, T, TP, CM, CMP)
          }
          // @formatter:on
        ).foreach(_.join())
        simSuccess()
      }
  }


  def simulate_softmax = {
    redirect_std("SOFTMAX.log")

    SimConfig
      .withConfig(spinalConfig)
      .withFstWave
      .allOptimisation
      .withVerilator
      .addSimulatorFlag("--unroll-count 1024")
      .addSimulatorFlag("-j 16")
      .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
      .compile(new SimpleNode("SOFTMAX"))
      .doSimUntilVoid { dut =>
        // some hyper parameters
        val L_MHA = 32
        val H = 32
        val T_LOAD = 128
        val T = 32
        val S_LOAD = 128
        val S = 32
        val TP = 4
        val SP = 8
        // arrays
        val data_path_prefix = "C:/projects/ClionProjects/LLM/cmake-build-debug/binaries_renamed/decoder_"
        val format_str = s"$data_path_prefix%d/%s.bin"
        // @formatter:off
        val i_array = cut_array[Long](read_multi_int64_files(format_str, L_MHA, "R_MASKED",      H * T_LOAD * S_LOAD), H, H, T_LOAD, T, S_LOAD, S)
        val o_array = cut_array[Long](read_multi_int64_files(format_str, L_MHA, "MHA_R_SOFTMAX", H * T_LOAD * S_LOAD), H, H, T_LOAD, T, S_LOAD, S)
        // @formatter:on

        val dut_array = Array.fill[Long](L_MHA * H * T * S)(0)
        // init ap_ctrl and streams
        init_ap_ctrl(dut.io.ap_ctrl)
        init_stream(dut.io.i_stream)
        init_stream(dut.io.o_stream)
        // fork clock
        init_clock(dut.clockDomain, 10)
        // threads
        Array(
          fork {
            for (l <- 0 until L_MHA) launch_ap_ctrl(dut.io.ap_ctrl, dut.clockDomain)
          },
          fork {
            for (l <- 0 until L_MHA) array2stream(dut.io.i_stream, dut.clockDomain, i_array(l), 1, H, T, TP, S, SP, verbose = true)
          },
          fork {
            for (l <- 0 until L_MHA) stream2array(dut.io.o_stream, dut.clockDomain, o_array(l), dut_array, H, T, TP, S, SP)
          }
          // @formatter:on
        ).foreach(_.join())
        simSuccess()
      }
  }

  //  simulate_silu
  simulate_softmax
}


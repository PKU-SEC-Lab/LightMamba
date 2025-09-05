import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, MUX requires l input, which indicates the order of layer
class GEMM_MUX_Blackbox extends BlackBox {
  val top_name: String = "GEMM_MUX"
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
    // @formatter:off
    val xlnq1_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("xlnq1_stream",  verilog_file_path)))
    val xlns1_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("xlns1_stream",  verilog_file_path)))
    val xlnq2_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("xlnq2_stream",  verilog_file_path)))
    val xlns2_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("xlns2_stream",  verilog_file_path)))
    val q_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("q_stream",     verilog_file_path)))
    val s_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("s_stream",     verilog_file_path)))
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

class GEMM_MUX extends Component {
  val top_name: String = "GEMM_MUX"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new GEMM_MUX_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val xlnq1_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.xlnq1_stream.config.to_std_config()))
    val xlns1_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.xlns1_stream.config.to_std_config()))
    val xlnq2_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.xlnq2_stream.config.to_std_config()))
    val xlns2_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.xlns2_stream.config.to_std_config()))
    val q_stream:     Axi4Stream = master(Axi4Stream(black_box.io.q_stream   .config.to_std_config()))
    val s_stream:     Axi4Stream = master(Axi4Stream(black_box.io.s_stream   .config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  // @formatter:off
  black_box.io.xlnq1_stream.connect2std(io.xlnq1_stream)
  black_box.io.xlns1_stream.connect2std(io.xlns1_stream)
  black_box.io.xlnq2_stream.connect2std(io.xlnq2_stream)
  black_box.io.xlns2_stream.connect2std(io.xlns2_stream)
  black_box.io.q_stream   .connect2std(io.q_stream)
  black_box.io.s_stream   .connect2std(io.s_stream)
  // @formatter:on
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.xlnq1_stream)
  Axi4StreamSpecRenamer(io.xlns1_stream)
  Axi4StreamSpecRenamer(io.xlnq2_stream)
  Axi4StreamSpecRenamer(io.xlns2_stream)
  Axi4StreamSpecRenamer(io.q_stream)
  Axi4StreamSpecRenamer(io.s_stream)
}

object simulate_gemm_mux extends App {
  redirect_std("GEMM_MUX.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new GEMM_MUX)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new GEMM_MUX)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      val L = 2

      val T = 1
      val TP = 1

      val CI1 = 2560
      val CI2 = 5120
      val CO1 = 10576
      val CO2 = 2560
      val CP = G
      val CIT1 = CI1 / CP
      val CIT2 = CI2 / CP
      val COT1 = CO1 / CP
      val COT2 = CO2 / CP

      // @formatter:off
      val NUM_X = T*(CI1*COT1+CI2*COT2)
      val NUM_S = NUM_X / G
      // @formatter:on

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      // @formatter:off
      val xln1_q = read_multi_int64_files(format_str, L, "/rms1_q_layer", T * CI1)
      val xln1_s = read_multi_int64_files(format_str, L, "/rms1_s_layer", T * CIT1)
      val xln2_q = read_multi_int64_files(format_str, L, "/rms2_q_layer", T * CI2)
      val xln2_s = read_multi_int64_files(format_str, L, "/rms2_s_layer", T * CIT2)

      val ref_o_q  = Array.ofDim[Long](L, NUM_X)
      val ref_o_s  = Array.ofDim[Long](L, NUM_S)
      for (l <- 0 until L) {
        for (r <- 0 until COT1) {
          for (c <- 0 until CI1) {
            ref_o_q(l)(r*CI1+c) = xln1_q(l)(c)
          }
          for (c <- 0 until CIT1) {
            ref_o_s(l)(r*CIT1+c) = xln1_s(l)(c)
          }
        }
        for (r <- 0 until COT2) {
          for (c <- 0 until CI2) {
            ref_o_q(l)(COT1*CI1+r*CI2+c) = xln2_q(l)(c)
          }
          for (c <- 0 until CIT2) {
            ref_o_s(l)(COT1*CIT1+r*CIT2+c) = xln2_s(l)(c)
          }
        }
      }

      val DUT_o_Q  = Array.ofDim[Long](L, NUM_X)
      val DUT_o_S  = Array.ofDim[Long](L, NUM_S)

      // init ap_ctrl and streams
      init_i_stream(dut.io.xlnq1_stream)
      init_i_stream(dut.io.xlns1_stream)
      init_i_stream(dut.io.xlnq2_stream)
      init_i_stream(dut.io.xlns2_stream)
      init_o_stream(dut.io.q_stream)
      init_o_stream(dut.io.s_stream)
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
            array2stream(dut.io.xlnq1_stream, dut.clockDomain, xln1_q(l), 1, 1, TP, 1, CI1,  CP, info="xln1_q stream", verbose=true)
            array2stream(dut.io.xlnq2_stream, dut.clockDomain, xln2_q(l), 1, 1, TP, 1, CI2,  CP, info="xln2_q stream", verbose=true)
          }
        },
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.xlns1_stream, dut.clockDomain, xln1_s(l), 1, 1, TP, 1, CIT1,  1, info="xln1_s stream")
            array2stream(dut.io.xlns2_stream, dut.clockDomain, xln2_s(l), 1, 1, TP, 1, CIT2,  1, info="xln2_s stream")
          }
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.q_stream,  dut.clockDomain, ref_o_q(l), DUT_o_Q(l),  1, TP, 1, NUM_X,  CP, info="o stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.s_stream,  dut.clockDomain, ref_o_s(l), DUT_o_S(l),  1, TP, 1, NUM_S, 1, info="o_s stream",is_signed = false)
        }
        // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)
      simSuccess()
    }
}


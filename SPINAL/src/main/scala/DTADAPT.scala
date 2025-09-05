import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, RMSNORM_QUANT requires l input, which indicates the order of layer
class DTADAPT_Blackbox extends BlackBox {
  val top_name: String = "DTADAPT"
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
    val o_stream: BlackboxAxis = master (BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
    val o_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_s_stream", verilog_file_path)))
    val o_stream2: BlackboxAxis = master (BlackboxAxis(BlackboxAxisConfig("o_stream2", verilog_file_path)))
    val o_s_stream2: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_s_stream2", verilog_file_path)))
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

class DTADAPT extends Component {
  val top_name: String = "DTADAPT"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new DTADAPT_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val i_stream: Axi4Stream = slave(Axi4Stream(black_box.io.i_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
    val o_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_s_stream.config.to_std_config()))
    val o_stream2: Axi4Stream = master(Axi4Stream(black_box.io.o_stream2.config.to_std_config()))
    val o_s_stream2: Axi4Stream = master(Axi4Stream(black_box.io.o_s_stream2.config.to_std_config()))
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
  black_box.io.o_stream.connect2std(io.o_stream)
  black_box.io.o_s_stream.connect2std(io.o_s_stream)
  black_box.io.o_stream2.connect2std(io.o_stream2)
  black_box.io.o_s_stream2.connect2std(io.o_s_stream2)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.i_stream)
  Axi4StreamSpecRenamer(io.o_stream)
  Axi4StreamSpecRenamer(io.o_s_stream)
  Axi4StreamSpecRenamer(io.o_stream2)
  Axi4StreamSpecRenamer(io.o_s_stream2)
}

object simulate_dtadapt extends App {
  redirect_std("DTADAPT.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new DTADAPT)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new DTADAPT)
    .doSimUntilVoid { dut =>
      // some hyper parameters
      //      val L = 64
      val L = 2
      val L_BEGIN = 0
      val L_CLOSE = L

      val T = 1
      val TP = 1
      val C = 80
      val CP = 8

      val CT = C / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      val DT = read_multi_int64_files(format_str, L, "/dt_layer", T * C)
      val DT_sp_Q = read_multi_int64_files(format_str, L, "/dt_softplus_q_layer", T * C)
      val DT_sp_S  = read_multi_int64_files(format_str, L, "/dt_softplus_s_layer", T * CT)

      val DUT_sp_Q = Array.ofDim[Long](L, T * C)
      val DUT_sp_S = Array.ofDim[Long](L, T * CT)
      val DUT_sp_Q2 = Array.ofDim[Long](L, T * C)
      val DUT_sp_S2 = Array.ofDim[Long](L, T * CT)

      // init ap_ctrl and streams
      init_i_stream(dut.io.i_stream)
      init_o_stream(dut.io.o_stream)
      init_o_stream(dut.io.o_s_stream)
      init_o_stream(dut.io.o_stream2)
      init_o_stream(dut.io.o_s_stream2)
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
          for (l <- 0 until L) array2stream(dut.io.i_stream,    dut.clockDomain, DT(l),                1, 1, T, TP, C, CP, WAIT=320)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_stream,    dut.clockDomain, DT_sp_Q(l), DUT_sp_Q(l), 1, T, TP, C,CP,  verbose = true, info = s"DT_sp_Q of layer $l", is_signed=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_s_stream, dut.clockDomain, DT_sp_S(l), DUT_sp_S(l), 1, T, TP, CT,1,  verbose = false, info = s"DT_sp_S of layer $l", is_signed=false)
        } ,
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_stream2,    dut.clockDomain, DT_sp_Q(l), DUT_sp_Q2(l), 1, T, TP, C,CP,  verbose = true, info = s"DT_sp_Q2 of layer $l", is_signed=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_s_stream2, dut.clockDomain, DT_sp_S(l), DUT_sp_S2(l), 1, T, TP, CT,1,  verbose = false, info = s"DT_sp_S2 of layer $l", is_signed=false)
        }
        // @formatter:on
      ).foreach(_.join())
      simSuccess()
    }
}


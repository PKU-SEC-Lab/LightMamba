import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, MUX requires l input, which indicates the order of layer
class C_BUFFER_Blackbox extends BlackBox {
  val top_name: String = "C_BUFFER"
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
    val i_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("i_stream",  verilog_file_path)))
    val i_s_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("i_s_stream",  verilog_file_path)))
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

class C_BUFFER extends Component {
  val top_name: String = "C_BUFFER"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new C_BUFFER_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val i_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.i_stream.config.to_std_config()))
    val i_s_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.i_s_stream.config.to_std_config()))
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
  black_box.io.i_stream.connect2std(io.i_stream)
  black_box.io.i_s_stream.connect2std(io.i_s_stream)
  black_box.io.q_stream   .connect2std(io.q_stream)
  black_box.io.s_stream   .connect2std(io.s_stream)
  // @formatter:on
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.i_stream)
  Axi4StreamSpecRenamer(io.i_s_stream)
  Axi4StreamSpecRenamer(io.q_stream)
  Axi4StreamSpecRenamer(io.s_stream)
}

object simulate_C_buffer extends App {
  redirect_std("C_BUFFER.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new C_BUFFER)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new C_BUFFER)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      val L = 2

      val T = 1
      val TP = 1

      val C = 5120
      val CP = G
      val N = 128
      val NT = N / CP
      val CT = C / CP
      val R = CT



      // @formatter:on

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      // @formatter:off
      val C_q = read_multi_int64_files(format_str, L, "/C_q_layer", T * N)
      val C_s = read_multi_int64_files(format_str, L, "/C_s_layer", T * NT)

      val ref_o_q  = Array.ofDim[Long](L, T * N * R)
      val ref_o_s  = Array.ofDim[Long](L, T * NT * R)
      for (l <- 0 until L) {
        for (r <- 0 until R) {
          for (n <- 0 until N) {
            ref_o_q(l)(r*N+n) = C_q(l)(n)
          }
          for (n <- 0 until NT) {
            ref_o_s(l)(r*NT+n) = C_s(l)(n)
          }
        }
      }

      val DUT_o_Q  = Array.ofDim[Long](L, T * N * R)
      val DUT_o_S  = Array.ofDim[Long](L, T * NT * R)


      // init ap_ctrl and streams
      init_i_stream(dut.io.i_stream)
      init_i_stream(dut.io.i_s_stream)
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
          for (l <- 0 until L) array2stream(dut.io.i_stream, dut.clockDomain, C_q(l), 1, 1, TP, 1, N,  CP, info="C stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.i_s_stream, dut.clockDomain, C_s(l), 1, 1, TP, 1, NT,  1, info="C_s stream")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.q_stream,  dut.clockDomain, ref_o_q(l), DUT_o_Q(l),  1, TP, 1, N*R,  CP, info="o stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.s_stream,  dut.clockDomain, ref_o_s(l), DUT_o_S(l),  1, TP, 1, NT*R, 1, info="o_s stream",is_signed = false)
        }
        // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)
      simSuccess()
    }
}


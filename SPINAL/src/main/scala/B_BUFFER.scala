import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps
/**
 * \brief BlackBox wrapper for the Verilog B_BUFFER module
 * \details This module defines the external Verilog module interface and maps its I/O,
 * including AXI-Stream interfaces and AP control. It ensures proper clock domain mapping
 * and renaming compatibility for integration in SpinalHDL.
 */

// FIXME: compared with utils.SimpleNode, MUX requires l input, which indicates the order of layer
class B_BUFFER_Blackbox extends BlackBox {

    /** Top-level Verilog module name */
  val top_name: String = "B_BUFFER"
  setDefinitionName(top_name)
  // source file
  /** Verilog source file path */
  private val verilog_file_path: String = s"src/main/verilog/$top_name/all.v"
  // define the IO of verilog entity
  /** I/O definition matching the Verilog blackbox interface */
  val io = new Bundle {
    // clock and reset
     /** Clock input */
    val ap_clk: Bool = in Bool()
     /** Active-low reset input */
    val ap_rst_n: Bool = in Bool()
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    /** AP control slave interface */
    val ap_ctrl: ApChain = slave(ApChain())
    // @formatter:off
     /** Input AXI-Stream interface for B stream */
    val i_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("i_stream",  verilog_file_path)))
    val i_s_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("i_s_stream",  verilog_file_path)))
    val q_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("q_stream",     verilog_file_path)))
    val s_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("s_stream",     verilog_file_path)))
    // @formatter:on
  }
  // no io prefix, this is essential for name matching
   /** Disable automatic I/O prefixing for Verilog name matching */
  noIoPrefix()
  // FIXME: here, renaming is for blackbox name matching, modify the name to match the verilog interface
   /** Apply naming conventions for AP control interface */
  ApChainRenamer(io.ap_ctrl)

  /** Clock and reset mapping (active low reset) */
  mapClockDomain(clock = io.ap_clk, reset = io.ap_rst_n, resetActiveLevel = LOW)
  // /** Add RTL path for synthesis/simulation */
  addRTLPath(verilog_file_path)
}
/**
 * \brief Wrapper component for the B_BUFFER blackbox
 * \details This component wraps the Verilog B_BUFFER blackbox and connects it to AXI4Stream
 * interfaces and a Manager control module.
 */
class B_BUFFER extends Component {
  val top_name: String = "B_BUFFER"
  setDefinitionName(top_name + "_wrapper")

  /** Instance of the Verilog BlackBox */
  private val black_box = new B_BUFFER_Blackbox

   /** External I/O bundle of the wrapper module */
  val io = new Bundle {
     /** Manager signal daisy chain interface */
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
     /** AXI4Stream input interface (B stream) */
    // @formatter:off
    val i_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.i_stream.config.to_std_config()))

    /** AXI4Stream input interface (B_s stream) */
    val i_s_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.i_s_stream.config.to_std_config()))

    /** AXI4Stream output interface (Q stream) */
    val q_stream:     Axi4Stream = master(Axi4Stream(black_box.io.q_stream   .config.to_std_config()))

    /** AXI4Stream output interface (S stream) */
    val s_stream:     Axi4Stream = master(Axi4Stream(black_box.io.s_stream   .config.to_std_config()))
    // @formatter:on
  }

   /** Disable I/O prefixing */
  noIoPrefix()
  // create manager
    /** Manager module instance */
  val manager = new Manager

    /** Connect daisy-chained manager signals */
  manager.io.signals <> io.signals
  // connect interface
   /** Connect AP control interface */
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  // @formatter:off

  /** Connect input/output AXI streams */
  black_box.io.i_stream.connect2std(io.i_stream)
  black_box.io.i_s_stream.connect2std(io.i_s_stream)
  black_box.io.q_stream   .connect2std(io.q_stream)
  black_box.io.s_stream   .connect2std(io.s_stream)
  // @formatter:on
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado

  /** Rename AXI4 stream interfaces for Vivado compatibility */

  Axi4StreamSpecRenamer(io.i_stream)
  Axi4StreamSpecRenamer(io.i_s_stream)
  Axi4StreamSpecRenamer(io.q_stream)
  Axi4StreamSpecRenamer(io.s_stream)
}

/**
 * \brief Simulation testbench for B_BUFFER component
 * \details Initializes the testbench environment, loads input data from disk, launches
 * parallel threads to feed and capture data streams, and verifies correctness.
 */

object simulate_B_buffer extends App {
   /** Redirect simulation output to log file */
  redirect_std("B_BUFFER.log")

  // spinal config
  /** SpinalHDL configuration for synchronous active-low reset */
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
   /** Generate Verilog from SpinalHDL model */
  spinalConfig.generateVerilog(new B_BUFFER)

  /** Run simulation using Verilator */
  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new B_BUFFER)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      val L = 2

      val T = 1
      val TP = 1

      val C = 80
      val CP = G
      val N = 128
      val NT = N / CP
      val CT = C / CP
      val R = CT



      // @formatter:on
/** Load input data from binary files */
      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      // @formatter:off
      val B_q = read_multi_int64_files(format_str, L, "/B_q_layer", T * N)
      val B_s = read_multi_int64_files(format_str, L, "/B_s_layer", T * NT)
   /** Prepare reference output arrays */
      val ref_o_q  = Array.ofDim[Long](L, T * N * R)
      val ref_o_s  = Array.ofDim[Long](L, T * NT * R)
      for (l <- 0 until L) {
        for (r <- 0 until R) {
          for (n <- 0 until N) {
            ref_o_q(l)(r*N+n) = B_q(l)(n)
          }
          for (n <- 0 until NT) {
            ref_o_s(l)(r*NT+n) = B_s(l)(n)
          }
        }
      }
 /** Allocate DUT output buffer */
      val DUT_o_Q  = Array.ofDim[Long](L, T * N * R)
      val DUT_o_S  = Array.ofDim[Long](L, T * NT * R)


      // init ap_ctrl and streams
       // Initialization
      init_i_stream(dut.io.i_stream)
      init_i_stream(dut.io.i_s_stream)
      init_o_stream(dut.io.q_stream)
      init_o_stream(dut.io.s_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      // Start clock
      init_clock(dut.clockDomain, 10)
      // threads
       // Launch simulation threads
      Array(
        fork {
          // Trigger layer processing
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
          // Feed B stream
          for (l <- 0 until 1) array2stream(dut.io.i_stream, dut.clockDomain, B_q(l), 1, 1, TP, 1, N,  CP, info="B stream", verbose=true)
        },
        fork {
          // Feed B_s stream
          for (l <- 0 until 1) array2stream(dut.io.i_s_stream, dut.clockDomain, B_s(l), 1, 1, TP, 1, NT,  1, info="B_s stream")
        },
        fork {
          // Capture Q stream
          for (l <- 0 until L) stream2array(dut.io.q_stream,  dut.clockDomain, ref_o_q(l), DUT_o_Q(l),  1, TP, 1, N*R,  CP, info="o stream", verbose=true)
        },
        fork {
           // Capture S stream
          for (l <- 0 until L) stream2array(dut.io.s_stream,  dut.clockDomain, ref_o_s(l), DUT_o_S(l),  1, TP, 1, NT*R, 1, info="o_s stream",is_signed = false)
        }
        // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)
      simSuccess()
    }
}


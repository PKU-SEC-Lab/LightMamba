/** @file YZ.scala
 *  @brief SpinalHDL implementation of the YZ module with a blackbox and simulation setup.
 *  
 *  This file defines a SpinalHDL blackbox (`YZ_Blackbox`) for interfacing with a Verilog module, 
 *  a wrapper component (`YZ`), and a simulation configuration (`simulate_yz`) for testing the design.
 *  The module handles AXI4-Stream interfaces for data processing and integrates with a control interface.
 */
import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

/** @class YZ_Blackbox
 *  @brief Blackbox definition for the YZ Verilog module.
 *  
 *  This class defines a SpinalHDL blackbox that interfaces with a Verilog module named "YZ". 
 *  It specifies the input/output ports and maps them to the Verilog module's interface.
 */
// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class YZ_Blackbox extends BlackBox {

  /** @brief Name of the Verilog module. */
  val top_name: String = "YZ"

  setDefinitionName(top_name)

  /** @brief Path to the Verilog source file. */
  private val verilog_file_path: String = s"src/main/verilog/$top_name/all.v"

    /** @brief Input/output bundle for the blackbox.
   *  
   *  Defines the clock, reset, control, and AXI4-Stream interfaces for the Verilog module.
   */

  // define the IO of verilog entity
  val io = new Bundle {
    // clock and reset
    val ap_clk: Bool = in Bool()
    /** @brief Active-low reset input signal. */
    val ap_rst_n: Bool = in Bool()
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    /** @brief Control interface using ApChain protocol.
     *  @note Must match the Verilog interface name (e.g., i_stream_TDATA).
     */
    val ap_ctrl: ApChain = slave(ApChain())

     /** @brief Input AXI4-Stream for y stream data. */
    val y_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("y_stream", verilog_file_path)))
    val y_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("y_s_stream", verilog_file_path)))

    /** @brief Input AXI4-Stream for z stream data. */
    val z_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("z_stream", verilog_file_path)))
    val z_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("z_s_stream", verilog_file_path)))

     /** @brief Output AXI4-Stream for o_stream data. */
    val o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
  }
  /** @brief Removes the "io_" prefix from signal names to match Verilog interface. */
  noIoPrefix()

  /** @brief Renames ApChain signals to match Verilog interface naming conventions.
   *  @note Required for blackbox name matching.
   */
  ApChainRenamer(io.ap_ctrl)

    /** @brief Maps the clock and reset signals to the module's clock domain.
   *  @param clock The clock signal (ap_clk).
   *  @param reset The active-low reset signal (ap_rst_n).
   */
  mapClockDomain(clock = io.ap_clk, reset = io.ap_rst_n, resetActiveLevel = LOW)

    /** @brief Adds the Verilog source file to the blackbox for RTL generation. */
  addRTLPath(verilog_file_path)
}

/** @class YZ
 *  @brief Wrapper component for the YZ_Blackbox.
 *  
 *  This component wraps the `YZ_Blackbox` and provides standard AXI4-Stream interfaces 
 *  and a DaisyChain control interface for integration with other SpinalHDL components.
 */
class YZ extends Component {

  /** @brief Name of the top-level module. */
  val top_name: String = "YZ"
  setDefinitionName(top_name + "_wrapper")

  /** @brief Instance of the YZ_Blackbox module. */
  private val black_box = new YZ_Blackbox

    /** @brief Input/output bundle for the wrapper component.
   *  
   *  Defines the DaisyChain control signals and AXI4-Stream interfaces.
   */
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val y_stream: Axi4Stream = slave(Axi4Stream(black_box.io.y_stream.config.to_std_config()))
    val y_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.y_s_stream.config.to_std_config()))
    val z_stream: Axi4Stream = slave(Axi4Stream(black_box.io.z_stream.config.to_std_config()))
    val z_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.z_s_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
  }
  noIoPrefix()

   /** @brief Instantiates a manager for handling control signals. */
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.y_stream.connect2std(io.y_stream)
  black_box.io.y_s_stream.connect2std(io.y_s_stream)
  black_box.io.z_stream.connect2std(io.z_stream)
  black_box.io.z_s_stream.connect2std(io.z_s_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.y_stream)
  Axi4StreamSpecRenamer(io.y_s_stream)
  Axi4StreamSpecRenamer(io.z_stream)
  Axi4StreamSpecRenamer(io.z_s_stream)
  Axi4StreamSpecRenamer(io.o_stream)
}

/** @object simulate_yz
 *  @brief Simulation setup for the YZ module.
 *  
 *  Configures and runs a simulation of the YZ module using SpinalHDL's simulation framework.
 *  Reads input data from binary files and writes output to arrays for verification.
 */
object simulate_yz extends App {

   /** @brief Redirects standard output to a log file. */
  redirect_std("YZ.log")

    /** @brief SpinalHDL configuration for the simulation.
   *  
   *  Sets up clock domain configuration with synchronous reset and active-low reset.
   */
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
   /** @brief Generates Verilog code for the YZ module. */
  spinalConfig.generateVerilog(new YZ)

  /** @brief Configures and runs the simulation using Verilator.
   *  
   *  Enables waveform generation, optimizations, and specific Verilator flags.
   */
  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new YZ)
    .doSimUntilVoid { dut =>
    
    
    // Hyperparameters for the simulation
      val G = 8

      //      val L = 32
      val L = 6

      val T_LOAD = 512
      val T = 1
      val TP = 1

      val C = 80
      val N = 128
      val P = 64
      val CP = G


      val CT = C / CP
      val NT = N / CP
      val PT = P / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val y_q = read_multi_int64_files(format_str, L, "/y_q_layer", T * C*P)
      val y_s = read_multi_int64_files(format_str, L, "/y_s_layer", T * C*PT)
      val z_q = read_multi_int64_files(format_str, L, "/z_silu_q_layer", T * C*P)
      val z_s = read_multi_int64_files(format_str, L, "/z_silu_s_layer", T * C*PT)
      val yz = read_multi_int64_files(format_str, L, "/yz_layer", T * C*P)

      // dut arrays
      val DUT_yz  = Array.ofDim[Long](L, T * C*P)

      // init ap_ctrl and streams
      init_i_stream(dut.io.y_stream)
      init_i_stream(dut.io.y_s_stream)
      init_i_stream(dut.io.z_stream)
      init_i_stream(dut.io.z_s_stream)
      init_o_stream(dut.io.o_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      init_clock(dut.clockDomain, 10)
      // threads
       // Fork parallel threads for simulation
      Array(
        fork {
          /** @brief Sets layer begin and close signals for simulation. */
          dut.io.signals.I.L_BEGIN #= L-1
          dut.io.signals.I.L_CLOSE #= L
          // delay 20 cycles to make sure the signals are set
          dut.clockDomain.waitSampling(20)
          /** @brief Triggers the simulation. */
          dut.io.signals.I.T #= true
          dut.clockDomain.waitSampling()
          dut.io.signals.I.T #= false
        },
        // @formatter:off
        fork {
           /** @brief Streams y_q data to y_stream input. */
          for (l <- L-1 until L) array2stream(dut.io.y_stream, dut.clockDomain, y_q(l), 1, 1, TP, 1, C*P,  CP, info="y stream", verbose=true)
        },
        fork {
          /** @brief Streams y_s data to y_s_stream input. */
          for (l <- L-1 until L) array2stream(dut.io.y_s_stream, dut.clockDomain, y_s(l), 1, 1, TP, 1, C*PT,  1, info="y_s stream")
        },
        fork {
          /** @brief Streams z_q data to z_stream input. */
          for (l <- L-1 until L) array2stream(dut.io.z_stream, dut.clockDomain, z_q(l), 1, 1, TP, 1, C*P,  CP, info="z stream", verbose=true)
        },
        fork {
          /** @brief Streams z_s data to z_s_stream input. */
          for (l <- L-1 until L) array2stream(dut.io.z_s_stream, dut.clockDomain, z_s(l), 1, 1, TP, 1, C*PT,  1, info="z_s stream")
        },
        fork {
          /** @brief Captures o_stream output to DUT_yz array. */
          for (l <- L-1 until L) stream2array(dut.io.o_stream,  dut.clockDomain, yz(l), DUT_yz(l),  1, TP, 1, C*P,  CP, info="o stream", verbose=true)
        }
        // @formatter:on
      ).foreach(_.join())

      /** @brief Calculates the maximum value in DUT_yz array for verification. */
      val max_XM_S = DUT_yz.flatten.max
      println(s"max_XM_S = $max_XM_S")

 /** @brief Signals successful completion of the simulation. */
      simSuccess()
    }
}


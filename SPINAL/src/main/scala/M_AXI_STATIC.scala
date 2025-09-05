import spinal.core.sim._
import spinal.core._
import spinal.lib.bus.amba4.axi.sim.{AxiMemorySim, AxiMemorySimConfig}
import spinal.lib.bus.amba4.axi._
import spinal.lib._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream
import utils._

import scala.language.postfixOps
import scala.reflect.ClassTag

// Blackbox class for the HLS module
class M_AXI_STATIC_Blackbox extends BlackBox {
  val top_name: String = "M_AXI_STATIC"
  setDefinitionName(top_name)
  // Source file path
  private val verilog_file_path: String = s"src/main/verilog/$top_name/all.v"
  // Define the IO of the Verilog entity
  // @formatter:off
  val io = new Bundle {
    // Clock and reset
    val ap_clk:   Bool = in Bool()
    val ap_rst_n: Bool = in Bool()
    // Function arguments
    val l_begin:  UInt = in UInt (32 bits)
    val l_close:  UInt = in UInt (32 bits)
    val memory_x: UInt = in UInt (64 bits)
    val memory_w: UInt = in UInt (64 bits)
    val memory_y: UInt = in UInt (64 bits)
    val memory_c: UInt = in UInt (64 bits)
    val memory_h: UInt = in UInt (64 bits)
    // Control interface
    val ap_ctrl: ApChain = slave(ApChain())
    val blackbox_axi:   BlackboxAxi  = master(BlackboxAxi (BlackboxAxiConfig (              verilog_file_path)))
    val x_stream:       BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("x_stream",   verilog_file_path)))
    val mem_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("mem_stream",  verilog_file_path)))
    val conv_stream:    BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("conv_stream", verilog_file_path)))
    val conv2_stream:   BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("conv2_stream", verilog_file_path)))
    val ht_stream:      BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht_stream", verilog_file_path)))
    val ht2_stream:     BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht2_stream", verilog_file_path)))
    val y_stream:       BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("y_stream",   verilog_file_path)))

    // @formatter:on
  }
  // No IO prefix
  noIoPrefix()
  // Rename control interface for proper matching
  ApChainRenamer(io.ap_ctrl)
  BlackboxAxiRenamer(io.blackbox_axi)
  // Map clock domain, reset is active low
  mapClockDomain(clock = io.ap_clk, reset = io.ap_rst_n, resetActiveLevel = LOW)
  // Add RTL code
  addRTLPath(verilog_file_path)
}

// Wrapper component for the blackbox
class M_AXI_STATIC extends Component {
  val top_name: String = "M_AXI_STATIC"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new M_AXI_STATIC_Blackbox()
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val m_axi:      Axi4       = master(Axi4      (black_box.io.blackbox_axi.config.to_std_config()))
    val x_stream:   Axi4Stream = master(Axi4Stream(black_box.io.x_stream    .config.to_std_config()))
    val mem_stream:  Axi4Stream = master(Axi4Stream(black_box.io.mem_stream   .config.to_std_config()))
    val conv_stream: Axi4Stream = master(Axi4Stream(black_box.io.conv_stream  .config.to_std_config()))
    val conv2_stream: Axi4Stream = slave(Axi4Stream(black_box.io.conv2_stream  .config.to_std_config()))
    val ht_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht_stream  .config.to_std_config()))
    val ht2_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht2_stream  .config.to_std_config()))
    val y_stream:   Axi4Stream = slave (Axi4Stream(black_box.io.y_stream    .config.to_std_config()))

    // @formatter:on
    val idle: Bool = out Bool()
  }
  noIoPrefix()
  // Create manager for control signals
  val manager = new Manager(single = true) // itself will do multiple layers
  manager.io.signals <> io.signals
  io.idle := black_box.io.ap_ctrl.ap_idle
  // Connect control interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  manager.io.signals.O.L_BEGIN <> black_box.io.l_begin
  manager.io.signals.O.L_CLOSE <> black_box.io.l_close
  manager.io.signals.O.MEMORY_X <> black_box.io.memory_x
  manager.io.signals.O.MEMORY_W <> black_box.io.memory_w
  manager.io.signals.O.MEMORY_Y <> black_box.io.memory_y
  manager.io.signals.O.MEMORY_C <> black_box.io.memory_c
  manager.io.signals.O.MEMORY_H <> black_box.io.memory_h
  // Connect AXI interface
  black_box.io.blackbox_axi.connect2std(io.m_axi)
  // Connect AXI streams
  black_box.io.x_stream.connect2std(io.x_stream)
  black_box.io.y_stream.connect2std(io.y_stream)
  black_box.io.mem_stream.connect2std(io.mem_stream)
  black_box.io.conv_stream.connect2std(io.conv_stream)
  black_box.io.conv2_stream.connect2std(io.conv2_stream)
  black_box.io.ht_stream.connect2std(io.ht_stream)
  black_box.io.ht2_stream.connect2std(io.ht2_stream)
  // Rename AXI stream signals for proper matching
  Axi4StreamSpecRenamer(io.x_stream)
  Axi4StreamSpecRenamer(io.y_stream)
  Axi4StreamSpecRenamer(io.mem_stream)
  Axi4StreamSpecRenamer(io.conv_stream)
  Axi4StreamSpecRenamer(io.conv2_stream)
  Axi4StreamSpecRenamer(io.ht_stream)
  Axi4StreamSpecRenamer(io.ht2_stream)
  Axi4SpecRenamer(io.m_axi)
}

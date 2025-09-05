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
class M_AXI_FLOW_Blackbox extends BlackBox {
  val top_name: String = "M_AXI_FLOW"
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
    // Control interface
    val ap_ctrl: ApChain = slave(ApChain())
    val mem_stream:      BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("mem_stream",  verilog_file_path)))
    val conv_stream:     BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("conv_stream", verilog_file_path)))
    val conv2_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("conv2_stream", verilog_file_path)))
    val ht_stream:     BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht_stream", verilog_file_path)))
    val ht2_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht2_stream", verilog_file_path)))
    val wq_stream:      BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("wq_stream",  verilog_file_path)))
    val ws1_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ws1_stream", verilog_file_path)))
    val ws2_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ws2_stream", verilog_file_path)))
    val cq_stream:      BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("cq_stream",  verilog_file_path)))
    val cs_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("cs_stream", verilog_file_path)))
    val cq2_stream:      BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("cq2_stream",  verilog_file_path)))
    val cs2_stream:     BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("cs2_stream", verilog_file_path)))
    val hq_stream:      BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("hq_stream",  verilog_file_path)))
    val hs_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("hs_stream", verilog_file_path)))
    val hq2_stream:      BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("hq2_stream",  verilog_file_path)))
    val hs2_stream:     BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("hs2_stream", verilog_file_path)))
    // @formatter:on
  }
  // No IO prefix
  noIoPrefix()
  // Rename control interface for proper matching
  ApChainRenamer(io.ap_ctrl)
  // Map clock domain, reset is active low
  mapClockDomain(clock = io.ap_clk, reset = io.ap_rst_n, resetActiveLevel = LOW)
  // Add RTL code
  addRTLPath(verilog_file_path)
}

// Wrapper component for the blackbox
class M_AXI_FLOW extends Component {
  val top_name: String = "M_AXI_FLOW"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new M_AXI_FLOW_Blackbox()
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val mem_stream:  Axi4Stream = slave(Axi4Stream(black_box.io.mem_stream   .config.to_std_config()))
    val conv_stream: Axi4Stream = slave(Axi4Stream(black_box.io.conv_stream  .config.to_std_config()))
    val conv2_stream: Axi4Stream = master(Axi4Stream(black_box.io.conv2_stream  .config.to_std_config()))
    val ht_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht_stream  .config.to_std_config()))
    val ht2_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht2_stream  .config.to_std_config()))
    val wq_stream:  Axi4Stream = master(Axi4Stream(black_box.io.wq_stream   .config.to_std_config()))
    val ws1_stream: Axi4Stream = master(Axi4Stream(black_box.io.ws1_stream  .config.to_std_config()))
    val ws2_stream: Axi4Stream = master(Axi4Stream(black_box.io.ws2_stream  .config.to_std_config()))
    val cq_stream:  Axi4Stream = master(Axi4Stream(black_box.io.cq_stream   .config.to_std_config()))
    val cs_stream: Axi4Stream = master(Axi4Stream(black_box.io.cs_stream  .config.to_std_config()))
    val cq2_stream:  Axi4Stream = slave(Axi4Stream(black_box.io.cq2_stream   .config.to_std_config()))
    val cs2_stream: Axi4Stream = slave(Axi4Stream(black_box.io.cs2_stream  .config.to_std_config()))
    val hq_stream:  Axi4Stream = master(Axi4Stream(black_box.io.hq_stream   .config.to_std_config()))
    val hs_stream: Axi4Stream = master(Axi4Stream(black_box.io.hs_stream  .config.to_std_config()))
    val hq2_stream:  Axi4Stream = slave(Axi4Stream(black_box.io.hq2_stream   .config.to_std_config()))
    val hs2_stream: Axi4Stream = slave(Axi4Stream(black_box.io.hs2_stream  .config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // Create manager for control signals
  val manager = new Manager(single = true) // itself will do multiple layers
  manager.io.signals <> io.signals
  // Connect control interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  manager.io.signals.O.L_BEGIN <> black_box.io.l_begin
  manager.io.signals.O.L_CLOSE <> black_box.io.l_close
  // Connect AXI streams
  black_box.io.mem_stream.connect2std(io.mem_stream)
  black_box.io.conv_stream.connect2std(io.conv_stream)
  black_box.io.conv2_stream.connect2std(io.conv2_stream)
  black_box.io.ht_stream.connect2std(io.ht_stream)
  black_box.io.ht2_stream.connect2std(io.ht2_stream)
  black_box.io.wq_stream.connect2std(io.wq_stream)
  black_box.io.ws1_stream.connect2std(io.ws1_stream)
  black_box.io.ws2_stream.connect2std(io.ws2_stream)
  black_box.io.cq_stream.connect2std(io.cq_stream)
  black_box.io.cs_stream.connect2std(io.cs_stream)
  black_box.io.cq2_stream.connect2std(io.cq2_stream)
  black_box.io.cs2_stream.connect2std(io.cs2_stream)
  black_box.io.hq_stream.connect2std(io.hq_stream)
  black_box.io.hs_stream.connect2std(io.hs_stream)
  black_box.io.hq2_stream.connect2std(io.hq2_stream)
  black_box.io.hs2_stream.connect2std(io.hs2_stream)
  // Rename AXI stream signals for proper matching
  Axi4StreamSpecRenamer(io.mem_stream)
  Axi4StreamSpecRenamer(io.conv_stream)
  Axi4StreamSpecRenamer(io.conv2_stream)
  Axi4StreamSpecRenamer(io.ht_stream)
  Axi4StreamSpecRenamer(io.ht2_stream)
  Axi4StreamSpecRenamer(io.wq_stream)
  Axi4StreamSpecRenamer(io.ws1_stream)
  Axi4StreamSpecRenamer(io.ws2_stream)
  Axi4StreamSpecRenamer(io.cq_stream)
  Axi4StreamSpecRenamer(io.cs_stream)
  Axi4StreamSpecRenamer(io.cq2_stream)
  Axi4StreamSpecRenamer(io.cs2_stream)
  Axi4StreamSpecRenamer(io.hq_stream)
  Axi4StreamSpecRenamer(io.hs_stream)
  Axi4StreamSpecRenamer(io.hq2_stream)
  Axi4StreamSpecRenamer(io.hs2_stream)
}
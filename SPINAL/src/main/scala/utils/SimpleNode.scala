package utils

import spinal.core._
import spinal.lib._
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
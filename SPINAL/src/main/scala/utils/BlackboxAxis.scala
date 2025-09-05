package utils

import spinal.core._
import spinal.lib.IMasterSlave
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream
import spinal.lib.bus.amba4.axis._

import scala.language.postfixOps

case class BlackboxAxisConfig(
                               prefix: String,
                               dw: Int = 32,
                               useLast: Boolean = false
                             ) {
  def to_std_config(): Axi4StreamConfig = {
    Axi4StreamConfig(
      dataWidth = dw / 8,
      useLast = useLast
    )
  }
}

object BlackboxAxisConfig {
  def apply(prefix: String, verilog_file_path: String): BlackboxAxisConfig = {
    // try to read the source file
    val source = scala.io.Source.fromFile(verilog_file_path)
    val lines = try source.mkString finally source.close()
    // need to use regex to get "output  [511:0] cos_stream_TDATA;" with given prefix "cos_stream"
    // select from "input" and "output", followed by [dataWidth-1:0], then the prefix, then "TDATA"
    val pattern = s"(input|output)\\s+\\[(\\d+):0\\]\\s+${prefix}_TDATA".r
    // there should be only one match
    val m = pattern.findFirstMatchIn(lines).get
    val dataWidth = m.group(2).toInt + 1
    // try to find TLAST, if no corresponding port, then useLast = false
    val useLast = lines.contains(s"${prefix}_TLAST")
    BlackboxAxisConfig(prefix, dataWidth, useLast)
  }
}

case class BlackboxAxis(config: BlackboxAxisConfig) extends Bundle with IMasterSlave {
  // default slave axis
  val TDATA: Bits = Bits(config.dw bits)
  val TVALID: Bool = Bool()
  val TREADY: Bool = Bool()
  val TLAST: Bool = (config.useLast) generate Bool()

  override def asMaster(): Unit = {
    out(TDATA)
    out(TVALID)
    in(TREADY)
    if (config.useLast) out(TLAST)
  }

  override def asSlave(): Unit = {
    in(TDATA)
    in(TVALID)
    out(TREADY)
    if (config.useLast) in(TLAST)
  }

  def connect2std(axis: Axi4Stream): Unit = {
    axis.data <> TDATA
    axis.valid <> TVALID
    axis.ready <> TREADY
    config.useLast generate {
      axis.last <> TLAST
    }
  }

}

object Axi4StreamSpecRenamer {
  // this renamer is used for Vivado flow compatibility
  def apply(that: Axi4Stream): Unit = {
    def doIt(): Unit = {
      that.flatten.foreach(bt => {
        bt.setName(bt.getName().replace("payload_data", "TDATA"))
        bt.setName(bt.getName().replace("valid", "TVALID"))
        bt.setName(bt.getName().replace("ready", "TREADY"))
        bt.setName(bt.getName().replace("last", "TLAST"))
        bt.setName(bt.getName().replace("keep", "TKEEP"))
        bt.setName(bt.getName().replace("strb", "TSTRB"))
        bt.setName(bt.getName().replace("id", "TID"))
        bt.setName(bt.getName().replace("dest", "TDEST"))
      })
    }

    if (Component.current == that.component)
      that.component.addPrePopTask(() => {
        doIt()
      })
    else
      doIt()
  }
}

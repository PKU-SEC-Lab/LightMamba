package utils

import spinal.core._
import spinal.lib.IMasterSlave
import spinal.lib.bus.amba4.axi._
import spinal.lib.bus.amba4.axilite._

import scala.language.postfixOps

case class BlackboxAxiLiteConfig(
                                  C_S_AXI_CONTROL_DATA_WIDTH: Int = 32,
                                  C_S_AXI_CONTROL_ADDR_WIDTH: Int = 32
                                ) {
  val C_S_AXI_CONTROL_WSTRB_WIDTH: Int = C_S_AXI_CONTROL_DATA_WIDTH / 8

  def to_std_config(): AxiLite4Config = {
    AxiLite4Config(
      addressWidth = C_S_AXI_CONTROL_ADDR_WIDTH,
      dataWidth = C_S_AXI_CONTROL_DATA_WIDTH
    )
  }
}

object BlackboxAxiLiteConfig {
  val default_map: Map[String, Int] = Map(
    "C_S_AXI_CONTROL_DATA_WIDTH" -> 32,
    "C_S_AXI_CONTROL_ADDR_WIDTH" -> 32
  )

  def apply(field_value_map: Map[String, Int]): BlackboxAxiLiteConfig = {
    BlackboxAxiLiteConfig(
      C_S_AXI_CONTROL_DATA_WIDTH = field_value_map("C_S_AXI_CONTROL_DATA_WIDTH"),
      C_S_AXI_CONTROL_ADDR_WIDTH = field_value_map("C_S_AXI_CONTROL_ADDR_WIDTH")
    )
  }

  def apply(verilog_file_path: String): BlackboxAxiLiteConfig = {
    var field_value_map: Map[String, Int] = Map()
    // try to read the source file
    val source = scala.io.Source.fromFile(verilog_file_path)
    val lines = try source.mkString finally source.close()
    val pattern = "parameter\\s+(\\w+)\\s*=\\s*(\\d+)".r
    for (m <- pattern.findAllMatchIn(lines)) {
      // check if the field is in the default_map
      val field = m.group(1)
      val value = m.group(2).toInt
      if (default_map.contains(field)) {
        field_value_map += (field -> value)
      }
    }
    BlackboxAxiLiteConfig(field_value_map)
  }
}

case class BlackboxAxiLite(config: BlackboxAxiLiteConfig) extends Bundle with IMasterSlave {
  // default slave axilite

  // control signals
  val s_axi_control_AWVALID: Bool = in Bool()
  val s_axi_control_AWREADY: Bool = out Bool()
  val s_axi_control_AWADDR: UInt = in UInt (config.C_S_AXI_CONTROL_ADDR_WIDTH bits)
  val s_axi_control_WVALID: Bool = in Bool()
  val s_axi_control_WREADY: Bool = out Bool()
  val s_axi_control_WDATA: Bits = in Bits (config.C_S_AXI_CONTROL_DATA_WIDTH bits)
  val s_axi_control_WSTRB: Bits = in Bits (config.C_S_AXI_CONTROL_WSTRB_WIDTH bits)
  val s_axi_control_ARVALID: Bool = in Bool()
  val s_axi_control_ARREADY: Bool = out Bool()
  val s_axi_control_ARADDR: UInt = in UInt (config.C_S_AXI_CONTROL_ADDR_WIDTH bits)
  val s_axi_control_RVALID: Bool = out Bool()
  val s_axi_control_RREADY: Bool = in Bool()
  val s_axi_control_RDATA: Bits = out Bits (config.C_S_AXI_CONTROL_DATA_WIDTH bits)
  val s_axi_control_RRESP: Bits = out Bits (2 bits)
  val s_axi_control_BVALID: Bool = out Bool()
  val s_axi_control_BREADY: Bool = in Bool()
  val s_axi_control_BRESP: Bits = out Bits (2 bits)

  override def asMaster(): Unit = {
    out(s_axi_control_AWVALID)
    in(s_axi_control_AWREADY)
    out(s_axi_control_AWADDR)
    out(s_axi_control_WVALID)
    in(s_axi_control_WREADY)
    out(s_axi_control_WDATA)
    out(s_axi_control_WSTRB)
    out(s_axi_control_ARVALID)
    in(s_axi_control_ARREADY)
    out(s_axi_control_ARADDR)
    out(s_axi_control_RVALID)
    in(s_axi_control_RREADY)
    in(s_axi_control_RDATA)
    in(s_axi_control_RRESP)
    in(s_axi_control_BVALID)
    out(s_axi_control_BREADY)
    in(s_axi_control_BRESP)
  }

  override def asSlave(): Unit = {
    in(s_axi_control_AWVALID)
    out(s_axi_control_AWREADY)
    in(s_axi_control_AWADDR)
    in(s_axi_control_WVALID)
    out(s_axi_control_WREADY)
    in(s_axi_control_WDATA)
    in(s_axi_control_WSTRB)
    in(s_axi_control_ARVALID)
    out(s_axi_control_ARREADY)
    in(s_axi_control_ARADDR)
    out(s_axi_control_RVALID)
    in(s_axi_control_RREADY)
    out(s_axi_control_RDATA)
    out(s_axi_control_RRESP)
    out(s_axi_control_BVALID)
    in(s_axi_control_BREADY)
    out(s_axi_control_BRESP)
  }

  def connect2std(axilite: AxiLite4): Unit = {
    s_axi_control_AWVALID <> axilite.aw.valid
    s_axi_control_AWREADY <> axilite.aw.ready
    s_axi_control_AWADDR <> axilite.aw.payload.addr
    s_axi_control_WVALID <> axilite.w.valid
    s_axi_control_WREADY <> axilite.w.ready
    s_axi_control_WDATA <> axilite.w.payload.data
    s_axi_control_WSTRB <> axilite.w.payload.strb
    s_axi_control_ARVALID <> axilite.ar.valid
    s_axi_control_ARREADY <> axilite.ar.ready
    s_axi_control_ARADDR <> axilite.ar.payload.addr
    s_axi_control_RVALID <> axilite.r.valid
    s_axi_control_RREADY <> axilite.r.ready
    s_axi_control_RDATA <> axilite.r.payload.data
    s_axi_control_RRESP <> axilite.r.payload.resp
    s_axi_control_BVALID <> axilite.b.valid
    s_axi_control_BREADY <> axilite.b.ready
    s_axi_control_BRESP <> axilite.b.payload.resp
  }

}

object BlackboxAxiLiteRenamer {
  def apply(that: BlackboxAxiLite): Unit = {
    // rename the signals, make sure it matches the verilog signals
    // remove the "blackbox_axi_" prefix
    def doIt(): Unit = {
      that.flatten.foreach(bt =>
        bt.setName(bt.getName().replace("blackbox_axilite_", ""))
      )
    }

    if (Component.current == that.component)
      that.component.addPrePopTask(() => {
        doIt()
      })
    else
      doIt()
  }

}

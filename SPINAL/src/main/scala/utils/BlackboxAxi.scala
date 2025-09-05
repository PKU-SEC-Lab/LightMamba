package utils;

import spinal.core._
import spinal.lib.IMasterSlave
import spinal.lib.bus.amba4.axi._

import scala.language.postfixOps

case class BlackboxAxiConfig(
                              C_M_AXI_GMEM_ID_WIDTH: Int = 1,
                              C_M_AXI_GMEM_ADDR_WIDTH: Int = 64,
                              C_M_AXI_GMEM_DATA_WIDTH: Int = 32,
                              C_M_AXI_GMEM_AWUSER_WIDTH: Int = 1,
                              C_M_AXI_GMEM_ARUSER_WIDTH: Int = 1,
                              C_M_AXI_GMEM_WUSER_WIDTH: Int = 1,
                              C_M_AXI_GMEM_RUSER_WIDTH: Int = 1,
                              C_M_AXI_GMEM_BUSER_WIDTH: Int = 1
                            ) {
  val C_M_AXI_GMEM_WSTRB_WIDTH: Int = C_M_AXI_GMEM_DATA_WIDTH / 8

  def to_std_config(): Axi4Config = Axi4Config(
    idWidth = C_M_AXI_GMEM_ID_WIDTH,
    addressWidth = C_M_AXI_GMEM_ADDR_WIDTH,
    dataWidth = C_M_AXI_GMEM_DATA_WIDTH,
    arUserWidth = C_M_AXI_GMEM_ARUSER_WIDTH,
    awUserWidth = C_M_AXI_GMEM_AWUSER_WIDTH,
    rUserWidth = C_M_AXI_GMEM_RUSER_WIDTH,
    wUserWidth = C_M_AXI_GMEM_WUSER_WIDTH,
    bUserWidth = C_M_AXI_GMEM_BUSER_WIDTH
  )
}

object BlackboxAxiConfig {
  val default_map: Map[String, Int] = Map(
    "C_M_AXI_GMEM_ID_WIDTH" -> 1,
    "C_M_AXI_GMEM_ADDR_WIDTH" -> 64,
    "C_M_AXI_GMEM_DATA_WIDTH" -> 32,
    "C_M_AXI_GMEM_AWUSER_WIDTH" -> 1,
    "C_M_AXI_GMEM_ARUSER_WIDTH" -> 1,
    "C_M_AXI_GMEM_WUSER_WIDTH" -> 1,
    "C_M_AXI_GMEM_RUSER_WIDTH" -> 1,
    "C_M_AXI_GMEM_BUSER_WIDTH" -> 1
  )

  def apply(field_value_map: Map[String, Int]): BlackboxAxiConfig = {
    // for each pair, print
    // print the size of the map
    println(s"field_value_map size: ${field_value_map.size}")
    new BlackboxAxiConfig(
      C_M_AXI_GMEM_ID_WIDTH = field_value_map("C_M_AXI_GMEM_ID_WIDTH"),
      C_M_AXI_GMEM_ADDR_WIDTH = field_value_map("C_M_AXI_GMEM_ADDR_WIDTH"),
      C_M_AXI_GMEM_DATA_WIDTH = field_value_map("C_M_AXI_GMEM_DATA_WIDTH"),
      C_M_AXI_GMEM_AWUSER_WIDTH = field_value_map("C_M_AXI_GMEM_AWUSER_WIDTH"),
      C_M_AXI_GMEM_ARUSER_WIDTH = field_value_map("C_M_AXI_GMEM_ARUSER_WIDTH"),
      C_M_AXI_GMEM_WUSER_WIDTH = field_value_map("C_M_AXI_GMEM_WUSER_WIDTH"),
      C_M_AXI_GMEM_RUSER_WIDTH = field_value_map("C_M_AXI_GMEM_RUSER_WIDTH"),
      C_M_AXI_GMEM_BUSER_WIDTH = field_value_map("C_M_AXI_GMEM_BUSER_WIDTH")
    )
  }

  def apply(verilog_file_path: String): BlackboxAxiConfig = {
    var field_value_map: Map[String, Int] = Map()
    // try to read the source file
    val source = scala.io.Source.fromFile(verilog_file_path)
    val lines = try source.mkString finally source.close()
    val pattern = "parameter\\s+(\\w+)\\s*=\\s*(\\d+)".r
    for (m <- pattern.findAllMatchIn(lines)) {
      // check if the field is a valid field name
      val field = m.group(1)
      val value = m.group(2).toInt
      if (BlackboxAxiConfig.default_map.contains(field)) {
        field_value_map += (field -> value)
      }
    }
    // print the map
    field_value_map.foreach(println)
    BlackboxAxiConfig(field_value_map)
  }
}


case class BlackboxAxi(config: BlackboxAxiConfig) extends Bundle with IMasterSlave {
  // default master axi

  // aw channel
  val m_axi_gmem_AWVALID: Bool = out Bool()
  val m_axi_gmem_AWREADY: Bool = in Bool()
  val m_axi_gmem_AWADDR: UInt = out UInt (config.C_M_AXI_GMEM_ADDR_WIDTH bits)
  val m_axi_gmem_AWID: UInt = out UInt (config.C_M_AXI_GMEM_ID_WIDTH bits) // not use
  val m_axi_gmem_AWUSER: Bits = out Bits (config.C_M_AXI_GMEM_AWUSER_WIDTH bits)
  // default width
  val m_axi_gmem_AWREGION: Bits = out Bits (4 bits)
  val m_axi_gmem_AWLEN: UInt = out UInt (8 bits)
  val m_axi_gmem_AWSIZE: UInt = out UInt (3 bits)
  val m_axi_gmem_AWBURST: Bits = out Bits (2 bits)
  val m_axi_gmem_AWLOCK: Bits = out Bits (1 bits)
  val m_axi_gmem_AWCACHE: Bits = out Bits (4 bits)
  val m_axi_gmem_AWQOS: Bits = out Bits (4 bits)
  val m_axi_gmem_AWPROT: Bits = out Bits (3 bits)

  // w channel
  val m_axi_gmem_WVALID: Bool = out Bool()
  val m_axi_gmem_WREADY: Bool = in Bool()
  val m_axi_gmem_WDATA: Bits = out Bits (config.C_M_AXI_GMEM_DATA_WIDTH bits)
  val m_axi_gmem_WSTRB: Bits = out Bits (config.C_M_AXI_GMEM_WSTRB_WIDTH bits) // 32 bit data bus
  val m_axi_gmem_WLAST: Bool = out Bool()
  val m_axi_gmem_WID: Bits = out Bits (config.C_M_AXI_GMEM_ID_WIDTH bits)
  val m_axi_gmem_WUSER: Bits = out Bits (config.C_M_AXI_GMEM_WUSER_WIDTH bits)

  // ar channel
  val m_axi_gmem_ARVALID: Bool = out Bool()
  val m_axi_gmem_ARREADY: Bool = in Bool()
  val m_axi_gmem_ARADDR: UInt = out UInt (config.C_M_AXI_GMEM_ADDR_WIDTH bits)
  val m_axi_gmem_ARID: UInt = out UInt (config.C_M_AXI_GMEM_ID_WIDTH bits)
  val m_axi_gmem_ARUSER: Bits = out Bits (config.C_M_AXI_GMEM_ARUSER_WIDTH bits)
  // default width
  val m_axi_gmem_ARREGION: Bits = out Bits (4 bits)
  val m_axi_gmem_ARLEN: UInt = out UInt (8 bits)
  val m_axi_gmem_ARSIZE: UInt = out UInt (3 bits)
  val m_axi_gmem_ARBURST: Bits = out Bits (2 bits)
  val m_axi_gmem_ARLOCK: Bits = out Bits (1 bits)
  val m_axi_gmem_ARCACHE: Bits = out Bits (4 bits)
  val m_axi_gmem_ARQOS: Bits = out Bits (4 bits)
  val m_axi_gmem_ARPROT: Bits = out Bits (3 bits)

  // r channel slave
  val m_axi_gmem_RVALID: Bool = in Bool()
  val m_axi_gmem_RREADY: Bool = out Bool()
  val m_axi_gmem_RDATA: Bits = in Bits (config.C_M_AXI_GMEM_DATA_WIDTH bits)
  val m_axi_gmem_RLAST: Bool = in Bool()
  val m_axi_gmem_RID: UInt = in UInt (config.C_M_AXI_GMEM_ID_WIDTH bits)
  val m_axi_gmem_RUSER: Bits = in Bits (config.C_M_AXI_GMEM_RUSER_WIDTH bits)
  // default width
  val m_axi_gmem_RRESP: Bits = in Bits (2 bits)

  // b channel slave
  val m_axi_gmem_BVALID: Bool = in Bool()
  val m_axi_gmem_BREADY: Bool = out Bool()
  val m_axi_gmem_BID: UInt = in UInt (config.C_M_AXI_GMEM_ID_WIDTH bits)
  val m_axi_gmem_BUSER: Bits = in Bits (config.C_M_AXI_GMEM_BUSER_WIDTH bits)
  // default width
  val m_axi_gmem_BRESP: Bits = in Bits (2 bits)

  override def asMaster(): Unit = {
    out(m_axi_gmem_AWVALID)
    in(m_axi_gmem_AWREADY)
    out(m_axi_gmem_AWADDR)
    out(m_axi_gmem_AWID)
    out(m_axi_gmem_AWLEN)
    out(m_axi_gmem_AWSIZE)
    out(m_axi_gmem_AWBURST)
    out(m_axi_gmem_AWLOCK)
    out(m_axi_gmem_AWCACHE)
    out(m_axi_gmem_AWPROT)
    out(m_axi_gmem_AWQOS)
    out(m_axi_gmem_AWREGION)
    out(m_axi_gmem_AWUSER)
    out(m_axi_gmem_WVALID)
    in(m_axi_gmem_WREADY)
    out(m_axi_gmem_WDATA)
    out(m_axi_gmem_WSTRB)
    out(m_axi_gmem_WLAST)
    out(m_axi_gmem_WID)
    out(m_axi_gmem_WUSER)
    out(m_axi_gmem_ARVALID)
    in(m_axi_gmem_ARREADY)
    out(m_axi_gmem_ARADDR)
    out(m_axi_gmem_ARID)
    out(m_axi_gmem_ARLEN)
    out(m_axi_gmem_ARSIZE)
    out(m_axi_gmem_ARBURST)
    out(m_axi_gmem_ARLOCK)
    out(m_axi_gmem_ARCACHE)
    out(m_axi_gmem_ARPROT)
    out(m_axi_gmem_ARQOS)
    out(m_axi_gmem_ARREGION)
    out(m_axi_gmem_ARUSER)
    in(m_axi_gmem_RVALID)
    out(m_axi_gmem_RREADY)
    in(m_axi_gmem_RDATA)
    in(m_axi_gmem_RLAST)
    in(m_axi_gmem_RID)
    in(m_axi_gmem_RUSER)
    in(m_axi_gmem_RRESP)
    in(m_axi_gmem_BVALID)
    out(m_axi_gmem_BREADY)
    in(m_axi_gmem_BRESP)
    in(m_axi_gmem_BID)
    in(m_axi_gmem_BUSER)
  }

  override def asSlave(): Unit = {
    in(m_axi_gmem_AWVALID)
    out(m_axi_gmem_AWREADY)
    in(m_axi_gmem_AWADDR)
    in(m_axi_gmem_AWID)
    in(m_axi_gmem_AWLEN)
    in(m_axi_gmem_AWSIZE)
    in(m_axi_gmem_AWBURST)
    in(m_axi_gmem_AWLOCK)
    in(m_axi_gmem_AWCACHE)
    in(m_axi_gmem_AWPROT)
    in(m_axi_gmem_AWQOS)
    in(m_axi_gmem_AWREGION)
    in(m_axi_gmem_AWUSER)
    in(m_axi_gmem_WVALID)
    out(m_axi_gmem_WREADY)
    in(m_axi_gmem_WDATA)
    in(m_axi_gmem_WSTRB)
    in(m_axi_gmem_WLAST)
    in(m_axi_gmem_WID)
    in(m_axi_gmem_WUSER)
    in(m_axi_gmem_ARVALID)
    out(m_axi_gmem_ARREADY)
    in(m_axi_gmem_ARADDR)
    in(m_axi_gmem_ARID)
    in(m_axi_gmem_ARLEN)
    in(m_axi_gmem_ARSIZE)
    in(m_axi_gmem_ARBURST)
    in(m_axi_gmem_ARLOCK)
    in(m_axi_gmem_ARCACHE)
    in(m_axi_gmem_ARPROT)
    in(m_axi_gmem_ARQOS)
    in(m_axi_gmem_ARREGION)
    in(m_axi_gmem_ARUSER)
    out(m_axi_gmem_RVALID)
    in(m_axi_gmem_RREADY)
    out(m_axi_gmem_RDATA)
    out(m_axi_gmem_RLAST)
    out(m_axi_gmem_RID)
    out(m_axi_gmem_RUSER)
    out(m_axi_gmem_RRESP)
    out(m_axi_gmem_BVALID)
    in(m_axi_gmem_BREADY)
    out(m_axi_gmem_BRESP)
    out(m_axi_gmem_BID)
    out(m_axi_gmem_BUSER)
  }

  def connect2std(Axi: Axi4): Unit = {
    m_axi_gmem_AWVALID <> Axi.aw.valid
    m_axi_gmem_AWREADY <> Axi.aw.ready
    m_axi_gmem_AWADDR <> Axi.aw.addr
    m_axi_gmem_AWID <> Axi.aw.id
    m_axi_gmem_AWLEN <> Axi.aw.len
    m_axi_gmem_AWSIZE <> Axi.aw.size
    m_axi_gmem_AWBURST <> Axi.aw.burst
    m_axi_gmem_AWLOCK <> Axi.aw.lock
    m_axi_gmem_AWCACHE <> Axi.aw.cache
    m_axi_gmem_AWPROT <> Axi.aw.prot
    m_axi_gmem_AWQOS <> Axi.aw.qos
    m_axi_gmem_AWREGION <> Axi.aw.region
    m_axi_gmem_AWUSER <> Axi.aw.user
    m_axi_gmem_WVALID <> Axi.w.valid
    m_axi_gmem_WREADY <> Axi.w.ready
    m_axi_gmem_WDATA <> Axi.w.data
    m_axi_gmem_WSTRB <> Axi.w.strb
    m_axi_gmem_WLAST <> Axi.w.last
    //    m_axi_gmem_WID <> Axi.w.id // not implemented in Spinal
    m_axi_gmem_WUSER <> Axi.w.user
    m_axi_gmem_ARVALID <> Axi.ar.valid
    m_axi_gmem_ARREADY <> Axi.ar.ready
    m_axi_gmem_ARADDR <> Axi.ar.addr
    m_axi_gmem_ARID <> Axi.ar.id
    m_axi_gmem_ARLEN <> Axi.ar.len
    m_axi_gmem_ARSIZE <> Axi.ar.size
    m_axi_gmem_ARBURST <> Axi.ar.burst
    m_axi_gmem_ARLOCK <> Axi.ar.lock
    m_axi_gmem_ARCACHE <> Axi.ar.cache
    m_axi_gmem_ARPROT <> Axi.ar.prot
    m_axi_gmem_ARQOS <> Axi.ar.qos
    m_axi_gmem_ARREGION <> Axi.ar.region
    m_axi_gmem_ARUSER <> Axi.ar.user
    m_axi_gmem_RVALID <> Axi.r.valid
    m_axi_gmem_RREADY <> Axi.r.ready
    m_axi_gmem_RDATA <> Axi.r.data
    m_axi_gmem_RLAST <> Axi.r.last
    m_axi_gmem_RID <> Axi.r.id
    m_axi_gmem_RUSER <> Axi.r.user
    m_axi_gmem_RRESP <> Axi.r.resp
    m_axi_gmem_BVALID <> Axi.b.valid
    m_axi_gmem_BREADY <> Axi.b.ready
    m_axi_gmem_BRESP <> Axi.b.resp
    m_axi_gmem_BID <> Axi.b.id
    m_axi_gmem_BUSER <> Axi.b.user
  }
}

object BlackboxAxiRenamer {
  def apply(that: BlackboxAxi): Unit = {
    // rename the signals, make sure it matches the verilog signals
    // remove the "blackbox_axi_" prefix
    def doIt(): Unit = {
      that.flatten.foreach(bt =>
        bt.setName(bt.getName().replace("blackbox_axi_", ""))
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

package utils

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axilite._

import scala.language.postfixOps

class Controller extends Component {
  val io = new Bundle {
    val axilite: AxiLite4 = slave(AxiLite4(addressWidth = ctrl_cfg.axilite_addr_width, dataWidth = ctrl_cfg.axilite_data_width))
    // direct ports
    val signals: ManagerSignals = out(ManagerSignals())
    // read idle
    val idle: Bool = in Bool()
  }
  noIoPrefix()
  AxiLite4SpecRenamer(io.axilite)

  // data registers
  private val busCtrl = new AxiLite4SlaveFactory(io.axilite)
  io.signals.T := False // on write requires default value
  // @formatter:off
  busCtrl.driveAndRead(io.signals.L_BEGIN,   ctrl_cfg.ADDR_L_BEGIN,  0, "Start layer")
  busCtrl.driveAndRead(io.signals.L_CLOSE,   ctrl_cfg.ADDR_L_CLOSE,  0, "Close layer")
  busCtrl.driveAndRead(io.signals.MEMORY_X,  ctrl_cfg.ADDR_MEMORY_X, 0, "Memory X")
  busCtrl.driveAndRead(io.signals.MEMORY_W,  ctrl_cfg.ADDR_MEMORY_W, 0, "Memory W")
  busCtrl.driveAndRead(io.signals.MEMORY_Y,  ctrl_cfg.ADDR_MEMORY_Y, 0, "Memory Y")
  busCtrl.driveAndRead(io.signals.MEMORY_C,  ctrl_cfg.ADDR_MEMORY_C, 0, "Memory C")
  busCtrl.driveAndRead(io.signals.MEMORY_H,  ctrl_cfg.ADDR_MEMORY_H, 0, "Memory H")
  busCtrl.driveAndRead(io.signals.POS,       ctrl_cfg.ADDR_POS,      0, "POS")
  busCtrl.write       (io.signals.T,         ctrl_cfg.ADDR_T,        0, "Trigger")
  busCtrl.read        (io.idle,              ctrl_cfg.ADDR_IDLE,     0, "Idle")
}

object simulate_controller extends App {

  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = ASYNC,
      resetActiveLevel = LOW
    )
  )

  SpinalVerilog(spinalConfig)(new Controller)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(3)
    .compile(new Controller)
    .doSimUntilVoid { dut =>

      val drv = AddressSeparableAxiLite4Driver(dut.io.axilite, dut.clockDomain)
      drv.reset()

      // init
      init_clock(dut.clockDomain, 10)

      drv.write(ctrl_cfg.ADDR_L_BEGIN, 1)
      dut.clockDomain.waitSampling(10)
      drv.write(ctrl_cfg.ADDR_L_CLOSE, 10)
      dut.clockDomain.waitSampling(100)

      drv.write(ctrl_cfg.ADDR_MEMORY_X, 0x12345678)
      dut.clockDomain.waitSampling(10)
      drv.write(ctrl_cfg.ADDR_MEMORY_W, 0x0EADBEEF)
      dut.clockDomain.waitSampling(10)
      drv.write(ctrl_cfg.ADDR_MEMORY_Y, 0x07654321)
      dut.clockDomain.waitSampling(100)

      drv.write(ctrl_cfg.ADDR_POS, 0x12345678)
      dut.clockDomain.waitSampling(10)

      drv.write(ctrl_cfg.ADDR_T, 1)
      dut.clockDomain.waitSampling(100)

      simSuccess()
    }
}

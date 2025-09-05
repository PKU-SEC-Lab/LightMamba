package utils

import spinal.core._
import spinal.lib._
import spinal.lib.fsm.{EntryPoint, State, StateMachine}

import scala.language.postfixOps

case class ApChain() extends Bundle with IMasterSlave {
  // Xilinx ap chain control signals

  val ap_start: Bool = Bool()
  val ap_continue: Bool = Bool()
  val ap_idle: Bool = Bool()
  val ap_ready: Bool = Bool()
  val ap_done: Bool = Bool()

  override def asMaster(): Unit = {
    out(ap_start)
    out(ap_continue)
    in(ap_idle)
    in(ap_ready)
    in(ap_done)
  }

  override def asSlave(): Unit = {
    in(ap_start)
    in(ap_continue)
    out(ap_idle)
    out(ap_ready)
    out(ap_done)
  }

}

object ApChainRenamer {
  def apply(that: ApChain): Unit = {
    def doIt(): Unit = {
      that.flatten.foreach(bt =>
        bt.setName(bt.getName().replace("ap_ctrl_", ""))
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

case class DaisyChain[T <: Data](gen: T) extends Bundle {
  // daisy chain IO
  val I: T = in(cloneOf(gen))
  val O: T = out(cloneOf(gen))
}

object ctrl_cfg {
  val L_BITS: Int = 32 // how many layers to process
  val POS_BITS: Int = 12 // current pos id

  val axilite_addr_width = 16
  val axilite_data_width = 64 // indexing more than 4GB

  // register space for controller
  // @formatter:off
  val ADDR_L_BEGIN  = 0x0000
  val ADDR_L_CLOSE  = 0x0010
  val ADDR_MEMORY_X = 0x0020
  val ADDR_MEMORY_W = 0x0030
  val ADDR_MEMORY_Y = 0x0040
  val ADDR_POS      = 0x0050
  val ADDR_T        = 0x0060
  val ADDR_IDLE     = 0x0070
  val ADDR_MEMORY_C = 0x0080
  val ADDR_MEMORY_H = 0x0090
  // @formatter:on
}

case class ManagerSignals() extends Bundle {
  // @formatter:off
  val L_BEGIN: UInt = UInt(ctrl_cfg.L_BITS bits) // start layer
  val L_CLOSE: UInt = UInt(ctrl_cfg.L_BITS bits) // close layer, exclusive
  val MEMORY_X:  UInt = UInt(64 bits) // memory address
  val MEMORY_W:  UInt = UInt(64 bits) // memory address
  val MEMORY_Y:  UInt = UInt(64 bits) // memory address
  val MEMORY_C:  UInt = UInt(64 bits) // memory address
  val MEMORY_H:  UInt = UInt(64 bits) // memory address
  val POS: UInt = UInt(ctrl_cfg.POS_BITS bits) // current pos id
  val T: Bool = Bool() // Trigger
  // @formatter:on
}

class Manager(single: Boolean = false) extends Component {
  // @formatter:off
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val ap_ctrl: ApChain = master(ApChain())
    val l:      UInt = out(UInt(ctrl_cfg.L_BITS   bits))
  }
  // @formatter:on

  noIoPrefix()

  // @formatter:off
  io.signals.O.L_BEGIN    := RegNext(io.signals.I.L_BEGIN)  // pass L_BEGIN
  io.signals.O.L_CLOSE    := RegNext(io.signals.I.L_CLOSE)  // pass L_CLOSE
  io.signals.O.MEMORY_X   := RegNext(io.signals.I.MEMORY_X) // pass MEMORY_X
  io.signals.O.MEMORY_W   := RegNext(io.signals.I.MEMORY_W) // pass MEMORY_W
  io.signals.O.MEMORY_Y   := RegNext(io.signals.I.MEMORY_Y) // pass MEMORY_Y
  io.signals.O.MEMORY_C   := RegNext(io.signals.I.MEMORY_C) // pass MEMORY_W
  io.signals.O.MEMORY_H   := RegNext(io.signals.I.MEMORY_H) // pass MEMORY_Y
  io.signals.O.POS        := RegNext(io.signals.I.POS)      // pass POS
  io.signals.O.T          := RegNext(io.signals.I.T)        // pass trigger
  // @formatter:on

  val l_counter: UInt = Reg(UInt(ctrl_cfg.L_BITS bits)) init 0

  io.l := l_counter

  // @formatter:off
  io.ap_ctrl.ap_continue := True  // always continue
  io.ap_ctrl.ap_start    := False // default value
  // @formatter:on

  val fsm: StateMachine = new StateMachine {
    val s_idle = new State with EntryPoint
    val s_work = new State
    val s_wait = new State

    s_idle.whenIsActive {
      when(io.signals.I.T) {
        l_counter := io.signals.I.L_BEGIN // set the counter
        goto(s_work)
      }
    } // end of s_idle


    s_work.whenIsActive {
      io.ap_ctrl.ap_start := True

      val jump_idle: Bool = if (single) True else (l_counter === io.signals.I.L_CLOSE - 1)

      when(io.ap_ctrl.ap_ready) { // handshake with ap_ready
        //        when(l_counter === io.signals.I.L_CLOSE - 1) {
        when(jump_idle) {
          goto(s_idle)
        } otherwise {
          l_counter := l_counter + 1 // next one
          goto(s_wait)
        }
      } // else, wait for ap_ready
    } // end of s_work

    s_wait.whenIsActive {
      io.ap_ctrl.ap_start := False
      when(io.ap_ctrl.ap_idle) {
        goto(s_work)
      }
    } // end of s_wait

  } // end of fsm

}

object genManager extends App {
  SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = ASYNC,
      resetActiveLevel = LOW
    ),
    mode = Verilog
  ).generate(new Manager)
}
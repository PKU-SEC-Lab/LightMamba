import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, RMSNORM_QUANT requires l input, which indicates the order of layer
class CONV_Blackbox extends BlackBox {
  val top_name: String = "CONV"
  setDefinitionName(top_name)
  // source file
  private val rtl_file_path: String = s"src/main/verilog/$top_name"
  private val verilog_file_path: String = s"$rtl_file_path/all.v"
  // define the IO of verilog entity
  val io = new Bundle {
    // clock and reset
    val ap_clk: Bool = in Bool()
    val ap_rst_n: Bool = in Bool()
    // the l signal
    val l: UInt = in UInt (32 bits)
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    val ap_ctrl: ApChain = slave(ApChain())
    // @formatter:off
    val i_stream: BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("i_stream", verilog_file_path)))
    val s_stream: BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("s_stream", verilog_file_path)))
    val w_stream: BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("w_stream", verilog_file_path)))
    val w_s_stream: BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("w_s_stream", verilog_file_path)))
    val o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
    // @formatter:on
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

class CONV extends Component {
  val top_name: String = "CONV"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new CONV_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val i_stream: Axi4Stream = slave(Axi4Stream(black_box.io.i_stream.config.to_std_config()))
    val s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.s_stream.config.to_std_config()))
    val w_stream: Axi4Stream = slave(Axi4Stream(black_box.io.w_stream.config.to_std_config()))
    val w_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.w_s_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  manager.io.l <> black_box.io.l
  black_box.io.i_stream.connect2std(io.i_stream)
  black_box.io.s_stream.connect2std(io.s_stream)
  black_box.io.w_stream.connect2std(io.w_stream)
  black_box.io.w_s_stream.connect2std(io.w_s_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.i_stream)
  Axi4StreamSpecRenamer(io.s_stream)
  Axi4StreamSpecRenamer(io.w_stream)
  Axi4StreamSpecRenamer(io.w_s_stream)
  Axi4StreamSpecRenamer(io.o_stream)
}

object simulate_conv extends App {
  redirect_std("CONV.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new CONV)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new CONV)
    .doSimUntilVoid { dut =>
      // some hyper parameters
      //      val L = 64
      val L = 2
      val L_BEGIN = 0
      val L_CLOSE = L

      val T = 1
      val TP = 1
      val C = 5376
      val D = 4
      val CP = 8
      val N = 128
      val C2 = 5120

      val CT = C / CP
      val NT=N/CP
      val C2T=C2/CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      val xBC_q = read_multi_int64_files(format_str, L, "/activations/xBC_q_layer", D * C)
      val xBC_s = read_multi_int64_files(format_str, L, "/activations/xBC_s_layer", D * CT)
      val xBC_conv  = read_multi_int64_files(format_str, L, "/activations/xBC_conv_layer", D * C)
      val w_q = read_multi_int64_files(format_str, L, "/weights/conv_wq_layer", 4 * C)
      val w_s = read_multi_int64_files(format_str, L, "/weights/conv_ws_layer", 4 * CT)

      val REF_XBC_Q = Array.ofDim[Long](L, D * C)
      val REF_XBC_S = Array.ofDim[Long](L, D * CT)
      val REF_XBC = Array.ofDim[Long](L, T * C)
      val ref_w_q  = Array.ofDim[Long](L, 4 * C)
      val ref_w_s  = Array.ofDim[Long](L, 4 * CT)
      // @formatter:off
      for (l <- 0 until L) {
        for (ct <- 0 until CT) {
          var ct_cur=0
          if(ct<NT*2) {
            ct_cur=ct+C2T
          }
          else {
            ct_cur=ct-2*NT
          }
          for (d <- 0 until D) {
            for (cp <- 0 until CP) {
              REF_XBC_Q(l)(ct*D*CP+d*CP+cp) = xBC_q(l)(d*C+ct_cur*CP+cp)
              ref_w_q(l)(ct*D*CP+d*CP+cp) = w_q(l)(d*C+ct_cur*CP+cp)
            }
            REF_XBC_S(l)(ct*D+d) = xBC_s(l)(d*CT+ct_cur)
            ref_w_s(l)(ct*D+d) = w_s(l)(d*CT+ct_cur)
          }
          for (cp <- 0 until CP) {
            REF_XBC(l)(ct*CP+cp) = xBC_conv(l)(3*C+ct_cur*CP+cp)
          }
        }
      }
      // @formatter:on

      val DUT_XBC = Array.ofDim[Long](L, T * C)

      // init ap_ctrl and streams
      init_i_stream(dut.io.i_stream)
      init_i_stream(dut.io.s_stream)
      init_i_stream(dut.io.w_stream)
      init_i_stream(dut.io.w_s_stream)
      init_o_stream(dut.io.o_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      init_clock(dut.clockDomain, 10)
      // threads
      Array(
        fork {
          // set scalar parameters
          dut.io.signals.I.L_BEGIN #= L_BEGIN
          dut.io.signals.I.L_CLOSE #= L_CLOSE
          // delay 20 cycles to make sure the signals are set
          dut.clockDomain.waitSampling(20)
          // launch with trigger
          dut.io.signals.I.T #= true
          dut.clockDomain.waitSampling()
          dut.io.signals.I.T #= false
        },
        // @formatter:off
        fork {
          for (l <- 0 until L) array2stream(dut.io.i_stream,    dut.clockDomain, REF_XBC_Q(l), 1, 1, 1, 1, C*D, CP)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.s_stream,    dut.clockDomain, REF_XBC_S(l), 1, 1, 1, 1, CT*D, 1)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.w_stream,    dut.clockDomain, ref_w_q(l), 1, 1, 1, 1, C*D, CP)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.w_s_stream,    dut.clockDomain, ref_w_s(l), 1, 1, 1, 1, CT*D, 1)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_stream, dut.clockDomain, REF_XBC(l), DUT_XBC(l), 1, T, TP, C,CP,  verbose = true, info = s"CONV of layer $l")
        }
        // @formatter:on
      ).foreach(_.join())
      simSuccess()
    }
}


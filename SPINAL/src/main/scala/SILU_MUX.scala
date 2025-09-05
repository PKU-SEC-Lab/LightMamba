import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, MUX requires l input, which indicates the order of layer
class SILU_MUX_Blackbox extends BlackBox {
  val top_name: String = "SILU_MUX"
  setDefinitionName(top_name)
  // source file
  private val verilog_file_path: String = s"src/main/verilog/$top_name/all.v"
  // define the IO of verilog entity
  val io = new Bundle {
    // clock and reset
    val ap_clk: Bool = in Bool()
    val ap_rst_n: Bool = in Bool()
    // FIXME: be careful about the naming! It must match the verilog interface name. For example: i_stream_TDATA <=> i_stream
    val ap_ctrl: ApChain = slave(ApChain())
    // @formatter:off
    val xBC_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("xBC_stream",  verilog_file_path)))
    val z_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("z_stream",  verilog_file_path)))
    val silu_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("silu_stream",     verilog_file_path)))
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

class SILU_MUX extends Component {
  val top_name: String = "SILU_MUX"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new SILU_MUX_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val xBC_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.xBC_stream.config.to_std_config()))
    val z_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.z_stream.config.to_std_config()))
    val silu_stream:     Axi4Stream = master(Axi4Stream(black_box.io.silu_stream   .config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  // @formatter:off
  black_box.io.xBC_stream.connect2std(io.xBC_stream)
  black_box.io.z_stream.connect2std(io.z_stream)
  black_box.io.silu_stream.connect2std(io.silu_stream)
  // @formatter:on
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.xBC_stream)
  Axi4StreamSpecRenamer(io.z_stream)
  Axi4StreamSpecRenamer(io.silu_stream)
}

object simulate_silu_mux extends App {
  redirect_std("SILU_MUX.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new SILU_MUX)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new SILU_MUX)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      val L = 2

      val T = 1
      val TP = 1

      val CC        = 5376
      val N         = 128
      val C2        = 5120

      val CP        = G

      val NTT       = 2*N  / CP
      val CCT       = CC  / CP
      val C2T       = C2  / CP
      val CT        = C2*2  / CP

      val NUM_X     = CC+C2

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      // @formatter:off
      val xBC = read_multi_int64_files(format_str, L, "/xBC_layer", T * CC)
      val z = read_multi_int64_files(format_str, L, "/z_layer", T * C2)

      val ref_silu  = Array.ofDim[Long](L, NUM_X)
      for (l <- 0 until L) {
        var ct=0
        for (nt <- 0 until NTT) {
          for (cp <- 0 until CP) {
            ref_silu(l)(ct * CP + cp) = xBC(l)(nt*CP+cp)
          }
          ct+=1
        }
        for (c2t <- 0 until C2T) {
          for (cp <- 0 until CP) {
            ref_silu(l)(ct * CP + cp) = xBC(l)(2*N+c2t*CP+cp)
          }
          ct+=1
          for (cp <- 0 until CP) {
            ref_silu(l)(ct * CP + cp) = z(l)(c2t*CP+cp)
          }
          ct+=1
        }
      }

      val DUT_o  = Array.ofDim[Long](L, NUM_X)

      // init ap_ctrl and streams
      init_i_stream(dut.io.xBC_stream)
      init_i_stream(dut.io.z_stream)
      init_o_stream(dut.io.silu_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      init_clock(dut.clockDomain, 10)
      // threads
      Array(
        fork {
          dut.io.signals.I.L_BEGIN #= 0
          dut.io.signals.I.L_CLOSE #= L
          // delay 20 cycles to make sure the signals are set
          dut.clockDomain.waitSampling(20)
          // launch with trigger
          dut.io.signals.I.T #= true
          dut.clockDomain.waitSampling()
          dut.io.signals.I.T #= false
        },
        // @formatter:off
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.xBC_stream, dut.clockDomain, xBC(l), 1, 1, TP, 1, CC,  CP, info="xBC stream", verbose=true)
          }
        },
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.z_stream, dut.clockDomain, z(l), 1, 1, TP, 1, C2,  CP, info="z stream", verbose=true)
          }
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.silu_stream,  dut.clockDomain, ref_silu(l), DUT_o(l),  1, TP, 1, NUM_X,  CP, info="o stream", verbose=true)
        }
        // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)
      simSuccess()
    }
}


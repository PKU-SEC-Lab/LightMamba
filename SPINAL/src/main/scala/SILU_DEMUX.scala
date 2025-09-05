import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, MUX requires l input, which indicates the order of layer
class SILU_DEMUX_Blackbox extends BlackBox {
  val top_name: String = "SILU_DEMUX"
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
    val silu_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("silu_stream",  verilog_file_path)))
    val silu_s_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("silu_s_stream",  verilog_file_path)))
    val x_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("x_stream",     verilog_file_path)))
    val x_s_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("x_s_stream",     verilog_file_path)))
    val x_stream2:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("x_stream2",     verilog_file_path)))
    val x_s_stream2:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("x_s_stream2",     verilog_file_path)))
    val B_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("B_stream",     verilog_file_path)))
    val B_s_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("B_s_stream",     verilog_file_path)))
    val C_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("C_stream",     verilog_file_path)))
    val C_s_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("C_s_stream",     verilog_file_path)))
    val z_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("z_stream",     verilog_file_path)))
    val z_s_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("z_s_stream",     verilog_file_path)))
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

class SILU_DEMUX extends Component {
  val top_name: String = "SILU_DEMUX"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new SILU_DEMUX_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val silu_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.silu_stream.config.to_std_config()))
    val silu_s_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.silu_s_stream.config.to_std_config()))
    val x_stream:     Axi4Stream = master(Axi4Stream(black_box.io.x_stream   .config.to_std_config()))
    val x_s_stream:     Axi4Stream = master(Axi4Stream(black_box.io.x_s_stream   .config.to_std_config()))
    val x_stream2:     Axi4Stream = master(Axi4Stream(black_box.io.x_stream2   .config.to_std_config()))
    val x_s_stream2:     Axi4Stream = master(Axi4Stream(black_box.io.x_s_stream2   .config.to_std_config()))
    val B_stream:     Axi4Stream = master(Axi4Stream(black_box.io.B_stream   .config.to_std_config()))
    val B_s_stream:     Axi4Stream = master(Axi4Stream(black_box.io.B_s_stream   .config.to_std_config()))
    val C_stream:     Axi4Stream = master(Axi4Stream(black_box.io.C_stream   .config.to_std_config()))
    val C_s_stream:     Axi4Stream = master(Axi4Stream(black_box.io.C_s_stream   .config.to_std_config()))
    val z_stream:     Axi4Stream = master(Axi4Stream(black_box.io.z_stream   .config.to_std_config()))
    val z_s_stream:     Axi4Stream = master(Axi4Stream(black_box.io.z_s_stream   .config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  // @formatter:off
  black_box.io.silu_stream.connect2std(io.silu_stream)
  black_box.io.silu_s_stream.connect2std(io.silu_s_stream)
  black_box.io.x_stream.connect2std(io.x_stream)
  black_box.io.x_s_stream.connect2std(io.x_s_stream)
  black_box.io.x_stream2.connect2std(io.x_stream2)
  black_box.io.x_s_stream2.connect2std(io.x_s_stream2)
  black_box.io.B_stream.connect2std(io.B_stream)
  black_box.io.B_s_stream.connect2std(io.B_s_stream)
  black_box.io.C_stream.connect2std(io.C_stream)
  black_box.io.C_s_stream.connect2std(io.C_s_stream)
  black_box.io.z_stream.connect2std(io.z_stream)
  black_box.io.z_s_stream.connect2std(io.z_s_stream)
  // @formatter:on
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.silu_stream)
  Axi4StreamSpecRenamer(io.silu_s_stream)
  Axi4StreamSpecRenamer(io.x_stream)
  Axi4StreamSpecRenamer(io.x_s_stream)
  Axi4StreamSpecRenamer(io.x_stream2)
  Axi4StreamSpecRenamer(io.x_s_stream2)
  Axi4StreamSpecRenamer(io.B_stream)
  Axi4StreamSpecRenamer(io.B_s_stream)
  Axi4StreamSpecRenamer(io.C_stream)
  Axi4StreamSpecRenamer(io.C_s_stream)
  Axi4StreamSpecRenamer(io.z_stream)
  Axi4StreamSpecRenamer(io.z_s_stream)
}

object simulate_silu_demux extends App {
  redirect_std("SILU_DEMUX.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new SILU_DEMUX)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new SILU_DEMUX)
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
      val NT       = N  / CP
      val CCT       = CC  / CP
      val C2T       = C2  / CP
      val CT        = (CC+C2) / CP

      val NUM_Y     = CC+C2;

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      // @formatter:off
      val silu_q = read_multi_int64_files(format_str, L, "/xBCz_silu_q_layer", T * NUM_Y)
      val silu_s = read_multi_int64_files(format_str, L, "/xBCz_silu_s_layer", T * CT)

      val x_q  = Array.ofDim[Long](L, C2)
      val x_s  = Array.ofDim[Long](L, C2T)
      val B_q  = Array.ofDim[Long](L, N)
      val B_s  = Array.ofDim[Long](L, NT)
      val C_q  = Array.ofDim[Long](L, N)
      val C_s  = Array.ofDim[Long](L, NT)
      val z_q  = Array.ofDim[Long](L, C2)
      val z_s  = Array.ofDim[Long](L, C2T)


      for (l <- 0 until L) {
        var ct=0
        for (nt <- 0 until NT) {
          for (cp <- 0 until CP) {
            B_q(l)(nt * CP + cp) = silu_q(l)(ct*CP+cp)
          }
          B_s(l)(nt) = silu_s(l)(ct)
          ct+=1
        }
        for (nt <- 0 until NT) {
          for (cp <- 0 until CP) {
            C_q(l)(nt * CP + cp) = silu_q(l)(ct*CP+cp)
          }
          C_s(l)(nt) = silu_s(l)(ct)
          ct+=1
        }
        for (c2t <- 0 until C2T) {
          for (cp <- 0 until CP) {
            x_q(l)(c2t * CP + cp) = silu_q(l)(ct*CP+cp)
          }
          x_s(l)(c2t) = silu_s(l)(ct)
          ct+=1
          for (cp <- 0 until CP) {
            z_q(l)(c2t * CP + cp) = silu_q(l)(ct*CP+cp)
          }
          z_s(l)(c2t) = silu_s(l)(ct)
          ct+=1
        }
      }

      val dut_x_q  = Array.ofDim[Long](L, C2)
      val dut_x_s  = Array.ofDim[Long](L, C2T)
      val dut_x_q2  = Array.ofDim[Long](L, C2)
      val dut_x_s2  = Array.ofDim[Long](L, C2T)
      val dut_B_q  = Array.ofDim[Long](L, N)
      val dut_B_s  = Array.ofDim[Long](L, NT)
      val dut_C_q  = Array.ofDim[Long](L, N)
      val dut_C_s  = Array.ofDim[Long](L, NT)
      val dut_z_q  = Array.ofDim[Long](L, C2)
      val dut_z_s  = Array.ofDim[Long](L, C2T)

      // init ap_ctrl and streams
      init_i_stream(dut.io.silu_stream)
      init_i_stream(dut.io.silu_s_stream)
      init_o_stream(dut.io.x_stream)
      init_o_stream(dut.io.x_s_stream)
      init_o_stream(dut.io.x_stream2)
      init_o_stream(dut.io.x_s_stream2)
      init_o_stream(dut.io.B_stream)
      init_o_stream(dut.io.B_s_stream)
      init_o_stream(dut.io.C_stream)
      init_o_stream(dut.io.C_s_stream)
      init_o_stream(dut.io.z_stream)
      init_o_stream(dut.io.z_s_stream)
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
          for (l <- 0 until L) array2stream(dut.io.silu_stream, dut.clockDomain, silu_q(l), 1, 1, TP, 1, NUM_Y,  CP, info="silu_q", verbose=true)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.silu_s_stream, dut.clockDomain, silu_s(l), 1, 1, TP, 1, CT,  1, info="silu_s")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.x_stream,  dut.clockDomain, x_q(l), dut_x_q(l),  1, TP, 1, C2,  CP, info="x stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.x_s_stream,  dut.clockDomain, x_s(l), dut_x_s(l),  1, TP, 1, C2T, 1, info="x_s stream")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.x_stream2,  dut.clockDomain, x_q(l), dut_x_q2(l),  1, TP, 1, C2,  CP, info="x stream2", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.x_s_stream2,  dut.clockDomain, x_s(l), dut_x_s2(l),  1, TP, 1, C2T, 1, info="x_s stream2")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.B_stream,  dut.clockDomain, B_q(l), dut_B_q(l),  1, TP, 1, N,  CP, info="B stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.B_s_stream,  dut.clockDomain, B_s(l), dut_B_s(l),  1, TP, 1, NT, 1, info="B_s stream")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.C_stream,  dut.clockDomain, C_q(l), dut_C_q(l),  1, TP, 1, N,  CP, info="C stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.C_s_stream,  dut.clockDomain, C_s(l), dut_C_s(l),  1, TP, 1, NT, 1, info="C_s stream")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.z_stream,  dut.clockDomain, z_q(l), dut_z_q(l),  1, TP, 1, C2,  CP, info="z stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.z_s_stream,  dut.clockDomain, z_s(l), dut_z_s(l),  1, TP, 1, C2T, 1, info="z_s stream")
        }
        // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)
      simSuccess()
    }
}


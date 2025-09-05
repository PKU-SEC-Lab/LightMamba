import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, MUX requires l input, which indicates the order of layer
class GEMM_DEMUX_Blackbox extends BlackBox {
  val top_name: String = "GEMM_DEMUX"
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
    val gemm_stream:  BlackboxAxis = slave (BlackboxAxis(BlackboxAxisConfig("gemm_stream",  verilog_file_path)))
    val dt_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("dt_stream",     verilog_file_path)))
    val xBC_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("xBC_stream",     verilog_file_path)))
    val z_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("z_stream",     verilog_file_path)))
    val out_stream:     BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("out_stream",     verilog_file_path)))
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

class GEMM_DEMUX extends Component {
  val top_name: String = "GEMM_DEMUX"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new GEMM_DEMUX_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    // @formatter:off
    val gemm_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.gemm_stream.config.to_std_config()))
    val dt_stream:     Axi4Stream = master(Axi4Stream(black_box.io.dt_stream   .config.to_std_config()))
    val xBC_stream:     Axi4Stream = master(Axi4Stream(black_box.io.xBC_stream   .config.to_std_config()))
    val z_stream:     Axi4Stream = master(Axi4Stream(black_box.io.z_stream   .config.to_std_config()))
    val out_stream:     Axi4Stream = master(Axi4Stream(black_box.io.out_stream   .config.to_std_config()))
    // @formatter:on
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  // @formatter:off
  black_box.io.gemm_stream.connect2std(io.gemm_stream)
  black_box.io.dt_stream.connect2std(io.dt_stream)
  black_box.io.xBC_stream.connect2std(io.xBC_stream)
  black_box.io.z_stream.connect2std(io.z_stream)
  black_box.io.out_stream.connect2std(io.out_stream)
  // @formatter:on
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.gemm_stream)
  Axi4StreamSpecRenamer(io.dt_stream)
  Axi4StreamSpecRenamer(io.xBC_stream)
  Axi4StreamSpecRenamer(io.z_stream)
  Axi4StreamSpecRenamer(io.out_stream)
}

object simulate_gemm_demux extends App {
  redirect_std("GEMM_DEMUX.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new GEMM_DEMUX)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new GEMM_DEMUX)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      val L = 2

      val T = 1
      val TP = 1

      val CP = G
      val N         = 128
      val P         = 64
      val CH        = 80
      val CC        = 5376
      val C2        = 5120
      val CO        = 2560
      val CHT       = CH/CP
      val NTT       = 2*N/CP
      val CT        = 2*P+1 //129
      val COT       = CO/CP //129

      // @formatter:off
      val NUM_Y = 2*N+CH*CT
      // @formatter:on

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // arrays
      // @formatter:off
      val in = read_multi_int64_files(format_str, L, "/zxbcdt_layer", T * NUM_Y)
      val out = read_multi_int64_files(format_str, L, "/out_proj_layer", T * CO)

      val ref_dt  = Array.ofDim[Long](L, CH)
      val ref_xBC  = Array.ofDim[Long](L, CC)
      val ref_z  = Array.ofDim[Long](L, C2)


      for (l <- 0 until L) {
        var ct=0
        for (nt <- 0 until NTT) {
          for (cp <- 0 until CP) {
            ref_xBC(l)(nt * CP + cp) = in(l)(ct*CP+cp)
          }
          ct+=1
        }
        for (ht <- 0 until CHT) {
          for (cp <- 0 until CP) {
            ref_dt(l)(ht * CP + cp) = in(l)(ct*CP+cp)
          }
          ct+=1
          for (p <- 0 until P) {
            for (cp <- 0 until CP) {
              ref_xBC(l)(2 * N + ht * CP * P + p * CP + cp) = in(l)(ct*CP+cp)
            }
            ct+=1
            for (cp <- 0 until CP) {
              ref_z(l)(ht * CP * P + p * CP + cp) = in(l)(ct*CP+cp)
            }
            ct+=1
          }
        }
      }

      val DUT_dt  = Array.ofDim[Long](L, CH)
      val DUT_xBC  = Array.ofDim[Long](L, CC)
      val DUT_z  = Array.ofDim[Long](L, C2)
      val DUT_out  = Array.ofDim[Long](L, CO)

      // init ap_ctrl and streams
      init_i_stream(dut.io.gemm_stream)
      init_o_stream(dut.io.dt_stream)
      init_o_stream(dut.io.xBC_stream)
      init_o_stream(dut.io.z_stream)
      init_o_stream(dut.io.out_stream)
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
            array2stream(dut.io.gemm_stream, dut.clockDomain, in(l), 1, 1, TP, 1, NUM_Y,  CP, info="in proj", verbose=true)
            array2stream(dut.io.gemm_stream, dut.clockDomain, out(l), 1, 1, TP, 1, CO,  CP, info="out proj", verbose=true)
          }
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.dt_stream,  dut.clockDomain, ref_dt(l), DUT_dt(l),  1, TP, 1, CH,  CP, info="dt stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.xBC_stream,  dut.clockDomain, ref_xBC(l), DUT_xBC(l),  1, TP, 1, CC, CP, info="xBC stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.z_stream,  dut.clockDomain, ref_z(l), DUT_z(l),  1, TP, 1, C2, CP, info="z stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.out_stream,  dut.clockDomain, out(l), DUT_out(l),  1, TP, 1, CO, CP, info="out stream", verbose=true)
        }
        // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)
      simSuccess()
    }
}


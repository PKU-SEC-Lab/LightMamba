import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class HT_STATE_Blackbox extends BlackBox {
  val top_name: String = "HT_STATE"
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
    val state_in_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("state_in_stream", verilog_file_path)))
    val state_in_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("state_in_s_stream", verilog_file_path)))
    val ht_in_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht_in_stream", verilog_file_path)))
    val ht_in_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht_in_s_stream", verilog_file_path)))
    val ht_out_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht_out_stream", verilog_file_path)))
    val ht_out_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("ht_out_s_stream", verilog_file_path)))
    val state_out_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("state_out_stream", verilog_file_path)))
    val state_out_s_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("state_out_s_stream", verilog_file_path)))
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

class HT_STATE extends Component {
  val top_name: String = "HT_STATE"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new HT_STATE_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val state_in_stream: Axi4Stream = slave(Axi4Stream(black_box.io.state_in_stream.config.to_std_config()))
    val state_in_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.state_in_s_stream.config.to_std_config()))
    val ht_in_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht_in_stream.config.to_std_config()))
    val ht_in_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht_in_s_stream.config.to_std_config()))
    val ht_out_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht_out_stream.config.to_std_config()))
    val ht_out_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.ht_out_s_stream.config.to_std_config()))
    val state_out_stream: Axi4Stream = master(Axi4Stream(black_box.io.state_out_stream.config.to_std_config()))
    val state_out_s_stream: Axi4Stream = master(Axi4Stream(black_box.io.state_out_s_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.state_in_stream.connect2std(io.state_in_stream)
  black_box.io.state_in_s_stream.connect2std(io.state_in_s_stream)
  black_box.io.ht_in_stream.connect2std(io.ht_in_stream)
  black_box.io.ht_in_s_stream.connect2std(io.ht_in_s_stream)
  black_box.io.ht_out_stream.connect2std(io.ht_out_stream)
  black_box.io.ht_out_s_stream.connect2std(io.ht_out_s_stream)
  black_box.io.state_out_stream.connect2std(io.state_out_stream)
  black_box.io.state_out_s_stream.connect2std(io.state_out_s_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.state_in_stream)
  Axi4StreamSpecRenamer(io.state_in_s_stream)
  Axi4StreamSpecRenamer(io.ht_in_stream)
  Axi4StreamSpecRenamer(io.ht_in_s_stream)
  Axi4StreamSpecRenamer(io.ht_out_stream)
  Axi4StreamSpecRenamer(io.ht_out_s_stream)
  Axi4StreamSpecRenamer(io.state_out_stream)
  Axi4StreamSpecRenamer(io.state_out_s_stream)
}

object simulate_ht_state extends App {
  redirect_std("HT_STATE.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new HT_STATE)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new HT_STATE)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      //      val L = 32
      val L = 2

      val T_LOAD = 512
      val T = 1
      val TP = 1

      val C = 5120
      val CP = G
      val N = 128
      val NP = G
      val NP2       = NP / 2;
      val CT = C / CP
      val NT = N / CP
      val NTT       = N / NP2;
      val CTT       = CT / CP;




      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val ht1_q = read_multi_int64_files(format_str, L, "/ht1_q0_layer", N * C)
      val ht1_s = read_multi_int64_files(format_str, L, "/ht1_s0_layer", N * CT)
      val ht2_q = read_multi_int64_files(format_str, L, "/ht1_q1_layer", N * C)
      val ht2_s = read_multi_int64_files(format_str, L, "/ht1_s1_layer", N * CT)

      val ref_state_in_q  = Array.ofDim[Long](L, N * C)
      val ref_state_in_s  = Array.ofDim[Long](L, N * CT)
      for (l <- 0 until L) {
        for (ct <- 0 until CT) {
          for (nt <- 0 until NTT) {
            for (np <- 0 until NP2) {
              for (cp <- 0 until CP) {
                ref_state_in_q(l)((ct*NTT+nt)*NP2*CP+np*CP+cp) = ht1_q(l)(ct*N*CP+(nt*NP2+np)*CP+cp)
              }
            }
          }
        }
      }
      for (l <- 0 until L) {
        for (ct <- 0 until CTT) {
          for (nt <- 0 until NT) {
            for (np <- 0 until NP) {
              for (cp <- 0 until CP) {
                ref_state_in_s(l)((ct*NT+nt)*NP*CP+np*CP+cp) = ht1_s(l)((ct*CP+cp)*N+nt*NP+np)
              }
            }
          }
        }
      }

      val ref_state_out_q  = Array.ofDim[Long](L, N * C)
      val ref_state_out_s  = Array.ofDim[Long](L, N * CT)
      for (l <- 0 until L) {
        for (ct <- 0 until CT) {
          for (nt <- 0 until NTT) {
            for (np <- 0 until NP2) {
              for (cp <- 0 until CP) {
                ref_state_out_q(l)((ct*NTT+nt)*NP2*CP+np*CP+cp) = ht2_q(l)(ct*N*CP+(nt*NP2+np)*CP+cp)
              }
            }
          }
        }
      }
      for (l <- 0 until L) {
        for (ct <- 0 until CTT) {
          for (nt <- 0 until NT) {
            for (np <- 0 until NP) {
              for (cp <- 0 until CP) {
                ref_state_out_s(l)((ct*NT+nt)*NP*CP+np*CP+cp) = ht2_s(l)((ct*CP+cp)*N+nt*NP+np)
              }
            }
          }
        }
      }

      // dut arrays
      val DUT_o_Q  = Array.ofDim[Long](L, N * C)
      val DUT_o_S  = Array.ofDim[Long](L, N * CT)
      val DUT_state_out_Q  = Array.ofDim[Long](L, N * C)
      val DUT_state_out_S  = Array.ofDim[Long](L, N * CT)

      // init ap_ctrl and streams
      init_i_stream(dut.io.state_in_stream)
      init_i_stream(dut.io.state_in_s_stream)
      init_i_stream(dut.io.ht_in_stream)
      init_i_stream(dut.io.ht_in_s_stream)
      init_o_stream(dut.io.ht_out_stream)
      init_o_stream(dut.io.ht_out_s_stream)
      init_o_stream(dut.io.state_out_stream)
      init_o_stream(dut.io.state_out_s_stream)
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
            array2stream(dut.io.state_in_stream, dut.clockDomain, ref_state_in_q(l), 1, 1, TP, 1, C*N,  NP2*CP, info="state_in stream", verbose=true)
            array2stream(dut.io.state_in_s_stream, dut.clockDomain, ref_state_in_s(l), 1, 1, TP, 1, CT*N,  NP*CP, info="state_in_s stream",verbose=true)
          }
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.ht_in_stream, dut.clockDomain, ht2_q(l), 1, 1, TP, 1, C*N,  CP, info="ht stream", verbose=true,DELAY=20480+1280)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.ht_in_s_stream, dut.clockDomain, ht2_s(l), 1, 1, TP, 1, CT*N,  1, info="ht_s stream",DELAY=20480+1280)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.ht_out_stream,  dut.clockDomain, ht1_q(l), DUT_o_Q(l),  1, TP, 1, C*N,  CP, info="o stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.ht_out_s_stream,  dut.clockDomain, ht1_s(l), DUT_o_S(l),  1, TP, 1, CT*N, 1, info="o_s stream",is_signed = false)
        } ,
        fork {
          for (l <- 0 until L) {
            stream2array(dut.io.state_out_stream,  dut.clockDomain, ref_state_out_q(l), DUT_state_out_Q(l),  1, TP, 1, C*N,  NP2*CP, info="state_out stream", verbose=true)
            stream2array(dut.io.state_out_s_stream,  dut.clockDomain, ref_state_out_s(l), DUT_state_out_S(l),  1, TP, 1, CT*N, NP*CP, info="state_out_s stream", verbose=true ,is_signed = false)
          }
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_state_out_Q.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


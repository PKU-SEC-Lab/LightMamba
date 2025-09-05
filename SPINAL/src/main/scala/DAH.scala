import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// FIXME: compared with utils.SimpleNode, SILU_EM_QUANT requires l input, which indicates the order of layer
class DAH_Blackbox extends BlackBox {
  val top_name: String = "DAH"
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
    val dA_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dA_stream", verilog_file_path)))
    val dA_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("dA_s_stream", verilog_file_path)))
    val ht_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht_stream", verilog_file_path)))
    val ht_s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("ht_s_stream", verilog_file_path)))
    val o_stream: BlackboxAxis = master(BlackboxAxis(BlackboxAxisConfig("o_stream", verilog_file_path)))
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

class DAH extends Component {
  val top_name: String = "DAH"
  setDefinitionName(top_name + "_wrapper")
  private val black_box = new DAH_Blackbox
  val io = new Bundle {
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val dA_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dA_stream.config.to_std_config()))
    val dA_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.dA_s_stream.config.to_std_config()))
    val ht_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht_stream.config.to_std_config()))
    val ht_s_stream: Axi4Stream = slave(Axi4Stream(black_box.io.ht_s_stream.config.to_std_config()))
    val o_stream: Axi4Stream = master(Axi4Stream(black_box.io.o_stream.config.to_std_config()))
  }
  noIoPrefix()
  // create manager
  val manager = new Manager
  manager.io.signals <> io.signals
  // connect interface
  manager.io.ap_ctrl <> black_box.io.ap_ctrl
  black_box.io.dA_stream.connect2std(io.dA_stream)
  black_box.io.dA_s_stream.connect2std(io.dA_s_stream)
  black_box.io.ht_stream.connect2std(io.ht_stream)
  black_box.io.ht_s_stream.connect2std(io.ht_s_stream)
  black_box.io.o_stream.connect2std(io.o_stream)
  // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
  Axi4StreamSpecRenamer(io.dA_stream)
  Axi4StreamSpecRenamer(io.dA_s_stream)
  Axi4StreamSpecRenamer(io.ht_stream)
  Axi4StreamSpecRenamer(io.ht_s_stream)
  Axi4StreamSpecRenamer(io.o_stream)
}

object simulate_dAh extends App {
  redirect_std("DAH.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new DAH)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new DAH)
    .doSimUntilVoid { dut =>
      // some hyper parameters

      val G = 8

      //      val L = 32
      val L = 2

      val T_LOAD = 512
      val T = 1
      val TP = 1

      val C = 80
      val N = 128
      val P = 64
      val CP = G


      val CT = C / CP
      val NT = N / CP
      val PT = P / CP

      val data_path_prefix = "D:/file/project/git/light-mamba/ref/activations"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val dA_q = read_multi_int64_files(format_str, L, "/dA_exp_q_layer", T_LOAD * C)
      val dA_s = read_multi_int64_files(format_str, L, "/dA_exp_s_layer", T_LOAD * CT)
      val ht_q = read_multi_int64_files(format_str, L, "/ht1_q0_layer", T * C*P*N)
      val ht_s = read_multi_int64_files(format_str, L, "/ht1_s0_layer", T * C*PT*N)
      val dAh = read_multi_int64_files(format_str, L, "/dAh1_layer", T * C*P*N)

      val REF_DA_Q = Array.ofDim[Long](L, T * C)
      val REF_DA_S = Array.ofDim[Long](L, T * CT)

      // dut arrays
      val DUT_dAh  = Array.ofDim[Long](L, T * C*P*N)


      for (l <- 0 until L) {
        for (t <- 0 until TP) {
          for (c <- 0 until C) {
            REF_DA_Q(l)(t*C + c) = dA_q(l)(1*C + c)
          }
        }
      }
      for (l <- 0 until L) {
        for (t <- 0 until TP) {
          for (ct <- 0 until CT) {
            REF_DA_S(l)(t*CT + ct) = dA_s(l)(1*CT + ct)
          }
        }
      }


      // init ap_ctrl and streams
      init_i_stream(dut.io.dA_stream)
      init_i_stream(dut.io.dA_s_stream)
      init_i_stream(dut.io.ht_stream)
      init_i_stream(dut.io.ht_s_stream)
      init_o_stream(dut.io.o_stream)
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
          for (l <- 0 until L) array2stream(dut.io.dA_stream, dut.clockDomain, REF_DA_Q(l), 1, 1, TP, 1, C,  CP, info="dA stream", verbose=true, WAIT=320)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.dA_s_stream, dut.clockDomain, REF_DA_S(l), 1, 1, TP, 1, CT,  1, info="dA_s stream", WAIT=320)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.ht_stream, dut.clockDomain, ht_q(l), 1, 1, TP, 1, C*P*N,  CP, info="ht stream", verbose=true)
        },
        fork {
          for (l <- 0 until L) array2stream(dut.io.ht_s_stream, dut.clockDomain, ht_s(l), 1, 1, TP, 1, C*PT*N,  1, info="ht_s stream")
        },
        fork {
          for (l <- 0 until L) stream2array(dut.io.o_stream,  dut.clockDomain, dAh(l), DUT_dAh(l),  1, TP, 1, C*P*N,  CP, info="o stream", verbose=true)
        }
        // @formatter:on
      ).foreach(_.join())

      // calculate max of XM_S
      val max_XM_S = DUT_dAh.flatten.max
      println(s"max_XM_S = $max_XM_S")

      simSuccess()
    }
}


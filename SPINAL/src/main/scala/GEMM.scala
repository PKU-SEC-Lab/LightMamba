import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// GEMM, for Q K V O U G D
class GEMM_Blackbox extends BlackBox {
    val top_name: String = "GEMM"
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
        val i_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("i_stream", verilog_file_path)))
        val w_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("w_stream", verilog_file_path)))
        val s_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("s_stream", verilog_file_path)))
        val s1_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("s1_stream", verilog_file_path)))
        val s2_stream: BlackboxAxis = slave(BlackboxAxis(BlackboxAxisConfig("s2_stream", verilog_file_path)))
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

class GEMM extends Component {
    val top_name: String = "GEMM"
    setDefinitionName(top_name + "_wrapper")
    private val black_box = new GEMM_Blackbox
    val io = new Bundle {
        // @formatter:off
    val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
    val i_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.i_stream .config.to_std_config()))
    val w_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.w_stream .config.to_std_config()))
    val s_stream:  Axi4Stream = slave (Axi4Stream(black_box.io.s_stream .config.to_std_config()))
    val s1_stream: Axi4Stream = slave (Axi4Stream(black_box.io.s1_stream.config.to_std_config()))
    val s2_stream: Axi4Stream = slave (Axi4Stream(black_box.io.s2_stream.config.to_std_config()))
    val o_stream:  Axi4Stream = master(Axi4Stream(black_box.io.o_stream .config.to_std_config()))
    // @formatter:on
    }
    noIoPrefix()
    // create manager
    val manager = new Manager
    manager.io.signals <> io.signals
    // connect interface
    manager.io.ap_ctrl <> black_box.io.ap_ctrl
    black_box.io.i_stream.connect2std(io.i_stream)
    black_box.io.w_stream.connect2std(io.w_stream)
    black_box.io.s_stream.connect2std(io.s_stream)
    black_box.io.s1_stream.connect2std(io.s1_stream)
    black_box.io.s2_stream.connect2std(io.s2_stream)
    black_box.io.o_stream.connect2std(io.o_stream)
    // FIXME: here, renaming is for Vivado flow compatibility, modify the name therefore the name can be recognized by Vivado
    Axi4StreamSpecRenamer(io.i_stream)
    Axi4StreamSpecRenamer(io.w_stream)
    Axi4StreamSpecRenamer(io.s_stream)
    Axi4StreamSpecRenamer(io.s1_stream)
    Axi4StreamSpecRenamer(io.s2_stream)
    Axi4StreamSpecRenamer(io.o_stream)
}

object simulate_gemm extends App {
    // spinal config
    val spinalConfig: SpinalConfig = SpinalConfig(
        defaultConfigForClockDomains = ClockDomainConfig(
            resetKind = SYNC, resetActiveLevel = LOW
        )
    )

    redirect_std("GEMM.log")

    spinalConfig.generateVerilog(new GEMM)

    // do simulation
    SimConfig
        .withConfig(spinalConfig)
        .withFstWave
        .withWaveDepth(1)
        .allOptimisation
        .withVerilator
        .addSimulatorFlag("--unroll-count 1024")
        .addSimulatorFlag("-j 16")
        .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
        //    .addSimulatorFlag("-threads 16")
        .compile(new GEMM)
        .doSimUntilVoid { dut =>


          val L = 2

          val T = 1
          val TP = 1

          val CI1 = 2560
          val CI2 = 5120
          val CO1 = 10576
          val CO2 = 2560
          val CP = 8
          val G = 128
          val P = 64
          val C2 = 5120
          val N = 128

          val CIT1 = CI1 / CP
          val CIT2 = CI2 / CP
          val COT1 = CO1 / CP
          val COT2 = CO2 / CP
          val WT1 = CI1 / G
          val WT2 = CI2 / G
          val C2T = C2/CP
          val NT = N/CP


          val data_path_prefix_a = "D:/file/project/git/light-mamba/ref"
          val data_path_prefix = "D:/file/project/git/mamba_cpp/cmake-build-debug/bin"
          val format_str_a = s"$data_path_prefix_a%s%d.bin"
          val format_str = s"$data_path_prefix%s%d.bin"
          // @formatter:off
          // ref arrays
          val XLN1_Q = read_multi_int64_files(format_str_a, L, "/activations/rms1_q_layer", T * CI1)
          val XLN1_S = read_multi_int64_files(format_str_a, L, "/activations/rms1_s_layer", T * CIT1)
          val XLN2_Q = read_multi_int64_files(format_str_a, L, "/activations/rms2_q_layer", T * CI2)
          val XLN2_S = read_multi_int64_files(format_str_a, L, "/activations/rms2_s_layer", T * CIT2)
          val WIN_Q = read_multi_int64_files(format_str, L, "/weights/in_proj_wq_layer", CO1 * CI1)
          val WIN_S1 = read_multi_int64_files(format_str, L, "/weights/in_proj_s1_layer", CO1 * WT1)
          val WIN_S2 = read_multi_int64_files(format_str, L, "/weights/in_proj_s2_layer", CO1 * WT1)
          val WOUT_Q = read_multi_int64_files(format_str, L, "/weights/out_proj_wq_layer", CO2 * CI2)
          val WOUT_S1 = read_multi_int64_files(format_str, L, "/weights/out_proj_s1_layer", CO2 * WT2)
          val WOUT_S2 = read_multi_int64_files(format_str, L, "/weights/out_proj_s2_layer", CO2 * WT2)

          val IN = read_multi_int64_files(format_str_a, L, "/activations/zxbcdt_layer", T * CO1)
          val OUT = read_multi_int64_files(format_str_a, L, "/activations/out_proj_layer", T * CO2)

          val DUT_IN  = Array.ofDim[Long](L, T * CO1)
          val DUT_OUT  = Array.ofDim[Long](L, T * CO2)

          val REF_WIN_Q  = Array.ofDim[Long](L, CO1 * CI1)
          val REF_WIN_S1  = Array.ofDim[Long](L, CO1 * WT1)
          val REF_WIN_S2  = Array.ofDim[Long](L, CO1 * WT1)
          val REF_IN  = Array.ofDim[Long](L, T * CO1)

          for (l <- 0 until L) {
            for (cot <- 0 until COT1) {
              var ct=0
              if (cot<C2T) {
                val group_id=(cot+1)/P
                val last_id=(cot+1)%P
                val id_prefix=2*NT+group_id*(2*P+1)-1
                if (last_id>0) {
                  ct=id_prefix+1+2*last_id
                }
                else {
                  ct=id_prefix
                }
              }
              else if (cot<2*C2T) {
                val group_id=(cot+1-C2T)/P
                val last_id=(cot+1-C2T)%P
                val id_prefix=2*NT+group_id*(2*P+1)-2
                if (last_id>0) {
                  ct=id_prefix+1+2*last_id
                }
                else {
                  ct=id_prefix
                }
              }
              else if (cot<2*C2T+2*NT) {
                ct=cot-2*C2T
              }
              else {
                val group_id=cot-2*C2T-2*NT
                ct=2*NT+group_id*(2*P+1)
              }
              for (cp <- 0 until CP) {
                for (gt <- 0 until WT1) {
                  REF_WIN_S1(l)((ct*CP+cp)*WT1+gt)=WIN_S1(l)((cot*CP+cp)*WT1+gt)
                  REF_WIN_S2(l)((ct*CP+cp)*WT1+gt)=WIN_S2(l)((cot*CP+cp)*WT1+gt)
                }
                for (c <- 0 until CI1) {
                  REF_WIN_Q(l)((ct*CP+cp)*CI1+c)=WIN_Q(l)((cot*CP+cp)*CI1+c)
                }
                REF_IN(l)(ct*CP+cp)=IN(l)(cot*CP+cp)
              }
            }
          }


          // initialize streams
        init_i_stream(dut.io.i_stream)
        init_i_stream(dut.io.w_stream)
        init_i_stream(dut.io.s_stream)
        init_i_stream(dut.io.s1_stream)
        init_i_stream(dut.io.s2_stream)
        init_o_stream(dut.io.o_stream)
        init_daisy_chain(dut.io.signals)
        // fork clock
        init_clock(dut.clockDomain, 10)
            // threads
            // @formatter:off
      Array(
        fork{
          dut.io.signals.I.L_BEGIN #= 0
          dut.io.signals.I.L_CLOSE #= L
          // delay 20 cycles to make sure the signals are set
          dut.clockDomain.waitSampling(20)
          // launch with trigger
          dut.io.signals.I.T #= true
          dut.clockDomain.waitSampling()
          dut.io.signals.I.T #= false
        },
        // quantized input data streams
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.i_stream, dut.clockDomain, XLN1_Q(l), COT1,  1, T, TP, CI1,  CP, info = "XLN1_Q")
            array2stream(dut.io.i_stream, dut.clockDomain, XLN2_Q(l), COT2,  1, T, TP, CI2,  CP, info = "XLN2_Q")
          }
        },
        // quantized input scales streams
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.s_stream, dut.clockDomain, XLN1_S(l), COT1,  1, T, TP, CIT1,  1, info = "XLN1_S")
            array2stream(dut.io.s_stream, dut.clockDomain, XLN2_S(l), COT2,  1, T, TP, CIT2,  1, info = "XLN2_S")
          }
        },
        // quantized weights streams
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.w_stream, dut.clockDomain, REF_WIN_Q(l), 1, 1, CO1,  CP, CI1,  CP, verbose = true, info = "WQ1")
            array2stream(dut.io.w_stream, dut.clockDomain, WOUT_Q(l), 1, 1, CO2,  CP, CI2,  CP, verbose = true, info = "WQ2")
          }
        },
        // quantized weights scales streams 1
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.s1_stream, dut.clockDomain, REF_WIN_S1(l), 1, 1, CO1,  CP, WT1,  1, info = "WS1_1")
            array2stream(dut.io.s1_stream, dut.clockDomain, WOUT_S1(l), 1, 1, CO2,  CP, WT2,  1, info = "WS1_2")
          }
        },
        // quantized weights scales streams 2
        fork {
          for (l <- 0 until L) {
            array2stream(dut.io.s2_stream, dut.clockDomain, REF_WIN_S2(l), 1, 1, CO1,  CP, WT1,  1, info = "WS2_1")
            array2stream(dut.io.s2_stream, dut.clockDomain, WOUT_S2(l), 1, 1, CO2,  CP, WT2,  1, info = "WS2_2")
          }
        },
        // output streams
        fork {
          for (l <- 0 until L) {
            stream2array(dut.io.o_stream, dut.clockDomain, REF_IN(l), DUT_IN(l), 1, T, TP ,CO1,  CP, info = "IN")
            stream2array(dut.io.o_stream, dut.clockDomain, OUT(l), DUT_OUT(l), 1, T, TP, CO2,  CP, info = "OUT")
          }
        }
      ).foreach(_.join())
      // @formatter:on

            simSuccess()

        }
}


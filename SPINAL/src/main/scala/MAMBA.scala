import spinal.core.sim._
import spinal.core._
import spinal.lib._
import utils._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import scala.language.postfixOps

// gradually build up the LLAMA accelerator
class MAMBA extends Component {
  // @formatter:off
    val B_buffer      = new B_BUFFER()
    val C_buffer      = new C_BUFFER()
    val conv          = new CONV()
    val conv_state    = new CONV_STATE()
    val dAh           = new DAH()
    val dBu           = new DBU()
    val dtA           = new DTA()
    val dtadapt       = new DTADAPT()
    val dtB_quant     = new DTB_QUANT()
    val exp_quant     = new EXP_QUANT()
    val gemm          = new GEMM()
    val gemm_demux    = new GEMM_DEMUX()
    val gemm_mux      = new GEMM_MUX()
    val ht_add_quant  = new HT_ADD_QUANT()
    val ht_state      = new HT_STATE()
    val htC_quant     = new HTC_QUANT()
    val quant_conv    = new QUANT_CONV()
    val residual      = new RESIDUAL()
    val rms_quant_1   = new RMSNORM_QUANT_1()
    val rms_quant_2   = new RMSNORM_QUANT_2()
    val silu_demux    = new SILU_DEMUX()
    val silu_mux      = new SILU_MUX()
    val silu_quant    = new SILU_QUANT()
    val ud            = new UD()
    val yz            = new YZ()

    val io = new Bundle {
      val signals: DaisyChain[ManagerSignals] = DaisyChain(ManagerSignals())
      val x_stream:     Axi4Stream = slave (Axi4Stream(residual       .io.x_stream           .config))
      val w_stream:     Axi4Stream = slave (Axi4Stream(gemm           .io.w_stream           .config))
      val s1_stream:    Axi4Stream = slave (Axi4Stream(gemm           .io.s1_stream          .config))
      val s2_stream:    Axi4Stream = slave (Axi4Stream(gemm           .io.s2_stream          .config))
      val y_stream:     Axi4Stream = master(Axi4Stream(residual       .io.y_stream           .config))
      val cq_stream:    Axi4Stream = slave (Axi4Stream(conv_state     .io.conv_stream        .config))
      val cs_stream:    Axi4Stream = slave (Axi4Stream(conv_state     .io.conv_s_stream      .config))
      val cq2_stream:   Axi4Stream = master(Axi4Stream(conv_state     .io.conv_state_stream  .config))
      val cs2_stream:   Axi4Stream = master(Axi4Stream(conv_state     .io.conv_state_s_stream.config))
      val hq_stream:    Axi4Stream = slave (Axi4Stream(ht_state       .io.state_in_stream    .config))
      val hs_stream:    Axi4Stream = slave (Axi4Stream(ht_state       .io.state_in_s_stream  .config))
      val hq2_stream:   Axi4Stream = master(Axi4Stream(ht_state       .io.state_out_stream   .config))
      val hs2_stream:   Axi4Stream = master(Axi4Stream(ht_state       .io.state_out_s_stream .config))
    }
    noIoPrefix()
    // connect signals
                   io.signals.I               <>      B_buffer        .io.signals.I
    B_buffer      .io.signals.O               <>      C_buffer        .io.signals.I
    C_buffer      .io.signals.O               <>      conv            .io.signals.I
    conv          .io.signals.O               <>      conv_state      .io.signals.I
    conv_state    .io.signals.O               <>      dAh             .io.signals.I
    dAh           .io.signals.O               <>      dBu             .io.signals.I
    dBu           .io.signals.O               <>      dtA             .io.signals.I
    dtA           .io.signals.O               <>      dtadapt         .io.signals.I
    dtadapt       .io.signals.O               <>      dtB_quant       .io.signals.I
    dtB_quant     .io.signals.O               <>      exp_quant       .io.signals.I
    exp_quant     .io.signals.O               <>      gemm            .io.signals.I
    gemm          .io.signals.O               <>      gemm_demux      .io.signals.I
    gemm_demux    .io.signals.O               <>      gemm_mux        .io.signals.I
    gemm_mux      .io.signals.O               <>      ht_add_quant    .io.signals.I
    ht_add_quant  .io.signals.O               <>      ht_state        .io.signals.I
    ht_state      .io.signals.O               <>      htC_quant       .io.signals.I
    htC_quant     .io.signals.O               <>      quant_conv      .io.signals.I
    quant_conv    .io.signals.O               <>      residual        .io.signals.I
    residual      .io.signals.O               <>      rms_quant_1     .io.signals.I
    rms_quant_1   .io.signals.O               <>      rms_quant_2     .io.signals.I
    rms_quant_2   .io.signals.O               <>      silu_demux      .io.signals.I
    silu_demux    .io.signals.O               <>      silu_mux        .io.signals.I
    silu_mux      .io.signals.O               <>      silu_quant      .io.signals.I
    silu_quant    .io.signals.O               <>      ud              .io.signals.I
    ud            .io.signals.O               <>      yz              .io.signals.I
    yz            .io.signals.O               <>                       io.signals.O

    // connect streams
                   io.x_stream            .queue(8)    <>      residual        .io.x_stream
                   io.w_stream            .queue(8)    <>      gemm            .io.w_stream
                   io.s1_stream           .queue(8)    <>      gemm            .io.s1_stream
                   io.s2_stream           .queue(8)    <>      gemm            .io.s2_stream
                   io.cq_stream           .queue(8)    <>      conv_state      .io.conv_stream
                   io.cs_stream           .queue(8)    <>      conv_state      .io.conv_s_stream
                   io.hq_stream           .queue(8)    <>      ht_state        .io.state_in_stream
                   io.hs_stream           .queue(8)    <>      ht_state        .io.state_in_s_stream
    B_buffer      .io.q_stream            .queue(8)    <>      dtB_quant       .io.B_stream
    B_buffer      .io.s_stream            .queue(8)    <>      dtB_quant       .io.B_s_stream
    C_buffer      .io.q_stream            .queue(8)    <>      htC_quant       .io.C_stream
    C_buffer      .io.s_stream            .queue(8)    <>      htC_quant       .io.C_s_stream
    conv          .io.o_stream            .queue(8)    <>      silu_mux        .io.xBC_stream
    conv_state    .io.o_stream            .queue(8)    <>      conv            .io.i_stream
    conv_state    .io.o_s_stream          .queue(8)    <>      conv            .io.s_stream
    conv_state    .io.w_stream            .queue(8)    <>      conv            .io.w_stream
    conv_state    .io.w_s_stream          .queue(8)    <>      conv            .io.w_s_stream
    conv_state    .io.conv_state_stream   .queue(8)    <>                       io.cq2_stream
    conv_state    .io.conv_state_s_stream .queue(8)    <>                       io.cs2_stream
    dAh           .io.o_stream            .queue(8)    <>      ht_add_quant    .io.dAh_stream
    dBu           .io.o_stream            .queue(8)    <>      ht_add_quant    .io.dBu_stream
    dtA           .io.o_stream            .queue(8)    <>      exp_quant       .io.i_stream
    dtadapt       .io.o_stream            .queue(8)    <>      dtA             .io.i_stream
    dtadapt       .io.o_s_stream          .queue(8)    <>      dtA             .io.s_stream
    dtadapt       .io.o_stream2           .queue(8)    <>      dtB_quant       .io.dt_stream
    dtadapt       .io.o_s_stream2         .queue(8)    <>      dtB_quant       .io.dt_s_stream
    dtB_quant     .io.o_stream            .queue(8)    <>      dBu             .io.dB_stream
    dtB_quant     .io.o_s_stream          .queue(8)    <>      dBu             .io.dB_s_stream
    exp_quant     .io.o_stream            .queue(8)    <>      dAh             .io.dA_stream
    exp_quant     .io.o_s_stream          .queue(8)    <>      dAh             .io.dA_s_stream
    gemm          .io.o_stream            .queue(8)    <>      gemm_demux      .io.gemm_stream
    gemm_demux    .io.dt_stream           .queue(8)    <>      dtadapt         .io.i_stream
    gemm_demux    .io.xBC_stream          .queue(8)    <>      quant_conv      .io.i_stream
    gemm_demux    .io.z_stream            .queue(8)    <>      silu_mux        .io.z_stream
    gemm_demux    .io.out_stream          .queue(8)    <>      residual        .io.res_i_stream
    gemm_mux      .io.q_stream            .queue(8)    <>      gemm            .io.i_stream
    gemm_mux      .io.s_stream            .queue(512)  <>      gemm            .io.s_stream
    ht_add_quant  .io.ht1_q_stream        .queue(8)    <>      ht_state        .io.ht_in_stream
    ht_add_quant  .io.ht1_s_stream        .queue(8)    <>      ht_state        .io.ht_in_s_stream
    ht_add_quant  .io.ht2_q_stream        .queue(8)    <>      htC_quant       .io.ht_stream
    ht_add_quant  .io.ht2_s_stream        .queue(8)    <>      htC_quant       .io.ht_s_stream
    ht_state      .io.ht_out_stream       .queue(64)   <>      dAh             .io.ht_stream
    ht_state      .io.ht_out_s_stream     .queue(64)   <>      dAh             .io.ht_s_stream
    ht_state      .io.state_out_stream    .queue(8)    <>                       io.hq2_stream
    ht_state      .io.state_out_s_stream  .queue(8)    <>                       io.hs2_stream
    htC_quant     .io.o_q_stream          .queue(8)    <>      yz              .io.y_stream
    htC_quant     .io.o_s_stream          .queue(8)    <>      yz              .io.y_s_stream
    quant_conv    .io.o_stream            .queue(8)    <>      conv_state      .io.xBC_stream
    quant_conv    .io.o_s_stream          .queue(8)    <>      conv_state      .io.xBC_s_stream
    residual      .io.res_o_stream        .queue(8)    <>      rms_quant_1     .io.x_stream
    residual      .io.y_stream            .queue(8)    <>                       io.y_stream
    rms_quant_1   .io.xlnq_stream         .queue(8)    <>      gemm_mux        .io.xlnq1_stream
    rms_quant_1   .io.xlns_stream         .queue(8)    <>      gemm_mux        .io.xlns1_stream
    rms_quant_2   .io.xlnq_stream         .queue(8)    <>      gemm_mux        .io.xlnq2_stream
    rms_quant_2   .io.xlns_stream         .queue(8)    <>      gemm_mux        .io.xlns2_stream
    silu_demux    .io.x_stream            .queue(8)    <>      dBu             .io.u_stream
    silu_demux    .io.x_s_stream          .queue(8)    <>      dBu             .io.u_s_stream
    silu_demux    .io.x_stream2           .queue(8)    <>      ud              .io.i_stream
    silu_demux    .io.x_s_stream2         .queue(8)    <>      ud              .io.s_stream
    silu_demux    .io.B_stream            .queue(8)    <>      B_buffer        .io.i_stream
    silu_demux    .io.B_s_stream          .queue(8)    <>      B_buffer        .io.i_s_stream
    silu_demux    .io.C_stream            .queue(8)    <>      C_buffer        .io.i_stream
    silu_demux    .io.C_s_stream          .queue(8)    <>      C_buffer        .io.i_s_stream
    silu_demux    .io.z_stream            .queue(8)    <>      yz              .io.z_stream
    silu_demux    .io.z_s_stream          .queue(8)    <>      yz              .io.z_s_stream
    silu_mux      .io.silu_stream         .queue(8)    <>      silu_quant      .io.i_stream
    silu_quant    .io.out_stream          .queue(8)    <>      silu_demux      .io.silu_stream
    silu_quant    .io.out_s_stream        .queue(8)    <>      silu_demux      .io.silu_s_stream
    ud            .io.o_stream            .queue(8)    <>      htC_quant       .io.uD_stream
    yz            .io.o_stream            .queue(8)    <>      rms_quant_2     .io.x_stream

  // rename
    Axi4StreamSpecRenamer(io.x_stream)
    Axi4StreamSpecRenamer(io.w_stream)
    Axi4StreamSpecRenamer(io.s1_stream)
    Axi4StreamSpecRenamer(io.s2_stream)
    Axi4StreamSpecRenamer(io.y_stream)
    Axi4StreamSpecRenamer(io.cq_stream)
    Axi4StreamSpecRenamer(io.cs_stream)
    Axi4StreamSpecRenamer(io.cq2_stream)
    Axi4StreamSpecRenamer(io.cs2_stream)
    Axi4StreamSpecRenamer(io.hq_stream)
    Axi4StreamSpecRenamer(io.hs_stream)
    Axi4StreamSpecRenamer(io.hq2_stream)
    Axi4StreamSpecRenamer(io.hs2_stream)
  // @formatter:on
}

object simulate_mamba extends App {
  redirect_std("MAMBA.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new MAMBA)

  SimConfig
    .withConfig(spinalConfig)
    .withFstWave
    .withWaveDepth(2)
    .allOptimisation
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    .compile(new MAMBA)
    .doSimUntilVoid { dut =>
      // some hyper parameters


      val L = 2

      val T = 1
      val TP = 1 // used many places

      val CI1 = 2560
      val CI2 = 5120
      val CO1 = 10576
      val CO2 = 2560
      val CP = 8
      val G = 8
      val GW = 128
      val CC = 5376
      val C2 = 5120
      val CH = 80
      val C2C = C2+CC
      val N = 128
      val NP = G
      val NP2 = NP / 2;
      val P = 64

      val NT = N/CP
      val CHT = CH/CP
      val C2CT = C2C/CP
      val CCT = CC/CP
      val C2T = C2/CP
      val CIT1 = CI1 / CP
      val CIT2 = CI2 / CP
      val COT1 = CO1 / CP
      val COT2 = CO2 / CP
      val WT1 = CI1 / GW
      val WT2 = CI2 / GW

      val STATE_P = 32
      val STATE_P_S = 64
      val D=4
      val ST = D * CC / STATE_P
      val ST_S = D * CCT / STATE_P_S

      val data_path_prefix = "D:/file/project/git/light-mamba/ref"
      val format_str = s"$data_path_prefix%s%d.bin"
      // @formatter:off
      // ref arrays
      val ref_x = read_multi_int64_files(format_str, L, "/activations/before_rms1_layer", 4 * CI1)
      val ref_y = read_multi_int64_files(format_str, L, "/activations/output_layer", 4 * CI1)
      val w_q = read_multi_int64_files(format_str, L, "/weights/conv_wq_layer", D * CC)
      val w_s = read_multi_int64_files(format_str, L, "/weights/conv_ws_layer", D * CCT)
      val REF_X  = Array.ofDim[Long](T * CI1)
      for (c <- 0 until CI1) {
        REF_X(c)=ref_x(0)(3*CI1+c)
      }
      val REF_Y  = Array.ofDim[Long](T * CI1)
      for (c <- 0 until CI1) {
        REF_Y(c)=ref_y(L-1)(3*CI1+c)
      }


      val ref_w_q  = Array.ofDim[Long](L, 4 * CC)
      val ref_w_s  = Array.ofDim[Long](L, 4 * CCT)
      // @formatter:off
      for (l <- 0 until L) {
        for (ct <- 0 until CCT) {
          var ct_cur=0
          if(ct<NT*2) {
            ct_cur=ct+C2T
          }
          else {
            ct_cur=ct-2*NT
          }
          for (d <- 0 until D) {
            for (cp <- 0 until CP) {
              ref_w_q(l)(ct*D*CP+d*CP+cp) = w_q(l)(d*CC+ct_cur*CP+cp)
            }
            ref_w_s(l)(ct*D+d) = w_s(l)(d*CCT+ct_cur)
          }
        }
      }

      val WIN_Q = read_multi_int64_files(format_str, L, "/weights/in_proj_wq_layer", CO1 * CI1)
      val WIN_S1 = read_multi_int64_files(format_str, L, "/weights/in_proj_s1_layer", CO1 * WT1)
      val WIN_S2 = read_multi_int64_files(format_str, L, "/weights/in_proj_s2_layer", CO1 * WT1)
      val WOUT_Q = read_multi_int64_files(format_str, L, "/weights/out_proj_wq_layer", CO2 * CI2)
      val WOUT_S1 = read_multi_int64_files(format_str, L, "/weights/out_proj_s1_layer", CO2 * WT2)
      val WOUT_S2 = read_multi_int64_files(format_str, L, "/weights/out_proj_s2_layer", CO2 * WT2)

      val REF_WIN_Q  = Array.ofDim[Long](L, CO1 * CI1)
      val REF_WIN_S1  = Array.ofDim[Long](L, CO1 * WT1)
      val REF_WIN_S2  = Array.ofDim[Long](L, CO1 * WT1)


      val xBC_q = read_multi_int64_files(format_str, L, "/activations/xBC_q_layer", D * CC)
      val xBC_s = read_multi_int64_files(format_str, L, "/activations/xBC_s_layer", D * CCT)

      val REF_XBC_Q = Array.ofDim[Long](L, D * CC)
      val REF_XBC_S = Array.ofDim[Long](L, D * CCT)
      for (l <- 0 until L) {
        for (ct <- 0 until CCT) {
          var ct_cur=0
          if(ct<NT*2) {
            ct_cur=ct+C2T;
          }
          else {
            ct_cur=ct-2*NT;
          }
          for (d <- 0 until D) {
            for (cp <- 0 until CP) {
              REF_XBC_Q(l)(d*CC+ct*CP+cp) = xBC_q(l)(d*CC+ct_cur*CP+cp)
            }
            REF_XBC_S(l)(d*CCT+ct) = xBC_s(l)(d*CCT+ct_cur)
          }
        }
      }

      val ref_conv_q  = Array.ofDim[Long](L, D * CC)
      val ref_conv_s  = Array.ofDim[Long](L, D * CCT)
      for (l <- 0 until L) {
        for (ct <- 0 until ST) {
          for (cp <- 0 until STATE_P) {
            val index: Int=ct*STATE_P+cp
            val d2: Int=index/CP%D
            val ct2: Int=index/CP/D
            val cp2: Int=index%CP
            ref_conv_q(l)(index) = REF_XBC_Q(l)(d2*CC+ct2*CP+cp2)
          }
        }
        for (ct <- 0 until ST_S) {
          for (cp <- 0 until STATE_P_S) {
            val index: Int=ct*STATE_P_S+cp
            val d2: Int=index%D
            val ct2: Int=index/D
            ref_conv_s(l)(index) = REF_XBC_S(l)(d2*CCT+ct2)
          }
        }
      }

      val REF_XBC_IN_Q = Array.ofDim[Long](L, D * CC)
      val REF_XBC_IN_S = Array.ofDim[Long](L, D * CCT)
      for (l <- 0 until L) {
        for (ct <- 0 until CCT) {
          for (d <- 1 until D) {
            for (cp <- 0 until CP) {
              REF_XBC_IN_Q(l)(d*CC+ct*CP+cp) = REF_XBC_Q(l)((d-1)*CC+ct*CP+cp)
            }
            REF_XBC_IN_S(l)(d*CCT+ct) = REF_XBC_S(l)((d-1)*CCT+ct)
          }
        }
      }

      val ref_conv_in_q  = Array.ofDim[Long](L, D * CC)
      val ref_conv_in_s  = Array.ofDim[Long](L, D * CCT)
      for (l <- 0 until L) {
        for (ct <- 0 until ST) {
          for (cp <- 0 until STATE_P) {
            val index: Int=ct*STATE_P+cp
            val d2: Int=index/CP%D
            val ct2: Int=index/CP/D
            val cp2: Int=index%CP
            ref_conv_in_q(l)(index) = REF_XBC_IN_Q(l)(d2*CC+ct2*CP+cp2)
          }
        }
        for (ct <- 0 until ST_S) {
          for (cp <- 0 until STATE_P_S) {
            val index: Int=ct*STATE_P_S+cp
            val d2: Int=index%D
            val ct2: Int=index/D
            ref_conv_in_s(l)(index) = REF_XBC_IN_S(l)(d2*CCT+ct2)
          }
        }
      }

      val NTT       = N / NP2;
      val CTT       = C2T / CP;
      val ht1_q = read_multi_int64_files(format_str, L, "/activations/ht1_q2_layer", N * C2)
      val ht1_s = read_multi_int64_files(format_str, L, "/activations/ht1_s2_layer", N * C2T)
      val ht2_q = read_multi_int64_files(format_str, L, "/activations/ht1_q3_layer", N * C2)
      val ht2_s = read_multi_int64_files(format_str, L, "/activations/ht1_s3_layer", N * C2T)

      val ref_state_in_q  = Array.ofDim[Long](L, N * C2)
      val ref_state_in_s  = Array.ofDim[Long](L, N * C2T)
      val ref_state_out_q  = Array.ofDim[Long](L, N * C2)
      val ref_state_out_s  = Array.ofDim[Long](L, N * C2T)
      for (l <- 0 until L) {
        for (ct <- 0 until C2T) {
          for (nt <- 0 until NTT) {
            for (np <- 0 until NP2) {
              for (cp <- 0 until CP) {
                ref_state_in_q(l)((ct*NTT+nt)*NP2*CP+np*CP+cp) = ht1_q(l)(ct*N*CP+(nt*NP2+np)*CP+cp)
                ref_state_out_q(l)((ct*NTT+nt)*NP2*CP+np*CP+cp) = ht2_q(l)(ct*N*CP+(nt*NP2+np)*CP+cp)
              }
            }
          }
        }
        for (ct <- 0 until CTT) {
          for (nt <- 0 until NT) {
            for (np <- 0 until NP) {
              for (cp <- 0 until CP) {
                ref_state_in_s(l)((ct*NT+nt)*NP*CP+np*CP+cp) = ht1_s(l)((ct*CP+cp)*N+nt*NP+np)
                ref_state_out_s(l)((ct*NT+nt)*NP*CP+np*CP+cp) = ht2_s(l)((ct*CP+cp)*N+nt*NP+np)
              }
            }
          }
        }
      }

      val DUT_Y      = Array.ofDim[Long](T*CI1)
      val DUT_conv_Q  = Array.ofDim[Long](L, 4 * CC)
      val DUT_conv_S  = Array.ofDim[Long](L, 4 * CCT)
      val DUT_state_out_Q  = Array.ofDim[Long](L, N * C2)
      val DUT_state_out_S  = Array.ofDim[Long](L, N * C2T)

      //zxbcdt
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
          }
        }
      }


      // init ap_ctrl and streams
      init_i_stream(dut.io.x_stream)
      init_i_stream(dut.io.w_stream)
      init_i_stream(dut.io.s1_stream)
      init_i_stream(dut.io.s2_stream)
      init_o_stream(dut.io.y_stream)
      init_i_stream(dut.io.cq_stream)
      init_i_stream(dut.io.cs_stream)
      init_o_stream(dut.io.cq2_stream)
      init_o_stream(dut.io.cs2_stream)
      init_i_stream(dut.io.hq_stream)
      init_i_stream(dut.io.hs_stream)
      init_o_stream(dut.io.hq2_stream)
      init_o_stream(dut.io.hs2_stream)
      init_daisy_chain(dut.io.signals)

      // fork clock
      init_clock(dut.clockDomain, 10)

      // set parameter and trigger
      dut.io.signals.I.L_BEGIN #= 0
      dut.io.signals.I.L_CLOSE #= L
      dut.io.signals.I.POS #= 0
      // delay 20 cycles to make sure the signals are set
      dut.clockDomain.waitSampling(20)
      // launch with trigger
      dut.io.signals.I.T #= true
      dut.clockDomain.waitSampling()
      dut.io.signals.I.T #= false
      dut.clockDomain.waitSampling(20)



      // threads
      Array(
        // @formatter:off
                fork {
                  array2stream(dut.io.x_stream,     dut.clockDomain, REF_X,  1,  1, T, TP, CI1, CP,  info="x stream", verbose=true)
                },
                fork {
                  for (l <- 0 until L) {
                    array2stream(dut.io.cq_stream, dut.clockDomain, ref_conv_q(l), 1, 1, TP, 1, CC*4,  STATE_P, info="conv_in stream", verbose=true)
                    array2stream(dut.io.cs_stream, dut.clockDomain, ref_conv_s(l), 1, 1, TP, 1, CCT*4,  STATE_P_S, info="conv_in_s stream",verbose=true)
                    array2stream(dut.io.cq_stream, dut.clockDomain, ref_w_q(l), 1, 1, TP, 1, CC*4,  STATE_P, info="conv_w stream", verbose=true)
                    array2stream(dut.io.cs_stream, dut.clockDomain, ref_w_s(l), 1, 1, TP, 1, CCT*4,  STATE_P_S, info="conv_w_s stream",verbose=true)
                  }
                },
                fork {
                  for (l <- 0 until L) {
                    array2stream(dut.io.hq_stream, dut.clockDomain, ref_state_in_q(l), 1, 1, TP, 1, C2*N,  NP2*CP, info="state_in stream", verbose=true)
                    array2stream(dut.io.hs_stream, dut.clockDomain, ref_state_in_s(l), 1, 1, TP, 1, C2T*N,  NP*CP, info="state_in_s stream",verbose=true)
                  }
                },
                fork {
                    for (l <- 0 until L) {
                      array2stream(dut.io.w_stream, dut.clockDomain, REF_WIN_Q(l), 1, 1, CO1,  CP, CI1,  CP, verbose = true, info = "WQ1")
                      array2stream(dut.io.w_stream, dut.clockDomain, WOUT_Q(l), 1, 1, CO2,  CP, CI2,  CP, verbose = true, info = "WQ2")
                    }
                },
                fork {
                    for (l <- 0 until L) {
                      array2stream(dut.io.s1_stream, dut.clockDomain, REF_WIN_S1(l), 1, 1, CO1,  CP, WT1,  1, info = "WS1_1")
                      array2stream(dut.io.s1_stream, dut.clockDomain, WOUT_S1(l), 1, 1, CO2,  CP, WT2,  1, info = "WS1_2")
                    }
                },
                fork {
                    for (l <- 0 until L) {
                      array2stream(dut.io.s2_stream, dut.clockDomain, REF_WIN_S2(l), 1, 1, CO1,  CP, WT1,  1, info = "WS2_1")
                      array2stream(dut.io.s2_stream, dut.clockDomain, WOUT_S2(l), 1, 1, CO2,  CP, WT2,  1, info = "WS2_2")
                    }
                },
                fork {
                  for (l <- 0 until L) {
                    stream2array(dut.io.cq2_stream,  dut.clockDomain, ref_conv_in_q(l), DUT_conv_Q(l),  1, TP, 1, CC*4,  STATE_P, info="conv_out stream", verbose=true,compare=false)
                    stream2array(dut.io.cs2_stream,  dut.clockDomain, ref_conv_in_s(l), DUT_conv_S(l),  1, TP, 1, CCT*4, STATE_P_S, info="conv_out_s stream",verbose=true,is_signed = false,compare=false)
                  }
                },
                fork {
                  for (l <- 0 until L) {
                    stream2array(dut.io.hq2_stream,  dut.clockDomain, ref_state_out_q(l), DUT_state_out_Q(l),  1, TP, 1, C2*N,  NP2*CP, info="state_out stream", verbose=true,compare=false)
                    stream2array(dut.io.hs2_stream,  dut.clockDomain, ref_state_out_s(l), DUT_state_out_S(l),  1, TP, 1, C2T*N, NP*CP, info="state_out_s stream", verbose=true ,is_signed = false,compare=false)
                  }
                },
                fork {
                  stream2array(dut.io.y_stream,     dut.clockDomain, REF_Y,  DUT_Y,  1, 1, 1,   T*CI1, TP*CP,  info="y stream", verbose=true)
                }
                // @formatter:on
      ).foreach(_.join())

      // at end, with 100 cycles
      dut.clockDomain.waitSampling(100)

      simSuccess()
    }
}


object generate_mamba extends App {
  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC, resetActiveLevel = LOW
    )
  )
  spinalConfig.generateVerilog(new MAMBA).mergeRTLSource()
}

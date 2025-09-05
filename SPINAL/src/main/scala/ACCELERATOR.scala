import simulate_m_axi.spinalConfig
import spinal.core.sim._
import spinal.core._
import spinal.lib.bus.amba4.axi.sim.{AxiMemorySim, AxiMemorySimConfig}
import spinal.lib.bus.amba4.axi._
import spinal.lib._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4SpecRenamer}
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream
import utils._

import scala.language.postfixOps
import scala.reflect.ClassTag

class ACCELERATOR extends Component {
  // @formatter:off
  private val inst_mamba       = new MAMBA
  private val inst_m_axi       = new M_AXI
  private val inst_controller  = new Controller
  // @formatter:on

  val io = new Bundle {
    val axilite: AxiLite4 = slave(AxiLite4(inst_controller.io.axilite.config))
    val m_axi: Axi4 = master(Axi4(inst_m_axi.io.m_axi.config))
    val idle: Bool = out Bool()
  }
  noIoPrefix()

  // connect io signals
  io.axilite <> inst_controller.io.axilite
  io.m_axi <> inst_m_axi.io.m_axi
  io.idle <> inst_m_axi.io.idle
  // connect internal signals
  inst_controller.io.idle <> inst_m_axi.io.idle
  // connect daisy chain
  inst_controller.io.signals <> inst_m_axi.io.signals.I
  inst_m_axi.io.signals.O <> inst_mamba.io.signals.I

  // connect streams
  // @formatter:off
  inst_mamba.io.x_stream              <> inst_m_axi.io.x_stream
  inst_mamba.io.w_stream              <> inst_m_axi.io.wq_stream    .queue(512)
  inst_mamba.io.s1_stream             <> inst_m_axi.io.ws1_stream   .queue(512)
  inst_mamba.io.s2_stream             <> inst_m_axi.io.ws2_stream   .queue(512)
  inst_mamba.io.cq_stream             <> inst_m_axi.io.cq_stream    .queue(512)
  inst_mamba.io.cs_stream             <> inst_m_axi.io.cs_stream    .queue(512)
  inst_mamba.io.cq2_stream.queue(512) <> inst_m_axi.io.cq2_stream
  inst_mamba.io.cs2_stream.queue(512) <> inst_m_axi.io.cs2_stream
  inst_mamba.io.hq_stream             <> inst_m_axi.io.hq_stream    .queue(512)
  inst_mamba.io.hs_stream             <> inst_m_axi.io.hs_stream    .queue(512)
  inst_mamba.io.hq2_stream.queue(512) <> inst_m_axi.io.hq2_stream
  inst_mamba.io.hs2_stream.queue(512) <> inst_m_axi.io.hs2_stream
  inst_mamba.io.y_stream  .queue(512) <> inst_m_axi.io.y_stream
  // @formatter:on

  // rename
  Axi4SpecRenamer(io.m_axi)
  AxiLite4SpecRenamer(io.axilite)
}

object simulate_accelerator extends App {
  redirect_std("ACCELERATOR.log")

  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC,
      resetActiveLevel = LOW
    )
  )
  SpinalVerilog(spinalConfig)(new ACCELERATOR).mergeRTLSource()

  SimConfig
    .withConfig(spinalConfig)
    .allOptimisation
    .withFstWave
    .withWaveDepth(1)
    .withVerilator
    .addSimulatorFlag("--unroll-count 1024")
    .addSimulatorFlag("-j 16")
    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast --noassert")
    //    .addSimulatorFlag("-O3 --x-assign fast --x-initial fast")
    //    .addSimulatorFlag("-O3                 --x-initial fast")
    //    .addSimulatorFlag("-O3 --x-assign fast ")
    //    .addSimulatorFlag("-O3                 --x-initial fast --noassert")
    //    .addSimulatorFlag("-O3 --x-assign fast                  --noassert")
    //    .addSimulatorFlag("-O3")
    .compile(new ACCELERATOR)
    .doSimUntilVoid { dut =>
      // declare axilite driver and axi sim memory
      val drv = AddressSeparableAxiLite4Driver(dut.io.axilite, dut.clockDomain)
      val axi_sim = AxiMemorySim(dut.io.m_axi, dut.clockDomain, AxiMemorySimConfig())

      val L = 2

      val T = 1
      val TP = 1

      val C   = 2560
      val CI1 = 2560
      val CI2 = 5120
      val CO1 = 10576
      val CO2 = 2560
      val CP = 8
      val G = 128
      val P = 64

      val CC = 5376
      val C2 = 5120
      val N = 128
      val NT = N/CP
      val CCT = CC/CP
      val C2T = C2/CP
      val NP = CP
      val NP2       = NP / 2
      val D = 4

      val STATE_P = 32
      val STATE_P_S = 64


      val DW_WQ = 4
      val DW_WS = 3
      val DW_AQ     = 8
      val DW_AS     = 4
      val DW_MAXI = CP * CP * DW_WQ
      val BYTES_PER_PACK = DW_MAXI / 8
      val BYTES_PER_X = 32 / 8

      val CIT1 = CI1 / CP
      val CIT2 = CI2 / CP
      val COT1 = CO1 / CP
      val COT2 = CO2 / CP
      val WT1 = CI1 / G
      val WT2 = CI2 / G

      val ST = D * CC / STATE_P
      val ST_S = D * CCT / STATE_P_S

      val TT = T / TP
      val CT = C / CP

      // @formatter:off
      val NUM_W   = CI1 * CO1 + CI2 * CO2
      val NUM_WS  = NUM_W / G
      val NUM_X   = T*C

      // @formatter:on
      val C_CYCS=714
      val H_CYCS=21760

      // calculate the address for memory x and memory y
      // use 4GB
      //      val addr_x = 0x100000000L
      // use 4GB / 16
      val addr_w = 0
      val addr_x = 0x100000000L / 16
      val addr_y = addr_x + NUM_X * BYTES_PER_X
      val addr_c = addr_y + NUM_X * BYTES_PER_X
      val addr_h = addr_c + L*C_CYCS*2*BYTES_PER_PACK


      val data_path_prefix = "D:/file/project/git/light-mamba/ref"
      val format_str = s"$data_path_prefix%s%d.bin"

      // @formatter:off
      val WIN_Q = read_multi_int64_files(format_str, L, "/weights/in_proj_wq_layer", CO1 * CI1)
      val WIN_S1 = read_multi_int64_files(format_str, L, "/weights/in_proj_s1_layer", CO1 * WT1)
      val WIN_S2 = read_multi_int64_files(format_str, L, "/weights/in_proj_s2_layer", CO1 * WT1)
      val WOUT_Q = read_multi_int64_files(format_str, L, "/weights/out_proj_wq_layer", CO2 * CI2)
      val WOUT_S1 = read_multi_int64_files(format_str, L, "/weights/out_proj_s1_layer", CO2 * WT2)
      val WOUT_S2 = read_multi_int64_files(format_str, L, "/weights/out_proj_s2_layer", CO2 * WT2)
      val w_q = read_multi_int64_files(format_str, L, "/weights/conv_wq_layer", 4 * CC)
      val w_s = read_multi_int64_files(format_str, L, "/weights/conv_ws_layer", 4 * CCT)

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

      val REF_WIN_Q  = Array.ofDim[Long](L, CO1 * CI1)
      val REF_WIN_S1  = Array.ofDim[Long](L, CO1 * WT1)
      val REF_WIN_S2  = Array.ofDim[Long](L, CO1 * WT1)

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

      val MERGE_WQ  = Array.ofDim[Long](L, CO1 * CI1+CO2 * CI2)
      val MERGE_WS1  = Array.ofDim[Long](L, CO1 * WT1+CO2 * WT2)
      val MERGE_WS2  = Array.ofDim[Long](L, CO1 * WT1+CO2 * WT2)
      for (l <- 0 until L) {
        for (cot <- 0 until COT1) {
          for (cit <- 0 until CIT1) {
            val index_prefix=(cot*CIT1+cit)*CP*CP
            for (cop <- 0 until CP) {
              for (cip <- 0 until CP) {
                MERGE_WQ(l)(index_prefix+cop*CP+cip)=REF_WIN_Q(l)((cot*CP+cop)*CI1+cit*CP+cip)
              }
            }
          }
          for (wt <- 0 until WT1) {
            val index_prefix=(cot*WT1+wt)*CP
            for (cop <- 0 until CP) {
              MERGE_WS1(l)(index_prefix+cop)=REF_WIN_S1(l)((cot*CP+cop)*WT1+wt)
              MERGE_WS2(l)(index_prefix+cop)=REF_WIN_S2(l)((cot*CP+cop)*WT1+wt)
            }
          }
        }
        for (cot <- 0 until COT2) {
          for (cit <- 0 until CIT2) {
            val index_prefix=CO1*CI1+(cot*CIT2+cit)*CP*CP
            for (cop <- 0 until CP) {
              for (cip <- 0 until CP) {
                MERGE_WQ(l)(index_prefix+cop*CP+cip)=WOUT_Q(l)((cot*CP+cop)*CI2+cit*CP+cip)
              }
            }
          }
          for (wt <- 0 until WT2) {
            val index_prefix=CO1*WT1+(cot*WT2+wt)*CP
            for (cop <- 0 until CP) {
              MERGE_WS1(l)(index_prefix+cop)=WOUT_S1(l)((cot*CP+cop)*WT2+wt)
              MERGE_WS2(l)(index_prefix+cop)=WOUT_S2(l)((cot*CP+cop)*WT2+wt)
            }
          }
        }
      }

      val TOTAL_CYCS=635199
      val TOTAL_LOOPS=2453
      val WS_LOOPs=7359
      val WQ_CYCS=256
      val WS_CYCS=3
      val WQ_BOARD=128
      val BLOCK_PER_LOOP_WS=16
      val WS_BOARD=8
      def compose_tile[T: Numeric : ClassTag](tile: Array[T], i_bits: Int): BigInt = {
        val sign_weight = BigInt(1) << i_bits
        val mask = (BigInt(1) << i_bits) - 1 // Pre-compute the mask to be used for negative numbers
        tile.map { num =>
            val numBigInt = BigInt(implicitly[Numeric[T]].toLong(num))
            if (numBigInt < 0) sign_weight + numBigInt else numBigInt
          }
          .reverse
          .reduce(_ << i_bits | _ & mask)
      }
      def resolve_tile(tile_int: BigInt, o_bits: Int, TP: Int, CP: Int): Array[Byte] = {
        // resolve a tile to a local array
        val local_array = new Array[Byte](TP * CP)
        // resolve the tile
        for (tp <- 0 until TP) {
          for (cp <- 0 until CP) {
            val loc_idx = tp * CP + cp
            // FIXME: Don't Touch! Magic!
            val part_val = (tile_int >> (o_bits * loc_idx)) & BigInt("1" * o_bits, 2)
            local_array(loc_idx) = part_val.toByte
          }
        }
        local_array
      }

      val CONDENSE_WS  = Array.ofDim[Byte](L,WS_LOOPs*BYTES_PER_PACK)
      for (l <- 0 until L) {
        var ws_cur=0
        var w_cur=0
        for (loop <- 0 until TOTAL_LOOPS) {
          val input_tile: Array[Long] = new Array[Long](2*BLOCK_PER_LOOP_WS*CP)
          var tile_cur=0
          for (i <- 0 until BLOCK_PER_LOOP_WS) {
            if(loop<TOTAL_LOOPS-1||i<WS_BOARD) {
              for (cp <- 0 until CP) {
                input_tile(tile_cur)=MERGE_WS1(l)(ws_cur+cp)
                tile_cur+=1
                input_tile(tile_cur)=MERGE_WS2(l)(ws_cur+cp)
                tile_cur+=1
              }
              ws_cur+=CP
            }
            else {
              for (cp <- 0 until CP) {
                input_tile(tile_cur+cp)=0
              }
              tile_cur+=8
              for (cp <- 0 until CP) {
                input_tile(tile_cur+cp)=0
              }
              tile_cur+=8
            }
          }
          val tile_int=compose_tile(input_tile, DW_WS)
          val local_array = resolve_tile(tile_int, 8, 1, BYTES_PER_PACK*WS_CYCS)
          for (c <- 0 until BYTES_PER_PACK*WS_CYCS) {
            CONDENSE_WS(l)(w_cur+c)=local_array(c)
          }
          w_cur+=BYTES_PER_PACK*WS_CYCS
        }
      }

      val CONDENSE_W  = Array.ofDim[Byte](L,TOTAL_CYCS*BYTES_PER_PACK)
      for (l <- 0 until L) {
        var wq_cur=0
        var w_cur=0
        var ws_cur=0
        for (loop <- 0 until TOTAL_LOOPS) {
          for (cyc <- 0 until WQ_CYCS+WS_CYCS) {
            if(cyc < WS_CYCS){
              for (c <- 0 until BYTES_PER_PACK) {
                CONDENSE_W(l)(w_cur+c)=CONDENSE_WS(l)(ws_cur+c)
              }
              w_cur+=BYTES_PER_PACK
              ws_cur+=BYTES_PER_PACK
            }
            else {
              if(loop<TOTAL_LOOPS-1||cyc<WS_CYCS+WQ_BOARD) {
                val input_tile: Array[Long] = new Array[Long](CP * CP)
                for (c <- 0 until CP*CP) {
                  input_tile(c)=MERGE_WQ(l)(wq_cur+c)
                }
                wq_cur+=CP*CP
                val tile_int=compose_tile(input_tile, DW_WQ)
                val local_array = resolve_tile(tile_int, 8, 1, BYTES_PER_PACK)
                for (c <- 0 until BYTES_PER_PACK) {
                  CONDENSE_W(l)(w_cur+c)=local_array(c)
                }
                w_cur+=BYTES_PER_PACK
              }
            }
          }
        }
        val file = format_str.format("/weights/CONDENSED_W_layer",l)
        write_int8_file(file,CONDENSE_W(l))
      }

      val CONDENSE_CW  = Array.ofDim[Byte](L,C_CYCS*BYTES_PER_PACK)
      for (l <- 0 until L) {
        var w_cur=0
        for (ct <- 0 until ST) {
          val input_tile: Array[Long] = new Array[Long](STATE_P)
          for (cp <- 0 until STATE_P) {
            val ref_idx = ct*STATE_P+cp
            input_tile(cp) = ref_w_q(l)(ref_idx)
          }
          val tile_int = compose_tile(input_tile, DW_AQ)
          val local_array = resolve_tile(tile_int, 8, 1, BYTES_PER_PACK)
          for (c <- 0 until BYTES_PER_PACK) {
            CONDENSE_CW(l)(w_cur+c)=local_array(c)
          }
          w_cur+=BYTES_PER_PACK
        }
        for (ct <- 0 until ST_S) {
          val input_tile: Array[Long] = new Array[Long](STATE_P_S)
          for (cp <- 0 until STATE_P_S) {
            val ref_idx = ct*STATE_P_S+cp
            input_tile(cp) = ref_w_s(l)(ref_idx)
          }
          val tile_int = compose_tile(input_tile, DW_AS)
          val local_array = resolve_tile(tile_int, 8, 1, BYTES_PER_PACK)
          for (c <- 0 until BYTES_PER_PACK) {
            CONDENSE_CW(l)(w_cur+c)=local_array(c)
          }
          w_cur+=BYTES_PER_PACK
        }
        val file = format_str.format("/weights/CONDENSED_CW_layer",l)
        write_int8_file(file,CONDENSE_CW(l))
      }

      val ref_x = read_multi_int64_files(format_str, L, "/activations/before_rms1_layer", 4 * CI1)
      val ref_y = read_multi_int64_files(format_str, L, "/activations/output_layer", 4 * CI1)
      val REF_X  = Array.ofDim[Long](T * CI1)
      for (c <- 0 until CI1) {
        REF_X(c)=ref_x(0)(3*CI1+c)
      }
      val REF_Y  = Array.ofDim[Long](T * CI1)
      for (c <- 0 until CI1) {
        REF_Y(c)=ref_y(L-1)(3*CI1+c)
      }
      val DUT_Y      = Array.ofDim[Long](T*CI1)

      val DUT_CQ  = Array.ofDim[Long](L,T * CC*4)
      val DUT_CS  = Array.ofDim[Long](L,T * CCT*4)

      val DUT_HQ  = Array.ofDim[Long](L,T * C2*N)
      val DUT_HS  = Array.ofDim[Long](L,T * C2T*N)


      // initialize weight
      for (l <- 0 until L) {
        val condensed_file_name = format_str.format("/weights/CONDENSED_W_layer",l)
        axi_sim.memory.loadBinary(addr_w+l*TOTAL_CYCS*BYTES_PER_PACK, condensed_file_name)
        val condensed_cw_file_name = format_str.format("/weights/CONDENSED_CW_layer",l)
        axi_sim.memory.loadBinary(addr_c+(l*C_CYCS*2+C_CYCS)*BYTES_PER_PACK, condensed_cw_file_name)
      }


      // initialize input x into memory
      for (tt <- 0 until TT) {
        for (ct <- 0 until CT) {
          for (tp <- 0 until TP) {
            for (cp <- 0 until CP) {
              // original    loop: TT -> TP -> CT -> CP
              // accelerator loop: TT -> CT -> TP -> CP
              val ref_idx = tt * TP * CT * CP + tp * CT * CP + ct * CP + cp
              val axi_idx = tt * CT * TP * CP + ct * TP * CP + tp * CP + cp
              // consider the sign problem, if <0, convert to complement
              val ref_val = BigInt(REF_X(ref_idx))
              val axi_val = if (ref_val < 0) (BigInt(1) << 32) + ref_val else ref_val
              axi_sim.memory.writeBigInt(addr_x + axi_idx * BYTES_PER_X, axi_val, BYTES_PER_X)
            }
          }
        }
      }

      // initialize c memory
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

      for (l <- 0 until L) {
        for (ct <- 0 until ST) {
          val input_tile: Array[Long] = new Array[Long](STATE_P)
          for (cp <- 0 until STATE_P) {
            val ref_idx = ct*STATE_P+cp
            input_tile(cp) = ref_conv_in_q(l)(ref_idx)
          }
          val axi_val = compose_tile(input_tile, DW_AQ)
          val axi_idx = l * (ST + ST_S)*2 + ct
          axi_sim.memory.writeBigInt(addr_c + axi_idx * BYTES_PER_PACK, axi_val, BYTES_PER_PACK)
        }
        for (ct <- 0 until ST_S) {
          val input_tile: Array[Long] = new Array[Long](STATE_P_S)
          for (cp <- 0 until STATE_P_S) {
            val ref_idx = ct*STATE_P_S+cp
            input_tile(cp) = ref_conv_in_s(l)(ref_idx)
          }
          val axi_val = compose_tile(input_tile, DW_AS)
          val axi_idx = l * (ST + ST_S)*2 + ST + ct
          axi_sim.memory.writeBigInt(addr_c + axi_idx * BYTES_PER_PACK, axi_val, BYTES_PER_PACK)
        }
      }

      // initialize h memory
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
      for (l <- 0 until L) {
        for (ct <- 0 until C2T) {
          for (nt <- 0 until NTT) {
            val input_tile: Array[Long] = new Array[Long](NP2 * CP)
            for (np <- 0 until NP2) {
              for (cp <- 0 until CP) {
                val ref_idx = (ct * NTT + nt) * NP2 * CP + np * CP + cp
                input_tile(np * CP + cp) = ref_state_in_q(l)(ref_idx)
              }
            }
            val axi_val = compose_tile(input_tile, DW_AQ)
            val axi_idx = l * (C2T * NTT + CTT * NT) + ct * NTT + nt
            axi_sim.memory.writeBigInt(addr_h + axi_idx * BYTES_PER_PACK, axi_val, BYTES_PER_PACK)
          }
        }
        for (ct <- 0 until CTT) {
          for (nt <- 0 until NT) {
            val input_tile: Array[Long] = new Array[Long](NP * CP)
            for (np <- 0 until NP) {
              for (cp <- 0 until CP) {
                val ref_idx = (ct * NT + nt) * NP * CP + np * CP + cp
                input_tile(np * CP + cp) = ref_state_in_s(l)(ref_idx)
              }
            }
            val axi_val = compose_tile(input_tile, DW_AS)
            val axi_idx = l * (C2T * NTT + CTT * NT) + C2T * NTT + ct * NT + nt
            axi_sim.memory.writeBigInt(addr_h + axi_idx * BYTES_PER_PACK, axi_val, BYTES_PER_PACK)
          }
        }
      }


      init_clock(dut.clockDomain, 10)
      axi_sim.reset()
      drv.reset()
      // write parameters
      drv.write(ctrl_cfg.ADDR_L_BEGIN, 0)
      drv.write(ctrl_cfg.ADDR_L_CLOSE, L)
      drv.write(ctrl_cfg.ADDR_MEMORY_W, 0)
      drv.write(ctrl_cfg.ADDR_MEMORY_X, addr_x)
      drv.write(ctrl_cfg.ADDR_MEMORY_Y, addr_y)
      drv.write(ctrl_cfg.ADDR_MEMORY_C, addr_c)
      drv.write(ctrl_cfg.ADDR_MEMORY_H, addr_h)
      drv.write(ctrl_cfg.ADDR_POS, 0)
      //      drv.write(ctrl_cfg.ADDR_POS, 1) // for error inject

      // try to read the config back and print
      println(s"Reading L_BEGIN:  ${drv.read(ctrl_cfg.ADDR_L_BEGIN)}")
      println(s"Reading L_CLOSE:  ${drv.read(ctrl_cfg.ADDR_L_CLOSE)}")
      println(s"Reading MEMORY_W: ${drv.read(ctrl_cfg.ADDR_MEMORY_W)}")
      println(s"Reading MEMORY_X: ${drv.read(ctrl_cfg.ADDR_MEMORY_X)}")
      println(s"Reading MEMORY_Y: ${drv.read(ctrl_cfg.ADDR_MEMORY_Y)}")
      println(s"Reading MEMORY_C: ${drv.read(ctrl_cfg.ADDR_MEMORY_C)}")
      println(s"Reading MEMORY_H: ${drv.read(ctrl_cfg.ADDR_MEMORY_H)}")
      println(s"Reading POS:      ${drv.read(ctrl_cfg.ADDR_POS)}")

      // delay 20 cycles to make sure the signals are set
      dut.clockDomain.waitSampling(20)
      SimTimeout(10 * 4000000 * 1)
      // try to read if idle
      println("idle status: " + drv.read(ctrl_cfg.ADDR_IDLE))
      val start_time = simTime()
      // launch with trigger
      drv.write(ctrl_cfg.ADDR_T, 1)
      dut.clockDomain.waitSampling(100)

      // wait until idle
      dut.clockDomain.waitSamplingWhere(dut.io.idle.toBoolean)
      println("idle status: " + drv.read(ctrl_cfg.ADDR_IDLE))
      val end_time = simTime()
      val cycles = (end_time - start_time) / 10
      println(f"cycles elapsed: $cycles%10d")
      dut.clockDomain.waitSampling(10000)

      // read the result
      // read from axi_sim and put into DUT_Y, transposed
      for (tt <- 0 until TT) {
        for (ct <- 0 until CT) {
          for (tp <- 0 until TP) {
            for (cp <- 0 until CP) {
              val axi_idx = tt * CT * TP * CP + ct * TP * CP + tp * CP + cp
              val dut_idx = tt * TP * CT * CP + tp * CT * CP + ct * CP + cp
              val axi_val = axi_sim.memory.readBigInt(addr_y + axi_idx * BYTES_PER_X, BYTES_PER_X)
              val out_val = if ((axi_val >> 31) == 1) (axi_val - (BigInt(1) << 32)).toLong else axi_val.toLong
              DUT_Y(dut_idx) = out_val
            }
          }
        }
      }

      compare_array(REF_Y, DUT_Y)

      // read c
      for (l <- 0 until L) {
        for (ct <- 0 until ST) {
          val axi_idx = l * (ST + ST_S)*2 + ct
          val axi_val = axi_sim.memory.readBigInt(addr_c + axi_idx * BYTES_PER_PACK, BYTES_PER_PACK)
          val local_array = resolve_tile(axi_val, DW_AQ, 1, STATE_P)
          for (cp <- 0 until STATE_P) {
            val ref_idx = ct * STATE_P + cp
            DUT_CQ(l)(ref_idx) = local_array(cp).toLong
          }
        }
        for (ct <- 0 until ST_S) {
          val axi_idx = l * (ST + ST_S)*2 + ST + ct
          val axi_val = axi_sim.memory.readBigInt(addr_c + axi_idx * BYTES_PER_PACK, BYTES_PER_PACK)
          val local_array = resolve_tile(axi_val, DW_AS, 1, STATE_P_S)
          for (cp <- 0 until STATE_P_S) {
            val ref_idx = ct * STATE_P_S + cp
            DUT_CS(l)(ref_idx) = local_array(cp).toLong
          }
        }
        compare_array(ref_conv_q(l), DUT_CQ(l),"cq_out")
        compare_array(ref_conv_s(l), DUT_CS(l),"cs_out")
      }

      // read h
      for (l <- 0 until L) {
        for (ct <- 0 until C2T) {
          for (nt <- 0 until NTT) {
            val axi_idx = l * (C2T * NTT + CTT * NT) + ct * NTT + nt
            val axi_val = axi_sim.memory.readBigInt(addr_h + axi_idx * BYTES_PER_PACK, BYTES_PER_PACK)
            val local_array = resolve_tile(axi_val, DW_AQ, 1, NP2*CP)
            for (np <- 0 until NP2) {
              for (cp <- 0 until CP) {
                val ref_idx = (ct * NTT + nt) * NP2 * CP + np * CP + cp
                DUT_HQ(l)(ref_idx) = local_array(np * CP + cp).toLong
              }
            }
          }
        }
        for (ct <- 0 until CTT) {
          for (nt <- 0 until NT) {
            val axi_idx = l * (C2T * NTT + CTT * NT) + C2T * NTT + ct * NT + nt
            val axi_val = axi_sim.memory.readBigInt(addr_h + axi_idx * BYTES_PER_PACK, BYTES_PER_PACK)
            val local_array = resolve_tile(axi_val, DW_AS, 1, NP*CP)
            for (np <- 0 until NP) {
              for (cp <- 0 until CP) {
                val ref_idx = (ct * NT + nt) * NP * CP + np * CP + cp
                DUT_HS(l)(ref_idx) = local_array(np * CP + cp).toLong
              }
            }
          }
        }
        compare_array(ref_state_out_q(l), DUT_HQ(l),"hq_out")
        compare_array(ref_state_out_s(l), DUT_HS(l),"hs_out")
      }


      simSuccess()
    }
}

object generate_accelerator extends App {
  // spinal config
  val spinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC,
      resetActiveLevel = LOW
    )
  )
  SpinalVerilog(spinalConfig)(new ACCELERATOR).mergeRTLSource()
}
import utils._

import scala.language.postfixOps
import scala.reflect.ClassTag

object accelerator_save_mem extends App {
  val L = 64

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
  val NP2       = NP / 2;

  val STATE_P = 32
  val STATE_P_S = 64


  val DW_WQ = 4
  val DW_WS = 3
  val DW_MAXI = CP * CP * DW_WQ
  val BYTES_PER_PACK = DW_MAXI / 8
  val BYTES_PER_X = 32 / 8

  val CIT1 = CI1 / CP
  val CIT2 = CI2 / CP
  val COT1 = CO1 / CP
  val COT2 = CO2 / CP
  val WT1 = CI1 / G
  val WT2 = CI2 / G

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
  val addr_h = addr_c + C_CYCS*BYTES_PER_PACK


  val data_path_prefix = "D:/file/project/git/mamba_cpp/cmake-build-debug/bin"
  val out_data_path_prefix = "D:/file/project/git/light-mamba/ref"
  val format_str = s"$data_path_prefix%s%d.bin"
  val out_format_str = s"$out_data_path_prefix%s%d.bin"

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

  for (l <- 0 until L) {
    // @formatter:off
    val WIN_Q = read_int64_file(format_str.format("/weights/in_proj_wq_layer",l), CO1 * CI1)
    val WIN_S1 = read_int64_file(format_str.format("/weights/in_proj_s1_layer",l), CO1 * WT1)
    val WIN_S2 = read_int64_file(format_str.format("/weights/in_proj_s2_layer",l), CO1 * WT1)
    val WOUT_Q = read_int64_file(format_str.format("/weights/out_proj_wq_layer",l), CO2 * CI2)
    val WOUT_S1 = read_int64_file(format_str.format("/weights/out_proj_s1_layer",l), CO2 * WT2)
    val WOUT_S2 = read_int64_file(format_str.format("/weights/out_proj_s2_layer",l), CO2 * WT2)

    val REF_WIN_Q  = Array.ofDim[Long](CO1 * CI1)
    val REF_WIN_S1  = Array.ofDim[Long](CO1 * WT1)
    val REF_WIN_S2  = Array.ofDim[Long]( CO1 * WT1)

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
          REF_WIN_S1((ct*CP+cp)*WT1+gt)=WIN_S1((cot*CP+cp)*WT1+gt)
          REF_WIN_S2((ct*CP+cp)*WT1+gt)=WIN_S2((cot*CP+cp)*WT1+gt)
        }
        for (c <- 0 until CI1) {
          REF_WIN_Q((ct*CP+cp)*CI1+c)=WIN_Q((cot*CP+cp)*CI1+c)
        }
      }
    }


    val MERGE_WQ  = Array.ofDim[Long](CO1 * CI1+CO2 * CI2)
    val MERGE_WS1  = Array.ofDim[Long](CO1 * WT1+CO2 * WT2)
    val MERGE_WS2  = Array.ofDim[Long](CO1 * WT1+CO2 * WT2)

    for (cot <- 0 until COT1) {
      for (cit <- 0 until CIT1) {
        val index_prefix=(cot*CIT1+cit)*CP*CP
        for (cop <- 0 until CP) {
          for (cip <- 0 until CP) {
            MERGE_WQ(index_prefix+cop*CP+cip)=REF_WIN_Q((cot*CP+cop)*CI1+cit*CP+cip)
          }
        }
      }
      for (wt <- 0 until WT1) {
        val index_prefix=(cot*WT1+wt)*CP
        for (cop <- 0 until CP) {
          MERGE_WS1(index_prefix+cop)=REF_WIN_S1((cot*CP+cop)*WT1+wt)
          MERGE_WS2(index_prefix+cop)=REF_WIN_S2((cot*CP+cop)*WT1+wt)
        }
      }
    }
    for (cot <- 0 until COT2) {
      for (cit <- 0 until CIT2) {
        val index_prefix=CO1*CI1+(cot*CIT2+cit)*CP*CP
        for (cop <- 0 until CP) {
          for (cip <- 0 until CP) {
            MERGE_WQ(index_prefix+cop*CP+cip)=WOUT_Q((cot*CP+cop)*CI2+cit*CP+cip)
          }
        }
      }
      for (wt <- 0 until WT2) {
        val index_prefix=CO1*WT1+(cot*WT2+wt)*CP
        for (cop <- 0 until CP) {
          MERGE_WS1(index_prefix+cop)=WOUT_S1((cot*CP+cop)*WT2+wt)
          MERGE_WS2(index_prefix+cop)=WOUT_S2((cot*CP+cop)*WT2+wt)
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


    val CONDENSE_WS  = Array.ofDim[Byte](WS_LOOPs*BYTES_PER_PACK)

    var ws_cur=0
    var w_cur=0
    for (loop <- 0 until TOTAL_LOOPS) {
      val input_tile: Array[Long] = new Array[Long](2*BLOCK_PER_LOOP_WS*CP)
      var tile_cur=0
      for (i <- 0 until BLOCK_PER_LOOP_WS) {
        if(loop<TOTAL_LOOPS-1||i<WS_BOARD) {
          for (cp <- 0 until CP) {
            input_tile(tile_cur)=MERGE_WS1(ws_cur+cp)
            tile_cur+=1
            input_tile(tile_cur)=MERGE_WS2(ws_cur+cp)
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
        CONDENSE_WS(w_cur+c)=local_array(c)
      }
      w_cur+=BYTES_PER_PACK*WS_CYCS
    }


    val CONDENSE_W  = Array.ofDim[Byte](TOTAL_CYCS*BYTES_PER_PACK)
    var wq_cur=0
    w_cur=0
    ws_cur=0
    for (loop <- 0 until TOTAL_LOOPS) {
      for (cyc <- 0 until WQ_CYCS+WS_CYCS) {
        if(cyc < WS_CYCS){
          for (c <- 0 until BYTES_PER_PACK) {
            CONDENSE_W(w_cur+c)=CONDENSE_WS(ws_cur+c)
          }
          w_cur+=BYTES_PER_PACK
          ws_cur+=BYTES_PER_PACK
        }
        else {
          if(loop<TOTAL_LOOPS-1||cyc<WS_CYCS+WQ_BOARD) {
            val input_tile: Array[Long] = new Array[Long](CP * CP)
            for (c <- 0 until CP*CP) {
              input_tile(c)=MERGE_WQ(wq_cur+c)
            }
            wq_cur+=CP*CP
            val tile_int=compose_tile(input_tile, DW_WQ)
            val local_array = resolve_tile(tile_int, 8, 1, BYTES_PER_PACK)
            for (c <- 0 until BYTES_PER_PACK) {
              CONDENSE_W(w_cur+c)=local_array(c)
            }
            w_cur+=BYTES_PER_PACK
          }
        }
      }
    }
    val file = out_format_str.format("/weights/CONDENSED_W/CONDENSED_W_layer",l)
    write_int8_file(file,CONDENSE_W)
  }

}

object accelerator_save_conv_mem extends App {
  val L = 64

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
  val NP2       = NP / 2;
  val D=4

  val STATE_P = 32
  val STATE_P_S = 64

  val ST = D * CC / STATE_P
  val ST_S = D * CCT / STATE_P_S

  val DW_WQ = 4
  val DW_WS = 3
  val DW_AQ     = 8
  val DW_AS     = 4
  val DW_MAXI = CP * CP * DW_WQ
  val BYTES_PER_PACK = DW_MAXI / 8
  val BYTES_PER_X = 32 / 8

  val C_CYCS=714

  val data_path_prefix = "D:/file/project/git/mamba_cpp/cmake-build-debug/bin"
  val out_data_path_prefix = "D:/file/project/git/light-mamba/ref"
  val format_str = s"$data_path_prefix%s%d.bin"
  val out_format_str = s"$out_data_path_prefix%s%d.bin"

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

  for (l <- 0 until L) {
    // @formatter:off
    val w_q = read_int64_file(format_str.format("/weights/conv_wq_layer",l), 4 * CC)
    val w_s = read_int64_file(format_str.format("/weights/conv_ws_layer",l), 4 * CCT)

    val ref_w_q  = Array.ofDim[Long](4 * CC)
    val ref_w_s  = Array.ofDim[Long](4 * CCT)
    // @formatter:off

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
          ref_w_q(ct*D*CP+d*CP+cp) = w_q(d*CC+ct_cur*CP+cp)
        }
        ref_w_s(ct*D+d) = w_s(d*CCT+ct_cur)
      }
    }


    val CONDENSE_CW  = Array.ofDim[Byte](C_CYCS*BYTES_PER_PACK)
    var w_cur=0
    for (ct <- 0 until ST) {
      val input_tile: Array[Long] = new Array[Long](STATE_P)
      for (cp <- 0 until STATE_P) {
        val ref_idx = ct*STATE_P+cp
        input_tile(cp) = ref_w_q(ref_idx)
      }
      val tile_int = compose_tile(input_tile, DW_AQ)
      val local_array = resolve_tile(tile_int, 8, 1, BYTES_PER_PACK)
      for (c <- 0 until BYTES_PER_PACK) {
        CONDENSE_CW(w_cur+c)=local_array(c)
      }
      w_cur+=BYTES_PER_PACK
    }
    for (ct <- 0 until ST_S) {
      val input_tile: Array[Long] = new Array[Long](STATE_P_S)
      for (cp <- 0 until STATE_P_S) {
        val ref_idx = ct*STATE_P_S+cp
        input_tile(cp) = ref_w_s(ref_idx)
      }
      val tile_int = compose_tile(input_tile, DW_AS)
      val local_array = resolve_tile(tile_int, 8, 1, BYTES_PER_PACK)
      for (c <- 0 until BYTES_PER_PACK) {
        CONDENSE_CW(w_cur+c)=local_array(c)
      }
      w_cur+=BYTES_PER_PACK
    }
    val file = out_format_str.format("/weights/CONDENSED_CW/CONDENSED_CW_layer",l)
    write_int8_file(file,CONDENSE_CW)
  }

}
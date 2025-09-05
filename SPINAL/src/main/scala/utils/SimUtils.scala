package utils

import spinal.core._
import spinal.core.sim._
import spinal.lib.bus.amba4.axilite.AxiLite4
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream

import java.io.{DataInputStream, File, FileInputStream, FileOutputStream, PrintStream}
import java.nio.{ByteBuffer, ByteOrder}
import scala.math.Numeric.Implicits.infixNumericOps
import scala.reflect.ClassTag
import java.nio.file.Paths
import java.nio.file.Files

object redirect_std {
  def apply(filename: String): Unit = {
    val file = new File(filename)
    val fos = new FileOutputStream(file)
    val ps = new PrintStream(fos)
    System.setOut(ps)
  }
}

class ProgressBar(val _info: String, val total: Int) {
  private val info = _info
  private var current = 0

  def update(step: Int): Unit = {
    current += step
    val percentage = (current.toDouble / total * 100).toInt
    val progress = 50 * current / total
    val bar = "=" * progress + " " * (50 - progress)
    System.err.print(f"\r[$info%20s][$bar] $percentage%3d%%")
    if (current >= total) System.err.println() // Move to next line when done
  }

  def start(): Unit = {
    update(0) // Initialize the progress bar
  }

  def finish(): Unit = {
    update(total - current) // Complete the progress bar
  }
}


object read_int64_file {
  def apply(file: String, n: Int): Array[Long] = {
    val file_stream = new DataInputStream(new FileInputStream(file))
    val byte_buffer = ByteBuffer.allocate(8 * n) // 8 bytes per int64
    file_stream.read(byte_buffer.array())
    file_stream.close()
    val int_buffer = byte_buffer.order(ByteOrder.LITTLE_ENDIAN).asLongBuffer() // little endian
    val int64_array = new Array[Long](n)
    int_buffer.get(int64_array)
    int64_array
  }
}

object read_int8_file {
  def apply(file: String, n: Int): Array[Byte] = {
    val file_stream = new DataInputStream(new FileInputStream(file))
    val byte_buffer = ByteBuffer.allocate(n) // 1 byte per int8
    file_stream.read(byte_buffer.array()) // no endian issue
    file_stream.close()
    byte_buffer.array()
  }
}

object write_int8_file {
  def apply(file: String, array:Array[Byte]): Unit = {
    Files.write(Paths.get(file), array)
  }
}

// read multiple files
object read_multi_int8_files {
  def apply(format_str: String, L: Int, file_name: String, n: Int): Array[Array[Byte]] = {
    val int8_array = new Array[Array[Byte]](L)
    for (l <- 0 until L) {
      val file = format_str.format(l, file_name)
      int8_array(l) = read_int8_file(file, n)
    }
    int8_array
  }
}

object read_multi_int64_files {
  def apply(format_str: String, L: Int, file_name: String, n: Int): Array[Array[Long]] = {
    val int64_array = new Array[Array[Long]](L)
    for (l <- 0 until L) {
      val file = format_str.format(file_name, l)
      int64_array(l) = read_int64_file(file, n)
    }
    int64_array
  }
}

object cut_array {
  def apply[T: Numeric : ClassTag](src: Array[Array[T]], D1_LOAD: Int, D1: Int, D2_LOAD: Int, D2: Int, D3_LOAD: Int, D3: Int): Array[Array[T]] = {
    val L = src.length // number of layers
    src.foreach(array => assert(array.length == D1_LOAD * D2_LOAD * D3_LOAD))
    // create a destination array
    val dst = Array.ofDim[T](L, D1 * D2 * D3)
    // 3D array, put the data to the right place
    for (l <- 0 until L) {
      for (d1 <- 0 until D1) {
        for (d2 <- 0 until D2) {
          for (d3 <- 0 until D3) {
            val src_idx = d1 * D2_LOAD * D3_LOAD + d2 * D3_LOAD + d3
            val dst_idx = d1 * D2 * D3 + d2 * D3 + d3
            dst(l)(dst_idx) = src(l)(src_idx)
          }
        }
      }
    }
    dst
  }
}

object split_heads {
  // src: T, H, C -> H, T, C
  def apply[T: Numeric : ClassTag](src: Array[Array[T]], H: Int, T: Int, C: Int): Unit = {
    val L = src.length
    src.foreach(array => assert(array.length == H * T * C))
    val dst = Array.ofDim[T](L, H * T * C)
    for (l <- 0 until L) {
      for (h <- 0 until H) {
        for (t <- 0 until T) {
          for (c <- 0 until C) {
            val src_idx = t * H * C + h * C + c
            val dst_idx = h * T * C + t * C + c
            dst(l)(dst_idx) = src(l)(src_idx)
          }
        }
      }
    }
    // overwrite the src array
    for (l <- 0 until L) {
      for (i <- 0 until H * T * C) {
        src(l)(i) = dst(l)(i)
      }
    }
  }

}

object merge_heads {
  // src: H, T, C -> T, H, C
  def apply[T: Numeric : ClassTag](src: Array[Array[T]], H: Int, T: Int, C: Int): Unit = {
    val L = src.length
    src.foreach(array => assert(array.length == H * T * C))
    val dst = Array.ofDim[T](L, H * T * C)
    for (l <- 0 until L) {
      for (h <- 0 until H) {
        for (t <- 0 until T) {
          for (c <- 0 until C) {
            val src_idx = h * T * C + t * C + c
            val dst_idx = t * H * C + h * C + c
            dst(l)(dst_idx) = src(l)(src_idx)
          }
        }
      }
    }
    // overwrite the src array
    for (l <- 0 until L) {
      for (i <- 0 until H * T * C) {
        src(l)(i) = dst(l)(i)
      }
    }
  }
}


object array2stream {

  private def compose_tile[T: Numeric : ClassTag](tile: Array[T], i_bits: Int): BigInt = {
    val sign_weight = BigInt(1) << i_bits
    val mask = (BigInt(1) << i_bits) - 1 // Pre-compute the mask to be used for negative numbers
    tile.map { num =>
        val numBigInt = BigInt(implicitly[Numeric[T]].toLong(num))
        if (numBigInt < 0) sign_weight + numBigInt else numBigInt
      }
      .reverse
      .reduce(_ << i_bits | _ & mask)
  }

  def apply[T: Numeric : ClassTag](
                                    i_stream: Axi4Stream,
                                    clockDomain: ClockDomain,
                                    i_array: Array[T],
                                    R: Int,
                                    H: Int,
                                    T: Int,
                                    TP: Int,
                                    C: Int,
                                    CP: Int,
                                    verbose: Boolean = false,
                                    unpack: Boolean = false,
                                    random_stall: Boolean = false,
                                    //                                    random_stall: Boolean = true,
                                    info: String = "",
                                    WAIT:Int = 0,
                                    DELAY:Int = 0
                                  ): Unit = {
    // initialize ap_ctrl
    val TT = T / TP
    val CT = C / CP
    // get the spinal simulation time of the beginning
    val start_time = simTime()
    val real_start_time = System.currentTimeMillis()

    // check interface width

    val bar = new ProgressBar(info, H * TT * R * CT)
    if(DELAY!=0) {
      clockDomain.waitSampling(DELAY)
    }
    for (h <- 0 until H) {
      for (tt <- 0 until TT) {
        for (r <- 0 until R) { // repeat inside TT loop, the repeat behavior for tokens
          for (ct <- 0 until CT) {
            // update progress bar
            if (verbose) bar.update(1)
            if (!unpack) {
              val i_bits = i_stream.config.dataWidth * 8 / TP / CP
              // input tile
              val input_tile: Array[T] = new Array[T](TP * CP)
              for (tp <- 0 until TP) {
                for (cp <- 0 until CP) {
                  val loc_idx = tp * CP + cp
                  val glb_idx = h * T * C + (tt * TP + tp) * C + ct * CP + cp
                  input_tile(loc_idx) = i_array(glb_idx)
                }
              }
              // assign port
              i_stream.valid #= true
              i_stream.data #= compose_tile(input_tile, i_bits)
              clockDomain.waitSamplingWhere(i_stream.ready.toBoolean && i_stream.valid.toBoolean)
              i_stream.valid #= false
              if(WAIT!=0) {
                clockDomain.waitSampling(WAIT)
              }
            } else {
              // repeat TP times to put the sub-tile
              val i_bits = i_stream.config.dataWidth * 8 / CP
              for (tp <- 0 until TP) {
                // input tile
                val input_tile: Array[T] = new Array[T](CP)
                for (cp <- 0 until CP) {
                  val loc_idx = cp
                  val glb_idx = h * T * C + (tt * TP + tp) * C + ct * CP + cp
                  input_tile(loc_idx) = i_array(glb_idx)
                }
                // compose the tile to a BigInt
                val input_bigint = compose_tile(input_tile, i_bits)
                // assign port
                i_stream.valid #= true
                i_stream.data #= input_bigint
                clockDomain.waitSamplingWhere(i_stream.ready.toBoolean && i_stream.valid.toBoolean)
                i_stream.valid #= false
              } // end of unpack TP loop
            } // unpack or not
            if (random_stall) {
              // 1/5 prob to cause a stall
              // stall cycles in [1, 2]
              if (scala.util.Random.nextInt(5) == 0) {
                val stall_cycles = (scala.util.Random.nextInt(2) + 1).toInt
                clockDomain.waitSampling(stall_cycles)
              }
            }
          } // end of CT loop
        } // end of R loop
      } // end of TT loop
    }
    val end_time = simTime()
    val real_end_time = System.currentTimeMillis()
    val cycles = (end_time - start_time) / 10 // 10 is the period of the clock
    val real_elapsed_time: Float = (real_end_time - real_start_time) / 1000.0f // 1000 is milliseconds
    val KHz: Float = cycles.toFloat / real_elapsed_time / 1000.0f // 1000 is kHz
    println(f"input  thread $info%20s done, cycles elapsed: $cycles%10d, real time elapsed: $real_elapsed_time%4.2f, KHz: $KHz%2.2f")
    // delay 1 cycle
    clockDomain.waitSampling()
  }
}


object stream2array {
  private def resolve_tile(tile_int: BigInt, o_bits: Int, TP: Int, CP: Int, is_signed: Boolean): Array[Long] = {
    // resolve a tile to a local array
    val local_array = new Array[Long](TP * CP)
    // resolve the tile
    for (tp <- 0 until TP) {
      for (cp <- 0 until CP) {
        val loc_idx = tp * CP + cp
        // FIXME: Don't Touch! Magic!
        val part_val = (tile_int >> (o_bits * loc_idx)) & BigInt("1" * o_bits, 2)
        //        val sign_bit = (part_val >> (o_bits - 1)) & 1
        val sign_bit: BigInt = if (is_signed) (part_val >> (o_bits - 1)) & 1 else 0
        local_array(loc_idx) = (part_val - (sign_bit << o_bits)).toLong
      }
    }
    local_array
  }

  private def compare_dut_ref[T: Numeric : ClassTag](dut_val: T, ref_array: Array[T], tile_int: BigInt, glb_idx: Int, info: String = ""): Unit = {
    if (dut_val != ref_array(glb_idx)) {
      //      print(Console.RED)
      //      print(s"$info different at $glb_idx, the result is $dut_val, expected ${ref_array(glb_idx)}\n")
      // set width for print
      print(f"$info different at $glb_idx%10d, the result is ${dut_val.toInt}%10d, expected ${ref_array(glb_idx).toInt}%10d, the tile is $tile_int%10h\n")
      //      print(Console.RESET)
    } else {
      //      print(Console.GREEN)
//            print(s"Same at $glb_idx, the result is $dut_val, expected ${ref_array(glb_idx)}\n")
      //      print(Console.RESET)
    }
  }

  def apply[T: Numeric : ClassTag](
                                    o_stream: Axi4Stream,
                                    clockDomain: ClockDomain,
                                    ref_array: Array[T],
                                    dut_array: Array[T],
                                    H: Int,
                                    T: Int,
                                    TP: Int,
                                    C: Int,
                                    CP: Int,
                                    TRUNCATE: Int = 0,
                                    verbose: Boolean = false,
                                    unpack: Boolean = false, // if unpacked, TP parallelism is unpacked to TP cycles
                                    info: String = "",
                                    is_signed: Boolean = true,
                                    compare: Boolean = true
                                  ): Unit = {
    // some hyper parameters
    val TT = T / TP
    val CT = C / CP
    // get the spinal simulation time of the beginning
    val start_time = simTime()
    val real_start_time = System.currentTimeMillis()
    // progress bar
    val bar = new ProgressBar(info, H * TT * CT)
    // loop
    for (h <- 0 until H) {
      for (tt <- 0 until TT) {
        for (ct <- 0 until CT) {
          // update progress bar
          if (verbose) bar.update(1)
          // assign ready
          o_stream.ready #= true
          if (!unpack) {
            // get result
            clockDomain.waitSamplingWhere(o_stream.valid.toBoolean && o_stream.ready.toBoolean)
            val tile_int = o_stream.data.toBigInt
//            if(info=="yz")
//            println(ct)
            // resolve TP*CP elements
            val o_bits = o_stream.config.dataWidth * 8 / TP / CP
            val local_array = resolve_tile(tile_int, o_bits, TP, CP, is_signed = is_signed)
            // put the local array to the global array
            for (tp <- 0 until TP) {
              for (cp <- 0 until CP) {
                val loc_idx = tp * CP + cp
                val glb_idx = h * T * C + (tt * TP + tp) * C + ct * CP + cp
                // use Implicitly conversion to convert T to Long
                dut_array(glb_idx) = implicitly[Numeric[T]].fromInt((local_array(loc_idx) >> TRUNCATE).toInt)
                if (compare) compare_dut_ref(dut_array(glb_idx), ref_array, tile_int, glb_idx, info)
              }
            }
          } else {
            // repeat TP times to collect the tile
            for (tp <- 0 until TP) {
              // get result
              clockDomain.waitSamplingWhere(o_stream.valid.toBoolean && o_stream.ready.toBoolean)
              val tile_int = o_stream.data.toBigInt
              // resolve CP elements
              val o_bits = o_stream.config.dataWidth * 8 / CP
              val local_array = resolve_tile(tile_int, o_bits, 1, CP, is_signed = is_signed)
              // put the local array to the global array
              for (cp <- 0 until CP) {
                val loc_idx = cp
                val glb_idx = h * T * C + (tt * TP + tp) * C + ct * CP + cp
                //                dut_array(glb_idx) = local_array(loc_idx) >> TRUNCATE
                // use Implicitly conversion to convert T to Long
                dut_array(glb_idx) = implicitly[Numeric[T]].fromInt((local_array(loc_idx) >> TRUNCATE).toInt)
                if (compare) compare_dut_ref(dut_array(glb_idx), ref_array, tile_int, glb_idx, info)
              }
            }
          }
          // de-assert ready
          o_stream.ready #= false
        }
      }
    }

    val end_time = simTime()
    val real_end_time = System.currentTimeMillis()
    // calculate the KHz of the simulation
    val cycles = (end_time - start_time) / 10 // 10 is the period of the clock
    val real_elapsed_time: Float = (real_end_time - real_start_time) / 1000 // 1000 is milliseconds
    val KHz: Float = cycles / real_elapsed_time / 1000
    // output thread done
    println(f"output thread $info%20s done, cycles elapsed: $cycles%10d, real time elapsed: $real_elapsed_time%4.2f, KHz: $KHz%2.2f")
    // delay 1 cycle
    clockDomain.waitSampling()
  }
}

object stream2stream {
  private def resolve_tile(tile_int: BigInt, o_bits: Int, TP: Int, CP: Int, is_signed: Boolean): Array[Long] = {
    // resolve a tile to a local array
    val local_array = new Array[Long](TP * CP)
    // resolve the tile
    for (tp <- 0 until TP) {
      for (cp <- 0 until CP) {
        val loc_idx = tp * CP + cp
        // FIXME: Don't Touch! Magic!
        val part_val = (tile_int >> (o_bits * loc_idx)) & BigInt("1" * o_bits, 2)
        //        val sign_bit = (part_val >> (o_bits - 1)) & 1
        val sign_bit: BigInt = if (is_signed) (part_val >> (o_bits - 1)) & 1 else 0
        local_array(loc_idx) = (part_val - (sign_bit << o_bits)).toLong
      }
    }
    local_array
  }

  private def compare_dut_ref[T: Numeric : ClassTag](dut_val: T, ref_array: Array[T], tile_int: BigInt, glb_idx: Int, info: String = ""): Unit = {
    if (dut_val != ref_array(glb_idx)) {
      //      print(Console.RED)
      //      print(s"$info different at $glb_idx, the result is $dut_val, expected ${ref_array(glb_idx)}\n")
      // set width for print
      print(f"$info different at $glb_idx%10d, the result is ${dut_val.toInt}%10d, expected ${ref_array(glb_idx).toInt}%10d, the tile is $tile_int%10h\n")
      //      print(Console.RESET)
    } else {
      //      print(Console.GREEN)
      //      print(s"Same at $glb_idx, the result is $dut_val, expected ${ref_array(glb_idx)}\n")
      //      print(Console.RESET)
    }
  }

  def apply[T: Numeric : ClassTag](
                                    o_stream: Axi4Stream,
                                    i_stream: Axi4Stream,
                                    clockDomain: ClockDomain,
                                    ref_array: Array[T],
                                    dut_array: Array[T],
                                    H: Int,
                                    T: Int,
                                    TP: Int,
                                    C: Int,
                                    CP: Int,
                                    TRUNCATE: Int = 0,
                                    verbose: Boolean = false,
                                    unpack: Boolean = false, // if unpacked, TP parallelism is unpacked to TP cycles
                                    info: String = "",
                                    is_signed: Boolean = true,
                                    compare: Boolean = true
                                  ): Unit = {
    // some hyper parameters
    val TT = T / TP
    val CT = C / CP
    // get the spinal simulation time of the beginning
    val start_time = simTime()
    val real_start_time = System.currentTimeMillis()
    // progress bar
    val bar = new ProgressBar(info, H * TT * CT)
    // loop
    for (h <- 0 until H) {
      for (tt <- 0 until TT) {
        for (ct <- 0 until CT) {
          // update progress bar
          if (verbose) bar.update(1)
          // assign ready
          o_stream.ready #= true
          var tile:BigInt =0
          if (!unpack) {
            // get result
            clockDomain.waitSamplingWhere(o_stream.valid.toBoolean && o_stream.ready.toBoolean)
            val tile_int = o_stream.data.toBigInt
            tile = o_stream.data.toBigInt
            if(info=="check")
              println(ct)
            // resolve TP*CP elements
            val o_bits = o_stream.config.dataWidth * 8 / TP / CP
            val local_array = resolve_tile(tile_int, o_bits, TP, CP, is_signed = is_signed)
            // put the local array to the global array
            for (tp <- 0 until TP) {
              for (cp <- 0 until CP) {
                val loc_idx = tp * CP + cp
                val glb_idx = h * T * C + (tt * TP + tp) * C + ct * CP + cp
                // use Implicitly conversion to convert T to Long
                dut_array(glb_idx) = implicitly[Numeric[T]].fromInt((local_array(loc_idx) >> TRUNCATE).toInt)
                if (compare) compare_dut_ref(dut_array(glb_idx), ref_array, tile_int, glb_idx, info)
              }
            }

          } else {
            // repeat TP times to collect the tile
            for (tp <- 0 until TP) {
              // get result
              clockDomain.waitSamplingWhere(o_stream.valid.toBoolean && o_stream.ready.toBoolean)
              val tile_int = o_stream.data.toBigInt
              // resolve CP elements
              val o_bits = o_stream.config.dataWidth * 8 / CP
              val local_array = resolve_tile(tile_int, o_bits, 1, CP, is_signed = is_signed)
              // put the local array to the global array
              for (cp <- 0 until CP) {
                val loc_idx = cp
                val glb_idx = h * T * C + (tt * TP + tp) * C + ct * CP + cp
                //                dut_array(glb_idx) = local_array(loc_idx) >> TRUNCATE
                // use Implicitly conversion to convert T to Long
                dut_array(glb_idx) = implicitly[Numeric[T]].fromInt((local_array(loc_idx) >> TRUNCATE).toInt)
                if (compare) compare_dut_ref(dut_array(glb_idx), ref_array, tile_int, glb_idx, info)
              }
            }
          }
          // de-assert ready
          o_stream.ready #= false
          i_stream.valid #= true
          i_stream.data #= tile
          clockDomain.waitSamplingWhere(i_stream.ready.toBoolean && i_stream.valid.toBoolean)
          i_stream.valid #= false
          if(info=="check")
            println(ct)
        }
      }
    }

    val end_time = simTime()
    val real_end_time = System.currentTimeMillis()
    // calculate the KHz of the simulation
    val cycles = (end_time - start_time) / 10 // 10 is the period of the clock
    val real_elapsed_time: Float = (real_end_time - real_start_time) / 1000 // 1000 is milliseconds
    val KHz: Float = cycles / real_elapsed_time / 1000
    // output thread done
    println(f"output thread $info%20s done, cycles elapsed: $cycles%10d, real time elapsed: $real_elapsed_time%4.2f, KHz: $KHz%2.2f")
    // delay 1 cycle
    clockDomain.waitSampling()
  }
}

object compare_array {
  def apply[T: Numeric : ClassTag](ref_array: Array[T], dut_array: Array[T],info: String = ""): Unit = {
    var flag = true
    for (i <- ref_array.indices) {
      if (ref_array(i) != dut_array(i)) {
        print(s"${info} Different at $i, the result is ${dut_array(i)}, expected ${ref_array(i)}\n")
        flag = false
      } else {
        //        print(Console.GREEN)
        //        print(s"Same at $i, the result is ${dut_array(i)}, expected ${ref_array(i)}\n")
        //        print(Console.RESET)
      }
    }
    if (flag) println("All the same!")
    //    else println("ERROR!")
    else System.err.println("ERROR!")
  }
}

object launch_ap_ctrl {
  def apply(ap_ctrl: ApChain, clockDomain: ClockDomain): Unit = {
    // initialize ap_ctrl
    clockDomain.waitSamplingWhere(ap_ctrl.ap_idle.toBoolean)
    ap_ctrl.ap_start #= true
    clockDomain.waitSamplingWhere(ap_ctrl.ap_ready.toBoolean)
    ap_ctrl.ap_start #= false
    clockDomain.waitSamplingWhere(ap_ctrl.ap_idle.toBoolean)
    println(s"ctrl thread done")
    clockDomain.waitSampling(1)
  }
}

object init_clock {
  def apply(clockDomain: ClockDomain, period: Int): Unit = {
    clockDomain.forkStimulus(period = period)
    clockDomain.assertReset()
    clockDomain.waitSampling(5)
    clockDomain.deassertReset()
  }
}


case class AddressSeparableAxiLite4Driver(axi: AxiLite4, clockDomain: ClockDomain) {

  def reset(): Unit = {
    axi.aw.valid #= false
    axi.w.valid #= false
    axi.ar.valid #= false
    axi.r.ready #= true
    axi.b.ready #= true
  }

  def read(address: BigInt): BigInt = {
    axi.ar.payload.prot.assignBigInt(6)
    axi.ar.valid #= true
    axi.ar.payload.addr #= address
    axi.r.ready #= true
    clockDomain.waitSamplingWhere(axi.ar.ready.toBoolean)

    axi.ar.valid #= false
    clockDomain.waitSamplingWhere(axi.r.valid.toBoolean)

    axi.r.ready #= false
    axi.r.payload.data.toBigInt
  }

  def write(address: BigInt, data: BigInt): Unit = {
    axi.aw.payload.prot.assignBigInt(6)
    axi.w.payload.strb.assignBigInt((1 << axi.w.payload.strb.getWidth) - 1)
    val aw_thread = fork {
      axi.aw.valid #= true
      axi.aw.payload.addr #= address
      clockDomain.waitSamplingWhere(axi.aw.ready.toBoolean)
      axi.aw.valid #= false
    }
    val w_thread = fork {
      axi.w.valid #= true
      axi.w.payload.data #= data
      clockDomain.waitSamplingWhere(axi.w.ready.toBoolean)
      axi.w.valid #= false
    }
    aw_thread.join()
    w_thread.join()
    // force a cycle
    clockDomain.waitSampling(5)
  } // end of write
}

object init_ap_ctrl {
  def apply(ap_ctrl: ApChain): Unit = {
    ap_ctrl.ap_start #= false
    ap_ctrl.ap_continue #= true
  }
}

object init_stream {
  def apply(stream: Axi4Stream): Unit = {
    stream.valid #= false
    stream.ready #= false
    stream.data.randomize()
  }
}

object init_i_stream {
  def apply(i_stream: Axi4Stream): Unit = {
    i_stream.valid #= false
    i_stream.data.randomize()
  }
}

object init_o_stream {
  def apply(o_stream: Axi4Stream): Unit = {
    o_stream.ready #= false
  }
}

object init_daisy_chain {
  def apply(daisy_chain: DaisyChain[ManagerSignals]): Unit = {
    daisy_chain.I.L_BEGIN.randomize()
    daisy_chain.I.L_CLOSE.randomize()
    daisy_chain.I.POS.randomize()
    daisy_chain.I.T #= false
  }
}
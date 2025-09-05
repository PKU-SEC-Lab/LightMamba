package utils

import spinal.core._
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4Stream
import spinal.lib.bus.amba4.axis.{Axi4Stream, Axi4StreamConfig}
import spinal.lib.{StreamFifo, master, slave}

import scala.language.postfixOps

// Residual fifo, with stream interface
//class Fifo(streamConfig: Axi4StreamConfig, depth: Int = 512) extends Component {
//
//  val io = new Bundle {
//    val i_stream: Axi4Stream = slave(Axi4Stream(streamConfig))
//    val o_stream: Axi4Stream = master(Axi4Stream(streamConfig))
//  }
//
//  // create a local fifo
//  val fifo: StreamFifo[Bits] = StreamFifo(Bits(8 * streamConfig.dataWidth bits), depth)
//  // connect the fifo
//  io.i_stream.ready <> fifo.io.push.ready
//  io.i_stream.valid <> fifo.io.push.valid
//  io.i_stream.payload.data <> fifo.io.push.payload
//
//  io.o_stream.ready <> fifo.io.pop.ready
//  io.o_stream.valid <> fifo.io.pop.valid
//  io.o_stream.payload.data <> fifo.io.pop.payload
//}


case class Fifo(config: Axi4StreamConfig, depth: Int) extends Component {
  // 定义输入输出接口
  val io = new Bundle {
    val i_stream = slave(Axi4Stream(config))
    val o_stream = master(Axi4Stream(config))
  }

  // FIFO的寄存器定义
  val fifoMem = Mem(Bits(config.dataWidth * 8 bits), depth)
  val writePtr = Reg(UInt(log2Up(depth) bits)) init (0)
  val readPtr = Reg(UInt(log2Up(depth) bits)) init (0)
  val fifoOccupancy = Reg(UInt(log2Up(depth + 1) bits)) init (0)

  // AXI4 Stream的有效性信号
  val fifoFull = fifoOccupancy === depth - 1
  val fifoEmpty = fifoOccupancy === 0

  // 写入逻辑：当输入接口有效且FIFO未满时，写入数据
  when(io.i_stream.valid && !fifoFull) {
    fifoMem(writePtr) := io.i_stream.payload.data
    writePtr := writePtr + 1
    fifoOccupancy := fifoOccupancy + 1
  }

  // 输出逻辑：当输出接口准备好且FIFO非空时，输出数据
  io.o_stream.valid := !fifoEmpty
  io.o_stream.payload.data := fifoMem(readPtr)

  when(io.o_stream.ready && !fifoEmpty) {
    readPtr := readPtr + 1
    fifoOccupancy := fifoOccupancy - 1
  }

  // 处理输入ready信号：当FIFO未满时，表示可以继续接收数据
  io.i_stream.ready := !fifoFull
}

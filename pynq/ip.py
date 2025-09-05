# Drivers for Xilinx Versal FPGA IPs
import mmap
import struct
import numpy
import os
import time
import numpy as np
import threading
from time import sleep
from tqdm import tqdm

from clock_configs import *

class AXI_MEM:
    def __init__(self, base_addr, dtype: np.dtype, length=None, bytes=None):
        # 3 cases:
        # 1. length is None, bytes is None -> length = 1
        # 2. length is None: length = bytes / np.dtype(dtype).itemsize
        # 3. bytes is None: length is length

        if length is None and bytes is None:
            length = 1
        elif length is None and bytes is not None:
            length = bytes // np.dtype(dtype).itemsize
        elif length is not None and bytes is None:
            pass
        else:
            raise ValueError("Invalid parameters")

        self.base_addr = base_addr
        self.dtype = dtype
        self.length = length
        self.size = np.dtype(dtype).itemsize * length

        # align the base address to the page size
        self.page_offset = base_addr % mmap.PAGESIZE

        # Opening /dev/mem with read and write access
        self.fd = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)

        # Mapping memory with aligned address and size
        self.mem = mmap.mmap(self.fd, self.size + self.page_offset, mmap.MAP_SHARED, mmap.PROT_READ | mmap.PROT_WRITE, offset=base_addr - self.page_offset)

        # Adjusting the numpy buffer to point to the correct location
        self.buffer = np.frombuffer(self.mem, dtype=dtype, count=length, offset=self.page_offset)

    def read(self, index=0):
        # Read a value from the memory
        return self.buffer[index]

    def write(self, value, index=0):
        # Write a value to the memory
        self.buffer[index] = value

    def __del__(self):
        # Clean up
        self.mem.close()
        os.close(self.fd)
    
    def __getitem__(self, index):
        return self.read(index)

    def __setitem__(self, index, value):
        self.write(value, index)


AXI_REGISTER = AXI_MEM


def AXI_IP(base_addr, reg_list):
    class _AXI_IP:
        def __init__(self, _base_addr, _reg_list):
            self.registers = {}
            for name, offset, dtype in _reg_list:
                abs_addr = _base_addr + offset
                reg = AXI_REGISTER(abs_addr, dtype)
                self.registers[name] = reg
                self._create_property(name)

        def _create_property(self, name):
            def getter(self):
                return self.registers[name].read()
            def setter(self, value):
                self.registers[name].write(value)
            # Create the property and attach it to the instance
            setattr(self.__class__, name, property(getter, setter))
        
    return _AXI_IP(base_addr, reg_list)


class AXI_DMA_CHANNEL:

    _AXI_DMA_MM2S_REGISTER_LIST = (
        ("DMACR",  0x00, np.uint32), # Control register
        ("DMASR",  0x04, np.uint32), # Status register
        ("A",      0x18, np.uint32), # Source address
        ("A_MSB",  0x1C, np.uint32), # Source address (MSB)
        ("LENGTH", 0x28, np.uint32), # Transfer length
    )

    _AXI_DMA_S2MM_REGISTER_LIST = (
        ("DMACR",  0x30, np.uint32), # Control register
        ("DMASR",  0x34, np.uint32), # Status register
        ("A",      0x48, np.uint32), # Destination address
        ("A_MSB",  0x4C, np.uint32), # Destination address (MSB)
        ("LENGTH", 0x58, np.uint32), # Transfer length
    )

    # the composition of DMACR:
    # bit 0:        RS - Run/Stop, 0 = Stop, 1 = Run
    # bit 1:        Reserved
    # bit 2:        Reset
    # bit 3:        Keyhole
    # bit 4:        Cyclic BD enable
    # bit 5-11:     Reserved
    # bit 12:       IOC_IrqEn, 0 = Interrupt on complete disable, 1 = Interrupt on complete enable
    # bit 13:       Dly_IrqEn, 0 = Interrupt on delay disable, 1 = Interrupt on delay enable
    # bit 14:       Err_IrqEn, 0 = Interrupt on error disable, 1 = Interrupt on error enable
    # bit 15:       Reserved
    # bit 16-23:    IRQThreshold
    # bit 24-31:    IRQDelay

    # the composition of DMASR:
    # bit 0:        Halted - 0 = DMA channel is running, 1 = DMA channel is halted
    # bit 1:        Idle - 0 = DMA channel is busy, 1 = DMA channel is idle
    # bit 2:        Reserved
    # bit 3:        SGIncld - Scatter/Gather mode enabled
    # bit 4:        DMAIntErr - DMA internal error
    # bit 5:        DMASlvErr - DMA slave error
    # bit 6:        DMADecErr - DMA decode error
    # bit 7:        Reserved
    # bit 8:        SGIntErr - Scatter/Gather internal error
    # bit 9:        SGSlvErr - Scatter/Gather slave error
    # bit 10:       SGDecErr - Scatter/Gather decode error
    # bit 11:       Reserved
    # bit 12:       IOC_Irq - Interrupt on complete
    # bit 13:       Dly_Irq - Interrupt on delay
    # bit 14:       Err_Irq - Interrupt on error
    # bit 15:       Reserved
    # bit 16-23:    IRQThresholdSts
    # bit 24-31:    IRQDelaySts

    def __init__(self, base_address, mode):
        if mode == "mm2s":
            register_list = self._AXI_DMA_MM2S_REGISTER_LIST
        elif mode == "s2mm":
            register_list = self._AXI_DMA_S2MM_REGISTER_LIST
        else:
            raise ValueError("Invalid mode")

        self.base_address = base_address
        self.mode = mode
        self.ip = AXI_IP(base_address, register_list)

    def enable(self, en=True):
        self.ip.DMACR = 1 if en else 0
    
    def reset(self):
        self.ip.DMACR = 4
        sleep(0.01)
        self.ip.DMACR = 0
    
    @property
    def halted(self):
        return self.ip.DMASR & 1
    
    @property
    def idle(self):
        return (self.ip.DMASR >> 1) & 1
    
    def transfer(self, src, bytes):
        # set address
        self.ip.A = src & int("1"*32, 2)
        self.ip.A_MSB = src >> 32
        self.ip.LENGTH = bytes
    
    def wait(self):
        while not self.idle:
            sleep(0.00001)
    
    def print_status(self):
        # include running, halted, idle, length, and address
        print(f"Running: {self.ip.DMACR & 1}, Halted: {self.halted}, Idle: {self.idle}, Length: {self.ip.LENGTH}, Address: {self.ip.A_MSB:08x}{self.ip.A:08x}")

class AXI_DMA:
    def __init__(self, base_address):
        self.base_address = base_address
        self.mm2s = AXI_DMA_CHANNEL(base_address, "mm2s")
        self.s2mm = AXI_DMA_CHANNEL(base_address, "s2mm")
    
    def reset(self):
        self.mm2s.reset()
        self.s2mm.reset()


class AXI_CLOCK:
    def __init__(self, base_address):
        self.base_address = base_address
        self.mem = AXI_MEM(base_address, dtype=np.uint32, length=0x400)
    
    def refresh(self, s):
        # s is a string
        s = s.strip()
        for line in s.split("\n"):
            offset, value = map(lambda x: int(x, 16), line.split(" "))
            offset //= 4 # convert to 32-bit word offset
            self.mem[offset] = value
        # load
        self.mem[0x014 // 4] = 0x0000_0003


class PL_RESET:
    def __init__(self):
        self.base_address = 0x00F1260330
        self.reg = AXI_REGISTER(self.base_address, np.uint8)
        
    def reset(self):
        self.reg.write(0b0000_1111)
        sleep(0.01)
        self.reg.write(0x0000_0000)
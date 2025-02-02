#!/usr/bin/env python2.7
# send_dcp.py - Send a DCP packet
# Copyright (c) 2012 Atomic Rules LLC - ALL Rights Reserved

import optparse
import os
import re
import subprocess
import sys
import time

from scapy.all import *

def main(argv):
  print """Hello from %s""" % (prog_name)
  p = Ether()
  p.src  = '00:26:E1:01:01:00'   # Linux Host Source MAC Address
# p.dst  = '00:0A:35:42:01:00'   # Xilinx FPGA Dest MAC Address
# p.dst  = 'A0:36:FA:25:3B:81'   # Ettus FPGA Dest MAC Address
  p.dst  = 'A0:36:FA:25:3E:A5'   # Ettus N210 Dest MAC Address
  p.type = 0xF040                # EtherType TCP
  #p.payload = "\x00\x0A\x00\x00\x0F\x05\x80\x00\x00\x01"                    # 10B NOP
  p.payload = "\x00\x0E\x00\x00\x1F\x56\x00\x00\x00\x24\x22\x33\x44\x55"     # 14B Write 0x24 with 0x1234567F
  #p.payload = "\x00\x0A\x00\x00\x2F\x07\x00\x00\x00\x24"                     # 10B Read 0x24
  #p.payload = "\x00\x0A\x00\x00\x2F\x07\x00\x00\x00\x00"                     # 10B Read 0x00
  print "Sending packet..."
  r = srp(p, iface="eth1")
  print r
  print 'r is a ' + str(type(r))


prog_name = os.path.basename(sys.argv[0])
if __name__ == '__main__':
    main(sys.argv)

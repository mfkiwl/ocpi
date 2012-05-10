// DCP.bsv - DWORD Control Packet
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED

// This module digests DCP (ad hoc EtherType 0xF040) payloads
// DCP Requests arriving are assumed correct as tagged; upstream logic strips 6+6+2 Byte Ethernet header

import CPDefs       ::*; 

import ClientServer ::*; 
import Clocks       ::*;
import FIFO         ::*;	
import GetPut       ::*;
import Vector       ::*;

typedef enum {
  NOP      = 4'h0,
  Write    = 4'h1,
  Read     = 4'h2,
  Response = 4'h3,
  Pad      = 4'hF
} DCPMesgType deriving (Bits, Eq);

typedef struct {
  Bit#(8)  tag;
  Bit#(32) initAdvert;
} DCPRequestNOP deriving (Bits, Eq);

typedef struct {
  Bit#(4)  be;
  Bit#(8)  tag;
  Bit#(32) data;
  Bit#(32) addr;
} DCPRequestWrite deriving (Bits, Eq);

typedef struct {
  Bit#(4)  be;
  Bit#(8)  tag;
  Bit#(32) addr;
} DCPRequestRead deriving (Bits, Eq);

typedef union tagged {
  DCPRequestNOP    NOP;
  DCPRequestWrite  Write;
  DCPRequestRead   Read;
} DCPRequest deriving (Bits);

typedef enum {
  RESP_OK      = 4'h0,
  RESP_TIMEOUT = 4'h1,
  RESP_ERROR   = 4'h2
} DCPRespCode deriving (Bits, Eq);

typedef struct {
  Bit#(32)    targAdvert;
  Bit#(8)     tag;
  DCPRespCode code;
} DCPResponseNOP deriving (Bits, Eq);

typedef struct {
  Bit#(8)     tag;
  DCPRespCode code;
} DCPResponseWrite deriving (Bits, Eq);

typedef struct {
  Bit#(32)    data;
  Bit#(8)     tag;
  DCPRespCode code;
} DCPResponseRead deriving (Bits, Eq);

typedef union tagged {
  DCPResponseNOP    NOP;
  DCPResponseWrite  Write;
  DCPResponseRead   Read;
} DCPResponse deriving (Bits);

interface DCPAdapterIfc;
  interface Server#(DCPRequest,DCPResponse) server; 
  interface Client#(CpReq,CpReadResp)       client; 
endinterface 

module mkDCPAdapter#(Clock cpClock, Reset cpReset) (DCPAdapterIfc);

  FIFO#(DCPRequest)        dcpReqF   <- mkFIFO;                          // Inbound   DCP Requests
  FIFO#(DCPResponse)       dcpRespF  <- mkFIFO;                          // Outbound  DCP Responses
//FIFO#(CpReq)             cpReqF    <- mkFIFO;                          // Control-plane Requests
  SyncFIFOIfc#(CpReq)      cpReqF    <- mkSyncFIFOFromCC(4, cpClock); 
//FIFO#(CpReadResp)        cpRespF   <- mkFIFO;                          // Control-plane Responses
  SyncFIFOIfc#(CpReadResp) cpRespF   <- mkSyncFIFOToCC(4, cpClock, cpReset); 

  rule dcp_request;
    let x = dcpReqF.first; dcpReqF.deq;
    case (x) matches
      tagged NOP   .n: dcpRespF.enq(tagged NOP( DCPResponseNOP{targAdvert:32'h4000_0001, tag:n.tag, code:RESP_OK}));        // Respond to the NOP
      tagged Write .w: begin
                       cpReqF.enq(tagged WriteRequest( CpWriteReq{dwAddr:truncate(w.addr>>2), byteEn:w.be, data:w.data}));  // Issue the Write
                       dcpRespF.enq(tagged Write( DCPResponseWrite{tag:w.tag, code:RESP_OK}));                              // Blind ACK the Write
                       end
      tagged Read  .r: cpReqF.enq(tagged ReadRequest(  CpReadReq {dwAddr:truncate(r.addr>>2), byteEn:r.be, tag:r.tag}));    // Issue the Read
    endcase
  endrule

  rule cp_response;
    let y = cpRespF.first; cpRespF.deq;
    dcpRespF.enq(tagged Read( DCPResponseRead{data:y.data, tag:y.tag, code:RESP_OK}));  // Advance the CP Read response
  endrule

  interface Server server;  // Facing the DCP Packet Side
    interface request  = toPut(dcpReqF);
    interface response = toGet(dcpRespF);
  endinterface
  interface Client client;  // Facing the Control Plane
    interface request  = toGet(cpReqF);
    interface response = toPut(cpRespF);
  endinterface
endmodule

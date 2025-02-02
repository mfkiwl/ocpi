// TLPServBC.bsv - TLP Server, BRAM Client
// Copyright (c) 2009,2010,2011,2102 Atomic Rules LLC - ALL RIGHTS RESERVED

// For use with Bluesim, you need to undefine USE_SRLFIFO, as mkSRLFIFO is not yet a BSV 
// primative, it is importBVI of Atomic Rules Verilog...
//`define USE_SRLFIFO

import OCBufQ::*;
import OCWip::*;
import PCIE::*;
import SRLFIFO::*;
import TLPBRAM::*;
import TLPMF::*;

import BRAM::*;
import ClientServer::*; 
import DReg::*;
import FIFO::*;
import FIFOF::*;
import GetPut::*;
import Vector::*;

interface TLPServBCIfc;
  interface Server#(PTW16,PTW16) server;
  interface BufQCIfc             bufq;
  method Action                  dpCtrl (DPControl dc);
  method Bit#(32)                i_flowDiagCount;
  method Bit#(32)                i_debug;
  method Vector#(4,Bit#(32))     i_meta;
  method Action                  now    (Bit#(64) arg);
  method Bool  dmaStartPulse;
  method Bool  dmaDonePulse;
endinterface

typedef enum {Idle,NearReqMeta,NearRespMeta,NearReqMesg,PushMesgHead,PushMesgBody,
  PushMetaHead,PushMetaBody,TailEvent,PostDwell} PushDMAState deriving (Bits,Eq);
typedef enum {Idle,FarReqMeta, FarRespMeta, FarReqMesg, PullMesgHead,PullMesgBody,
  TailEvent,PostDwell} PullDMAState deriving (Bits,Eq);

typedef 5 NtagBits; // Must match PCIe configureation: 5b tag is the default; 8b is optional; 11b with phantom-tags stealing 3b device num

// Rule naming for Pull debug...
typedef enum {
  R_none                  = 15,
  R_dmaRequestFarMeta     = 1,
  R_dmaRespHeadFarMeta    = 2,
  R_dmaRespBodyFarMeta    = 3,
  R_dmaPullRequestFarMesg = 4,
  R_dmaPullResponseHeader = 5,
  R_dmaPullResponseBody   = 6,
  R_dmaPullTailEvent      = 7,
  R_dmaTailEventSender32  = 8,
  R_dmaTailEventSender64a = 9,
  R_dmaTailEventSender64b = 10
  } DmaPullRules deriving (Bits,Eq);

module mkTLPServBC#(Vector#(4,BRAMServer#(DPBufHWAddr,Bit#(32))) mem, PciId pciDevice, WciSlaveIfc#(32) wci, Bool hasPush, Bool hasPull) (TLPServBCIfc);

`ifdef USE_SRLFIFO
  Bool useSRL = True;  // Set to True to use SRLFIFOD primitive (more storage, fewer DFFs, more MSLICES/SRLs ) (needs Verilog simulator)
`else
  Bool useSRL = False; // Set to False to allow for Bluesim simulation)
`endif

  FIFOF#(PTW16)              inF                  <- useSRL ? mkSRLFIFOD(4) : mkFIFOF;  // The PTW16 inbound from the NoC
  FIFOF#(PTW16)              outF                 <- useSRL ? mkSRLFIFOD(4) : mkFIFOF;  // The PTW16 outbound to the NoC
  TLPBRAMIfc                 tlpBRAM              <- mkTLPBRAM(mem);
  FIFOF#(Bit#(1))            tailEventF           <- mkFIFOF;
  Reg#(Bool)                 inIgnorePkt          <- mkRegU;
  Reg#(Bit#(10))             outDwRemain          <- mkRegU;
  Reg#(Bool)                 tlpRcvBusy           <- mkReg(False);  // the inbound, downstream mutex
  Reg#(Bool)                 tlpXmtBusy           <- mkReg(False);  // the outbound,  upstream mutex
  Reg#(Bool)                 remStart             <- mkDReg(False);
  Reg#(Bool)                 remDone              <- mkDReg(False);
  Reg#(Bool)                 nearBufReady         <- mkDReg(False);
  Reg#(Bool)                 farBufReady          <- mkDReg(False);
  Reg#(Bool)                 creditReady          <- mkDReg(False);
  Reg#(Bit#(16))             remMetaAddr          <- mkRegU;
  Reg#(Bit#(16))             remMesgAddr          <- mkRegU;
  Reg#(Bit#(16))             remMesgAccu          <- mkRegU;
  Reg#(Bit#(32))             fabMetaAddr          <- mkRegU;
  Reg#(Bit#(32))             fabMesgAddr          <- mkRegU;
  Reg#(Bit#(32))             fabFlowAddr          <- mkRegU;
  Reg#(Bit#(32))             fabMetaAddrMS        <- mkRegU;
  Reg#(Bit#(32))             fabMesgAddrMS        <- mkRegU;
  Reg#(Bit#(32))             fabFlowAddrMS        <- mkRegU;
  Reg#(Bit#(32))             srcMesgAccu          <- mkRegU;
  Reg#(Bit#(32))             fabMesgAccu          <- mkRegU;
  Reg#(Bit#(4))              postSeqDwell         <- mkReg(0);
  Reg#(Bit#(4))              doorSeqDwell         <- mkReg(0);
  Reg#(Bool)                 reqMetaInFlight      <- mkReg(False);
  Reg#(Bool)                 reqMetaBodyInFlight  <- mkReg(False);
  Reg#(Bool)                 xmtMetaInFlight      <- mkReg(False);
  Reg#(Bool)                 doXmtMetaBody        <- mkReg(False);
  Reg#(Bool)                 reqMesgInFlight      <- mkReg(False);
  Reg#(Bool)                 xmtMetaOK            <- mkReg(False);
  Reg#(Bool)                 tlpMetaSent          <- mkReg(False);
  Reg#(Bool)                 sentTail4DWHeader    <- mkReg(False);
  Reg#(Maybe#(MesgMeta))     fabMeta              <- mkReg(Invalid);
  Wire#(DPControl)           dpControl            <- mkWire;
  Reg#(Bit#(NtagBits))       dmaTag               <- mkReg(0); 
  Reg#(Bit#(NtagBits))       dmaReqTag            <- mkRegU;
  Reg#(Bit#(10))             dmaPullRemainDWLen   <- mkRegU;
  Reg#(Bit#(10))             dmaPullRemainDWSub   <- mkRegU;
  Reg#(Bool)                 gotResponseHeader    <- mkReg(False);
  Reg#(Bool)                 pullTagMatch         <- mkDReg(False);
  Reg#(Bool)                 dmaDoTailEvent       <- mkReg(False);
  Reg#(Bit#(17))             mesgLengthRemainPush <- mkRegU;      // Size limits maximum DMA message just under 128KB (was 2^24 but slow path) (for Push Logic)
  Reg#(Bit#(17))             mesgLengthRemainPull <- mkRegU;      // Size limits maximum DMA message just under 128KB (was 2^24 but slow path) (for Pull Logic)
  Reg#(Bit#(17))             mesgComplReceived    <- mkRegU;      // Size limits maximum DMA message just under 128KB (was 2^24 but slow path)
  Reg#(Bit#(13))             maxPayloadSize       <- mkReg(128);  // 128B Typical - Must not exceed 4096B
  Reg#(Bit#(13))             maxReadReqSize       <- mkReg(4096); // 512B Typical - Must not exceed 4096B
  Reg#(Bit#(32))             flowDiagCount        <- mkReg(0);
  Reg#(DmaPullRules)         lastRuleFired        <- mkReg(R_none);
  Reg#(Bool)                 complTimerRunning    <- mkReg(False);
  Reg#(UInt#(12))            complTimerCount      <- mkReg(0);
  Vector#(4,Reg#(Bit#(32)))  lastMetaV            <- replicateM(mkReg(0));
  Wire#(Bit#(64))            nowW                 <- mkWire;

  Reg#(Bool)                 dmaStartMark         <- mkDReg(False);
  Reg#(Bool)                 dmaDoneMark          <- mkDReg(False);


  // Note that there are few, if any, reasons why the maxReadReqSize should not be maxed out at 4096 in the current implementation.
  // This is because with only one read in-flight at once, we wish to amortize the serial latency over as large a request as possible.
  // When moving to two or more read-requests per DMA engine in flight at once, we may wish to lower maReadReqSize from the maximum.
  // The team thanks Dan Zhang for bringing this issues front and center. -Shep Siegel 2011-03-10

  Bool actMesgP = (dpControl==fProdActMesg);
  Bool actMesgC = (dpControl==fConsActMesg);
  Bool actFlow  = (dpControl.role==ActFlow);

  //TODO: Understand why psDwell=1 failed dmaTestBasic4 on 2010-11-02
  // Non-Zero dwell required until BufQ logic is cleared of all dead-reckoning; then suggest removal
  Bit#(4) psDwell = (actFlow ? 8 : 4);  // Was 15 in all modes through Q3-CY2011 ; halved and halved again when not activeFlow

  //
  // FPactMesg - Fabric Producer Push DMA Sequence...
  //

  // Request the metadata for the remote-facing ready buffer...
  rule dmaRequestNearMeta (hasPush && actMesgP && !tlpRcvBusy && !reqMetaInFlight && !isValid(fabMeta) && nearBufReady && farBufReady && postSeqDwell==0);
    dmaStartMark    <= True;
    remStart        <= True;   // Indicate to buffer-management remote move start
    reqMetaInFlight <= True;
    ReadReq rreq = ReadReq {
      skipRespData : False,
      role         : Metadata,
      reqID        : PciId {bus:255, dev:31, func:0},
      dwLength     : 4,        // Request all 4DW of metadata (One alligned 16B superword)
      tag          : ?,
      tc           : ?,
      dwAddr       : truncate(remMetaAddr>>2),
      firstBE      : '1,
      lastBE       : '1 };
    MemReqPacket mpkt = ReadHeader(rreq);
    tlpBRAM.putReq.put(mpkt);  // Enqueue BRAM read request for metadata
    $display("[%0d]: %m: dmaRequestNearMeta FPactMesg-Step1/7", $time);
  endrule

  // Accept the first DW metadata back... 
  rule dmaResponseNearMetaHead (hasPush && actMesgP &&& tlpBRAM.getsResp.first matches tagged ReadHead .rres &&& rres.role==Metadata);
    tlpBRAM.getsResp.deq;
    mesgLengthRemainPush <= truncate(byteSwap(rres.data));  // undo the PCI byteSwap on the 1st DW (mesgLength)
    lastMetaV[0]         <=          byteSwap(rres.data);   // push length
    $display("[%0d]: %m: dmaResponseNearMetaHead FPactMesg-Step2a/7 mesgLength:%0x", $time, byteSwap(rres.data));
  endrule

  // Accept the remaining metadata back and then commit to MesgMeta format..
  rule dmaResponseNearMetaBody (hasPush && actMesgP &&& tlpBRAM.getsResp.first matches tagged ReadBody .rres &&& rres.role==Metadata);
    tlpBRAM.getsResp.deq;
    Vector#(4, DWord) vWords = reverse(unpack(rres.data));
    Bit#(32) opcode  = byteSwap(vWords[0]); lastMetaV[1] <= opcode;
    Bit#(32) nowMS   = byteSwap(vWords[1]); lastMetaV[2] <= nowMS;
    Bit#(32) nowLS   = byteSwap(vWords[2]); lastMetaV[3] <= nowLS;
    reqMetaInFlight <= False;
    fabMeta <= (Valid (MesgMeta{length:extend(mesgLengthRemainPush), opcode:opcode, nowMS:nowMS, nowLS:nowLS}));
    xmtMetaOK <= (mesgLengthRemainPush==0); // Skip over Message Movement phases and just send metadata if mesgLength is zero
    mesgLengthRemainPush <= (mesgLengthRemainPush+3) & ~3; // DWORD roundup - shep owes Jim a beer
    remMesgAccu <= remMesgAddr;  // Load the message rem address accumulator so we can locally manage message segments
    srcMesgAccu <= fabMesgAddr;  // Load the message src address accumulator so we can locally manage message segments
    fabMesgAccu <= fabMesgAddr;  // Load the message fab address accumulator so we can locally manage message segments
    $display("[%0d]: %m: dmaResponseNearMetaBody FPactMesg-Step2b/7 opcode:%0x nowMS:%0x nowLS:%0x", $time, opcode, nowMS, nowLS);
  endrule

  // Steps 3, 4a, 4b to be repeated 0-N times.
  //   0 times if there is no message data to be moved.
  //   1 or more times based on how many segments the fabric address-length tuple dictates
  //   Policy includes: i) Do not exceed (typ 128B) Maximum Paylod Size MPS); ii) Do not cross 4KB bounds.

  // Request the message from the remote-facing ready buffer...
  // Inhibit this rule while tlpRcvBusy with other rem buffer access...
  // If needed, make multiple requests until the full extent of the message is traversed, as signalled by mesgLengthRemainPush==0...
  rule dmaPushRequestMesg (hasPush && actMesgP &&& fabMeta matches tagged Valid .meta &&& meta.length!=0 &&& !tlpRcvBusy &&& mesgLengthRemainPush!=0);
    Bit#(13) spanToNextPage = 4096 - extend(srcMesgAccu[11:0]);                                                 // how far until we hit a PCIe 4K Page
    //Bit#(13) thisRequestLength = min(min(truncate(min(mesgLengthRemainPush,4096)),maxPayloadSize),spanToNextPage);  // minimum of what we want and what we are allowed
    Bit#(13) thisRequestLength = min(truncate(min(mesgLengthRemainPush,extend(maxPayloadSize))),spanToNextPage);  // minimum of what we want and what we are allowed 
    mesgLengthRemainPush  <= mesgLengthRemainPush - extend(thisRequestLength);
    //lastSegmentOfMessage <= (mesgLengthRemainPush - extend(thisRequestLength)) < min(maxPayloadSize, f(spanToNextPage) TODO: Needs work to pipeline critical path to EoM tag
    ReadReq rreq = ReadReq {
      skipRespData : (fabMesgAddrMS!='0),  // skip when non-zero MesgMS Addr; This is the special behavior taken for 64b Mesg addr in this rule
      role         : DMASrc,
      reqID        : PciId {bus:255, dev:31, func:0},
      dwLength     : truncate(thisRequestLength>>2),
      tag          : (extend(thisRequestLength)==mesgLengthRemainPush)?8'h01:8'h00, // Tag the last segment of a message request with 8'h01
      tc           : ?,
      dwAddr       : truncate(remMesgAccu>>2),
      firstBE      : '1,
      lastBE       : '1 };
    MemReqPacket mpkt = ReadHeader(rreq);
    srcMesgAccu <= srcMesgAccu + extend(thisRequestLength);  // increment src side of the message dest address
    remMesgAccu <= remMesgAccu + extend(thisRequestLength);  // increment the rem address accumulator
    tlpBRAM.putReq.put(mpkt);  // Enqueue BRAM read request for message data
    $display("[%0d]: %m: dmaPushRequestMesg FPactMesg-Step3/7", $time);
  endrule

  // Transform the local read response header to a PCIe posted write request header for push DMA...
  rule dmaPushResponseHeader (hasPush && actMesgP &&& tlpBRAM.getsResp.first matches tagged ReadHead .rres &&& rres.role==DMASrc && !tlpXmtBusy && postSeqDwell==0);
    Bool onlyBeatInSegment = (rres.dwLength==1);
    Bool lastSegmentInMesg = (rres.tag==8'h01); 

    // This rule has two different behaviors depending on if we must make a 32b or 64b MWr request
    if (fabMesgAddrMS=='0) begin  // 32b addr, use 3DW and send 1DW data...
      MemReqHdr1 h = makeWrReqHdr(pciDevice, rres.dwLength, '1, (rres.dwLength>1)?'1:'0, False); // TODO: Byte Enable Support
      let w = PTW16 { data : {pack(h), fabMesgAccu, rres.data}, be:'1, hit:7'h2, sof:True, eof:onlyBeatInSegment };
      outF.enq(w);  // Out goes the 3DW request + 1 DW write data
    end else begin               // 64b addr, use 4DW and no data in this MWr...
      onlyBeatInSegment = False;
      MemReqHdr1 h = makeWrReqHdr(pciDevice, rres.dwLength, '1, (rres.dwLength>1)?'1:'0, True); // 4DW MWr
      let w = PTW16 { data : {pack(h), fabMesgAddrMS, fabMesgAccu}, be:'1, hit:7'h2, sof:True, eof:onlyBeatInSegment };
      outF.enq(w);  // Out goes the 4DW request + no data
    end

    outDwRemain <= rres.dwLength - ((fabMesgAddrMS=='0) ? 1 : 0);  // update dwords remaining
    fabMesgAccu <= fabMesgAccu + (extend(rres.dwLength)<<2);       // increment the fabric address accumulator
    if (!onlyBeatInSegment) tlpXmtBusy <= True;                    // acquire outbound mutex
    if ( onlyBeatInSegment && lastSegmentInMesg) begin
      xmtMetaOK  <= True;   // message sent, move on to metadata
      tlpXmtBusy <= False;  // release outbound mutex
    end
    tlpBRAM.getsResp.deq; // Consume the BRAM response, even if there was no data and just header
    $display("[%0d]: %m: dmaPushResponseHeader FPactMesg-Step4a/7", $time);
  endrule

  // continue the transformation for the local-read to fabric-write payload body...
  // this rule finishes up the push without regard to message address space
  rule dmaPushResponseBody (hasPush && actMesgP &&& tlpBRAM.getsResp.first matches tagged ReadBody .rbody &&& rbody.role==DMASrc);
    tlpBRAM.getsResp.deq;
    Bool lastBeatInSegment = (outDwRemain <= 4);
    Bool lastSegmentInMesg = (rbody.tag==8'h01); 
    PTW16 w = TLPData {
                data : rbody.data,
                be   : (lastBeatInSegment ? remFromDW(outDwRemain[1:0]) : '1),
                hit  : 7'h2,
                sof  : False,
                eof  : lastBeatInSegment };
    outF.enq(w);  // out goes follow-on write data
    outDwRemain <= outDwRemain - 4;                                   // update DW remaining in this segment
    if (lastBeatInSegment)                      tlpXmtBusy <= False;  // release outbound mutex
    if (lastBeatInSegment && lastSegmentInMesg) xmtMetaOK  <= True;   // message sent, move on to metadata
    $display("[%0d]: %m: dmaPushResponseBody FPactMesg-Step4b/7", $time);
  endrule

  // Transmit the Metadata header...
  rule dmaXmtMetaHead (hasPush && actMesgP &&& fabMeta matches tagged Valid .meta &&& !tlpXmtBusy && !xmtMetaInFlight && xmtMetaOK && postSeqDwell==0);
    xmtMetaInFlight <= True;
    tlpXmtBusy      <= True;
    doXmtMetaBody   <= True;
    xmtMetaOK       <= False;
    // This rule has two different behaviors depending on if we must make a 32b or 64b MWr request
    if (fabMetaAddrMS=='0) begin
      MemReqHdr1 h = makeWrReqHdr(pciDevice, 4, '1, '1, False); 
      let w = PTW16 { data : {pack(h), fabMetaAddr, byteSwap(extend(meta.length))}, be:'1, hit:7'h2, sof:True, eof:False };
      outF.enq(w);  // Out goes 3DW header + 1 DW of metadata
    end else begin
      MemReqHdr1 h = makeWrReqHdr(pciDevice, 4, '1, '1, True); 
      let w = PTW16 { data : {pack(h), fabMetaAddrMS, fabMetaAddr}, be:'1, hit:7'h2, sof:True, eof:False };
      outF.enq(w);  // Out goes 4DW header + 0 Data
    end
    $display("[%0d]: %m: dmaXmtMetaHead FPactMesg-Step5/7", $time);
  endrule

  // and then the Metadata body...
  rule dmaXmtMetaBody (hasPush && actMesgP &&& fabMeta matches tagged Valid .meta &&& doXmtMetaBody);
    remDone         <= True;  // Indicate to buffer-management remote move done (tail event doesn't care about mesg/meta state)
    doXmtMetaBody   <= False;
    tlpXmtBusy      <= False;
    tlpMetaSent     <= True;
    Bit#(32) opcode  = meta.opcode;
    Bit#(32) nowMS   = meta.nowMS;
    Bit#(32) nowLS   = meta.nowLS;
    if (fabMetaAddrMS=='0) begin
      let w = PTW16 {data:{byteSwap(opcode), byteSwap(nowMS), byteSwap(nowLS), 32'b0}, be:16'hFFF0, hit:7'h2, sof:False, eof:True };
      outF.enq(w);  // Out goes the rest of metadata write
    end else begin
      let w = PTW16 {data:{byteSwap(extend(meta.length)), byteSwap(opcode), byteSwap(nowMS), byteSwap(nowLS)}, be:16'hFFFF, hit:7'h2, sof:False, eof:True };
      outF.enq(w);  // Out goes all of metadata write
    end
    $display("[%0d]: %m: dmaXmtMetaBody FPactMesg-Step6/7", $time);
  endrule

  // Transmit the DMA-PUSH TailEvent...
  rule dmaXmtTailEvent (hasPush && actMesgP &&& fabMeta matches tagged Valid .meta &&& tlpMetaSent);
    xmtMetaInFlight <= False;
    tlpMetaSent     <= False;
    tailEventF.enq(0);  // Send a tail event that does NOT generate a remDone (done in dmaXmtMetaBody)
    $display("[%0d]: %m: dmaXmtTailEvent FPactMesg-Step7/7", $time);
  endrule

  // This rule used at the end of all Active transfers to purposefully insert a small amount of dwell time...
  rule dmaPostSeqDwell (postSeqDwell!=0); postSeqDwell <= postSeqDwell - 1; endrule
  rule dmaDoorSeqDwell (doorSeqDwell!=0); doorSeqDwell <= doorSeqDwell - 1; endrule

  // FCactFlow - Fabric Consumer Sending Doorbells
  // FPactFlow - Fabric Consumer Sending Doorbells
  // 
  // FIXME: There are two dead-reakoning races here that need to be fixed structurally
  // i)  Remove the use of doorSeqDwell that serves to keep this rule from re-firing before creditReady has updated from remStart
  // ii) There is a race between
  //      a) remStart, which is used to increment the fabFlowAddr
  //      b) the use of fabFlowAddr at the deq
  // We are counting on (b) to win so we use the correct address (not the incremented address)
  // Send Doorbells to tell the far side of our near buffer availability...
  rule dmaXmtDoorbell (actFlow && creditReady && doorSeqDwell==0);  // FIXME: Race from remStart->OCBufQ->creditReady is gated by doorSeqDwell
    remStart      <= True;    // Indicate to buffer-management to decrement LBCF, and advance crdBuf and fabFlowAddr
    doorSeqDwell  <= 8;
    flowDiagCount <= flowDiagCount + 1;
    tailEventF.enq(0);        // Send a tail event with no remDone
    $display("[%0d]: %m: dmaXmtDoorbell FC/FPactFlow-Step1/1", $time);
  endrule


  function Bool tagCompletionMatch(PciId rid, Bit#(8) tagm, PTW16 t);
    CompletionHdr ch = unpack(t.data[127:32]);
    return(tagm==ch.tag && ch.requesterID==rid);
  endfunction 

  //
  // FCactMesg - Fabric Consumer Message Pull Sequence...
  //
  // TODO
  // - consider use of taggged union/pattern matching instead of functions in rule predicate
  // - need ID-based completion routing

  // Request the metadata from the far-side fabric node...
  rule dmaRequestFarMeta (hasPull && actMesgC && !tlpXmtBusy && !reqMetaInFlight && !reqMetaBodyInFlight && !isValid(fabMeta) && nearBufReady && farBufReady && postSeqDwell==0);
    dmaStartMark    <= True;
    remStart        <= True;  // Indicate to buffer-management remote move start
    reqMetaInFlight <= True;
    // TODO: request needs the correct function number to facilitate completion routing (see comments in OCInf.bsv)
    PTW16 w = makeRdNDwReqTLP(pciDevice, 7'h2, truncate(fabMetaAddr>>2), extend(dmaTag), 4, fabMetaAddrMS); // Read Request 4DW of metadata
    dmaReqTag <= dmaTag;
    dmaTag    <= dmaTag + 1; 
    outF.enq(w);  // Out goes the read request of far metdata
    lastRuleFired <= R_dmaRequestFarMeta;
    complTimerRunning <= True;
    $display("[%0d]: %m: dmaRequestFarMeta FCactMesg-Step1/5", $time);
  endrule

  // Receive the first 1DW metadata back in the completion header...
  rule dmaRespHeadFarMeta (hasPull && actMesgC && reqMetaInFlight && !tlpRcvBusy && tagCompletionMatch(pciDevice,extend(dmaReqTag),inF.first) );
    PTW16 pw = inF.first;
    Ptw16Hdr p = unpack(pw.data);
    reqMetaInFlight     <= False;
    reqMetaBodyInFlight <= True;
    mesgLengthRemainPull <=     truncate(byteSwap(pw.data[31:0]));  // Source of Pull demand
    lastMetaV[0]         <=              byteSwap(pw.data[31:0]);   // Source of Pull demand
    inF.deq;
    // Push the 1st of the metadata into local buffer...
    WriteReq wreq = WriteReq {
      skipHeadData : False,
      dwAddr       : truncate(remMetaAddr>>2),
      dwLength     : 4,
      data         : pw.data[31:0],  // data still in PCIe Big-Endian Format
      firstBE      : '1,
      lastBE       : '1 };
    MemReqPacket mpkt = WriteHeader(wreq);
    tlpBRAM.putReq.put(mpkt);  // Enqueue BRAM write request header to store metadata
    lastRuleFired <= R_dmaRespHeadFarMeta;
    complTimerRunning <= False;
    $display("[%0d]: %m: dmaRespHeadFarMeta FPactMesg-Step2a/N fabMeta:%0x", $time, byteSwap(pw.data[31:0]));
  endrule

  // Receive the remaining 3DW metadata back in the completion body...
  rule dmaRespBodyFarMeta (hasPull && actMesgC && reqMetaBodyInFlight && !tlpRcvBusy );
    PTW16 pw = inF.first;
    Ptw16Hdr p = unpack(pw.data);
    reqMetaBodyInFlight <= False;
    inF.deq;
    Vector#(4, DWord) vWords = reverse(unpack(pw.data));
    Bit#(32) opcode = byteSwap(vWords[0]); lastMetaV[1] <= opcode;
    Bit#(32) nowMS  = byteSwap(vWords[1]); lastMetaV[2] <= nowMS;
    Bit#(32) nowLS  = byteSwap(vWords[2]); lastMetaV[3] <= nowLS;
    fabMeta <= (Valid (MesgMeta{length:extend(mesgLengthRemainPull), opcode:opcode, nowMS:nowMS, nowLS:nowLS}));
    dmaDoTailEvent <= (mesgLengthRemainPull==0); // Skip over Message Movement pull phases if mesgLength is zero
    mesgLengthRemainPull <= (mesgLengthRemainPull+3) & ~3; // DWORD roundup - shep owes Jim a beer
    mesgComplReceived <= 0;                  // Used to form the barrier-sync before isssuing pull tail event
    remMesgAccu <= remMesgAddr;              // Load the accumulator of rem address for sub-completions and multiple requests
    fabMesgAccu <= fabMesgAddr;              // Load the accumulator of fabric starting addresses over multiple requests
    MemReqPacket mpkt = WriteData(pw.data);
    tlpBRAM.putReq.put(mpkt);  // Enqueue BRAM write request body to store metadata
    lastRuleFired <= R_dmaRespBodyFarMeta;
    $display("[%0d]: %m: dmaRespBodyFarMeta FPactMesg-Step2b/N opcode:%0x nowMS:%0x nowLS:%0x", $time, opcode, nowMS, nowLS);
  endrule

  // Steps 3, 4a, 4b to be repeated 0-N times.
  //   0 times if there is no message data to be moved.
  //   1 or more times based on how many segments the fabric address-length tuple dictates
  //   Policy includes: i) Do not exceed (typ 512B) Maximum Read Request Size; ii) Do not cross 4KB (10b) DW bounds.

  // Request the message from the far side fabric node...
  rule dmaPullRequestFarMesg (hasPull && actMesgC &&& fabMeta matches tagged Valid .meta &&& meta.length!=0 &&& !tlpXmtBusy &&& !reqMesgInFlight &&& mesgLengthRemainPull!=0);
    Bit#(13) spanToNextPage = 4096 - extend(fabMesgAccu[11:0]);                                                    // how far until we hit a PCIe 4K Page
    Bit#(13) thisRequestLength = min(truncate(min(mesgLengthRemainPull,extend(maxReadReqSize))),spanToNextPage);   // minimum of what we want and what we are allowed
    mesgLengthRemainPull  <= mesgLengthRemainPull - extend(thisRequestLength);                                     // decrement mesgLengthRemainPull at the source
    fabMesgAccu <= fabMesgAccu + extend(thisRequestLength);                                                        // increment the fabric address accumulator
    reqMesgInFlight   <= True;  // Asserted while individual requests, with one or more (sub)completions, are in flight
    gotResponseHeader <= False;
    PTW16 w = makeRdNDwReqTLP(pciDevice, 7'h2, truncate(fabMesgAccu>>2), extend(dmaTag), truncate(thisRequestLength>>2), fabMesgAddrMS);
    dmaPullRemainDWLen <= truncate(thisRequestLength>>2); // How many DW remain in this request
    dmaReqTag   <= dmaTag;
    dmaTag      <= dmaTag + 1; 
    outF.enq(w);  // Out goes the read request of far message
    lastRuleFired <= R_dmaPullRequestFarMesg;
    complTimerRunning <= True;
    $display("[%0d]: %m: dmaPullRequestFarMesg FCactMesg-Step3/5", $time);
  endrule

  rule dmaPullResponseHeaderTag (hasPull && actMesgC); pullTagMatch <= tagCompletionMatch(pciDevice,extend(dmaReqTag),inF.first); endrule

  function Action updatePullState(Bool endOfSubCompletion, Bool endOfReqCompletion);
   action
    reqMesgInFlight   <= !endOfReqCompletion;  // Clear when Req finishes, disables head and body 
    tlpRcvBusy        <= !endOfSubCompletion;  // Clear when each sub completion ends
    gotResponseHeader <= !endOfSubCompletion;  // By clearing gotResponseHeader; enables new header, blocks body
    dmaDoTailEvent    <=  endOfReqCompletion;  // Req Over, trigger tail event
   endaction
  endfunction

  // Process the response header of the completion message from the far fabric node...
  rule dmaPullResponseHeader (hasPull && actMesgC &&& fabMeta matches tagged Valid .meta &&& reqMesgInFlight &&& !tlpRcvBusy &&& pullTagMatch &&& !gotResponseHeader);
    PTW16 pw = inF.first;
    inF.deq;
    Ptw16Hdr p = unpack(pw.data);
    CompletionHdr ch = unpack(pw.data[127:32]);
    remMesgAccu <= remMesgAccu + (extend(ch.length)<<2);  // increment the rem address accumulator
    WriteReq wreq = WriteReq {
      skipHeadData : False,
      dwAddr       : truncate(remMesgAccu>>2),   //
      dwLength     : ch.length,                  // the length in DW of this (possibly sub-) completion of the request
      data         : pw.data[31:0],              // data still in PCIe Big-Endian Format
      firstBE      : '1,
      lastBE       : '1 };
    MemReqPacket mpkt = WriteHeader(wreq);
    tlpBRAM.putReq.put(mpkt);  // Enqueue BRAM write request header to store message
    dmaPullRemainDWLen  <= dmaPullRemainDWLen - 1;
    dmaPullRemainDWSub  <= ch.length - 1;
    Bool endOfSubCompletion = (ch.length==1);
    Bool endOfReqCompletion = (dmaPullRemainDWLen==1);
    updatePullState(endOfSubCompletion, endOfReqCompletion);
    mesgComplReceived <= mesgComplReceived + 4;
    lastRuleFired <= R_dmaPullResponseHeader;
    $display("[%0d]: %m: dmaPullResponseHeader FPactMesg-Step4a/5", $time);
  endrule

  // continue accepting the completion payload (if any) and placing in memory...
  rule dmaPullResponseBody (hasPull && actMesgC &&& fabMeta matches tagged Valid .meta &&& reqMesgInFlight &&& gotResponseHeader);
    PTW16 pw = inF.first;
    inF.deq;
    MemReqPacket pkt = WriteData(pw.data); //16B Data still in PCI/NBO format
    tlpBRAM.putReq.put(pkt); // Enqueue BRAM write request body to store message
    Bool endOfSubCompletion = dmaPullRemainDWSub<=4;
    Bool endOfReqCompletion = endOfSubCompletion && (dmaPullRemainDWLen<=dmaPullRemainDWSub);
    dmaPullRemainDWLen    <=  endOfSubCompletion ? dmaPullRemainDWLen-dmaPullRemainDWSub : dmaPullRemainDWLen-4;   
    dmaPullRemainDWSub    <=  endOfSubCompletion ? 0 : dmaPullRemainDWSub-4;
    updatePullState(endOfSubCompletion, endOfReqCompletion);
    mesgComplReceived <= mesgComplReceived + (endOfSubCompletion ? (extend(dmaPullRemainDWSub)<<2) : 16);
    lastRuleFired <= R_dmaPullResponseBody;
    $display("[%0d]: %m: dmaPullResponseBody FPactMesg-Step4b/5", $time);
  endrule

  // We use the target-side "mesgComplReceived" accumulating to the full message length as the barrier-sync for the tail event.
  // Enq tailEventF to transmit the DMA-PULL TailEvent...
  rule dmaPullTailEvent (hasPull && actMesgC &&& fabMeta matches tagged Valid .meta &&& dmaDoTailEvent &&& postSeqDwell==0 &&& (mesgComplReceived>=truncate(meta.length)));
    dmaDoTailEvent  <= False;
    tailEventF.enq(1);  // Send a tail event that generates a remDone
    lastRuleFired <= R_dmaPullTailEvent;
    complTimerRunning <= False;  // Stop Completion Timer Here
    $display("[%0d]: %m: dmaPullTailEvent FPactMesg-Step5/5", $time);
  endrule

  // Generic TailEvent Sender (Used at end of push, pull, and for flow signal to fabFlowAddr)...
  // This rule will fire twice in the 4DW (64b addr) case; make sure the two PTW16s come sequentially
  rule dmaTailEventSender( (!tlpXmtBusy && !sentTail4DWHeader && postSeqDwell==0) || (tlpXmtBusy && sentTail4DWHeader));
    Bit#(32) eventData = truncate(nowW>>5) | 32'h0000_0001; // radix point has 5b integer (wrap at 32 seconds)
    dmaDoneMark <= True;
    if (fabFlowAddrMS=='0) begin
      if (tailEventF.first==1) remDone <= True; // For dmaPullTailEvent: Indicate to buffer-management remote move done  FIXME - pipeline allignment address advance
      postSeqDwell   <= psDwell;
      fabMeta        <= (Invalid);
      tailEventF.deq;
      MemReqHdr1 h = makeWrReqHdr(pciDevice, 1, '1, '0, False);
      let w = PTW16 { data : {pack(h), fabFlowAddr, byteSwap(eventData)}, be:'1, hit:7'h2, sof:True, eof:True };
      outF.enq(w); // Out goes the tail event write 3DW + 1 DW 0x0000_0001 non-zero
      lastRuleFired  <= R_dmaTailEventSender32;
    end else begin
      if (!sentTail4DWHeader) begin
        if (tailEventF.first==1) remDone <= True; // For dmaPullTailEvent: Indicate to buffer-management remote move done  FIXME - pipeline allignment address advance
        MemReqHdr1 h = makeWrReqHdr(pciDevice, 1, '1, '0, True);
        let w = PTW16 { data : {pack(h), fabFlowAddrMS, fabFlowAddr}, be:'1, hit:7'h2, sof:True, eof:False };
        outF.enq(w); // Out goes the tail event write 4DW 
        lastRuleFired  <= R_dmaTailEventSender64a;
        sentTail4DWHeader <= True;  // enable second term of rule predacate
        tlpXmtBusy        <= True;
      end else begin
        postSeqDwell   <= psDwell; 
        fabMeta        <= (Invalid);
        tailEventF.deq;
        let w = PTW16 {data:{byteSwap(eventData), byteSwap(0), byteSwap(0), byteSwap(0)}, be:16'hF000, hit:7'h2, sof:False, eof:True };
        outF.enq(w);  
        lastRuleFired  <= R_dmaTailEventSender64b;
        sentTail4DWHeader <= False;
        tlpXmtBusy     <= False;
      end
    end
    $display("[%0d]: %m: dmaTailEventSender - generic", $time);
  endrule

  rule completionTimer;
    complTimerCount <= (complTimerRunning) ? complTimerCount + 1 : 0 ;
  endrule

  // Push and Pull rule schedules (rules later in sequence have higher urgency)...
  //(* descending_urgency = "dmaXmtTailEvent, dmaXmtMetaBody, dmaXmtMetaHead, dmaPushResponseBody, dmaPushResponseHeader, dmaPushRequestMesg, dmaResponseNearMetaBody, dmaResponseNearMetaHead, dmaRequestNearMeta" *)
  //(* descending_urgency = "dmaTailEventSender, dmaPullTailEvent, dmaPullResponseBody, dmaPullResponseHeader, dmaPullResponseHeaderTag, dmaPullRequestFarMesg, dmaRespBodyFarMeta, dmaRespHeadFarMeta, dmaRequestFarMeta" *)

  //
  // uNoC Access of BRAM by BAR1...
  //

  rule tlpRcv (!reqMetaInFlight && !reqMesgInFlight && !reqMetaBodyInFlight); // TODO: Replace these guards with monitors
    PTW16 pw = inF.first;
    Ptw16Hdr p = unpack(pw.data);
    if (pw.sof) begin 
      MemReqHdr1 hdr       = unpack(pw.data[127:64]);  // Top 2DW of 4DW TLP has the hdr
      Bit#(10)   len       = hdr.length;
      Bit#(8)    tag       = hdr.tag;
      Bit#(3)    tc        = hdr.trafficClass;
      Bit#(4)    firstBE   = hdr.firstDWByteEn;
      Bit#(4)    lastBE    = hdr.lastDWByteEn;
      Bit#(2)    lowAddr10 = byteEnToLowAddr(hdr.firstDWByteEn);
      Bool       isWrite   = hdr.isWrite;
      PciId      srcReqID  = hdr.requesterID;
      DWAddress  dwAddr    = pw.data[63:34];          // Pick off dwAddr from 1st TLP
      DWord      firstDW   = truncate(pw.data);       // Bottom DW of 1st TLP is data
      Bool ignorePkt = p.hdr.isPoisoned || p.hdr.is4DW || p.hdr.pktType != 5'b00000;
      if (!ignorePkt) begin
        if (isWrite) begin
          WriteReq wreq = WriteReq {
            skipHeadData : False,
            dwAddr       : truncate(dwAddr),
            dwLength     : len,
            data         : firstDW,  // DW still in PCI/NBO, Byte0 on 31:24
            firstBE      : firstBE,
            lastBE       : lastBE };
            MemReqPacket mpkt = WriteHeader(wreq);
            tlpBRAM.putReq.put(mpkt);  // BRAM Write request from NoC with 1DW goes along
            //if (pw.eof) $display("[%0d] Mem: Finished single-cycle write (addr %x)", $time, {dwAddr,2'b00});
        end else begin
          ReadReq rreq = ReadReq {
            skipRespData : False,
            role         : ComplTgt,
            reqID        : srcReqID,
            dwLength     : len,
            tag          : tag,
            tc           : tc,
            dwAddr       : truncate(dwAddr),
            firstBE      : firstBE,
            lastBE       : lastBE };
            MemReqPacket mpkt = ReadHeader(rreq);
            tlpBRAM.putReq.put(mpkt); // BRAM Read request from NoC
        end
      end
    // Update state in case there are multiple write data beats...
    inIgnorePkt <= ignorePkt;
    end else begin 
      if (!inIgnorePkt) begin
        MemReqPacket pkt = WriteData(pw.data); //16B Data still in PCI/NBO format
        tlpBRAM.putReq.put(pkt);  // BRAM Write payload from NoC
        //if (pw.eof) $display("[%0d] Mem: Finished multi-cycle write (addr %x)", $time, {dwAddr,2'b00});
      end
    end
    tlpRcvBusy <= !pw.eof; // Block other local memory requests from interrupting multicycle writes
    inF.deq;
  endrule
   
  rule dataXmt_Header (tlpBRAM.getsResp.first matches tagged ReadHead .rres &&& rres.role==ComplTgt &&& !tlpXmtBusy);
    tlpBRAM.getsResp.deq;
    CompletionHdr hdr =
      makeReadCompletionHdr(pciDevice, rres.reqID, rres.dwLength, rres.tag, rres.tc, rres.lowAddr, rres.byteCount);
    Bit#(128) pkt = { pack(hdr), rres.data };
    PTW16 w = TLPData {
                data : pkt,
                be   : '1,
                hit  : 7'h2,
                sof  : True,
                eof  : (rres.dwLength == 1)};
    outF.enq(w);  // Out goes the 3DW completion header and 1DW data
    outDwRemain <= rres.dwLength - 1;
    if (rres.dwLength>1) tlpXmtBusy <= True;
  endrule

 rule dataXmt_Body (tlpBRAM.getsResp.first matches tagged ReadBody .rbody &&& rbody.role==ComplTgt);
    tlpBRAM.getsResp.deq;
    Bool isLastTLP = (outDwRemain <= 4);
    PTW16 w = TLPData {
                data : rbody.data,
                be   : (isLastTLP ? remFromDW(outDwRemain[1:0]) : '1),
                hit  : 7'h2,
                sof  : False,
                eof  : isLastTLP };
    outF.enq(w);  // Out goes remaining completion data
    outDwRemain <= outDwRemain - 4;
    if (isLastTLP) tlpXmtBusy <= False;
  endrule

  Bit#(32) tlpDebug = {4'h0, pack(complTimerCount), 12'h0, pack(lastRuleFired)};

  interface Server server;
    interface request  = toPut(inF);
    interface response = toGet(outF);
  endinterface

  // remote-facing buffer queue interface...
  interface BufQCIfc bufq;
    method Bool   start   = remStart;
    method Bool   done    = remDone;
    method Bool   fabric  = False;
    method Action rdy     = nearBufReady._write(True);
    method Action frdy    = farBufReady._write(True);
    method Action credit  = creditReady._write(True);
    method Action bufMeta (Bit#(16) bMeta); remMetaAddr<=bMeta; endmethod
    method Action bufMesg (Bit#(16) bMesg); remMesgAddr<=bMesg; endmethod
    method Action fabMeta (Bit#(32) fMeta); fabMetaAddr<=fMeta; endmethod
    method Action fabMesg (Bit#(32) fMesg); fabMesgAddr<=fMesg; endmethod
    method Action fabFlow (Bit#(32) fFlow); fabFlowAddr<=fFlow; endmethod
    method Action fabMetaMS (Bit#(32) fMetaMS); fabMetaAddrMS<=fMetaMS; endmethod
    method Action fabMesgMS (Bit#(32) fMesgMS); fabMesgAddrMS<=fMesgMS; endmethod
    method Action fabFlowMS (Bit#(32) fFlowMS); fabFlowAddrMS<=fFlowMS; endmethod
  endinterface

  // expose register interface so WCI can set/get these config properties...
  method Action dpCtrl (DPControl dc) = dpControl._write(dc);
  method Bit#(32)            i_flowDiagCount = flowDiagCount;
  method Bit#(32)            i_debug = tlpDebug;
  method Vector#(4,Bit#(32)) i_meta  = readVReg(lastMetaV);
  method Action now (Bit#(64) arg) = nowW._write(arg);
  method Bool  dmaStartPulse = dmaStartMark;
  method Bool  dmaDonePulse = dmaDoneMark;

endmodule



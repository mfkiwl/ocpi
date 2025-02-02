// MemiTestWorker.bsv - A WMemI Memory Test Worker
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED

import Accum::*;
import OCWip::*;

import Connectable::*;
import DReg::*;
import FIFO::*;	
import GetPut::*;
import Vector::*;

interface HwSeqGenIfc;
  interface Get#(Bit#(128)) stream;
endinterface

module mkHwSeqGen (HwSeqGenIfc);
  FIFO#(Bit#(128))          gsF        <- mkFIFO;
  Reg#(Vector#(4,Bit#(32))) patV       <- mkReg(unpack(128'h00000003_00000002_00000001_00000000));

  function Bit#(32) incDword (Bit#(32) arg) = (arg + 4);

  rule genseq;
    gsF.enq(pack(patV));
    patV  <= map(incDword, patV);
  endrule

  interface Get stream = toGet(gsF);
endmodule


interface MemiTestWorkerIfc;
  interface WciES        wciS0;    // Worker Control and Configuration 
  interface WmemiEM16B   wmemiM0;  // WMI Memory
endinterface 

(* synthesize, default_clock_osc="wciS0_Clk", default_reset="wciS0_MReset_n" *)
module mkMemiTestWorker#(parameter Bool hasDebugLogic) (MemiTestWorkerIfc);

  WciESlaveIfc                   wci               <- mkWciESlave;
  WmemiMasterIfc#(36,12,128,16)  wmemi             <- mkWmemiMaster; // 2^36 = 64GB
  HwSeqGenIfc                    wgen              <- mkHwSeqGen;
  HwSeqGenIfc                    rgen              <- mkHwSeqGen;
  Reg#(Bit#(32))                 tstCtrl           <- mkReg(0);
  Reg#(UInt#(32))                seqLen            <- mkReg(16);    // in HWords
  Reg#(Bool)                     isTesting         <- mkReg(False);
  Reg#(Bool)                     isWriter          <- mkReg(True);
  Reg#(Bool)                     isReader          <- mkReg(False);
  Reg#(Bool)                     isCharPush        <- mkReg(False);
  Reg#(UInt#(32))                hwordAddr         <- mkReg(0);
  Reg#(UInt#(32))                unrollCnt         <- mkReg(0);
  Reg#(UInt#(32))                respCnt           <- mkReg(0);
  Reg#(UInt#(32))                wmemiWrReq        <- mkReg(0);
  Reg#(UInt#(32))                wmemiRdReq        <- mkReg(0);
  Reg#(UInt#(32))                wmemiRdResp       <- mkReg(0);
  Reg#(UInt#(32))                testCycleCount    <- mkReg(0);
  Reg#(UInt#(32))                errorCount        <- mkReg(0);
  Reg#(UInt#(32))                wtCycStart        <- mkReg(0);
  Reg#(UInt#(32))                rdCycStart        <- mkReg(0);
  Reg#(UInt#(32))                wtDuration        <- mkReg(0);
  Reg#(UInt#(32))                rdDuration        <- mkReg(0);
  Reg#(UInt#(32))                freeCnt           <- mkReg(0);

  rule operating_actions (wci.isOperating);
    wmemi.operate();
  endrule

  rule free_inc; freeCnt <= freeCnt + 1; endrule

  Bool haltOnError = unpack(tstCtrl[0]);
  Bool charPerLoop = unpack(tstCtrl[1]);  // set to cause write to BLUART on loop

  function Bit#(36) hwordAsBytes(UInt#(32) hwAddr);
    return ( {pack(hwordAddr), 4'h0} );  // 4b up-shifted to convert hword to Bytes
  endfunction

  rule write_req (wci.isOperating && isTesting && isWriter && !isReader && !isCharPush);
    let d <- wgen.stream.get;
    wmemi.req(True, hwordAsBytes(hwordAddr), 1);         // Write Request 
    wmemi.dh(d, '1, True);                               // Write 16B Datahandshake
    hwordAddr  <= (unrollCnt==1) ? 0 : hwordAddr  + 1;   // Bump Address
    wmemiWrReq <= wmemiWrReq + 1;
    unrollCnt <= (unrollCnt==1) ? seqLen : unrollCnt - 1;
    if (unrollCnt==1) begin
      isWriter <= False;
      isReader <= True;
      rdCycStart <= freeCnt;
      wtDuration <= freeCnt - wtCycStart;
    end
  endrule

  rule read_req (wci.isOperating && isTesting && !isWriter && isReader);
    wmemi.req(False, hwordAsBytes(hwordAddr), 1);         // Read Request 
    hwordAddr  <= (unrollCnt==1) ? 0 : hwordAddr  + 1;    // Bump Address
    wmemiRdReq <= wmemiRdReq + 1;
    unrollCnt <= (unrollCnt==1) ? seqLen : unrollCnt - 1;
    if (unrollCnt==1) begin
      isReader <= False;
      isWriter <= True;
      testCycleCount <= testCycleCount + 1;
      wtCycStart <= freeCnt;
      rdDuration <= freeCnt - rdCycStart;
      isCharPush <= charPerLoop;
    end
  endrule

  rule read_resp (wci.isOperating && isTesting);
    let e <- rgen.stream.get;
    let g <- wmemi.resp;
    if (e != g.data) begin
      errorCount <= errorCount + 1;
      if (haltOnError) isTesting <= False;
      $display("[%0d]: %m: read_resp MISMATCH: exp:%0x got:%0x", $time, e, g.data);
    end
    wmemiRdResp <= wmemiRdResp + 1;
  endrule

  rule char_push (wci.isOperating && isTesting && isWriter && !isReader && isCharPush);
    wmemi.req(True, 36'h08000002C, 1);                         // Write Request - set bit 31 to write AXI; 2C is TX
    wmemi.dh(128'h0000000000000000000000000000002B, '1, True); // Write 16B Datahandshake 2B is ASCII '+'
    isCharPush <= False;
  endrule


// WCI...
Bit#(32) testStatus = {31'h0, pack(isReader)};
(* descending_urgency = "wci_wslv_ctl_op_complete, wci_wslv_ctl_op_start, wci_cfwr, wci_cfrd" *)
(* mutually_exclusive = "wci_cfwr, wci_cfrd, wci_ctrl_EiI, wci_ctrl_IsO, wci_ctrl_OrE" *)

// TODO: Fix Start and Stop to be "clean". Currently reset is needed to cleanly re-start
// Should start reset all state? (then why not use Control-Ops?)
// Should Stop wait to end of current pass, or be immediate?

rule wci_cfwr (wci.configWrite); // WCI Configuration Property Writes...
 let wciReq <- wci.reqGet.get;
   case (wciReq.addr) matches
     'h00 : tstCtrl   <= unpack(wciReq.data);
     'h04 : seqLen    <= unpack(wciReq.data);
     'h30 : begin isTesting <= True; unrollCnt <= seqLen; end  // Start test by writing here
     'h34 : begin isTesting <= False; end                      // Stop  test by writing here
   endcase
   //$display("[%0d]: %m: WCI CONFIG WRITE Addr:%0x BE:%0x Data:%0x", $time, wciReq.addr, wciReq.byteEn, wciReq.data);
   wci.respPut.put(wciOKResponse); // write response
endrule

rule wci_cfrd (wci.configRead);  // WCI Configuration Property Reads...
 let wciReq <- wci.reqGet.get; Bit#(32) rdat = '0;
   case (wciReq.addr) matches
     'h00 : rdat = pack(tstCtrl);
     'h04 : rdat = pack(seqLen);                 // The number of cycles in each W/R seqeunce (each cycle 16B)                    
     'h08 : rdat = extend(pack(wmemi.status));
     'h0C : rdat = pack(testCycleCount);         // How many times the test has repeated the W/R cycle
     'h10 : rdat = pack(errorCount);             // The number of errors detected
     'h14 : rdat = pack(wtDuration);             // The duration (in cycles) of the last write sequence
     'h18 : rdat = pack(rdDuration);             // The duration (in cycles) of the last read sequence
     'h1C : rdat = pack(wmemiWrReq);             // Rolling count of number of write requests issued
     'h20 : rdat = pack(wmemiRdReq);             // Rolling count of number of read  requests issued
     'h24 : rdat = pack(wmemiRdResp);            // Rolling count of number of read  responses received
     'h28 : rdat = testStatus;
   endcase
   //$display("[%0d]: %m: WCI CONFIG READ Addr:%0x BE:%0x Data:%0x", $time, wciReq.addr, wciReq.byteEn, rdat);
   wci.respPut.put(WciResp{resp:DVA, data:rdat}); // read response
endrule

rule wci_ctrl_IsO (wci.ctlState==Initialized && wci.ctlOp==Start);
  wci.ctlAck;
  $display("[%0d]: %m: Starting MemiTestWorker", $time);
endrule

rule wci_ctrl_EiI (wci.ctlState==Exists && wci.ctlOp==Initialize); wci.ctlAck; endrule
rule wci_ctrl_OrE (wci.isOperating && wci.ctlOp==Release); wci.ctlAck; endrule

  WmemiEM16B              wmemi_Em  <- mkWmemiMtoEm(wmemi.mas);
  interface wciS0   = wci.slv;
  interface wmemiM0 = wmemi_Em;

endmodule

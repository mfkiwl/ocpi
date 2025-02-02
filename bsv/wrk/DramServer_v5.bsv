// DramServer_v5.bsv
// Copyright (c) 2010-2012 Atomic Rules LLC - ALL RIGHTS RESERVED

package DramServer_v5;

import Accum::*;
import OCWip::*;
import DRAM_v5::*;
import Config::*;
import SRLFIFO ::*;

import Clocks::*;
import Connectable::*;
import FIFO::*;
import FIFOF::*;
import Vector::*;
import GetPut::*;

export DRAM_v5::*;
export DramServer_v5::*;

interface DramServer_v5Ifc;
  interface WciES          wciS0;    // Worker Control and Configuration
  interface WmemiES16B     wmemiS0;  // The Wmemi slave interface provided to the application
  interface DDR2_32        dram;     // The interface to the DRAM pins
endinterface

typedef 4 DqsWidth;
typedef 8 DqsPerDqs;

(* synthesize, default_clock_osc="wciS0_Clk", default_reset="wciS0_MReset_n" *)
module mkDramServer_v5#(parameter Bool hasDebugLogic, Clock sys0_clk, Reset sys0_rst, Clock sys1_clk, Reset sys1_rst) (DramServer_v5Ifc);

  WciESlaveIfc                     wci                        <- mkWciESlave;
  DramControllerUiV5Ifc            memc                       <- mkDramControllerV5Ui(sys0_clk, sys0_rst, sys1_clk);
  WmemiSlaveIfc#(36,12,128,16)     wmemi                      <- mkWmemiSlave; 
  Reg#(Bit#(32))                   dramCtrl                   <- mkReg(0);
  Clock                            uclk                       =  memc.uclk;
  Reset                            urst_n                     =  memc.urst_n;
  ReadOnly#(Bool)                  memIsReset                 <- isResetAsserted(clocked_by uclk, reset_by urst_n);
  SyncBitIfc#(Bit#(1))             memIsResetCC               <- mkSyncBitToCC(uclk, urst_n);
  SyncBitIfc#(Bit#(1))             initComplete               <- mkSyncBitToCC(uclk, urst_n);
  SyncBitIfc#(Bit#(1))             appFull                    <- mkSyncBitToCC(uclk, urst_n);
  SyncBitIfc#(Bit#(1))             wdfFull                    <- mkSyncBitToCC(uclk, urst_n);
  SyncBitIfc#(Bit#(1))             firBeat                    <- mkSyncBitToCC(uclk, urst_n);
  SyncBitIfc#(Bit#(1))             secBeat                    <- mkSyncBitToCC(uclk, urst_n);
  Reg#(Bit#(32))                   dbgCtrl                    <- mkReg(0, clocked_by uclk, reset_by urst_n);
  Reg#(Bit#(8))                    respCount                  <- mkReg(0);
  Reg#(Bool)                       splitReadInFlight          <- mkReg(False); 
  FIFOF#(Bit#(2))                  splaF                      <- mkSRLFIFOD(4);

  Reg#(Bit#(4))                    dbg_calib_done             <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(4))                    dbg_calib_err              <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(6,DqsWidth)))    dbg_calib_dq_tap_cnt       <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(6,DqsWidth)))    dbg_calib_dqs_tap_cnt      <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(6,DqsWidth)))    dbg_calib_gate_tap_cnt     <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(DqsWidth))             dbg_calib_rd_data_sel      <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_calib_rden_delay       <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_calib_gate_delay       <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(16))                   requestCount               <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(16))                   responseCount              <- mkSyncRegToCC(0, uclk, urst_n);

  Reg#(Bit#(16))                   pReg                       <- mkReg(0);
  Reg#(Bit#(16))                   mReg                       <- mkReg(0);
  Vector#(4,Reg#(Bit#(32)))        wdReg                      <- replicateM(mkReg(0));
  Vector#(4,Reg#(Bit#(32)))        rdReg                      <- replicateM(mkReg(0));

  SyncFIFOIfc#(DramReq16B)         lreqF                      <- mkSyncFIFOFromCC(2, uclk);
  SyncFIFOIfc#(Bit#(128))          lrespF                     <- mkSyncFIFOToCC  (5, uclk, urst_n);

  Accumulator2Ifc#(Int#(8))        wmemiReadInFlight          <- mkAccumulator2;
  Reg#(Bit#(32))                   wmemiWrReq                 <- mkReg(0);
  Reg#(Bit#(32))                   wmemiRdReq                 <- mkReg(0);
  Reg#(Bit#(32))                   wmemiRdResp                <- mkReg(0);

rule operating_actions (wci.isOperating);
  wmemi.operate();
endrule


  rule update_memIsReset;   memIsResetCC.send(pack(memIsReset)); endrule
  rule update_initComplete; initComplete.send(pack(memc.usr.initComplete)); endrule
  rule update_appFull;      appFull.send(pack(memc.usr.appFull)); endrule
  rule update_wdfFull;      wdfFull.send(pack(memc.usr.wdfFull)); endrule
  rule update_firBeat;      firBeat.send(pack(memc.usr.firBeat)); endrule
  rule update_secBeat;      secBeat.send(pack(memc.usr.secBeat)); endrule

  rule update_debug;
    dbg_calib_done             <= memc.dbg.calib_done;
    dbg_calib_err              <= memc.dbg.calib_err;
    dbg_calib_dq_tap_cnt       <= memc.dbg.calib_dq_tap_cnt;
    dbg_calib_dqs_tap_cnt      <= memc.dbg.calib_dqs_tap_cnt;
    dbg_calib_gate_tap_cnt     <= memc.dbg.calib_gate_tap_cnt;
    dbg_calib_rd_data_sel      <= memc.dbg.calib_rd_data_sel;
    dbg_calib_rden_delay       <= memc.dbg.calib_rden_delay;
    dbg_calib_gate_delay       <= memc.dbg.calib_gate_delay;
    requestCount               <= memc.reqCount;
    responseCount              <= memc.respCount;
  endrule

  rule debug_update;
    memc.dbg.idel_up_all(0);
    memc.dbg.idel_down_all(0);
    memc.dbg.sel_all_idel_dq(0);
    memc.dbg.sel_idel_dq(0);
    memc.dbg.idel_up_dq(0);
    memc.dbg.idel_down_dq(0);
    memc.dbg.sel_all_idel_dqs(0);
    memc.dbg.sel_idel_dqs(0);
    memc.dbg.idel_up_dqs(0);
    memc.dbg.idel_down_dqs(0);
    memc.dbg.sel_all_idel_gate(0);
    memc.dbg.sel_idel_gate(0);
    memc.dbg.idel_up_gate(0);
    memc.dbg.idel_down_gate(0);
  endrule

  mkConnection(toGet(lreqF), memc.usr.request);
  mkConnection(memc.usr.response, toPut(lrespF));


// Connection to the Wmemi...
// The use of '12' for the read throttle is the blind suspicion of a defect in the MIG core which results in
// the request FIFO full asserting late. We saw some evedince of that in ChipScope. 
rule getRequest (!wci.configWrite && !wci.configRead); // Rule predicate gives PIO config access priority
  let req <- wmemi.req;
  if (req.cmd==WR) begin
      let dh <- wmemi.dh;
      lreqF.enq( DramReq16B {isRead:False, addr:truncate(req.addr), be:dh.dataByteEn, data:dh.data} );
      wmemiWrReq <= wmemiWrReq + 1;
  end else if (wmemiReadInFlight < 12) begin  // Restrict Reads to memory that we can capture at low-level response
      lreqF.enq( DramReq16B {isRead:True,  addr:truncate(req.addr), be:?,             data:?} );
      wmemiReadInFlight.acc1(1);
      wmemiRdReq <= wmemiRdReq + 1;
  end
endrule

rule getResponse (wmemiReadInFlight>0);
  let rsp = lrespF.first; lrespF.deq();
  wmemiReadInFlight.acc2(-1);
  wmemi.respd(rsp, True);
  wmemiRdResp <= wmemiRdResp + 1;
endrule



  Bit#(32) dramStatus = {16'hFEED, respCount, 
    2'h0, memIsResetCC.read, appFull.read, wdfFull.read, secBeat.read, firBeat.read, initComplete.read};
  //      5                  4             3             2             1             0

  function Action writeDram4B(Bit#(32) addr, Bit#(4) be, Bit#(32) wdata);
    action
      Vector#(4, Bit#(4))  vbe  = replicate(4'h0);
      vbe[addr[3:2]] = be; // place be in the correct 4B within 16B words
      Vector#(4, Bit#(32)) wdat = replicate(wdata);
      lreqF.enq( DramReq16B {isRead:False, addr:(addr&32'hFFFF_FFF0), be:pack(vbe), data:pack(wdat)} );
    endaction
  endfunction

  function Action readDram4B(Bit#(32) addr);
    action
      lreqF.enq( DramReq16B {isRead:True, addr:(addr&32'hFFFF_FFF0), be:?, data:?} );
      splaF.enq(addr[3:2]); // enq which 4B of 16B we need to select when response arrives
    endaction
  endfunction

  (* descending_urgency = "wci_wslv_ctl_op_complete, wci_wslv_ctl_op_start, wci_cfwr, wci_cfrd, advance_response" *)
  (* mutually_exclusive = "wci_cfwr, wci_cfrd, wci_ctrl_EiI, wci_ctrl_IsO, wci_ctrl_OrE, advance_response" *)

  rule advance_response (!wci.configWrite && wmemiReadInFlight==0);
    let rsp = lrespF.first; lrespF.deq();
    Vector#(4, Bit#(32)) rdVect = unpack(rsp);
    for(Integer i=0;i<4;i=i+1) rdReg[i] <= rdVect[i];
    if (splitReadInFlight) begin
      let p = splaF.first; splaF.deq();
      wci.respPut.put(WciResp{resp:DVA, data:rdVect[p]}); // put the correct 4B DW from 16B return
      splitReadInFlight <= False;
    end
    respCount <= respCount + 1;
  endrule

  rule wci_cfwr (wci.configWrite); // WCI Configuration Property Writes...
   let wciReq <- wci.reqGet.get;
   if (wciReq.addr[19]==0) begin
     case (wciReq.addr[7:0]) matches
       'h04 : dramCtrl  <= unpack(wciReq.data);
       'h50 : pReg      <= truncate(wciReq.data);
       'h54 : lreqF.enq(DramReq16B {isRead:False, addr:wciReq.data, be:mReg, data:pack(readVReg(wdReg))}); // Write Req
       'h58 : lreqF.enq(DramReq16B {isRead:True,  addr:wciReq.data, be:mReg, data:pack(readVReg(wdReg))}); // Read  Req
       'h5C : mReg      <= truncate(wciReq.data);
       'h60 : wdReg[0]  <= wciReq.data;
       'h64 : wdReg[1]  <= wciReq.data;
       'h68 : wdReg[2]  <= wciReq.data;
       'h6C : wdReg[3]  <= wciReq.data;
       'h80 : rdReg[0]  <= wciReq.data;
       'h84 : rdReg[1]  <= wciReq.data;
       'h88 : rdReg[2]  <= wciReq.data;
       'h8C : rdReg[3]  <= wciReq.data;
     endcase
     end else begin
       writeDram4B(truncate({pReg,wciReq.addr[18:2],2'b0}), 4'hF, wciReq.data);
     end
     wci.respPut.put(wciOKResponse); // write response
  endrule

  rule wci_cfrd (wci.configRead);  // WCI Configuration Property Reads...
   Bool splitRead = False;
   let wciReq <- wci.reqGet.get; Bit#(32) rdat = '0;
   if (wciReq.addr[19]==0) begin
     case (wciReq.addr[7:0]) matches
       'h00 : rdat = dramStatus;
       'h04 : rdat = pack(dramCtrl);
       'h08 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_done);
       'h0C : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_err);
       'h10 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_dq_tap_cnt);
       'h14 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_dqs_tap_cnt);
       'h18 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_gate_tap_cnt);
       'h1C : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_rd_data_sel);
       'h20 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_rden_delay);
       'h24 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_calib_gate_delay);
       'h28 : rdat = (!hasDebugLogic) ? 0 : 32'hC0DEBABE;
       'h2C : rdat = (!hasDebugLogic) ? 0 : wmemiWrReq;
       'h30 : rdat = (!hasDebugLogic) ? 0 : wmemiRdReq;
       'h34 : rdat = (!hasDebugLogic) ? 0 : wmemiRdResp;
       'h38 : rdat = (!hasDebugLogic) ? 0 : extend(pack(wmemi.status));
       'h3C : rdat = (!hasDebugLogic) ? 0 : extend(pack(wmemiReadInFlight));
       'h40 : rdat = (!hasDebugLogic) ? 0 : 0;
       'h44 : rdat = (!hasDebugLogic) ? 0 : 0;
       'h48 : rdat = (!hasDebugLogic) ? 0 : extend(requestCount);
       'h4C : rdat = (!hasDebugLogic) ? 0 : 0;
       'h50 : rdat = (!hasDebugLogic) ? 0 : extend(pReg); // page reg
       'h5C : rdat = (!hasDebugLogic) ? 0 : extend(mReg); // mask Reg
       'h60 : rdat = (!hasDebugLogic) ? 0 : wdReg[0];
       'h64 : rdat = (!hasDebugLogic) ? 0 : wdReg[1];
       'h68 : rdat = (!hasDebugLogic) ? 0 : wdReg[2];
       'h6C : rdat = (!hasDebugLogic) ? 0 : wdReg[3];
       'h80 : rdat = (!hasDebugLogic) ? 0 : rdReg[0];
       'h84 : rdat = (!hasDebugLogic) ? 0 : rdReg[1];
       'h88 : rdat = (!hasDebugLogic) ? 0 : rdReg[2];
       'h8C : rdat = (!hasDebugLogic) ? 0 : rdReg[3];
       'h90 : rdat = (!hasDebugLogic) ? 0 : wmemiWrReq;
       'h94 : rdat = (!hasDebugLogic) ? 0 : wmemiRdReq;
       'h98 : rdat = (!hasDebugLogic) ? 0 : wmemiRdResp;
     endcase
     end else begin
       readDram4B(truncate({pReg,wciReq.addr[18:2],2'b0}));
       splitRead = True;
     end
     if (!splitRead)wci.respPut.put(WciResp{resp:DVA, data:rdat}); // read response
     else splitReadInFlight <= True;
  endrule

  rule wci_ctrl_IsO (wci.ctlState==Initialized && wci.ctlOp==Start);
    //TODO: DRAM Auto Initialize here
    wmemiReadInFlight.load(0);
    wci.ctlAck;
    $display("[%0d]: %m: Starting DramWorker dramCtrl:%0x", $time, dramCtrl);
  endrule
  
  rule wci_ctrl_EiI (wci.ctlState==Exists && wci.ctlOp==Initialize); wci.ctlAck; endrule
  rule wci_ctrl_OrE (wci.isOperating && wci.ctlOp==Release); wci.ctlAck; endrule

  WmemiES16B wmemi_Es <- mkWmemiStoES(wmemi.slv);

  interface Wci_s       wciS0    = wci.slv;
  interface WmemiES16B  wmemiS0  = wmemi_Es;
  interface DDR3_64     dram     = memc.dram; 

endmodule : mkDramServer_v5

endpackage : DramServer_v5


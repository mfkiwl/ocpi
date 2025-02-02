// DramServer_v6.bsv
// Copyright (c) 2010-2013 Atomic Rules LLC - ALL RIGHTS RESERVED

package DramServer_v6;

import Accum::*;
import OCWip::*;
import DRAM_v6::*;
import Config::*;
import SRLFIFO ::*;

import Clocks::*;
import Connectable::*;
import DReg::*; 
import FIFO::*;
import FIFOF::*;
import Vector::*;
import GetPut::*;

export DRAM_v6::*;
export DramServer_v6::*;

interface DramServer_v6Ifc;
  interface WciES         wciS0;    // Worker Control and Configuration
  interface WmemiES16B    wmemiS0;  // The Wmemi slave interface provided to the application
  interface DDR3_64       dram;     // The interface to the DRAM pins
  // Diagnostics...
  (*always_ready*) method Bool isInReset;
  (*always_ready*) method Bool isReset;
  (*always_ready*) method Bool isTrained;
endinterface

typedef 8 DqsWidth;

(* synthesize, default_clock_osc="wciS0_Clk", default_reset="wciS0_MReset_n" *)
module mkDramServer_v6#(parameter Bool hasDebugLogic, Clock sys0_clk, Reset sys0_rst) (DramServer_v6Ifc);

  WciESlaveIfc                     wci                        <- mkWciESlave;
  DramControllerUiIfc              memc                       <- mkDramControllerUi(sys0_clk, sys0_clk);
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
  Reg#(Bool)                       memInReset                 <- mkDReg(True);

  Reg#(Bit#(DqsWidth))             dbg_wl_dqs_inverted        <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(2,DqsWidth)))    dbg_wr_calib_clk_delay     <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_wl_odelay_dqs_tap_cnt  <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_wl_odelay_dq_tap_cnt   <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(2))                    dbg_rdlvl_done             <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(2))                    dbg_rdlvl_err              <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_cpt_tap_cnt            <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_cpt_first_edge_cnt     <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_cpt_second_edge_cnt    <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(3,DqsWidth)))    dbg_rd_bitslip_cnt         <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(2,DqsWidth)))    dbg_rd_clkdly_cnt          <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(5))                    dbg_rd_active_dly          <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_dqs_p_tap_cnt          <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_dqs_n_tap_cnt          <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(5,DqsWidth)))    dbg_dq_tap_cnt             <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(TMul#(4,DqsWidth)))    dbg_rddata                 <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(16))                   requestCount               <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(16))                   responseCount              <- mkSyncRegToCC(0, uclk, urst_n);
  Reg#(Bit#(32))                   uclkUpdateCnt              <- mkReg(0, clocked_by uclk, reset_by urst_n);
  Reg#(Bit#(32))                   wci_uclkUpdateCnt          <- mkSyncRegToCC(0, uclk, urst_n);

  Reg#(Bit#(16))                   pReg                       <- mkReg(0);
  Reg#(Bit#(16))                   mReg                       <- mkReg(0);
  Vector#(4,Reg#(Bit#(32)))        wdReg                      <- replicateM(mkReg(0));
  Vector#(4,Reg#(Bit#(32)))        rdReg                      <- replicateM(mkReg(0));

  SyncFIFOIfc#(DramReq16B)         lreqF                      <- mkSyncFIFOFromCC(2, uclk);
  SyncFIFOIfc#(Bit#(128))          lrespF                     <- mkSyncFIFOToCC  (2, uclk, urst_n);

  Accumulator2Ifc#(Int#(8))        wmemiReadInFlight          <- mkAccumulator2;
  Reg#(Bit#(32))                   wmemiWrReq                 <- mkReg(0);
  Reg#(Bit#(32))                   wmemiRdReq                 <- mkReg(0);
  Reg#(Bit#(32))                   wmemiRdResp                <- mkReg(0);

  Reg#(Bool)                       pioReadInFlight            <- mkReg(False);  // TODO: Add PIO low-priority mutex 

  rule clear_reset;  // This rule will fire when WCI is not reset, clearing memInReset bit
    memInReset <= False;
  endrule

  rule operating_actions (wci.isOperating);
     wmemi.operate();
  endrule

  rule update_memIsReset;   memIsResetCC.send(pack(memIsReset)); endrule
  rule update_initComplete; initComplete.send(pack(memc.usr.initComplete)); endrule
  rule update_appFull;      appFull.send(pack(memc.usr.appFull)); endrule
  rule update_wdfFull;      wdfFull.send(pack(memc.usr.wdfFull)); endrule
  rule update_firBeat;      firBeat.send(pack(memc.usr.firBeat)); endrule
  rule update_secBeat;      secBeat.send(pack(memc.usr.secBeat)); endrule

  //(* no_implicit_conditions, fire_when_enabled *)
  // mkSyncRegToCC have guarded _write methods
  // This rule is in the 200 MHz uclk domain - output from MIG
  rule update_debug (True);
     dbg_wl_dqs_inverted       <= memc.dbg.wl_dqs_inverted;
     dbg_wr_calib_clk_delay    <= memc.dbg.wr_calib_clk_delay;
     dbg_wl_odelay_dqs_tap_cnt <= memc.dbg.wl_odelay_dqs_tap_cnt;
     dbg_wl_odelay_dq_tap_cnt  <= memc.dbg.wl_odelay_dq_tap_cnt;
     dbg_rdlvl_done            <= memc.dbg.rdlvl_done;
     dbg_rdlvl_err             <= memc.dbg.rdlvl_err;
     dbg_cpt_tap_cnt           <= memc.dbg.cpt_tap_cnt;
     dbg_cpt_first_edge_cnt    <= memc.dbg.cpt_first_edge_cnt;
     dbg_cpt_second_edge_cnt   <= memc.dbg.cpt_second_edge_cnt;
     dbg_rd_bitslip_cnt        <= memc.dbg.rd_bitslip_cnt;
     dbg_rd_clkdly_cnt         <= memc.dbg.rd_clkdly_cnt;
     dbg_rd_active_dly         <= memc.dbg.rd_active_dly;
     dbg_dqs_p_tap_cnt         <= memc.dbg.dqs_p_tap_cnt;
     dbg_dqs_n_tap_cnt         <= memc.dbg.dqs_n_tap_cnt;
     dbg_dq_tap_cnt            <= memc.dbg.dq_tap_cnt;
     dbg_rddata                <= memc.dbg.rddata;
     requestCount              <= memc.reqCount;
     responseCount             <= memc.respCount;
     uclkUpdateCnt             <= uclkUpdateCnt + 1;  // Count update cycles
  endrule

  rule update_ucnt;
     wci_uclkUpdateCnt         <= uclkUpdateCnt;
  endrule

  (* no_implicit_conditions, fire_when_enabled *)
  rule debug_update;  // Tie of debug control inpputs to no-op zero
    memc.dbg.pd_off(0);
    memc.dbg.pd_maintain_off(0);
    memc.dbg.pd_maintain_0_only(0);
    memc.dbg.ocb_mon_off(0);
    memc.dbg.inc_cpt(0);
    memc.dbg.dec_cpt(0);
    memc.dbg.inc_rd_dqs(0);
    memc.dbg.dec_rd_dqs(0);
    memc.dbg.inc_dec_sel(0);
`ifdef MIG_392
    memc.dbg.wr_dqs_tap_set(0);
    memc.dbg.wr_dq_tap_set(0);
    memc.dbg.wr_tap_set_en(0);
    memc.dbg.inc_rd_fps(0);
    memc.dbg.pd_msb_sel(0);
    memc.dbg.sel_idel_cpt(0);
    memc.dbg.sel_idel_rsync(0);
    memc.dbg.pd_byte_sel(0);
    memc.dbg.dec_rd_fps(0);
`endif
  endrule

  mkConnection(toGet(lreqF), memc.usr.request);
  mkConnection(memc.usr.response, toPut(lrespF));

  Bit#(32) dramStatus = extend({respCount, 
    2'b00, memIsResetCC.read, appFull.read, wdfFull.read, secBeat.read, firBeat.read, initComplete.read});
  //       5                  4             3             2             1             0


// Connection to the Wmemi...
rule getRequest (!wci.configWrite && !wci.configRead); // Rule predicate gives PIO config access priority
  let req <- wmemi.req;
  if (req.cmd==WR) begin
      let dh <- wmemi.dh;
      lreqF.enq( DramReq16B {isRead:False, addr:truncate(req.addr), be:dh.dataByteEn, data:dh.data} );
      wmemiWrReq <= wmemiWrReq + 1;
  end else if (wmemiReadInFlight < 16) begin  // Restrict Reads to memory that we can capture at low-level response
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
     //$display("[%0d]: %m: WCI CONFIG WRITE Addr:%0x BE:%0x Data:%0x", $time, wciReq.addr, wciReq.byteEn, wciReq.data);
     wci.respPut.put(wciOKResponse); // write response
  endrule

  rule wci_cfrd (wci.configRead);  // WCI Configuration Property Reads...
   Bool splitRead = False;
   let wciReq <- wci.reqGet.get; Bit#(32) rdat = '0;
   if (wciReq.addr[19]==0) begin
     case (wciReq.addr[7:0]) matches
       'h00 : rdat = dramStatus;
       'h04 : rdat = pack(dramCtrl);
       'h08 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_wl_dqs_inverted);
       'h0C : rdat = (!hasDebugLogic) ? 0 : extend(dbg_wr_calib_clk_delay);
       'h10 : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_wl_odelay_dqs_tap_cnt);
       'h14 : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_wl_odelay_dq_tap_cnt);
       'h18 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_rdlvl_done);
       'h1C : rdat = (!hasDebugLogic) ? 0 : extend(dbg_rdlvl_err);
       'h20 : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_cpt_tap_cnt );
       'h24 : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_cpt_first_edge_cnt);
       'h28 : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_cpt_second_edge_cnt);
       'h2C : rdat = (!hasDebugLogic) ? 0 : extend(dbg_rd_bitslip_cnt);
       'h30 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_rd_clkdly_cnt);
       'h34 : rdat = (!hasDebugLogic) ? 0 : extend(dbg_rd_active_dly);
       'h38 : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_dqs_p_tap_cnt);
       'h3C : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_dqs_n_tap_cnt);
       'h40 : rdat = (!hasDebugLogic) ? 0 : truncate(dbg_dq_tap_cnt);
       'h44 : rdat = (!hasDebugLogic) ? 0 : (dbg_rddata);
       'h48 : rdat = (!hasDebugLogic) ? 0 : extend(requestCount);
       'h4C : rdat = (!hasDebugLogic) ? 0 : extend(responseCount);
       'h50 : rdat = (!hasDebugLogic) ? 0 : extend(pReg);
       'h5C : rdat = (!hasDebugLogic) ? 0 : extend(mReg);
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
       'h9C : rdat = (!hasDebugLogic) ? 0 : wci_uclkUpdateCnt; // should spin with updates
      endcase
    end else begin
       readDram4B(truncate({pReg,wciReq.addr[18:2],2'b0}));
       splitRead = True;
    end
     //$display("[%0d]: %m: WCI CONFIG READ Addr:%0x BE:%0x Data:%0x", $time, wciReq.addr, wciReq.byteEn, rdat);
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

  method Bool isInReset = memInReset;
  method Bool isReset   = unpack(memIsResetCC.read);
  method Bool isTrained = unpack(initComplete.read);
  interface WciES       wciS0    = wci.slv;
  interface WmemiES16B  wmemiS0  = wmemi_Es;
  interface DDR3_64     dram     = memc.dram; 

endmodule : mkDramServer_v6

endpackage : DramServer_v6

// CTop.bsv
// Copyright (c) 2009-2011 Atomic Rules LLC - ALL RIGHTS RESERVED

package CTop;

//import BLUART      ::*;
import OCInf       ::*;
import OCApp       ::*;
import TLPMF       ::*;
import CPDefs      ::*;
import TimeService ::*;
import OCWip       ::*;
import Config      ::*;

import Clocks::*;
import PCIE::*;
import Vector::*;
import GetPut::*;
import ClientServer::*;
import Connectable::*;


// ndw - number of 4B DWORDS...

interface CTopIfc#(numeric type ndw);
  interface Server#(PTW16,PTW16)      server;
  interface Server#(CpReq,CpReadResp) cpServer;
  (* always_ready *)                 method Bit#(2) led;
  (* always_ready, always_enabled *) method Action  switch (Bit#(3) x);
  interface Vector#(Nwci_ftop, WciEM)                   wci_m;  // provide WCI interfaces to Ftop
  interface  GPS64_t     cpNow;
  interface Wsi_Es#(12,TMul#(ndw,32),TMul#(ndw,4),8,0)  wsi_s_adc;   
  interface Wsi_Em#(12,TMul#(ndw,32),TMul#(ndw,4),8,0)  wsi_m_dac;  
  interface  WmemiEM16B  wmemiM0;
  interface  GPSIfc      gps;
//  interface  UART_pads   upads;
endinterface 

module mkCTop#(PciId pciDevice, Clock sys0_clk, Reset sys0_rst) (CTopIfc#(ndw))
  provisos (DWordWidth#(ndw), NumAlias#(TMul#(ndw,32),nd), Add#(a_,32,nd), NumAlias#(TMul#(ndw,4),nbe), Add#(1,b_,TMul#(ndw,32)), // by shep
    Add#(1, a__, TAdd#(3, TAdd#(1, TAdd#(1, TAdd#(12, TAdd#(TMul#(ndw, 32), TAdd#(TMul#(ndw, 4), 8))))))));                       ///by bsc output

`ifdef USE_DEBUGLOGIC
  Bool hasDebugLogic = True;
`else
  Bool hasDebugLogic = False;
`endif

  //OCInfIfc#(Nwci_ctop,ndw) inf <- mkOCInf_poly(pciDevice, sys0_clk, sys0_rst);       // Instance the Infrastructre
`ifdef USE_NDW1
  OCInf4BIfc inf  <- mkOCInf4B(pciDevice, sys0_clk, sys0_rst);       // Instance the Infrastructre
`elsif USE_NDW2
  OCInf8BIfc inf  <- mkOCInf8B(pciDevice, sys0_clk, sys0_rst);       // Instance the Infrastructre
`elsif USE_NDW4
  OCInf16BIfc inf <- mkOCInf16B(pciDevice, sys0_clk, sys0_rst);       // Instance the Infrastructre
`elsif USE_NDW8
  OCInf32BIfc inf <- mkOCInf32B(pciDevice, sys0_clk, sys0_rst);       // Instance the Infrastructre
`endif

  Vector#(iNwci_ctop, Reset) resetVec = newVector;                                   // Vector of WCI Resets
  for (Integer i=0; i<iNwci_app; i=i+1) resetVec[i] = inf.wci_m[i].mReset_n;         // Reset Vector for the Application

  //OCAppIfc#(Nwci_app,Nwmi,Nwmemi,ndw) app  <- mkOCApp_poly(resetVec,hasDebugLogic);  // Instance the Application
`ifdef USE_NDW1
  OCApp4BIfc  app  <- mkOCApp4B(resetVec,hasDebugLogic);  // Instance the Application
`elsif USE_NDW2
  OCApp8BIfc app   <- mkOCApp8B(resetVec,hasDebugLogic);  // Instance the Application
`elsif USE_NDW4
  OCApp16BIfc app  <- mkOCApp16B(resetVec,hasDebugLogic);  // Instance the Application
`elsif USE_NDW8
  OCApp32BIfc app  <- mkOCApp32B(resetVec,hasDebugLogic);  // Instance the Application
`endif

  for (Integer i=0; i<iNwci_app; i=i+1) mkConnection(inf.wci_m[i], app.wci_s[i]);   // Connect WCI between INF/APP
  Vector#(Nwci_ftop, WciEM) wci_c2f = takeAt(iNwci_app, inf.wci_m);                 // Take the unused WCI for FTop

  // WMI interfaces between App(masters) to Inf(Slaves)...
  mkConnection(app.wmiM0, inf.wmiDP0);
  mkConnection(app.wmiM1, inf.wmiDP1);

  rule connect_uuid;
    inf.uuid(app.uuid);
  endrule // Pass the uuid from the application to the infrastructure

  // We could instance N mkTimeClient's, each with ther own clock crossing and WtiMaster
  // But instead, we go the low-level route and instance N WtiMasters by themselves
  // and a single synchronizer feeding them all. It's perhaps not such a big difference

  // Time repeaters...
  Vector#(Nwti_app, WtiMasterIfc#(64)) wtiM <- replicateM(mkWtiMaster);

  // Connect WTI masters to app...
  // One way to do this is to use a for loop and iterate over the subinterfaces and interfaces
  // for (Integer i=0; i<iNwti_app; i=i+1) mkConnection(wtiM[i].mas, app.wti_s[i]); 

  // We can't quite use these functions as is as per 2012-01-12 dialog with Joe Stoy
  // zipWithM(mkConnection, wtiM.mas, app.wti_s); // mkConnection zipped over arguments
  // mkConnection(wtiM.mas, app.wti_s);           // mkConnection understands Vectors of Connectable

  // So we write a functon to select the desired subinterface of the master...
  function Wti_m#(64) masF(WtiMasterIfc#(64) x) = x.mas; // select the mas subinterface of WtiMasterIfc
  mkConnection (map(masF,wtiM), app.wti_s);

  Clock app_clk <- exposeCurrentClock;
  Reset app_rst <- exposeCurrentReset;
  Reg#(GPS64_t)     ctNow   <- mkSyncReg(unpack(0), sys0_clk, sys0_rst, app_clk);  // Our single sys0 -> app_clk syncReg

  rule send_time; ctNow._write(inf.cpNow); endrule  // Write inf.cpNow to our synchronizer

  // Instead of the Rule timeSource below, we can again be clever and use mkConnection and map
  // rule timeSource;
  //   for (Integer i=0; i<iNwti_app; i=i+1) begin
  //     wtiM[i].reqPut.put(WtiReq{cmd:WR, data:pack(ctNow)});
  //   end
  // endrule

  function Put#(WtiReq#(64)) reqPutF(WtiMasterIfc#(64) x) = x.reqPut;                 // select the reqPut Put subinterface of WtiMasterIfc
  Vector#(Nwti_app, WtiReq#(64)) vFoo = replicate(WtiReq{cmd:WR, data:pack(ctNow)});  // Make our Vector of Requests
  mkConnection (map(toGet,vFoo), map(reqPutF,wtiM));                                  // Connect the values to the Puts



  interface Server server     = inf.server;   // Pass the sever interface provided by OCInf straight through
  interface Server cpServer   = inf.cpServer; // cpServer for Ethernet access to control plane
  method led                  = inf.led;
  method switch               = inf.switch;
  interface GPS64_t cpNow     = inf.cpNow;
  interface GPSIfc  gps       = inf.gps;
  interface Vector  wci_m     = wci_c2f;
  //interface Wsi_s wsi_s_adc   = app.wsi_s_adc; // The ADC device-worker to the application  // FIXME Poly Width
  //interface Wsi_m wsi_m_dac   = app.wsi_m_dac; // The DAC device-worker to the application  // FIXME Poly Width
  interface WmemiEM16B wmemiM0 = app.wmemiM0;
//  interface UART_pads  upads   = inf.upads;
endmodule : mkCTop

// Synthesizeable, non-polymorphic modules that use the poly module above...

`ifdef USE_NDW1
typedef CTopIfc#(1) CTop4BIfc;
(* synthesize *)
module mkCTop4B#(PciId pciDevice, Clock sys0_clk, Reset sys0_rst) (CTop4BIfc);
  CTop4BIfc _a <- mkCTop(pciDevice, sys0_clk, sys0_rst); return _a;
endmodule

`elsif USE_NDW2
typedef CTopIfc#(2) CTop8BIfc;
(* synthesize *)
module mkCTop8B#(PciId pciDevice, Clock sys0_clk, Reset sys0_rst) (CTop8BIfc);
  CTop8BIfc _a <- mkCTop(pciDevice, sys0_clk, sys0_rst); return _a;
endmodule

`elsif USE_NDW4
typedef CTopIfc#(4) CTop16BIfc;
(* synthesize *)
module mkCTop16B#(PciId pciDevice, Clock sys0_clk, Reset sys0_rst) (CTop16BIfc);
  CTop16BIfc _a <- mkCTop(pciDevice, sys0_clk, sys0_rst); return _a;
endmodule

`elsif USE_NDW8
typedef CTopIfc#(8) CTop32BIfc;
(* synthesize *)
module mkCTop32B#(PciId pciDevice, Clock sys0_clk, Reset sys0_rst) (CTop32BIfc);
  CTop32BIfc _a <- mkCTop(pciDevice, sys0_clk, sys0_rst); return _a;
endmodule
`endif


endpackage: CTop

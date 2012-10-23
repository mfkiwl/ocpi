//
// Generated by Bluespec Compiler, version 2012.09.beta1 (build 29570, 2012-09.11)
//
// On Tue Oct 23 15:39:39 EDT 2012
//
//
// Ports:
// Name                         I/O  size props
// RDY_gpsTime                    O     1
// wti_m_req                      O    67
// CLK_sys0_clk                   I     1 clock
// RST_N_sys0_rst                 I     1 reset
// CLK_wti_clk                    I     1 clock
// RST_N_wti_rst                  I     1 reset
// CLK                            I     1 unused
// RST_N                          I     1 unused
// gpsTime_arg                    I    64
// EN_gpsTime                     I     1
// wti_m_SThreadBusy              I     1 reg
// wti_m_SReset_n                 I     1 reg
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkTimeClient(CLK_sys0_clk,
		    RST_N_sys0_rst,
		    CLK_wti_clk,
		    RST_N_wti_rst,
		    CLK,
		    RST_N,

		    gpsTime_arg,
		    EN_gpsTime,
		    RDY_gpsTime,

		    wti_m_req,

		    wti_m_SThreadBusy,

		    wti_m_SReset_n);
  input  CLK_sys0_clk;
  input  RST_N_sys0_rst;
  input  CLK_wti_clk;
  input  RST_N_wti_rst;
  input  CLK;
  input  RST_N;

  // action method gpsTime
  input  [63 : 0] gpsTime_arg;
  input  EN_gpsTime;
  output RDY_gpsTime;

  // value method wti_m_get
  output [66 : 0] wti_m_req;

  // action method wti_m_sThreadBusy
  input  wti_m_SThreadBusy;

  // action method wti_m_sReset_n
  input  wti_m_SReset_n;

  // signals for module outputs
  wire [66 : 0] wti_m_req;
  wire RDY_gpsTime;

  // inlined wires
  wire wti_peerIsReady_1$wget,
       wti_peerIsReady_1$whas,
       wti_sThreadBusy_pw$whas;

  // register wti_nowReq
  reg [66 : 0] wti_nowReq;
  wire [66 : 0] wti_nowReq$D_IN;
  wire wti_nowReq$EN;

  // register wti_peerIsReady
  reg wti_peerIsReady;
  wire wti_peerIsReady$D_IN, wti_peerIsReady$EN;

  // register wti_sThreadBusy_d
  reg wti_sThreadBusy_d;
  wire wti_sThreadBusy_d$D_IN, wti_sThreadBusy_d$EN;

  // ports of submodule now
  wire [63 : 0] now$dD_OUT, now$sD_IN;
  wire now$sEN, now$sRDY;

  // action method gpsTime
  assign RDY_gpsTime = now$sRDY ;

  // value method wti_m_get
  assign wti_m_req = wti_sThreadBusy_d ? 67'h0AAAAAAAAAAAAAAAA : wti_nowReq ;

  // submodule now
  SyncRegister #(.width(32'd64), .init(64'd0)) now(.sCLK(CLK_sys0_clk),
						   .dCLK(CLK_wti_clk),
						   .sRST(RST_N_sys0_rst),
						   .sD_IN(now$sD_IN),
						   .sEN(now$sEN),
						   .dD_OUT(now$dD_OUT),
						   .sRDY(now$sRDY));

  // inlined wires
  assign wti_peerIsReady_1$wget = 1'd1 ;
  assign wti_peerIsReady_1$whas = wti_m_SReset_n ;
  assign wti_sThreadBusy_pw$whas = wti_m_SThreadBusy ;

  // register wti_nowReq
  assign wti_nowReq$D_IN = { 3'd1, now$dD_OUT } ;
  assign wti_nowReq$EN = 1'd1 ;

  // register wti_peerIsReady
  assign wti_peerIsReady$D_IN = wti_m_SReset_n ;
  assign wti_peerIsReady$EN = 1'd1 ;

  // register wti_sThreadBusy_d
  assign wti_sThreadBusy_d$D_IN = wti_m_SThreadBusy ;
  assign wti_sThreadBusy_d$EN = 1'd1 ;

  // submodule now
  assign now$sD_IN = gpsTime_arg ;
  assign now$sEN = EN_gpsTime ;

  // handling of inlined registers

  always@(posedge CLK_wti_clk)
  begin
    if (RST_N_wti_rst == `BSV_RESET_VALUE)
      begin
        wti_nowReq <= `BSV_ASSIGNMENT_DELAY 67'd0;
	wti_peerIsReady <= `BSV_ASSIGNMENT_DELAY 1'd0;
	wti_sThreadBusy_d <= `BSV_ASSIGNMENT_DELAY 1'd1;
      end
    else
      begin
        if (wti_nowReq$EN)
	  wti_nowReq <= `BSV_ASSIGNMENT_DELAY wti_nowReq$D_IN;
	if (wti_peerIsReady$EN)
	  wti_peerIsReady <= `BSV_ASSIGNMENT_DELAY wti_peerIsReady$D_IN;
	if (wti_sThreadBusy_d$EN)
	  wti_sThreadBusy_d <= `BSV_ASSIGNMENT_DELAY wti_sThreadBusy_d$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    wti_nowReq = 67'h2AAAAAAAAAAAAAAAA;
    wti_peerIsReady = 1'h0;
    wti_sThreadBusy_d = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkTimeClient


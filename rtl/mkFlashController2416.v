//
// Generated by Bluespec Compiler, version 2011.06.D (build 24470, 2011-06-30)
//
// On Sun Sep  4 10:35:23 EDT 2011
//
//
// Ports:
// Name                         I/O  size props
// flash_addr                     O    24 reg
// flash_ce_n                     O     1
// flash_oe_n                     O     1
// flash_we_n                     O     1
// flash_wp_n                     O     1 const
// flash_rst_n                    O     1 const
// flash_adv_n                    O     1 const
// RDY_user_request_put           O     1 reg
// user_response_get              O    16 reg
// RDY_user_response_get          O     1 reg
// user_waitBit                   O     1 reg
// RDY_user_waitBit               O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// flash_fwait_i                  I     1 reg
// user_request_put               I    41 reg
// EN_user_request_put            I     1
// EN_user_response_get           I     1
// flash_io_dq                   IO    16 inout
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif

module mkFlashController2416(CLK,
			     RST_N,

			     flash_io_dq,

			     flash_addr,

			     flash_ce_n,

			     flash_oe_n,

			     flash_we_n,

			     flash_wp_n,

			     flash_rst_n,

			     flash_adv_n,

			     flash_fwait_i,

			     user_request_put,
			     EN_user_request_put,
			     RDY_user_request_put,

			     EN_user_response_get,
			     user_response_get,
			     RDY_user_response_get,

			     user_waitBit,
			     RDY_user_waitBit);
  input  CLK;
  input  RST_N;

  inout  [15 : 0] flash_io_dq;

  // value method flash_addr
  output [23 : 0] flash_addr;

  // value method flash_ce_n
  output flash_ce_n;

  // value method flash_oe_n
  output flash_oe_n;

  // value method flash_we_n
  output flash_we_n;

  // value method flash_wp_n
  output flash_wp_n;

  // value method flash_rst_n
  output flash_rst_n;

  // value method flash_adv_n
  output flash_adv_n;

  // action method flash_fwait
  input  flash_fwait_i;

  // action method user_request_put
  input  [40 : 0] user_request_put;
  input  EN_user_request_put;
  output RDY_user_request_put;

  // actionvalue method user_response_get
  input  EN_user_response_get;
  output [15 : 0] user_response_get;
  output RDY_user_response_get;

  // value method user_waitBit
  output user_waitBit;
  output RDY_user_waitBit;

  // signals for module outputs
  wire [23 : 0] flash_addr;
  wire [15 : 0] user_response_get;
  wire RDY_user_request_put,
       RDY_user_response_get,
       RDY_user_waitBit,
       flash_adv_n,
       flash_ce_n,
       flash_oe_n,
       flash_rst_n,
       flash_we_n,
       flash_wp_n,
       user_waitBit;

  // inlined wires
  wire rseqFsm_abort$wget,
       rseqFsm_abort$whas,
       rseqFsm_start_reg_1_1$wget,
       rseqFsm_start_reg_1_1$whas,
       rseqFsm_start_wire$wget,
       rseqFsm_start_wire$whas,
       rseqFsm_state_fired_1$wget,
       rseqFsm_state_fired_1$whas,
       rseqFsm_state_overlap_pw$whas,
       rseqFsm_state_set_pw$whas,
       wseqFsm_abort$wget,
       wseqFsm_abort$whas,
       wseqFsm_start_reg_1_1$wget,
       wseqFsm_start_reg_1_1$whas,
       wseqFsm_start_wire$wget,
       wseqFsm_start_wire$whas,
       wseqFsm_state_fired_1$wget,
       wseqFsm_state_fired_1$whas,
       wseqFsm_state_overlap_pw$whas,
       wseqFsm_state_set_pw$whas;

  // register aReg
  reg [23 : 0] aReg;
  wire [23 : 0] aReg$D_IN;
  wire aReg$EN;

  // register ceReg
  reg ceReg;
  wire ceReg$D_IN, ceReg$EN;

  // register isRead
  reg isRead;
  wire isRead$D_IN, isRead$EN;

  // register oeReg
  reg oeReg;
  wire oeReg$D_IN, oeReg$EN;

  // register rseqFsm_jj_delay_count
  reg [14 : 0] rseqFsm_jj_delay_count;
  wire [14 : 0] rseqFsm_jj_delay_count$D_IN;
  wire rseqFsm_jj_delay_count$EN;

  // register rseqFsm_start_reg
  reg rseqFsm_start_reg;
  wire rseqFsm_start_reg$D_IN, rseqFsm_start_reg$EN;

  // register rseqFsm_start_reg_1
  reg rseqFsm_start_reg_1;
  wire rseqFsm_start_reg_1$D_IN, rseqFsm_start_reg_1$EN;

  // register rseqFsm_state_can_overlap
  reg rseqFsm_state_can_overlap;
  wire rseqFsm_state_can_overlap$D_IN, rseqFsm_state_can_overlap$EN;

  // register rseqFsm_state_fired
  reg rseqFsm_state_fired;
  wire rseqFsm_state_fired$D_IN, rseqFsm_state_fired$EN;

  // register rseqFsm_state_mkFSMstate
  reg [3 : 0] rseqFsm_state_mkFSMstate;
  reg [3 : 0] rseqFsm_state_mkFSMstate$D_IN;
  wire rseqFsm_state_mkFSMstate$EN;

  // register tsOE
  reg tsOE;
  wire tsOE$D_IN, tsOE$EN;

  // register tsWD
  reg [15 : 0] tsWD;
  wire [15 : 0] tsWD$D_IN;
  wire tsWD$EN;

  // register waitReg
  reg waitReg;
  wire waitReg$D_IN, waitReg$EN;

  // register wdReg
  reg [15 : 0] wdReg;
  wire [15 : 0] wdReg$D_IN;
  wire wdReg$EN;

  // register weReg
  reg weReg;
  wire weReg$D_IN, weReg$EN;

  // register wseqFsm_jj_delay_count
  reg [14 : 0] wseqFsm_jj_delay_count;
  wire [14 : 0] wseqFsm_jj_delay_count$D_IN;
  wire wseqFsm_jj_delay_count$EN;

  // register wseqFsm_start_reg
  reg wseqFsm_start_reg;
  wire wseqFsm_start_reg$D_IN, wseqFsm_start_reg$EN;

  // register wseqFsm_start_reg_1
  reg wseqFsm_start_reg_1;
  wire wseqFsm_start_reg_1$D_IN, wseqFsm_start_reg_1$EN;

  // register wseqFsm_state_can_overlap
  reg wseqFsm_state_can_overlap;
  wire wseqFsm_state_can_overlap$D_IN, wseqFsm_state_can_overlap$EN;

  // register wseqFsm_state_fired
  reg wseqFsm_state_fired;
  wire wseqFsm_state_fired$D_IN, wseqFsm_state_fired$EN;

  // register wseqFsm_state_mkFSMstate
  reg [3 : 0] wseqFsm_state_mkFSMstate;
  reg [3 : 0] wseqFsm_state_mkFSMstate$D_IN;
  wire wseqFsm_state_mkFSMstate$EN;

  // ports of submodule reqF
  wire [40 : 0] reqF$D_IN, reqF$D_OUT;
  wire reqF$CLR, reqF$DEQ, reqF$EMPTY_N, reqF$ENQ, reqF$FULL_N;

  // ports of submodule respF
  wire [15 : 0] respF$D_IN, respF$D_OUT;
  wire respF$CLR, respF$DEQ, respF$EMPTY_N, respF$ENQ, respF$FULL_N;

  // ports of submodule tsd
  wire [15 : 0] tsd$IO, tsd$O;

  // rule scheduling signals
  wire WILL_FIRE_RL_nextRequest,
       WILL_FIRE_RL_rseqFsm_action_d_init_np,
       WILL_FIRE_RL_rseqFsm_action_l57c12,
       WILL_FIRE_RL_rseqFsm_action_l58c12,
       WILL_FIRE_RL_rseqFsm_action_l60c10,
       WILL_FIRE_RL_rseqFsm_action_l61c12,
       WILL_FIRE_RL_rseqFsm_action_l62c12,
       WILL_FIRE_RL_rseqFsm_action_np,
       WILL_FIRE_RL_rseqFsm_fsm_start,
       WILL_FIRE_RL_rseqFsm_idle_l56c15,
       WILL_FIRE_RL_wseqFsm_action_d_init_np,
       WILL_FIRE_RL_wseqFsm_action_l67c12,
       WILL_FIRE_RL_wseqFsm_action_l68c12,
       WILL_FIRE_RL_wseqFsm_action_l69c12,
       WILL_FIRE_RL_wseqFsm_action_l71c12,
       WILL_FIRE_RL_wseqFsm_action_l72c12,
       WILL_FIRE_RL_wseqFsm_action_l73c12,
       WILL_FIRE_RL_wseqFsm_action_np,
       WILL_FIRE_RL_wseqFsm_fsm_start,
       WILL_FIRE_RL_wseqFsm_idle_l66c15;

  // inputs to muxes for submodule ports
  wire [14 : 0] MUX_rseqFsm_jj_delay_count$write_1__VAL_1,
		MUX_wseqFsm_jj_delay_count$write_1__VAL_1;
  wire MUX_ceReg$write_1__SEL_1,
       MUX_rseqFsm_start_reg$write_1__SEL_1,
       MUX_wseqFsm_start_reg$write_1__SEL_1;

  // remaining internal signals
  wire IF_reqF_first__48_BIT_40_49_THEN_rseqFsm_abort_ETC___d154,
       rseqFsm_abort_whas_AND_rseqFsm_abort_wget_OR_r_ETC___d71,
       wseqFsm_abort_whas__7_AND_wseqFsm_abort_wget___ETC___d144;

  // value method flash_addr
  assign flash_addr = aReg ;

  // value method flash_ce_n
  assign flash_ce_n = !ceReg ;

  // value method flash_oe_n
  assign flash_oe_n = !oeReg ;

  // value method flash_we_n
  assign flash_we_n = !weReg ;

  // value method flash_wp_n
  assign flash_wp_n = 1'b1 ;

  // value method flash_rst_n
  assign flash_rst_n = 1'b1 ;

  // value method flash_adv_n
  assign flash_adv_n = 1'b1 ;

  // action method user_request_put
  assign RDY_user_request_put = reqF$FULL_N ;

  // actionvalue method user_response_get
  assign user_response_get = respF$D_OUT ;
  assign RDY_user_response_get = respF$EMPTY_N ;

  // value method user_waitBit
  assign user_waitBit = waitReg ;
  assign RDY_user_waitBit = 1'd1 ;

  // submodule reqF
  FIFO2 #(.width(32'd41), .guarded(32'd1)) reqF(.RST_N(RST_N),
						.CLK(CLK),
						.D_IN(reqF$D_IN),
						.ENQ(reqF$ENQ),
						.DEQ(reqF$DEQ),
						.CLR(reqF$CLR),
						.D_OUT(reqF$D_OUT),
						.FULL_N(reqF$FULL_N),
						.EMPTY_N(reqF$EMPTY_N));

  // submodule respF
  FIFO2 #(.width(32'd16), .guarded(32'd1)) respF(.RST_N(RST_N),
						 .CLK(CLK),
						 .D_IN(respF$D_IN),
						 .ENQ(respF$ENQ),
						 .DEQ(respF$DEQ),
						 .CLR(respF$CLR),
						 .D_OUT(respF$D_OUT),
						 .FULL_N(respF$FULL_N),
						 .EMPTY_N(respF$EMPTY_N));

  // submodule tsd
  TriState #(.width(32'd16)) tsd(.I(tsWD), .OE(tsOE), .O(tsd$O), .IO(tsd$IO));

  // rule RL_rseqFsm_action_l58c12
  assign WILL_FIRE_RL_rseqFsm_action_l58c12 =
	     isRead && rseqFsm_state_mkFSMstate == 4'd1 ;

  // rule RL_rseqFsm_action_d_init_np
  assign WILL_FIRE_RL_rseqFsm_action_d_init_np =
	     isRead && rseqFsm_state_mkFSMstate == 4'd2 ;

  // rule RL_rseqFsm_action_np
  assign WILL_FIRE_RL_rseqFsm_action_np =
	     isRead && !rseqFsm_jj_delay_count[14] &&
	     (rseqFsm_state_mkFSMstate == 4'd3 ||
	      rseqFsm_state_mkFSMstate == 4'd4) ;

  // rule RL_rseqFsm_action_l60c10
  assign WILL_FIRE_RL_rseqFsm_action_l60c10 =
	     respF$FULL_N && isRead && rseqFsm_jj_delay_count[14] &&
	     (rseqFsm_state_mkFSMstate == 4'd3 ||
	      rseqFsm_state_mkFSMstate == 4'd4) ;

  // rule RL_rseqFsm_action_l61c12
  assign WILL_FIRE_RL_rseqFsm_action_l61c12 =
	     isRead && rseqFsm_state_mkFSMstate == 4'd5 ;

  // rule RL_rseqFsm_action_l62c12
  assign WILL_FIRE_RL_rseqFsm_action_l62c12 =
	     isRead && rseqFsm_state_mkFSMstate == 4'd6 ;

  // rule RL_rseqFsm_fsm_start
  assign WILL_FIRE_RL_rseqFsm_fsm_start =
	     rseqFsm_abort_whas_AND_rseqFsm_abort_wget_OR_r_ETC___d71 &&
	     rseqFsm_start_reg ;

  // rule RL_rseqFsm_action_l57c12
  assign WILL_FIRE_RL_rseqFsm_action_l57c12 =
	     isRead && rseqFsm_start_wire$whas &&
	     (rseqFsm_state_mkFSMstate == 4'd0 ||
	      rseqFsm_state_mkFSMstate == 4'd7) ;

  // rule RL_rseqFsm_idle_l56c15
  assign WILL_FIRE_RL_rseqFsm_idle_l56c15 =
	     !rseqFsm_start_wire$whas && rseqFsm_state_mkFSMstate == 4'd7 ;

  // rule RL_wseqFsm_action_l68c12
  assign WILL_FIRE_RL_wseqFsm_action_l68c12 =
	     !isRead && wseqFsm_state_mkFSMstate == 4'd1 ;

  // rule RL_wseqFsm_action_l69c12
  assign WILL_FIRE_RL_wseqFsm_action_l69c12 =
	     !isRead && wseqFsm_state_mkFSMstate == 4'd2 ;

  // rule RL_wseqFsm_action_d_init_np
  assign WILL_FIRE_RL_wseqFsm_action_d_init_np =
	     !isRead && wseqFsm_state_mkFSMstate == 4'd3 ;

  // rule RL_wseqFsm_action_np
  assign WILL_FIRE_RL_wseqFsm_action_np =
	     !isRead && !wseqFsm_jj_delay_count[14] &&
	     (wseqFsm_state_mkFSMstate == 4'd4 ||
	      wseqFsm_state_mkFSMstate == 4'd5) ;

  // rule RL_wseqFsm_action_l71c12
  assign WILL_FIRE_RL_wseqFsm_action_l71c12 =
	     !isRead && wseqFsm_jj_delay_count[14] &&
	     (wseqFsm_state_mkFSMstate == 4'd4 ||
	      wseqFsm_state_mkFSMstate == 4'd5) ;

  // rule RL_wseqFsm_action_l72c12
  assign WILL_FIRE_RL_wseqFsm_action_l72c12 =
	     !isRead && wseqFsm_state_mkFSMstate == 4'd6 ;

  // rule RL_wseqFsm_action_l73c12
  assign WILL_FIRE_RL_wseqFsm_action_l73c12 =
	     !isRead && wseqFsm_state_mkFSMstate == 4'd7 ;

  // rule RL_wseqFsm_fsm_start
  assign WILL_FIRE_RL_wseqFsm_fsm_start =
	     wseqFsm_abort_whas__7_AND_wseqFsm_abort_wget___ETC___d144 &&
	     wseqFsm_start_reg ;

  // rule RL_wseqFsm_action_l67c12
  assign WILL_FIRE_RL_wseqFsm_action_l67c12 =
	     !isRead && wseqFsm_start_wire$whas &&
	     (wseqFsm_state_mkFSMstate == 4'd0 ||
	      wseqFsm_state_mkFSMstate == 4'd8) ;

  // rule RL_nextRequest
  assign WILL_FIRE_RL_nextRequest =
	     reqF$EMPTY_N &&
	     IF_reqF_first__48_BIT_40_49_THEN_rseqFsm_abort_ETC___d154 &&
	     rseqFsm_abort_whas_AND_rseqFsm_abort_wget_OR_r_ETC___d71 &&
	     !rseqFsm_start_reg &&
	     wseqFsm_abort_whas__7_AND_wseqFsm_abort_wget___ETC___d144 &&
	     !wseqFsm_start_reg ;

  // rule RL_wseqFsm_idle_l66c15
  assign WILL_FIRE_RL_wseqFsm_idle_l66c15 =
	     !wseqFsm_start_wire$whas && wseqFsm_state_mkFSMstate == 4'd8 ;

  // inputs to muxes for submodule ports
  assign MUX_ceReg$write_1__SEL_1 =
	     WILL_FIRE_RL_wseqFsm_action_l73c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l62c12 ;
  assign MUX_rseqFsm_start_reg$write_1__SEL_1 =
	     WILL_FIRE_RL_nextRequest && reqF$D_OUT[40] ;
  assign MUX_wseqFsm_start_reg$write_1__SEL_1 =
	     WILL_FIRE_RL_nextRequest && !reqF$D_OUT[40] ;
  assign MUX_rseqFsm_jj_delay_count$write_1__VAL_1 =
	     { rseqFsm_jj_delay_count[13:0], 1'd0 } ;
  assign MUX_wseqFsm_jj_delay_count$write_1__VAL_1 =
	     { wseqFsm_jj_delay_count[13:0], 1'd0 } ;

  // inlined wires
  assign rseqFsm_start_wire$wget = 1'd1 ;
  assign rseqFsm_start_wire$whas =
	     WILL_FIRE_RL_rseqFsm_fsm_start ||
	     rseqFsm_start_reg_1 && !rseqFsm_state_fired ;
  assign rseqFsm_start_reg_1_1$wget = 1'd1 ;
  assign rseqFsm_start_reg_1_1$whas = rseqFsm_start_wire$whas ;
  assign rseqFsm_abort$wget = 1'b0 ;
  assign rseqFsm_abort$whas = 1'b0 ;
  assign rseqFsm_state_fired_1$wget = 1'd1 ;
  assign rseqFsm_state_fired_1$whas = rseqFsm_state_set_pw$whas ;
  assign wseqFsm_start_wire$wget = 1'd1 ;
  assign wseqFsm_start_wire$whas =
	     WILL_FIRE_RL_wseqFsm_fsm_start ||
	     wseqFsm_start_reg_1 && !wseqFsm_state_fired ;
  assign wseqFsm_start_reg_1_1$wget = 1'd1 ;
  assign wseqFsm_start_reg_1_1$whas = wseqFsm_start_wire$whas ;
  assign wseqFsm_abort$wget = 1'b0 ;
  assign wseqFsm_abort$whas = 1'b0 ;
  assign wseqFsm_state_fired_1$wget = 1'd1 ;
  assign wseqFsm_state_fired_1$whas = wseqFsm_state_set_pw$whas ;
  assign rseqFsm_state_set_pw$whas =
	     WILL_FIRE_RL_rseqFsm_idle_l56c15 ||
	     WILL_FIRE_RL_rseqFsm_action_l62c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l60c10 ||
	     WILL_FIRE_RL_rseqFsm_action_np ||
	     WILL_FIRE_RL_rseqFsm_action_d_init_np ||
	     WILL_FIRE_RL_rseqFsm_action_l58c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l57c12 ;
  assign rseqFsm_state_overlap_pw$whas = 1'b0 ;
  assign wseqFsm_state_set_pw$whas =
	     WILL_FIRE_RL_wseqFsm_idle_l66c15 ||
	     WILL_FIRE_RL_wseqFsm_action_l73c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	     WILL_FIRE_RL_wseqFsm_action_np ||
	     WILL_FIRE_RL_wseqFsm_action_d_init_np ||
	     WILL_FIRE_RL_wseqFsm_action_l69c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l68c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l67c12 ;
  assign wseqFsm_state_overlap_pw$whas = 1'b0 ;

  // register aReg
  assign aReg$D_IN = reqF$D_OUT[39:16] ;
  assign aReg$EN = WILL_FIRE_RL_nextRequest ;

  // register ceReg
  assign ceReg$D_IN = !MUX_ceReg$write_1__SEL_1 ;
  assign ceReg$EN =
	     WILL_FIRE_RL_wseqFsm_action_l73c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l62c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l67c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l57c12 ;

  // register isRead
  assign isRead$D_IN = reqF$D_OUT[40] ;
  assign isRead$EN = WILL_FIRE_RL_nextRequest ;

  // register oeReg
  assign oeReg$D_IN = !WILL_FIRE_RL_rseqFsm_action_l61c12 ;
  assign oeReg$EN =
	     WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l58c12 ;

  // register rseqFsm_jj_delay_count
  assign rseqFsm_jj_delay_count$D_IN =
	     WILL_FIRE_RL_rseqFsm_action_np ?
	       MUX_rseqFsm_jj_delay_count$write_1__VAL_1 :
	       15'd1 ;
  assign rseqFsm_jj_delay_count$EN =
	     WILL_FIRE_RL_rseqFsm_action_np ||
	     WILL_FIRE_RL_rseqFsm_action_d_init_np ;

  // register rseqFsm_start_reg
  assign rseqFsm_start_reg$D_IN = MUX_rseqFsm_start_reg$write_1__SEL_1 ;
  assign rseqFsm_start_reg$EN =
	     WILL_FIRE_RL_nextRequest && reqF$D_OUT[40] ||
	     WILL_FIRE_RL_rseqFsm_fsm_start ;

  // register rseqFsm_start_reg_1
  assign rseqFsm_start_reg_1$D_IN = rseqFsm_start_wire$whas ;
  assign rseqFsm_start_reg_1$EN = 1'd1 ;

  // register rseqFsm_state_can_overlap
  assign rseqFsm_state_can_overlap$D_IN =
	     rseqFsm_state_set_pw$whas || rseqFsm_state_can_overlap ;
  assign rseqFsm_state_can_overlap$EN = 1'd1 ;

  // register rseqFsm_state_fired
  assign rseqFsm_state_fired$D_IN = rseqFsm_state_set_pw$whas ;
  assign rseqFsm_state_fired$EN = 1'd1 ;

  // register rseqFsm_state_mkFSMstate
  always@(WILL_FIRE_RL_rseqFsm_idle_l56c15 or
	  WILL_FIRE_RL_rseqFsm_action_l57c12 or
	  WILL_FIRE_RL_rseqFsm_action_l58c12 or
	  WILL_FIRE_RL_rseqFsm_action_d_init_np or
	  WILL_FIRE_RL_rseqFsm_action_np or
	  WILL_FIRE_RL_rseqFsm_action_l60c10 or
	  WILL_FIRE_RL_rseqFsm_action_l61c12 or
	  WILL_FIRE_RL_rseqFsm_action_l62c12)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_rseqFsm_idle_l56c15: rseqFsm_state_mkFSMstate$D_IN = 4'd0;
      WILL_FIRE_RL_rseqFsm_action_l57c12:
	  rseqFsm_state_mkFSMstate$D_IN = 4'd1;
      WILL_FIRE_RL_rseqFsm_action_l58c12:
	  rseqFsm_state_mkFSMstate$D_IN = 4'd2;
      WILL_FIRE_RL_rseqFsm_action_d_init_np:
	  rseqFsm_state_mkFSMstate$D_IN = 4'd3;
      WILL_FIRE_RL_rseqFsm_action_np: rseqFsm_state_mkFSMstate$D_IN = 4'd4;
      WILL_FIRE_RL_rseqFsm_action_l60c10:
	  rseqFsm_state_mkFSMstate$D_IN = 4'd5;
      WILL_FIRE_RL_rseqFsm_action_l61c12:
	  rseqFsm_state_mkFSMstate$D_IN = 4'd6;
      WILL_FIRE_RL_rseqFsm_action_l62c12:
	  rseqFsm_state_mkFSMstate$D_IN = 4'd7;
      default: rseqFsm_state_mkFSMstate$D_IN =
		   4'b1010 /* unspecified value */ ;
    endcase
  end
  assign rseqFsm_state_mkFSMstate$EN =
	     WILL_FIRE_RL_rseqFsm_idle_l56c15 ||
	     WILL_FIRE_RL_rseqFsm_action_l57c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l58c12 ||
	     WILL_FIRE_RL_rseqFsm_action_d_init_np ||
	     WILL_FIRE_RL_rseqFsm_action_np ||
	     WILL_FIRE_RL_rseqFsm_action_l60c10 ||
	     WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	     WILL_FIRE_RL_rseqFsm_action_l62c12 ;

  // register tsOE
  assign tsOE$D_IN = !WILL_FIRE_RL_wseqFsm_action_l72c12 ;
  assign tsOE$EN =
	     WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l68c12 ;

  // register tsWD
  assign tsWD$D_IN = reqF$D_OUT[15:0] ;
  assign tsWD$EN = WILL_FIRE_RL_nextRequest ;

  // register waitReg
  assign waitReg$D_IN = flash_fwait_i ;
  assign waitReg$EN = 1'd1 ;

  // register wdReg
  assign wdReg$D_IN = 16'h0 ;
  assign wdReg$EN = 1'b0 ;

  // register weReg
  assign weReg$D_IN = !WILL_FIRE_RL_wseqFsm_action_l71c12 ;
  assign weReg$EN =
	     WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l69c12 ;

  // register wseqFsm_jj_delay_count
  assign wseqFsm_jj_delay_count$D_IN =
	     WILL_FIRE_RL_wseqFsm_action_np ?
	       MUX_wseqFsm_jj_delay_count$write_1__VAL_1 :
	       15'd1 ;
  assign wseqFsm_jj_delay_count$EN =
	     WILL_FIRE_RL_wseqFsm_action_np ||
	     WILL_FIRE_RL_wseqFsm_action_d_init_np ;

  // register wseqFsm_start_reg
  assign wseqFsm_start_reg$D_IN = MUX_wseqFsm_start_reg$write_1__SEL_1 ;
  assign wseqFsm_start_reg$EN =
	     WILL_FIRE_RL_nextRequest && !reqF$D_OUT[40] ||
	     WILL_FIRE_RL_wseqFsm_fsm_start ;

  // register wseqFsm_start_reg_1
  assign wseqFsm_start_reg_1$D_IN = wseqFsm_start_wire$whas ;
  assign wseqFsm_start_reg_1$EN = 1'd1 ;

  // register wseqFsm_state_can_overlap
  assign wseqFsm_state_can_overlap$D_IN =
	     wseqFsm_state_set_pw$whas || wseqFsm_state_can_overlap ;
  assign wseqFsm_state_can_overlap$EN = 1'd1 ;

  // register wseqFsm_state_fired
  assign wseqFsm_state_fired$D_IN = wseqFsm_state_set_pw$whas ;
  assign wseqFsm_state_fired$EN = 1'd1 ;

  // register wseqFsm_state_mkFSMstate
  always@(WILL_FIRE_RL_wseqFsm_idle_l66c15 or
	  WILL_FIRE_RL_wseqFsm_action_l67c12 or
	  WILL_FIRE_RL_wseqFsm_action_l68c12 or
	  WILL_FIRE_RL_wseqFsm_action_l69c12 or
	  WILL_FIRE_RL_wseqFsm_action_d_init_np or
	  WILL_FIRE_RL_wseqFsm_action_np or
	  WILL_FIRE_RL_wseqFsm_action_l71c12 or
	  WILL_FIRE_RL_wseqFsm_action_l72c12 or
	  WILL_FIRE_RL_wseqFsm_action_l73c12)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_wseqFsm_idle_l66c15: wseqFsm_state_mkFSMstate$D_IN = 4'd0;
      WILL_FIRE_RL_wseqFsm_action_l67c12:
	  wseqFsm_state_mkFSMstate$D_IN = 4'd1;
      WILL_FIRE_RL_wseqFsm_action_l68c12:
	  wseqFsm_state_mkFSMstate$D_IN = 4'd2;
      WILL_FIRE_RL_wseqFsm_action_l69c12:
	  wseqFsm_state_mkFSMstate$D_IN = 4'd3;
      WILL_FIRE_RL_wseqFsm_action_d_init_np:
	  wseqFsm_state_mkFSMstate$D_IN = 4'd4;
      WILL_FIRE_RL_wseqFsm_action_np: wseqFsm_state_mkFSMstate$D_IN = 4'd5;
      WILL_FIRE_RL_wseqFsm_action_l71c12:
	  wseqFsm_state_mkFSMstate$D_IN = 4'd6;
      WILL_FIRE_RL_wseqFsm_action_l72c12:
	  wseqFsm_state_mkFSMstate$D_IN = 4'd7;
      WILL_FIRE_RL_wseqFsm_action_l73c12:
	  wseqFsm_state_mkFSMstate$D_IN = 4'd8;
      default: wseqFsm_state_mkFSMstate$D_IN =
		   4'b1010 /* unspecified value */ ;
    endcase
  end
  assign wseqFsm_state_mkFSMstate$EN =
	     WILL_FIRE_RL_wseqFsm_idle_l66c15 ||
	     WILL_FIRE_RL_wseqFsm_action_l67c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l68c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l69c12 ||
	     WILL_FIRE_RL_wseqFsm_action_d_init_np ||
	     WILL_FIRE_RL_wseqFsm_action_np ||
	     WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	     WILL_FIRE_RL_wseqFsm_action_l73c12 ;

  // submodule reqF
  assign reqF$D_IN = user_request_put ;
  assign reqF$ENQ = EN_user_request_put ;
  assign reqF$DEQ = WILL_FIRE_RL_nextRequest ;
  assign reqF$CLR = 1'b0 ;

  // submodule respF
  assign respF$D_IN = tsd$O ;
  assign respF$ENQ = WILL_FIRE_RL_rseqFsm_action_l60c10 ;
  assign respF$DEQ = EN_user_response_get ;
  assign respF$CLR = 1'b0 ;

  // remaining internal signals
  assign IF_reqF_first__48_BIT_40_49_THEN_rseqFsm_abort_ETC___d154 =
	     reqF$D_OUT[40] ?
	       rseqFsm_abort_whas_AND_rseqFsm_abort_wget_OR_r_ETC___d71 &&
	       !rseqFsm_start_reg :
	       wseqFsm_abort_whas__7_AND_wseqFsm_abort_wget___ETC___d144 &&
	       !wseqFsm_start_reg ;
  assign rseqFsm_abort_whas_AND_rseqFsm_abort_wget_OR_r_ETC___d71 =
	     (rseqFsm_state_mkFSMstate == 4'd0 ||
	      rseqFsm_state_mkFSMstate == 4'd7) &&
	     (!rseqFsm_start_reg_1 || rseqFsm_state_fired) ;
  assign wseqFsm_abort_whas__7_AND_wseqFsm_abort_wget___ETC___d144 =
	     (wseqFsm_state_mkFSMstate == 4'd0 ||
	      wseqFsm_state_mkFSMstate == 4'd8) &&
	     (!wseqFsm_start_reg_1 || wseqFsm_state_fired) ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        aReg <= `BSV_ASSIGNMENT_DELAY 24'd0;
	ceReg <= `BSV_ASSIGNMENT_DELAY 1'd0;
	isRead <= `BSV_ASSIGNMENT_DELAY 1'd1;
	oeReg <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rseqFsm_jj_delay_count <= `BSV_ASSIGNMENT_DELAY 15'd1;
	rseqFsm_start_reg <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rseqFsm_start_reg_1 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rseqFsm_state_can_overlap <= `BSV_ASSIGNMENT_DELAY 1'd1;
	rseqFsm_state_fired <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rseqFsm_state_mkFSMstate <= `BSV_ASSIGNMENT_DELAY 4'd0;
	tsOE <= `BSV_ASSIGNMENT_DELAY 1'd0;
	tsWD <= `BSV_ASSIGNMENT_DELAY 16'd0;
	wdReg <= `BSV_ASSIGNMENT_DELAY 16'd0;
	weReg <= `BSV_ASSIGNMENT_DELAY 1'd0;
	wseqFsm_jj_delay_count <= `BSV_ASSIGNMENT_DELAY 15'd1;
	wseqFsm_start_reg <= `BSV_ASSIGNMENT_DELAY 1'd0;
	wseqFsm_start_reg_1 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	wseqFsm_state_can_overlap <= `BSV_ASSIGNMENT_DELAY 1'd1;
	wseqFsm_state_fired <= `BSV_ASSIGNMENT_DELAY 1'd0;
	wseqFsm_state_mkFSMstate <= `BSV_ASSIGNMENT_DELAY 4'd0;
      end
    else
      begin
        if (aReg$EN) aReg <= `BSV_ASSIGNMENT_DELAY aReg$D_IN;
	if (ceReg$EN) ceReg <= `BSV_ASSIGNMENT_DELAY ceReg$D_IN;
	if (isRead$EN) isRead <= `BSV_ASSIGNMENT_DELAY isRead$D_IN;
	if (oeReg$EN) oeReg <= `BSV_ASSIGNMENT_DELAY oeReg$D_IN;
	if (rseqFsm_jj_delay_count$EN)
	  rseqFsm_jj_delay_count <= `BSV_ASSIGNMENT_DELAY
	      rseqFsm_jj_delay_count$D_IN;
	if (rseqFsm_start_reg$EN)
	  rseqFsm_start_reg <= `BSV_ASSIGNMENT_DELAY rseqFsm_start_reg$D_IN;
	if (rseqFsm_start_reg_1$EN)
	  rseqFsm_start_reg_1 <= `BSV_ASSIGNMENT_DELAY
	      rseqFsm_start_reg_1$D_IN;
	if (rseqFsm_state_can_overlap$EN)
	  rseqFsm_state_can_overlap <= `BSV_ASSIGNMENT_DELAY
	      rseqFsm_state_can_overlap$D_IN;
	if (rseqFsm_state_fired$EN)
	  rseqFsm_state_fired <= `BSV_ASSIGNMENT_DELAY
	      rseqFsm_state_fired$D_IN;
	if (rseqFsm_state_mkFSMstate$EN)
	  rseqFsm_state_mkFSMstate <= `BSV_ASSIGNMENT_DELAY
	      rseqFsm_state_mkFSMstate$D_IN;
	if (tsOE$EN) tsOE <= `BSV_ASSIGNMENT_DELAY tsOE$D_IN;
	if (tsWD$EN) tsWD <= `BSV_ASSIGNMENT_DELAY tsWD$D_IN;
	if (wdReg$EN) wdReg <= `BSV_ASSIGNMENT_DELAY wdReg$D_IN;
	if (weReg$EN) weReg <= `BSV_ASSIGNMENT_DELAY weReg$D_IN;
	if (wseqFsm_jj_delay_count$EN)
	  wseqFsm_jj_delay_count <= `BSV_ASSIGNMENT_DELAY
	      wseqFsm_jj_delay_count$D_IN;
	if (wseqFsm_start_reg$EN)
	  wseqFsm_start_reg <= `BSV_ASSIGNMENT_DELAY wseqFsm_start_reg$D_IN;
	if (wseqFsm_start_reg_1$EN)
	  wseqFsm_start_reg_1 <= `BSV_ASSIGNMENT_DELAY
	      wseqFsm_start_reg_1$D_IN;
	if (wseqFsm_state_can_overlap$EN)
	  wseqFsm_state_can_overlap <= `BSV_ASSIGNMENT_DELAY
	      wseqFsm_state_can_overlap$D_IN;
	if (wseqFsm_state_fired$EN)
	  wseqFsm_state_fired <= `BSV_ASSIGNMENT_DELAY
	      wseqFsm_state_fired$D_IN;
	if (wseqFsm_state_mkFSMstate$EN)
	  wseqFsm_state_mkFSMstate <= `BSV_ASSIGNMENT_DELAY
	      wseqFsm_state_mkFSMstate$D_IN;
      end
    if (waitReg$EN) waitReg <= `BSV_ASSIGNMENT_DELAY waitReg$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    aReg = 24'hAAAAAA;
    ceReg = 1'h0;
    isRead = 1'h0;
    oeReg = 1'h0;
    rseqFsm_jj_delay_count = 15'h2AAA;
    rseqFsm_start_reg = 1'h0;
    rseqFsm_start_reg_1 = 1'h0;
    rseqFsm_state_can_overlap = 1'h0;
    rseqFsm_state_fired = 1'h0;
    rseqFsm_state_mkFSMstate = 4'hA;
    tsOE = 1'h0;
    tsWD = 16'hAAAA;
    waitReg = 1'h0;
    wdReg = 16'hAAAA;
    weReg = 1'h0;
    wseqFsm_jj_delay_count = 15'h2AAA;
    wseqFsm_start_reg = 1'h0;
    wseqFsm_start_reg_1 = 1'h0;
    wseqFsm_state_can_overlap = 1'h0;
    wseqFsm_state_fired = 1'h0;
    wseqFsm_state_mkFSMstate = 4'hA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N)
      if (WILL_FIRE_RL_rseqFsm_action_l58c12 &&
	  (WILL_FIRE_RL_rseqFsm_action_d_init_np ||
	   WILL_FIRE_RL_rseqFsm_action_np ||
	   WILL_FIRE_RL_rseqFsm_action_l60c10 ||
	   WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	   WILL_FIRE_RL_rseqFsm_action_l62c12))
	$display("Error: \"bsv/dev/Flash.bsv\", line 58, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_rseqFsm_action_l58c12] and\n  [RL_rseqFsm_action_d_init_np, RL_rseqFsm_action_np,\n  RL_rseqFsm_action_l60c10, RL_rseqFsm_action_l61c12,\n  RL_rseqFsm_action_l62c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_rseqFsm_action_d_init_np &&
	  (WILL_FIRE_RL_rseqFsm_action_np ||
	   WILL_FIRE_RL_rseqFsm_action_l60c10 ||
	   WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	   WILL_FIRE_RL_rseqFsm_action_l62c12))
	$display("Error: \"StmtFSM.bs\", line 41, column 0: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_rseqFsm_action_d_init_np] and\n  [RL_rseqFsm_action_np, RL_rseqFsm_action_l60c10, RL_rseqFsm_action_l61c12,\n  RL_rseqFsm_action_l62c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_rseqFsm_action_np &&
	  (WILL_FIRE_RL_rseqFsm_action_l60c10 ||
	   WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	   WILL_FIRE_RL_rseqFsm_action_l62c12))
	$display("Error: \"StmtFSM.bs\", line 41, column 0: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_rseqFsm_action_np] and\n  [RL_rseqFsm_action_l60c10, RL_rseqFsm_action_l61c12,\n  RL_rseqFsm_action_l62c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_rseqFsm_action_l60c10 &&
	  (WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	   WILL_FIRE_RL_rseqFsm_action_l62c12))
	$display("Error: \"bsv/dev/Flash.bsv\", line 60, column 10: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_rseqFsm_action_l60c10] and\n  [RL_rseqFsm_action_l61c12, RL_rseqFsm_action_l62c12] ) fired in the same\n  clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_rseqFsm_action_l61c12 &&
	  WILL_FIRE_RL_rseqFsm_action_l62c12)
	$display("Error: \"bsv/dev/Flash.bsv\", line 61, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_rseqFsm_action_l61c12] and\n  [RL_rseqFsm_action_l62c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_rseqFsm_action_l57c12 &&
	  (WILL_FIRE_RL_rseqFsm_action_l58c12 ||
	   WILL_FIRE_RL_rseqFsm_action_d_init_np ||
	   WILL_FIRE_RL_rseqFsm_action_np ||
	   WILL_FIRE_RL_rseqFsm_action_l60c10 ||
	   WILL_FIRE_RL_rseqFsm_action_l61c12 ||
	   WILL_FIRE_RL_rseqFsm_action_l62c12))
	$display("Error: \"bsv/dev/Flash.bsv\", line 57, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_rseqFsm_action_l57c12] and\n  [RL_rseqFsm_action_l58c12, RL_rseqFsm_action_d_init_np,\n  RL_rseqFsm_action_np, RL_rseqFsm_action_l60c10, RL_rseqFsm_action_l61c12,\n  RL_rseqFsm_action_l62c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_wseqFsm_action_l68c12 &&
	  (WILL_FIRE_RL_wseqFsm_action_l69c12 ||
	   WILL_FIRE_RL_wseqFsm_action_d_init_np ||
	   WILL_FIRE_RL_wseqFsm_action_np ||
	   WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l73c12))
	$display("Error: \"bsv/dev/Flash.bsv\", line 68, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_wseqFsm_action_l68c12] and\n  [RL_wseqFsm_action_l69c12, RL_wseqFsm_action_d_init_np,\n  RL_wseqFsm_action_np, RL_wseqFsm_action_l71c12, RL_wseqFsm_action_l72c12,\n  RL_wseqFsm_action_l73c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_wseqFsm_action_l69c12 &&
	  (WILL_FIRE_RL_wseqFsm_action_d_init_np ||
	   WILL_FIRE_RL_wseqFsm_action_np ||
	   WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l73c12))
	$display("Error: \"bsv/dev/Flash.bsv\", line 69, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_wseqFsm_action_l69c12] and\n  [RL_wseqFsm_action_d_init_np, RL_wseqFsm_action_np,\n  RL_wseqFsm_action_l71c12, RL_wseqFsm_action_l72c12,\n  RL_wseqFsm_action_l73c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_wseqFsm_action_d_init_np &&
	  (WILL_FIRE_RL_wseqFsm_action_np ||
	   WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l73c12))
	$display("Error: \"StmtFSM.bs\", line 41, column 0: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_wseqFsm_action_d_init_np] and\n  [RL_wseqFsm_action_np, RL_wseqFsm_action_l71c12, RL_wseqFsm_action_l72c12,\n  RL_wseqFsm_action_l73c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_wseqFsm_action_np &&
	  (WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l73c12))
	$display("Error: \"StmtFSM.bs\", line 41, column 0: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_wseqFsm_action_np] and\n  [RL_wseqFsm_action_l71c12, RL_wseqFsm_action_l72c12,\n  RL_wseqFsm_action_l73c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_wseqFsm_action_l71c12 &&
	  (WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l73c12))
	$display("Error: \"bsv/dev/Flash.bsv\", line 71, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_wseqFsm_action_l71c12] and\n  [RL_wseqFsm_action_l72c12, RL_wseqFsm_action_l73c12] ) fired in the same\n  clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_wseqFsm_action_l72c12 &&
	  WILL_FIRE_RL_wseqFsm_action_l73c12)
	$display("Error: \"bsv/dev/Flash.bsv\", line 72, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_wseqFsm_action_l72c12] and\n  [RL_wseqFsm_action_l73c12] ) fired in the same clock cycle.\n");
    if (RST_N)
      if (WILL_FIRE_RL_wseqFsm_action_l67c12 &&
	  (WILL_FIRE_RL_wseqFsm_action_l68c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l69c12 ||
	   WILL_FIRE_RL_wseqFsm_action_d_init_np ||
	   WILL_FIRE_RL_wseqFsm_action_np ||
	   WILL_FIRE_RL_wseqFsm_action_l71c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l72c12 ||
	   WILL_FIRE_RL_wseqFsm_action_l73c12))
	$display("Error: \"bsv/dev/Flash.bsv\", line 67, column 12: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_wseqFsm_action_l67c12] and\n  [RL_wseqFsm_action_l68c12, RL_wseqFsm_action_l69c12,\n  RL_wseqFsm_action_d_init_np, RL_wseqFsm_action_np, RL_wseqFsm_action_l71c12,\n  RL_wseqFsm_action_l72c12, RL_wseqFsm_action_l73c12] ) fired in the same\n  clock cycle.\n");
  end
  // synopsys translate_on
endmodule  // mkFlashController2416


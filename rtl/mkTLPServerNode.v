//
// Generated by Bluespec Compiler, version 2012.09.beta1 (build 29570, 2012-09.11)
//
// On Tue Oct 23 15:40:30 EDT 2012
//
//
// Ports:
// Name                         I/O  size props
// c_request_get                  O   153
// RDY_c_request_get              O     1
// RDY_c_response_put             O     1
// RDY_p_put                      O     1
// g_get                          O   153
// RDY_g_get                      O     1
// pfk                            I    14
// CLK                            I     1 clock
// RST_N                          I     1 reset
// c_response_put                 I   153
// p_put                          I   153
// EN_c_response_put              I     1
// EN_p_put                       I     1
// EN_c_request_get               I     1
// EN_g_get                       I     1
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

module mkTLPServerNode(pfk,
		       CLK,
		       RST_N,

		       EN_c_request_get,
		       c_request_get,
		       RDY_c_request_get,

		       c_response_put,
		       EN_c_response_put,
		       RDY_c_response_put,

		       p_put,
		       EN_p_put,
		       RDY_p_put,

		       EN_g_get,
		       g_get,
		       RDY_g_get);
  input  [13 : 0] pfk;
  input  CLK;
  input  RST_N;

  // actionvalue method c_request_get
  input  EN_c_request_get;
  output [152 : 0] c_request_get;
  output RDY_c_request_get;

  // action method c_response_put
  input  [152 : 0] c_response_put;
  input  EN_c_response_put;
  output RDY_c_response_put;

  // action method p_put
  input  [152 : 0] p_put;
  input  EN_p_put;
  output RDY_p_put;

  // actionvalue method g_get
  input  EN_g_get;
  output [152 : 0] g_get;
  output RDY_g_get;

  // signals for module outputs
  wire [152 : 0] c_request_get, g_get;
  wire RDY_c_request_get, RDY_c_response_put, RDY_g_get, RDY_p_put;

  // ports of submodule pktFork
  wire [152 : 0] pktFork$iport_put, pktFork$oport0_get, pktFork$oport1_get;
  wire pktFork$EN_iport_put,
       pktFork$EN_oport0_get,
       pktFork$EN_oport1_get,
       pktFork$RDY_iport_put,
       pktFork$RDY_oport0_get,
       pktFork$RDY_oport1_get;

  // ports of submodule pktMerge
  wire [152 : 0] pktMerge$iport0_put, pktMerge$iport1_put, pktMerge$oport_get;
  wire pktMerge$EN_iport0_put,
       pktMerge$EN_iport1_put,
       pktMerge$EN_oport_get,
       pktMerge$RDY_iport0_put,
       pktMerge$RDY_iport1_put,
       pktMerge$RDY_oport_get;

  // remaining internal signals
  reg [1 : 0] CASE_pfk_BITS_13_TO_12_3_0_pfk_BITS_13_TO_12_1_ETC__q1;
  wire [13 : 0] x__h110;

  // actionvalue method c_request_get
  assign c_request_get = pktFork$oport0_get ;
  assign RDY_c_request_get = pktFork$RDY_oport0_get ;

  // action method c_response_put
  assign RDY_c_response_put = pktMerge$RDY_iport0_put ;

  // action method p_put
  assign RDY_p_put = pktFork$RDY_iport_put ;

  // actionvalue method g_get
  assign g_get = pktMerge$oport_get ;
  assign RDY_g_get = pktMerge$RDY_oport_get ;

  // submodule pktFork
  mkPktFork pktFork(.pfk(x__h110),
		    .CLK(CLK),
		    .RST_N(RST_N),
		    .iport_put(pktFork$iport_put),
		    .EN_iport_put(pktFork$EN_iport_put),
		    .EN_oport0_get(pktFork$EN_oport0_get),
		    .EN_oport1_get(pktFork$EN_oport1_get),
		    .RDY_iport_put(pktFork$RDY_iport_put),
		    .oport0_get(pktFork$oport0_get),
		    .RDY_oport0_get(pktFork$RDY_oport0_get),
		    .oport1_get(pktFork$oport1_get),
		    .RDY_oport1_get(pktFork$RDY_oport1_get));

  // submodule pktMerge
  mkPktMerge pktMerge(.CLK(CLK),
		      .RST_N(RST_N),
		      .iport0_put(pktMerge$iport0_put),
		      .iport1_put(pktMerge$iport1_put),
		      .EN_iport0_put(pktMerge$EN_iport0_put),
		      .EN_iport1_put(pktMerge$EN_iport1_put),
		      .EN_oport_get(pktMerge$EN_oport_get),
		      .RDY_iport0_put(pktMerge$RDY_iport0_put),
		      .RDY_iport1_put(pktMerge$RDY_iport1_put),
		      .oport_get(pktMerge$oport_get),
		      .RDY_oport_get(pktMerge$RDY_oport_get));

  // submodule pktFork
  assign pktFork$iport_put = p_put ;
  assign pktFork$EN_iport_put = EN_p_put ;
  assign pktFork$EN_oport0_get = EN_c_request_get ;
  assign pktFork$EN_oport1_get =
	     pktMerge$RDY_iport1_put && pktFork$RDY_oport1_get ;

  // submodule pktMerge
  assign pktMerge$iport0_put = c_response_put ;
  assign pktMerge$iport1_put = pktFork$oport1_get ;
  assign pktMerge$EN_iport0_put = EN_c_response_put ;
  assign pktMerge$EN_iport1_put =
	     pktMerge$RDY_iport1_put && pktFork$RDY_oport1_get ;
  assign pktMerge$EN_oport_get = EN_g_get ;

  // remaining internal signals
  assign x__h110 =
	     { CASE_pfk_BITS_13_TO_12_3_0_pfk_BITS_13_TO_12_1_ETC__q1,
	       pfk[11:0] } ;
  always@(pfk)
  begin
    case (pfk[13:12])
      2'd0, 2'd1, 2'd2:
	  CASE_pfk_BITS_13_TO_12_3_0_pfk_BITS_13_TO_12_1_ETC__q1 = pfk[13:12];
      2'd3: CASE_pfk_BITS_13_TO_12_3_0_pfk_BITS_13_TO_12_1_ETC__q1 = 2'd3;
    endcase
  end
endmodule  // mkTLPServerNode


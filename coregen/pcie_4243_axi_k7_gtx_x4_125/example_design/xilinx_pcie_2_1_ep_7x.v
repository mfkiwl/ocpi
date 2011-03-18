//-----------------------------------------------------------------------------
//
// (c) Copyright 2009-2011 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
// Project    : Series-7 Integrated Block for PCI Express
// File       : xilinx_pcie_2_1_ep_7x.v
// Version    : 1.1
//--
//-- Description:  PCI Express Endpoint example FPGA design
//--
//------------------------------------------------------------------------------

`timescale 1ns / 1ps



module xilinx_pcie_2_1_ep_7x # (
  parameter PL_FAST_TRAIN     = "FALSE",
  parameter C_DATA_WIDTH      = 128,               // RX/TX interface data width
  parameter STRB_WIDTH        = C_DATA_WIDTH / 8  // TSTRB width
)
(
  output  [3:0]    pci_exp_txp,
  output  [3:0]    pci_exp_txn,
  input   [3:0]    pci_exp_rxp,
  input   [3:0]    pci_exp_rxn,

`ifdef ENABLE_LEDS
  output                                      led_0,
  output                                      led_1,
  output                                      led_2,
`endif
  input                                       sys_clk_p,
  input                                       sys_clk_n,
  input                                       sys_rst_n
);

  wire                                        user_clk;
  wire                                        user_reset;
  wire                                        user_lnk_up;

  // Tx
  wire [5:0]                                  tx_buf_av;
  wire                                        tx_cfg_req;
  wire                                        tx_err_drop;
  wire                                        tx_cfg_gnt;
  wire                                        s_axis_tx_tready;
  wire [3:0]                                  s_axis_tx_tuser;
  wire [C_DATA_WIDTH-1:0]                     s_axis_tx_tdata;
  wire [STRB_WIDTH-1:0]                       s_axis_tx_tstrb;
  wire                                        s_axis_tx_tlast;
  wire                                        s_axis_tx_tvalid;


  // Rx
  wire [C_DATA_WIDTH-1:0]                     m_axis_rx_tdata;
  wire [STRB_WIDTH-1:0]                       m_axis_rx_tstrb;
  wire                                        m_axis_rx_tlast;
  wire                                        m_axis_rx_tvalid;
  wire                                        m_axis_rx_tready;
  wire  [21:0]                                m_axis_rx_tuser;
  wire                                        rx_np_ok;
  wire                                        rx_np_req;

  // Flow Control
  wire [11:0]                                 fc_cpld;
  wire [7:0]                                  fc_cplh;
  wire [11:0]                                 fc_npd;
  wire [7:0]                                  fc_nph;
  wire [11:0]                                 fc_pd;
  wire [7:0]                                  fc_ph;
  wire [2:0]                                  fc_sel;


  //-------------------------------------------------------
  // 3. Configuration (CFG) Interface
  //-------------------------------------------------------

  wire [31:0]                                 cfg_do;
  wire                                        cfg_rd_wr_done;
  wire [31:0]                                 cfg_di;
  wire  [3:0]                                 cfg_byte_en;
  wire  [9:0]                                 cfg_dwaddr;
  wire                                        cfg_wr_en;
  wire                                        cfg_rd_en;

  wire                                        cfg_err_cor;
  wire                                        cfg_err_ur;
  wire                                        cfg_err_ecrc;
  wire                                        cfg_err_cpl_timeout;
  wire                                        cfg_err_cpl_abort;
  wire                                        cfg_err_cpl_unexpect;
  wire                                        cfg_err_posted;
  wire                                        cfg_err_locked;
  wire [47:0]                                 cfg_err_tlp_cpl_header;
  wire                                        cfg_err_cpl_rdy;
  wire                                        cfg_interrupt;
  wire                                        cfg_interrupt_rdy;
  wire                                        cfg_interrupt_assert;
  wire [7:0]                                  cfg_interrupt_di;
  wire [7:0]                                  cfg_interrupt_do;
  wire [2:0]                                  cfg_interrupt_mmenable;
  wire                                        cfg_interrupt_msienable;
  wire                                        cfg_interrupt_msixenable;
  wire                                        cfg_interrupt_msixfm;
  wire                                        cfg_turnoff_ok;
  wire                                        cfg_to_turnoff;
  wire                                        cfg_trn_pending;
  wire                                        cfg_pm_wake;
  wire  [7:0]                                 cfg_bus_number;
  wire  [4:0]                                 cfg_device_number;
  wire  [2:0]                                 cfg_function_number;
  wire [15:0]                                 cfg_status;
  wire [15:0]                                 cfg_command;
  wire [15:0]                                 cfg_dstatus;
  wire [15:0]                                 cfg_dcommand;
  wire [15:0]                                 cfg_lstatus;
  wire [15:0]                                 cfg_lcommand;
  wire [15:0]                                 cfg_dcommand2;
  wire  [2:0]                                 cfg_pcie_link_state;
  wire [63:0]                                 cfg_dsn;
  wire                                        cfg_err_aer_headerlog_set;
  wire                                        cfg_aer_ecrc_check_en;
  wire                                        cfg_aer_ecrc_gen_en;

  //-------------------------------------------------------
  // 4. Physical Layer Control and Status (PL) Interface
  //-------------------------------------------------------

  wire [2:0]                                  pl_initial_link_width;
  wire [1:0]                                  pl_lane_reversal_mode;
  wire                                        pl_link_gen2_capable;
  wire                                        pl_link_partner_gen2_supported;
  wire                                        pl_link_upcfg_capable;
  wire [5:0]                                  pl_ltssm_state;
  wire                                        pl_received_hot_rst;
  wire                                        pl_sel_link_rate;
  wire [1:0]                                  pl_sel_link_width;
  wire                                        pl_directed_link_auton;
  wire [1:0]                                  pl_directed_link_change;
  wire                                        pl_directed_link_speed;
  wire [1:0]                                  pl_directed_link_width;
  wire                                        pl_upstream_prefer_deemph;

  //-------------------------------------------------------

IBUF   sys_reset_n_ibuf (.O(sys_reset_n_c), .I(sys_rst_n));

`ifdef SIMULATION
  IBUFDS_GTE2 refclk_ibuf (.O(sys_clk), .ODIV2(), .I(sys_clk_p), .CEB(1'b0), .IB(sys_clk_n));
`else
  IBUFDS_GTE2 refclk_ibuf (.O(sys_clk), .ODIV2(), .I(sys_clk_p), .IB(sys_clk_n));
`endif

`ifdef ENABLE_LEDS
   OBUF   led_0_obuf (.O(led_0), .I(sys_reset_n_c));
   OBUF   led_1_obuf (.O(led_1), .I(user_reset));
   OBUF   led_2_obuf (.O(led_2), .I(!user_lnk_up));
`endif

reg user_reset_q;
reg user_lnk_up_q;
always @(posedge user_clk) begin
  user_reset_q <= user_reset;
  user_lnk_up_q <= user_lnk_up;
end

pcie_7x_v1_1 #(
  .PL_FAST_TRAIN			( PL_FAST_TRAIN )
) pcie_7x_v1_1_i (

  //-------------------------------------------------------
  // 1. PCI Express (pci_exp) Interface
  //-------------------------------------------------------

  // Tx
  .pci_exp_txn( pci_exp_txn ),
  .pci_exp_txp( pci_exp_txp ),

  // Rx
  .pci_exp_rxn( pci_exp_rxn ),
  .pci_exp_rxp( pci_exp_rxp ),

  //-------------------------------------------------------
  // 2. AXI-S Interface
  //-------------------------------------------------------

  // Common
  .user_clk_out( user_clk ),
  .user_reset_out( user_reset ),
  .user_lnk_up( user_lnk_up ),

  // TX 

  .tx_buf_av( tx_buf_av ),
  .tx_err_drop( tx_err_drop ),
  .tx_cfg_req( tx_cfg_req ),
  .s_axis_tx_tready( s_axis_tx_tready ),
  .s_axis_tx_tdata( s_axis_tx_tdata ),
  .s_axis_tx_tstrb( s_axis_tx_tstrb ),
  .s_axis_tx_tuser( s_axis_tx_tuser ),
  .s_axis_tx_tlast( s_axis_tx_tlast ),
  .s_axis_tx_tvalid( s_axis_tx_tvalid ),

  .tx_cfg_gnt( tx_cfg_gnt ),

  // Rx
  .m_axis_rx_tdata( m_axis_rx_tdata ),
  .m_axis_rx_tstrb( m_axis_rx_tstrb ),
  .m_axis_rx_tlast( m_axis_rx_tlast ),
  .m_axis_rx_tvalid( m_axis_rx_tvalid ),
  .m_axis_rx_tready( m_axis_rx_tready ),
  .m_axis_rx_tuser ( m_axis_rx_tuser ),
  .rx_np_ok( rx_np_ok ),
  .rx_np_req( rx_np_req ),

  // Flow Control
  .fc_cpld( fc_cpld ),
  .fc_cplh( fc_cplh ),
  .fc_npd( fc_npd ),
  .fc_nph( fc_nph ),
  .fc_pd( fc_pd ),
  .fc_ph( fc_ph ),
  .fc_sel( fc_sel ),


  //-------------------------------------------------------
  // 3. Configuration (CFG) Interface
  //-------------------------------------------------------

  .cfg_mgmt_do(),
  .cfg_mgmt_rd_wr_done( cfg_mgmt_rd_wr_done ),
  .cfg_err_cpl_rdy( cfg_err_cpl_rdy ),
  .cfg_interrupt_rdy( cfg_interrupt_rdy ),
  .cfg_interrupt_mmenable( cfg_interrupt_mmenable ),
  .cfg_interrupt_msienable( cfg_interrupt_msienable ),
  .cfg_interrupt_do( cfg_interrupt_do ),
  .cfg_interrupt_msixenable( cfg_interrupt_msixenable ),
  .cfg_interrupt_msixfm( cfg_interrupt_msixfm ),
  .cfg_to_turnoff( cfg_to_turnoff ),
  .cfg_bus_number( cfg_bus_number ),
  .cfg_device_number( cfg_device_number ),
  .cfg_function_number( cfg_function_number ),
  .cfg_status( cfg_status ),
  .cfg_command( cfg_command ),
  .cfg_dstatus( cfg_dstatus ),
  .cfg_dcommand( cfg_dcommand ),
  .cfg_lstatus( cfg_lstatus ),
  .cfg_lcommand( cfg_lcommand ),
  .cfg_dcommand2( cfg_dcommand2 ),
  .cfg_pcie_link_state( cfg_pcie_link_state ),
  .cfg_pmcsr_pme_en( cfg_pmcsr_pme_en ),
  .cfg_pmcsr_powerstate(),
  .cfg_pmcsr_pme_status( cfg_pmcsr_pme_status ),
  .cfg_received_func_lvl_rst( cfg_received_func_lvl_rst ),

  .cfg_mgmt_di( 32'h0 ),
  .cfg_mgmt_byte_en( 4'h0 ),
  .cfg_mgmt_dwaddr(10'h0),
  .cfg_mgmt_wr_en(1'b0),
  .cfg_mgmt_rd_en(1'b0),
  .cfg_err_cor( cfg_err_cor ),
  .cfg_err_ur( cfg_err_ur ),
  .cfg_err_ecrc( cfg_err_ecrc ),
  .cfg_err_cpl_timeout( cfg_err_cpl_timeout ),
  .cfg_err_cpl_abort(1'b0),
  .cfg_err_cpl_unexpect( cfg_err_cpl_unexpect ),
  .cfg_err_posted( cfg_err_posted ),
  .cfg_err_locked( cfg_err_locked ),
  .cfg_err_tlp_cpl_header( cfg_err_tlp_cpl_header ),
  .cfg_interrupt( cfg_interrupt ),
  .cfg_interrupt_di( cfg_interrupt_di ),
  .cfg_interrupt_assert( cfg_interrupt_assert ),
  .cfg_turnoff_ok( cfg_turnoff_ok ),
  .cfg_trn_pending( cfg_trn_pending ),
  .cfg_pm_wake( cfg_pm_wake ),
  .cfg_pm_halt_aspm_l0s(1'b0),
  .cfg_pm_halt_aspm_l1(1'b0),
  .cfg_pm_force_state_en(1'b0),
  .cfg_pm_force_state(2'b00),
  .cfg_dsn( cfg_dsn ),
  .cfg_pciecap_interrupt_msgnum(5'b00000),
  .cfg_err_poisoned(1'b0),
  .cfg_mgmt_wr_rw1c_as_rw(1'b0),
  .cfg_mgmt_wr_readonly(1'b0),
  .cfg_err_malformed(1'b0),
  .cfg_err_acs(1'b0),
  .cfg_err_atomic_egress_blocked(1'b0),
  .cfg_err_mc_blocked(1'b0),
  .cfg_err_internal_uncor(1'b0),
  .cfg_err_internal_cor(1'b0),
  .cfg_err_norecovery(1'b0),
  .cfg_interrupt_stat(1'b0),

  //-------------------------------------------------------
  // 4. Physical Layer Control and Status (PL) Interface
  //-------------------------------------------------------

  .pl_directed_link_change( pl_directed_link_change ),
  .pl_directed_link_width( pl_directed_link_width ),
  .pl_directed_link_speed( pl_directed_link_speed ),
  .pl_directed_link_auton( pl_directed_link_auton ),
  .pl_upstream_prefer_deemph( pl_upstream_prefer_deemph ),

  .pl_sel_lnk_rate(pl_sel_link_rate),
  .pl_sel_lnk_width(pl_sel_link_width),
  .pl_ltssm_state( pl_ltssm_state ),
  .pl_lane_reversal_mode( pl_lane_reversal_mode ),
  .pl_phy_lnk_up( pl_phy_lnk_up ),
  .pl_tx_pm_state(),
  .pl_rx_pm_state(),
  .pl_link_upcfg_cap( pl_link_upcfg_cap ),
  .pl_link_gen2_cap( pl_link_gen2_cap ),
  .pl_link_partner_gen2_supported( pl_link_partner_gen2_supported ),
  .pl_initial_link_width( pl_initial_link_width ),
  .pl_directed_change_done( pl_directed_change_done ),
  .pl_received_hot_rst( pl_received_hot_rst ),


  //-------------------------------------------------------
  // 5. AER Interface
  //-------------------------------------------------------

  .cfg_err_aer_headerlog(128'h0),
  .cfg_aer_interrupt_msgnum(5'b00000),
  .cfg_err_aer_headerlog_set( cfg_err_aer_headerlog_set ),
  .cfg_aer_ecrc_check_en( cfg_aer_ecrc_check_en ),
  .cfg_aer_ecrc_gen_en( cfg_aer_ecrc_gen_en ),

  //-------------------------------------------------------
  // 6. VC interface
  //-------------------------------------------------------

  .cfg_vc_tcvc_map(),   
  //-------------------------------------------------------
  // 7. System  (SYS) Interface
  //-------------------------------------------------------

  .sys_clk( sys_clk ),
  .sys_rst_n( sys_reset_n_c )

);



pcie_app_7x  #(
  .C_DATA_WIDTH( C_DATA_WIDTH )

)app (

  //-------------------------------------------------------
  // 1. AXI-S Interface
  //-------------------------------------------------------

  // Common
  .user_clk( user_clk ),
  .user_reset( user_reset_q ),
  .user_lnk_up( user_lnk_up_q ),

  // Tx
  .tx_buf_av( tx_buf_av ),
  .tx_cfg_req( tx_cfg_req ),
  .tx_err_drop( tx_err_drop ),
  .s_axis_tx_tready( s_axis_tx_tready ),
  .s_axis_tx_tdata( s_axis_tx_tdata ),
  .s_axis_tx_tstrb( s_axis_tx_tstrb ),
  .s_axis_tx_tuser( s_axis_tx_tuser ),
  .s_axis_tx_tlast( s_axis_tx_tlast ),
  .s_axis_tx_tvalid( s_axis_tx_tvalid ),
  .tx_cfg_gnt( tx_cfg_gnt ),

  // Rx
  .m_axis_rx_tdata( m_axis_rx_tdata ),
  .m_axis_rx_tstrb( m_axis_rx_tstrb ),
  .m_axis_rx_tlast( m_axis_rx_tlast ),
  .m_axis_rx_tvalid( m_axis_rx_tvalid ),
  .m_axis_rx_tready( m_axis_rx_tready ),
  .m_axis_rx_tuser ( m_axis_rx_tuser ),
  .rx_np_ok( rx_np_ok ),
  .rx_np_req( rx_np_req ),

  // Flow Control
  .fc_cpld( fc_cpld ),
  .fc_cplh( fc_cplh ),
  .fc_npd( fc_npd ),
  .fc_nph( fc_nph ),
  .fc_pd( fc_pd ),
  .fc_ph( fc_ph ),
  .fc_sel( fc_sel ),


  //-------------------------------------------------------
  // 2. Configuration (CFG) Interface
  //-------------------------------------------------------

  .cfg_do( cfg_do ),
  .cfg_rd_wr_done( cfg_rd_wr_done),
  .cfg_di( cfg_di ),
  .cfg_byte_en( cfg_byte_en ),
  .cfg_dwaddr( cfg_dwaddr ),
  .cfg_wr_en( cfg_wr_en ),
  .cfg_rd_en( cfg_rd_en ),

  .cfg_err_cor( cfg_err_cor ),
  .cfg_err_ur( cfg_err_ur ),
  .cfg_err_ecrc( cfg_err_ecrc ),
  .cfg_err_cpl_timeout( cfg_err_cpl_timeout ),
  .cfg_err_cpl_abort( cfg_err_cpl_abort ),
  .cfg_err_cpl_unexpect( cfg_err_cpl_unexpect ),
  .cfg_err_posted( cfg_err_posted ),
  .cfg_err_locked( cfg_err_locked ),
  .cfg_err_tlp_cpl_header( cfg_err_tlp_cpl_header ),
  .cfg_err_cpl_rdy( cfg_err_cpl_rdy ),
  .cfg_interrupt( cfg_interrupt ),
  .cfg_interrupt_rdy( cfg_interrupt_rdy ),
  .cfg_interrupt_assert( cfg_interrupt_assert ),
  .cfg_interrupt_di( cfg_interrupt_di ),
  .cfg_interrupt_do( cfg_interrupt_do ),
  .cfg_interrupt_mmenable( cfg_interrupt_mmenable ),
  .cfg_interrupt_msienable( cfg_interrupt_msienable ),
  .cfg_interrupt_msixenable( cfg_interrupt_msixenable ),
  .cfg_interrupt_msixfm( cfg_interrupt_msixfm ),
  .cfg_turnoff_ok( cfg_turnoff_ok ),
  .cfg_to_turnoff( cfg_to_turnoff ),
  .cfg_trn_pending( cfg_trn_pending ),
  .cfg_pm_wake( cfg_pm_wake ),
  .cfg_bus_number( cfg_bus_number ),
  .cfg_device_number( cfg_device_number ),
  .cfg_function_number( cfg_function_number ),
  .cfg_status( cfg_status ),
  .cfg_command( cfg_command ),
  .cfg_dstatus( cfg_dstatus ),
  .cfg_dcommand( cfg_dcommand ),
  .cfg_lstatus( cfg_lstatus ),
  .cfg_lcommand( cfg_lcommand ),
  .cfg_dcommand2( cfg_dcommand2 ),
  .cfg_pcie_link_state( cfg_pcie_link_state ),
  .cfg_dsn( cfg_dsn ),

  //-------------------------------------------------------
  // 3. Physical Layer Control and Status (PL) Interface
  //-------------------------------------------------------

  .pl_initial_link_width( pl_initial_link_width ),
  .pl_lane_reversal_mode( pl_lane_reversal_mode ),
  .pl_link_gen2_capable( pl_link_gen2_capable ),
  .pl_link_partner_gen2_supported( pl_link_partner_gen2_supported ),
  .pl_link_upcfg_capable( pl_link_upcfg_capable ),
  .pl_ltssm_state( pl_ltssm_state ),
  .pl_received_hot_rst( pl_received_hot_rst ),
  .pl_sel_link_rate( pl_sel_link_rate ),
  .pl_sel_link_width( pl_sel_link_width ),
  .pl_directed_link_auton( pl_directed_link_auton ),
  .pl_directed_link_change( pl_directed_link_change ),
  .pl_directed_link_speed( pl_directed_link_speed ),
  .pl_directed_link_width( pl_directed_link_width ),
  .pl_upstream_prefer_deemph( pl_upstream_prefer_deemph )

);

endmodule

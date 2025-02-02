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
// Project    : Virtex-6 Integrated Block for PCI Express
// File       : v6_pcie_v2_3.veo
// Version    : 2.3
//--
//------------------------------------------------------------------------------
// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

v6_pcie_v2_3YourInstanceName (

  //-------------------------------------------------------
  // 1. PCI Express (pci_exp) Interface
  //-------------------------------------------------------

  // Tx
  .pci_exp_txp                         ( pci_exp_txp ),
  .pci_exp_txn                         ( pci_exp_txn ),

  // Rx
  .pci_exp_rxp                         ( pci_exp_rxp ),
  .pci_exp_rxn                         ( pci_exp_rxn ),

  //-------------------------------------------------------
  // 2. Transaction (TRN) Interface
  //-------------------------------------------------------

  // Common
  .user_clk_out                        ( user_clk ),
  .user_reset_out                      ( user_reset_int1 ),
  .user_lnk_up                         ( user_lnk_up_int1 ),

  // Tx
  .s_axis_tx_tready                    ( s_axis_tx_tready ),
  .s_axis_tx_tdata                     ( s_axis_tx_tdata ),
  .s_axis_tx_tstrb                     ( s_axis_tx_tstrb ),
  .s_axis_tx_tuser                     ( s_axis_tx_tuser ),
  .s_axis_tx_tlast                     ( s_axis_tx_tlast ),
  .s_axis_tx_tvalid                    ( s_axis_tx_tvalid ),
  .tx_cfg_gnt                          ( tx_cfg_gnt ),
  .tx_cfg_req                          ( tx_cfg_req ),
  .tx_buf_av                           ( tx_buf_av ),
  .tx_err_drop                         ( tx_err_drop ),

  // Rx
  .m_axis_rx_tdata                     ( m_axis_rx_tdata ),
  .m_axis_rx_tstrb                     ( m_axis_rx_tstrb ),
  .m_axis_rx_tlast                     ( m_axis_rx_tlast ),
  .m_axis_rx_tvalid                    ( m_axis_rx_tvalid ),
  .m_axis_rx_tready                    ( m_axis_rx_tready ),
  .m_axis_rx_tuser                     ( m_axis_rx_tuser ),
  .rx_np_ok                            ( rx_np_ok ),

  // Flow Control
  .fc_cpld                             ( fc_cpld ),
  .fc_cplh                             ( fc_cplh ),
  .fc_npd                              ( fc_npd ),
  .fc_nph                              ( fc_nph ),
  .fc_pd                               ( fc_pd ),
  .fc_ph                               ( fc_ph ),
  .fc_sel                              ( fc_sel ),


  //-------------------------------------------------------
  // 3. Configuration (CFG) Interface
  //-------------------------------------------------------

  .cfg_do                              ( cfg_do ),
  .cfg_rd_wr_done                      ( cfg_rd_wr_done),
  .cfg_di                              ( cfg_di ),
  .cfg_byte_en                         ( cfg_byte_en ),
  .cfg_dwaddr                          ( cfg_dwaddr ),
  .cfg_wr_en                           ( cfg_wr_en ),
  .cfg_rd_en                           ( cfg_rd_en ),

  .cfg_err_cor                         ( cfg_err_cor ),
  .cfg_err_ur                          ( cfg_err_ur ),
  .cfg_err_ecrc                        ( cfg_err_ecrc ),
  .cfg_err_cpl_timeout                 ( cfg_err_cpl_timeout ),
  .cfg_err_cpl_abort                   ( cfg_err_cpl_abort ),
  .cfg_err_cpl_unexpect                ( cfg_err_cpl_unexpect ),
  .cfg_err_posted                      ( cfg_err_posted ),
  .cfg_err_locked                      ( cfg_err_locked ),
  .cfg_err_tlp_cpl_header              ( cfg_err_tlp_cpl_header ),
  .cfg_err_cpl_rdy                     ( cfg_err_cpl_rdy ),
  .cfg_interrupt                       ( cfg_interrupt ),
  .cfg_interrupt_rdy                   ( cfg_interrupt_rdy ),
  .cfg_interrupt_assert                ( cfg_interrupt_assert ),
  .cfg_interrupt_di                    ( cfg_interrupt_di ),
  .cfg_interrupt_do                    ( cfg_interrupt_do ),
  .cfg_interrupt_mmenable              ( cfg_interrupt_mmenable ),
  .cfg_interrupt_msienable             ( cfg_interrupt_msienable ),
  .cfg_interrupt_msixenable            ( cfg_interrupt_msixenable ),
  .cfg_interrupt_msixfm                ( cfg_interrupt_msixfm ),
  .cfg_turnoff_ok                      ( cfg_turnoff_ok ),
  .cfg_to_turnoff                      ( cfg_to_turnoff ),
  .cfg_trn_pending                     ( cfg_trn_pending ),
  .cfg_pm_wake                         ( cfg_pm_wake ),
  .cfg_bus_number                      ( cfg_bus_number ),
  .cfg_device_number                   ( cfg_device_number ),
  .cfg_function_number                 ( cfg_function_number ),
  .cfg_status                          ( cfg_status ),
  .cfg_command                         ( cfg_command ),
  .cfg_dstatus                         ( cfg_dstatus ),
  .cfg_dcommand                        ( cfg_dcommand ),
  .cfg_lstatus                         ( cfg_lstatus ),
  .cfg_lcommand                        ( cfg_lcommand ),
  .cfg_dcommand2                       ( cfg_dcommand2 ),
  .cfg_pcie_link_state                 ( cfg_pcie_link_state ),
  .cfg_dsn                             ( cfg_dsn ),
  .cfg_pmcsr_pme_en                    ( cfg_pmcsr_pme_en ),
  .cfg_pmcsr_pme_status                ( cfg_pmcsr_pme_status ),
  .cfg_pmcsr_powerstate                ( cfg_pmcsr_powerstate ),

  //-------------------------------------------------------
  // 4. Physical Layer Control and Status (PL) Interface
  //-------------------------------------------------------

  .pl_initial_link_width               ( pl_initial_link_width ),
  .pl_lane_reversal_mode               ( pl_lane_reversal_mode ),
  .pl_link_gen2_capable                ( pl_link_gen2_capable ),
  .pl_link_partner_gen2_supported      ( pl_link_partner_gen2_supported ),
  .pl_link_upcfg_capable               ( pl_link_upcfg_capable ),
  .pl_ltssm_state                      ( pl_ltssm_state ),
  .pl_received_hot_rst                 ( pl_received_hot_rst ),
  .pl_sel_link_rate                    ( pl_sel_link_rate ),
  .pl_sel_link_width                   ( pl_sel_link_width ),
  .pl_directed_link_auton              ( pl_directed_link_auton ),
  .pl_directed_link_change             ( pl_directed_link_change ),
  .pl_directed_link_speed              ( pl_directed_link_speed ),
  .pl_directed_link_width              ( pl_directed_link_width ),
  .pl_upstream_prefer_deemph           ( pl_upstream_prefer_deemph ),

  //-------------------------------------------------------
  // 5. System  (SYS) Interface
  //-------------------------------------------------------

  .sys_clk                             ( sys_clk_c ),
  .sys_reset                           ( !sys_reset_n_c )

);


// INST_TAG_END ------ End INSTANTIATION Template ---------

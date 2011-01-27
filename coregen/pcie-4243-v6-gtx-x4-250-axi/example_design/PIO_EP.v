//-----------------------------------------------------------------------------
//
// (c) Copyright 2009-2010 Xilinx, Inc. All rights reserved.
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
// File       : PIO_EP.v
// Version    : 2.1
//--
//-- Description: Endpoint Programmed I/O module.
//--
//--------------------------------------------------------------------------------

`timescale 1ns/1ns

module PIO_EP #(
  parameter C_DATA_WIDTH = 64,            // RX/TX interface data width

  // Do not override parameters below this line
  parameter STRB_WIDTH = C_DATA_WIDTH / 8               // TSTRB width
) (

  input                         clk,
  input                         rst_n,

  // AXIS TX
  input                         s_axis_tx_tready,
  output  [C_DATA_WIDTH-1:0]    s_axis_tx_tdata,
  output  [STRB_WIDTH-1:0]      s_axis_tx_tstrb,
  output                        s_axis_tx_tlast,
  output                        s_axis_tx_tvalid,
  output                        tx_src_dsc,

  //AXIS RX
  input   [C_DATA_WIDTH-1:0]    m_axis_rx_tdata,
  input   [STRB_WIDTH-1:0]      m_axis_rx_tstrb,
  input                         m_axis_rx_tlast,
  input                         m_axis_rx_tvalid,
  output                        m_axis_rx_tready,
  input   [21:0]                m_axis_rx_tuser,

  output                        req_compl_o,
  output                        compl_done_o,

  input   [15:0]                cfg_completer_id,
  input                         cfg_bus_mstr_enable
);

    // Local wires

    wire  [10:0]      rd_addr;
    wire  [3:0]       rd_be;
    wire  [31:0]      rd_data;

    wire  [10:0]      wr_addr;
    wire  [7:0]       wr_be;
    wire  [31:0]      wr_data;
    wire              wr_en;
    wire              wr_busy;

    wire              req_compl;
    wire              req_compl_wd;
    wire              compl_done;

    wire  [2:0]       req_tc;
    wire              req_td;
    wire              req_ep;
    wire  [1:0]       req_attr;
    wire  [9:0]       req_len;
    wire  [15:0]      req_rid;
    wire  [7:0]       req_tag;
    wire  [7:0]       req_be;
    wire  [12:0]      req_addr;


    //
    // ENDPOINT MEMORY : 8KB memory aperture implemented in FPGA BlockRAM(*)
    //

    PIO_EP_MEM_ACCESS EP_MEM (

                   .clk(clk),               // I
                   .rst_n(rst_n),           // I

                   // Read Port

                   .rd_addr_i(rd_addr),     // I [10:0]
                   .rd_be_i(rd_be),         // I [3:0]
                   .rd_data_o(rd_data),     // O [31:0]

                   // Write Port

                   .wr_addr_i(wr_addr),     // I [10:0]
                   .wr_be_i(wr_be),         // I [7:0]
                   .wr_data_i(wr_data),     // I [31:0]
                   .wr_en_i(wr_en),         // I
                   .wr_busy_o(wr_busy)      // O

                   );

    //
    // Local-Link Receive Controller
    //

  PIO_64_RX_ENGINE #(
    .C_DATA_WIDTH( C_DATA_WIDTH ),
    .STRB_WIDTH( STRB_WIDTH )

  ) EP_RX (

    .clk(clk),                              // I
    .rst_n(rst_n),                          // I

    // AXIS RX
    .m_axis_rx_tdata( m_axis_rx_tdata ),    // I
    .m_axis_rx_tstrb( m_axis_rx_tstrb ),    // I
    .m_axis_rx_tlast( m_axis_rx_tlast ),    // I
    .m_axis_rx_tvalid( m_axis_rx_tvalid ),  // I
    .m_axis_rx_tready( m_axis_rx_tready ),  // O
    .m_axis_rx_tuser ( m_axis_rx_tuser ),   // I

    // Handshake with Tx engine
    .req_compl_o(req_compl),                // O
    .req_compl_wd_o(req_compl_wd),          // O
    .compl_done_i(compl_done),              // I

    .req_tc_o(req_tc),                      // O [2:0]
    .req_td_o(req_td),                      // O
    .req_ep_o(req_ep),                      // O
    .req_attr_o(req_attr),                  // O [1:0]
    .req_len_o(req_len),                    // O [9:0]
    .req_rid_o(req_rid),                    // O [15:0]
    .req_tag_o(req_tag),                    // O [7:0]
    .req_be_o(req_be),                      // O [7:0]
    .req_addr_o(req_addr),                  // O [12:0]

    // Memory Write Port
    .wr_addr_o(wr_addr),                    // O [10:0]
    .wr_be_o(wr_be),                        // O [7:0]
    .wr_data_o(wr_data),                    // O [31:0]
    .wr_en_o(wr_en),                        // O
    .wr_busy_i(wr_busy)                     // I

  );

    //
    // Local-Link Transmit Controller
    //

  PIO_64_TX_ENGINE #(
    .C_DATA_WIDTH( C_DATA_WIDTH ),
    .STRB_WIDTH( STRB_WIDTH )

  )EP_TX(

    .clk(clk),                                  // I
    .rst_n(rst_n),                              // I

    // AXIS Tx
    .s_axis_tx_tready( s_axis_tx_tready ),      // I
    .s_axis_tx_tdata( s_axis_tx_tdata ),        // O
    .s_axis_tx_tstrb( s_axis_tx_tstrb ),        // O
    .s_axis_tx_tlast( s_axis_tx_tlast ),        // O
    .s_axis_tx_tvalid( s_axis_tx_tvalid ),      // O
    .tx_src_dsc( tx_src_dsc ),                  // O

    // Handshake with Rx engine
    .req_compl_i(req_compl),                    // I
    .req_compl_wd_i(req_compl_wd),              // I
    .compl_done_o(compl_done),                  // 0

    .req_tc_i(req_tc),                          // I [2:0]
    .req_td_i(req_td),                          // I
    .req_ep_i(req_ep),                          // I
    .req_attr_i(req_attr),                      // I [1:0]
    .req_len_i(req_len),                        // I [9:0]
    .req_rid_i(req_rid),                        // I [15:0]
    .req_tag_i(req_tag),                        // I [7:0]
    .req_be_i(req_be),                          // I [7:0]
    .req_addr_i(req_addr),                      // I [12:0]

    // Read Port

    .rd_addr_o(rd_addr),                        // O [10:0]
    .rd_be_o(rd_be),                            // O [3:0]
    .rd_data_i(rd_data),                        // I [31:0]

    .completer_id_i(cfg_completer_id),          // I [15:0]
    .cfg_bus_mstr_enable_i(cfg_bus_mstr_enable) // I

    );

  assign req_compl_o  = req_compl;
  assign compl_done_o = compl_done;

endmodule // PIO_EP



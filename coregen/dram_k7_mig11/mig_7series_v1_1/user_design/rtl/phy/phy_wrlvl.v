//*****************************************************************************
// (c) Copyright 2009 - 2010 Xilinx, Inc. All rights reserved.
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
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: %version 
//  \   \         Application: MIG
//  /   /         Filename: phy_wrlvl.v
// /___/   /\     Date Last Modified: $Date: 2010/12/21 21:57:51 $
// \   \  /  \    Date Created: Mon Jun 23 2008
//  \___\/\___\
//
//Device: 7 Series
//Design Name: DDR3 SDRAM
//Purpose:
//  Memory initialization and overall master state control during
//  initialization and calibration. Specifically, the following functions
//  are performed:
//    1. Memory initialization (initial AR, mode register programming, etc.)
//    2. Initiating write leveling
//    3. Generate training pattern writes for read leveling. Generate
//       memory readback for read leveling.
//  This module has a DFI interface for providing control/address and write
//  data to the rest of the PHY datapath during initialization/calibration.
//  Once initialization is complete, control is passed to the MC. 
//  NOTES:
//    1. Multiple CS (multi-rank) not supported
//    2. DDR2 not supported
//    3. ODT not supported
//Reference:
//Revision History:
//*****************************************************************************

/******************************************************************************
**$Id: phy_wrlvl.v,v 1.11 2010/12/21 21:57:51 mgeorge Exp $
**$Date: 2010/12/21 21:57:51 $
**$Author: mgeorge $
**$Revision: 1.11 $
**$Source: /devl/xcs/repo/env/Databases/ip/src2/O/mig_7series_v1_1/data/dlib/7series/ddr3_sdram/verilog/rtl/phy/phy_wrlvl.v,v $
******************************************************************************/

`timescale 1ps/1ps

module phy_wrlvl #
  (
   parameter TCQ = 100,
   parameter DQS_CNT_WIDTH     = 3,
   parameter DQ_WIDTH          = 64,
   parameter DQS_WIDTH         = 2,
   parameter DRAM_WIDTH        = 8,
   parameter RANKS             = 1,
   parameter SIM_CAL_OPTION    = "NONE"
   )
  (
   input                        clk,
   input                        rst,
   input                        wr_level_start,
   input                        wl_sm_start,
   input [(DQ_WIDTH)-1:0]       rd_data_rise0,
   output reg                   wr_level_done,
   // to phy_init for cs logic
   output                       wrlvl_rank_done,
   output                       done_dqs_tap_inc,
   output [DQS_CNT_WIDTH:0]     po_stg2_wl_cnt,
   // Fine delay line used only during write leveling
   // Inc/dec Phaser_Out fine delay line
   output reg                   dqs_po_stg2_f_incdec,
   // Enable Phaser_Out fine delay inc/dec
   output reg                   dqs_po_en_stg2_f,
   // Coarse delay line used during write leveling
   // only if 64 taps of fine delay line were not
   // sufficient to detect a 0->1 transition
   // Inc Phaser_Out coarse delay line
   output reg                   dqs_wl_po_stg2_c_incdec,
   // Enable Phaser_Out coarse delay inc/dec
   output reg                   dqs_wl_po_en_stg2_c,
   // Load Phaser_Out delay line
   output reg                   dqs_wl_po_stg2_load,
   output reg [8:0]             dqs_wl_po_stg2_reg_l,
   // CK edge undetected
   output reg                   wrlvl_err,
   output reg [3*DQS_WIDTH-1:0] wl_po_coarse_cnt,
   output reg [6*DQS_WIDTH-1:0] wl_po_fine_cnt,
   // Debug ports
   output [5:0]                 dbg_wl_tap_cnt,
   output                       dbg_wl_edge_detect_valid,
   output [(DQS_WIDTH)-1:0]     dbg_rd_data_edge_detect,
   output [DQS_CNT_WIDTH:0]     dbg_dqs_count,
   output [3:0]                 dbg_wl_state
   );


   localparam WL_IDLE            = 4'h0;
   localparam WL_INIT            = 4'h1;
   localparam WL_FINE_INC        = 4'h2;
   localparam WL_WAIT            = 4'h3;
   localparam WL_EDGE_CHECK      = 4'h4;
   localparam WL_DQS_CHECK       = 4'h5;
   localparam WL_DQS_CNT         = 4'h6;
   localparam WL_FINE_DEC        = 4'h7;
   localparam WL_FINE_DEC_WAIT   = 4'h8;
   localparam WL_CORSE_INC       = 4'h9;
   localparam WL_CORSE_INC_WAIT  = 4'hA;
   localparam WL_CORSE_INC_WAIT2 = 4'hB;


   integer     i, j, k, l, p, q;

   reg [DQS_CNT_WIDTH:0] dqs_count_r;
   reg [DQS_CNT_WIDTH:0] regl_dqs_cnt;
   reg [1:0]             rank_cnt_r;
   reg [DQS_WIDTH-1:0]   rd_data_rise_wl_r;
   reg [DQS_WIDTH-1:0]   rd_data_previous_r;
   reg [DQS_WIDTH-1:0]   rd_data_edge_detect_r;
   reg                   wr_level_done_r;
   reg                   wrlvl_rank_done_r;
   reg                   wr_level_start_r;
   reg [3:0]             wl_state_r, wl_state_r1;
   reg                   wl_edge_detect_valid_r;
   reg [5:0]             wl_tap_count_r;
   reg [5:0]             fine_dec_cnt;
   reg                   dq_cnt_inc;
   reg [2:0]             stable_cnt;
   reg [3*DQS_WIDTH-1:0] corse_cnt;
   reg [3*DQS_WIDTH-1:0] wl_corse_cnt;
   reg                   wr_level_done_r1;
   reg                   wr_level_done_r2;
   reg                   wr_level_done_r3;
   reg                   wr_level_done_r4;
   reg [6*DQS_WIDTH-1:0] wl_dqs_tap_count_r[0:RANKS-1];
   reg [5:0]             smallest[0:DQS_WIDTH-1];
   reg [5:0]             largest[0:DQS_WIDTH-1];
   reg [5:0]             final_val[0:DQS_WIDTH-1];
   reg [5:0]             po_dec_cnt[0:DQS_WIDTH-1];
   reg [3:0]             done_cnt;
   reg                   done_dqs_dec;
   




  // Debug ports
   assign dbg_wl_edge_detect_valid = wl_edge_detect_valid_r;
   assign dbg_rd_data_edge_detect  = rd_data_edge_detect_r;
   assign dbg_wl_tap_cnt = wl_tap_count_r;
   assign dbg_dqs_count = dqs_count_r;
   assign dbg_wl_state = wl_state_r;
   
   //**************************************************************************
   // DQS count to hard PHY during write leveling using Phaser_OUT Stage2 delay 
   //**************************************************************************
   assign po_stg2_wl_cnt = (wr_level_done_r) ? regl_dqs_cnt : dqs_count_r;

   assign wrlvl_rank_done = wrlvl_rank_done_r;
   
   assign done_dqs_tap_inc = done_dqs_dec;
   
   always @(posedge clk)
     wr_level_done = done_dqs_dec;


   
   always @(posedge clk) begin
     wr_level_done_r1 <= #TCQ wr_level_done_r;
     wr_level_done_r2 <= #TCQ wr_level_done_r1;
     wr_level_done_r3 <= #TCQ wr_level_done_r2;
     wr_level_done_r4 <= #TCQ wr_level_done_r3;
     wl_po_coarse_cnt <= #TCQ wl_corse_cnt;
     for (l = 0; l < DQS_WIDTH; l = l + 1) begin 
       wl_po_fine_cnt[6*l+:6] <= #TCQ final_val[l];
     end
   end
   
   // This counter used to implement settling time for
   // Phaser_Out fine delay line after final_val
   // loaded for different DQSs
   always @(posedge clk) begin
     if (rst || ((regl_dqs_cnt == DQS_WIDTH-1)
              && (done_cnt == 4'd1)))
       done_cnt <= #TCQ 'b0;
     else if ((wr_level_done_r3 && ~wr_level_done_r4)
              || (done_cnt == 4'd1))
       done_cnt <= #TCQ 4'b1010;
     else if (done_cnt > 'b0)
       done_cnt <= #TCQ done_cnt - 1;
   end

   
   always @(posedge clk) begin
     if (rst)
       done_dqs_dec <= #TCQ 1'b0;
     else if ((regl_dqs_cnt == DQS_WIDTH-1)
              && (done_cnt == 4'd1))
       done_dqs_dec <= #TCQ 1'b1;
   end
  
   // Storing DQS tap values at the end of each DQS write leveling
   always @(posedge clk) begin
     if (rst) begin
       wl_corse_cnt <= #TCQ 'b0;
       for (k = 0; k < RANKS; k = k + 1) begin: rst_wl_dqs_tap_count_loop
         wl_dqs_tap_count_r[k] <= #TCQ 'b0;
       end
     end else if ((wl_state_r == WL_DQS_CNT) | (wl_state_r == WL_WAIT)) begin
         wl_dqs_tap_count_r[rank_cnt_r][(6*dqs_count_r)+:6]
           <= #TCQ wl_tap_count_r;
         wl_corse_cnt[3*dqs_count_r+:3] <= #TCQ corse_cnt[3*dqs_count_r+:3];
     end else if ((SIM_CAL_OPTION == "FAST_CAL") & (wl_state_r == WL_DQS_CHECK)) begin
       for (p = 0; p < RANKS; p = p +1) begin: dqs_tap_rank_cnt   
         for(q = 0; q < DQS_WIDTH; q = q +1) begin: dqs_tap_dqs_cnt
           wl_dqs_tap_count_r[p][(6*q)+:6] <= #TCQ wl_tap_count_r;
           wl_corse_cnt[3*q+:3] <= #TCQ corse_cnt[2:0];
         end
       end
     end
   end
   
   // Determine delay value for DQS in multirank system
   // Assuming delay value is the smallest for rank 0 DQS 
   // and largest delay value for rank 4 DQS
   // Set to smallest + ((largest-smallest)/2)
   always @(posedge clk) begin
     if (rst) begin
       for (j = 0; j < DQS_WIDTH; j = j +1) begin: init_tap
         smallest[j] <= #TCQ 'b0;
         largest[j]  <= #TCQ 'b0;
       end
     end else if (wl_state_r == WL_DQS_CNT) begin
       smallest[dqs_count_r] 
       <= #TCQ wl_dqs_tap_count_r[0][6*dqs_count_r+:6];
       largest[dqs_count_r] 
        <= #TCQ wl_dqs_tap_count_r[RANKS-1][6*dqs_count_r+:6];
     end else if ((SIM_CAL_OPTION == "FAST_CAL") & 
                  wr_level_done_r1 & ~wr_level_done_r2) begin
       for(i = 0; i < DQS_WIDTH; i = i +1) begin: smallest_dqs
         smallest[i] 
         <= #TCQ wl_dqs_tap_count_r[0][6*i+:6];
         largest[i] 
         <= #TCQ wl_dqs_tap_count_r[RANKS-1][6*i+:6];
       end
     end
   end

   
    // final_val to be loaded for all DQSs in all ranks   
    genvar wr_i;
    generate
      for (wr_i = 0; wr_i < DQS_WIDTH; wr_i = wr_i +1) begin: gen_final_tap
       always @(posedge clk) begin
         if (rst)
           final_val[wr_i] <= #TCQ 'b0;
         else if (wr_level_done_r2 && ~wr_level_done_r3)
           final_val[wr_i] 
             <= #TCQ (smallest[wr_i] + ((largest[wr_i]-smallest[wr_i])/2));
       end
      end
    endgenerate
    
   // Load Phaser_OUT register with final delay value.
   // For multi-rank systems same value used for all
   // ranks from single Phaser_OUT register.
   always @(posedge clk) begin
     if (rst || (done_cnt == 4'd0)) begin
       dqs_wl_po_stg2_load  <= #TCQ 'b0;
       dqs_wl_po_stg2_reg_l <= #TCQ 'b0;
     end else if (wr_level_done_r3 && (regl_dqs_cnt <= DQS_WIDTH-1)
                  && (done_cnt == 4'd2)) begin
       dqs_wl_po_stg2_load  <= #TCQ 'b1;
       dqs_wl_po_stg2_reg_l <= #TCQ {wl_corse_cnt[3*regl_dqs_cnt+:3],final_val[regl_dqs_cnt]};
     end else begin
       dqs_wl_po_stg2_load  <= #TCQ 'b0;
       dqs_wl_po_stg2_reg_l <= #TCQ 'b0;
     end
   end


   always @(posedge clk) begin
     if (rst || (done_cnt == 4'd0))
       regl_dqs_cnt    <= #TCQ {DQS_CNT_WIDTH+1{1'b0}};
     else if (wr_level_done_r3 && (regl_dqs_cnt != DQS_WIDTH-1)
                  && (done_cnt == 4'd1))
       regl_dqs_cnt  <= #TCQ regl_dqs_cnt + 1;
     else
       regl_dqs_cnt  <= #TCQ regl_dqs_cnt;
   end

   
   // Inc/Dec Phaser_Out stage 2 fine delay line
   always @(posedge clk) begin
     if (rst) begin
     // Fine delay line used only during write leveling
       dqs_po_stg2_f_incdec   <= #TCQ 1'b0;
       dqs_po_en_stg2_f       <= #TCQ 1'b0;
     // Inc Phaser_Out fine delay during write leveling
     end else if (wl_state_r == WL_FINE_INC) begin
       dqs_po_stg2_f_incdec <= #TCQ 1'b1;
       dqs_po_en_stg2_f     <= #TCQ 1'b1;
     // Dec Phaser_Out fine delay to '0' if no 0 to 1
     // transition detected with 63 fine delay taps
     end else if (wl_state_r == WL_FINE_DEC) begin
       dqs_po_stg2_f_incdec <= #TCQ 1'b0;
       dqs_po_en_stg2_f     <= #TCQ 1'b1;
     end else if ((wl_state_r == WL_WAIT) || 
                  (wl_state_r == WL_FINE_DEC_WAIT) ||
                  (wl_state_r == WL_CORSE_INC)) begin
       dqs_po_stg2_f_incdec <= #TCQ 1'b0;
       dqs_po_en_stg2_f     <= #TCQ 1'b0; 
     end
   end
   

   // Inc Phaser_Out stage 2 Coarse delay line
   always @(posedge clk) begin
     if (rst) begin
     // Coarse delay line used during write leveling
     // only if no 0->1 transition undetected with 64
     // fine delay line taps
       dqs_wl_po_stg2_c_incdec   <= #TCQ 1'b0;
       dqs_wl_po_en_stg2_c       <= #TCQ 1'b0;
     // Inc Phaser_Out coarse delay during write leveling
     end else if (wl_state_r == WL_CORSE_INC) begin
       dqs_wl_po_stg2_c_incdec <= #TCQ 1'b1;
       dqs_wl_po_en_stg2_c     <= #TCQ 1'b1;
     end else if (wl_state_r == WL_CORSE_INC_WAIT) begin
       dqs_wl_po_stg2_c_incdec <= #TCQ 1'b0;
       dqs_wl_po_en_stg2_c     <= #TCQ 1'b0; 
     end
   end
     

   // only storing the rise data for checking. The data comming back during
   // write leveling will be a static value. Just checking for rise data is
   // enough. 

genvar rd_i;
generate
  for(rd_i = 0; rd_i < DQS_WIDTH; rd_i = rd_i +1)begin: gen_rd
   always @(posedge clk)
     rd_data_rise_wl_r[rd_i] <=
     #TCQ |rd_data_rise0[(rd_i*DRAM_WIDTH)+DRAM_WIDTH-1:rd_i*DRAM_WIDTH];
  end
endgenerate


   // storing the previous data for checking later.
   always @(posedge clk)begin
     if ((wl_state_r == WL_INIT) || (wl_state_r == WL_CORSE_INC_WAIT2) ||
         (wl_state_r == WL_FINE_DEC) || (wl_state_r == WL_FINE_DEC_WAIT) ||
         (wl_state_r == WL_CORSE_INC) || (wl_state_r == WL_CORSE_INC_WAIT) || 
         ((wl_state_r == WL_EDGE_CHECK) & (wl_edge_detect_valid_r)))
       rd_data_previous_r         <= #TCQ rd_data_rise_wl_r;
   end
   
   // changed stable count from 3 to 7 because of fine tap resolution
   always @(posedge clk)begin
      if (rst | (wl_state_r == WL_DQS_CNT))
        stable_cnt <= #TCQ 3'd0;
      else if ((wl_tap_count_r > 6'd0) & 
         (wl_state_r == WL_EDGE_CHECK) & (wl_edge_detect_valid_r)) begin
        if ((rd_data_previous_r[dqs_count_r] == rd_data_rise_wl_r[dqs_count_r])
           & (stable_cnt < 3'd7))
          stable_cnt <= #TCQ stable_cnt + 1;
        else if (rd_data_previous_r[dqs_count_r] != rd_data_rise_wl_r[dqs_count_r])
          stable_cnt <= #TCQ 3'd0;
      end
   end
   


   //checking for transition from 0 to 1
   always @(posedge clk)begin
     if (rst || (rd_data_previous_r[dqs_count_r] && (stable_cnt < 3'd7)))
       rd_data_edge_detect_r     <= #TCQ {DQS_WIDTH{1'b0}};
     else if (rd_data_edge_detect_r[dqs_count_r] == 1'b1) begin
       if ((wl_state_r == WL_FINE_DEC) || (wl_state_r == WL_FINE_DEC_WAIT) ||
           (wl_state_r == WL_CORSE_INC) || (wl_state_r == WL_CORSE_INC_WAIT) ||
           (wl_state_r == WL_CORSE_INC_WAIT2))
         rd_data_edge_detect_r <= #TCQ {DQS_WIDTH{1'b0}};
       else
         rd_data_edge_detect_r <= #TCQ rd_data_edge_detect_r;
     end else
       rd_data_edge_detect_r <= #TCQ (~rd_data_previous_r &
                                       rd_data_rise_wl_r);
   end


  
  // registring the write level start signal
   always@(posedge clk) begin
     wr_level_start_r <= #TCQ wr_level_start;
   end

   

   
   // state machine to initiate the write leveling sequence
   // The state machine operates on one byte at a time.
   // It will increment the delays to the DQS OSERDES
   // and sample the DQ from the memory. When it detects
   // a transition from 1 to 0 then the write leveling is considered
   // done. 
   always @(posedge clk) begin
      if(rst)begin
         wrlvl_err              <= #TCQ 1'b0;
         wr_level_done_r        <= #TCQ 1'b0;
         wrlvl_rank_done_r      <= #TCQ 1'b0;
         dqs_count_r            <= #TCQ {DQS_CNT_WIDTH+1{1'b0}};
         dq_cnt_inc             <= #TCQ 1'b1;
         rank_cnt_r             <= #TCQ 2'b00;
         wl_state_r             <= #TCQ WL_IDLE;
         wl_state_r1            <= #TCQ WL_IDLE;
         wl_edge_detect_valid_r <= #TCQ 1'b0;
         wl_tap_count_r         <= #TCQ 6'b0;
         fine_dec_cnt           <= #TCQ 6'b0;
         corse_cnt              <= #TCQ {3*DQS_WIDTH{1'b0}};
      end else begin
         wl_state_r1            <= #TCQ wl_state_r;
         case (wl_state_r)
           
           WL_IDLE: begin
              wrlvl_rank_done_r <= #TCQ 1'd0;
              if(!wr_level_done_r & wr_level_start_r & wl_sm_start)
                wl_state_r <= #TCQ WL_INIT;
           end

           WL_INIT: begin
              wl_edge_detect_valid_r <= #TCQ 1'b0;
              wrlvl_rank_done_r      <= #TCQ 1'd0;
              if(wl_sm_start)
                 wl_state_r <= #TCQ WL_EDGE_CHECK; //WL_FINE_INC;
           end
           // Inc DQS Phaser_Out Stage2 Fine Delay line
           WL_FINE_INC: begin 
              wl_state_r <= #TCQ WL_WAIT;
              wl_edge_detect_valid_r <= #TCQ 1'b0;
              wl_tap_count_r <= #TCQ wl_tap_count_r + 1'b1;
           end
           
           WL_FINE_DEC: begin
              wl_edge_detect_valid_r <= #TCQ 1'b0;
              wl_tap_count_r <= #TCQ 'd0;
              wl_state_r   <= #TCQ WL_FINE_DEC_WAIT;
              if (fine_dec_cnt > 6'd0)
                fine_dec_cnt <= #TCQ fine_dec_cnt - 1;
              else
                fine_dec_cnt <= #TCQ fine_dec_cnt;
           end
           
           WL_FINE_DEC_WAIT: begin
              if (fine_dec_cnt > 6'd0)
                wl_state_r   <= #TCQ WL_FINE_DEC;
              else
                wl_state_r <= #TCQ WL_CORSE_INC;
           end
           
           WL_CORSE_INC: begin
              corse_cnt[3*dqs_count_r+:3]  <= #TCQ corse_cnt[3*dqs_count_r+:3] + 1;
             // if (corse_cnt[3*dqs_count_r+:3] == 'd2)
             //   wl_state_r <= #TCQ WL_CORSE_INC_WAIT2;
             // else
                wl_state_r <= #TCQ WL_CORSE_INC_WAIT;
           end

           WL_CORSE_INC_WAIT: begin
              if (wl_sm_start)
                wl_state_r <= #TCQ WL_CORSE_INC_WAIT2;
           end

           WL_CORSE_INC_WAIT2: begin
             if (wl_sm_start)
                wl_state_r <= #TCQ WL_WAIT;
           end
           
           WL_WAIT: begin
              if (wl_sm_start)
              wl_state_r <= #TCQ WL_EDGE_CHECK;
           end
           
           WL_EDGE_CHECK: begin // Look for the edge
              if (wl_edge_detect_valid_r == 1'b0) begin
                wl_state_r <= #TCQ WL_WAIT;
                wl_edge_detect_valid_r <= #TCQ 1'b1;
              end
              // 0->1 transition detected with DQS
              else if(rd_data_edge_detect_r[dqs_count_r] &&
                      wl_edge_detect_valid_r)
                begin
                   wl_state_r <= #TCQ WL_DQS_CNT;
                   wl_tap_count_r <= #TCQ wl_tap_count_r;
                 end
              // No transition detected with 63 taps of fine delay
              // increment coarse delay by 1 tap, reset fine delay to '0'
              // and begin detection of 1 -> 0 transition again
              else if (wl_tap_count_r > 6'd62) begin
                if (corse_cnt[3*dqs_count_r+:3] < 'd3) begin
                  wl_state_r   <= #TCQ WL_FINE_DEC;
                  fine_dec_cnt <= #TCQ wl_tap_count_r;
                end else
                  wrlvl_err <= #TCQ 1'b1;
              end else
                wl_state_r <= #TCQ WL_FINE_INC;
           end

           WL_DQS_CNT: begin
              if ((SIM_CAL_OPTION == "FAST_CAL") ||
                  (dqs_count_r == (DQS_WIDTH-1))) begin
                dqs_count_r <= #TCQ dqs_count_r;
                dq_cnt_inc  <= #TCQ 1'b0;
              end else begin
                dqs_count_r <= #TCQ dqs_count_r + 1'b1;
                dq_cnt_inc  <= #TCQ 1'b1;
              end
              wl_state_r <= #TCQ WL_DQS_CHECK;
              wl_edge_detect_valid_r <= #TCQ 1'b0;
             end
           
           WL_DQS_CHECK: begin // check if all DQS have been calibrated
              wl_tap_count_r <= #TCQ 5'b0;
              if (dq_cnt_inc == 1'b0)begin
                wrlvl_rank_done_r <= #TCQ 1'd1;
                wl_state_r <= #TCQ WL_IDLE;
                if ((SIM_CAL_OPTION == "FAST_CAL") ||
                    (rank_cnt_r == RANKS-1)) begin
                  wr_level_done_r <= #TCQ 1'd1;
                  rank_cnt_r <= #TCQ 2'b00;
                end else begin
                  wr_level_done_r <= #TCQ 1'd0;
                  rank_cnt_r <= #TCQ rank_cnt_r + 1'b1;
                  dqs_count_r <= #TCQ 5'd0;
                end
              end else
                wl_state_r <= #TCQ WL_INIT;
           end
        endcase
     end
   end // always @ (posedge clk)
   

                                                          

endmodule
              
                 
                
   
     

   

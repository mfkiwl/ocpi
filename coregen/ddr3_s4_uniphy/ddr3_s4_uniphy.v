// megafunction wizard: %DDR3 SDRAM Controller with UniPHY v11.0%
// GENERATION: XML
// ddr3_s4_uniphy.v

// 

`timescale 1 ps / 1 ps
module ddr3_s4_uniphy (
		input  wire        pll_ref_clk,       //     pll_ref_clk.clk
		input  wire        global_reset_n,    //    global_reset.reset_n
		input  wire        soft_reset_n,      //      soft_reset.reset_n
		output wire        afi_clk,           //         afi_clk.clk
		output wire        afi_half_clk,      //    afi_half_clk.clk
		output wire        afi_reset_n,       //       afi_reset.reset_n
		output wire [12:0] mem_a,             //          memory.mem_a
		output wire [2:0]  mem_ba,            //                .mem_ba
		output wire        mem_ck,            //                .mem_ck
		output wire        mem_ck_n,          //                .mem_ck_n
		output wire        mem_cke,           //                .mem_cke
		output wire        mem_cs_n,          //                .mem_cs_n
		output wire [1:0]  mem_dm,            //                .mem_dm
		output wire        mem_ras_n,         //                .mem_ras_n
		output wire        mem_cas_n,         //                .mem_cas_n
		output wire        mem_we_n,          //                .mem_we_n
		output wire        mem_reset_n,       //                .mem_reset_n
		inout  wire [15:0] mem_dq,            //                .mem_dq
		inout  wire [1:0]  mem_dqs,           //                .mem_dqs
		inout  wire [1:0]  mem_dqs_n,         //                .mem_dqs_n
		output wire        mem_odt,           //                .mem_odt
		output wire        avl_ready,         //             avl.waitrequest_n
		input  wire        avl_burstbegin,    //                .beginbursttransfer
		input  wire [23:0] avl_addr,          //                .address
		output wire        avl_rdata_valid,   //                .readdatavalid
		output wire [63:0] avl_rdata,         //                .readdata
		input  wire [63:0] avl_wdata,         //                .writedata
		input  wire [7:0]  avl_be,            //                .byteenable
		input  wire        avl_read_req,      //                .read
		input  wire        avl_write_req,     //                .write
		input  wire [2:0]  avl_size,          //                .burstcount
		output wire        local_init_done,   //          status.local_init_done
		output wire        local_cal_success, //                .local_cal_success
		output wire        local_cal_fail,    //                .local_cal_fail
		input  wire        oct_rdn,           //             oct.rdn
		input  wire        oct_rup,           //                .rup
		output wire        local_powerdn_ack, // local_powerdown.local_powerdn_ack
		input  wire        local_powerdn_req  //                .local_powerdn_req
	);

	ddr3_s4_uniphy_0002 ddr3_s4_uniphy_inst (
		.pll_ref_clk       (pll_ref_clk),       //     pll_ref_clk.clk
		.global_reset_n    (global_reset_n),    //    global_reset.reset_n
		.soft_reset_n      (soft_reset_n),      //      soft_reset.reset_n
		.afi_clk           (afi_clk),           //         afi_clk.clk
		.afi_half_clk      (afi_half_clk),      //    afi_half_clk.clk
		.afi_reset_n       (afi_reset_n),       //       afi_reset.reset_n
		.mem_a             (mem_a),             //          memory.mem_a
		.mem_ba            (mem_ba),            //                .mem_ba
		.mem_ck            (mem_ck),            //                .mem_ck
		.mem_ck_n          (mem_ck_n),          //                .mem_ck_n
		.mem_cke           (mem_cke),           //                .mem_cke
		.mem_cs_n          (mem_cs_n),          //                .mem_cs_n
		.mem_dm            (mem_dm),            //                .mem_dm
		.mem_ras_n         (mem_ras_n),         //                .mem_ras_n
		.mem_cas_n         (mem_cas_n),         //                .mem_cas_n
		.mem_we_n          (mem_we_n),          //                .mem_we_n
		.mem_reset_n       (mem_reset_n),       //                .mem_reset_n
		.mem_dq            (mem_dq),            //                .mem_dq
		.mem_dqs           (mem_dqs),           //                .mem_dqs
		.mem_dqs_n         (mem_dqs_n),         //                .mem_dqs_n
		.mem_odt           (mem_odt),           //                .mem_odt
		.avl_ready         (avl_ready),         //             avl.waitrequest_n
		.avl_burstbegin    (avl_burstbegin),    //                .beginbursttransfer
		.avl_addr          (avl_addr),          //                .address
		.avl_rdata_valid   (avl_rdata_valid),   //                .readdatavalid
		.avl_rdata         (avl_rdata),         //                .readdata
		.avl_wdata         (avl_wdata),         //                .writedata
		.avl_be            (avl_be),            //                .byteenable
		.avl_read_req      (avl_read_req),      //                .read
		.avl_write_req     (avl_write_req),     //                .write
		.avl_size          (avl_size),          //                .burstcount
		.local_init_done   (local_init_done),   //          status.local_init_done
		.local_cal_success (local_cal_success), //                .local_cal_success
		.local_cal_fail    (local_cal_fail),    //                .local_cal_fail
		.oct_rdn           (oct_rdn),           //             oct.rdn
		.oct_rup           (oct_rup),           //                .rup
		.local_powerdn_ack (local_powerdn_ack), // local_powerdown.local_powerdn_ack
		.local_powerdn_req (local_powerdn_req)  //                .local_powerdn_req
	);

endmodule
// Retrieval info: <?xml version="1.0"?>
//<!--
//	Generated by Altera MegaWizard Launcher Utility version 1.0
//	************************************************************
//	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//	************************************************************
//	Copyright (C) 1991-2011 Altera Corporation
//	Any megafunction design, and related net list (encrypted or decrypted),
//	support information, device programming or simulation file, and any other
//	associated documentation or information provided by Altera or a partner
//	under Altera's Megafunction Partnership Program may be used only to
//	program PLD devices (but not masked PLD devices) from Altera.  Any other
//	use of such megafunction design, net list, support information, device
//	programming or simulation file, or any other related documentation or
//	information is prohibited for any other purpose, including, but not
//	limited to modification, reverse engineering, de-compiling, or use with
//	any other silicon devices, unless such use is explicitly licensed under
//	a separate agreement with Altera or a megafunction partner.  Title to
//	the intellectual property, including patents, copyrights, trademarks,
//	trade secrets, or maskworks, embodied in any such megafunction design,
//	net list, support information, device programming or simulation file, or
//	any other related documentation or information provided by Altera or a
//	megafunction partner, remains with Altera, the megafunction partner, or
//	their respective licensors.  No other licenses, including any licenses
//	needed under any third party's intellectual property, are provided herein.
//-->
// Retrieval info: <instance entity-name="altera_mem_if_ddr3_emif" version="11.0" >
// Retrieval info: 	<generic name="MEM_VENDOR" value="Micron" />
// Retrieval info: 	<generic name="MEM_FORMAT" value="DISCRETE" />
// Retrieval info: 	<generic name="AC_PARITY" value="false" />
// Retrieval info: 	<generic name="RDIMM_CONFIG" value="0" />
// Retrieval info: 	<generic name="DISCRETE_FLY_BY" value="false" />
// Retrieval info: 	<generic name="DEVICE_DEPTH" value="1" />
// Retrieval info: 	<generic name="MEM_MIRROR_ADDRESSING" value="0" />
// Retrieval info: 	<generic name="MEM_CLK_FREQ_MAX" value="666.667" />
// Retrieval info: 	<generic name="MEM_ROW_ADDR_WIDTH" value="13" />
// Retrieval info: 	<generic name="MEM_COL_ADDR_WIDTH" value="10" />
// Retrieval info: 	<generic name="MEM_DQ_WIDTH" value="16" />
// Retrieval info: 	<generic name="MEM_DQ_PER_DQS" value="8" />
// Retrieval info: 	<generic name="MEM_BANKADDR_WIDTH" value="3" />
// Retrieval info: 	<generic name="MEM_IF_DM_PINS_EN" value="true" />
// Retrieval info: 	<generic name="MEM_IF_DQSN_EN" value="true" />
// Retrieval info: 	<generic name="MEM_NUMBER_OF_DIMMS" value="1" />
// Retrieval info: 	<generic name="MEM_NUMBER_OF_RANKS_PER_DIMM" value="1" />
// Retrieval info: 	<generic name="MEM_NUMBER_OF_RANKS_PER_DEVICE" value="1" />
// Retrieval info: 	<generic name="MEM_CK_WIDTH" value="1" />
// Retrieval info: 	<generic name="ALTMEMPHY_COMPATIBLE_MODE" value="false" />
// Retrieval info: 	<generic name="NEXTGEN" value="true" />
// Retrieval info: 	<generic name="MEM_IF_BOARD_BASE_DELAY" value="10" />
// Retrieval info: 	<generic name="MEM_IF_SIM_VALID_WINDOW" value="0" />
// Retrieval info: 	<generic name="MEM_GUARANTEED_WRITE_INIT" value="false" />
// Retrieval info: 	<generic name="MEM_BL" value="OTF" />
// Retrieval info: 	<generic name="MEM_BT" value="Sequential" />
// Retrieval info: 	<generic name="MEM_ASR" value="Manual" />
// Retrieval info: 	<generic name="MEM_SRT" value="Normal" />
// Retrieval info: 	<generic name="MEM_PD" value="DLL on" />
// Retrieval info: 	<generic name="MEM_DRV_STR" value="RZQ/7" />
// Retrieval info: 	<generic name="MEM_DLL_EN" value="true" />
// Retrieval info: 	<generic name="MEM_RTT_NOM" value="ODT Disabled" />
// Retrieval info: 	<generic name="MEM_RTT_WR" value="RZQ/4" />
// Retrieval info: 	<generic name="MEM_WTCL" value="6" />
// Retrieval info: 	<generic name="MEM_ATCL" value="Disabled" />
// Retrieval info: 	<generic name="MEM_TCL" value="7" />
// Retrieval info: 	<generic name="MEM_AUTO_LEVELING_MODE" value="true" />
// Retrieval info: 	<generic name="MEM_USER_LEVELING_MODE" value="Leveling" />
// Retrieval info: 	<generic name="MEM_INIT_EN" value="false" />
// Retrieval info: 	<generic name="MEM_INIT_FILE" value="" />
// Retrieval info: 	<generic name="DAT_DATA_WIDTH" value="32" />
// Retrieval info: 	<generic name="TIMING_TIS" value="190" />
// Retrieval info: 	<generic name="TIMING_TIH" value="140" />
// Retrieval info: 	<generic name="TIMING_TDS" value="30" />
// Retrieval info: 	<generic name="TIMING_TDH" value="65" />
// Retrieval info: 	<generic name="TIMING_TDQSQ" value="125" />
// Retrieval info: 	<generic name="TIMING_TQH" value="0.38" />
// Retrieval info: 	<generic name="TIMING_TDQSCK" value="255" />
// Retrieval info: 	<generic name="TIMING_TDQSS" value="0.25" />
// Retrieval info: 	<generic name="TIMING_TQSH" value="0.4" />
// Retrieval info: 	<generic name="TIMING_TDSH" value="0.2" />
// Retrieval info: 	<generic name="TIMING_TDSS" value="0.2" />
// Retrieval info: 	<generic name="MEM_TINIT_US" value="500" />
// Retrieval info: 	<generic name="MEM_TMRD_CK" value="4" />
// Retrieval info: 	<generic name="MEM_TRAS_NS" value="36.0" />
// Retrieval info: 	<generic name="MEM_TRCD_NS" value="13.5" />
// Retrieval info: 	<generic name="MEM_TRP_NS" value="13.5" />
// Retrieval info: 	<generic name="MEM_TREFI_US" value="7.8" />
// Retrieval info: 	<generic name="MEM_TRFC_NS" value="110.0" />
// Retrieval info: 	<generic name="MEM_TWR_NS" value="15.0" />
// Retrieval info: 	<generic name="MEM_TWTR" value="4" />
// Retrieval info: 	<generic name="MEM_TFAW_NS" value="30.0" />
// Retrieval info: 	<generic name="MEM_TRRD_NS" value="6.0" />
// Retrieval info: 	<generic name="MEM_TRTP_NS" value="7.5" />
// Retrieval info: 	<generic name="CSR_ADDR_WIDTH" value="8" />
// Retrieval info: 	<generic name="CSR_DATA_WIDTH" value="32" />
// Retrieval info: 	<generic name="POWER_OF_TWO_BUS" value="false" />
// Retrieval info: 	<generic name="SOPC_COMPAT_RESET" value="false" />
// Retrieval info: 	<generic name="AVL_MAX_SIZE" value="4" />
// Retrieval info: 	<generic name="BYTE_ENABLE" value="false" />
// Retrieval info: 	<generic name="ENABLE_CTRL_AVALON_INTERFACE" value="true" />
// Retrieval info: 	<generic name="CTL_SELF_REFRESH_EN" value="false" />
// Retrieval info: 	<generic name="AUTO_POWERDN_EN" value="false" />
// Retrieval info: 	<generic name="MEM_AUTO_PD_CYCLES" value="0" />
// Retrieval info: 	<generic name="CTL_USR_REFRESH_EN" value="false" />
// Retrieval info: 	<generic name="CTL_AUTOPCH_EN" value="false" />
// Retrieval info: 	<generic name="ADDR_ORDER" value="0" />
// Retrieval info: 	<generic name="CTL_LOOK_AHEAD_DEPTH" value="4" />
// Retrieval info: 	<generic name="CONTROLLER_LATENCY" value="5" />
// Retrieval info: 	<generic name="CFG_REORDER_DATA" value="true" />
// Retrieval info: 	<generic name="CFG_STARVE_LIMIT" value="10" />
// Retrieval info: 	<generic name="CTL_CSR_ENABLED" value="false" />
// Retrieval info: 	<generic name="CTL_CSR_CONNECTION" value="INTERNAL_JTAG" />
// Retrieval info: 	<generic name="CTL_ECC_ENABLED" value="false" />
// Retrieval info: 	<generic name="CTL_HRB_ENABLED" value="false" />
// Retrieval info: 	<generic name="CTL_ECC_AUTO_CORRECTION_ENABLED" value="false" />
// Retrieval info: 	<generic name="MULTICAST_EN" value="false" />
// Retrieval info: 	<generic name="CTL_DYNAMIC_BANK_ALLOCATION" value="false" />
// Retrieval info: 	<generic name="CTL_DYNAMIC_BANK_NUM" value="4" />
// Retrieval info: 	<generic name="DEBUG_MODE" value="false" />
// Retrieval info: 	<generic name="ENABLE_BURST_MERGE" value="false" />
// Retrieval info: 	<generic name="LOCAL_ID_WIDTH" value="8" />
// Retrieval info: 	<generic name="WRBUFFER_ADDR_WIDTH" value="6" />
// Retrieval info: 	<generic name="USE_MM_ADAPTOR" value="true" />
// Retrieval info: 	<generic name="USE_AXI_ADAPTOR" value="false" />
// Retrieval info: 	<generic name="HCX_COMPAT_MODE" value="false" />
// Retrieval info: 	<generic name="CTL_CMD_QUEUE_DEPTH" value="8" />
// Retrieval info: 	<generic name="CTL_CSR_READ_ONLY" value="1" />
// Retrieval info: 	<generic name="CFG_DATA_REORDERING_TYPE" value="INTER_BANK" />
// Retrieval info: 	<generic name="REF_CLK_FREQ" value="100.0" />
// Retrieval info: 	<generic name="REF_CLK_FREQ_PARAM_VALID" value="false" />
// Retrieval info: 	<generic name="REF_CLK_FREQ_MIN_PARAM" value="0.0" />
// Retrieval info: 	<generic name="REF_CLK_FREQ_MAX_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_DR_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_DR_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_DR_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_DR_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_DR_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_MEM_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_MEM_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_MEM_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_MEM_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_MEM_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_AFI_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_AFI_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_AFI_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_AFI_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_AFI_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_WRITE_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_WRITE_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_WRITE_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_WRITE_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_WRITE_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_NIOS_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_NIOS_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_NIOS_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_NIOS_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_NIOS_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_CONFIG_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_CONFIG_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_CONFIG_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_CONFIG_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_CONFIG_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_P2C_READ_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_P2C_READ_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_P2C_READ_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_P2C_READ_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_P2C_READ_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_HR_CLK_FREQ_PARAM" value="0.0" />
// Retrieval info: 	<generic name="PLL_HR_CLK_FREQ_SIM_STR_PARAM" value="" />
// Retrieval info: 	<generic name="PLL_HR_CLK_PHASE_PS_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_HR_CLK_MULT_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_HR_CLK_DIV_PARAM" value="0" />
// Retrieval info: 	<generic name="PLL_CLK_PARAM_VALID" value="false" />
// Retrieval info: 	<generic name="ENABLE_EXTRA_REPORTING" value="false" />
// Retrieval info: 	<generic name="NUM_EXTRA_REPORT_PATH" value="10" />
// Retrieval info: 	<generic name="ENABLE_ISS_PROBES" value="false" />
// Retrieval info: 	<generic name="READ_VALID_FIFO_SIZE" value="16" />
// Retrieval info: 	<generic name="CALIB_REG_WIDTH" value="8" />
// Retrieval info: 	<generic name="MAX_LATENCY_COUNT_WIDTH" value="5" />
// Retrieval info: 	<generic name="DLL_DELAY_CHAIN_LENGTH" value="10" />
// Retrieval info: 	<generic name="USE_SEQUENCER_BFM" value="false" />
// Retrieval info: 	<generic name="DEFAULT_FAST_SIM_MODEL" value="true" />
// Retrieval info: 	<generic name="PLL_SHARING_MODE" value="None" />
// Retrieval info: 	<generic name="DLL_SHARING_MODE" value="None" />
// Retrieval info: 	<generic name="OCT_SHARING_MODE" value="None" />
// Retrieval info: 	<generic name="ABSTRACT_REAL_COMPARE_TEST" value="false" />
// Retrieval info: 	<generic name="INCLUDE_BOARD_DELAY_MODEL" value="false" />
// Retrieval info: 	<generic name="PACKAGE_DESKEW" value="false" />
// Retrieval info: 	<generic name="EXTRA_SETTINGS" value="" />
// Retrieval info: 	<generic name="MEM_DEVICE" value="MISSING_MODEL" />
// Retrieval info: 	<generic name="FORCE_SYNTHESIS_LANGUAGE" value="" />
// Retrieval info: 	<generic name="QSYS_SEQUENCER_DEBUG" value="true" />
// Retrieval info: 	<generic name="SEQUENCER_TYPE" value="NIOS" />
// Retrieval info: 	<generic name="ADVERTIZE_SEQUENCER_SW_BUILD_FILES" value="false" />
// Retrieval info: 	<generic name="SEQ_MODE" value="0" />
// Retrieval info: 	<generic name="ADVANCED_CK_PHASES" value="false" />
// Retrieval info: 	<generic name="COMMAND_PHASE" value="0.0" />
// Retrieval info: 	<generic name="MEM_CK_PHASE" value="0.0" />
// Retrieval info: 	<generic name="C2P_WRITE_CLOCK_ADD_PHASE" value="0.0" />
// Retrieval info: 	<generic name="MEM_VOLTAGE" value="1.5V DDR3" />
// Retrieval info: 	<generic name="PLL_LOCATION" value="Top_Bottom" />
// Retrieval info: 	<generic name="SKIP_MEM_INIT" value="true" />
// Retrieval info: 	<generic name="READ_DQ_DQS_CLOCK_SOURCE" value="INVERTED_DQS_BUS" />
// Retrieval info: 	<generic name="DQ_INPUT_REG_USE_CLKN" value="false" />
// Retrieval info: 	<generic name="DQS_DQSN_MODE" value="DIFFERENTIAL" />
// Retrieval info: 	<generic name="AFI_DEBUG_INFO_WIDTH" value="32" />
// Retrieval info: 	<generic name="CALIBRATION_MODE" value="Skip" />
// Retrieval info: 	<generic name="NIOS_ROM_DATA_WIDTH" value="32" />
// Retrieval info: 	<generic name="NIOS_ROM_ADDRESS_WIDTH" value="12" />
// Retrieval info: 	<generic name="READ_FIFO_SIZE" value="8" />
// Retrieval info: 	<generic name="PHY_CSR_ENABLED" value="false" />
// Retrieval info: 	<generic name="PHY_CSR_CONNECTION" value="INTERNAL_JTAG" />
// Retrieval info: 	<generic name="TIMING_BOARD_DERATE_METHOD" value="AUTO" />
// Retrieval info: 	<generic name="TIMING_BOARD_CK_CKN_SLEW_RATE" value="2.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_AC_SLEW_RATE" value="1.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_DQS_DQSN_SLEW_RATE" value="2.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_DQ_SLEW_RATE" value="1.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_TIS" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_TIH" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_TDS" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_TDH" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_ISI_METHOD" value="AUTO" />
// Retrieval info: 	<generic name="TIMING_BOARD_AC_EYE_REDUCTION_SU" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_AC_EYE_REDUCTION_H" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_DQ_EYE_REDUCTION" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_DELTA_DQS_ARRIVAL_TIME" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_MAX_CK_DELAY" value="0.6" />
// Retrieval info: 	<generic name="TIMING_BOARD_MAX_DQS_DELAY" value="0.6" />
// Retrieval info: 	<generic name="TIMING_BOARD_SKEW_CKDQS_DIMM_MIN" value="-0.01" />
// Retrieval info: 	<generic name="TIMING_BOARD_SKEW_CKDQS_DIMM_MAX" value="0.01" />
// Retrieval info: 	<generic name="TIMING_BOARD_SKEW_BETWEEN_DIMMS" value="0.05" />
// Retrieval info: 	<generic name="TIMING_BOARD_SKEW_WITHIN_DQS" value="0.02" />
// Retrieval info: 	<generic name="TIMING_BOARD_SKEW_BETWEEN_DQS" value="0.02" />
// Retrieval info: 	<generic name="TIMING_BOARD_DQ_TO_DQS_SKEW" value="0.0" />
// Retrieval info: 	<generic name="TIMING_BOARD_AC_SKEW" value="0.02" />
// Retrieval info: 	<generic name="TIMING_BOARD_AC_TO_CK_SKEW" value="0.0" />
// Retrieval info: 	<generic name="RATE" value="Half" />
// Retrieval info: 	<generic name="MEM_CLK_FREQ" value="533.0" />
// Retrieval info: 	<generic name="DQS_TRK_ENABLED" value="false" />
// Retrieval info: 	<generic name="SYS_INFO_DEVICE_FAMILY" value="Stratix IV" />
// Retrieval info: 	<generic name="PARSE_FRIENDLY_DEVICE_FAMILY_PARAM_VALID" value="false" />
// Retrieval info: 	<generic name="PARSE_FRIENDLY_DEVICE_FAMILY_PARAM" value="" />
// Retrieval info: 	<generic name="DEVICE_FAMILY_PARAM" value="" />
// Retrieval info: 	<generic name="DISABLE_CHILD_MESSAGING" value="false" />
// Retrieval info: 	<generic name="SPEED_GRADE" value="2" />
// Retrieval info: 	<generic name="ADD_EFFICIENCY_MONITOR" value="false" />
// Retrieval info: 	<generic name="ENABLE_ABS_RAM_MEM_INIT" value="false" />
// Retrieval info: 	<generic name="ABS_RAM_MEM_INIT_FILENAME" value="meminit" />
// Retrieval info: </instance>
// IPFS_FILES : NONE

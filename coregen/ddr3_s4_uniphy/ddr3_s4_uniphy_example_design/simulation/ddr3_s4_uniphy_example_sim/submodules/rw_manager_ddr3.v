// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


module rw_manager_ddr3 (
	// Avalon Interface
	avl_clk,
	avl_reset_n,
	avl_address,
	avl_write,
	avl_writedata,
	avl_read,
	avl_readdata,
	avl_waitrequest,

	// AFI Interface
	afi_clk,
	afi_reset_n,
	afi_address,
	afi_bank,
	afi_cs_n,
	afi_cke,
	afi_odt,
	afi_ras_n,
	afi_cas_n,
	afi_we_n,
	afi_dqs_en,
	afi_mem_reset_n,
	afi_wdata,
	afi_wdata_valid,
	afi_dm,
	afi_rdata_en,
	afi_rdata_en_full,
	afi_rdata,
	afi_rdata_valid,
	csr_clk,
	csr_ena,
	csr_dout_phy,
	csr_dout
);

	parameter AVL_DATA_WIDTH 			= 32;
	parameter AVL_ADDR_WIDTH			= 16;
	
	parameter MEM_ADDRESS_WIDTH			= 19;
	parameter MEM_CONTROL_WIDTH			= 4;
	parameter MEM_DQ_WIDTH				= 36;
	parameter MEM_DM_WIDTH				= 4;
	parameter MEM_NUMBER_OF_RANKS			= 1;
	parameter MEM_CLK_EN_WIDTH			= 1;

	parameter MEM_BANK_WIDTH			= 2;
	parameter MEM_ODT_WIDTH				= 2;
	parameter MEM_CHIP_SELECT_WIDTH			= 1;

	parameter MEM_READ_DQS_WIDTH 			= 4;
	parameter MEM_WRITE_DQS_WIDTH			= 4;

	parameter AFI_RATIO = 2;

	parameter RATE = "Half";
	parameter HCX_COMPAT_MODE = 0;
	parameter DEVICE_FAMILY = "STRATIXIV";

	parameter AC_ROM_INIT_FILE_NAME = "AC_ROM.hex";
	parameter INST_ROM_INIT_FILE_NAME = "inst_ROM.hex";

	input avl_clk;
	input avl_reset_n;
	input [AVL_ADDR_WIDTH-1:0] avl_address;
	input avl_write;
	input [AVL_DATA_WIDTH-1:0] avl_writedata;
	input avl_read;
	output [AVL_DATA_WIDTH-1:0] avl_readdata;
	output avl_waitrequest;

	input afi_clk;
	input afi_reset_n;
	output [MEM_ADDRESS_WIDTH * AFI_RATIO - 1:0] afi_address;
	
	output [MEM_BANK_WIDTH * AFI_RATIO - 1:0] afi_bank;
	output [MEM_CHIP_SELECT_WIDTH * AFI_RATIO - 1:0] afi_cs_n;
	output [MEM_CLK_EN_WIDTH * AFI_RATIO - 1:0] afi_cke;
	output [MEM_ODT_WIDTH * AFI_RATIO - 1:0] afi_odt;
	output [MEM_CONTROL_WIDTH * AFI_RATIO - 1:0] afi_ras_n;
	output [MEM_CONTROL_WIDTH * AFI_RATIO - 1:0] afi_cas_n;
	output [MEM_CONTROL_WIDTH * AFI_RATIO - 1:0] afi_we_n;
	output [MEM_WRITE_DQS_WIDTH * AFI_RATIO - 1:0] afi_dqs_en;
	output [MEM_CONTROL_WIDTH * AFI_RATIO - 1:0] afi_mem_reset_n;

	output [MEM_DQ_WIDTH * 2 * AFI_RATIO - 1:0] afi_wdata;
	output [MEM_WRITE_DQS_WIDTH * AFI_RATIO - 1:0] afi_wdata_valid;
	output [MEM_DM_WIDTH * 2 * AFI_RATIO - 1:0] afi_dm;
	output afi_rdata_en;
	output afi_rdata_en_full;
	input [MEM_DQ_WIDTH * 2 * AFI_RATIO - 1:0] afi_rdata;
	input afi_rdata_valid;

	input csr_clk;
	input csr_ena;
	input csr_dout_phy;
	output csr_dout;
	
	parameter AC_BUS_WIDTH = 30;

	wire [AC_BUS_WIDTH - 1:0] ac_bus;

	rw_manager_generic rw_mgr_inst (
		.avl_clk(avl_clk),
		.avl_reset_n(avl_reset_n),
		.avl_address(avl_address),
		.avl_write(avl_write),
		.avl_writedata(avl_writedata),
		.avl_read(avl_read),
		.avl_readdata(avl_readdata),
		.avl_waitrequest(avl_waitrequest),

		.afi_clk(afi_clk),
		.afi_reset_n(afi_reset_n),
		.ac_masked_bus (afi_cs_n),
		.ac_bus (ac_bus),
		.afi_wdata(afi_wdata),
		.afi_dm(afi_dm),
		.afi_odt(afi_odt),
		.afi_rdata(afi_rdata),
		.afi_rdata_valid(afi_rdata_valid),
		.csr_clk(csr_clk),
		.csr_ena(csr_ena),
		.csr_dout_phy(csr_dout_phy),
		.csr_dout(csr_dout)
	);
	defparam rw_mgr_inst.AVL_DATA_WIDTH = AVL_DATA_WIDTH;
	defparam rw_mgr_inst.AVL_ADDRESS_WIDTH = AVL_ADDR_WIDTH;
	defparam rw_mgr_inst.MEM_DQ_WIDTH = MEM_DQ_WIDTH;
	defparam rw_mgr_inst.MEM_DM_WIDTH = MEM_DM_WIDTH;
	defparam rw_mgr_inst.MEM_ODT_WIDTH = MEM_ODT_WIDTH;
	defparam rw_mgr_inst.AC_BUS_WIDTH = AC_BUS_WIDTH;
	defparam rw_mgr_inst.AC_MASKED_BUS_WIDTH = MEM_CHIP_SELECT_WIDTH * AFI_RATIO;
	defparam rw_mgr_inst.MASK_WIDTH = MEM_CHIP_SELECT_WIDTH;
	defparam rw_mgr_inst.AFI_RATIO = AFI_RATIO;
	defparam rw_mgr_inst.MEM_READ_DQS_WIDTH = MEM_READ_DQS_WIDTH;
	defparam rw_mgr_inst.MEM_WRITE_DQS_WIDTH = MEM_WRITE_DQS_WIDTH;
	defparam rw_mgr_inst.RATE = RATE;
	defparam rw_mgr_inst.HCX_COMPAT_MODE = HCX_COMPAT_MODE;
	defparam rw_mgr_inst.DEVICE_FAMILY = DEVICE_FAMILY;
	defparam rw_mgr_inst.DEBUG_READ_DI_WIDTH = 32;
	defparam rw_mgr_inst.DEBUG_WRITE_TO_READ_RATIO_2_EXPONENT = 0;
	defparam rw_mgr_inst.AC_ROM_INIT_FILE_NAME = AC_ROM_INIT_FILE_NAME;
	defparam rw_mgr_inst.INST_ROM_INIT_FILE_NAME = INST_ROM_INIT_FILE_NAME;
	defparam rw_mgr_inst.AC_ODT_BIT =
		(AFI_RATIO == 4) ? 27 : // Quarter-rate
		(AFI_RATIO == 2) ? 25 : // Half-rate
		24; // Full-rate

generate
begin
	if (AFI_RATIO == 4) begin
		assign afi_address = {AFI_RATIO{ {(MEM_ADDRESS_WIDTH-13){1'b0}}, ac_bus[12:0] }};
		assign afi_bank = {AFI_RATIO{ac_bus[15:13]}};
		assign afi_mem_reset_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[16]}};
		assign afi_ras_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[17]}};
		assign afi_cas_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[18]}};
		assign afi_we_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[19]}};
		assign afi_dqs_en = {{(MEM_WRITE_DQS_WIDTH * AFI_RATIO / 4){ac_bus[23]}}, 
		                     {(MEM_WRITE_DQS_WIDTH * AFI_RATIO / 4){ac_bus[22]}},
		                     {(MEM_WRITE_DQS_WIDTH * AFI_RATIO / 4){ac_bus[21]}},
		                     {(MEM_WRITE_DQS_WIDTH * AFI_RATIO / 4){ac_bus[20]}}};
		assign afi_rdata_en_full = ac_bus[24];
		assign afi_rdata_en = ac_bus[25];
		assign afi_wdata_valid = {MEM_WRITE_DQS_WIDTH * AFI_RATIO{ac_bus[26]}};
		assign afi_cke = {(MEM_CLK_EN_WIDTH * AFI_RATIO){ac_bus[28]}};
	end else if (AFI_RATIO == 2) begin
		assign afi_address = {AFI_RATIO{ {(MEM_ADDRESS_WIDTH-13){1'b0}}, ac_bus[12:0] }};
		assign afi_bank = {AFI_RATIO{ac_bus[15:13]}};
		assign afi_mem_reset_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[16]}};
		assign afi_ras_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[17]}};
		assign afi_cas_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[18]}};
		assign afi_we_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[19]}};
		assign afi_dqs_en = {{(MEM_WRITE_DQS_WIDTH * AFI_RATIO / 2){ac_bus[21]}}, {(MEM_WRITE_DQS_WIDTH * AFI_RATIO / 2){ac_bus[20]}}};
		assign afi_rdata_en_full = ac_bus[22];
		assign afi_rdata_en = ac_bus[23];
		assign afi_wdata_valid = {MEM_WRITE_DQS_WIDTH * AFI_RATIO{ac_bus[24]}};
		assign afi_cke = {(MEM_CLK_EN_WIDTH * AFI_RATIO){ac_bus[26]}};
	end else begin
		assign afi_address = {AFI_RATIO{ {(MEM_ADDRESS_WIDTH-13){1'b0}}, ac_bus[12:0] }};
		assign afi_bank = {AFI_RATIO{ac_bus[15:13]}};
		assign afi_mem_reset_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[16]}};
		assign afi_ras_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[17]}};
		assign afi_cas_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[18]}};
		assign afi_we_n = {(MEM_CONTROL_WIDTH * AFI_RATIO){ac_bus[19]}};
		assign afi_dqs_en = {MEM_WRITE_DQS_WIDTH * AFI_RATIO{ac_bus[20]}};
		assign afi_rdata_en_full = ac_bus[21];
		assign afi_rdata_en = ac_bus[22];
		assign afi_wdata_valid = {MEM_WRITE_DQS_WIDTH * AFI_RATIO{ac_bus[23]}};
		assign afi_cke = {(MEM_CLK_EN_WIDTH * AFI_RATIO){ac_bus[25]}};
	end
end
endgenerate

endmodule

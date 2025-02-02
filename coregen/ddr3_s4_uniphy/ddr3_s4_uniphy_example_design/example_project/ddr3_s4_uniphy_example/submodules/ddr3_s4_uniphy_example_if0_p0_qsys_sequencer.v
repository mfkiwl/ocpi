// ddr3_s4_uniphy_example_if0_p0_qsys_sequencer.v

// This file was auto-generated from qsys_sequencer_110_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using SOPC Builder version 11.0sp1 208 at 2011.09.28.12:49:10

`timescale 1 ps / 1 ps
module ddr3_s4_uniphy_example_if0_p0_qsys_sequencer (
		input  wire        clock_clk,                   // clock.clk
		input  wire        reset_reset_n,               // reset.reset_n
		input  wire        reset_n_scc_clk,             //   scc.reset_n_scc_clk
		input  wire        scc_clk,                     //      .scc_clk
		output wire        scc_data,                    //      .scc_data
		output wire [1:0]  scc_dqs_ena,                 //      .scc_dqs_ena
		output wire [1:0]  scc_dqs_io_ena,              //      .scc_dqs_io_ena
		output wire [15:0] scc_dq_ena,                  //      .scc_dq_ena
		output wire [1:0]  scc_dm_ena,                  //      .scc_dm_ena
		output wire        scc_upd,                     //      .scc_upd
		input  wire [1:0]  capture_strobe_tracking,     //      .capture_strobe_tracking
		input  wire        phy_clk,                     //   phy.phy_clk
		input  wire        phy_reset_n,                 //      .phy_reset_n
		output wire [4:0]  phy_read_latency_counter,    //      .phy_read_latency_counter
		output wire [1:0]  phy_read_increment_vfifo_fr, //      .phy_read_increment_vfifo_fr
		output wire [1:0]  phy_read_increment_vfifo_hr, //      .phy_read_increment_vfifo_hr
		output wire [1:0]  phy_read_increment_vfifo_qr, //      .phy_read_increment_vfifo_qr
		output wire        phy_reset_mem_stable,        //      .phy_reset_mem_stable
		output wire [5:0]  phy_afi_wlat,                //      .phy_afi_wlat
		output wire [5:0]  phy_afi_rlat,                //      .phy_afi_rlat
		output wire        phy_mux_sel,                 //      .phy_mux_sel
		output wire        phy_cal_success,             //      .phy_cal_success
		output wire        phy_cal_fail,                //      .phy_cal_fail
		output wire [31:0] phy_cal_debug_info,          //      .phy_cal_debug_info
		output wire [1:0]  phy_read_fifo_reset,         //      .phy_read_fifo_reset
		output wire [1:0]  phy_vfifo_rd_en_override,    //      .phy_vfifo_rd_en_override
		input  wire [7:0]  calib_skip_steps,            // calib.calib_skip_steps
		input  wire        afi_clk,                     //   afi.afi_clk
		input  wire        afi_reset_n,                 //      .afi_reset_n
		output wire [25:0] afi_address,                 //      .afi_address
		output wire [5:0]  afi_bank,                    //      .afi_bank
		output wire [1:0]  afi_cs_n,                    //      .afi_cs_n
		output wire [1:0]  afi_cke,                     //      .afi_cke
		output wire [1:0]  afi_odt,                     //      .afi_odt
		output wire [1:0]  afi_ras_n,                   //      .afi_ras_n
		output wire [1:0]  afi_cas_n,                   //      .afi_cas_n
		output wire [1:0]  afi_we_n,                    //      .afi_we_n
		output wire [3:0]  afi_dqs_en,                  //      .afi_dqs_en
		output wire [1:0]  afi_mem_reset_n,             //      .afi_mem_reset_n
		output wire [63:0] afi_wdata,                   //      .afi_wdata
		output wire [3:0]  afi_wdata_valid,             //      .afi_wdata_valid
		output wire [7:0]  afi_dm,                      //      .afi_dm
		output wire        afi_rdata_en,                //      .afi_rdata_en
		output wire        afi_rdata_en_full,           //      .afi_rdata_en_full
		input  wire [63:0] afi_rdata,                   //      .afi_rdata
		input  wire        afi_rdata_valid              //      .afi_rdata_valid
	);

	wire         cpu_inst_instruction_master_waitrequest;                                                          // cpu_inst_instruction_master_translator:av_waitrequest -> cpu_inst:i_waitrequest
	wire  [16:0] cpu_inst_instruction_master_address;                                                              // cpu_inst:i_address -> cpu_inst_instruction_master_translator:av_address
	wire         cpu_inst_instruction_master_read;                                                                 // cpu_inst:i_read -> cpu_inst_instruction_master_translator:av_read
	wire  [31:0] cpu_inst_instruction_master_readdata;                                                             // cpu_inst_instruction_master_translator:av_readdata -> cpu_inst:i_readdata
	wire         cpu_inst_data_master_waitrequest;                                                                 // cpu_inst_data_master_translator:av_waitrequest -> cpu_inst:d_waitrequest
	wire  [31:0] cpu_inst_data_master_writedata;                                                                   // cpu_inst:d_writedata -> cpu_inst_data_master_translator:av_writedata
	wire  [18:0] cpu_inst_data_master_address;                                                                     // cpu_inst:d_address -> cpu_inst_data_master_translator:av_address
	wire         cpu_inst_data_master_write;                                                                       // cpu_inst:d_write -> cpu_inst_data_master_translator:av_write
	wire         cpu_inst_data_master_read;                                                                        // cpu_inst:d_read -> cpu_inst_data_master_translator:av_read
	wire  [31:0] cpu_inst_data_master_readdata;                                                                    // cpu_inst_data_master_translator:av_readdata -> cpu_inst:d_readdata
	wire         cpu_inst_data_master_debugaccess;                                                                 // cpu_inst:jtag_debug_module_debugaccess_to_roms -> cpu_inst_data_master_translator:av_debugaccess
	wire   [3:0] cpu_inst_data_master_byteenable;                                                                  // cpu_inst:d_byteenable -> cpu_inst_data_master_translator:av_byteenable
	wire  [31:0] sequencer_rom_s1_translator_avalon_anti_slave_0_writedata;                                        // sequencer_rom_s1_translator:av_writedata -> sequencer_rom:writedata
	wire  [11:0] sequencer_rom_s1_translator_avalon_anti_slave_0_address;                                          // sequencer_rom_s1_translator:av_address -> sequencer_rom:address
	wire         sequencer_rom_s1_translator_avalon_anti_slave_0_chipselect;                                       // sequencer_rom_s1_translator:av_chipselect -> sequencer_rom:chipselect
	wire         sequencer_rom_s1_translator_avalon_anti_slave_0_clken;                                            // sequencer_rom_s1_translator:av_clken -> sequencer_rom:clken
	wire         sequencer_rom_s1_translator_avalon_anti_slave_0_write;                                            // sequencer_rom_s1_translator:av_write -> sequencer_rom:write
	wire  [31:0] sequencer_rom_s1_translator_avalon_anti_slave_0_readdata;                                         // sequencer_rom:readdata -> sequencer_rom_s1_translator:av_readdata
	wire         sequencer_rom_s1_translator_avalon_anti_slave_0_debugaccess;                                      // sequencer_rom_s1_translator:av_debugaccess -> sequencer_rom:debugaccess
	wire   [3:0] sequencer_rom_s1_translator_avalon_anti_slave_0_byteenable;                                       // sequencer_rom_s1_translator:av_byteenable -> sequencer_rom:byteenable
	wire  [31:0] cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_writedata;                              // cpu_inst_jtag_debug_module_translator:av_writedata -> cpu_inst:jtag_debug_module_writedata
	wire   [8:0] cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_address;                                // cpu_inst_jtag_debug_module_translator:av_address -> cpu_inst:jtag_debug_module_address
	wire         cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_chipselect;                             // cpu_inst_jtag_debug_module_translator:av_chipselect -> cpu_inst:jtag_debug_module_select
	wire         cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_write;                                  // cpu_inst_jtag_debug_module_translator:av_write -> cpu_inst:jtag_debug_module_write
	wire  [31:0] cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_readdata;                               // cpu_inst:jtag_debug_module_readdata -> cpu_inst_jtag_debug_module_translator:av_readdata
	wire         cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_begintransfer;                          // cpu_inst_jtag_debug_module_translator:av_begintransfer -> cpu_inst:jtag_debug_module_begintransfer
	wire         cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_debugaccess;                            // cpu_inst_jtag_debug_module_translator:av_debugaccess -> cpu_inst:jtag_debug_module_debugaccess
	wire   [3:0] cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_byteenable;                             // cpu_inst_jtag_debug_module_translator:av_byteenable -> cpu_inst:jtag_debug_module_byteenable
	wire  [31:0] sequencer_ram_s1_translator_avalon_anti_slave_0_writedata;                                        // sequencer_ram_s1_translator:av_writedata -> sequencer_ram:writedata
	wire   [8:0] sequencer_ram_s1_translator_avalon_anti_slave_0_address;                                          // sequencer_ram_s1_translator:av_address -> sequencer_ram:address
	wire         sequencer_ram_s1_translator_avalon_anti_slave_0_chipselect;                                       // sequencer_ram_s1_translator:av_chipselect -> sequencer_ram:chipselect
	wire         sequencer_ram_s1_translator_avalon_anti_slave_0_clken;                                            // sequencer_ram_s1_translator:av_clken -> sequencer_ram:clken
	wire         sequencer_ram_s1_translator_avalon_anti_slave_0_write;                                            // sequencer_ram_s1_translator:av_write -> sequencer_ram:write
	wire  [31:0] sequencer_ram_s1_translator_avalon_anti_slave_0_readdata;                                         // sequencer_ram:readdata -> sequencer_ram_s1_translator:av_readdata
	wire   [3:0] sequencer_ram_s1_translator_avalon_anti_slave_0_byteenable;                                       // sequencer_ram_s1_translator:av_byteenable -> sequencer_ram:byteenable
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest;                             // sequencer_rw_mgr_inst:avl_waitrequest -> sequencer_rw_mgr_inst_avl_translator:av_waitrequest
	wire  [31:0] sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_writedata;                               // sequencer_rw_mgr_inst_avl_translator:av_writedata -> sequencer_rw_mgr_inst:avl_writedata
	wire  [12:0] sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_address;                                 // sequencer_rw_mgr_inst_avl_translator:av_address -> sequencer_rw_mgr_inst:avl_address
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_write;                                   // sequencer_rw_mgr_inst_avl_translator:av_write -> sequencer_rw_mgr_inst:avl_write
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_read;                                    // sequencer_rw_mgr_inst_avl_translator:av_read -> sequencer_rw_mgr_inst:avl_read
	wire  [31:0] sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_readdata;                                // sequencer_rw_mgr_inst:avl_readdata -> sequencer_rw_mgr_inst_avl_translator:av_readdata
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest;                            // sequencer_phy_mgr_inst:avl_waitrequest -> sequencer_phy_mgr_inst_avl_translator:av_waitrequest
	wire  [31:0] sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_writedata;                              // sequencer_phy_mgr_inst_avl_translator:av_writedata -> sequencer_phy_mgr_inst:avl_writedata
	wire  [12:0] sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_address;                                // sequencer_phy_mgr_inst_avl_translator:av_address -> sequencer_phy_mgr_inst:avl_address
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_write;                                  // sequencer_phy_mgr_inst_avl_translator:av_write -> sequencer_phy_mgr_inst:avl_write
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_read;                                   // sequencer_phy_mgr_inst_avl_translator:av_read -> sequencer_phy_mgr_inst:avl_read
	wire  [31:0] sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_readdata;                               // sequencer_phy_mgr_inst:avl_readdata -> sequencer_phy_mgr_inst_avl_translator:av_readdata
	wire         sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest;                           // sequencer_data_mgr_inst:avl_waitrequest -> sequencer_data_mgr_inst_avl_translator:av_waitrequest
	wire  [31:0] sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_writedata;                             // sequencer_data_mgr_inst_avl_translator:av_writedata -> sequencer_data_mgr_inst:avl_writedata
	wire  [12:0] sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_address;                               // sequencer_data_mgr_inst_avl_translator:av_address -> sequencer_data_mgr_inst:avl_address
	wire         sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_write;                                 // sequencer_data_mgr_inst_avl_translator:av_write -> sequencer_data_mgr_inst:avl_write
	wire         sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_read;                                  // sequencer_data_mgr_inst_avl_translator:av_read -> sequencer_data_mgr_inst:avl_read
	wire  [31:0] sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_readdata;                              // sequencer_data_mgr_inst:avl_readdata -> sequencer_data_mgr_inst_avl_translator:av_readdata
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest;                            // sequencer_ptr_mgr_inst:avl_waitrequest -> sequencer_ptr_mgr_inst_avl_translator:av_waitrequest
	wire  [31:0] sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_writedata;                              // sequencer_ptr_mgr_inst_avl_translator:av_writedata -> sequencer_ptr_mgr_inst:avl_writedata
	wire  [12:0] sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_address;                                // sequencer_ptr_mgr_inst_avl_translator:av_address -> sequencer_ptr_mgr_inst:avl_address
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_write;                                  // sequencer_ptr_mgr_inst_avl_translator:av_write -> sequencer_ptr_mgr_inst:avl_write
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_read;                                   // sequencer_ptr_mgr_inst_avl_translator:av_read -> sequencer_ptr_mgr_inst:avl_read
	wire  [31:0] sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_readdata;                               // sequencer_ptr_mgr_inst:avl_readdata -> sequencer_ptr_mgr_inst_avl_translator:av_readdata
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest;                            // sequencer_scc_mgr_inst:avl_waitrequest -> sequencer_scc_mgr_inst_avl_translator:av_waitrequest
	wire  [31:0] sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_writedata;                              // sequencer_scc_mgr_inst_avl_translator:av_writedata -> sequencer_scc_mgr_inst:avl_writedata
	wire  [12:0] sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_address;                                // sequencer_scc_mgr_inst_avl_translator:av_address -> sequencer_scc_mgr_inst:avl_address
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_write;                                  // sequencer_scc_mgr_inst_avl_translator:av_write -> sequencer_scc_mgr_inst:avl_write
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_read;                                   // sequencer_scc_mgr_inst_avl_translator:av_read -> sequencer_scc_mgr_inst:avl_read
	wire  [31:0] sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_readdata;                               // sequencer_scc_mgr_inst:avl_readdata -> sequencer_scc_mgr_inst_avl_translator:av_readdata
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_waitrequest;                     // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_waitrequest -> cpu_inst_instruction_master_translator:uav_waitrequest
	wire   [2:0] cpu_inst_instruction_master_translator_avalon_universal_master_0_burstcount;                      // cpu_inst_instruction_master_translator:uav_burstcount -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] cpu_inst_instruction_master_translator_avalon_universal_master_0_writedata;                       // cpu_inst_instruction_master_translator:uav_writedata -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_writedata
	wire  [18:0] cpu_inst_instruction_master_translator_avalon_universal_master_0_address;                         // cpu_inst_instruction_master_translator:uav_address -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_address
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_lock;                            // cpu_inst_instruction_master_translator:uav_lock -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_lock
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_write;                           // cpu_inst_instruction_master_translator:uav_write -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_write
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_read;                            // cpu_inst_instruction_master_translator:uav_read -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] cpu_inst_instruction_master_translator_avalon_universal_master_0_readdata;                        // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_readdata -> cpu_inst_instruction_master_translator:uav_readdata
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_debugaccess;                     // cpu_inst_instruction_master_translator:uav_debugaccess -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] cpu_inst_instruction_master_translator_avalon_universal_master_0_byteenable;                      // cpu_inst_instruction_master_translator:uav_byteenable -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_byteenable
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_readdatavalid;                   // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:av_readdatavalid -> cpu_inst_instruction_master_translator:uav_readdatavalid
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_waitrequest;                            // cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_waitrequest -> cpu_inst_data_master_translator:uav_waitrequest
	wire   [2:0] cpu_inst_data_master_translator_avalon_universal_master_0_burstcount;                             // cpu_inst_data_master_translator:uav_burstcount -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] cpu_inst_data_master_translator_avalon_universal_master_0_writedata;                              // cpu_inst_data_master_translator:uav_writedata -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_writedata
	wire  [18:0] cpu_inst_data_master_translator_avalon_universal_master_0_address;                                // cpu_inst_data_master_translator:uav_address -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_address
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_lock;                                   // cpu_inst_data_master_translator:uav_lock -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_lock
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_write;                                  // cpu_inst_data_master_translator:uav_write -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_write
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_read;                                   // cpu_inst_data_master_translator:uav_read -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] cpu_inst_data_master_translator_avalon_universal_master_0_readdata;                               // cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_readdata -> cpu_inst_data_master_translator:uav_readdata
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_debugaccess;                            // cpu_inst_data_master_translator:uav_debugaccess -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] cpu_inst_data_master_translator_avalon_universal_master_0_byteenable;                             // cpu_inst_data_master_translator:uav_byteenable -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_byteenable
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_readdatavalid;                          // cpu_inst_data_master_translator_avalon_universal_master_0_agent:av_readdatavalid -> cpu_inst_data_master_translator:uav_readdatavalid
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;                        // sequencer_rom_s1_translator:uav_waitrequest -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;                         // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> sequencer_rom_s1_translator:uav_burstcount
	wire  [31:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_writedata;                          // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> sequencer_rom_s1_translator:uav_writedata
	wire  [18:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_address;                            // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_address -> sequencer_rom_s1_translator:uav_address
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_write;                              // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_write -> sequencer_rom_s1_translator:uav_write
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_lock;                               // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_lock -> sequencer_rom_s1_translator:uav_lock
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_read;                               // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_read -> sequencer_rom_s1_translator:uav_read
	wire  [31:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                           // sequencer_rom_s1_translator:uav_readdata -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                      // sequencer_rom_s1_translator:uav_readdatavalid -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;                        // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sequencer_rom_s1_translator:uav_debugaccess
	wire   [3:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;                         // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> sequencer_rom_s1_translator:uav_byteenable
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                 // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;                       // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;               // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_data;                        // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;                       // sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;              // sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                    // sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;            // sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                     // sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                    // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                  // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                   // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                  // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_waitrequest;              // cpu_inst_jtag_debug_module_translator:uav_waitrequest -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_burstcount;               // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_burstcount -> cpu_inst_jtag_debug_module_translator:uav_burstcount
	wire  [31:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_writedata;                // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_writedata -> cpu_inst_jtag_debug_module_translator:uav_writedata
	wire  [18:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_address;                  // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_address -> cpu_inst_jtag_debug_module_translator:uav_address
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_write;                    // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_write -> cpu_inst_jtag_debug_module_translator:uav_write
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_lock;                     // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_lock -> cpu_inst_jtag_debug_module_translator:uav_lock
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_read;                     // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_read -> cpu_inst_jtag_debug_module_translator:uav_read
	wire  [31:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdata;                 // cpu_inst_jtag_debug_module_translator:uav_readdata -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdatavalid;            // cpu_inst_jtag_debug_module_translator:uav_readdatavalid -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_debugaccess;              // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_debugaccess -> cpu_inst_jtag_debug_module_translator:uav_debugaccess
	wire   [3:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_byteenable;               // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_byteenable -> cpu_inst_jtag_debug_module_translator:uav_byteenable
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;       // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_valid;             // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_valid -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;     // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_data;              // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_data -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_ready;             // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;    // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;          // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;  // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;           // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;          // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_ready -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;        // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;         // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;        // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;                        // sequencer_ram_s1_translator:uav_waitrequest -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;                         // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> sequencer_ram_s1_translator:uav_burstcount
	wire  [31:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_writedata;                          // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> sequencer_ram_s1_translator:uav_writedata
	wire  [18:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_address;                            // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_address -> sequencer_ram_s1_translator:uav_address
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_write;                              // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_write -> sequencer_ram_s1_translator:uav_write
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_lock;                               // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_lock -> sequencer_ram_s1_translator:uav_lock
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_read;                               // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_read -> sequencer_ram_s1_translator:uav_read
	wire  [31:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                           // sequencer_ram_s1_translator:uav_readdata -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                      // sequencer_ram_s1_translator:uav_readdatavalid -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;                        // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sequencer_ram_s1_translator:uav_debugaccess
	wire   [3:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;                         // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> sequencer_ram_s1_translator:uav_byteenable
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                 // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;                       // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;               // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_data;                        // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;                       // sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;              // sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                    // sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;            // sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                     // sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                    // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                  // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                   // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                  // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest;               // sequencer_rw_mgr_inst_avl_translator:uav_waitrequest -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount;                // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_burstcount -> sequencer_rw_mgr_inst_avl_translator:uav_burstcount
	wire  [31:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata;                 // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_writedata -> sequencer_rw_mgr_inst_avl_translator:uav_writedata
	wire  [18:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address;                   // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_address -> sequencer_rw_mgr_inst_avl_translator:uav_address
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write;                     // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_write -> sequencer_rw_mgr_inst_avl_translator:uav_write
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock;                      // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_lock -> sequencer_rw_mgr_inst_avl_translator:uav_lock
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read;                      // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_read -> sequencer_rw_mgr_inst_avl_translator:uav_read
	wire  [31:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata;                  // sequencer_rw_mgr_inst_avl_translator:uav_readdata -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid;             // sequencer_rw_mgr_inst_avl_translator:uav_readdatavalid -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess;               // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sequencer_rw_mgr_inst_avl_translator:uav_debugaccess
	wire   [3:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable;                // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_byteenable -> sequencer_rw_mgr_inst_avl_translator:uav_byteenable
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;        // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid;              // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_valid -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;      // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data;               // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_data -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready;              // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;     // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;           // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;   // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;            // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;           // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;         // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;          // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;         // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest;              // sequencer_phy_mgr_inst_avl_translator:uav_waitrequest -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount;               // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_burstcount -> sequencer_phy_mgr_inst_avl_translator:uav_burstcount
	wire  [31:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata;                // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_writedata -> sequencer_phy_mgr_inst_avl_translator:uav_writedata
	wire  [18:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address;                  // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_address -> sequencer_phy_mgr_inst_avl_translator:uav_address
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write;                    // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_write -> sequencer_phy_mgr_inst_avl_translator:uav_write
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock;                     // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_lock -> sequencer_phy_mgr_inst_avl_translator:uav_lock
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read;                     // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_read -> sequencer_phy_mgr_inst_avl_translator:uav_read
	wire  [31:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata;                 // sequencer_phy_mgr_inst_avl_translator:uav_readdata -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid;            // sequencer_phy_mgr_inst_avl_translator:uav_readdatavalid -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess;              // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sequencer_phy_mgr_inst_avl_translator:uav_debugaccess
	wire   [3:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable;               // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_byteenable -> sequencer_phy_mgr_inst_avl_translator:uav_byteenable
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;       // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid;             // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_valid -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;     // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data;              // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_data -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready;             // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;    // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;          // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;  // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;           // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;          // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;        // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;         // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;        // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest;             // sequencer_data_mgr_inst_avl_translator:uav_waitrequest -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount;              // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_burstcount -> sequencer_data_mgr_inst_avl_translator:uav_burstcount
	wire  [31:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata;               // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_writedata -> sequencer_data_mgr_inst_avl_translator:uav_writedata
	wire  [18:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address;                 // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_address -> sequencer_data_mgr_inst_avl_translator:uav_address
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write;                   // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_write -> sequencer_data_mgr_inst_avl_translator:uav_write
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock;                    // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_lock -> sequencer_data_mgr_inst_avl_translator:uav_lock
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read;                    // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_read -> sequencer_data_mgr_inst_avl_translator:uav_read
	wire  [31:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata;                // sequencer_data_mgr_inst_avl_translator:uav_readdata -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid;           // sequencer_data_mgr_inst_avl_translator:uav_readdatavalid -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess;             // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sequencer_data_mgr_inst_avl_translator:uav_debugaccess
	wire   [3:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable;              // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_byteenable -> sequencer_data_mgr_inst_avl_translator:uav_byteenable
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;      // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid;            // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_valid -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;    // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data;             // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_data -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready;            // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;   // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;         // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket; // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;          // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;         // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;       // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;        // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;       // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest;              // sequencer_ptr_mgr_inst_avl_translator:uav_waitrequest -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount;               // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_burstcount -> sequencer_ptr_mgr_inst_avl_translator:uav_burstcount
	wire  [31:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata;                // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_writedata -> sequencer_ptr_mgr_inst_avl_translator:uav_writedata
	wire  [18:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address;                  // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_address -> sequencer_ptr_mgr_inst_avl_translator:uav_address
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write;                    // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_write -> sequencer_ptr_mgr_inst_avl_translator:uav_write
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock;                     // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_lock -> sequencer_ptr_mgr_inst_avl_translator:uav_lock
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read;                     // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_read -> sequencer_ptr_mgr_inst_avl_translator:uav_read
	wire  [31:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata;                 // sequencer_ptr_mgr_inst_avl_translator:uav_readdata -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid;            // sequencer_ptr_mgr_inst_avl_translator:uav_readdatavalid -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess;              // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sequencer_ptr_mgr_inst_avl_translator:uav_debugaccess
	wire   [3:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable;               // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_byteenable -> sequencer_ptr_mgr_inst_avl_translator:uav_byteenable
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;       // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid;             // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_valid -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;     // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data;              // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_data -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready;             // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;    // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;          // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;  // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;           // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;          // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;        // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;         // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;        // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest;              // sequencer_scc_mgr_inst_avl_translator:uav_waitrequest -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount;               // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_burstcount -> sequencer_scc_mgr_inst_avl_translator:uav_burstcount
	wire  [31:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata;                // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_writedata -> sequencer_scc_mgr_inst_avl_translator:uav_writedata
	wire  [18:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address;                  // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_address -> sequencer_scc_mgr_inst_avl_translator:uav_address
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write;                    // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_write -> sequencer_scc_mgr_inst_avl_translator:uav_write
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock;                     // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_lock -> sequencer_scc_mgr_inst_avl_translator:uav_lock
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read;                     // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_read -> sequencer_scc_mgr_inst_avl_translator:uav_read
	wire  [31:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata;                 // sequencer_scc_mgr_inst_avl_translator:uav_readdata -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid;            // sequencer_scc_mgr_inst_avl_translator:uav_readdatavalid -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess;              // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sequencer_scc_mgr_inst_avl_translator:uav_debugaccess
	wire   [3:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable;               // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:m0_byteenable -> sequencer_scc_mgr_inst_avl_translator:uav_byteenable
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;       // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid;             // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_valid -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;     // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [76:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data;              // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_data -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready;             // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;    // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;          // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;  // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [76:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;           // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;          // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;        // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;         // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;        // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket;            // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router:sink_endofpacket
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_valid;                  // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:cp_valid -> addr_router:sink_valid
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket;          // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router:sink_startofpacket
	wire  [75:0] cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_data;                   // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:cp_data -> addr_router:sink_data
	wire         cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_ready;                  // addr_router:sink_ready -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:cp_ready
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket;                   // cpu_inst_data_master_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router_001:sink_endofpacket
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_valid;                         // cpu_inst_data_master_translator_avalon_universal_master_0_agent:cp_valid -> addr_router_001:sink_valid
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket;                 // cpu_inst_data_master_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router_001:sink_startofpacket
	wire  [75:0] cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_data;                          // cpu_inst_data_master_translator_avalon_universal_master_0_agent:cp_data -> addr_router_001:sink_data
	wire         cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_ready;                         // addr_router_001:sink_ready -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:cp_ready
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;                        // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router:sink_endofpacket
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_valid;                              // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router:sink_valid
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;                      // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router:sink_startofpacket
	wire  [75:0] sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_data;                               // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router:sink_data
	wire         sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_ready;                              // id_router:sink_ready -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_endofpacket;              // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_001:sink_endofpacket
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_valid;                    // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_001:sink_valid
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_startofpacket;            // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_001:sink_startofpacket
	wire  [75:0] cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_data;                     // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_data -> id_router_001:sink_data
	wire         cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_ready;                    // id_router_001:sink_ready -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_ready
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;                        // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_002:sink_endofpacket
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_valid;                              // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_002:sink_valid
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;                      // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_002:sink_startofpacket
	wire  [75:0] sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_data;                               // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router_002:sink_data
	wire         sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_ready;                              // id_router_002:sink_ready -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket;               // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_003:sink_endofpacket
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid;                     // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_003:sink_valid
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket;             // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_003:sink_startofpacket
	wire  [75:0] sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data;                      // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_data -> id_router_003:sink_data
	wire         sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready;                     // id_router_003:sink_ready -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_ready
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket;              // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_004:sink_endofpacket
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid;                    // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_004:sink_valid
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket;            // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_004:sink_startofpacket
	wire  [75:0] sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data;                     // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_data -> id_router_004:sink_data
	wire         sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready;                    // id_router_004:sink_ready -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_ready
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket;             // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_005:sink_endofpacket
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid;                   // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_005:sink_valid
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket;           // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_005:sink_startofpacket
	wire  [75:0] sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data;                    // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_data -> id_router_005:sink_data
	wire         sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready;                   // id_router_005:sink_ready -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_ready
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket;              // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_006:sink_endofpacket
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid;                    // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_006:sink_valid
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket;            // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_006:sink_startofpacket
	wire  [75:0] sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data;                     // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_data -> id_router_006:sink_data
	wire         sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready;                    // id_router_006:sink_ready -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_ready
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket;              // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_007:sink_endofpacket
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid;                    // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_007:sink_valid
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket;            // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_007:sink_startofpacket
	wire  [75:0] sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data;                     // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_data -> id_router_007:sink_data
	wire         sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready;                    // id_router_007:sink_ready -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:rp_ready
	wire         addr_router_src_endofpacket;                                                                      // addr_router:src_endofpacket -> limiter:cmd_sink_endofpacket
	wire         addr_router_src_valid;                                                                            // addr_router:src_valid -> limiter:cmd_sink_valid
	wire         addr_router_src_startofpacket;                                                                    // addr_router:src_startofpacket -> limiter:cmd_sink_startofpacket
	wire  [75:0] addr_router_src_data;                                                                             // addr_router:src_data -> limiter:cmd_sink_data
	wire   [7:0] addr_router_src_channel;                                                                          // addr_router:src_channel -> limiter:cmd_sink_channel
	wire         addr_router_src_ready;                                                                            // limiter:cmd_sink_ready -> addr_router:src_ready
	wire         limiter_rsp_src_endofpacket;                                                                      // limiter:rsp_src_endofpacket -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_rsp_src_valid;                                                                            // limiter:rsp_src_valid -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_rsp_src_startofpacket;                                                                    // limiter:rsp_src_startofpacket -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [75:0] limiter_rsp_src_data;                                                                             // limiter:rsp_src_data -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:rp_data
	wire   [7:0] limiter_rsp_src_channel;                                                                          // limiter:rsp_src_channel -> cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_rsp_src_ready;                                                                            // cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:rp_ready -> limiter:rsp_src_ready
	wire         addr_router_001_src_endofpacket;                                                                  // addr_router_001:src_endofpacket -> limiter_001:cmd_sink_endofpacket
	wire         addr_router_001_src_valid;                                                                        // addr_router_001:src_valid -> limiter_001:cmd_sink_valid
	wire         addr_router_001_src_startofpacket;                                                                // addr_router_001:src_startofpacket -> limiter_001:cmd_sink_startofpacket
	wire  [75:0] addr_router_001_src_data;                                                                         // addr_router_001:src_data -> limiter_001:cmd_sink_data
	wire   [7:0] addr_router_001_src_channel;                                                                      // addr_router_001:src_channel -> limiter_001:cmd_sink_channel
	wire         addr_router_001_src_ready;                                                                        // limiter_001:cmd_sink_ready -> addr_router_001:src_ready
	wire         limiter_001_rsp_src_endofpacket;                                                                  // limiter_001:rsp_src_endofpacket -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_001_rsp_src_valid;                                                                        // limiter_001:rsp_src_valid -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_001_rsp_src_startofpacket;                                                                // limiter_001:rsp_src_startofpacket -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [75:0] limiter_001_rsp_src_data;                                                                         // limiter_001:rsp_src_data -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:rp_data
	wire   [7:0] limiter_001_rsp_src_channel;                                                                      // limiter_001:rsp_src_channel -> cpu_inst_data_master_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_001_rsp_src_ready;                                                                        // cpu_inst_data_master_translator_avalon_universal_master_0_agent:rp_ready -> limiter_001:rsp_src_ready
	wire         rst_controller_reset_out_reset;                                                                   // rst_controller:reset_out -> [addr_router:reset, addr_router_001:reset, cmd_xbar_demux:reset, cmd_xbar_demux_001:reset, cmd_xbar_mux:reset, cmd_xbar_mux_001:reset, cpu_inst:reset_n, cpu_inst_data_master_translator:reset, cpu_inst_data_master_translator_avalon_universal_master_0_agent:reset, cpu_inst_instruction_master_translator:reset, cpu_inst_instruction_master_translator_avalon_universal_master_0_agent:reset, cpu_inst_jtag_debug_module_translator:reset, cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:reset, cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, id_router:reset, id_router_001:reset, id_router_002:reset, id_router_003:reset, id_router_004:reset, id_router_005:reset, id_router_006:reset, id_router_007:reset, irq_mapper:reset, limiter:reset, limiter_001:reset, rsp_xbar_demux:reset, rsp_xbar_demux_001:reset, rsp_xbar_demux_002:reset, rsp_xbar_demux_003:reset, rsp_xbar_demux_004:reset, rsp_xbar_demux_005:reset, rsp_xbar_demux_006:reset, rsp_xbar_demux_007:reset, rsp_xbar_mux:reset, rsp_xbar_mux_001:reset, sequencer_data_mgr_inst:avl_reset_n, sequencer_data_mgr_inst_avl_translator:reset, sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:reset, sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, sequencer_phy_mgr_inst:avl_reset_n, sequencer_phy_mgr_inst_avl_translator:reset, sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:reset, sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, sequencer_ptr_mgr_inst:avl_reset_n, sequencer_ptr_mgr_inst_avl_translator:reset, sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:reset, sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, sequencer_ram:reset, sequencer_ram_s1_translator:reset, sequencer_ram_s1_translator_avalon_universal_slave_0_agent:reset, sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, sequencer_rom:reset, sequencer_rom_s1_translator:reset, sequencer_rom_s1_translator_avalon_universal_slave_0_agent:reset, sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, sequencer_rw_mgr_inst:avl_reset_n, sequencer_rw_mgr_inst_avl_translator:reset, sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:reset, sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, sequencer_scc_mgr_inst:avl_reset_n, sequencer_scc_mgr_inst_avl_translator:reset, sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:reset, sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo:reset]
	wire         cmd_xbar_demux_src0_endofpacket;                                                                  // cmd_xbar_demux:src0_endofpacket -> cmd_xbar_mux:sink0_endofpacket
	wire         cmd_xbar_demux_src0_valid;                                                                        // cmd_xbar_demux:src0_valid -> cmd_xbar_mux:sink0_valid
	wire         cmd_xbar_demux_src0_startofpacket;                                                                // cmd_xbar_demux:src0_startofpacket -> cmd_xbar_mux:sink0_startofpacket
	wire  [75:0] cmd_xbar_demux_src0_data;                                                                         // cmd_xbar_demux:src0_data -> cmd_xbar_mux:sink0_data
	wire   [7:0] cmd_xbar_demux_src0_channel;                                                                      // cmd_xbar_demux:src0_channel -> cmd_xbar_mux:sink0_channel
	wire         cmd_xbar_demux_src0_ready;                                                                        // cmd_xbar_mux:sink0_ready -> cmd_xbar_demux:src0_ready
	wire         cmd_xbar_demux_src1_endofpacket;                                                                  // cmd_xbar_demux:src1_endofpacket -> cmd_xbar_mux_001:sink0_endofpacket
	wire         cmd_xbar_demux_src1_valid;                                                                        // cmd_xbar_demux:src1_valid -> cmd_xbar_mux_001:sink0_valid
	wire         cmd_xbar_demux_src1_startofpacket;                                                                // cmd_xbar_demux:src1_startofpacket -> cmd_xbar_mux_001:sink0_startofpacket
	wire  [75:0] cmd_xbar_demux_src1_data;                                                                         // cmd_xbar_demux:src1_data -> cmd_xbar_mux_001:sink0_data
	wire   [7:0] cmd_xbar_demux_src1_channel;                                                                      // cmd_xbar_demux:src1_channel -> cmd_xbar_mux_001:sink0_channel
	wire         cmd_xbar_demux_src1_ready;                                                                        // cmd_xbar_mux_001:sink0_ready -> cmd_xbar_demux:src1_ready
	wire         cmd_xbar_demux_001_src0_endofpacket;                                                              // cmd_xbar_demux_001:src0_endofpacket -> cmd_xbar_mux:sink1_endofpacket
	wire         cmd_xbar_demux_001_src0_valid;                                                                    // cmd_xbar_demux_001:src0_valid -> cmd_xbar_mux:sink1_valid
	wire         cmd_xbar_demux_001_src0_startofpacket;                                                            // cmd_xbar_demux_001:src0_startofpacket -> cmd_xbar_mux:sink1_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src0_data;                                                                     // cmd_xbar_demux_001:src0_data -> cmd_xbar_mux:sink1_data
	wire   [7:0] cmd_xbar_demux_001_src0_channel;                                                                  // cmd_xbar_demux_001:src0_channel -> cmd_xbar_mux:sink1_channel
	wire         cmd_xbar_demux_001_src0_ready;                                                                    // cmd_xbar_mux:sink1_ready -> cmd_xbar_demux_001:src0_ready
	wire         cmd_xbar_demux_001_src1_endofpacket;                                                              // cmd_xbar_demux_001:src1_endofpacket -> cmd_xbar_mux_001:sink1_endofpacket
	wire         cmd_xbar_demux_001_src1_valid;                                                                    // cmd_xbar_demux_001:src1_valid -> cmd_xbar_mux_001:sink1_valid
	wire         cmd_xbar_demux_001_src1_startofpacket;                                                            // cmd_xbar_demux_001:src1_startofpacket -> cmd_xbar_mux_001:sink1_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src1_data;                                                                     // cmd_xbar_demux_001:src1_data -> cmd_xbar_mux_001:sink1_data
	wire   [7:0] cmd_xbar_demux_001_src1_channel;                                                                  // cmd_xbar_demux_001:src1_channel -> cmd_xbar_mux_001:sink1_channel
	wire         cmd_xbar_demux_001_src1_ready;                                                                    // cmd_xbar_mux_001:sink1_ready -> cmd_xbar_demux_001:src1_ready
	wire         cmd_xbar_demux_001_src2_endofpacket;                                                              // cmd_xbar_demux_001:src2_endofpacket -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src2_valid;                                                                    // cmd_xbar_demux_001:src2_valid -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src2_startofpacket;                                                            // cmd_xbar_demux_001:src2_startofpacket -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src2_data;                                                                     // cmd_xbar_demux_001:src2_data -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src2_channel;                                                                  // cmd_xbar_demux_001:src2_channel -> sequencer_ram_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src3_endofpacket;                                                              // cmd_xbar_demux_001:src3_endofpacket -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src3_valid;                                                                    // cmd_xbar_demux_001:src3_valid -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src3_startofpacket;                                                            // cmd_xbar_demux_001:src3_startofpacket -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src3_data;                                                                     // cmd_xbar_demux_001:src3_data -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src3_channel;                                                                  // cmd_xbar_demux_001:src3_channel -> sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src4_endofpacket;                                                              // cmd_xbar_demux_001:src4_endofpacket -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src4_valid;                                                                    // cmd_xbar_demux_001:src4_valid -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src4_startofpacket;                                                            // cmd_xbar_demux_001:src4_startofpacket -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src4_data;                                                                     // cmd_xbar_demux_001:src4_data -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src4_channel;                                                                  // cmd_xbar_demux_001:src4_channel -> sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src5_endofpacket;                                                              // cmd_xbar_demux_001:src5_endofpacket -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src5_valid;                                                                    // cmd_xbar_demux_001:src5_valid -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src5_startofpacket;                                                            // cmd_xbar_demux_001:src5_startofpacket -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src5_data;                                                                     // cmd_xbar_demux_001:src5_data -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src5_channel;                                                                  // cmd_xbar_demux_001:src5_channel -> sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src6_endofpacket;                                                              // cmd_xbar_demux_001:src6_endofpacket -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src6_valid;                                                                    // cmd_xbar_demux_001:src6_valid -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src6_startofpacket;                                                            // cmd_xbar_demux_001:src6_startofpacket -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src6_data;                                                                     // cmd_xbar_demux_001:src6_data -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src6_channel;                                                                  // cmd_xbar_demux_001:src6_channel -> sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src7_endofpacket;                                                              // cmd_xbar_demux_001:src7_endofpacket -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src7_valid;                                                                    // cmd_xbar_demux_001:src7_valid -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src7_startofpacket;                                                            // cmd_xbar_demux_001:src7_startofpacket -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_demux_001_src7_data;                                                                     // cmd_xbar_demux_001:src7_data -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src7_channel;                                                                  // cmd_xbar_demux_001:src7_channel -> sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_channel
	wire         rsp_xbar_demux_src0_endofpacket;                                                                  // rsp_xbar_demux:src0_endofpacket -> rsp_xbar_mux:sink0_endofpacket
	wire         rsp_xbar_demux_src0_valid;                                                                        // rsp_xbar_demux:src0_valid -> rsp_xbar_mux:sink0_valid
	wire         rsp_xbar_demux_src0_startofpacket;                                                                // rsp_xbar_demux:src0_startofpacket -> rsp_xbar_mux:sink0_startofpacket
	wire  [75:0] rsp_xbar_demux_src0_data;                                                                         // rsp_xbar_demux:src0_data -> rsp_xbar_mux:sink0_data
	wire   [7:0] rsp_xbar_demux_src0_channel;                                                                      // rsp_xbar_demux:src0_channel -> rsp_xbar_mux:sink0_channel
	wire         rsp_xbar_demux_src0_ready;                                                                        // rsp_xbar_mux:sink0_ready -> rsp_xbar_demux:src0_ready
	wire         rsp_xbar_demux_src1_endofpacket;                                                                  // rsp_xbar_demux:src1_endofpacket -> rsp_xbar_mux_001:sink0_endofpacket
	wire         rsp_xbar_demux_src1_valid;                                                                        // rsp_xbar_demux:src1_valid -> rsp_xbar_mux_001:sink0_valid
	wire         rsp_xbar_demux_src1_startofpacket;                                                                // rsp_xbar_demux:src1_startofpacket -> rsp_xbar_mux_001:sink0_startofpacket
	wire  [75:0] rsp_xbar_demux_src1_data;                                                                         // rsp_xbar_demux:src1_data -> rsp_xbar_mux_001:sink0_data
	wire   [7:0] rsp_xbar_demux_src1_channel;                                                                      // rsp_xbar_demux:src1_channel -> rsp_xbar_mux_001:sink0_channel
	wire         rsp_xbar_demux_src1_ready;                                                                        // rsp_xbar_mux_001:sink0_ready -> rsp_xbar_demux:src1_ready
	wire         rsp_xbar_demux_001_src0_endofpacket;                                                              // rsp_xbar_demux_001:src0_endofpacket -> rsp_xbar_mux:sink1_endofpacket
	wire         rsp_xbar_demux_001_src0_valid;                                                                    // rsp_xbar_demux_001:src0_valid -> rsp_xbar_mux:sink1_valid
	wire         rsp_xbar_demux_001_src0_startofpacket;                                                            // rsp_xbar_demux_001:src0_startofpacket -> rsp_xbar_mux:sink1_startofpacket
	wire  [75:0] rsp_xbar_demux_001_src0_data;                                                                     // rsp_xbar_demux_001:src0_data -> rsp_xbar_mux:sink1_data
	wire   [7:0] rsp_xbar_demux_001_src0_channel;                                                                  // rsp_xbar_demux_001:src0_channel -> rsp_xbar_mux:sink1_channel
	wire         rsp_xbar_demux_001_src0_ready;                                                                    // rsp_xbar_mux:sink1_ready -> rsp_xbar_demux_001:src0_ready
	wire         rsp_xbar_demux_001_src1_endofpacket;                                                              // rsp_xbar_demux_001:src1_endofpacket -> rsp_xbar_mux_001:sink1_endofpacket
	wire         rsp_xbar_demux_001_src1_valid;                                                                    // rsp_xbar_demux_001:src1_valid -> rsp_xbar_mux_001:sink1_valid
	wire         rsp_xbar_demux_001_src1_startofpacket;                                                            // rsp_xbar_demux_001:src1_startofpacket -> rsp_xbar_mux_001:sink1_startofpacket
	wire  [75:0] rsp_xbar_demux_001_src1_data;                                                                     // rsp_xbar_demux_001:src1_data -> rsp_xbar_mux_001:sink1_data
	wire   [7:0] rsp_xbar_demux_001_src1_channel;                                                                  // rsp_xbar_demux_001:src1_channel -> rsp_xbar_mux_001:sink1_channel
	wire         rsp_xbar_demux_001_src1_ready;                                                                    // rsp_xbar_mux_001:sink1_ready -> rsp_xbar_demux_001:src1_ready
	wire         rsp_xbar_demux_002_src0_endofpacket;                                                              // rsp_xbar_demux_002:src0_endofpacket -> rsp_xbar_mux_001:sink2_endofpacket
	wire         rsp_xbar_demux_002_src0_valid;                                                                    // rsp_xbar_demux_002:src0_valid -> rsp_xbar_mux_001:sink2_valid
	wire         rsp_xbar_demux_002_src0_startofpacket;                                                            // rsp_xbar_demux_002:src0_startofpacket -> rsp_xbar_mux_001:sink2_startofpacket
	wire  [75:0] rsp_xbar_demux_002_src0_data;                                                                     // rsp_xbar_demux_002:src0_data -> rsp_xbar_mux_001:sink2_data
	wire   [7:0] rsp_xbar_demux_002_src0_channel;                                                                  // rsp_xbar_demux_002:src0_channel -> rsp_xbar_mux_001:sink2_channel
	wire         rsp_xbar_demux_002_src0_ready;                                                                    // rsp_xbar_mux_001:sink2_ready -> rsp_xbar_demux_002:src0_ready
	wire         rsp_xbar_demux_003_src0_endofpacket;                                                              // rsp_xbar_demux_003:src0_endofpacket -> rsp_xbar_mux_001:sink3_endofpacket
	wire         rsp_xbar_demux_003_src0_valid;                                                                    // rsp_xbar_demux_003:src0_valid -> rsp_xbar_mux_001:sink3_valid
	wire         rsp_xbar_demux_003_src0_startofpacket;                                                            // rsp_xbar_demux_003:src0_startofpacket -> rsp_xbar_mux_001:sink3_startofpacket
	wire  [75:0] rsp_xbar_demux_003_src0_data;                                                                     // rsp_xbar_demux_003:src0_data -> rsp_xbar_mux_001:sink3_data
	wire   [7:0] rsp_xbar_demux_003_src0_channel;                                                                  // rsp_xbar_demux_003:src0_channel -> rsp_xbar_mux_001:sink3_channel
	wire         rsp_xbar_demux_003_src0_ready;                                                                    // rsp_xbar_mux_001:sink3_ready -> rsp_xbar_demux_003:src0_ready
	wire         rsp_xbar_demux_004_src0_endofpacket;                                                              // rsp_xbar_demux_004:src0_endofpacket -> rsp_xbar_mux_001:sink4_endofpacket
	wire         rsp_xbar_demux_004_src0_valid;                                                                    // rsp_xbar_demux_004:src0_valid -> rsp_xbar_mux_001:sink4_valid
	wire         rsp_xbar_demux_004_src0_startofpacket;                                                            // rsp_xbar_demux_004:src0_startofpacket -> rsp_xbar_mux_001:sink4_startofpacket
	wire  [75:0] rsp_xbar_demux_004_src0_data;                                                                     // rsp_xbar_demux_004:src0_data -> rsp_xbar_mux_001:sink4_data
	wire   [7:0] rsp_xbar_demux_004_src0_channel;                                                                  // rsp_xbar_demux_004:src0_channel -> rsp_xbar_mux_001:sink4_channel
	wire         rsp_xbar_demux_004_src0_ready;                                                                    // rsp_xbar_mux_001:sink4_ready -> rsp_xbar_demux_004:src0_ready
	wire         rsp_xbar_demux_005_src0_endofpacket;                                                              // rsp_xbar_demux_005:src0_endofpacket -> rsp_xbar_mux_001:sink5_endofpacket
	wire         rsp_xbar_demux_005_src0_valid;                                                                    // rsp_xbar_demux_005:src0_valid -> rsp_xbar_mux_001:sink5_valid
	wire         rsp_xbar_demux_005_src0_startofpacket;                                                            // rsp_xbar_demux_005:src0_startofpacket -> rsp_xbar_mux_001:sink5_startofpacket
	wire  [75:0] rsp_xbar_demux_005_src0_data;                                                                     // rsp_xbar_demux_005:src0_data -> rsp_xbar_mux_001:sink5_data
	wire   [7:0] rsp_xbar_demux_005_src0_channel;                                                                  // rsp_xbar_demux_005:src0_channel -> rsp_xbar_mux_001:sink5_channel
	wire         rsp_xbar_demux_005_src0_ready;                                                                    // rsp_xbar_mux_001:sink5_ready -> rsp_xbar_demux_005:src0_ready
	wire         rsp_xbar_demux_006_src0_endofpacket;                                                              // rsp_xbar_demux_006:src0_endofpacket -> rsp_xbar_mux_001:sink6_endofpacket
	wire         rsp_xbar_demux_006_src0_valid;                                                                    // rsp_xbar_demux_006:src0_valid -> rsp_xbar_mux_001:sink6_valid
	wire         rsp_xbar_demux_006_src0_startofpacket;                                                            // rsp_xbar_demux_006:src0_startofpacket -> rsp_xbar_mux_001:sink6_startofpacket
	wire  [75:0] rsp_xbar_demux_006_src0_data;                                                                     // rsp_xbar_demux_006:src0_data -> rsp_xbar_mux_001:sink6_data
	wire   [7:0] rsp_xbar_demux_006_src0_channel;                                                                  // rsp_xbar_demux_006:src0_channel -> rsp_xbar_mux_001:sink6_channel
	wire         rsp_xbar_demux_006_src0_ready;                                                                    // rsp_xbar_mux_001:sink6_ready -> rsp_xbar_demux_006:src0_ready
	wire         rsp_xbar_demux_007_src0_endofpacket;                                                              // rsp_xbar_demux_007:src0_endofpacket -> rsp_xbar_mux_001:sink7_endofpacket
	wire         rsp_xbar_demux_007_src0_valid;                                                                    // rsp_xbar_demux_007:src0_valid -> rsp_xbar_mux_001:sink7_valid
	wire         rsp_xbar_demux_007_src0_startofpacket;                                                            // rsp_xbar_demux_007:src0_startofpacket -> rsp_xbar_mux_001:sink7_startofpacket
	wire  [75:0] rsp_xbar_demux_007_src0_data;                                                                     // rsp_xbar_demux_007:src0_data -> rsp_xbar_mux_001:sink7_data
	wire   [7:0] rsp_xbar_demux_007_src0_channel;                                                                  // rsp_xbar_demux_007:src0_channel -> rsp_xbar_mux_001:sink7_channel
	wire         rsp_xbar_demux_007_src0_ready;                                                                    // rsp_xbar_mux_001:sink7_ready -> rsp_xbar_demux_007:src0_ready
	wire         limiter_cmd_src_endofpacket;                                                                      // limiter:cmd_src_endofpacket -> cmd_xbar_demux:sink_endofpacket
	wire         limiter_cmd_src_startofpacket;                                                                    // limiter:cmd_src_startofpacket -> cmd_xbar_demux:sink_startofpacket
	wire  [75:0] limiter_cmd_src_data;                                                                             // limiter:cmd_src_data -> cmd_xbar_demux:sink_data
	wire   [7:0] limiter_cmd_src_channel;                                                                          // limiter:cmd_src_channel -> cmd_xbar_demux:sink_channel
	wire         limiter_cmd_src_ready;                                                                            // cmd_xbar_demux:sink_ready -> limiter:cmd_src_ready
	wire         rsp_xbar_mux_src_endofpacket;                                                                     // rsp_xbar_mux:src_endofpacket -> limiter:rsp_sink_endofpacket
	wire         rsp_xbar_mux_src_valid;                                                                           // rsp_xbar_mux:src_valid -> limiter:rsp_sink_valid
	wire         rsp_xbar_mux_src_startofpacket;                                                                   // rsp_xbar_mux:src_startofpacket -> limiter:rsp_sink_startofpacket
	wire  [75:0] rsp_xbar_mux_src_data;                                                                            // rsp_xbar_mux:src_data -> limiter:rsp_sink_data
	wire   [7:0] rsp_xbar_mux_src_channel;                                                                         // rsp_xbar_mux:src_channel -> limiter:rsp_sink_channel
	wire         rsp_xbar_mux_src_ready;                                                                           // limiter:rsp_sink_ready -> rsp_xbar_mux:src_ready
	wire         limiter_001_cmd_src_endofpacket;                                                                  // limiter_001:cmd_src_endofpacket -> cmd_xbar_demux_001:sink_endofpacket
	wire         limiter_001_cmd_src_startofpacket;                                                                // limiter_001:cmd_src_startofpacket -> cmd_xbar_demux_001:sink_startofpacket
	wire  [75:0] limiter_001_cmd_src_data;                                                                         // limiter_001:cmd_src_data -> cmd_xbar_demux_001:sink_data
	wire   [7:0] limiter_001_cmd_src_channel;                                                                      // limiter_001:cmd_src_channel -> cmd_xbar_demux_001:sink_channel
	wire         limiter_001_cmd_src_ready;                                                                        // cmd_xbar_demux_001:sink_ready -> limiter_001:cmd_src_ready
	wire         rsp_xbar_mux_001_src_endofpacket;                                                                 // rsp_xbar_mux_001:src_endofpacket -> limiter_001:rsp_sink_endofpacket
	wire         rsp_xbar_mux_001_src_valid;                                                                       // rsp_xbar_mux_001:src_valid -> limiter_001:rsp_sink_valid
	wire         rsp_xbar_mux_001_src_startofpacket;                                                               // rsp_xbar_mux_001:src_startofpacket -> limiter_001:rsp_sink_startofpacket
	wire  [75:0] rsp_xbar_mux_001_src_data;                                                                        // rsp_xbar_mux_001:src_data -> limiter_001:rsp_sink_data
	wire   [7:0] rsp_xbar_mux_001_src_channel;                                                                     // rsp_xbar_mux_001:src_channel -> limiter_001:rsp_sink_channel
	wire         rsp_xbar_mux_001_src_ready;                                                                       // limiter_001:rsp_sink_ready -> rsp_xbar_mux_001:src_ready
	wire         cmd_xbar_mux_src_endofpacket;                                                                     // cmd_xbar_mux:src_endofpacket -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_mux_src_valid;                                                                           // cmd_xbar_mux:src_valid -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_mux_src_startofpacket;                                                                   // cmd_xbar_mux:src_startofpacket -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_mux_src_data;                                                                            // cmd_xbar_mux:src_data -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_mux_src_channel;                                                                         // cmd_xbar_mux:src_channel -> sequencer_rom_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_mux_src_ready;                                                                           // sequencer_rom_s1_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_mux:src_ready
	wire         id_router_src_endofpacket;                                                                        // id_router:src_endofpacket -> rsp_xbar_demux:sink_endofpacket
	wire         id_router_src_valid;                                                                              // id_router:src_valid -> rsp_xbar_demux:sink_valid
	wire         id_router_src_startofpacket;                                                                      // id_router:src_startofpacket -> rsp_xbar_demux:sink_startofpacket
	wire  [75:0] id_router_src_data;                                                                               // id_router:src_data -> rsp_xbar_demux:sink_data
	wire   [7:0] id_router_src_channel;                                                                            // id_router:src_channel -> rsp_xbar_demux:sink_channel
	wire         id_router_src_ready;                                                                              // rsp_xbar_demux:sink_ready -> id_router:src_ready
	wire         cmd_xbar_mux_001_src_endofpacket;                                                                 // cmd_xbar_mux_001:src_endofpacket -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_mux_001_src_valid;                                                                       // cmd_xbar_mux_001:src_valid -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_mux_001_src_startofpacket;                                                               // cmd_xbar_mux_001:src_startofpacket -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [75:0] cmd_xbar_mux_001_src_data;                                                                        // cmd_xbar_mux_001:src_data -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_mux_001_src_channel;                                                                     // cmd_xbar_mux_001:src_channel -> cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_mux_001_src_ready;                                                                       // cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_mux_001:src_ready
	wire         id_router_001_src_endofpacket;                                                                    // id_router_001:src_endofpacket -> rsp_xbar_demux_001:sink_endofpacket
	wire         id_router_001_src_valid;                                                                          // id_router_001:src_valid -> rsp_xbar_demux_001:sink_valid
	wire         id_router_001_src_startofpacket;                                                                  // id_router_001:src_startofpacket -> rsp_xbar_demux_001:sink_startofpacket
	wire  [75:0] id_router_001_src_data;                                                                           // id_router_001:src_data -> rsp_xbar_demux_001:sink_data
	wire   [7:0] id_router_001_src_channel;                                                                        // id_router_001:src_channel -> rsp_xbar_demux_001:sink_channel
	wire         id_router_001_src_ready;                                                                          // rsp_xbar_demux_001:sink_ready -> id_router_001:src_ready
	wire         cmd_xbar_demux_001_src2_ready;                                                                    // sequencer_ram_s1_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src2_ready
	wire         id_router_002_src_endofpacket;                                                                    // id_router_002:src_endofpacket -> rsp_xbar_demux_002:sink_endofpacket
	wire         id_router_002_src_valid;                                                                          // id_router_002:src_valid -> rsp_xbar_demux_002:sink_valid
	wire         id_router_002_src_startofpacket;                                                                  // id_router_002:src_startofpacket -> rsp_xbar_demux_002:sink_startofpacket
	wire  [75:0] id_router_002_src_data;                                                                           // id_router_002:src_data -> rsp_xbar_demux_002:sink_data
	wire   [7:0] id_router_002_src_channel;                                                                        // id_router_002:src_channel -> rsp_xbar_demux_002:sink_channel
	wire         id_router_002_src_ready;                                                                          // rsp_xbar_demux_002:sink_ready -> id_router_002:src_ready
	wire         cmd_xbar_demux_001_src3_ready;                                                                    // sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src3_ready
	wire         id_router_003_src_endofpacket;                                                                    // id_router_003:src_endofpacket -> rsp_xbar_demux_003:sink_endofpacket
	wire         id_router_003_src_valid;                                                                          // id_router_003:src_valid -> rsp_xbar_demux_003:sink_valid
	wire         id_router_003_src_startofpacket;                                                                  // id_router_003:src_startofpacket -> rsp_xbar_demux_003:sink_startofpacket
	wire  [75:0] id_router_003_src_data;                                                                           // id_router_003:src_data -> rsp_xbar_demux_003:sink_data
	wire   [7:0] id_router_003_src_channel;                                                                        // id_router_003:src_channel -> rsp_xbar_demux_003:sink_channel
	wire         id_router_003_src_ready;                                                                          // rsp_xbar_demux_003:sink_ready -> id_router_003:src_ready
	wire         cmd_xbar_demux_001_src4_ready;                                                                    // sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src4_ready
	wire         id_router_004_src_endofpacket;                                                                    // id_router_004:src_endofpacket -> rsp_xbar_demux_004:sink_endofpacket
	wire         id_router_004_src_valid;                                                                          // id_router_004:src_valid -> rsp_xbar_demux_004:sink_valid
	wire         id_router_004_src_startofpacket;                                                                  // id_router_004:src_startofpacket -> rsp_xbar_demux_004:sink_startofpacket
	wire  [75:0] id_router_004_src_data;                                                                           // id_router_004:src_data -> rsp_xbar_demux_004:sink_data
	wire   [7:0] id_router_004_src_channel;                                                                        // id_router_004:src_channel -> rsp_xbar_demux_004:sink_channel
	wire         id_router_004_src_ready;                                                                          // rsp_xbar_demux_004:sink_ready -> id_router_004:src_ready
	wire         cmd_xbar_demux_001_src5_ready;                                                                    // sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src5_ready
	wire         id_router_005_src_endofpacket;                                                                    // id_router_005:src_endofpacket -> rsp_xbar_demux_005:sink_endofpacket
	wire         id_router_005_src_valid;                                                                          // id_router_005:src_valid -> rsp_xbar_demux_005:sink_valid
	wire         id_router_005_src_startofpacket;                                                                  // id_router_005:src_startofpacket -> rsp_xbar_demux_005:sink_startofpacket
	wire  [75:0] id_router_005_src_data;                                                                           // id_router_005:src_data -> rsp_xbar_demux_005:sink_data
	wire   [7:0] id_router_005_src_channel;                                                                        // id_router_005:src_channel -> rsp_xbar_demux_005:sink_channel
	wire         id_router_005_src_ready;                                                                          // rsp_xbar_demux_005:sink_ready -> id_router_005:src_ready
	wire         cmd_xbar_demux_001_src6_ready;                                                                    // sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src6_ready
	wire         id_router_006_src_endofpacket;                                                                    // id_router_006:src_endofpacket -> rsp_xbar_demux_006:sink_endofpacket
	wire         id_router_006_src_valid;                                                                          // id_router_006:src_valid -> rsp_xbar_demux_006:sink_valid
	wire         id_router_006_src_startofpacket;                                                                  // id_router_006:src_startofpacket -> rsp_xbar_demux_006:sink_startofpacket
	wire  [75:0] id_router_006_src_data;                                                                           // id_router_006:src_data -> rsp_xbar_demux_006:sink_data
	wire   [7:0] id_router_006_src_channel;                                                                        // id_router_006:src_channel -> rsp_xbar_demux_006:sink_channel
	wire         id_router_006_src_ready;                                                                          // rsp_xbar_demux_006:sink_ready -> id_router_006:src_ready
	wire         cmd_xbar_demux_001_src7_ready;                                                                    // sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src7_ready
	wire         id_router_007_src_endofpacket;                                                                    // id_router_007:src_endofpacket -> rsp_xbar_demux_007:sink_endofpacket
	wire         id_router_007_src_valid;                                                                          // id_router_007:src_valid -> rsp_xbar_demux_007:sink_valid
	wire         id_router_007_src_startofpacket;                                                                  // id_router_007:src_startofpacket -> rsp_xbar_demux_007:sink_startofpacket
	wire  [75:0] id_router_007_src_data;                                                                           // id_router_007:src_data -> rsp_xbar_demux_007:sink_data
	wire   [7:0] id_router_007_src_channel;                                                                        // id_router_007:src_channel -> rsp_xbar_demux_007:sink_channel
	wire         id_router_007_src_ready;                                                                          // rsp_xbar_demux_007:sink_ready -> id_router_007:src_ready
	wire   [7:0] limiter_cmd_valid_data;                                                                           // limiter:cmd_src_valid -> cmd_xbar_demux:sink_valid
	wire   [7:0] limiter_001_cmd_valid_data;                                                                       // limiter_001:cmd_src_valid -> cmd_xbar_demux_001:sink_valid
	wire  [31:0] cpu_inst_d_irq_irq;                                                                               // irq_mapper:sender_irq -> cpu_inst:d_irq

	sequencer_scc_mgr #(
		.AVL_DATA_WIDTH         (32),
		.AVL_ADDR_WIDTH         (13),
		.MEM_READ_DQS_WIDTH     (2),
		.MEM_WRITE_DQS_WIDTH    (2),
		.MEM_DQ_WIDTH           (16),
		.MEM_DM_WIDTH           (2),
		.DLL_DELAY_CHAIN_LENGTH (8),
		.FAMILY                 ("STRATIXIV"),
		.DQS_TRK_ENABLED        (0)
	) sequencer_scc_mgr_inst (
		.avl_clk                 (clock_clk),                                                             //   avl_clk.clk
		.avl_reset_n             (~rst_controller_reset_out_reset),                                       // avl_reset.reset_n
		.avl_address             (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_address),     //       avl.address
		.avl_write               (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_write),       //          .write
		.avl_writedata           (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),   //          .writedata
		.avl_read                (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_read),        //          .read
		.avl_readdata            (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),    //          .readdata
		.avl_waitrequest         (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest), //          .waitrequest
		.reset_n_scc_clk         (reset_n_scc_clk),                                                       //       scc.reset_n_scc_clk
		.scc_clk                 (scc_clk),                                                               //          .scc_clk
		.scc_data                (scc_data),                                                              //          .scc_data
		.scc_dqs_ena             (scc_dqs_ena),                                                           //          .scc_dqs_ena
		.scc_dqs_io_ena          (scc_dqs_io_ena),                                                        //          .scc_dqs_io_ena
		.scc_dq_ena              (scc_dq_ena),                                                            //          .scc_dq_ena
		.scc_dm_ena              (scc_dm_ena),                                                            //          .scc_dm_ena
		.scc_upd                 (scc_upd),                                                               //          .scc_upd
		.capture_strobe_tracking (capture_strobe_tracking)                                                //          .capture_strobe_tracking
	);

	sequencer_ptr_mgr #(
		.AVL_DATA_WIDTH (32),
		.AVL_ADDR_WIDTH (13)
	) sequencer_ptr_mgr_inst (
		.avl_clk         (clock_clk),                                                             //   avl_clk.clk
		.avl_reset_n     (~rst_controller_reset_out_reset),                                       // avl_reset.reset_n
		.avl_address     (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_address),     //       avl.address
		.avl_write       (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_write),       //          .write
		.avl_writedata   (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),   //          .writedata
		.avl_read        (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_read),        //          .read
		.avl_readdata    (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),    //          .readdata
		.avl_waitrequest (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest)  //          .waitrequest
	);

	sequencer_phy_mgr #(
		.AVL_DATA_WIDTH                    (32),
		.AVL_ADDR_WIDTH                    (13),
		.MAX_LATENCY_COUNT_WIDTH           (5),
		.MEM_READ_DQS_WIDTH                (2),
		.AFI_DEBUG_INFO_WIDTH              (32),
		.AFI_MAX_WRITE_LATENCY_COUNT_WIDTH (6),
		.AFI_MAX_READ_LATENCY_COUNT_WIDTH  (6),
		.CALIB_VFIFO_OFFSET                (14),
		.CALIB_LFIFO_OFFSET                (5),
		.CALIB_SKIP_STEPS_WIDTH            (8),
		.READ_VALID_FIFO_SIZE              (16),
		.MEM_T_WL                          (5),
		.MEM_T_RL                          (7),
		.CTL_REGDIMM_ENABLED               (0)
	) sequencer_phy_mgr_inst (
		.avl_clk                     (clock_clk),                                                             //   avl_clk.clk
		.avl_reset_n                 (~rst_controller_reset_out_reset),                                       // avl_reset.reset_n
		.avl_address                 (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_address),     //       avl.address
		.avl_write                   (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_write),       //          .write
		.avl_writedata               (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),   //          .writedata
		.avl_read                    (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_read),        //          .read
		.avl_readdata                (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),    //          .readdata
		.avl_waitrequest             (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest), //          .waitrequest
		.phy_clk                     (phy_clk),                                                               //       phy.phy_clk
		.phy_reset_n                 (phy_reset_n),                                                           //          .phy_reset_n
		.phy_read_latency_counter    (phy_read_latency_counter),                                              //          .phy_read_latency_counter
		.phy_read_increment_vfifo_fr (phy_read_increment_vfifo_fr),                                           //          .phy_read_increment_vfifo_fr
		.phy_read_increment_vfifo_hr (phy_read_increment_vfifo_hr),                                           //          .phy_read_increment_vfifo_hr
		.phy_read_increment_vfifo_qr (phy_read_increment_vfifo_qr),                                           //          .phy_read_increment_vfifo_qr
		.phy_reset_mem_stable        (phy_reset_mem_stable),                                                  //          .phy_reset_mem_stable
		.phy_afi_wlat                (phy_afi_wlat),                                                          //          .phy_afi_wlat
		.phy_afi_rlat                (phy_afi_rlat),                                                          //          .phy_afi_rlat
		.phy_mux_sel                 (phy_mux_sel),                                                           //          .phy_mux_sel
		.phy_cal_success             (phy_cal_success),                                                       //          .phy_cal_success
		.phy_cal_fail                (phy_cal_fail),                                                          //          .phy_cal_fail
		.phy_cal_debug_info          (phy_cal_debug_info),                                                    //          .phy_cal_debug_info
		.phy_read_fifo_reset         (phy_read_fifo_reset),                                                   //          .phy_read_fifo_reset
		.phy_vfifo_rd_en_override    (phy_vfifo_rd_en_override),                                              //          .phy_vfifo_rd_en_override
		.calib_skip_steps            (calib_skip_steps)                                                       //     calib.calib_skip_steps
	);

	sequencer_data_mgr #(
		.AVL_DATA_WIDTH                    (32),
		.AVL_ADDR_WIDTH                    (13),
		.MAX_LATENCY_COUNT_WIDTH           (5),
		.MEM_READ_DQS_WIDTH                (2),
		.AFI_DEBUG_INFO_WIDTH              (32),
		.AFI_MAX_WRITE_LATENCY_COUNT_WIDTH (6),
		.AFI_MAX_READ_LATENCY_COUNT_WIDTH  (6),
		.CALIB_VFIFO_OFFSET                (14),
		.CALIB_LFIFO_OFFSET                (5),
		.CALIB_SKIP_STEPS_WIDTH            (8),
		.READ_VALID_FIFO_SIZE              (16),
		.MEM_T_WL                          (5),
		.MEM_T_RL                          (7),
		.CTL_REGDIMM_ENABLED               (0),
		.SEQUENCER_VERSION                 (0)
	) sequencer_data_mgr_inst (
		.avl_clk         (clock_clk),                                                              //   avl_clk.clk
		.avl_reset_n     (~rst_controller_reset_out_reset),                                        // avl_reset.reset_n
		.avl_address     (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_address),     //       avl.address
		.avl_write       (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_write),       //          .write
		.avl_writedata   (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),   //          .writedata
		.avl_read        (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_read),        //          .read
		.avl_readdata    (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),    //          .readdata
		.avl_waitrequest (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest)  //          .waitrequest
	);

	rw_manager_ddr3 #(
		.RATE                    ("Half"),
		.AVL_DATA_WIDTH          (32),
		.AVL_ADDR_WIDTH          (13),
		.MEM_ADDRESS_WIDTH       (13),
		.MEM_CONTROL_WIDTH       (1),
		.MEM_DQ_WIDTH            (16),
		.MEM_DM_WIDTH            (2),
		.MEM_NUMBER_OF_RANKS     (1),
		.MEM_CLK_EN_WIDTH        (1),
		.MEM_BANK_WIDTH          (3),
		.MEM_ODT_WIDTH           (1),
		.MEM_CHIP_SELECT_WIDTH   (1),
		.MEM_READ_DQS_WIDTH      (2),
		.MEM_WRITE_DQS_WIDTH     (2),
		.AFI_RATIO               (2),
		.AC_BUS_WIDTH            (27),
		.HCX_COMPAT_MODE         (0),
		.DEVICE_FAMILY           ("STRATIXIV"),
		.AC_ROM_INIT_FILE_NAME   ("ddr3_s4_uniphy_example_if0_p0_AC_ROM.hex"),
		.INST_ROM_INIT_FILE_NAME ("ddr3_s4_uniphy_example_if0_p0_inst_ROM.hex")
	) sequencer_rw_mgr_inst (
		.avl_clk           (clock_clk),                                                            //   avl_clk.clk
		.avl_reset_n       (~rst_controller_reset_out_reset),                                      // avl_reset.reset_n
		.avl_address       (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_address),     //       avl.address
		.avl_write         (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_write),       //          .write
		.avl_writedata     (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),   //          .writedata
		.avl_read          (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_read),        //          .read
		.avl_readdata      (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),    //          .readdata
		.avl_waitrequest   (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest), //          .waitrequest
		.afi_clk           (afi_clk),                                                              //       afi.afi_clk
		.afi_reset_n       (afi_reset_n),                                                          //          .afi_reset_n
		.afi_address       (afi_address),                                                          //          .afi_address
		.afi_bank          (afi_bank),                                                             //          .afi_bank
		.afi_cs_n          (afi_cs_n),                                                             //          .afi_cs_n
		.afi_cke           (afi_cke),                                                              //          .afi_cke
		.afi_odt           (afi_odt),                                                              //          .afi_odt
		.afi_ras_n         (afi_ras_n),                                                            //          .afi_ras_n
		.afi_cas_n         (afi_cas_n),                                                            //          .afi_cas_n
		.afi_we_n          (afi_we_n),                                                             //          .afi_we_n
		.afi_dqs_en        (afi_dqs_en),                                                           //          .afi_dqs_en
		.afi_mem_reset_n   (afi_mem_reset_n),                                                      //          .afi_mem_reset_n
		.afi_wdata         (afi_wdata),                                                            //          .afi_wdata
		.afi_wdata_valid   (afi_wdata_valid),                                                      //          .afi_wdata_valid
		.afi_dm            (afi_dm),                                                               //          .afi_dm
		.afi_rdata_en      (afi_rdata_en),                                                         //          .afi_rdata_en
		.afi_rdata_en_full (afi_rdata_en_full),                                                    //          .afi_rdata_en_full
		.afi_rdata         (afi_rdata),                                                            //          .afi_rdata
		.afi_rdata_valid   (afi_rdata_valid),                                                      //          .afi_rdata_valid
		.csr_clk           (),                                                                     //       csr.csr_clk
		.csr_ena           (),                                                                     //          .csr_ena
		.csr_dout_phy      (),                                                                     //          .csr_dout_phy
		.csr_dout          ()                                                                      //          .csr_dout
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_sequencer_ram sequencer_ram (
		.clk        (clock_clk),                                                  //   clk1.clk
		.address    (sequencer_ram_s1_translator_avalon_anti_slave_0_address),    //     s1.address
		.chipselect (sequencer_ram_s1_translator_avalon_anti_slave_0_chipselect), //       .chipselect
		.clken      (sequencer_ram_s1_translator_avalon_anti_slave_0_clken),      //       .clken
		.readdata   (sequencer_ram_s1_translator_avalon_anti_slave_0_readdata),   //       .readdata
		.write      (sequencer_ram_s1_translator_avalon_anti_slave_0_write),      //       .write
		.writedata  (sequencer_ram_s1_translator_avalon_anti_slave_0_writedata),  //       .writedata
		.byteenable (sequencer_ram_s1_translator_avalon_anti_slave_0_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset)                              // reset1.reset
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_sequencer_rom sequencer_rom (
		.clk         (clock_clk),                                                   //   clk1.clk
		.address     (sequencer_rom_s1_translator_avalon_anti_slave_0_address),     //     s1.address
		.chipselect  (sequencer_rom_s1_translator_avalon_anti_slave_0_chipselect),  //       .chipselect
		.clken       (sequencer_rom_s1_translator_avalon_anti_slave_0_clken),       //       .clken
		.readdata    (sequencer_rom_s1_translator_avalon_anti_slave_0_readdata),    //       .readdata
		.write       (sequencer_rom_s1_translator_avalon_anti_slave_0_write),       //       .write
		.writedata   (sequencer_rom_s1_translator_avalon_anti_slave_0_writedata),   //       .writedata
		.debugaccess (sequencer_rom_s1_translator_avalon_anti_slave_0_debugaccess), //       .debugaccess
		.byteenable  (sequencer_rom_s1_translator_avalon_anti_slave_0_byteenable),  //       .byteenable
		.reset       (rst_controller_reset_out_reset)                               // reset1.reset
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_cpu_inst cpu_inst (
		.clk                                   (clock_clk),                                                               //                       clk.clk
		.reset_n                               (~rst_controller_reset_out_reset),                                         //                   reset_n.reset_n
		.d_address                             (cpu_inst_data_master_address),                                            //               data_master.address
		.d_byteenable                          (cpu_inst_data_master_byteenable),                                         //                          .byteenable
		.d_read                                (cpu_inst_data_master_read),                                               //                          .read
		.d_readdata                            (cpu_inst_data_master_readdata),                                           //                          .readdata
		.d_waitrequest                         (cpu_inst_data_master_waitrequest),                                        //                          .waitrequest
		.d_write                               (cpu_inst_data_master_write),                                              //                          .write
		.d_writedata                           (cpu_inst_data_master_writedata),                                          //                          .writedata
		.jtag_debug_module_debugaccess_to_roms (cpu_inst_data_master_debugaccess),                                        //                          .debugaccess
		.i_address                             (cpu_inst_instruction_master_address),                                     //        instruction_master.address
		.i_read                                (cpu_inst_instruction_master_read),                                        //                          .read
		.i_readdata                            (cpu_inst_instruction_master_readdata),                                    //                          .readdata
		.i_waitrequest                         (cpu_inst_instruction_master_waitrequest),                                 //                          .waitrequest
		.d_irq                                 (cpu_inst_d_irq_irq),                                                      //                     d_irq.irq
		.jtag_debug_module_resetrequest        (),                                                                        //   jtag_debug_module_reset.reset
		.jtag_debug_module_address             (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_address),       //         jtag_debug_module.address
		.jtag_debug_module_begintransfer       (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_begintransfer), //                          .begintransfer
		.jtag_debug_module_byteenable          (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_byteenable),    //                          .byteenable
		.jtag_debug_module_debugaccess         (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_debugaccess),   //                          .debugaccess
		.jtag_debug_module_readdata            (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_readdata),      //                          .readdata
		.jtag_debug_module_select              (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_chipselect),    //                          .chipselect
		.jtag_debug_module_write               (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_write),         //                          .write
		.jtag_debug_module_writedata           (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_writedata),     //                          .writedata
		.no_ci_readra                          ()                                                                         // custom_instruction_master.readra
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (17),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (19),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (0),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (1),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) cpu_inst_instruction_master_translator (
		.clk                   (clock_clk),                                                                      //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                 //                     reset.reset
		.uav_address           (cpu_inst_instruction_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (cpu_inst_instruction_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (cpu_inst_instruction_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (cpu_inst_instruction_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (cpu_inst_instruction_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (cpu_inst_instruction_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (cpu_inst_instruction_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (cpu_inst_instruction_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (cpu_inst_instruction_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (cpu_inst_instruction_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (cpu_inst_instruction_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (cpu_inst_instruction_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (cpu_inst_instruction_master_waitrequest),                                        //                          .waitrequest
		.av_read               (cpu_inst_instruction_master_read),                                               //                          .read
		.av_readdata           (cpu_inst_instruction_master_readdata),                                           //                          .readdata
		.av_burstcount         (1'b1),                                                                           //               (terminated)
		.av_byteenable         (4'b1111),                                                                        //               (terminated)
		.av_beginbursttransfer (1'b0),                                                                           //               (terminated)
		.av_begintransfer      (1'b0),                                                                           //               (terminated)
		.av_chipselect         (1'b0),                                                                           //               (terminated)
		.av_readdatavalid      (),                                                                               //               (terminated)
		.av_write              (1'b0),                                                                           //               (terminated)
		.av_writedata          (32'b00000000000000000000000000000000),                                           //               (terminated)
		.av_lock               (1'b0),                                                                           //               (terminated)
		.av_debugaccess        (1'b0),                                                                           //               (terminated)
		.uav_clken             (),                                                                               //               (terminated)
		.av_clken              (1'b1)                                                                            //               (terminated)
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (19),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (19),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (1)
	) cpu_inst_data_master_translator (
		.clk                   (clock_clk),                                                               //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                          //                     reset.reset
		.uav_address           (cpu_inst_data_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (cpu_inst_data_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (cpu_inst_data_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (cpu_inst_data_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (cpu_inst_data_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (cpu_inst_data_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (cpu_inst_data_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (cpu_inst_data_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (cpu_inst_data_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (cpu_inst_data_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (cpu_inst_data_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (cpu_inst_data_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (cpu_inst_data_master_waitrequest),                                        //                          .waitrequest
		.av_byteenable         (cpu_inst_data_master_byteenable),                                         //                          .byteenable
		.av_read               (cpu_inst_data_master_read),                                               //                          .read
		.av_readdata           (cpu_inst_data_master_readdata),                                           //                          .readdata
		.av_write              (cpu_inst_data_master_write),                                              //                          .write
		.av_writedata          (cpu_inst_data_master_writedata),                                          //                          .writedata
		.av_debugaccess        (cpu_inst_data_master_debugaccess),                                        //                          .debugaccess
		.av_burstcount         (1'b1),                                                                    //               (terminated)
		.av_beginbursttransfer (1'b0),                                                                    //               (terminated)
		.av_begintransfer      (1'b0),                                                                    //               (terminated)
		.av_chipselect         (1'b0),                                                                    //               (terminated)
		.av_readdatavalid      (),                                                                        //               (terminated)
		.av_lock               (1'b0),                                                                    //               (terminated)
		.uav_clken             (),                                                                        //               (terminated)
		.av_clken              (1'b1)                                                                     //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (12),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sequencer_rom_s1_translator (
		.clk                   (clock_clk),                                                                   //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                              //                    reset.reset
		.uav_address           (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sequencer_rom_s1_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sequencer_rom_s1_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (sequencer_rom_s1_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sequencer_rom_s1_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_byteenable         (sequencer_rom_s1_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_chipselect         (sequencer_rom_s1_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_clken              (sequencer_rom_s1_translator_avalon_anti_slave_0_clken),                       //                         .clken
		.av_debugaccess        (sequencer_rom_s1_translator_avalon_anti_slave_0_debugaccess),                 //                         .debugaccess
		.av_read               (),                                                                            //              (terminated)
		.av_begintransfer      (),                                                                            //              (terminated)
		.av_beginbursttransfer (),                                                                            //              (terminated)
		.av_burstcount         (),                                                                            //              (terminated)
		.av_readdatavalid      (1'b0),                                                                        //              (terminated)
		.av_waitrequest        (1'b0),                                                                        //              (terminated)
		.av_writebyteenable    (),                                                                            //              (terminated)
		.av_lock               (),                                                                            //              (terminated)
		.uav_clken             (1'b0),                                                                        //              (terminated)
		.av_outputenable       ()                                                                             //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (9),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) cpu_inst_jtag_debug_module_translator (
		.clk                   (clock_clk),                                                                             //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                        //                    reset.reset
		.uav_address           (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_begintransfer),               //                         .begintransfer
		.av_byteenable         (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_chipselect         (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_debugaccess        (cpu_inst_jtag_debug_module_translator_avalon_anti_slave_0_debugaccess),                 //                         .debugaccess
		.av_read               (),                                                                                      //              (terminated)
		.av_beginbursttransfer (),                                                                                      //              (terminated)
		.av_burstcount         (),                                                                                      //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                  //              (terminated)
		.av_waitrequest        (1'b0),                                                                                  //              (terminated)
		.av_writebyteenable    (),                                                                                      //              (terminated)
		.av_lock               (),                                                                                      //              (terminated)
		.av_clken              (),                                                                                      //              (terminated)
		.uav_clken             (1'b0),                                                                                  //              (terminated)
		.av_outputenable       ()                                                                                       //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (9),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sequencer_ram_s1_translator (
		.clk                   (clock_clk),                                                                   //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                              //                    reset.reset
		.uav_address           (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sequencer_ram_s1_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sequencer_ram_s1_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (sequencer_ram_s1_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sequencer_ram_s1_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_byteenable         (sequencer_ram_s1_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_chipselect         (sequencer_ram_s1_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_clken              (sequencer_ram_s1_translator_avalon_anti_slave_0_clken),                       //                         .clken
		.av_read               (),                                                                            //              (terminated)
		.av_begintransfer      (),                                                                            //              (terminated)
		.av_beginbursttransfer (),                                                                            //              (terminated)
		.av_burstcount         (),                                                                            //              (terminated)
		.av_readdatavalid      (1'b0),                                                                        //              (terminated)
		.av_waitrequest        (1'b0),                                                                        //              (terminated)
		.av_writebyteenable    (),                                                                            //              (terminated)
		.av_lock               (),                                                                            //              (terminated)
		.uav_clken             (1'b0),                                                                        //              (terminated)
		.av_debugaccess        (),                                                                            //              (terminated)
		.av_outputenable       ()                                                                             //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sequencer_rw_mgr_inst_avl_translator (
		.clk                   (clock_clk),                                                                            //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                       //                    reset.reset
		.uav_address           (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (sequencer_rw_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                                     //              (terminated)
		.av_beginbursttransfer (),                                                                                     //              (terminated)
		.av_burstcount         (),                                                                                     //              (terminated)
		.av_byteenable         (),                                                                                     //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                 //              (terminated)
		.av_writebyteenable    (),                                                                                     //              (terminated)
		.av_lock               (),                                                                                     //              (terminated)
		.av_chipselect         (),                                                                                     //              (terminated)
		.av_clken              (),                                                                                     //              (terminated)
		.uav_clken             (1'b0),                                                                                 //              (terminated)
		.av_debugaccess        (),                                                                                     //              (terminated)
		.av_outputenable       ()                                                                                      //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sequencer_phy_mgr_inst_avl_translator (
		.clk                   (clock_clk),                                                                             //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                        //                    reset.reset
		.uav_address           (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (sequencer_phy_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                                      //              (terminated)
		.av_beginbursttransfer (),                                                                                      //              (terminated)
		.av_burstcount         (),                                                                                      //              (terminated)
		.av_byteenable         (),                                                                                      //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                  //              (terminated)
		.av_writebyteenable    (),                                                                                      //              (terminated)
		.av_lock               (),                                                                                      //              (terminated)
		.av_chipselect         (),                                                                                      //              (terminated)
		.av_clken              (),                                                                                      //              (terminated)
		.uav_clken             (1'b0),                                                                                  //              (terminated)
		.av_debugaccess        (),                                                                                      //              (terminated)
		.av_outputenable       ()                                                                                       //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sequencer_data_mgr_inst_avl_translator (
		.clk                   (clock_clk),                                                                              //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                         //                    reset.reset
		.uav_address           (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (sequencer_data_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                                       //              (terminated)
		.av_beginbursttransfer (),                                                                                       //              (terminated)
		.av_burstcount         (),                                                                                       //              (terminated)
		.av_byteenable         (),                                                                                       //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                   //              (terminated)
		.av_writebyteenable    (),                                                                                       //              (terminated)
		.av_lock               (),                                                                                       //              (terminated)
		.av_chipselect         (),                                                                                       //              (terminated)
		.av_clken              (),                                                                                       //              (terminated)
		.uav_clken             (1'b0),                                                                                   //              (terminated)
		.av_debugaccess        (),                                                                                       //              (terminated)
		.av_outputenable       ()                                                                                        //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sequencer_ptr_mgr_inst_avl_translator (
		.clk                   (clock_clk),                                                                             //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                        //                    reset.reset
		.uav_address           (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (sequencer_ptr_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                                      //              (terminated)
		.av_beginbursttransfer (),                                                                                      //              (terminated)
		.av_burstcount         (),                                                                                      //              (terminated)
		.av_byteenable         (),                                                                                      //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                  //              (terminated)
		.av_writebyteenable    (),                                                                                      //              (terminated)
		.av_lock               (),                                                                                      //              (terminated)
		.av_chipselect         (),                                                                                      //              (terminated)
		.av_clken              (),                                                                                      //              (terminated)
		.uav_clken             (1'b0),                                                                                  //              (terminated)
		.av_debugaccess        (),                                                                                      //              (terminated)
		.av_outputenable       ()                                                                                       //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (19),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sequencer_scc_mgr_inst_avl_translator (
		.clk                   (clock_clk),                                                                             //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                        //                    reset.reset
		.uav_address           (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (sequencer_scc_mgr_inst_avl_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                                      //              (terminated)
		.av_beginbursttransfer (),                                                                                      //              (terminated)
		.av_burstcount         (),                                                                                      //              (terminated)
		.av_byteenable         (),                                                                                      //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                  //              (terminated)
		.av_writebyteenable    (),                                                                                      //              (terminated)
		.av_lock               (),                                                                                      //              (terminated)
		.av_chipselect         (),                                                                                      //              (terminated)
		.av_clken              (),                                                                                      //              (terminated)
		.uav_clken             (1'b0),                                                                                  //              (terminated)
		.av_debugaccess        (),                                                                                      //              (terminated)
		.av_outputenable       ()                                                                                       //              (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.PKT_BEGIN_BURST           (66),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.ST_DATA_W                 (76),
		.ST_CHANNEL_W              (8),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (3)
	) cpu_inst_instruction_master_translator_avalon_universal_master_0_agent (
		.clk              (clock_clk),                                                                               //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                                          // clk_reset.reset
		.av_address       (cpu_inst_instruction_master_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (cpu_inst_instruction_master_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (cpu_inst_instruction_master_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (cpu_inst_instruction_master_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (cpu_inst_instruction_master_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (cpu_inst_instruction_master_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (cpu_inst_instruction_master_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (cpu_inst_instruction_master_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (cpu_inst_instruction_master_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (cpu_inst_instruction_master_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (cpu_inst_instruction_master_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_rsp_src_valid),                                                                   //        rp.valid
		.rp_data          (limiter_rsp_src_data),                                                                    //          .data
		.rp_channel       (limiter_rsp_src_channel),                                                                 //          .channel
		.rp_startofpacket (limiter_rsp_src_startofpacket),                                                           //          .startofpacket
		.rp_endofpacket   (limiter_rsp_src_endofpacket),                                                             //          .endofpacket
		.rp_ready         (limiter_rsp_src_ready)                                                                    //          .ready
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.PKT_BEGIN_BURST           (66),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.ST_DATA_W                 (76),
		.ST_CHANNEL_W              (8),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (2),
		.BURSTWRAP_VALUE           (7)
	) cpu_inst_data_master_translator_avalon_universal_master_0_agent (
		.clk              (clock_clk),                                                                        //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                                   // clk_reset.reset
		.av_address       (cpu_inst_data_master_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (cpu_inst_data_master_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (cpu_inst_data_master_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (cpu_inst_data_master_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (cpu_inst_data_master_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (cpu_inst_data_master_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (cpu_inst_data_master_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (cpu_inst_data_master_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (cpu_inst_data_master_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (cpu_inst_data_master_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (cpu_inst_data_master_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_001_rsp_src_valid),                                                        //        rp.valid
		.rp_data          (limiter_001_rsp_src_data),                                                         //          .data
		.rp_channel       (limiter_001_rsp_src_channel),                                                      //          .channel
		.rp_startofpacket (limiter_001_rsp_src_startofpacket),                                                //          .startofpacket
		.rp_endofpacket   (limiter_001_rsp_src_endofpacket),                                                  //          .endofpacket
		.rp_ready         (limiter_001_rsp_src_ready)                                                         //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sequencer_rom_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                             //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                        //       clk_reset.reset
		.m0_address              (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_mux_src_ready),                                                                //              cp.ready
		.cp_valid                (cmd_xbar_mux_src_valid),                                                                //                .valid
		.cp_data                 (cmd_xbar_mux_src_data),                                                                 //                .data
		.cp_startofpacket        (cmd_xbar_mux_src_startofpacket),                                                        //                .startofpacket
		.cp_endofpacket          (cmd_xbar_mux_src_endofpacket),                                                          //                .endofpacket
		.cp_channel              (cmd_xbar_mux_src_channel),                                                              //                .channel
		.rf_sink_ready           (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                             //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                        // clk_reset.reset
		.in_data           (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                 // (terminated)
		.csr_read          (1'b0),                                                                                  // (terminated)
		.csr_write         (1'b0),                                                                                  // (terminated)
		.csr_readdata      (),                                                                                      // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                  // (terminated)
		.almost_full_data  (),                                                                                      // (terminated)
		.almost_empty_data (),                                                                                      // (terminated)
		.in_empty          (1'b0),                                                                                  // (terminated)
		.out_empty         (),                                                                                      // (terminated)
		.in_error          (1'b0),                                                                                  // (terminated)
		.out_error         (),                                                                                      // (terminated)
		.in_channel        (1'b0),                                                                                  // (terminated)
		.out_channel       ()                                                                                       // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                                       //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                                  //       clk_reset.reset
		.m0_address              (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_mux_001_src_ready),                                                                      //              cp.ready
		.cp_valid                (cmd_xbar_mux_001_src_valid),                                                                      //                .valid
		.cp_data                 (cmd_xbar_mux_001_src_data),                                                                       //                .data
		.cp_startofpacket        (cmd_xbar_mux_001_src_startofpacket),                                                              //                .startofpacket
		.cp_endofpacket          (cmd_xbar_mux_001_src_endofpacket),                                                                //                .endofpacket
		.cp_channel              (cmd_xbar_mux_001_src_channel),                                                                    //                .channel
		.rf_sink_ready           (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                                       //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                                  // clk_reset.reset
		.in_data           (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                           // (terminated)
		.csr_read          (1'b0),                                                                                            // (terminated)
		.csr_write         (1'b0),                                                                                            // (terminated)
		.csr_readdata      (),                                                                                                // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                            // (terminated)
		.almost_full_data  (),                                                                                                // (terminated)
		.almost_empty_data (),                                                                                                // (terminated)
		.in_empty          (1'b0),                                                                                            // (terminated)
		.out_empty         (),                                                                                                // (terminated)
		.in_error          (1'b0),                                                                                            // (terminated)
		.out_error         (),                                                                                                // (terminated)
		.in_channel        (1'b0),                                                                                            // (terminated)
		.out_channel       ()                                                                                                 // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sequencer_ram_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                             //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                        //       clk_reset.reset
		.m0_address              (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src2_ready),                                                         //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src2_valid),                                                         //                .valid
		.cp_data                 (cmd_xbar_demux_001_src2_data),                                                          //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src2_startofpacket),                                                 //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src2_endofpacket),                                                   //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src2_channel),                                                       //                .channel
		.rf_sink_ready           (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                             //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                        // clk_reset.reset
		.in_data           (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                 // (terminated)
		.csr_read          (1'b0),                                                                                  // (terminated)
		.csr_write         (1'b0),                                                                                  // (terminated)
		.csr_readdata      (),                                                                                      // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                  // (terminated)
		.almost_full_data  (),                                                                                      // (terminated)
		.almost_empty_data (),                                                                                      // (terminated)
		.in_empty          (1'b0),                                                                                  // (terminated)
		.out_empty         (),                                                                                      // (terminated)
		.in_error          (1'b0),                                                                                  // (terminated)
		.out_error         (),                                                                                      // (terminated)
		.in_channel        (1'b0),                                                                                  // (terminated)
		.out_channel       ()                                                                                       // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                                      //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                                 //       clk_reset.reset
		.m0_address              (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src3_ready),                                                                  //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src3_valid),                                                                  //                .valid
		.cp_data                 (cmd_xbar_demux_001_src3_data),                                                                   //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src3_startofpacket),                                                          //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src3_endofpacket),                                                            //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src3_channel),                                                                //                .channel
		.rf_sink_ready           (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                                      //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                                 // clk_reset.reset
		.in_data           (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                          // (terminated)
		.csr_read          (1'b0),                                                                                           // (terminated)
		.csr_write         (1'b0),                                                                                           // (terminated)
		.csr_readdata      (),                                                                                               // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                           // (terminated)
		.almost_full_data  (),                                                                                               // (terminated)
		.almost_empty_data (),                                                                                               // (terminated)
		.in_empty          (1'b0),                                                                                           // (terminated)
		.out_empty         (),                                                                                               // (terminated)
		.in_error          (1'b0),                                                                                           // (terminated)
		.out_error         (),                                                                                               // (terminated)
		.in_channel        (1'b0),                                                                                           // (terminated)
		.out_channel       ()                                                                                                // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                                       //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                                  //       clk_reset.reset
		.m0_address              (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src4_ready),                                                                   //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src4_valid),                                                                   //                .valid
		.cp_data                 (cmd_xbar_demux_001_src4_data),                                                                    //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src4_startofpacket),                                                           //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src4_endofpacket),                                                             //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src4_channel),                                                                 //                .channel
		.rf_sink_ready           (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                                       //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                                  // clk_reset.reset
		.in_data           (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                           // (terminated)
		.csr_read          (1'b0),                                                                                            // (terminated)
		.csr_write         (1'b0),                                                                                            // (terminated)
		.csr_readdata      (),                                                                                                // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                            // (terminated)
		.almost_full_data  (),                                                                                                // (terminated)
		.almost_empty_data (),                                                                                                // (terminated)
		.in_empty          (1'b0),                                                                                            // (terminated)
		.out_empty         (),                                                                                                // (terminated)
		.in_error          (1'b0),                                                                                            // (terminated)
		.out_error         (),                                                                                                // (terminated)
		.in_channel        (1'b0),                                                                                            // (terminated)
		.out_channel       ()                                                                                                 // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                                        //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                                   //       clk_reset.reset
		.m0_address              (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src5_ready),                                                                    //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src5_valid),                                                                    //                .valid
		.cp_data                 (cmd_xbar_demux_001_src5_data),                                                                     //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src5_startofpacket),                                                            //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src5_endofpacket),                                                              //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src5_channel),                                                                  //                .channel
		.rf_sink_ready           (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                                        //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                                   // clk_reset.reset
		.in_data           (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                            // (terminated)
		.csr_read          (1'b0),                                                                                             // (terminated)
		.csr_write         (1'b0),                                                                                             // (terminated)
		.csr_readdata      (),                                                                                                 // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                             // (terminated)
		.almost_full_data  (),                                                                                                 // (terminated)
		.almost_empty_data (),                                                                                                 // (terminated)
		.in_empty          (1'b0),                                                                                             // (terminated)
		.out_empty         (),                                                                                                 // (terminated)
		.in_error          (1'b0),                                                                                             // (terminated)
		.out_error         (),                                                                                                 // (terminated)
		.in_channel        (1'b0),                                                                                             // (terminated)
		.out_channel       ()                                                                                                  // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                                       //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                                  //       clk_reset.reset
		.m0_address              (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src6_ready),                                                                   //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src6_valid),                                                                   //                .valid
		.cp_data                 (cmd_xbar_demux_001_src6_data),                                                                    //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src6_startofpacket),                                                           //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src6_endofpacket),                                                             //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src6_channel),                                                                 //                .channel
		.rf_sink_ready           (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                                       //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                                  // clk_reset.reset
		.in_data           (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                           // (terminated)
		.csr_read          (1'b0),                                                                                            // (terminated)
		.csr_write         (1'b0),                                                                                            // (terminated)
		.csr_readdata      (),                                                                                                // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                            // (terminated)
		.almost_full_data  (),                                                                                                // (terminated)
		.almost_empty_data (),                                                                                                // (terminated)
		.in_empty          (1'b0),                                                                                            // (terminated)
		.out_empty         (),                                                                                                // (terminated)
		.in_error          (1'b0),                                                                                            // (terminated)
		.out_error         (),                                                                                                // (terminated)
		.in_channel        (1'b0),                                                                                            // (terminated)
		.out_channel       ()                                                                                                 // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (66),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (54),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (55),
		.PKT_TRANS_POSTED          (56),
		.PKT_TRANS_WRITE           (57),
		.PKT_TRANS_READ            (58),
		.PKT_TRANS_LOCK            (59),
		.PKT_SRC_ID_H              (70),
		.PKT_SRC_ID_L              (67),
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_BURSTWRAP_H           (65),
		.PKT_BURSTWRAP_L           (63),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_PROTECTION_H          (75),
		.PKT_PROTECTION_L          (75),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (76),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent (
		.clk                     (clock_clk),                                                                                       //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                                  //       clk_reset.reset
		.m0_address              (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src7_ready),                                                                   //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src7_valid),                                                                   //                .valid
		.cp_data                 (cmd_xbar_demux_001_src7_data),                                                                    //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src7_startofpacket),                                                           //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src7_endofpacket),                                                             //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src7_channel),                                                                 //                .channel
		.rf_sink_ready           (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (77),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clock_clk),                                                                                       //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                                  // clk_reset.reset
		.in_data           (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                           // (terminated)
		.csr_read          (1'b0),                                                                                            // (terminated)
		.csr_write         (1'b0),                                                                                            // (terminated)
		.csr_readdata      (),                                                                                                // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                            // (terminated)
		.almost_full_data  (),                                                                                                // (terminated)
		.almost_empty_data (),                                                                                                // (terminated)
		.in_empty          (1'b0),                                                                                            // (terminated)
		.out_empty         (),                                                                                                // (terminated)
		.in_error          (1'b0),                                                                                            // (terminated)
		.out_error         (),                                                                                                // (terminated)
		.in_channel        (1'b0),                                                                                            // (terminated)
		.out_channel       ()                                                                                                 // (terminated)
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_addr_router addr_router (
		.sink_ready         (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_inst_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                               //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                          // clk_reset.reset
		.src_ready          (addr_router_src_ready),                                                                   //       src.ready
		.src_valid          (addr_router_src_valid),                                                                   //          .valid
		.src_data           (addr_router_src_data),                                                                    //          .data
		.src_channel        (addr_router_src_channel),                                                                 //          .channel
		.src_startofpacket  (addr_router_src_startofpacket),                                                           //          .startofpacket
		.src_endofpacket    (addr_router_src_endofpacket)                                                              //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_addr_router_001 addr_router_001 (
		.sink_ready         (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_inst_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                        //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                   // clk_reset.reset
		.src_ready          (addr_router_001_src_ready),                                                        //       src.ready
		.src_valid          (addr_router_001_src_valid),                                                        //          .valid
		.src_data           (addr_router_001_src_data),                                                         //          .data
		.src_channel        (addr_router_001_src_channel),                                                      //          .channel
		.src_startofpacket  (addr_router_001_src_startofpacket),                                                //          .startofpacket
		.src_endofpacket    (addr_router_001_src_endofpacket)                                                   //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router id_router (
		.sink_ready         (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sequencer_rom_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                   //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                              // clk_reset.reset
		.src_ready          (id_router_src_ready),                                                         //       src.ready
		.src_valid          (id_router_src_valid),                                                         //          .valid
		.src_data           (id_router_src_data),                                                          //          .data
		.src_channel        (id_router_src_channel),                                                       //          .channel
		.src_startofpacket  (id_router_src_startofpacket),                                                 //          .startofpacket
		.src_endofpacket    (id_router_src_endofpacket)                                                    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router id_router_001 (
		.sink_ready         (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_inst_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                        // clk_reset.reset
		.src_ready          (id_router_001_src_ready),                                                               //       src.ready
		.src_valid          (id_router_001_src_valid),                                                               //          .valid
		.src_data           (id_router_001_src_data),                                                                //          .data
		.src_channel        (id_router_001_src_channel),                                                             //          .channel
		.src_startofpacket  (id_router_001_src_startofpacket),                                                       //          .startofpacket
		.src_endofpacket    (id_router_001_src_endofpacket)                                                          //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router_002 id_router_002 (
		.sink_ready         (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sequencer_ram_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                   //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                              // clk_reset.reset
		.src_ready          (id_router_002_src_ready),                                                     //       src.ready
		.src_valid          (id_router_002_src_valid),                                                     //          .valid
		.src_data           (id_router_002_src_data),                                                      //          .data
		.src_channel        (id_router_002_src_channel),                                                   //          .channel
		.src_startofpacket  (id_router_002_src_startofpacket),                                             //          .startofpacket
		.src_endofpacket    (id_router_002_src_endofpacket)                                                //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router_002 id_router_003 (
		.sink_ready         (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sequencer_rw_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                            //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                       // clk_reset.reset
		.src_ready          (id_router_003_src_ready),                                                              //       src.ready
		.src_valid          (id_router_003_src_valid),                                                              //          .valid
		.src_data           (id_router_003_src_data),                                                               //          .data
		.src_channel        (id_router_003_src_channel),                                                            //          .channel
		.src_startofpacket  (id_router_003_src_startofpacket),                                                      //          .startofpacket
		.src_endofpacket    (id_router_003_src_endofpacket)                                                         //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router_002 id_router_004 (
		.sink_ready         (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sequencer_phy_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                        // clk_reset.reset
		.src_ready          (id_router_004_src_ready),                                                               //       src.ready
		.src_valid          (id_router_004_src_valid),                                                               //          .valid
		.src_data           (id_router_004_src_data),                                                                //          .data
		.src_channel        (id_router_004_src_channel),                                                             //          .channel
		.src_startofpacket  (id_router_004_src_startofpacket),                                                       //          .startofpacket
		.src_endofpacket    (id_router_004_src_endofpacket)                                                          //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router_002 id_router_005 (
		.sink_ready         (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sequencer_data_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                              //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                         // clk_reset.reset
		.src_ready          (id_router_005_src_ready),                                                                //       src.ready
		.src_valid          (id_router_005_src_valid),                                                                //          .valid
		.src_data           (id_router_005_src_data),                                                                 //          .data
		.src_channel        (id_router_005_src_channel),                                                              //          .channel
		.src_startofpacket  (id_router_005_src_startofpacket),                                                        //          .startofpacket
		.src_endofpacket    (id_router_005_src_endofpacket)                                                           //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router_002 id_router_006 (
		.sink_ready         (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sequencer_ptr_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                        // clk_reset.reset
		.src_ready          (id_router_006_src_ready),                                                               //       src.ready
		.src_valid          (id_router_006_src_valid),                                                               //          .valid
		.src_data           (id_router_006_src_data),                                                                //          .data
		.src_channel        (id_router_006_src_channel),                                                             //          .channel
		.src_startofpacket  (id_router_006_src_startofpacket),                                                       //          .startofpacket
		.src_endofpacket    (id_router_006_src_endofpacket)                                                          //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_id_router_002 id_router_007 (
		.sink_ready         (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sequencer_scc_mgr_inst_avl_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clock_clk),                                                                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                        // clk_reset.reset
		.src_ready          (id_router_007_src_ready),                                                               //       src.ready
		.src_valid          (id_router_007_src_valid),                                                               //          .valid
		.src_data           (id_router_007_src_data),                                                                //          .data
		.src_channel        (id_router_007_src_channel),                                                             //          .channel
		.src_startofpacket  (id_router_007_src_startofpacket),                                                       //          .startofpacket
		.src_endofpacket    (id_router_007_src_endofpacket)                                                          //          .endofpacket
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_TRANS_POSTED          (56),
		.MAX_OUTSTANDING_RESPONSES (5),
		.PIPELINED                 (0),
		.ST_DATA_W                 (76),
		.ST_CHANNEL_W              (8),
		.VALID_WIDTH               (8),
		.ENFORCE_ORDER             (0),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter (
		.clk                    (clock_clk),                      //       clk.clk
		.reset                  (rst_controller_reset_out_reset), // clk_reset.reset
		.cmd_sink_ready         (addr_router_src_ready),          //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_src_valid),          //          .valid
		.cmd_sink_data          (addr_router_src_data),           //          .data
		.cmd_sink_channel       (addr_router_src_channel),        //          .channel
		.cmd_sink_startofpacket (addr_router_src_startofpacket),  //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_src_endofpacket),    //          .endofpacket
		.cmd_src_ready          (limiter_cmd_src_ready),          //   cmd_src.ready
		.cmd_src_data           (limiter_cmd_src_data),           //          .data
		.cmd_src_channel        (limiter_cmd_src_channel),        //          .channel
		.cmd_src_startofpacket  (limiter_cmd_src_startofpacket),  //          .startofpacket
		.cmd_src_endofpacket    (limiter_cmd_src_endofpacket),    //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_src_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_src_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_src_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_mux_src_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_src_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_src_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_rsp_src_ready),          //   rsp_src.ready
		.rsp_src_valid          (limiter_rsp_src_valid),          //          .valid
		.rsp_src_data           (limiter_rsp_src_data),           //          .data
		.rsp_src_channel        (limiter_rsp_src_channel),        //          .channel
		.rsp_src_startofpacket  (limiter_rsp_src_startofpacket),  //          .startofpacket
		.rsp_src_endofpacket    (limiter_rsp_src_endofpacket),    //          .endofpacket
		.cmd_src_valid          (limiter_cmd_valid_data)          // cmd_valid.data
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (74),
		.PKT_DEST_ID_L             (71),
		.PKT_TRANS_POSTED          (56),
		.MAX_OUTSTANDING_RESPONSES (5),
		.PIPELINED                 (0),
		.ST_DATA_W                 (76),
		.ST_CHANNEL_W              (8),
		.VALID_WIDTH               (8),
		.ENFORCE_ORDER             (0),
		.PKT_BYTE_CNT_H            (62),
		.PKT_BYTE_CNT_L            (60),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter_001 (
		.clk                    (clock_clk),                          //       clk.clk
		.reset                  (rst_controller_reset_out_reset),     // clk_reset.reset
		.cmd_sink_ready         (addr_router_001_src_ready),          //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_001_src_valid),          //          .valid
		.cmd_sink_data          (addr_router_001_src_data),           //          .data
		.cmd_sink_channel       (addr_router_001_src_channel),        //          .channel
		.cmd_sink_startofpacket (addr_router_001_src_startofpacket),  //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_001_src_endofpacket),    //          .endofpacket
		.cmd_src_ready          (limiter_001_cmd_src_ready),          //   cmd_src.ready
		.cmd_src_data           (limiter_001_cmd_src_data),           //          .data
		.cmd_src_channel        (limiter_001_cmd_src_channel),        //          .channel
		.cmd_src_startofpacket  (limiter_001_cmd_src_startofpacket),  //          .startofpacket
		.cmd_src_endofpacket    (limiter_001_cmd_src_endofpacket),    //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_001_src_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_001_src_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_001_src_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_mux_001_src_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_001_src_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_001_src_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_001_rsp_src_ready),          //   rsp_src.ready
		.rsp_src_valid          (limiter_001_rsp_src_valid),          //          .valid
		.rsp_src_data           (limiter_001_rsp_src_data),           //          .data
		.rsp_src_channel        (limiter_001_rsp_src_channel),        //          .channel
		.rsp_src_startofpacket  (limiter_001_rsp_src_startofpacket),  //          .startofpacket
		.rsp_src_endofpacket    (limiter_001_rsp_src_endofpacket),    //          .endofpacket
		.cmd_src_valid          (limiter_001_cmd_valid_data)          // cmd_valid.data
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~reset_reset_n),                 // reset_in0.reset
		.clk        (clock_clk),                      //       clk.clk
		.reset_out  (rst_controller_reset_out_reset), // reset_out.reset
		.reset_in1  (1'b0),                           // (terminated)
		.reset_in2  (1'b0),                           // (terminated)
		.reset_in3  (1'b0),                           // (terminated)
		.reset_in4  (1'b0),                           // (terminated)
		.reset_in5  (1'b0),                           // (terminated)
		.reset_in6  (1'b0),                           // (terminated)
		.reset_in7  (1'b0),                           // (terminated)
		.reset_in8  (1'b0),                           // (terminated)
		.reset_in9  (1'b0),                           // (terminated)
		.reset_in10 (1'b0),                           // (terminated)
		.reset_in11 (1'b0),                           // (terminated)
		.reset_in12 (1'b0),                           // (terminated)
		.reset_in13 (1'b0),                           // (terminated)
		.reset_in14 (1'b0),                           // (terminated)
		.reset_in15 (1'b0)                            // (terminated)
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_cmd_xbar_demux cmd_xbar_demux (
		.clk                (clock_clk),                         //        clk.clk
		.reset              (rst_controller_reset_out_reset),    //  clk_reset.reset
		.sink_ready         (limiter_cmd_src_ready),             //       sink.ready
		.sink_channel       (limiter_cmd_src_channel),           //           .channel
		.sink_data          (limiter_cmd_src_data),              //           .data
		.sink_startofpacket (limiter_cmd_src_startofpacket),     //           .startofpacket
		.sink_endofpacket   (limiter_cmd_src_endofpacket),       //           .endofpacket
		.sink_valid         (limiter_cmd_valid_data),            // sink_valid.data
		.src0_ready         (cmd_xbar_demux_src0_ready),         //       src0.ready
		.src0_valid         (cmd_xbar_demux_src0_valid),         //           .valid
		.src0_data          (cmd_xbar_demux_src0_data),          //           .data
		.src0_channel       (cmd_xbar_demux_src0_channel),       //           .channel
		.src0_startofpacket (cmd_xbar_demux_src0_startofpacket), //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_src0_endofpacket),   //           .endofpacket
		.src1_ready         (cmd_xbar_demux_src1_ready),         //       src1.ready
		.src1_valid         (cmd_xbar_demux_src1_valid),         //           .valid
		.src1_data          (cmd_xbar_demux_src1_data),          //           .data
		.src1_channel       (cmd_xbar_demux_src1_channel),       //           .channel
		.src1_startofpacket (cmd_xbar_demux_src1_startofpacket), //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_src1_endofpacket)    //           .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_cmd_xbar_demux_001 cmd_xbar_demux_001 (
		.clk                (clock_clk),                             //        clk.clk
		.reset              (rst_controller_reset_out_reset),        //  clk_reset.reset
		.sink_ready         (limiter_001_cmd_src_ready),             //       sink.ready
		.sink_channel       (limiter_001_cmd_src_channel),           //           .channel
		.sink_data          (limiter_001_cmd_src_data),              //           .data
		.sink_startofpacket (limiter_001_cmd_src_startofpacket),     //           .startofpacket
		.sink_endofpacket   (limiter_001_cmd_src_endofpacket),       //           .endofpacket
		.sink_valid         (limiter_001_cmd_valid_data),            // sink_valid.data
		.src0_ready         (cmd_xbar_demux_001_src0_ready),         //       src0.ready
		.src0_valid         (cmd_xbar_demux_001_src0_valid),         //           .valid
		.src0_data          (cmd_xbar_demux_001_src0_data),          //           .data
		.src0_channel       (cmd_xbar_demux_001_src0_channel),       //           .channel
		.src0_startofpacket (cmd_xbar_demux_001_src0_startofpacket), //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_001_src0_endofpacket),   //           .endofpacket
		.src1_ready         (cmd_xbar_demux_001_src1_ready),         //       src1.ready
		.src1_valid         (cmd_xbar_demux_001_src1_valid),         //           .valid
		.src1_data          (cmd_xbar_demux_001_src1_data),          //           .data
		.src1_channel       (cmd_xbar_demux_001_src1_channel),       //           .channel
		.src1_startofpacket (cmd_xbar_demux_001_src1_startofpacket), //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_001_src1_endofpacket),   //           .endofpacket
		.src2_ready         (cmd_xbar_demux_001_src2_ready),         //       src2.ready
		.src2_valid         (cmd_xbar_demux_001_src2_valid),         //           .valid
		.src2_data          (cmd_xbar_demux_001_src2_data),          //           .data
		.src2_channel       (cmd_xbar_demux_001_src2_channel),       //           .channel
		.src2_startofpacket (cmd_xbar_demux_001_src2_startofpacket), //           .startofpacket
		.src2_endofpacket   (cmd_xbar_demux_001_src2_endofpacket),   //           .endofpacket
		.src3_ready         (cmd_xbar_demux_001_src3_ready),         //       src3.ready
		.src3_valid         (cmd_xbar_demux_001_src3_valid),         //           .valid
		.src3_data          (cmd_xbar_demux_001_src3_data),          //           .data
		.src3_channel       (cmd_xbar_demux_001_src3_channel),       //           .channel
		.src3_startofpacket (cmd_xbar_demux_001_src3_startofpacket), //           .startofpacket
		.src3_endofpacket   (cmd_xbar_demux_001_src3_endofpacket),   //           .endofpacket
		.src4_ready         (cmd_xbar_demux_001_src4_ready),         //       src4.ready
		.src4_valid         (cmd_xbar_demux_001_src4_valid),         //           .valid
		.src4_data          (cmd_xbar_demux_001_src4_data),          //           .data
		.src4_channel       (cmd_xbar_demux_001_src4_channel),       //           .channel
		.src4_startofpacket (cmd_xbar_demux_001_src4_startofpacket), //           .startofpacket
		.src4_endofpacket   (cmd_xbar_demux_001_src4_endofpacket),   //           .endofpacket
		.src5_ready         (cmd_xbar_demux_001_src5_ready),         //       src5.ready
		.src5_valid         (cmd_xbar_demux_001_src5_valid),         //           .valid
		.src5_data          (cmd_xbar_demux_001_src5_data),          //           .data
		.src5_channel       (cmd_xbar_demux_001_src5_channel),       //           .channel
		.src5_startofpacket (cmd_xbar_demux_001_src5_startofpacket), //           .startofpacket
		.src5_endofpacket   (cmd_xbar_demux_001_src5_endofpacket),   //           .endofpacket
		.src6_ready         (cmd_xbar_demux_001_src6_ready),         //       src6.ready
		.src6_valid         (cmd_xbar_demux_001_src6_valid),         //           .valid
		.src6_data          (cmd_xbar_demux_001_src6_data),          //           .data
		.src6_channel       (cmd_xbar_demux_001_src6_channel),       //           .channel
		.src6_startofpacket (cmd_xbar_demux_001_src6_startofpacket), //           .startofpacket
		.src6_endofpacket   (cmd_xbar_demux_001_src6_endofpacket),   //           .endofpacket
		.src7_ready         (cmd_xbar_demux_001_src7_ready),         //       src7.ready
		.src7_valid         (cmd_xbar_demux_001_src7_valid),         //           .valid
		.src7_data          (cmd_xbar_demux_001_src7_data),          //           .data
		.src7_channel       (cmd_xbar_demux_001_src7_channel),       //           .channel
		.src7_startofpacket (cmd_xbar_demux_001_src7_startofpacket), //           .startofpacket
		.src7_endofpacket   (cmd_xbar_demux_001_src7_endofpacket)    //           .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_cmd_xbar_mux cmd_xbar_mux (
		.clk                 (clock_clk),                             //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (cmd_xbar_mux_src_ready),                //       src.ready
		.src_valid           (cmd_xbar_mux_src_valid),                //          .valid
		.src_data            (cmd_xbar_mux_src_data),                 //          .data
		.src_channel         (cmd_xbar_mux_src_channel),              //          .channel
		.src_startofpacket   (cmd_xbar_mux_src_startofpacket),        //          .startofpacket
		.src_endofpacket     (cmd_xbar_mux_src_endofpacket),          //          .endofpacket
		.sink0_ready         (cmd_xbar_demux_src0_ready),             //     sink0.ready
		.sink0_valid         (cmd_xbar_demux_src0_valid),             //          .valid
		.sink0_channel       (cmd_xbar_demux_src0_channel),           //          .channel
		.sink0_data          (cmd_xbar_demux_src0_data),              //          .data
		.sink0_startofpacket (cmd_xbar_demux_src0_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (cmd_xbar_demux_src0_endofpacket),       //          .endofpacket
		.sink1_ready         (cmd_xbar_demux_001_src0_ready),         //     sink1.ready
		.sink1_valid         (cmd_xbar_demux_001_src0_valid),         //          .valid
		.sink1_channel       (cmd_xbar_demux_001_src0_channel),       //          .channel
		.sink1_data          (cmd_xbar_demux_001_src0_data),          //          .data
		.sink1_startofpacket (cmd_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (cmd_xbar_demux_001_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_cmd_xbar_mux cmd_xbar_mux_001 (
		.clk                 (clock_clk),                             //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (cmd_xbar_mux_001_src_ready),            //       src.ready
		.src_valid           (cmd_xbar_mux_001_src_valid),            //          .valid
		.src_data            (cmd_xbar_mux_001_src_data),             //          .data
		.src_channel         (cmd_xbar_mux_001_src_channel),          //          .channel
		.src_startofpacket   (cmd_xbar_mux_001_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (cmd_xbar_mux_001_src_endofpacket),      //          .endofpacket
		.sink0_ready         (cmd_xbar_demux_src1_ready),             //     sink0.ready
		.sink0_valid         (cmd_xbar_demux_src1_valid),             //          .valid
		.sink0_channel       (cmd_xbar_demux_src1_channel),           //          .channel
		.sink0_data          (cmd_xbar_demux_src1_data),              //          .data
		.sink0_startofpacket (cmd_xbar_demux_src1_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (cmd_xbar_demux_src1_endofpacket),       //          .endofpacket
		.sink1_ready         (cmd_xbar_demux_001_src1_ready),         //     sink1.ready
		.sink1_valid         (cmd_xbar_demux_001_src1_valid),         //          .valid
		.sink1_channel       (cmd_xbar_demux_001_src1_channel),       //          .channel
		.sink1_data          (cmd_xbar_demux_001_src1_data),          //          .data
		.sink1_startofpacket (cmd_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.sink1_endofpacket   (cmd_xbar_demux_001_src1_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux rsp_xbar_demux (
		.clk                (clock_clk),                         //       clk.clk
		.reset              (rst_controller_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_src_ready),               //      sink.ready
		.sink_channel       (id_router_src_channel),             //          .channel
		.sink_data          (id_router_src_data),                //          .data
		.sink_startofpacket (id_router_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_src0_endofpacket),   //          .endofpacket
		.src1_ready         (rsp_xbar_demux_src1_ready),         //      src1.ready
		.src1_valid         (rsp_xbar_demux_src1_valid),         //          .valid
		.src1_data          (rsp_xbar_demux_src1_data),          //          .data
		.src1_channel       (rsp_xbar_demux_src1_channel),       //          .channel
		.src1_startofpacket (rsp_xbar_demux_src1_startofpacket), //          .startofpacket
		.src1_endofpacket   (rsp_xbar_demux_src1_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux rsp_xbar_demux_001 (
		.clk                (clock_clk),                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_001_src_ready),               //      sink.ready
		.sink_channel       (id_router_001_src_channel),             //          .channel
		.sink_data          (id_router_001_src_data),                //          .data
		.sink_startofpacket (id_router_001_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_001_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_001_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_001_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_001_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_001_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_001_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_001_src0_endofpacket),   //          .endofpacket
		.src1_ready         (rsp_xbar_demux_001_src1_ready),         //      src1.ready
		.src1_valid         (rsp_xbar_demux_001_src1_valid),         //          .valid
		.src1_data          (rsp_xbar_demux_001_src1_data),          //          .data
		.src1_channel       (rsp_xbar_demux_001_src1_channel),       //          .channel
		.src1_startofpacket (rsp_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.src1_endofpacket   (rsp_xbar_demux_001_src1_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux_002 rsp_xbar_demux_002 (
		.clk                (clock_clk),                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_002_src_ready),               //      sink.ready
		.sink_channel       (id_router_002_src_channel),             //          .channel
		.sink_data          (id_router_002_src_data),                //          .data
		.sink_startofpacket (id_router_002_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_002_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_002_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_002_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_002_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux_002 rsp_xbar_demux_003 (
		.clk                (clock_clk),                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_003_src_ready),               //      sink.ready
		.sink_channel       (id_router_003_src_channel),             //          .channel
		.sink_data          (id_router_003_src_data),                //          .data
		.sink_startofpacket (id_router_003_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_003_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_003_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_003_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_003_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_003_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_003_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_003_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_003_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux_002 rsp_xbar_demux_004 (
		.clk                (clock_clk),                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_004_src_ready),               //      sink.ready
		.sink_channel       (id_router_004_src_channel),             //          .channel
		.sink_data          (id_router_004_src_data),                //          .data
		.sink_startofpacket (id_router_004_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_004_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_004_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_004_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_004_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_004_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_004_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_004_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_004_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux_002 rsp_xbar_demux_005 (
		.clk                (clock_clk),                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_005_src_ready),               //      sink.ready
		.sink_channel       (id_router_005_src_channel),             //          .channel
		.sink_data          (id_router_005_src_data),                //          .data
		.sink_startofpacket (id_router_005_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_005_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_005_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_005_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_005_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_005_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_005_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_005_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_005_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux_002 rsp_xbar_demux_006 (
		.clk                (clock_clk),                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_006_src_ready),               //      sink.ready
		.sink_channel       (id_router_006_src_channel),             //          .channel
		.sink_data          (id_router_006_src_data),                //          .data
		.sink_startofpacket (id_router_006_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_006_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_006_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_006_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_006_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_006_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_006_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_006_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_006_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_demux_002 rsp_xbar_demux_007 (
		.clk                (clock_clk),                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_007_src_ready),               //      sink.ready
		.sink_channel       (id_router_007_src_channel),             //          .channel
		.sink_data          (id_router_007_src_data),                //          .data
		.sink_startofpacket (id_router_007_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_007_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_007_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_007_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_007_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_007_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_007_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_007_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_007_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_mux rsp_xbar_mux (
		.clk                 (clock_clk),                             //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (rsp_xbar_mux_src_ready),                //       src.ready
		.src_valid           (rsp_xbar_mux_src_valid),                //          .valid
		.src_data            (rsp_xbar_mux_src_data),                 //          .data
		.src_channel         (rsp_xbar_mux_src_channel),              //          .channel
		.src_startofpacket   (rsp_xbar_mux_src_startofpacket),        //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_src_endofpacket),          //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_src0_ready),             //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_src0_valid),             //          .valid
		.sink0_channel       (rsp_xbar_demux_src0_channel),           //          .channel
		.sink0_data          (rsp_xbar_demux_src0_data),              //          .data
		.sink0_startofpacket (rsp_xbar_demux_src0_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_src0_endofpacket),       //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_001_src0_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_001_src0_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_001_src0_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_001_src0_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_001_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_rsp_xbar_mux_001 rsp_xbar_mux_001 (
		.clk                 (clock_clk),                             //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (rsp_xbar_mux_001_src_ready),            //       src.ready
		.src_valid           (rsp_xbar_mux_001_src_valid),            //          .valid
		.src_data            (rsp_xbar_mux_001_src_data),             //          .data
		.src_channel         (rsp_xbar_mux_001_src_channel),          //          .channel
		.src_startofpacket   (rsp_xbar_mux_001_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_001_src_endofpacket),      //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_src1_ready),             //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_src1_valid),             //          .valid
		.sink0_channel       (rsp_xbar_demux_src1_channel),           //          .channel
		.sink0_data          (rsp_xbar_demux_src1_data),              //          .data
		.sink0_startofpacket (rsp_xbar_demux_src1_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_src1_endofpacket),       //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_001_src1_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_001_src1_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_001_src1_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_001_src1_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_001_src1_endofpacket),   //          .endofpacket
		.sink2_ready         (rsp_xbar_demux_002_src0_ready),         //     sink2.ready
		.sink2_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.sink2_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.sink2_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.sink2_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.sink2_endofpacket   (rsp_xbar_demux_002_src0_endofpacket),   //          .endofpacket
		.sink3_ready         (rsp_xbar_demux_003_src0_ready),         //     sink3.ready
		.sink3_valid         (rsp_xbar_demux_003_src0_valid),         //          .valid
		.sink3_channel       (rsp_xbar_demux_003_src0_channel),       //          .channel
		.sink3_data          (rsp_xbar_demux_003_src0_data),          //          .data
		.sink3_startofpacket (rsp_xbar_demux_003_src0_startofpacket), //          .startofpacket
		.sink3_endofpacket   (rsp_xbar_demux_003_src0_endofpacket),   //          .endofpacket
		.sink4_ready         (rsp_xbar_demux_004_src0_ready),         //     sink4.ready
		.sink4_valid         (rsp_xbar_demux_004_src0_valid),         //          .valid
		.sink4_channel       (rsp_xbar_demux_004_src0_channel),       //          .channel
		.sink4_data          (rsp_xbar_demux_004_src0_data),          //          .data
		.sink4_startofpacket (rsp_xbar_demux_004_src0_startofpacket), //          .startofpacket
		.sink4_endofpacket   (rsp_xbar_demux_004_src0_endofpacket),   //          .endofpacket
		.sink5_ready         (rsp_xbar_demux_005_src0_ready),         //     sink5.ready
		.sink5_valid         (rsp_xbar_demux_005_src0_valid),         //          .valid
		.sink5_channel       (rsp_xbar_demux_005_src0_channel),       //          .channel
		.sink5_data          (rsp_xbar_demux_005_src0_data),          //          .data
		.sink5_startofpacket (rsp_xbar_demux_005_src0_startofpacket), //          .startofpacket
		.sink5_endofpacket   (rsp_xbar_demux_005_src0_endofpacket),   //          .endofpacket
		.sink6_ready         (rsp_xbar_demux_006_src0_ready),         //     sink6.ready
		.sink6_valid         (rsp_xbar_demux_006_src0_valid),         //          .valid
		.sink6_channel       (rsp_xbar_demux_006_src0_channel),       //          .channel
		.sink6_data          (rsp_xbar_demux_006_src0_data),          //          .data
		.sink6_startofpacket (rsp_xbar_demux_006_src0_startofpacket), //          .startofpacket
		.sink6_endofpacket   (rsp_xbar_demux_006_src0_endofpacket),   //          .endofpacket
		.sink7_ready         (rsp_xbar_demux_007_src0_ready),         //     sink7.ready
		.sink7_valid         (rsp_xbar_demux_007_src0_valid),         //          .valid
		.sink7_channel       (rsp_xbar_demux_007_src0_channel),       //          .channel
		.sink7_data          (rsp_xbar_demux_007_src0_data),          //          .data
		.sink7_startofpacket (rsp_xbar_demux_007_src0_startofpacket), //          .startofpacket
		.sink7_endofpacket   (rsp_xbar_demux_007_src0_endofpacket)    //          .endofpacket
	);

	ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_irq_mapper irq_mapper (
		.clk        (clock_clk),                      //       clk.clk
		.reset      (rst_controller_reset_out_reset), // clk_reset.reset
		.sender_irq (cpu_inst_d_irq_irq)              //    sender.irq
	);

endmodule

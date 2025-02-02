project new test.xise

project set "Device Family" "virtex6"

project set "Device" "xc6vlx240t"

project set "Package" "ff1156"

project set "Speed Grade" "-2"

project set "Synthesis Tool" "XST (VHDL/Verilog)"

project set "Simulator" "ISim (VHDL/Verilog)"

xfile add "../rtl/controller/arb_mux.v"
xfile add "../rtl/controller/arb_row_col.v"
xfile add "../rtl/controller/arb_select.v"
xfile add "../rtl/controller/bank_cntrl.v"
xfile add "../rtl/controller/bank_common.v"
xfile add "../rtl/controller/bank_compare.v"
xfile add "../rtl/controller/bank_mach.v"
xfile add "../rtl/controller/bank_queue.v"
xfile add "../rtl/controller/bank_state.v"
xfile add "../rtl/controller/col_mach.v"
xfile add "../rtl/controller/mc.v"
xfile add "../rtl/controller/rank_cntrl.v"
xfile add "../rtl/controller/rank_common.v"
xfile add "../rtl/controller/rank_mach.v"
xfile add "../rtl/controller/round_robin_arb.v"
xfile add "../rtl/ecc/ecc_buf.v"
xfile add "../rtl/ecc/ecc_dec_fix.v"
xfile add "../rtl/ecc/ecc_gen.v"
xfile add "../rtl/ecc/ecc_merge_enc.v"
xfile add "../rtl/ip_top/clk_ibuf.v"
xfile add "../rtl/ip_top/ddr2_ddr3_chipscope.v"
xfile add "../rtl/ip_top/infrastructure.v"
xfile add "../rtl/ip_top/iodelay_ctrl.v"
xfile add "../rtl/ip_top/mem_intfc.v"
xfile add "../rtl/ip_top/memc_ui_top.v"
xfile add "../rtl/ip_top/mig_39_2.v"
xfile add "../rtl/phy/circ_buffer.v"
xfile add "../rtl/phy/phy_ck_iob.v"
xfile add "../rtl/phy/phy_clock_io.v"
xfile add "../rtl/phy/phy_control_io.v"
xfile add "../rtl/phy/phy_data_io.v"
xfile add "../rtl/phy/phy_dly_ctrl.v"
xfile add "../rtl/phy/phy_dm_iob.v"
xfile add "../rtl/phy/phy_dq_iob.v"
xfile add "../rtl/phy/phy_dqs_iob.v"
xfile add "../rtl/phy/phy_init.v"
xfile add "../rtl/phy/phy_pd.v"
xfile add "../rtl/phy/phy_pd_top.v"
xfile add "../rtl/phy/phy_rdclk_gen.v"
xfile add "../rtl/phy/phy_rdctrl_sync.v"
xfile add "../rtl/phy/phy_rddata_sync.v"
xfile add "../rtl/phy/phy_rdlvl.v"
xfile add "../rtl/phy/phy_read.v"
xfile add "../rtl/phy/phy_top.v"
xfile add "../rtl/phy/phy_write.v"
xfile add "../rtl/phy/phy_wrlvl.v"
xfile add "../rtl/phy/rd_bitslip.v"
xfile add "../rtl/ui/ui_cmd.v"
xfile add "../rtl/ui/ui_rd_data.v"
xfile add "../rtl/ui/ui_top.v"
xfile add "../rtl/ui/ui_wr_data.v"

xfile add "mig_39_2.ucf"

project set "Optimization Goal" "Speed" -process "Synthesize - XST"
project set "Optimization Effort" "Normal" -process "Synthesize - XST"
project set "Power Reduction" "False" -process "Synthesize - XST"
project set "Use Synthesis Constraints File" "True" -process "Synthesize - XST"
project set "Synthesis Constraints File" "constraints.xcf" -process "Synthesize - XST"
project set "Library Search Order" "../synth/mig_39_2.lso" -process "Synthesize - XST"
project set "Keep Hierarchy" "No" -process "Synthesize - XST"
project set "Global Optimization Goal" "AllClockNets" -process "Synthesize - XST"
project set "Generate RTL Schematic" "Yes" -process "Synthesize - XST"
project set "Read Cores" "True" -process "Synthesize - XST"
project set "Cores Search Directories" "" -process "Synthesize - XST"
project set "Write Timing Constraints" "False" -process "Synthesize - XST"
project set "Cross Clock Analysis" "False" -process "Synthesize - XST"
project set "Hierarchy Separator" "/" -process "Synthesize - XST"
project set "Bus Delimiter" "<>" -process "Synthesize - XST"
project set "LUT-FF Pairs Utilization Ratio" "100" -process "Synthesize - XST"
project set "BRAM Utilization Ratio" "100" -process "Synthesize - XST"
project set "DSP Utilization Ratio" "100" -process "Synthesize - XST"
project set "Case" "Maintain" -process "Synthesize - XST"
project set "HDL INI File" "" -process "Synthesize - XST"
project set "Verilog Include Directories" "" -process "Synthesize - XST"
project set "Verilog Macros" "" -process "Synthesize - XST"
project set "Other XST Command Line Options" "" -process "Synthesize - XST"
project set "FSM Encoding Algorithm" "Auto" -process "Synthesize - XST"
project set "Safe Implementation" "No" -process "Synthesize - XST"
project set "Case Implementation Style" "None" -process "Synthesize - XST"
project set "FSM Style" "LUT" -process "Synthesize - XST"
project set "RAM Extraction" "True" -process "Synthesize - XST"
project set "RAM Style" "Auto" -process "Synthesize - XST"
project set "ROM Extraction" "True" -process "Synthesize - XST"
project set "ROM Style" "Auto" -process "Synthesize - XST"
project set "Automatic BRAM Packing" "False" -process "Synthesize - XST"
project set "Shift Register Extraction" "True" -process "Synthesize - XST"
project set "Resource Sharing" "True" -process "Synthesize - XST"
project set "Use DSP Block" "Auto" -process "Synthesize - XST"
project set "Asynchronous To Synchronous" "False" -process "Synthesize - XST"
project set "Add I/O Buffers" "True" -process "Synthesize - XST"
project set "Max Fanout" "100000" -process "Synthesize - XST"
project set "Number of Clock Buffers" "32" -process "Synthesize - XST"
project set "Register Duplication" "True" -process "Synthesize - XST"
project set "Equivalent Register Removal" "True" -process "Synthesize - XST"
project set "Register Balancing" "No" -process "Synthesize - XST"
project set "Pack I/O Registers into IOBs" "Auto" -process "Synthesize - XST"
project set "Use Clock Enable" "Auto" -process "Synthesize - XST"
project set "Use Synchronous Set" "Auto" -process "Synthesize - XST"
project set "Use Synchronous Reset" "Auto" -process "Synthesize - XST"
project set "Optimize Instantiated Primitives" "False" -process "Synthesize - XST"

project set "Use LOC Constraints" "True" -process Translate
project set "Netlist Translation Type" "Timestamp" -process Translate
project set "Create I/O Pads from Ports" "False" -process Translate
project set "Allow Unexpanded Blocks" "False" -process Translate
project set "Allow Unmatched LOC Constraints" "False" -process Translate

project set "Placer Effort Level" "High" -process Map
project set "Placer Extra Effort" "Normal" -process Map
project set "Combinatorial Logic Optimization" "False" -process Map
project set "Trim Unconnected Signals" "True" -process Map
project set "Allow Logic Optimization Across Hierarchy" "False" -process Map
project set "Generate Detailed MAP Report" "False" -process Map
project set "Pack I/O Registers/Latches into IOBs" "Off" -process Map
project set "Map Slice Logic into Unused Block RAMs" "False" -process Map
project set "Other Map Command Line Options" "" -process Map

project set "Place And Route Mode" "Route Only" -process "Place & Route"
project set "Place & Route Effort Level (Overall)" "High" -process "Place & Route"
project set "Extra Effort (Highest PAR level only)" "Normal" -process "Place & Route"
project set "Ignore User Timing Constraints" "False" -process "Place & Route"
project set "Generate Asynchronous Delay Report" "False" -process "Place & Route"
project set "Generate Clock Region Report" "False" -process "Place & Route"
project set "Generate Post-Place & Route Simulation Model" "False" -process "Place & Route"
project set "Power Reduction" "False" -process "Place & Route"

project set "Report Type" "Verbose Report" -process "Generate Post-Map Static Timing"
project set "Number of Paths in Error/Verbose Report" "3" -process "Generate Post-Map Static Timing"
project set "Perform Advanced Analysis" "False" -process "Generate Post-Map Static Timing"
project set "Report Unconstrained Paths" "" -process "Generate Post-Map Static Timing"
project set "Report Fastest Path(s) in Each Constraint" "True" -process "Generate Post-Map Static Timing"

project set "Enable Debugging of Serial Mode BitStream" "False" -process "Generate Programming File"
project set "Create Binary Configuration File" "False" -process "Generate Programming File"
project set "Enable Cyclic Redundancy Checking (CRC)" "True" -process "Generate Programming File"
project set "Configuration Rate" "2" -process "Generate Programming File"
project set "Configuration Clk (Configuration Pins)" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin M0" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin M1" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin M2" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin Program" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin Done" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin Init" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin CS" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin DIn" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin Busy" "Pull Up" -process "Generate Programming File"
project set "Configuration Pin RdWr" "Pull Up" -process "Generate Programming File"
project set "JTAG Pin TCK" "Pull Up" -process "Generate Programming File"
project set "JTAG Pin TDI" "Pull Up" -process "Generate Programming File"
project set "JTAG Pin TDO" "Pull Up" -process "Generate Programming File"
project set "JTAG Pin TMS" "Pull Up" -process "Generate Programming File"
project set "Unused IOB Pins" "Pull Down" -process "Generate Programming File"
project set "UserID Code (8 Digit Hexadecimal)" "0xFFFFFFFF" -process "Generate Programming File"
project set "DCI Update Mode" "Quiet" -process "Generate Programming File"
project set "FPGA Start-Up Clock" "CCLK" -process "Generate Programming File"
project set "Done (Output Events)" "Default (4)" -process "Generate Programming File"
project set "Enable Outputs (Output Events)" "Default (5)" -process "Generate Programming File"
project set "Release Write Enable (Output Events)" "Default (6)" -process "Generate Programming File"
project set "Enable Internal Done Pipe" "False" -process "Generate Programming File"
project set "Drive Done Pin High" "False" -process "Generate Programming File"
project set "Security" "Enable Readback and Reconfiguration" -process "Generate Programming File"
project set "Encrypt Bitstream" "False" -process "Generate Programming File"

project close

view structure
view signals
view wave
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {System Signals}
add wave -noupdate -format Logic /testbench/reset
add wave -noupdate -format Logic /testbench/gtx_clk
add wave -noupdate -format Logic /testbench/host_clk
add wave -noupdate -divider {Tx Client Interface}
add wave -noupdate -label tx_client_clk -format Logic /testbench/dut/tx_clk
add wave -noupdate -format Literal -hex /testbench/dut/v6_emac_v1_3_locallink_inst/tx_data_i
add wave -noupdate -format Logic /testbench/dut/v6_emac_v1_3_locallink_inst/tx_data_valid_i
add wave -noupdate -format Logic /testbench/dut/v6_emac_v1_3_locallink_inst/tx_ack_i
add wave -noupdate -format Literal -hex /testbench/tx_ifg_delay
add wave -noupdate -divider {Rx Client Interface}
add wave -noupdate -label rx_client_clk -format Logic /testbench/dut/rx_clk_i
add wave -noupdate -format Literal -hex /testbench/dut/v6_emac_v1_3_locallink_inst/rx_data_i
add wave -noupdate -format Logic /testbench/dut/v6_emac_v1_3_locallink_inst/rx_data_valid_i
add wave -noupdate -format Logic /testbench/dut/v6_emac_v1_3_locallink_inst/rx_good_frame_i
add wave -noupdate -format Logic /testbench/dut/v6_emac_v1_3_locallink_inst/rx_bad_frame_i
add wave -noupdate -divider {Flow Control}
add wave -noupdate -format Literal -hex /testbench/pause_val
add wave -noupdate -format Logic /testbench/pause_req
add wave -noupdate -divider {Tx GMII/MII Interface}
add wave -noupdate -format Logic /testbench/gmii_tx_clk
add wave -noupdate -format Literal -hex /testbench/gmii_txd
add wave -noupdate -format Logic /testbench/gmii_tx_en
add wave -noupdate -format Logic /testbench/gmii_tx_er
add wave -noupdate -divider {Rx GMII/MII Interface}
add wave -noupdate -format Logic /testbench/gmii_rx_clk
add wave -noupdate -format Literal -hex /testbench/gmii_rxd
add wave -noupdate -format Logic /testbench/gmii_rx_dv
add wave -noupdate -format Logic /testbench/gmii_rx_er
add wave -noupdate -divider {MDIO Interface}
add wave -noupdate -format Logic /testbench/mdc
add wave -noupdate -format Logic /testbench/mdio_in
add wave -noupdate -format Logic /testbench/mdio_out
add wave -noupdate -format Logic /testbench/mdio_tri
add wave -noupdate -divider {Management Interface}
add wave -noupdate -format Logic /testbench/host_clk
add wave -noupdate -format Literal -binary /testbench/host_opcode
add wave -noupdate -format Literal -hex /testbench/host_addr
add wave -noupdate -format Literal -hex /testbench/host_wr_data
add wave -noupdate -format Literal -hex /testbench/host_rd_data
add wave -noupdate -format Logic /testbench/host_miim_sel
add wave -noupdate -format Logic /testbench/host_req
add wave -noupdate -format Logic /testbench/host_miim_rdy
add wave -noupdate -divider {Test semaphores}
add wave -noupdate -format Logic /testbench/configuration_busy
add wave -noupdate -format Logic /testbench/monitor_finished_1g
add wave -noupdate -format Logic /testbench/monitor_finished_100m
add wave -noupdate -format Logic /testbench/monitor_finished_10m
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
WaveRestoreZoom {0 ps} {4310754 ps}

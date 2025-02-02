// ddrOutTest.v
// Copyright (c) 2010 Atomic Rules LLC, ALL RIGHTS RESERVED
// Test Case to debug constraints
// 2010-01-14 ssiegel Creation
// 2010-01-15 ssiegel Specialaized for Slave-Drive role
// 2010-01-18 ssiegel Improved OSERDES Reset Synchronizer
// 2010-01-25 ssiegel Tweaked DCM_ADV parameters after reviewing TRCE results

module ddrOutTest#(
  parameter nbo         = 12, 
  parameter i2o         = 4, 
  parameter nbi         = nbo*i2o)
( input               ddrClkP, ddrClkN,
  input               dcmResetN, 
  output              dcmLocked, 
  output              dp,dn, 
);

wire di[3:0], da, ddrClk;

IBUFDS#(.IOSTANDARD("LVDS_25")) ibufds_i(.O(ddrClk),.I(ddrClkP),.IB(ddrClkN));

// DCM and BUFGs...
  DCM_ADV #(
    .CLKDV_DIVIDE(2.0),            // Divide by: 1.5,2.0,2.5...
    .CLKFX_DIVIDE(4),              // Can be any integer from 1 to 32
    .CLKFX_MULTIPLY(2),            // Can be any integer from 2 to 32
    .CLKIN_DIVIDE_BY_2("FALSE"),   // TRUE/FALSE to enable CLKIN divide by two feature
    //.CLKIN_PERIOD(4.0),            // 250 MHz: Specify period of input clock in ns from 1.25 to 1000.00
    .CLKIN_PERIOD(8.0),            // 125 MHz: Specify period of input clock in ns from 1.25 to 1000.00
    .CLKOUT_PHASE_SHIFT("FIXED"),  // Phaseshift of NONE,FIXED,VARIABLE_POSITIVE,VARIABLE_CENTER,DIRECT
    .CLK_FEEDBACK("1X"),           // Specify clock feedback of NONE, 1X or 2X
    .DCM_PERFORMANCE_MODE("MAX_SPEED"),   // Can be MAX_SPEED or MAX_RANGE
    .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or an integer from 0 to 15
    .DFS_FREQUENCY_MODE("HIGH"),          // HIGH or LOW frequency mode for frequency synthesis
    .DLL_FREQUENCY_MODE("HIGH"),          // LOW, HIGH, or HIGH_SER frequency mode for DLL
    .DUTY_CYCLE_CORRECTION("TRUE"),       // Duty cycle correction, "TRUE"/"FALSE"
    .FACTORY_JF(16'hf0f0),                // FACTORY JF value suggested to be set to 16’hf0f0
    .PHASE_SHIFT(-128),            // Amount of fixed phase shift from -255 to 1023
    .SIM_DEVICE("VIRTEX5"),        // Set target device, "VIRTEX4" or "VIRTEX5"
    .STARTUP_WAIT("FALSE")         // Delay configuration DONE until DCM LOCK, "TRUE"/"FALSE"
  ) DCM_ADV_inst (
    .CLK0(dcm_out),               // 0 degree DCM CLK output
    .CLK180(),                    // 180 degree DCM CLK output
    .CLK270(),                    // 270 degree DCM CLK output
    .CLK2X(),                     // 2X DCM CLK output
    .CLK2X180(),                  // 2X, 180 degree DCM CLK out
    .CLK90(),                     // 90 degree DCM CLK output
    .CLKDV(dcm_div),              // Divided DCM CLK out (CLKDV_DIVIDE)
    .CLKFX(),                     // DCM CLK synthesis out (M/D)
    .CLKFX180(),                  // 180 degree CLK synthesis out
    .DO(),                        // 16-bit data output for Dynamic Reconfiguration Port (DRP)
    .DRDY(),                      // Ready output signal from the DRP
    .LOCKED(dcmLocked),           // DCM LOCK status output
    .PSDONE(),                    // Dynamic phase adjust done output
    .CLKFB(outClk),               // DCM clock feedback
    .CLKIN(ddrClk),               // Clock input (from IBUFG, BUFG or DCM)
    .DADDR(7'h00),                // 7-bit address for the DRP
    .DCLK(1'b0),                  // Clock for the DRP
    .DEN(1'b0),                   // Enable input for the DRP
    .DI(16'h0000),                // 16-bit data input for the DRP
    .DWE(1'b0),                   // Active high allows for writing configuration memory
    .PSCLK(1'b0),                 // Dynamic phase adjust clock input
    .PSEN(1'b0),                  // Dynamic phase adjust enable input
    .PSINCDEC(1'b0),              // Dynamic phase adjust increment/decrement
    .RST(!dcmResetN)              // DCM asynchronous reset input (active high)
  );
  
BUFG bufg_i_ddrClk(.O(outClk),.I(dcm_out)); // BUFG driving the OSERDES out typ: 250MHz (DDR500)
BUFG bufg_i_sdrClk(.O(sdrClk),.I(dcm_div)); // BUFG driving the OSERDES in  typ: 125MHz
FDRSE#(.INIT(1'b0)) FRDSE_inst (.Q(di[0]), .C(sdrClk), .CE(1'b1), .D(!dcmLocked), .R(1'b0), .S(1'b0));
FDRSE#(.INIT(1'b0)) FRDSE_inst (.Q(di[1]), .C(sdrClk), .CE(1'b1), .D(di[0]),      .R(1'b0), .S(1'b0));
FDRSE#(.INIT(1'b0)) FRDSE_inst (.Q(di[2]), .C(sdrClk), .CE(1'b1), .D(di[1]),      .R(1'b0), .S(1'b0));
FDRSE#(.INIT(1'b0)) FRDSE_inst (.Q(di[3]), .C(sdrClk), .CE(1'b1), .D(di[2]),      .R(1'b0), .S(1'b0));

  OSERDES #(
    .DATA_RATE_OQ("DDR"),          // Specify data rate to "DDR" or "SDR"
    .DATA_RATE_TQ("DDR"),          // Specify data rate to "DDR", "SDR", or "BUF"
    .DATA_WIDTH(4),                // Specify data width - For DDR: 4,6,8, or 10 
    .INIT_OQ(1'b0),                // INIT for OQ register - 1’b1 or 1’b0
    .INIT_TQ(1'b0),                // INIT for OQ register - 1’b1 or 1’b0
    .SERDES_MODE("MASTER"),        // Set SERDES mode to "MASTER" or "SLAVE"
    .SRVAL_OQ(1'b0),               // Define OQ output value upon SR assertion - 1’b1 or 1’b0
    .SRVAL_TQ(1'b0),               // Define TQ output value upon SR assertion - 1’b1 or 1’b0
    .TRISTATE_WIDTH(4)             // Specify parallel to serial converter width  When DATA_RATE_TQ = DDR: 2 or 4
  ) OSERDES_inst_a (
    .OQ(da),                       // 1-bit data path output
    .SHIFTOUT1(),                  // 1-bit data expansion output
    .SHIFTOUT2(),                  // 1-bit data expansion output
    .TQ(),                         // 1-bit 3-state control output
    .CLK(outClk),                  // 1-bit clock input
    .CLKDIV(sdrClk),               // 1-bit divided clock input
    .D1(di[0]),                   // 1-bit parallel data input
    .D2(di[1]),                   // 1-bit parallel data input
    .D3(di[2]),                   // 1-bit parallel data input
    .D4(di[3]),                   // 1-bit parallel data input
    .D5(1'b0),                     // 1-bit parallel data input
    .D6(1'b0),                     // 1-bit parallel data input
    .OCE(1'b1),                    // 1-bit clock enable input
    .REV(1'b0),                    // Must be tied to logic zero
    .SHIFTIN1(1'b0),               // 1-bit data expansion input
    .SHIFTIN2(1'b0),               // 1-bit data expansion input
    .SR(rstSerdes),                // 1-bit set/reset input
    .T1(1'b0),                     // 1-bit parallel 3-state input
    .T2(1'b0),                     // 1-bit parallel 3-state input
    .T3(1'b0),                     // 1-bit parallel 3-state input
    .T4(1'b0),                     // 1-bit parallel 3-state input
    .TCE(1'b0)                     // 1-bit 3-state signal clock enable input
  );
  OBUFDS#(.IOSTANDARD("LVDS_25")) obufds_i_a(.O(dap),.OB(dan),.I(da));

endmodule

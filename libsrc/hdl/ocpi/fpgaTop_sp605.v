// fpgaTop_sp605.v - ssiegel 2010-03-30

module fpgaTop(
  input  wire        sys0_clkp,     // sys0 Clock +
  input  wire        sys0_clkn,     // sys0 Clock -
  input  wire        pci0_clkp,     // PCIe Clock +
  input  wire        pci0_clkn,     // PCIe Clock -
  input  wire        pci0_reset_n,  // PCIe Reset
  output wire [7:0]  pci_exp_txp,   // PCIe lanes...
  output wire [7:0]  pci_exp_txn,
  input  wire [7:0]  pci_exp_rxp,
  input  wire [7:0]  pci_exp_rxn,
  output wire [2:0]  led,            // LEDs ml555
  input  wire        ppsExtIn,       // PPS in
  output wire        ppsOut          // PPS out
);

// Instance and connect mkFTop...
 mkFTop_sp605 ftop(
  .sys0_clkp         (sys0_clkp),
  .sys0_clkn         (sys0_clkn),
  .pci0_clkp         (pci0_clkp),
  .pci0_clkn         (pci0_clkn),
  .pci0_rstn         (pci0_reset_n),
  .pcie_rxp_i        (pci_exp_rxp),
  .pcie_rxn_i        (pci_exp_rxn),
  .pcie_txp          (pci_exp_txp),
  .pcie_txn          (pci_exp_txn),
  .led               (led),
  .gps_ppsSyncIn_x   (ppsExtIn),
  .gps_ppsSyncOut    (ppsOut) 
);

endmodule

/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;
  control_unit_if cuif();
  register_file_if rfif();
  alu_if aluif();
  pc_if pcif();

  // pc init
  parameter PC_INIT = 0;

  //mapping control unit, regfile, alu and request unit
  pc PC (CLK, nRST, pcif);

endmodule

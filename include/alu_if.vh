/*
  Jason Lin
  lin57@purdue.edu
  1/14/2015
  ECE437

  ALU unit
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  import cpu_types_pkg::*;

  aluop_t aluop;
  word_t porta, portb, portout;
  regbits_t n_flag, z_flag, v_flag;

  // alu file ports
  modport alu (
    input porta, portb, aluop,
    output portout, n_flag, z_flag, v_flag
  );

  // alu testbench
  modport tb (
    input portout, n_flag, z_flag, v_flag,
    output porta, portb, aluop
  );
endinterface

`endif // ALU_IF_VH

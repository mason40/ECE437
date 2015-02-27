/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/12/2015

    Interface for forwarding unit
*/

`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface forward_unit_if;
  import cpu_types_pkg::*;
  // rtype or itype enable
  logic ri_enable, lw, sw;
  // input from idex
  regbits_t idex_rs, idex_rt;
  // input from exmem
  regbits_t exmem_rd;
  logic exmem_regW;
  opcode_t exmem_op;
  // input from memwb
  regbits_t memwb_rd;
  logic memwb_regW;
  opcode_t memwb_op;
  // control signals
  logic [1:0] alu1, alu2;
  logic [1:0] write;

  modport fu (
    input idex_rs, idex_rt, exmem_rd, exmem_regW, memwb_rd, memwb_regW,
          exmem_op, memwb_op, ri_enable, lw, sw,
    output alu1, alu2, write
  );
endinterface
`endif

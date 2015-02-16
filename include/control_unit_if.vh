/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/26/2015

    Control Unit Interface
*/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface control_unit_if;
  import cpu_types_pkg::*;

  // input to control unit
  opcode_t opcode;
  funct_t func;
  logic vflag;
  // output to alu
  aluop_t aluop;
  logic alusrc;
  // output from control unit
  logic memtoReg,regWrite, iren, dren, dwen, regDst, shift, lui, extend, halt;
  logic [1:0] jump, branch;
  word_t instr;

  modport cu (
    // input
    input opcode, func, vflag, instr,
    // output
    output aluop, alusrc, memtoReg, regWrite, iren, dren, dwen, regDst, jump, branch, lui, shift,extend, halt
  );
endinterface
`endif

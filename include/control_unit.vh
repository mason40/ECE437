/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/26/2015

    Control Unit Interface
*/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

include "cpu_types_pkg.vh"

interface control_unit_if;
  import cpu_types_pkg::*;

  // input to control unit
  opcode_t opcode;
  funct_t func;
  // output to alu
  aluop_t aluop;
  logic alusrc;
  // output from control unit
  logic memtoReg, memWrite, memRead,regWrite, iRequest, dRequest, regDst;

  modport cu(
    input opcode, func,
    output aluop, alusrc, memtoReg, memWrite, memRead, regWrite,
    output iRequest, dRequest, regDst
  );
endinterface
`endif

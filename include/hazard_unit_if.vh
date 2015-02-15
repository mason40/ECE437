/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/11/2015

    Hazard Unit Interface
*/

`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  import cpu_types_pkg::*;

  // input into the hazard unit
  logic ihit, dhit;
  opcode_t idex_op, exmem_op, memwb_op;
  word_t instr;
  // output to enable the latches
  logic ifid_en, idex_en, exmem_en, memwb_en;
  // to create no op for lw/sw
  logic idex_flush, exmem_flush, memwb_flush;
  // rtype or itype
  logic ri_enable;

  modport hu (
    input ihit, dhit, idex_op, exmem_op,memwb_op, instr,
    output ifid_en, idex_en, exmem_en, memwb_en, idex_flush, exmem_flush, memwb_flush, ri_enable
  );
endinterface
`endif

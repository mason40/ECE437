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
  /* remove
  opcode, ifid_op, instr, idex_rd, exmem_rt, exmem_rs, memwb_rd
  */
  // input into the hazard unit
  logic ihit, dhit, branch;
  opcode_t opcode,ifid_op, idex_op, exmem_op, memwb_op;
  word_t instr;
  regbits_t ifid_rs, ifid_rt, idex_rs, idex_rt,idex_rd, exmem_rd;
  regbits_t exmem_rt, exmem_rs, memwb_rd;
  // output to enable the latches
  logic ifid_en, idex_en, exmem_en, memwb_en;
  // to create no op for lw/sw
  logic idex_flush, exmem_flush, memwb_flush, ifid_flush;
  // rtype or itype
  logic ri_enable, pcpause, lw;

  modport hu (
    input ihit, dhit, ifid_op, idex_op, exmem_op,memwb_op, instr, opcode,
ifid_rs, ifid_rt, idex_rs, idex_rt, idex_rd, exmem_rt, exmem_rs, memwb_rd, exmem_rd, branch,
    output ifid_en, idex_en, exmem_en, memwb_en, idex_flush, exmem_flush, memwb_flush, ifid_flush, ri_enable, pcpause, lw
  );
endinterface
`endif

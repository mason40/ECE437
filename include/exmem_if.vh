/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/7/2015

    Interface for execute and mem register
*/

`ifndef EXMEM_IF_VH
`define EXMEM_IF_VH
`include "cpu_types_pkg.vh"

interface exmem_if;
  import cpu_types_pkg::*;

  //input from execute state
  word_t in_cpc;
  logic in_regWrite, in_memtoReg, in_halt;
  logic in_zflag, in_dren, in_dwen;
  logic [1:0] in_jump, in_branch;
  word_t in_aluout, in_writeData;
  word_t in_imm;
  word_t in_regtarget;
  regbits_t in_wsel;
  logic [25:0] in_jaddr;
  opcode_t in_opcode;

  // output to mem state
  word_t out_cpc;
  logic out_regWrite, out_memtoReg, out_halt;
  logic out_zflag, out_dren, out_dwen;
  logic [1:0] out_jump, out_branch;
  word_t out_aluout, out_writeData;
  word_t out_imm;
  word_t out_regtarget;
  regbits_t out_wsel;
  logic [25:0] out_jaddr;
  opcode_t out_opcode;

  modport exmem (
    input in_cpc, in_regWrite, in_memtoReg, in_halt, in_opcode,
          in_jump, in_branch, in_zflag, in_dren, in_dwen, in_regtarget,
          in_aluout, in_writeData, in_imm, in_wsel, in_jaddr,
    output out_cpc, out_regWrite, out_memtoReg, out_halt, out_opcode,
           out_jump, out_branch, out_zflag, out_dren, out_dwen, out_regtarget,
           out_aluout, out_writeData, out_imm, out_wsel, out_jaddr
  );
endinterface
`endif

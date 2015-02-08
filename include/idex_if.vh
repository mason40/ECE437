/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/7/2015

    Interface for ID_EX register
*/

`ifndef IDEX_IF_VH
`define IDEX_IF_VH
`include "cpu_types_pkg.vh"

interface idex_if;
  import cpu_types_pkg::*;

  // input from decode state
  // program counter forwarding to wb state
  word_t in_cpc; // program counter flow through
  // jump address forwarding to wb state
  logic [25:0] in_jaddr; // jump address
  // register target forwarding to wb state
  word_t in_regtarget;
  // imm forwarding to mem state
  word_t in_imm;
  // signals for execute state
  aluop_t in_aluop;  // alu op
  logic in_regDst, in_alusrc, in_shift, in_lui; // signals needed in execute state
  word_t in_rdat1, in_rdat2;
  regbits_t in_rt, in_rd;
  logic [4:0] in_shamt;
  // signals for mem state
  logic in_branch, in_dren, in_dwen; // signals going to mem state
  // signals for wb state
  logic [1:0] in_jump;
  logic in_memtoReg, in_regWrite, in_halt; // signals going to wb state
  opcode_t in_opcode;

  // output to execute state
  word_t out_cpc; // program counter flow through
  aluop_t out_aluop;
  logic out_branch, out_dren, out_dwen; // signals going to mem state
  logic [1:0] out_jump;
  logic out_memtoReg, out_regWrite, out_halt; // signals going to wb state
  logic out_regDst, out_alusrc, out_shift, out_lui; // signal use in execute state
  word_t out_rdat1, out_rdat2;
  word_t out_imm;
  regbits_t out_rt, out_rd;
  logic [4:0] out_shamt;
  logic [25:0] out_jaddr;
  opcode_t out_opcode;

  modport idex (
    input in_cpc, in_aluop, in_regDst, in_alusrc, in_shift, in_lui,
          in_jump, in_branch, in_dren, in_dwen, in_opcode,
          in_memtoReg, in_regWrite,in_halt, in_rdat1, in_rdat2,
          in_imm, in_rt, in_rd, in_jaddr, in_shamt,
    output out_cpc, out_aluop, out_regDst, out_alusrc, out_shift, out_lui,
           out_jump, out_branch, out_dren, out_dwen, out_opcode,
           out_memtoReg, out_regWrite, out_halt, out_rdat1, out_rdat2,
           out_imm, out_rt, out_rd, out_jaddr, out_shamt
  );
endinterface
`endif

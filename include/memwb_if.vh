/*  Jason LIn
    mg208
    lin57@purdue.edu
    2/7/2015

    interface for mem/wb register
*/

`ifndef MEMWB_IF_VH
`define MEMWB_IF_VH
`include "cpu_types_pkg.vh"

interface memwb_if;
  import cpu_types_pkg::*;

  //input from mem state
  logic in_regWrite, in_memtoReg, in_halt;
  opcode_t in_opcode;
  word_t in_readData, in_aluout, in_cpc, in_regtarget;
  logic [25:0] in_jaddr;
  logic [1:0] in_jump;
  regbits_t in_wsel;
  // output to write back state
  logic out_regWrite, out_memtoReg, out_halt;
  opcode_t out_opcode;
  word_t out_readData, out_aluout, out_cpc, out_regtarget;
  logic [25:0] out_jaddr;
  logic [1:0] out_jump;
  regbits_t out_wsel;

  modport memwb (
    input in_regWrite, in_memtoReg, in_halt, in_opcode, in_cpc, in_jump,
          in_readData, in_aluout, in_wsel, in_jaddr, in_regtarget,
    output out_regWrite, out_memtoReg, out_halt, out_opcode, out_cpc, out_jump,
           out_readData, out_aluout, out_wsel, out_jaddr, out_regtarget
  );
endinterface
`endif

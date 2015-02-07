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
  word_t in_readData, in_aluout;
  regbits_t in_wsel;
  // output to write back state
  logic out_regWrite, out_memtoReg, out_halt;
  word_t out_readData, out_aluout;
  regbits_t out_wsel;

  modport memwb (
    input in_regWrite, in_memtoReg, in_halt,
          in_readData, in_aluout, in_wsel,
    output out_regWrite, out_memtoReg, out_halt,
           out_readdata, out_aluout, out_wsel
  );
endinterface
`endif

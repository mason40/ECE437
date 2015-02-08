/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/7/2015

    mem/wb register
*/

`include "memwb_if.vh"
`include "cpu_types_pkg.vh"

module memwb (
  input logic CLK,
  input logic nRST,
  input logic en,
  memwb_if memwb
);

import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    memwb.out_regWrite <= 0;
    memwb.out_memtoReg <= 0;
    memwb.out_halt <= 0;
    memwb.out_readData <= 0;
    memwb.out_aluout <= 0;
    memwb.out_wsel <= 0;
    memwb.out_cpc <= 0;
    memwb.out_jump <= 0;
    memwb.out_regtarget <= 0;
    memwb.out_jaddr <= 0;
    memwb.out_opcode <= ADDI;
  end else if(en) begin
    memwb.out_regWrite <= memwb.in_regWrite;
    memwb.out_memtoReg <= memwb.in_memtoReg;
    memwb.out_halt <= memwb.in_halt;
    memwb.out_readData <= memwb.in_readData;
    memwb.out_aluout <= memwb.in_aluout;
    memwb.out_wsel <= memwb.in_wsel;
    memwb.out_cpc <= memwb.in_cpc;
    memwb.out_jump <= memwb.in_jump;
    memwb.out_regtarget <= memwb.in_regtarget;
    memwb.out_jaddr <= memwb.in_jaddr;
    memwb.out_opcode <= memwb.in_opcode;
  end
end

endmodule

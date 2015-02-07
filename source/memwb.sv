/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/7/2015

    mem/wb register
*/

`include "memwb_if.vh"

module memwb (
  input logic CLK,
  input logic nRST,
  memwb_if memwb
);

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    memwb.out_regWrite <= 0;
    memwb.out_memtoReg <= 0;
    memwb.out_halt <= 0;
    memwb.out_readData <= 0;
    memwb.out_aluout <= 0;
    memwb.out_wsel <= 0;
  end else begin
    memwb.out_regWrite <= memwb.in_regWrite;
    memwb.out_memtoReg <= memwb.in_memtoReg;
    memwb.out_halt <= memwb.in_halt;
    memwb.out_readData <= memwb.in_readData;
    memwb.out_aluout <= memwb.in_aluout;
    memwb.out_wsel <= memwb.in_wsel;
  end
end

endmodule

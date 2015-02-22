/*  Jason Lin
    mg208
    lin57@purdue.edu

    Hazard Handling Unit :
    Structural Hazard
*/

`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit (
  input logic CLK,
  input logic nRST,
  hazard_unit_if huif
);

import cpu_types_pkg::*;

// hazard detection
always_comb begin
    // aysnchronous reset
    if(!nRST) begin
      huif.ifid_en = 1'b0;
      huif.idex_en = 1'b0;
      huif.exmem_en = 1'b0;
      huif.memwb_en = 1'b0;
      huif.ifid_flush = 1'b0;
      huif.idex_flush = 1'b0;
      huif.exmem_flush = 1'b0;
      huif.pcpause = 1'b0;
      huif.ri_enable = 1'b0;
      huif.lw = 1'b0;
    end else begin
      if((huif.exmem_op==J)|(huif.exmem_op==JAL)|(huif.exmem_op==JR)) begin
        huif.pcpause = 1'b1;
        huif.ifid_en = 1'b0;
        huif.idex_en = 1'b1;
        huif.exmem_en = 1'b0;
        huif.memwb_en = 1'b1;
        huif.ifid_flush = 1'b0;
        huif.idex_flush = 1'b0;
        huif.exmem_flush = 1'b0;
        if((huif.memwb_op==huif.exmem_op)) begin
          huif.pcpause = 1'b0;
          huif.ifid_en = 1'b1;
          huif.idex_en = 1'b1;
          huif.exmem_en = 1'b1;
          huif.memwb_en = 1'b1;
          huif.ifid_flush = 1'b1;
          huif.idex_flush = 1'b1;
          huif.exmem_flush = 1'b1;
        end else begin
          huif.pcpause = 1'b1;
          huif.ifid_en = 1'b0;
          huif.idex_en = 1'b1;
          huif.exmem_en = 1'b0;
          huif.memwb_en = 1'b1;
          huif.ifid_flush = 1'b0;
          huif.idex_flush = 1'b0;
          huif.exmem_flush = 1'b0;
        end
      end else if((huif.exmem_op==LW)|(huif.exmem_op==SW)) begin
        huif.pcpause = 1'b1;
        huif.ifid_en = 1'b1;
        huif.idex_en = 1'b1;
        huif.exmem_en = 1'b1;
        huif.memwb_en = 1'b1;
        huif.ifid_flush = 1'b0;
        huif.idex_flush = 1'b0;
        huif.exmem_flush = 1'b0;
      end else if((huif.exmem_op==LW)&((huif.exmem_rd==huif.idex_rs)|(huif.exmem_rd==huif.idex_rt))) begin
        huif.pcpause = 1'b1;
        huif.ifid_en = 1'b0;
        huif.idex_en = 1'b1;
        huif.exmem_en = 1'b1;
        huif.memwb_en = 1'b1;
        huif.ifid_flush = 1'b0;
        huif.idex_flush = 1'b1;
        huif.exmem_flush = 1'b0;
      end else if(huif.branch) begin
        huif.pcpause = 1'b0;
        huif.ifid_en = 1'b1;
        huif.idex_en = 1'b0;
        huif.exmem_en = 1'b0;
        huif.memwb_en = 1'b1;
        huif.ifid_flush = 1'b1;
        huif.idex_flush = 1'b1;
        huif.exmem_flush = 1'b1;
      end else begin
        huif.ifid_en = 1'b1;
        huif.idex_en = 1'b1;//huif.ihit|huif.dhit;
        huif.exmem_en = 1'b1;//huif.ihit|huif.dhit;
        huif.memwb_en = 1'b1;//huif.ihit|huif.dhit;
        huif.ifid_flush = 1'b0;
        huif.idex_flush = 1'b0;
        huif.exmem_flush = 1'b0;
        huif.pcpause =1'b0;
      end
      if(huif.idex_op==SW|huif.idex_op==ADDIU|huif.idex_op==ADDI|huif.idex_op==BEQ|
         huif.idex_op==ANDI|huif.idex_op==LUI|huif.idex_op==ORI|huif.idex_op==LW|
         huif.idex_op==SLTI|huif.idex_op==SLTIU|huif.idex_op==XORI|huif.idex_op==BNE) begin
         huif.ri_enable = 1'b0;
      end else begin
        huif.ri_enable = 1'b1;
      end// end of rtype itype
      if(huif.exmem_op == LW) begin
        huif.lw = 1'b1;
      end else begin
        huif.lw = 1'b0;
      end // end of lw
    end// end of big else
end// end of comb

endmodule

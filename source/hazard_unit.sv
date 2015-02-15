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

always_comb begin
  if(!nRST) begin
    huif.ifid_en = 0;
    huif.idex_en = 0;
    huif.exmem_en = 0;
    huif.memwb_en = 0;
    huif.idex_flush = 0;
    huif.exmem_flush = 0;
  end else begin
    /*if((huif.idex_op==J)|(huif.idex_op==JR)|(huif.idex_op==JAL)|(huif.idex_op==BEQ)|(huif.idex_op==BNE)) begin
      huif.ifid_en = huif.ihit & ~huif.dhit;
      huif.idex_en = huif.ihit | huif.dhit;
      huif.exmem_en= huif.ihit | huif.dhit;
      huif.memwb_en= huif.ihit | huif.dhit;
      huif.idex_flush = 1'b1;
      huif.exmem_flush = 1'b0;
      huif.memwb_flush = 1'b0;
    end else if((huif.exmem_op==J)|(huif.exmem_op==JR)|(huif.exmem_op==JAL)|(huif.exmem_op==BEQ)|(huif.exmem_op==BNE)) begin
      huif.ifid_en = huif.ihit & ~huif.dhit;
      huif.idex_en = huif.ihit | huif.dhit;
      huif.exmem_en= huif.ihit | huif.dhit;
      huif.memwb_en= huif.ihit | huif.dhit;
      huif.idex_flush = 1'b1;
      huif.exmem_flush = 1'b1;
      huif.memwb_flush = 1'b0;
    end else if((huif.memwb_op==J)|(huif.memwb_op==JR)|(huif.memwb_op==JAL)) begin
      huif.ifid_en = huif.ihit & ~huif.dhit;
      huif.idex_en = huif.ihit | huif.dhit;
      huif.exmem_en= huif.ihit | huif.dhit;
      huif.memwb_en= huif.ihit | huif.dhit;
      huif.idex_flush = 1'b1;
      huif.exmem_flush = 1'b1;
      huif.memwb_flush = 1'b1;
    end else begin*/
      huif.ifid_en = huif.ihit & ~huif.dhit;
      huif.idex_en = huif.ihit | huif.dhit;
      huif.exmem_en = huif.ihit | huif.dhit;
      huif.memwb_en = huif.ihit | huif.dhit;
      huif.idex_flush = huif.dhit;
     // huif.exmem_flush = 1'b0;
     // huif.memwb_flush = 1'b0;
    //end
    if((huif.idex_op==SW)) begin
      huif.ri_enable = 1'b0;
    end else begin
      huif.ri_enable = 1'b1;
    end// end of rtype itype
  end
end// end of comb

endmodule

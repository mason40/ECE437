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
      huif.pcpause = 1'b0;
    end else begin
    // initial latch enables and flushes
    /*huif.ifid_en = huif.ihit|huif.dhit;
    huif.idex_en = huif.ihit|huif.dhit;
    huif.exmem_en = huif.ihit|huif.dhit;
    huif.memwb_en = huif.ihit|huif.dhit;
    huif.ifid_flush = 1'b0;
    huif.idex_flush = 1'b0;
    huif.exmem_flush = 1'b0;
    huif.memwb_flush = 1'b0;
    huif.pcpause = 1'b0;*/
    // branch stalling
    if((huif.ifid_op==BEQ)|(huif.ifid_op==BNE)) begin
      huif.pcpause = 1'b1;
      huif.ifid_en = 1'b0;
      huif.ifid_flush = 1'b0;
      if((huif.exmem_op==huif.ifid_op)) begin
        huif.pcpause = 1'b0;
        huif.ifid_en = 1'b1;
        huif.ifid_flush = 1'b1;
      end
    end else if((huif.ifid_op==J)|(huif.ifid_op==JAL)|(huif.ifid_op==JR)) begin
      huif.pcpause = 1'b1;
      huif.ifid_en = 1'b0;
      huif.ifid_flush = 1'b0;
      huif.idex_flush = 1'b0;
      huif.exmem_flush= 1'b0;
      if((huif.memwb_op==huif.ifid_op)) begin
        huif.pcpause = 1'b0;
        huif.ifid_en = 1'b1;
        huif.idex_en = 1'b1;
        huif.exmem_flush = 1'b1;
      end
    end else if((huif.exmem_op==LW)|(huif.exmem_op==SW)) begin
      huif.pcpause = 1'b1;
      huif.ifid_flush = 1'b1;
    end else begin
      huif.ifid_en = huif.ihit|huif.dhit;
      huif.idex_en = huif.ihit|huif.dhit;
      huif.exmem_en = huif.ihit|huif.dhit;
      huif.memwb_en = huif.ihit|huif.dhit;
      huif.ifid_flush = 1'b0;
      huif.idex_flush = 1'b0;
      huif.exmem_flush = 1'b0;
      huif.memwb_flush = 1'b0;
      huif.pcpause = 1'b0;
    end
      /*end else if((huif.exmem_op==LW)&&(huif.ifid_op==LW)) begin
        huif.pcpause = 1'b0;
        huif.ifid_en = 1'b1;
        huif.ifid_flush = 1'b0;
        huif.idex_flush = 1'b1;
        huif.exmem_flush = 1'b1;
      /*end else begin
        huif.pcpause = 1'b0;
        huif.ifid_en = huif.ihit;
        huif.idex_en = huif.ihit|huif.dhit;
        huif.exmem_en = huif.ihit|huif.dhit;
        huif.memwb_en = huif.ihit|huif.dhit;
      */
    if((huif.idex_op==SW)) begin
      huif.ri_enable = 1'b0;
    end else begin
      huif.ri_enable = 1'b1;
    end// end of rtype itype
  end
end// end of comb

endmodule

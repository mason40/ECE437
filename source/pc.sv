/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Program Counter source file
*/
`include "pc_if.vh"
`include "cpu_types_pkg.vh"

module pc ( input logic CLK, nRST, pc_if.pc pcif);
import cpu_types_pkg::*;

word_t npc;

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    pcif.cpc <= '0;
  end else begin
    pcif.cpc <= npc;
  end
end

always_comb begin
  npc = (pcif.branch) ? ((pcif.cpc+4)+(pcif.imm<<2)) : pcif.cpc+4;
  casez(pcif.jump)
    2'b00 : begin
      npc = npc;
    end
    2'b11 : begin
      npc = pcif.jaddr;
    end
    2'b01 : begin
      npc = pcif.regtarget;
    end
  endcase
end

endmodule

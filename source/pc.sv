/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Program Counter source file
*/
`include "pc_if.vh"

module pc ( input logic CLK, nRST, pc_if.pc pcif);

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    pcif.cpc <= '0;
  end else begin
    if(pcif.pcen) begin
      pcif.cpc <= pcif.npc;
    end
  end
end
/*
always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    pcif.cpc <= '0;
  end else begin
    if(pcif.pcen) begin
      pcif.cpc <= npc;
    end
  end
end

always_comb begin
    if(pcif.jump == 2'b00) begin
      if(pcif.branch) begin
        npc = (pcif.cpc + 4) + ({{16{pcif.imm[15]}},pcif.imm}<<2);
      end else begin
        npc = pcif.cpc + 4;
      end
    end else if(pcif.jump == 2'b01) begin
      npc = pcif.regtarget;
    end else begin
      npc = pcif.cpc + 4;
      npc = {npc[31:28],pcif.jaddr[25:0],2'b00};
    end
end
*/
endmodule

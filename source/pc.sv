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
    pcif.cpc <= pcif.npc;
  end
end

endmodule

/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Testbench for program counter
*/

`include "pc_if.vh"
`timescale 1 ns / 1 ns
module pc_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  always #(PERIOD/2) CLK++;
  pc_if pcif();
  test PROG(CLK, nRST, pcif);

  `ifndef MAPPED
    pc DUT(CLK, nRST, pcif);
  `endif
endmodule

program test(input logic CLK, output logic nRST, pc_if.pc pcif);
  int i;

  initial begin
    $monitor("pc = %h, npc = %h", pcif.cpc, pcif.npc);
    nRST = 1'b0;
    #(pc_tb.PERIOD);
    nRST = 1'b1;

    for(i = 0; i < 100; i++) begin
      pcif.npc = i << 2;
      #(pc_tb.PERIOD);
    end
    pcif.npc = 'h123940;
    #(pc_tb.PERIOD);
  end
endprogram




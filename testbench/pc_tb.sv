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
  int error = 0;
  int pc = 0;

  initial begin
    /* initialization*/
    pcif.pcen = 1'b0;
    pcif.branch = 1'b0;
    pcif.jump = 2'b00;
    pcif.regtarget = 0;
    pcif.jaddr = '0;
    pcif.imm = 0;
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    // regular increment
    for(i = 0; i < 3; i++) begin
      pcif.pcen = 1'b1;
      @(posedge CLK);
      #(2);
      pcif.pcen = 1'b0;
      #(3);
    end
    if(pcif.cpc != 32'h0000000c) $error("ERROR");
    // branch test
    pcif.branch = 1'b1;
    pcif.jump = 2'b00;
    pcif.imm = 10;
    pcif.pcen = 1'b1;
    @(posedge CLK);
    #(2);
    pcif.pcen = 1'b0;
    if(pcif.cpc != (16+(10<<2))) $error("ERROR2");
    // JR
    pcif.jump = 2'b01;
    pcif.imm = 4;
    pcif.pcen = 1'b1;
    pcif.regtarget = 33;
    @(posedge CLK);
    #(2);
    pcif.pcen = 1'b0;
    if(pcif.cpc != pcif.regtarget) $error("ERROR3");
    // J
    pcif.jump =2'b11;
    pcif.imm = 3;
    pcif.pcen = 1'b1;
    pcif.regtarget = 2;
    pcif.jaddr = 1023;
    @(posedge CLK);
    #(2);
    pcif.pcen = 1'b0;
    pcif.jump = 1'b0;
    @(posedge CLK);
    #(pc_tb.PERIOD*2);
    pcif.pcen = 1'b1;
    @(posedge CLK);
    #(2);
    pcif.pcen = 1'b0;
  end
endprogram




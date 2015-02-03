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
    $monitor("pc = %h", pcif.cpc);
    /* Async Testing*/
    $display("\nAsync Testing...");
    nRST = 1'b0;
    #(pc_tb.PERIOD);
    nRST = 1'b1;
    if(pcif.cpc == '0) $display("PASSED :: Async test");
    else $error("FAILED :: Async test");
    /* PC+4 testing*/
    // initializing
    $display("\nPC + 4 testing...");
    pcif.branch = 1'b0;
    pcif.jump = 1'b0;
    pcif.jaddr = '0;
    pcif.imm = '0;
    for(i = 0; i < 10; i++) begin
      if(pcif.cpc != i*4) error++;
      #(pc_tb.PERIOD);
    end
    if(error > 0) $error("FAILED :: PC+4 test");
    else $display("PASSED :: PC+4 test");
    /* Branch testing */
    $display("\nBranch testing...");
    // initializing
    $monitor("pc = %h, branch = %b", pcif.cpc, pcif.branch);
    error = 0;
    pcif.branch = 1'b1;
    pcif.imm = 10;
    pc = pcif.cpc;
    #(pc_tb.PERIOD);
    if(pcif.cpc != pc+4+(pcif.imm<<2)) error++;
    pcif.branch = 1'b0;
    pcif.imm = 2;
    pc = pcif.cpc;
    #(pc_tb.PERIOD);
    if(pcif.cpc != pc+4) error++;
    pcif.branch = 1'b1;
    pc = pcif.cpc;
    #(pc_tb.PERIOD);
    if(pcif.cpc != pc+4+(pcif.imm<<2)) error++;
    if(error > 0) $error("FAILED :: Branch test");
    else $display("PASSED :: Branch test");

    /* Jump testing J/JAL*/
    $monitor("pc = %h, jump = %2b", pcif.cpc, pcif.jump);
    $display("\nJump testing...");
    // intializing
    error = 0;
    pcif.branch = 1'b0;
    pcif.jump = 2'b00;
    pcif.jaddr = 'hfffff;
    #(pc_tb.PERIOD);
    if(pcif.cpc == 'hfffff) error++;
    pcif.jump = 2'b01;
    #(pc_tb.PERIOD);
    if(pcif.cpc != 'hfffff) error++;
    if(error > 0) $error("FAIELD :: Jump test");
    else $display("PASSED :: Jump test");
  end
endprogram




/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/24/2015

    Testbench for memory control interface
*/

// interface
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
// types
`include "cpu_types_pkg.vh"
// timescale
`timescale 1 ns / 1 ns

module memory_control_tb;
  //clock period
  parameter PERIOD = 20;
  // signal
  logic CLK = 1, nRST;

  // clock generation
  always #(PERIOD/2) CLK++;
  // interface
  cache_control_if ccif();
  cpu_ram_if ramif();

  // test program
  test PROG(CLK, nRST, ccif);

  // DUT
  `ifndef MAPPED
    memory_control DUT(CLK, nRST, ccif);
  `endif
endmodule

program test(input logic CLK, output logic nRST, cache_control_if.cc ccif);
  int i;            // indexing variable
  int error = 0;    // error cumulator

  // test begin
  initial begin
    // initializing all signals from cache
    ccif.iREN = 1'b0;
    ccif.dWEN = 1'b0;
    ccif.dREN = 1'b0;
    ccif.iaddr = 0;
    ccif.daddr = 0;
    ccif.dstore = 0;

    // asynchronous reset testing
    $display("Starting :: Asynchronous Reset Testing");
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    if(ccif.ramaddr == '0 && ~ccif.ramREN && ~ccif.ramWEN && ccif.ramstore=='0) begin
      $display("PASSED :: Asynchronous reset test\n");
    end else begin
      $error("FAILED :: Asynchronous reset test\n");
    end

    // Testing iCache signals
    $display("Starting :: Instruction Fetching Testing");
    for(i = 0; i < 10; i++) begin
      ccif.iaddr = i<<2;
      ccif.iREN = 1'b1;
      @(negedge ccif.iwait);
      $display("(%02d) i = %8h, r = %8h", i, ccif.iload, ccif.ramload);
      if(ccif.iload != ccif.ramload) error++;
      #(memory_control_tb.PERIOD);
      ccif.iREN = 1'b0;
      #(memory_control_tb.PERIOD);
    end
    if(error != 0) begin
      $error("FAILED :: Instruction Fetching Test\n");
    end else begin
      $display("PASSED :: Instruction Fetching Test\n");
    end
    error = 0;
    ccif.iREN = 1'b0;

    // Testing dCache and iCache read signal
    $display("Starting :: Reading Priority Testing");
    for(i = 0; i < 10; i ++) begin
      ccif.iaddr = i<<2;
      ccif.iREN = 1'b1;
      ccif.daddr = i<<2;
      ccif.dREN = 1'b1;
      @(negedge ccif.dwait);
      $display("(%02d) i = %8h, d = %8h, r = %8h", i, ccif.iload, ccif.dload,
ccif.ramload);
      if(ccif.iload == ccif.dload) error++;
      #(memory_control_tb.PERIOD);
      ccif.dREN = 1'b0;
      @(negedge ccif.iwait);
      $display("(%02d) i = %8h, d = %8h, r = %8h", i , ccif.iload, ccif.dload,
ccif.ramload);
      if(ccif.iload != ccif.dload) error++;
      ccif.iREN = 1'b0;
      #(memory_control_tb.PERIOD);
    end
    if(error != 0) begin
      $error("FAILED :: Read Priority Test\n");
    end else begin
      $display("PASSED :: Read Priority Test\n");
    end
    error = 0;
    ccif.iREN = 1'b0;
    ccif.dREN = 1'b0;
    ccif.dWEN = 1'b0;

    // dump memory from RAM
    $display("Memory Dump...");
    for(i = 0; i < 16384 ; i++) begin
      ccif.iaddr = i << 2;
      ccif.iREN = 1'b1;
      @(negedge ccif.iwait);
      if(ccif.iload != '0) begin
        $display("(%2h) %h", i,ccif.iload);
      end
      #(memory_control_tb.PERIOD);
    end
    ccif.iREN = 1'b0;
    ccif.dWEN = 1'b0;
    ccif.dREN = 1'b0;

    // Testing dCache write and iCache read
    $display("\nStore Data Testing");
    for(i = 0; i < 10; i ++) begin
      ccif.daddr = 4+(i<<2);
      ccif.iaddr = i<<2;
      ccif.dstore = 1234*i+17;
      ccif.dWEN = 1'b1;
      ccif.iREN = 1'b1;
      @(negedge ccif.dwait);
      #(memory_control_tb.PERIOD);
      ccif.dWEN = 1'b0;
      @(negedge ccif.iwait);
      $display("(%2h) i = %8h, d = %8h", i, ccif.iload, ccif.dstore);
      ccif.iREN = 1'b0;
      #(memory_control_tb.PERIOD);
    end
    ccif.iREN = 1'b0;
    ccif.dREN = 1'b0;
    ccif.dWEN = 1'b0;
    // dump memory from RAM to show changes
    $display("\nMemory Dump after Changes...");
    for(i = 0; i < 16384; i++) begin
      ccif.iaddr = i <<2;
      ccif.iREN = 1'b1;
      @(negedge ccif.iwait);
      if(ccif.iload != '0) begin
        $display("(%2h) %h", i, ccif.iload);
      end
      #(memory_control_tb.PERIOD);
    end

  end // end of the test
endprogram


/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/24/2015

    Testbench for memory control interface
*/

// interface
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "datapath_cache_if.vh"
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
  datapath_cache_if dcif();

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
    ccif.iaddr = '0;
    ccif.daddr = '0;
    ccif.iREN = 1'b0;
    ccif.dREN = 1'b0;
    ccif.dWEN = 1'b0;
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    ccif.iREN = 1'b1;
    ccif.dREN = 1'b0;
    ccif.dWEN = 1'b0;
    while(ccif.iwait[0] != 0) begin
      ccif.iREN = 1'b1;
      #(1);
    end
    ccif.iREN = 1'b0;
    @(posedge CLK);
    ccif.iaddr = 4;
    ccif.daddr = 16;
    ccif.iREN = 1'b1;
    ccif.dREN = 1'b1;
    ccif.dWEN = 1'b0;
    while(ccif.dwait[0] != 0) begin
      ccif.dREN = 1'b1;
      #(1);
    end
    ccif.dREN = 1'b0;
    while(ccif.iwait[0] != 0) begin
      ccif.iREN = 1'b1;
      #(1);
    end
    ccif.iREN = 1'b0;
    #(memory_control_tb.PERIOD);

  end // end of the test
endprogram


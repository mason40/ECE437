/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/1/2015

    Testbench for single cycle processor
*/

`include "system_if.vh"
`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"
`include "cache_control_if.vh"
`timescale 1 ns / 1 ns

module singlecycle_tb;
  parameter PERIOD = 20;
  logic CLK = 1, nRST, halt;

  always #(PERIOD/2) CLK++;

  cpu_ram_if crif();

  test PROG(CLK, nRST, crif);

  `ifndef MAPPED
    singlecycle PROC(CLK, nRST, halt, crif);
    ram RAM(CLK, nRST, crif);
  `endif
endmodule

program test(
  input logic CLK,
  output logic nRST,
  cpu_ram_if.cpu crif
);

  int i;
  initial begin
    nRST = 1'b0;
    #(10);
    nRST = 1'b1;
    #(singlecycle_tb.PERIOD);
    $monitor("ramstate = %s, addr = %h, ren = %b", crif.ramstate, crif.memaddr,crif.memREN);
    for(i = 0; i < 10; i++) begin
      #(singlecycle_tb.PERIOD);
    end
  end
endprogram

/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Testbench for Request Unit
*/
`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

module request_unit_tb;
  parameter PERIOD = 20;
  logic CLK = 1, nRST;

  always #(PERIOD/2) CLK++;

  request_unit_if ruif();

  test PROG(CLK, nRST, ruif);

  `ifndef MAPPED
    request_unit DUT(CLK, nRST, ruif);
  `endif
endmodule

program test(input logic CLK, output logic nRST, request_unit_if.ru ruif);

  initial begin
    ruif.iaddr = 32'h340100f0;
    #(request_unit_tb.PERIOD);
  end
endprogram

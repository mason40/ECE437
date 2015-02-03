/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/1/2015

    Testbench for Datapath
*/

`include "datapath_cache_if.vh"
`include "pc_if.vh"
`include "alu_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns
module datapath_tb;
  parameter PERIOD = 20;
  logic CLK = 1, nRST;

  always #(PERIOD/2) CLK++;

  datapath_cache_if dpif();
  test PROG(CLK, nRST, dpif);

  `ifndef MAPPED
    datapath DP(CLK, nRST, dpif);
  `endif
endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if.dp dpif);
  initial begin
    $monitor("(%b)iaddr = %h, instr = %h", dpif.imemREN, dpif.imemaddr, dpif.imemload);
    // initialize signal from cace
    dpif.imemload = '0;
    dpif.ihit = 0;
    dpif.dmemload = '0;
    dpif.dhit = 0;
    nRST = 1'b0;
    #(5);
    nRST = 1'b1;
    // case 1
    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(5);
    dpif.imemload = 32'h00430821;
    dpif.ihit = 1'b1;
    // case 2
    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(5);
    dpif.imemload = 32'h8c230000;
    dpif.ihit = 1'b1;
    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(5);
    dpif.imemload = 32'hffffffff;
    dpif.ihit = 1'b1;

  end
endprogram


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
    datapath DP(CLK, nRST,dpif);
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
    // case 1 rtype
    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00430821;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00611020;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00e31824;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00400008;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00a41027;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00011825;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h0043082a;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00a41823;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00c72822;
    dpif.ihit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h00010826;
    dpif.ihit = 1'b1;
    // case 2
    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h8c230000;
    dpif.ihit = 1'b1;
    #(3);
    dpif.dhit = 1'b1;

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h24410008;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h20410400;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h3021000c;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h1022ffff;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h1464ffff;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h3c03000c;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h8c230004;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h3441000a;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h28620064;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h2c61007a;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'hac210078;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h384203ff;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h08000019;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'h0c00001b;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

    @(posedge CLK);
    dpif.ihit = 1'b0;
    #(1);
    dpif.imemload = 32'hffffffff;
    dpif.ihit = 1'b1;
    #(datapath_tb.PERIOD);

  end
endprogram


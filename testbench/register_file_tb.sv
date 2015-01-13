/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif
endmodule

program test;
  int i;
  initial begin
    register_file_tb.rfif.wsel = 4'h0000;
    register_file_tb.rfif.rsel1 = 4'h0000;
    $monitor("@%00g CLK = %b nRST = %b WEN = %b rdata = %b", $time, register_file_tb.CLK,register_file_tb.nRST, register_file_tb.rfif.WEN, register_file_tb.rfif.rdat1);
    // async reset
    register_file_tb.nRST = 0;
    #(register_file_tb.PERIOD);
    register_file_tb.nRST = 1;
    // testing writing and reading from reg0
    #(register_file_tb.PERIOD);
    register_file_tb.rfif.WEN = 1;
    register_file_tb.rfif.wdat = 4'h1010;
    #(register_file_tb.PERIOD);
    register_file_tb.rfif.WEN = 0;
    register_file_tb.rfif.wsel = 4'h0001;
    register_file_tb.rfif.rsel1 = 4'h0001;
    // testing the reading data from register file
    for(i = 0; i < 32; i++) begin
      register_file_tb.rfif.WEN = 1;
      register_file_tb.rfif.wdat = i;
      #(register_file_tb.PERIOD);
    end
    // testing reset
    #(register_file_tb.PERIOD);
    register_file_tb.nRST = 0;
    #(register_file_tb.PERIOD);
    $finish;
  end

endprogram

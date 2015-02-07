/*
  Jason Lin
  lin57@purdue.edu
  1/13/2015
  ECE437

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
<<<<<<< HEAD
  // testing variables
  int i;  // indexing variable
  int eflag = 0;  // error flag

  initial begin
    register_file_tb.rfif.wsel = 5'b00000;
    register_file_tb.rfif.rsel1 = 5'b00000;
    register_file_tb.rfif.rsel2 = 5'b00000;
    $monitor("@%03g rsel1 = %02d rdata1 = %8h rsel2 = %02d rdata2 = %8h",$time, register_file_tb.rfif.rsel1, register_file_tb.rfif.rdat1, register_file_tb.rfif.rsel2,register_file_tb.rfif.rdat2);
    // async reset
    register_file_tb.nRST = 0;
    #(register_file_tb.PERIOD);
    register_file_tb.nRST = 1;
    // testing writing and reading from reg0
    #(register_file_tb.PERIOD);
    register_file_tb.rfif.WEN = 1;
    register_file_tb.rfif.wdat = 32'b00000000111100001100110011110000;
    #(register_file_tb.PERIOD);
    register_file_tb.rfif.WEN = 0;
    register_file_tb.rfif.wsel = 5'b00001;
    register_file_tb.rfif.rsel1 = 5'b00001;
    if(register_file_tb.rfif.rdat1 == 32'b0) begin
      $display("PASSED :: Reading from reg0");
    end else begin
      $error("FAILED :: Reading from reg0");
    end
    // reset the enables and selects to 0x0000
    register_file_tb.rfif.rsel1 = 5'b00000;
    register_file_tb.rfif.rsel2 = 5'b00000;
    register_file_tb.rfif.WEN = 0;
    register_file_tb.rfif.wsel = 5'b00000;
    // writing to register testing
    register_file_tb.rfif.WEN = 1'b1;
    for(i = 0; i < 32; i++) begin
      register_file_tb.rfif.wdat = i;
      #(register_file_tb.PERIOD);
      register_file_tb.rfif.wsel = register_file_tb.rfif.wsel + 1;
    end
    // testing the reading data from register file rsel1
    register_file_tb.rfif.rsel1 = 5'b00000;
    for(i = 0; i < 32; i++) begin
      if(register_file_tb.rfif.rdat1 != i) begin
        eflag += 1;
      end
      register_file_tb.rfif.rsel1 = register_file_tb.rfif.rsel1 + 1;
      #(register_file_tb.PERIOD);
    end
    if(eflag == 0) begin
      $display("PASSED :: Reading from rsel1");
    end else begin
      $error("FAILED :: Reading from rsel1 with (%d) errors", eflag);
    end
    // testing the reading data from register file rsel2
    eflag = 0;
    register_file_tb.rfif.rsel2 = 5'b00000;
    for(i = 0; i < 32; i++) begin
      if(register_file_tb.rfif.rdat2 != i) begin
        eflag += 1;
      end
      register_file_tb.rfif.rsel2 = register_file_tb.rfif.rsel2 + 1;
      #(register_file_tb.PERIOD);
    end
    if(eflag == 0) begin
      $display("PASSED :: Reading from rsel2");
    end else begin
      $error("FAILED :: Reading from rsel2");
    end
    // testing reset
    #(register_file_tb.PERIOD);
    register_file_tb.nRST = 0;
    #(register_file_tb.PERIOD);
    register_file_tb.rfif.rsel1 = 5'b00001;
    if(register_file_tb.rfif.rdat1 == 0) begin
      $display("PASSED :: Asynchronous Reset");
    end else begin
      $error("FAILED :: Asynchronous Reset");
    end
    $finish;
  end

=======
>>>>>>> 7dabfc3f11bbd03f1d249da3c2c0e8ce18ffaab5
endprogram

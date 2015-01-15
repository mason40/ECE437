/*
  Jason Lin
  lin57@purdue.edu
  1/14/2015
  ECE437

  Testbench for ALU unit
*/

`include "alu_if.vh"
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module alu_tb;
  aluop_t aluop;

  // interface
  alu_if aluif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT (
    .\aluif.aluop (aluif.aluop),
    .\aluif.porta (aluif.porta),
    .\aluif.portb (aluif.portb),
    .\aluif.portout (aluif.portout),
    .\aluif.n_flag (aluif.n_flag),
    .\aluif.z_flag (aluif.z_flag),
    .\aluif.v_flag (aluif.v_flag)
  );
`endif
endmodule

program test;
  int i,j;  // indexing var
  int eflag = 0;  // error flag
  initial begin
    $monitor("@%03g alu_op = %s porta = %h portb = %h output = %h (%b %b %b)", $time, alu_tb.aluif.aluop,alu_tb.aluif.porta, alu_tb.aluif.portb, alu_tb.aluif.portout, alu_tb.aluif.z_flag, alu_tb.aluif.n_flag, alu_tb.aluif.v_flag);
    // extensive testing shift left logic
    alu_tb.aluif.porta = 'h1;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_SLL;
    alu_tb.aluif.aluop = alu_tb.aluop;
    for(i = 0; i < 32; i++) begin
      alu_tb.aluif.portb = i;
      #(1);
      if(alu_tb.aluif.portout != (alu_tb.aluif.porta << i)) begin
        eflag += 1;
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Shift Left Logic");
    end else begin
      $error("FAILED :: Shift Left Logic");
    end
    // extensive testing shift right logic
    alu_tb.aluif.porta = 'h80000000;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_SRL;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    for(i = 0; i <32; i++) begin
      alu_tb.aluif.portb = i;
      #(1);
      if(alu_tb.aluif.portout != (alu_tb.aluif.porta >> i)) begin
        eflag += 1;
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Shift Right Logic");
    end else begin
      $display("FAILED :: Shift Right Logic");
    end
    // testing ADD
    alu_tb.aluif.porta = 'h1;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_ADD;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    for(i = 0; i < 32; i++) begin
      alu_tb.aluif.porta = 17*(19-i);
      alu_tb.aluif.portb = 33*(20+i);
      #(1);
      if(alu_tb.aluif.portout != (alu_tb.aluif.porta + alu_tb.aluif.portb)) begin
        eflag += 1;
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Signed Addition");
    end else begin
      $error("FAILED :: Signed Addition");
    end
    // testing SUB
    alu_tb.aluif.porta = 'h1;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_SUB;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    for(i = 0; i < 32; i++) begin
      alu_tb.aluif.porta = 33*(13-i);
      alu_tb.aluif.portb = 42*(3+i);
      #(1);
      if(alu_tb.aluif.portout != (alu_tb.aluif.porta - alu_tb.aluif.portb)) begin
        eflag += 1;
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Signed Subtraction");
    end else begin
      $error("FAILED :: Signed Subtraction");
    end
    // testing AND
    alu_tb.aluif.porta = 'h1;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_AND;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    for(i = 0; i < 5; i++) begin
      alu_tb.aluif.porta = 32*(13-3*i);
      alu_tb.aluif.portb = 92*(4+9*i);
      #(1);
      for(j = 0; j < 32; j++) begin
        if(alu_tb.aluif.portout[j] != (alu_tb.aluif.porta[j] & alu_tb.aluif.portb[j])) begin
          eflag += 1;
        end
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Logic AND");
    end else begin
      $error("FAILED :: Logic AND");
    end
    // testing OR
    alu_tb.aluif.porta = 'h1;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_OR;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    for(i = 0; i < 5; i++) begin
      alu_tb.aluif.porta = 32*(13-3*i);
      alu_tb.aluif.portb = 92*(4+9*i);
      #(1);
      for(j = 0; j < 32; j++) begin
        if(alu_tb.aluif.portout[j] != (alu_tb.aluif.porta[j] | alu_tb.aluif.portb[j])) begin
          eflag += 1;
        end
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Logic OR");
    end else begin
      $error("FAILED :: Logic OR");
    end
    // testing XOR
    alu_tb.aluif.porta = 'h1;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_XOR;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    for(i = 0; i < 5; i++) begin
      alu_tb.aluif.porta = 32*(13-3*i);
      alu_tb.aluif.portb = 92*(4+9*i);
      #(1);
      if(alu_tb.aluif.portout != (alu_tb.aluif.porta ^ alu_tb.aluif.portb)) begin
        eflag += 1;
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Logic XOR");
    end else begin
      $error("FAILED :: Logic XOR");
    end
    // testing NOR
    alu_tb.aluif.porta = 'h1;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_NOR;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    for(i = 0; i < 5; i++) begin
      alu_tb.aluif.porta = 32*(13-3*i);
      alu_tb.aluif.portb = 92*(4+9*i);
      #(1);
      for(j = 0; j < 32; j++) begin
        if(alu_tb.aluif.portout[j] != ~(alu_tb.aluif.porta[j] | alu_tb.aluif.portb[j])) begin
          eflag += 1;
        end
      end
    end
    if(eflag == 0) begin
      $display("PASSED :: Logic NOR");
    end else begin
      $error("FAILED :: Logic NOR");
    end
    // testing SLT
    // testing SLTU
    // testing Zero flag
    /* case 1 */
    alu_tb.aluif.porta = 10;
    alu_tb.aluif.portb = -10;
    alu_tb.aluop = ALU_ADD;
    alu_tb.aluif.aluop = alu_tb.aluop;
    eflag = 0;
    #(1);
    if(alu_tb.aluif.z_flag != 1) begin
      eflag += 1;
    end
    /* case 2 */
    alu_tb.aluif.porta = 'hf;
    alu_tb.aluif.portb = 'h0;
    alu_tb.aluop = ALU_AND;
    alu_tb.aluif.aluop = alu_tb.aluop;
    #(1);
    if(alu_tb.aluif.z_flag != 1) begin
      eflag += 1;
    end
    /* case 3 */
    alu_tb.aluif.porta = 123;
    alu_tb.aluif.portb = 123;
    alu_tb.aluop = ALU_SUB;
    alu_tb.aluif.aluop = alu_tb.aluop;
    #(1);
    if(alu_tb.aluif.z_flag != 1) begin
      eflag += 1;
    end
    /* case 4 */
    alu_tb.aluif.porta = 123;
    alu_tb.aluif.portb = 122;
    alu_tb.aluop = ALU_SUB;
    alu_tb.aluif.aluop = alu_tb.aluop;
    #(1);
    if(alu_tb.aluif.z_flag == 1) begin
      eflag += 1;
    end
    if(eflag == 0) begin
      $display("PASSED :: Zero flag testing");
    end else begin
      $error("FAILED :: Zero flag testing");
    end
    // testing Negative flag
    // testing Overflow flag
    $finish;
  end
endprogram

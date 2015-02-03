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
  import cpu_types_pkg::*;
  int error = 0;

  initial begin
    $monitor("opcode = %s, rs = %h, rt =  %h, rd = %h, shamt = %h, funct = %s",
ruif.rdata.opcode, ruif.rdata.rs, ruif.rdata.rt, ruif.rdata.rd, ruif.rdata.shamt, ruif.rdata.funct);
    ruif.iRequest = 1'b1;
    $display("\nAsync testing...");
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    if(ruif.rdata != '0) $error("FAILED :: Async testing");
    else $display("PASSED :: Asynch testing");
    /* testing decoding functionality */
    $display("\nDecoding Testing begin...");
    // test case : RTYPE - ADDU $1, $2, $3
    ruif.iload = 32'h00430821;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != ADDU) error++;
    // test case : RTYPE - ADD $2, $3, $1
    ruif.iload = 32'h00611020;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != ADD) error++;
    // test case : RTYPE - AND $3, $7, $3
    ruif.iload = 32'h00e31824;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != AND) error++;
    // test case : RTYPE - JR $2
    ruif.iload = 32'h00400008;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != JR) error++;
    // test case : RTYPE - NOR $2, $5, $4
    ruif.iload = 32'h00a41027;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != NOR) error++;
    // test case : RTYPE - OR $3, $0, $1
    ruif.iload = 32'h00011825;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != OR) error++;
    // test case : RTYPE - SLT $1, $2, $3
    ruif.iload = 32'h0043082a;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != SLT) error++;
    // test case : RTYPE - SLTU $2, $0, $0
    ruif.iload = 32'h0000102b;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != SLTU) error++;
    // test case : RTYPE - SLL $1, $3, 8
    ruif.iload = 32'h00600a00;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != SLL) error++;
    // test case : RTYPE - SRL $2, $2, 3
    ruif.iload = 32'h004010c2;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != SRL) error++;
    // test case : RTYPE - SUBU $3, $5, $4
    ruif.iload = 32'h00a41823;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != SUBU) error++;
    // test case : RTYPE - SUB $5, $6, $7
    ruif.iload = 32'h00c72822;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != SUB) error++;
    // test case : RTYPE - XOR $1, $0, $1
    ruif.iload = 32'h00010826;
    #(request_unit_tb.PERIOD);
    if(ruif.rdata.opcode != RTYPE && ruif.rdata.funct != XOR) error++;
    // test case : ADDIU $1, $2, 8
    $monitor("opcode = %s, rs = %h, rt = %h, imm = %d", ruif.idata.opcode,ruif.idata.rs, ruif.idata.rt, ruif.idata.imm);
    ruif.iload = 32'h24410008;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != ADDIU && ruif.idata.imm != 8) error++;
    // test case : ADDI $1, $2, 1024
    ruif.iload = 32'h20410400;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != ADDI && ruif.idata.imm != 1024) error++;
    // test case : ANDI $1, $1, 12
    ruif.iload = 32'h3021000c;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != ANDI && ruif.idata.imm != 12) error++;
    // test case : BEQ $1, $2, label1
    ruif.iload = 32'h1022ffff;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != BEQ) error++;
    // test case : BNE $1, $2, label2
    ruif.iload = 32'h1464ffff;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != BNE) error++;
    // test case : LUI $3, 12
    ruif.iload = 32'h3c03000c;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != LUI && ruif.idata.imm != 12) error++;
    // test case : LW $3, 4($1)
    ruif.iload = 32'h8c2c0004;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != LW && ruif.idata.imm != 4) error++;
    // test case : ORI $1, $2, 10
    ruif.iload = 32'h3441000a;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != ORI && ruif.idata.imm != 10) error++;
    // test case : SLTI $2, $3, 100
    ruif.iload = 32'h28620064;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != SLTI && ruif.idata.imm != 100) error++;
    // test case : SLTIU $1, $3, 122
    ruif.iload = 32'h2c61007a;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != SLTIU && ruif.idata.imm != 122) error++;
    // test case : SW $1, 120($1)
    ruif.iload = 32'hac210078;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != SW && ruif.idata.imm != 120) error++;
    // test case : LL $1, 10($1)
    ruif.iload = 32'hc021000a;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != LL && ruif.idata.imm != 10) error++;
    // test case : SC $1, 10($2)
    ruif.iload = 32'he041000a;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != SC && ruif.idata.imm != 10) error++;
    // test case : XORI $2, $2, 1023
    ruif.iload = 32'h384203ff;
    #(request_unit_tb.PERIOD);
    if(ruif.idata.opcode != XORI && ruif.idata.imm != 1023) error++;
    // test case : J label3
    $monitor("opcode = %s, addr = %h", ruif.jdata.opcode, ruif.jdata.addr);
    ruif.iload = 32'h0800001b;
    #(request_unit_tb.PERIOD);
    if(ruif.jdata.opcode != J) error++;
    // test case : JAL label4
    ruif.iload = 32'h0c00001d;
    #(request_unit_tb.PERIOD);
    if(ruif.jdata.opcode != JAL) error++;
    // test case : halt
    ruif.iload = 32'hffffffff;
    #(request_unit_tb.PERIOD);
    if(error > 0) $error("FAILED :: Decoding Test");
    else $display("PASSED :: Decoding Test");

    /* Signal handling */
    $display("\nSignal I/O testing...");
    error = 0;
    // Initializing
    ruif.iRequest = 1'b0;
    ruif.dRequest = 1'b0;
    ruif.memRead = 1'b0;
    ruif.memWrite = 1'b0;
    ruif.dhit = 1'b0;
    ruif.ihit = 1'b0;
    $monitor("iREN = %b, dREN = %b, dWEN = %b", ruif.iREN, ruif.dREN,ruif.dWEN);
    ruif.iRequest = 1'b1;
    @(posedge CLK);
    if(ruif.iREN == 0) error++;
    ruif.ihit = 1'b1;
    @(posedge CLK);
    if(ruif.iREN == 1) error++;
    ruif.ihit = 1'b0;
    ruif.dRequest = 1'b1;
    ruif.memRead = 1'b1;
    @(posedge CLK);
    if(ruif.iREN == 0 && ruif.dREN == 0) error++;
    @(posedge CLK);
    ruif.dhit = 1'b1;
    ruif.ihit = 1'b1;
    #(request_unit_tb.PERIOD);
    if(ruif.iREN == 1 && ruif.dREN == 1) error++;
    ruif.ihit = 1'b0;
    ruif.dhit = 1'b0;
    ruif.memWrite = 1'b1;
    ruif.memRead = 1'b0;
    #(request_unit_tb.PERIOD);
    if(ruif.iREN == 0 && ruif.dWEN == 0) error++;
    ruif.dhit = 1'b1;
    ruif.ihit = 1'b1;
    #(5);
    if(ruif.iREN == 1 && ruif.dWEN == 1) error++;
    if(error > 0) $error("FAILED :: Signal I/O testing");
    else $display("PASSED :: Signal I/O testing");
  end
endprogram

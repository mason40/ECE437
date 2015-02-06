/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/27/2015

    Testbench for control unit decoding
*/

`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module control_unit_tb;
  parameter PERIOD = 20;
  logic CLK = 1, nRST;

  always #(PERIOD/2) CLK++;

  control_unit_if cuif();

  test PROG(CLK, nRST, cuif);

  `ifndef MAPPED
    control_unit DUT(CLK, nRST, cuif);
  `endif
endmodule

program test (input logic CLK, output logic nRST, control_unit_if.cu cuif);
  import cpu_types_pkg::*;
  initial begin
    /* initializing*/
    cuif.vflag = 1'b0;
    cuif.opcode = HALT;
    cuif.func = ADD;
    cuif.iReady = 1'b0;
    cuif.dReady = 1'b0;
    nRST = 1'b0;
    // testing Rtype
    cuif.opcode = RTYPE;
    cuif.func = ADD;
    @(posedge CLK);
    nRST = 1'b1;
    #(1);
    cuif.iReady = 1'b1;
    cuif.dReady = 1'b0;
    // testing LW
    cuif.iReady = 1'b0;
    cuif.dReady = 1'b0;
    @(posedge CLK);
    #(1);
    cuif.opcode = LW;
    cuif.iReady = 1'b1;
    #(control_unit_tb.PERIOD*2);
    #(2);
    cuif.dReady = 1'b1;
    @(posedge CLK);


    /*$monitor("opcode = %s, funct = %s, ALUop = %s, ALUsrc = %b\nregDst = %b, regWrite = %b, memtoReg = %b, memRead = %b, memWrite = %b\nbranch = %b, shift = %b, jump = %2b, extend = %b\n",
              cuif.opcode, cuif.func, cuif.aluop, cuif.alusrc,
              cuif.regDst, cuif.regWrite, cuif.memtoReg, cuif.memRead,cuif.memWrite,
              cuif.branch, cuif.regWrite, cuif.jump, cuif.extend);
    cuif.opcode = RTYPE;
    cuif.func = SLL;
    #(control_unit_tb.PERIOD);
    cuif.func = SRL;
    #(control_unit_tb.PERIOD);
    cuif.func = ADD;
    #(control_unit_tb.PERIOD);
    cuif.func = ADDU;
    #(control_unit_tb.PERIOD);
    cuif.func = SUB;
    #(control_unit_tb.PERIOD);
    cuif.func = SUBU;
    #(control_unit_tb.PERIOD);
    cuif.func = OR;
    #(control_unit_tb.PERIOD);
    cuif.func = XOR;
    #(control_unit_tb.PERIOD);
    cuif.func = NOR;
    #(control_unit_tb.PERIOD);
    cuif.func = SLT;
    #(control_unit_tb.PERIOD);
    cuif.func = SLTU;
    #(control_unit_tb.PERIOD);
    cuif.opcode = BEQ;
    #(control_unit_tb.PERIOD);
    cuif.opcode = BNE;
    cuif.func = NOR;
    #(control_unit_tb.PERIOD);
    cuif.opcode = ADDI;
    #(control_unit_tb.PERIOD);
    cuif.opcode = ADDIU;
    #(control_unit_tb.PERIOD);
    cuif.opcode = SLTI;
    #(control_unit_tb.PERIOD);
    cuif.opcode = SLTIU;
    #(control_unit_tb.PERIOD);
    cuif.opcode = ANDI;
    #(control_unit_tb.PERIOD);
    cuif.opcode = ORI;
    #(control_unit_tb.PERIOD);
    cuif.opcode = XORI;
    #(control_unit_tb.PERIOD);
    cuif.opcode = LUI;
    #(control_unit_tb.PERIOD);
    cuif.opcode = LW;
    #(control_unit_tb.PERIOD);
    cuif.opcode = SW;
    #(control_unit_tb.PERIOD);
    cuif.opcode = J;
    #(control_unit_tb.PERIOD);
    cuif.opcode = RTYPE;
    cuif.func = JR;
    #(control_unit_tb.PERIOD);
    */
  end
endprogram

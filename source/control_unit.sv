/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/26/2015

    Control Unit in Datapath
*/

`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module control_unit (
  input logic CLK, nRST,
  control_unit_if.cu cuif
);

logic [12:0] signals;
logic halt = 1'b0;
logic v;

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    cuif.halt = 0;
  end else begin
    if(v || cuif.instr == 32'hffffffff) begin
      cuif.halt = 1'b1;
    end else begin
      cuif.halt = 1'b0;
    end
  end
end

always_comb begin
  //signals = '0;
  if(cuif.opcode == RTYPE) begin
    casez(cuif.func) // rtype decoding
      SLL : begin
        cuif.aluop = ALU_SLL;
        signals = 13'b1100010000010;
      end
      SRL : begin
        cuif.aluop = ALU_SRL;
        signals = 13'b1100010000010;
      end
      JR : begin
        cuif.aluop = ALU_ADD;
        signals = 13'b0000000001000;
      end
      ADD: begin
        cuif.aluop = ALU_ADD;
        signals = {12'b110000000000,cuif.vflag};
      end
      ADDU: begin
        cuif.aluop = ALU_ADD;
        signals = 13'b1100000000000;
      end
      SUB : begin
        cuif.aluop = ALU_SUB;
        signals = {12'b110000000000,cuif.vflag};
      end
      SUBU: begin
        cuif.aluop = ALU_SUB;
        signals = 13'b1100000000000;
      end
      AND : begin
        cuif.aluop = ALU_AND;
        signals = 13'b1100000000000;
      end
      OR  : begin
        cuif.aluop = ALU_OR;
        signals = 13'b1100000000000;
      end
      XOR : begin
        cuif.aluop = ALU_XOR;
        signals = 13'b1100000000000;
      end
      NOR : begin
        cuif.aluop = ALU_NOR;
        signals = 13'b1100000000000;
      end
      SLT : begin
        cuif.aluop = ALU_SLT;
        signals = {12'b110000000000,cuif.vflag};
      end
      SLTU: begin
        cuif.aluop = ALU_SLTU;
        signals = 13'b1100000000000;
      end
      default : begin
        cuif.aluop = ALU_SLL;
        signals = '0;
      end
    endcase // end of the rtype case
  end else begin
    casez(cuif.opcode) // itype and jtype
      BEQ : begin
        cuif.aluop = ALU_SUB;
        signals = 13'b0000000100000;
      end
      BNE : begin
        cuif.aluop = ALU_SUB;
        signals = 13'b0000000100000;
      end
      ADDI: begin
        cuif.aluop = ALU_ADD;
        signals = {12'b01000000011,cuif.vflag};
      end
      ADDIU: begin
        cuif.aluop = ALU_ADD;
        signals = 13'b0100000000110;
      end
      SLTI: begin
        cuif.aluop = ALU_SLT;
        signals = {12'b010000000011,cuif.vflag};
      end
      SLTIU: begin
        cuif.aluop = ALU_SLTU;
        signals = 13'b0100000000110;
      end
      ANDI: begin
        cuif.aluop = ALU_AND;
        signals = 13'b0100000000010;
      end
      ORI : begin
        cuif.aluop = ALU_OR;
        signals = 13'b0100000000010;
      end
      XORI: begin
        cuif.aluop = ALU_XOR;
        signals = 13'b0100000000010;
      end
      LUI : begin
        cuif.aluop = ALU_ADD;
        signals = 13'b0100001000010;
      end
      LW  : begin
        cuif.aluop = ALU_ADD;
        signals = 13'b0111000000110;
      end
      SW  : begin
        cuif.aluop = ALU_ADD;
        signals = 13'b0000100000110;
      end
      J   : begin
        cuif.aluop = ALU_ADD;
        signals = 13'b0000000011000;
      end
      JAL : begin
        cuif.aluop = ALU_ADD;
        signals = 13'b0100000011000;
      end
      default : begin
        cuif.aluop = ALU_SLL;
        signals = '0;
      end
    endcase // end of itype and jtype
  end
  /*if(signals[0] || cuif.instr == 32'hffffffff) begin
    halt = 1;
  end*/
end

assign cuif.regDst = signals[12];
assign cuif.regWrite = signals[11];
assign cuif.memtoReg = signals[10];
assign cuif.dren = signals[9];
assign cuif.dwen = signals[8];
assign cuif.shift = signals[7];
assign cuif.lui = signals[6];
//assign cuif.branch = signals[5];
assign cuif.jump = signals[4:3];
assign cuif.extend = signals[2];
assign cuif.alusrc = signals[1];
assign cuif.iren = (nRST & ~cuif.halt & ~cuif.dren);
//assign cuif.halt = halt;
always_comb begin
  if(cuif.opcode == BNE) begin
    cuif.branch = 2'b10;
  end else if(cuif.opcode == BEQ) begin
    cuif.branch = 2'b01;
  end else begin
    cuif.branch = 2'b00;
  end
  if((cuif.opcode==SLTI)|(cuif.opcode==ADDI)|(cuif.opcode==RTYPE&cuif.func==ADD)|
     (cuif.opcode==RTYPE&cuif.func==SUB)|(cuif.opcode==RTYPE&cuif.func==SLT)) begin
    v = cuif.vflag;
  end else begin
    v = 1'b0;
  end
end
endmodule

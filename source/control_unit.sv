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
  control_unit_if.cu cuif
);

always_comb begin
  if(cuif.opcode == RTYPE) begin
    casez(cuif.func)
      SLL : cuif.aluop = ALU_SLL;
      SRL : cuif.aluop = ALU_SRL;
      ADD : cuif.aluop = ALU_ADD;
      ADDU: cuif.aluop = ALU_ADD;
      SUB : cuif.aluop = ALU_SUB;
      SUBU: cuif.aluop = ALU_SUB;
      AND : cuif.aluop = ALU_AND;
      OR  : cuif.aluop = ALU_OR;
      XOR : cuif.aluop = ALU_XOR;
      NOR : cuif.aluop = ALU_NOR;
      SLT : cuif.aluop = ALU_SLT;
      SLTU: cuif.aluop = ALU_SLTU;
      JR  : cuif.jump = 2'b01;
      default : cuif.jump = 2'b00;
    endcase
  end else begin
    casez(cuif.opcode)
      BEQ : cuif.aluop = ALU_SLT;
      BNE : cuif.aluop = ALU_SLT;
      ADDI: cuif.aluop = ALU_ADD;
      ADDIU: cuif.aluop = ALU_ADD;
      SLTI: cuif.aluop = ALU_SLT;
      SLTIU: cuif.aluop = ALU_SLTU;
      ANDI: cuif.aluop = ALU_AND;
      ORI : cuif.aluop = ALU_OR;
      XORI: cuif.aluop = ALU_XOR;
      LUI : cuif.aluop = ALU_SLL;
      LW  : cuif.aluop = ALU_ADD;
      LBU : cuif.aluop = ALU_ADD;
      LHU : cuif.aluop = ALU_ADD;
      SB  : cuif.aluop = ALU_ADD;
      SH  : cuif.aluop = ALU_ADD;
      SW  : cuif.aluop = ALU_ADD;
      LL  : cuif.aluop = ALU_ADD;
      SC  : cuif.aluop = ALU_ADD;
      J   : cuif.jump = 2'b10;
      JAL : cuif.jump = 2'b11;
      default : cuif.jump = 2'b00;
    endcase
  end
end

assign cuif.regDst = (cuif.opcode == RTYPE) ? 1 : 0;
assign cuif.alusrc = (cuif.opcode == RTYPE || cuif.opcode == BEQ || cuif.opcode == BNE) ? 0 : 1;
assign cuif.branch = (cuif.opcode == BEQ || cuif.opcode == BNE) ? 1 : 0;
assign cuif.memtoReg = (cuif.opcode == LW  ||
                        cuif.opcode == LBU ||
                        cuif.opcode == LHU) ? 1 : 0;
assign cuif.memWrite = (cuif.opcode == SB  ||
                        cuif.opcode == SH  ||
                        cuif.opcode == SW) ? 1 : 0;
assign cuif.memRead = (cuif.opcode == LW   ||
                       cuif.opcode == LBU  ||
                       cuif.opcode == LHU  ||
                       cuif.opcode == LL) ? 1 : 0;
assign cuif.regWrite = (cuif.opcode == BEQ ||
                        cuif.opcode == BNE ||
                        cuif.opcode == SB  ||
                        cuif.opcode == SW  ||
                        cuif.opcode == SH  ||
                        cuif.opcode == J   ||
                        cuif.opcode == JAL ||
                        cuif.func == JR) ? 0 : 1;
assign cuif.shift = ((cuif.opcode == RTYPE && cuif.func == SLL) ||
                     (cuif.opcode == RTYPE && cuif.func == SRL)) ? 1 : 0;
assign cuif.lui = (cuif.opcode == LUI) ? 1 : 0;
assign cuif.iRequest = 1;
assign cuif.dRequest = cuif.memWrite || cuif.memRead;
assign cuif.extend = (cuif.opcode == ORI || cuif.opcode == XORI || cuif.opcode == ANDI) ? 0 : 1;
assign cuif.halt = (cuif.opcode == HALT || (cuif.vflag && cuif.func != ADDU && cuif.opcode != ADDIU)) ? 1 : 0;

endmodule

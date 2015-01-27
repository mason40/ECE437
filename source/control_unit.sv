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
  control_unit_if cuif
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
      SLUT: cuif.aluop = ALU_SLTU;
    endcase
  end else begin
    casez(cuif.opcode)
      BEQ : cuif.aluop = ALU_ADD;
      BNE : cuif.aluop = ALU_ADD;
      ADDI: cuif.aluop = ALU_ADD;
      ADDIU: cuif.aluop = ALU_ADD;
      SLTI: cuif.aluop = ALU_SLT;
      SLTIU: cuif.aluop = ALU_SLTU;
      ANDI: cuif.aluop = ALU_AND;
      ORI : cuif.aluop = ALU_OR;
      XORI: cuif.aluop = ALU_XOR;
      LUI : cuif.aluop = ALU_ADD;
      LW  : cuif.aluop = ALU_ADD;
      LBU : cuif.aluop = ALU_ADD;
      LHU : cuif.aluop = ALU_ADD;
      SB  : cuif.aluop = ALU_ADD;
      SH  : cuif.aluop = ALU_ADD;
      SW  : cuif.aluop = ALU_ADD;
      LL  : cuif.aluop = ALU_ADD;
      SC  : cuif.aluop = ALU_ADD;
    endcase
  end
end

assign cuif.alusrc = (cuif.aluop == RTYPE) ? 0 : 1;
assign cuif.memtoReg = (cuif.aluop == LUI ||
                        cuif.aluop == LW  ||
                        cuif.aluop == LBU ||
                        cuif.aluop == LHU) 1 : 0;
assign cuif.memWrite = (cuif.aluop == SB  ||
                        cuif.aluop == SH  ||
                        cuif.aluop == SW) 1 : 0;
assign cuif.memRead = (cuif.aluop == LUI  ||
                       cuif.aluop == LW   ||
                       cuif.aluop == LBU  ||
                       cuif.aluop == LHU) 1 : 0;
assign cuif.regWrite = (cuif.aluop == SB  ||
                        cuif.aluop == SH  ||
                        cuif.aluop == SW) 0 : 1;
assign cuif.iRequest = 1;
assign cuif.dRequest = cuif.memWrite || cuif.memRead;
assign cuif.regDst = (cuif.aluop == RTYPE) ? 0 : 1;

endmodule

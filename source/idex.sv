/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/7/2015

    ID/EX register
*/

`include "idex_if.vh"
`include "cpu_types_pkg.vh"

module idex (
  input logic CLK,
  input logic nRST,
  input logic en,
  input logic nop,
  idex_if idex
);
import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST, posedge nop) begin
  if(!nRST) begin
    idex.out_cpc <= 0;
    idex.out_aluop <= ALU_SLL;
    idex.out_regDst <= 0;
    idex.out_alusrc <= 0;
    idex.out_shift <= 0;
    idex.out_lui <= 0;
    idex.out_jump <= 0;
    idex.out_branch <=0;
    idex.out_dren <= 0;
    idex.out_dwen <= 0;
    idex.out_memtoReg <=0;
    idex.out_regWrite <=0;
    idex.out_halt <= 0;
    idex.out_rdat1 <= 0;
    idex.out_rdat2 <= 0;
    idex.out_imm <= 0;
    idex.out_rs <= 0;
    idex.out_rt <= 0;
    idex.out_rd <= 0;
    idex.out_jaddr <= 0;
    idex.out_shamt <= 0;
    idex.out_opcode <= RTYPE;
  end else if(nop) begin
    idex.out_cpc <= 0;
    idex.out_aluop <= ALU_SLL;
    idex.out_regDst <= 0;
    idex.out_alusrc <= 0;
    idex.out_shift <= 0;
    idex.out_lui <= 0;
    idex.out_jump <= 0;
    idex.out_branch <=0;
    idex.out_dren <= 0;
    idex.out_dwen <= 0;
    idex.out_memtoReg <=0;
    idex.out_regWrite <=0;
    idex.out_halt <= 0;
    idex.out_rdat1 <= 0;
    idex.out_rdat2 <= 0;
    idex.out_imm <= 0;
    idex.out_rs <= 0;
    idex.out_rt <= 0;
    idex.out_rd <= 0;
    idex.out_jaddr <= 0;
    idex.out_shamt <= 0;
    idex.out_opcode <= RTYPE;
  end else begin
    if(en) begin
    idex.out_cpc <= idex.in_cpc;
    idex.out_aluop <= idex.in_aluop;
    idex.out_regDst <= idex.in_regDst;
    idex.out_alusrc <= idex.in_alusrc;
    idex.out_shift <= idex.in_shift;
    idex.out_lui <= idex.in_lui;
    idex.out_jump <= idex.in_jump;
    idex.out_branch <= idex.in_branch;
    idex.out_dren <= idex.in_dren;
    idex.out_dwen <= idex.in_dwen;
    idex.out_memtoReg <=idex.in_memtoReg;
    idex.out_regWrite <= idex.in_regWrite;
    idex.out_halt <= idex.in_halt;
    idex.out_rdat1 <= idex.in_rdat1;
    idex.out_rdat2 <= idex.in_rdat2;
    idex.out_imm <= idex.in_imm;
    idex.out_rs <= idex.in_rs;
    idex.out_rt <= idex.in_rt;
    idex.out_rd <= idex.in_rd;
    idex.out_jaddr <= idex.in_jaddr;
    idex.out_shamt <= idex.in_shamt;
    idex.out_opcode <= idex.in_opcode;
    end
   end
end

endmodule


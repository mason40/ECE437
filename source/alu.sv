/*
  Jason Lin
  lin57@purdue.edu
  1/14/2015
  ECE437

  ALU source file
*/

`include "alu_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

// module declaration
module alu (
  alu_if aluif
);

// internal indexing variable
int i;

// combinational block
always_comb begin
  casez(aluif.aluop)
    ALU_SLL : begin
      aluif.portout= aluif.porta << aluif.portb;
    end
    ALU_SRL : begin
      aluif.portout = aluif.porta >> aluif.portb;
    end
    ALU_ADD : begin
      aluif.portout = aluif.porta + aluif.portb;
    end
    ALU_SUB : begin
      aluif.portout = aluif.porta - aluif.portb;
    end
    ALU_AND : begin
      for(i = 0; i < 32; i++) begin
        aluif.portout[i] = aluif.porta[i] & aluif.portb[i];
      end
    end
    ALU_OR  : begin
      for(i = 0; i < 32; i++) begin
        aluif.portout[i] = aluif.porta[i] | aluif.portb[i];
      end
    end
    ALU_XOR : begin
      aluif.portout = aluif.porta ^ aluif.portb;
    end
    ALU_NOR : begin
      for(i = 0; i < 32; i ++) begin
        aluif.portout[i] = ~(aluif.porta[i] | aluif.portb[i]);
      end
    end
  endcase
end

// output assignment

assign aluif.z_flag = (aluif.portout == '0) ? 1 : 0;
assign aluif.n_flag = (aluif.portout[31] == 1'b1) ? 1 : 0;

endmodule

/*
  Jason Lin
  lin57@purdue.edu
  mg208
  1/14/2015

  ALU source file
*/

`include "alu_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

// module declaration
module alu (
  alu_if aluif
);

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
      aluif.portout = aluif.porta & aluif.portb;
    end
    ALU_OR  : begin
      aluif.portout = aluif.porta | aluif.portb;
    end
    ALU_XOR : begin
      aluif.portout = aluif.porta ^ aluif.portb;
    end
    ALU_NOR : begin
      aluif.portout = ~(aluif.porta | aluif.portb);
    end
    ALU_SLT : begin
      if(aluif.porta < aluif.portb) begin
        aluif.portout = 1;
      end else begin
        aluif.portout = 0;
      end
    end
    ALU_SLTU : begin
      if(aluif.porta < aluif.portb) begin
        aluif.portout = 1;
      end else begin
        aluif.portout = 0;
      end
    end
  endcase
end

// output assignment

assign aluif.z_flag = (aluif.portout == 0) ? 1 : 0;
assign aluif.n_flag = (aluif.portout[31] == 1'b1) ? 1 : 0;
assign aluif.v_flag = (~(aluif.porta[31]^aluif.portb[31]))&(aluif.portout[31]^aluif.porta[31]);

endmodule

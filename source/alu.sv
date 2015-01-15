`include "alu_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

// module declaration
module alu (
  alu_if aluif
);

always_comb begin
  casez(aluif.aluop)
    ALU_SLL : begin
      aluif.portout = aluif.porta << aluif.portb;
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
      aluif.portout = aluif.porta && aluif.portb;
    end
    ALU_OR  : begin
      aluif.portout = aluif.porta || aluif.portb;
    end
    ALU_XOR : begin
      aluif.portout = aluif.porta ^ aluif.portb;
    end
    ALU_NOR : begin
      aluif.portout = !(aluif.porta || aluif.portb);
    end
  endcase
end

endmodule

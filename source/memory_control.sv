/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;
  parameter CPUID = 0;
  logic iren, dren, dwen;
  always_ff @(posedge CLK) begin
    iren <= ccif.iREN[CPUID];
    dren <= ccif.dREN[CPUID];
    dwen <= ccif.dWEN[CPUID];
  end
  // priority bus selection
  always_comb begin
    if(!nRST) begin
      ccif.iwait[CPUID] = 1'b0;
      ccif.dwait[CPUID] = 1'b0;
      ccif.iload[CPUID] = '0;
      ccif.dload[CPUID] = '0;
    end
    casez(ccif.ramstate)
      ACCESS : begin
        ccif.iwait[CPUID] = (ccif.dWEN[CPUID]||ccif.dREN[CPUID]) ? 1'b1 : 1'b0;
        ccif.dwait[CPUID] = (ccif.iREN[CPUID] && ~ccif.dREN[CPUID] && ~ccif.dWEN[CPUID]) ? 1'b1 : 1'b0;
        ccif.iload[CPUID] = ccif.ramload;
        ccif.dload[CPUID] = ccif.ramload;
      end
      BUSY : begin
        ccif.iwait[CPUID] = 1'b1;
        ccif.dwait[CPUID] = 1'b1;
        ccif.iload[CPUID] = '0;
        ccif.dload[CPUID] = '0;
      end
      FREE : begin
        ccif.iwait[CPUID] = 1'b1;
        ccif.dwait[CPUID] = 1'b1;
        ccif.iload[CPUID] = '0;
        ccif.dload[CPUID] = '0;
      end
      default : begin
        ccif.iwait[CPUID] = 1'b1;
        ccif.dwait[CPUID] = 1'b1;
        ccif.iload[CPUID] = '0;
        ccif.dload[CPUID] = '0;
      end
    endcase
  end
  //assign ccif.iload[CPUID] = (~ccif.iwait[CPUID]) ? ccif.ramload : ccif.iload[CPUID];
  //assign ccif.dload[CPUID] = (~ccif.dwait[CPUID]) ? ccif.ramload : ccif.dload[CPUID];
  //assign ccif.ramREN = (ccif.dREN[CPUID]&&~ccif.dWEN[CPUID])? ccif.dREN[CPUID] : ccif.iREN[CPUID];
  assign ccif.ramREN = !ccif.dWEN[CPUID] &&(ccif.dREN[CPUID]||ccif.iREN[CPUID]);
  assign ccif.ramWEN = ccif.dWEN[CPUID];
  assign ccif.ramaddr = (ccif.dREN[CPUID]||ccif.dWEN[CPUID])? ccif.daddr[CPUID] : ccif.iaddr[CPUID];
  assign ccif.ramstore = ccif.dstore[CPUID];
endmodule

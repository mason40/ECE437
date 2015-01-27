/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

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

  // priority bus selection
  always_comb begin
    if(!nRST) begin
      ccif.iload[CPUID] = '0;
      ccif.iwait[CPUID] = 0;
      ccif.dload[CPUID] = '0;
      ccif.dwait[CPUID] = 0;
      ccif.ramaddr = '0;
      ccif.ramREN = 0;
      ccif.ramWEN = 0;
      ccif.ramstore = '0;
    end
    casez({ccif.dWEN[CPUID], ccif.dREN[CPUID], ccif.iREN[CPUID]})
      3'b101: begin
        ccif.ramWEN = ccif.dWEN[CPUID];
        ccif.ramREN = 1'b0;
        ccif.ramstore = ccif.dstore[CPUID];
        ccif.ramaddr = ccif.daddr[CPUID];
        ccif.dwait[CPUID] = 1'b1;
        ccif.iwait[CPUID] = 1'b1;
      end
      3'b011: begin
        ccif.ramWEN = 1'b0;
        ccif.ramREN = ccif.dREN[CPUID];
        ccif.ramaddr = ccif.daddr[CPUID];
        ccif.dwait[CPUID] = 1'b1;
        ccif.iwait[CPUID] = 1'b1;
      end
      3'b001: begin
        ccif.ramWEN = 1'b0;
        ccif.ramREN = ccif.iREN[CPUID];
        ccif.ramaddr = ccif.iaddr[CPUID];
        ccif.iwait[CPUID] = 1'b1;
        ccif.dwait[CPUID] = 1'b0;
      end
    endcase
    if(ccif.ramstate == ACCESS) begin
      casez({ccif.dwait[CPUID], ccif.iwait[CPUID]})
        2'b1z: begin
          ccif.dload[CPUID] = ccif.ramload;
          ccif.dwait[CPUID] = 1'b0;
        end
        2'b01: begin
          ccif.iload[CPUID] = ccif.ramload;
          ccif.iwait[CPUID] = 1'b0;
        end
      endcase
    end else begin
      ccif.iload[CPUID] = ccif.iload[CPUID];
      ccif.dload[CPUID] = ccif.dload[CPUID];
      ccif.iwait[CPUID] = ccif.iwait[CPUID];
      ccif.dwait[CPUID] = ccif.dwait[CPUID];
    end
  end

  // Cache port connection

  // RAM port connections for testing testbench only
  cpu_ram_if prif();
  ram RAM(CLK, nRST, prif);
  assign ccif.ramstate = prif.ramstate;
  assign ccif.ramload = prif.ramload;
  assign prif.ramWEN = ccif.ramWEN;
  assign prif.ramREN = ccif.ramREN;
  assign prif.ramaddr = ccif.ramaddr;
  assign prif.ramstore = ccif.ramstore;

endmodule

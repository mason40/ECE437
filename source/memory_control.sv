/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and arbitration for ram
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
  //parameter CPUS = 1;

  //Instruction Load = RAM Load
  assign ccif.iload = ccif.ramload;
  //Data Load = RAM Load
  assign ccif.dload = ccif.ramload;
  //RAM Store = Data Store
  assign ccif.ramstore = ccif.dstore;
  //RAM Write Enable = Data Write Enable[0]
  assign ccif.ramWEN = ccif.dWEN;
  //RAM Read Enable = Data Read Enable[0] ? 1 : Instruction Read Enable & NOT Data Write Enable
  //assign ccif.ramREN = ccif.dREN ? 1 : (ccif.iREN & ~ccif.dWEN);
  assign ccif.ramREN = ccif.iREN[0]|ccif.dREN[0];

  always_comb
  begin

    //If Data Write or Data Read are asserted, set RAM address to data address.
    if(ccif.dWEN || ccif.dREN)
    begin
      ccif.ramaddr = ccif.daddr;
    end

    //If neither signal is asserted, set ram address to instruction address.
    else
    begin
      ccif.ramaddr = ccif.iaddr;
    end

    //Tell instruction and data to wait by default
    ccif.iwait = 1;
    ccif.dwait = 1;

    casez(ccif.ramstate)

      //Data Read, Data Write or Instruction Read means being Accessed
      ACCESS:
      begin
        //IF Data Read or Data Write Enabled: Instruction Waiting, Data not waiting
        if(ccif.dREN || ccif.dWEN)
        begin
          ccif.iwait = 1;
          ccif.dwait = 0;
        end

        //IF Instruction Read Enabled, Instruction not waiting, Data waiting
        else if(ccif.iREN)
        begin
          ccif.iwait = 0;
          ccif.dwait = 1;
        end
      end

    endcase
  end


endmodule

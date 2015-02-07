/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/7/2015

    Interface for if/id register
*/

`ifndef IFID_IF_VH
`define IFID_IF_VH
`include "cpu_types_pkg.vh"

interface ifid_if;
  import cpu_types_pkg::*;
  // input from instruction fetch
  word_t in_iload, in_cpc;
  // output to decode state
  word_t out_iload, out_cpc;
  // modport
  modport ifid (
    //input from instr fetching
    input in_iload, in_cpc,
    //output to decode state
    output out_iload, out_cpc
  );
endinterface
`endif

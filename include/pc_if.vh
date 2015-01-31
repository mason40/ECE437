/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Interface of Program Counter
*/

`ifndef "PC_IF_VH"
`define "PC_IF_VH"

interface pc_if;
  import cpu_types_pkg::*;

  word_t cpc, npc;

  modport  pc(
    input  npc,
    output cpc
  );
endinterface
`endif

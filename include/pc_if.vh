/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Interface of Program Counter
*/

`ifndef PC_IF_VH
`define PC_IF_VH

interface pc_if;
  import cpu_types_pkg::*;

  // output to request unit
  word_t cpc;
  // input from request unit
  //word_t imm; // i type imm
  //word_t regtarget; // JR reg value
  //logic [25:0] jaddr; // j type jump target address
  //logic branch; // branch control signal
  //logic [1:0] jump; // jump control signal 00 : no jump, 01 : j, 10: jr, 11: jal
  // input for program counter
  logic pcen;
  word_t npc;

  modport  pc(
    input npc, pcen,
    output cpc
  );
endinterface
`endif

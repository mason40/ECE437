/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Request Unit Interface
*/

`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH
`include "cpu_types_pkg.vh"
interface request_unit_if;
  import cpu_types_pkg::*;
  word_t d;

  //input from cache
  word_t iload, dload;
  logic ihit, dhit;
  //output to cache
  word_t iaddr, daddr, dstore;
  logic iREN, dREN, dWEN, pcen;
  logic halt;

  // input from datapath
  word_t pc, d_addr, writeData, readData;
  logic iren, dren, dwen;
  // output to datapath
  r_t rdata;
  i_t idata;
  j_t jdata;

  modport ru (
    // input
    input iload, dload, ihit, dhit, pc, d_addr, writeData, iren, dren, dwen, halt,
    // output
    output iaddr, daddr, dstore, iREN, dREN, dWEN, rdata, jdata, idata, readData, pcen
  );

endinterface
`endif

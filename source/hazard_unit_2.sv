/*  Jason Lin
    mg208
    lin57@purdue.edu

    Hazard unit rework
*/

`include "hazard_unit_if.vh"

module hazard_unit_2 (
  input logic CLK,
  input logic nRST,
  hazard_unit_if huif
);

always_comb begin
  //Load Use Hazard detection
  if((huif.idex_op==LW)&((huif.ifid_rs==huif.idex_rs)|(huif.ifid_rt==huif.idex_rs)))begin
    // disable pc
    pcpause = 1'b1;
    // disable ifid
    huif.ifid_en = 1'b0;
    // reset idex
    huif.idex_flush = 1'b1;
  end else begin
    // resume usage
    pcpause = 1'b0;
    huif.ifid_en = 1'b1;
    huif.idex_flush = 1'b0;
  end

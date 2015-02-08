/*
  Jason Lin
  lin57@purdue.edu
  mg208
  1/14/2015

  Register file source file
*/

`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

// module declaration
module register_file(
  input logic CLK,
  input logic nRST,
  register_file_if rfif
);

// internal variable declaration
word_t rfile [32];

always_ff @ (CLK, negedge nRST) begin
  if(~nRST) begin
    rfile <= '{default:'0};
  end else if(rfif.WEN && rfif.wsel != 0) begin
    rfile[rfif.wsel] <= rfif.wdat;
  end
end

always_comb begin
  rfif.rdat1 = rfile[rfif.rsel1];
  rfif.rdat2 = rfile[rfif.rsel2];
end

endmodule

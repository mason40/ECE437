/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Request Unit Source file
*/

`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

module request_unit(
  logic CLK, nRST, request_unit_if.ru ruif
);

word_t instr;

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    instr <= '0;
  end else begin
    instr <= ruif.iaddr;
  end
end

assign ruif.jdata.opcode = instr[31:26];
assign ruif.rdata.opcode = instr[31:26];
assign ruif.idata.opcode = instr[31:26];
endmodule


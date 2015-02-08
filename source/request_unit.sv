/*  Jason Lin
    mg208
    lin57@purdue.edu
    1/31/2015

    Request Unit Source file
*/

`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
module request_unit(
  input logic CLK, nRST, request_unit_if.ru ruif
);
import cpu_types_pkg::*;
logic ihit, dhit;
// latching the data and signal from cpu on clock edge
always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    ruif.dREN <= 0;
    ruif.dWEN <= 0;
    ruif.iREN <= 0;
  end else begin
    ihit <= ruif.ihit;
    dhit <= ruif.dhit;
    if(ruif.ihit) begin
        ruif.dREN <= ruif.dren;
        ruif.dWEN <= ruif.dwen;
        ruif.iREN <= 0;
    end
    if(ruif.dhit) begin
        ruif.dREN <= 0;
        ruif.dWEN <= 0;
        ruif.iREN <= 1;
    end
  end
end
assign ruif.iaddr = ruif.pc;
assign ruif.daddr = ruif.d_addr;
assign ruif.dstore = ruif.writeData;
assign ruif.pcen = nRST && ruif.ihit && ~ruif.dhit;

endmodule


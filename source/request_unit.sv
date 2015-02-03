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

word_t iaddr, daddr, dat;
logic ifetch, dfetch, read, write;
opcode_t opcode;

// latching the data and signal from cpu on clock edge
always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
    iaddr <= '0;
    daddr <= '0;
    dat <= '0;
    ifetch <= 0;
    dfetch <= 0;
    read <= 0;
    write <= 0;
  end else begin
    iaddr <= ruif.pc;
    daddr <= ruif.d_addr;
    dat <= ruif.writeData;
    ifetch <= ruif.iRequest;
    dfetch <= ruif.dRequest;
    read <= ruif.memRead;
    write <= ruif.memWrite;
  end
end

assign ruif.iREN = (ruif.ihit) ? 0 : ifetch;
assign ruif.dREN = (ruif.dhit) ? 0 : dfetch && read;
assign ruif.dWEN = (ruif.dhit) ? 0 : dfetch && write;
assign ruif.iaddr = iaddr;
assign ruif.daddr = daddr;
assign ruif.dstore = dat;

// update when data hit
always_comb begin
  if(ruif.ihit) begin
    // r-type output
    ruif.rdata.opcode = '{ruif.iload[31:26]};
    ruif.rdata.rs = '{ruif.iload[25:21]};
    ruif.rdata.rt = '{ruif.iload[20:16]};
    ruif.rdata.rd = '{ruif.iload[15:11]};
    ruif.rdata.shamt = '{ruif.iload[10:6]};
    ruif.rdata.funct = '{ruif.iload[5:0]};
    // i-type output
    ruif.idata.opcode = '{ruif.iload[31:26]};
    ruif.idata.rs = '{ruif.iload[25:21]};
    ruif.idata.rt = '{ruif.iload[20:16]};
    ruif.idata.imm = '{ruif.iload[15:0]};
    // j-type output
    ruif.jdata.opcode = '{ruif.iload[31:26]};
    ruif.jdata.addr = '{ruif.iload[25:0]};
  end
  if(ruif.dhit) begin
    // memory read
    ruif.readData = ruif.dload;
  end
end

endmodule


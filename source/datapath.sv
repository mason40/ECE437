/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
`include "pc_if.vh"
`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  import cpu_types_pkg::word_t;
  word_t imm, pc;

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
      pc <= '0;
    end else begin
      pc <= pcif.cpc;
    end
  end

  assign imm = (cuif.extend) ? {{8{ruif.idata.imm[15]}}, ruif.idata.imm}
                             : {ruif.idata.imm, '0};
  // import types
  import cpu_types_pkg::*;
  control_unit_if cuif();
  register_file_if rfif();
  alu_if aluif();
  pc_if pcif();
  request_unit_if ruif();

  // pc init
  parameter PC_INIT = 0;

  //mapping control unit, regfile, alu and request unit, pc
  pc PC(CLK, nRST, pcif);
  control_unit CU(CLK, nRST,cuif);
  register_file RF(CLK, nRST, rfif);
  alu ALU(aluif);
  request_unit RU(CLK, nRST, ruif);

  // routing PC inputs
  assign pcif.imm = imm;
  assign pcif.jaddr = ruif.jdata.addr;
  assign pcif.branch = cuif.branch && aluif.z_flag;
  assign pcif.jump = cuif.jump;
  assign pcif.regtarget = rfif.rdat1;
  // routing control unit
  assign cuif.opcode = ruif.rdata.opcode;
  assign cuif.func = ruif.rdata.funct;
  assign cuif.vflag = aluif.v_flag;
  // routing register file
  assign rfif.WEN = cuif.regWrite;
  assign rfif.wsel = (ruif.jdata.opcode == JAL) ? 31 : ((cuif.regDst) ? ruif.rdata.rd : ruif.rdata.rt);
  assign rfif.rsel1 = ruif.rdata.rs;
  assign rfif.rsel2 = ruif.rdata.rt;
  assign rfif.wdat = (ruif.jdata.opcode == JAL) ? pc : ((cuif.memtoReg) ? ruif.readData : aluif.portout);
  //routing ALU
  assign aluif.porta = rfif.rdat1;
  assign aluif.portb = (cuif.alusrc) ? imm :
                       ((cuif.shift) ? ruif.rdata.shamt :
                       ((cuif.lui) ? {ruif.idata.imm,'0} : rfif.rdat2));
  assign aluif.aluop = cuif.aluop;
  // routing request unit
  assign ruif.pc = pcif.cpc;
  assign ruif.d_addr = aluif.portout;
  assign ruif.writeData = rfif.rdat2;
  assign ruif.iRequest = cuif.iRequest;
  assign ruif.dRequest = cuif.dRequest;
  assign ruif.memRead = cuif.memRead;
  assign ruif.memWrite = cuif.memWrite;
  assign ruif.ihit = dpif.ihit;
  assign ruif.dhit = dpif.dhit;
  assign ruif.iload = dpif.imemload;
  assign ruif.dload = dpif.dmemload;
  // routing datapath
  assign dpif.imemREN = ruif.iREN;
  assign dpif.dmemREN = ruif.dREN;
  assign dpif.dmemWEN = ruif.dWEN;
  assign dpif.imemaddr = ruif.iaddr;
  assign dpif.dmemaddr = ruif.daddr;
  assign dpif.dmemstore = ruif.dstore;
  assign dpif.halt = cuif.halt;
endmodule

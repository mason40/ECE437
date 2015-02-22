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
`include "forward_unit_if.vh"
`include "hazard_unit_if.vh"
`include "ifid_if.vh"
`include "idex_if.vh"
`include "exmem_if.vh"
`include "memwb_if.vh"
`include "cpu_types_pkg.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  import cpu_types_pkg::word_t;
  word_t npc;
  logic halt;
  logic enable;

  // import types
  import cpu_types_pkg::*;
  control_unit_if cuif();
  register_file_if rfif();
  alu_if aluif();
  pc_if pcif();
  hazard_unit_if huif();
  forward_unit_if fuif();
  ifid_if ifid();
  idex_if idex();
  exmem_if exmem();
  memwb_if memwb();

  // pc init
  parameter PC_INIT = 0;
  //assign enable = (exmem.out_opcode == LW || exmem.out_opcode == SW) ? dpif.dhit : dpif.ihit;
  //mapping control unit, regfile, alu and request unit, pc
  pc PC(CLK, nRST, pcif);
  control_unit CU(CLK, nRST,cuif);
  register_file RF(CLK, nRST, rfif);
  alu ALU(aluif);
  // hazard unit
  hazard_unit HU(CLK, nRST, huif);
  forward_unit FU(fuif);
  // latch units
  ifid FD(CLK, nRST, huif.ifid_en, huif.ifid_flush, ifid);
  //ifid FD(CLK, nRST, huif.ifid_en, huif.ifid_flush, ifid);
  idex DX(CLK, nRST, huif.idex_en, huif.idex_flush, idex);
  exmem XM(CLK, nRST, huif.exmem_en, huif.exmem_flush,exmem);
  memwb MB(CLK, nRST, huif.memwb_en, memwb);
  //ifid FD(CLK, nRST, dpif.ihit&~dpif.dhit, dpif.dhit, ifid);
  //idex DX(CLK, nRST, dpif.ihit|dpif.dhit, idex);
  //exmem XM(CLK, nRST, dpif.ihit|dpif.dhit, exmem);
  //memwb MB(CLK, nRST, dpif.ihit|dpif.dhit, memwb);

  // hazard unit connections
  assign huif.opcode = opcode_t'(dpif.imemload[31:26]);
  assign huif.ifid_op = opcode_t'(ifid.out_iload[31:26]);
  assign huif.idex_op = idex.out_opcode;
  assign huif.exmem_op = exmem.out_opcode;
  assign huif.memwb_op = memwb.out_opcode;
  //assign huif.opcode = opcode_t'(ifid.out_iload[31:26]);
  assign huif.ihit = dpif.ihit;
  assign huif.dhit = dpif.dhit;
  assign huif.instr = dpif.imemload;
  assign huif.branch = ((exmem.out_branch==2'b01)&exmem.out_zflag)|((exmem.out_branch==2'b10)&~exmem.out_zflag);

  // forwarding unit connections
  assign fuif.idex_rs = idex.out_rs;
  assign fuif.idex_rt = idex.out_rt;
  assign fuif.exmem_rd = exmem.out_wsel;
  assign fuif.memwb_rd = memwb.out_wsel;
  assign fuif.exmem_regW = exmem.out_regWrite;
  assign fuif.memwb_regW = memwb.out_regWrite;
  assign fuif.exmem_op = exmem.out_opcode;
  assign fuif.memwb_op = memwb.out_opcode;
  assign fuif.ri_enable = huif.ri_enable;
  assign fuif.lw = huif.lw;
  // fetch state
  //assign pcif.pcen = (huif.pcpause) ? 1'b0 : nRST & dpif.ihit & ~dpif.dhit;
  assign pcif.pcen = ~huif.pcpause;
  // next program counter loc
  always_comb begin
    if(memwb.out_jump == 2'b00) begin
      if(((exmem.out_branch==2'b01)&exmem.out_zflag)|((exmem.out_branch==2'b10)&~exmem.out_zflag)) begin
        pcif.npc = ({{16{exmem.out_imm[15]}},16'h0000}|exmem.out_imm <<2)+(exmem.out_cpc+4);
      end else begin
        pcif.npc = pcif.cpc + 4;
      end
    end else if(memwb.out_jump == 2'b11) begin
      pcif.npc = exmem.out_cpc+4;
      pcif.npc = {pcif.npc[31:28],memwb.out_jaddr,2'b00};
    end else if(memwb.out_jump == 2'b01) begin
      pcif.npc = memwb.out_regtarget;
    end else begin
      pcif.npc = pcif.cpc+4;
    end
  end
  assign dpif.imemaddr = pcif.cpc;
  assign ifid.in_cpc = pcif.cpc;
  assign ifid.in_iload = dpif.imemload;
  always_comb begin
    if(!nRST | memwb.out_halt | dpif.dmemREN | dpif.dmemWEN) begin
      dpif.imemREN = 0;
    end else begin
      dpif.imemREN = 1;
    end
  end
  // decode state
  assign cuif.opcode = opcode_t'(ifid.out_iload[31:26]);
  assign cuif.func = funct_t'(ifid.out_iload[5:0]);
  assign cuif.vflag = aluif.v_flag;
  assign cuif.instr = ifid.out_iload;
  assign rfif.rsel1 = regbits_t'(ifid.out_iload[25:21]);
  assign rfif.rsel2 = regbits_t'(ifid.out_iload[20:16]);
  assign idex.in_cpc = ifid.out_cpc;
  assign idex.in_aluop = cuif.aluop;
  assign idex.in_regDst = cuif.regDst;
  assign idex.in_alusrc = cuif.alusrc;
  assign idex.in_shift = cuif.shift;
  assign idex.in_lui = cuif.lui;
  assign idex.in_jump = cuif.jump;
  assign idex.in_branch = cuif.branch;
  assign idex.in_dren = cuif.dren;
  assign idex.in_dwen = cuif.dwen;
  assign idex.in_memtoReg = cuif.memtoReg;
  assign idex.in_regWrite = cuif.regWrite;
  assign idex.in_halt = cuif.halt;
  assign idex.in_rdat1 = rfif.rdat1;
  assign idex.in_rdat2 = rfif.rdat2;
  assign idex.in_imm = (cuif.extend) ? {{16{ifid.out_iload[15]}},ifid.out_iload[15:0]} : {16'h0000, ifid.out_iload[15:0]};
  assign idex.in_rs = regbits_t'(ifid.out_iload[25:21]);
  assign idex.in_rt = regbits_t'(ifid.out_iload[20:16]);
  assign idex.in_rd = regbits_t'(ifid.out_iload[15:11]);
  assign idex.in_jaddr = ifid.out_iload[25:0];
  assign idex.in_shamt = ifid.out_iload[10:6];
  assign idex.in_opcode = opcode_t'(ifid.out_iload[31:26]);
  // execute state
  //assign aluif.porta = idex.out_rdat1;
  // alu porta with forwarding unit
  always_comb begin
    casez(fuif.alu1)
      2'b10: begin
        aluif.porta = (fuif.lw)?dpif.dmemload:exmem.out_aluout;
      end
      2'b01: begin
        aluif.porta = (fuif.lw)?memwb.out_readData:memwb.out_aluout;
      end
      2'b00: begin
        aluif.porta = idex.out_rdat1;
      end
      default: begin
        aluif.porta = idex.out_rdat1;
      end
    endcase
  end
  // alu portb with forwarding unit
  always_comb begin
    casez(fuif.alu2)
      2'b10: begin
        aluif.portb = (fuif.lw)?dpif.dmemload:exmem.out_aluout;
      end
      2'b01: begin
        aluif.portb = (fuif.lw)?memwb.out_readData:memwb.out_aluout;
      end
      2'b00: begin
        if(idex.out_alusrc) begin
          if(idex.out_shift) begin
            aluif.portb = idex.out_shamt;
          end else if(idex.out_lui) begin
            aluif.portb = idex.out_imm << 16;
          end else begin
            aluif.portb = idex.out_imm;
          end
        end else begin
          aluif.portb = idex.out_rdat2;
        end
      end
      default: begin
        aluif.portb = idex.out_rdat2;
      end
    endcase
  end
  assign aluif.aluop = idex.out_aluop;
  assign exmem.in_cpc = idex.out_cpc;
  assign exmem.in_regWrite = idex.out_regWrite;
  assign exmem.in_memtoReg = idex.out_memtoReg;
  assign exmem.in_halt = idex.out_halt;
  assign exmem.in_jump = idex.out_jump;
  assign exmem.in_branch = idex.out_branch;
  assign exmem.in_zflag = aluif.z_flag;
  assign exmem.in_dren = idex.out_dren;
  assign exmem.in_dwen = idex.out_dwen;
  assign exmem.in_wsel = (idex.out_regDst) ? idex.out_rd : idex.out_rt;
  assign exmem.in_aluout = aluif.portout;
  assign exmem.in_writeData = (fuif.write)? exmem.out_aluout : idex.out_rdat2;
  assign exmem.in_imm = idex.out_imm;
  assign exmem.in_jaddr = idex.out_jaddr;
  assign exmem.in_opcode = idex.out_opcode;
  assign exmem.in_regtarget = idex.out_rdat1;
  //mem state
  assign dpif.dmemREN = exmem.out_dren;
  assign dpif.dmemWEN = exmem.out_dwen;
  assign dpif.dmemaddr = exmem.out_aluout;
  assign dpif.dmemstore = (fuif.write==1) ? exmem.out_aluout : exmem.out_writeData;
  //assign dpif.dmemstore = exmem.out_writeData;
  assign memwb.in_regWrite = exmem.out_regWrite;
  assign memwb.in_memtoReg = exmem.out_memtoReg;
  assign memwb.in_halt = exmem.out_halt;
  assign memwb.in_readData = (dpif.dhit) ? dpif.dmemload : memwb.in_readData;
  assign memwb.in_aluout = exmem.out_aluout;
  assign memwb.in_opcode = exmem.out_opcode;
  assign memwb.in_jaddr = exmem.out_jaddr;
  assign memwb.in_cpc = exmem.out_cpc;
  assign memwb.in_regtarget = exmem.out_regtarget;
  assign memwb.in_wsel = exmem.out_wsel;
  assign memwb.in_jump = exmem.out_jump;
  // write back state
  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
      halt <= 0;
    end else begin
      halt <= memwb.out_halt;
    end
  end
  assign dpif.halt = halt;
  assign npc = memwb.out_cpc + 4;
  assign rfif.wdat = (memwb.out_opcode == JAL) ? (memwb.out_cpc+4) : ((memwb.out_memtoReg) ? memwb.out_readData : memwb.out_aluout);
  assign rfif.WEN = memwb.out_regWrite;
  assign rfif.wsel = (memwb.out_opcode == JAL) ? 31 : memwb.out_wsel;
endmodule

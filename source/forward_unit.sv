/*  Jason Lin
    mg208
    lin57@purdue.edu
    2/12/2015

    Forwarding unit to solve RAW hazard
*/

`include "forward_unit_if.vh"

module forward_unit (
  forward_unit_if fuif
);
import cpu_types_pkg::*;

logic [1:0] forward_a, forward_b;

always_comb begin
    fuif.write = 1'b0;
  // forward A control

    if((fuif.idex_rs==fuif.exmem_rd)&fuif.exmem_regW&(fuif.exmem_rd!=0)&fuif.ri_enable) begin
      forward_a = 2'b10;
      if(fuif.lw) begin
        fuif.write = 1'b1;
      end
    end
    else if((fuif.idex_rs==fuif.memwb_rd)&fuif.memwb_regW&(fuif.memwb_rd !=0)&fuif.ri_enable) begin
      forward_a = 2'b01;
      if(fuif.lw) begin
        fuif.write = 1'b1;
      end
    end
    else begin
      forward_a = 2'b00;
    end
    // forward B control
    if((fuif.idex_rt==fuif.exmem_rd)&fuif.exmem_regW&(fuif.exmem_rd!=0)&fuif.ri_enable) begin
      forward_b = 2'b10;
      if(fuif.lw) begin
        fuif.write = 1'b1;
      end
    end
    else if((fuif.idex_rt==fuif.memwb_rd)&fuif.memwb_regW&(fuif.memwb_rd!=0)&fuif.ri_enable) begin
      forward_b = 2'b01;
      if(fuif.lw) begin
        fuif.write = 1'b1;
      end
    end
    else begin
      forward_b = 2'b00;
    end
    // itype
    if((fuif.idex_rs==fuif.memwb_rd)&(fuif.memwb_rd!=0)&~fuif.ri_enable) begin
      forward_a = 2'b01;
      if(fuif.lw) begin
        fuif.write = 2'b01;
      end
    end else if((fuif.idex_rs==fuif.exmem_rd)&(fuif.exmem_rd!=0)&~fuif.ri_enable) begin
      forward_a = 2'b10;
      if(fuif.lw) begin
        fuif.write = 2'b01;
      end
    //end else begin
    //  forward_a = 2'b00;
    end
    if((fuif.idex_rt ==fuif.exmem_rd)&fuif.exmem_regW&(fuif.exmem_rd!=0)&~fuif.ri_enable) begin
      fuif.write = 2'b11;
    end else if((huif.idex_rt ==fuif.memwb_rd)&fuif.exmem_regW&(fuif.exmem_rd!=0) & ~fuif.ri_enable) begin
      fuif.write = 2'b10;
    end else begin
      fuif.write = 2'b00;
    end
end

assign fuif.alu1 = forward_a;
assign fuif.alu2 = (forward_a == forward_b)? 2'b00 : forward_b;

endmodule

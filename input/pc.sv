`include "mycpu.svh"

import mycpu_pkg::*;

module pc
  (
   input logic 		 clk,
   input logic 		 rst_n,
   input logic [1:0] 	 ps_in,
   input logic [15:0]  ia_in,
   input logic [15:0]  ra_in,
   output logic [15:0] pc_out
   );

logic [15:0] pc_r;
ps_t ps_op;
assign ps_op = pc_t'(ps_in);

always_ff @(posedge clk or negedge rst_n)
begin : pc_regs
  if (rst_n == '0)
    pc_r = '0;
  else
    begin : synchronous_function
      case (ps_op)
        mycpu_pkg::PC_NOP : pc_r = pc_r;
        mycpu_pkg::PC_INC : pc_r += 1;
        mycpu_pkg::PC_BRA : pc_r += ia_in;
        mycpu_pkg::PC_JMP : pc_r = ra_in;
      endcase
    end : synchronous_function
end : pc_regs

assign pc_out = pc_r;

endmodule


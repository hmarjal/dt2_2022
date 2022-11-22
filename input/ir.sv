`include "mycpu.svh"

import mycpu_pkg::*;

module ir
  (
   input logic 	       clk,     // Rising-edge sensitive clock signal input.
   input logic 	       rst_n,   // Active-low, asynchronous reset signal input.	
   input logic 	       il_in,   // Instruction load enable.
   input logic [15:0]  ins_in,  // Instruction word input.
   output logic [15:0] ins_out, // Instruction register output.	
   output logic [15:0] ia_out,  // Instruction register (IR) immediate branch address extended to 16-bit signed 2's complement format.
   output logic [15:0] iv_out   // Instruction register (IR) immediate value extended to 16-bit unsigned format.
   );


always_ff @(posedge clk or negedge rst_n)

begin : ir_regs
  if(rst_n == '0)
    begin
      ir_r = '0;
    end
  else
    begin
      ir_r = ins_in;
    end
end : ir_regs

// TODO: Recheck
always_comb
  begin : ia_logic
    logic ia_temp[5:0];
    ia_temp =  = { ir_r[2:0], ir_r[8:6] };
    assign result = { 16{a[31]}, a };
  end : ia_logic

"Combinational function of signal ia:
Bits ir_r[8:6] and ir_r[2:0] are concatenated into a 6-bit value,
which is treated as a signed 2's complement format binary number
and sign-extended to 16-bits and assigned to ia."			

always_comb
  begin : iv_logic
    assign result = { 16{ir_r[2:0]}, ir_r };
  end : iv_logic


// ins_out driver
assign ins_out = ir_r;
// ia_out driver
assign ia_out = ia;
// iv_driver
assign iv_out = iv;
   
   
endmodule



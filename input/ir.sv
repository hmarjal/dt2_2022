`include "mycpu.svh"

import mycpu_pkg::*;

module ir
  (
   input logic 	       clk,       // Rising-edge sensitive clock signal input.
   input logic 	       rst_n,     // Active-low, asynchronous reset signal input.
   input logic 	       il_in,     // Instruction load enable.
   input logic  [15:0] ins_in,    // Instruction word input.
   output logic [15:0] ins_out,   // Instruction register output.
   output logic [15:0] ia_out,    // Instruction register (IR) immediate branch address extended to 16-bit signed 2's complement format.
   output logic [15:0] iv_out     // Instruction register (IR) immediate value extended to 16-bit unsigned format.
   );

  // internal register for Instruction register
  logic [15:0] ir_r;
  // internal register for Instruction vector
  logic [15:0] iv;
  // internal register for Immediate address
  reg signed [15:0] ia;


  always_ff @(posedge clk or negedge rst_n)
  begin : ir_regs
    if (rst_n == '0)
      begin
        ir_r <= '0;
      end
    else
      begin
        // if il_in == '1, ins_in is loaded into ir_r on the rising edge of clk
        if (il_in == '1)
          begin
            ir_r <= ins_in;
          end
          // otherwise ir_r retains its state
        else
          begin
            // is this needed?
            ir_r <= ir_r;
          end
      end
  end : ir_regs

  always_comb
    begin : ia_logic
      // bits ir_r[8:6] and ir[2:0] are concatenated into a 6-bit value, which is treated
      // as a 2's complement format binary number and sign-extended to 16-bits and assigned to ia
      ia = $signed({{10{ir_r[8]}}, ir_r[8:6], ir_r[2:0]});
    end : ia_logic


  always_comb
    begin : iv_logic
      iv = {13'b0, ir_r[2:0]};
    end : iv_logic


  // ins_out driver
  assign ins_out = ir_r;
  // ia_out driver
  assign ia_out = ia;
  // iv_driver
  assign iv_out = iv;


endmodule


`include "mycpu.svh"

import mycpu_pkg::*;

module mycpu
  (
   input logic 	       clk,
   input logic 	       rst_n,
   output logic [15:0] a_out, 
   input logic [15:0]  d_in,
   output logic [15:0] d_out,
   input logic [15:0]  io_in,
   output logic        wen_out,
   output logic        iom_out
   );

   

endmodule 

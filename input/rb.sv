`include "mycpu.svh"

import mycpu_pkg::*;

module rb
  (
   input logic 	       clk,
   input logic 	       rst_n,
   input logic [15:0]  d_in,
   input logic 	       rw_in,
   input logic [11:0]   rs_in,
   output logic [15:0] a_out,
   output logic [15:0] b_out
   );


endmodule


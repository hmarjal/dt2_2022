`ifndef SYNTHESIS

`include "mycpu.svh"

import mycpu_pkg::*;

program mux_3x16_test
  (
   input logic 	       clk,
   input logic 	       rst_n,
   output logic [1:0]  sel_in,
   output logic [15:0] d0_in,
   output logic [15:0] d1_in,
   output logic [15:0] d2_in, 
   input logic [15:0]  m_out
   );

   /////////////////////////////////////////////////////////////
   // Write a test program below
   /////////////////////////////////////////////////////////////


endprogram

`endif

`include "mycpu.svh"

import mycpu_pkg::*;

module mux_3x16
  (input logic [1:0] sel_in,
   input logic [15:0]  d0_in,
   input logic [15:0]  d1_in,
   input logic [15:0]  d2_in,   
   output logic [15:0] m_out);
   
endmodule

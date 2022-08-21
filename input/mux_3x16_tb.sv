`ifndef SYNTHESIS

`include "mycpu.svh"

import mycpu_pkg::*;


module mux_3x16_tb  #(parameter DUT_VS_REF_SIMULATION = 0);
   logic clk;
   logic rst_n;   
   logic [1:0] sel_in;
   logic [15:0] d0_in;
   logic [15:0] d1_in;
   logic [15:0] d2_in;   
   logic [15:0] m_out;

   
`ifdef RTL_SIM
 `include "mycpu_svabind.svh"   
`endif 
   
endmodule

`endif      
   

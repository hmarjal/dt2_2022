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


   
endmodule 
   

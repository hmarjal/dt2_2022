`include "mycpu.svh"

import mycpu_pkg::*;

module fu
  (
   input logic [15:0]  a_in,
   input logic [15:0]  b_in, 
   input logic [3:0] 	 fs_in,
   output logic [15:0] f_out,
   output logic 	 z_out,
   output logic 	 n_out
   );
   
   fs_t fs;
   assign fs = fs_t'(fs_in);

   
   
endmodule

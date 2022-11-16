`include "mycpu.svh"

import mycpu_pkg::*;

module cu
  (
   input logic 		clk,
   input logic 		rst_n,
   input logic [15:0] ins_in,
   input logic 		z_in,
   input logic 		n_in,
   output logic 	il_out,
   output logic [1:0] 	ps_out,
   output logic 	rw_out,
   // TODO: Check the correct width for rs_out. 9 bits or 12 bits?
   output logic [11:0] 	rs_out,
   output logic 	mm_out,
   output logic [1:0] 	md_out,
   output logic 	mb_out,
   output logic [3:0] 	fs_out,
   output logic 	wen_out,
   output logic 	iom_out   
   );

   cu_state_t st_r, ns;   
   opcode_t    opcode;

   assign opcode = opcode_t'(ins_in[15:9]);

   // To do:  Write code below - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  //
   
endmodule
               
   

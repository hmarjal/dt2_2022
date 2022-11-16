`include "mycpu.svh"

import mycpu_pkg::*;

program rb_test
  (
   input logic 		 clk,
   input logic 		 rst_n,
   output logic [15:0] d_in,
   output logic 	 rw_in,
   output logic [11:0] 	 rs_in,
   input logic [15:0]  a_out,
   input logic [15:0]  b_out
   );

   logic [15:0] 	 patterns [16];
   
   initial
     begin
	///////////////////////////////////////////////////////////////////////
	$info("T1: Reset Test");
	///////////////////////////////////////////////////////////////////////	
	d_in = '0;
	rw_in = '0;
	rs_in = '0;
	wait (rst_n);

	///////////////////////////////////////////////////////////////////////	
	$info("T2: Read-Write Test");
	///////////////////////////////////////////////////////////////////////

		     
	$finish;
     end
endprogram

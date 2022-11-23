`ifndef SYNTHESIS

`include "mycpu.svh"

import mycpu_pkg::*;

program pc_test
  (
   input logic 		 clk,
   input logic 		 rst_n,
   output logic [1:0] 	 ps_in,
   output logic [15:0] ia_in,
   output logic [15:0] ra_in, 
   input logic [15:0]  pc_out      
   );

   initial
     begin : test_program_counter
     
       $info("T1: Reset Test");
       ps_in = 2'b00;
       ia_in = 16'b00000000_00000000;
       ra_in = 16'b00000000_00000000;
       wait (rst_n);
       @(negedge clk);
      // assert (pc_r == '0)
      // else $error("Reset test failed!");     
	
	    $info("T2: Program Counter Test");
	    ps_in = 2'b00;
	    @(negedge clk);
	    assert (pc_out == '0);
	    
	
	$finish;	
     end   
   
endprogram


`endif

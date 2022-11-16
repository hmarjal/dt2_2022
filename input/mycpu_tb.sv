`include "mycpu.svh"

`ifndef SYNTHESIS

import mycpu_pkg::*;

module mycpu_tb #(parameter DUT_VS_REF_SIMULATION = 0);
   
   logic clk;
   logic rst_n;
   logic wen_out;
   logic [15:0] a_out; 
   logic [15:0] d_in;
   logic [15:0] d_out;
   logic 	  iom_out;
   logic [15:0] io_in;
   localparam int 	 SIMULATION_CYCLES = 4000;   // Max. clock cycle sto simulate
   int 			 cycle_counter;

   mycpu DUT_INSTANCE (.*);
   mycpu_test TEST (.*);

   // Reference model instantiation for gates vs. RTL, or post-layout vs-gates
   // simulations.
   
   generate
      if (DUT_VS_REF_SIMULATION) begin : REF_MODEL
	 logic [15:0] ref_d_in;
	 logic [15:0] ref_io_in;
	 logic [15:0] ref_a_out; 
	 logic [15:0] ref_d_out;
	 logic 	      ref_wen_out;
	 logic 	      ref_iom_out;
	 
	 mycpu REF_INSTANCE
	   (.clk(clk),
	    .rst_n(rst_n),
	    .d_in(ref_d_in),
	    .io_in(ref_io_in),
	    .a_out(ref_a_out),
	    .d_out(ref_d_out),
	    .wen_out(ref_wen_out),
	    .iom_out(ref_iom_out)
	    );

	 mycpu_test REF_TEST
	   (.clk(clk),
	    .rst_n(rst_n),
	    .d_in(ref_d_in),
	    .io_in(ref_io_in),
	    .a_out(ref_a_out),
	    .d_out(ref_d_out),
	    .wen_out(ref_wen_out),	    
	    .iom_out(ref_iom_out)
	    );
	 
      end 
   endgenerate


   initial
     begin
	clk = '0;
	cycle_counter = 0;
	#(CLK_PERIOD/2.0);	
	forever
	  begin
	     if (clk == '0)
	       clk = '1;
	     else
	       begin
		  clk = '0;
		  cycle_counter = cycle_counter + 1;
		  if (cycle_counter >= SIMULATION_CYCLES)
		    $finish;
	       end
	     #(CLK_PERIOD/2.0);
	  end
     end
   
   initial
     begin
	rst_n = '0;
	@(negedge clk);
	@(negedge clk);	
	rst_n = '1;
     end

`ifdef RTL_SIM
`include "mycpu_svabind.svh"   
`endif 
   

   

`ifdef ENABLE_CPU_REPORTER   

   generate
      if (!DUT_VS_REF_SIMULATION) 
	begin : REPORTER
	   
	 initial
	   begin
	      int file;
	      file = $fopen("reports/mycpu_simulation.txt", "w");
	      
	      wait (rst_n);
	      $fdisplay(file, "==============================================================================================================================================================================================================================");
	      $fdisplay(file, "                CONTROL UNIT                      |           CONTROL WORD            |                                             REGISTERS                                           |       BUSES       | FLG |   I/O   |");
	      
	      $fdisplay(file, "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	      
	      $fdisplay(file, "  PC STATE    NS PS IL                  IR OPCODE |             RS RW MM MD MB     FS |    R0    R1    R2    R3    R4    R5    R6    R7    R8    R9   R10   R11   R12   R13   R14   R15 | A_Bus B_Bus D_Bus | Z N | WEN IOM | ");
	      $fdisplay(file, "==============================================================================================================================================================================================================================");
	      
	      forever
		begin
		   @(posedge clk iff rst_n == '1);
		   $fwrite(file, "%4d %5s %5s %2b  %1b %7b_%3b_%3b_%3b %6s | %4b_%4b_%4b  %1b  %1b %2b  %1b  %5s | %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d | %5d %5d %5d | %1b %1b |   %1b   %1b |", 
			     DUT_INSTANCE.PC.pc_r,
			     DUT_INSTANCE.CU.st_r.name() ,
			     DUT_INSTANCE.CU.ns.name() ,
			     DUT_INSTANCE.ps ,
			     DUT_INSTANCE.il,
			     DUT_INSTANCE.IR.ir_r[15:9],
			     DUT_INSTANCE.IR.ir_r[8:6],
			     DUT_INSTANCE.IR.ir_r[5:3],
			     DUT_INSTANCE.IR.ir_r[2:0],
			     DUT_INSTANCE.CU.opcode.name(),						 
			     DUT_INSTANCE.rs[11:8],
			     DUT_INSTANCE.rs[7:4],						
			     DUT_INSTANCE.rs[3:0],
			     DUT_INSTANCE.CU.rw_out,															
			     DUT_INSTANCE.CU.mm_out,
			     DUT_INSTANCE.CU.md_out,
			     DUT_INSTANCE.CU.mb_out,			
			     DUT_INSTANCE.FU.fs.name(),
			     DUT_INSTANCE.RB.rb_r[0],
			     DUT_INSTANCE.RB.rb_r[1],
			     DUT_INSTANCE.RB.rb_r[2],
			     DUT_INSTANCE.RB.rb_r[3],
			     DUT_INSTANCE.RB.rb_r[4],
			     DUT_INSTANCE.RB.rb_r[5],
			     DUT_INSTANCE.RB.rb_r[6],
			     DUT_INSTANCE.RB.rb_r[7],
			     DUT_INSTANCE.RB.rb_r[8],
			     DUT_INSTANCE.RB.rb_r[9],
			     DUT_INSTANCE.RB.rb_r[10],
			     DUT_INSTANCE.RB.rb_r[11],
			     DUT_INSTANCE.RB.rb_r[12],
			     DUT_INSTANCE.RB.rb_r[13],
			     DUT_INSTANCE.RB.rb_r[14],
			     DUT_INSTANCE.RB.rb_r[15],
			     DUT_INSTANCE.abus,
			     DUT_INSTANCE.bbus,						
			     DUT_INSTANCE.dbus,	
			     DUT_INSTANCE.z,
			     DUT_INSTANCE.n,
			     DUT_INSTANCE.wen_out,
			     DUT_INSTANCE.iom_out			       			       
			     );
		   if ( DUT_INSTANCE.iom_out )
		     begin
			if (DUT_INSTANCE.wen_out == '1 )
			  $fwrite(file, "IN:  %d", DUT_INSTANCE.io_in);
			else
			  $fwrite(file, "OUT: %d", DUT_INSTANCE.d_out);
		     end
		   $fwrite(file, "\n");
		   if (DUT_INSTANCE.CU.st_r == HLT)
		     begin
			@(negedge clk);
			$finish;
		     end
		end
	   end
      end : REPORTER
      endgenerate
	
`endif

endmodule 



`endif

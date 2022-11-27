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
      assert (pc_out == '0)
      else $error("Reset test failed!");
      @(negedge clk);

	    $info("T2: PC_INC Test");
      logic [15:0] test_value;
      test_value = pc_out;
	    ps_in = mycpu_pkg::PC_INC;
	    @(negedge clk);
	    assert (pc_out == test_value + 1)
      else $error("Increment test failed");
      @(negedge clk);

      $info("T3: PC_NOP Test");
      ps_in = mycpu_pkg::PC_NOP;
      @(negedge clk);
      assert (pc_op == test_value)
      else $error("NO-OP test failed");
      @(negedge clk);

      $info("T4: PC_BRA Test");
      ia_in = 16'hFF55FF55;
      ps_in = mycpu_pkg::PC_BRA;
      @(negedge clk);
      assert (pc_op == ($signed(16'hFF55FF55) + 1))
      else $error("Branching test failed");
      @(negedge clk);

      $info("T5: PC_JMP Test");
      ra_in = 16'h55AA55AA55;
      test_value = ra_in + pc_r;
      @(negedge clk);
      assert (pc_op == test_value)
      else $error("Jump test failed");
      @(negedge clk);
	  $finish;
  end

endprogram

`endif

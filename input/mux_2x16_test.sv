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
    initial
        begin : test_program

        sel_in = '0;
        d0_in = '0;
        d1_in = '0;
        d2_in = '0;
        
        wait(rst_n);

        $info("T1");

        repeat (50) begin
        @(negedge clk);
        sel_in = $urandom;
        d0_in = $urandom;
        d1_in = $urandom;
        d2_in = $urandom;
        @(posedge clk);
        assert ((sel_in == 2'b00) && (d0_in == m_out) ||
                (sel_in == 2'b01) && (d1_in == m_out) ||
                (sel_in == 2'b10) && (d2_in == m_out) ||
                (sel_in == 2'b11) && (d0_in == '0));
        else
            begin
                $error("mux_3x16 tests failed!");
                $info("Dumping input and output values:")
                $info(sel_in);
                $info(d0_in);
                $info(d1_in);
                $info(d2_in);
                $info(m_out);
            end // error prints

        end // repeat 50
        $finish;
    end : test_program

endprogram

`endif
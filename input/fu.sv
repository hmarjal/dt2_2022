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
/*
    function logic is_zero_out (input [15:0] a);
      begin
        if ((a & 0xff) == 0)
        begin
          return '1;
        else
          return '0;
        end
      end
    endfunction : is_zero_out;
*/
  always_comb
  begin : fu_logic
    case (fs)
      mycpu_pkg::MOVA :
      begin
          f_out = a_in;  
          // z_out = is_zero_out(a_in);
          z_out = (a_in == '0);
          n_out = '0;
      end

      // Increment A, does not saturate
      // Output flags are always '0
      mycpu_pkg::FINC :
      begin
        f_out = a_in + 1;
        z_out = '0;
        n_out = '0;
      end

      mycpu_pkg::FDEC :
      begin
        f_out = a_in - 1;
        z_out = ((f_out & 0xff) == 0);
        n_out = '0;
      end
      // ADD, OUT = A_in + B_in
      mycpu_pkg::FADD :
      begin
        f_out = a_in + b_in;
        z_out = '0;
        n_out = '0;
      end

      mycpu_pkg::FSUB :
      begin
        f_out = a_in - b_in;
        z_out = ((f_out & 0xff) == 0);
        n_out = '0
      end

      mycpu_pkg::FCLR :
      begin
        f_out = '0;
        n_out = '0;
        z_out = '0;
      end
    endcase
  end


   
endmodule

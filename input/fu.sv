`include "mycpu.svh"

import mycpu_pkg::*;

module fu
  (
    input logic     [15:0]  a_in,
    input logic     [15:0]  b_in, 
    input logic     [3:0] 	fs_in,
    output logic    [15:0]  f_out, // Function out
    output logic 	        z_out, // Zero
    output logic 	        n_out // 1 if MSB is 1
  );

  fs_t fs;
  assign fs = fs_t'(fs_in);

  always_comb
  begin : fu_logic
    case (fs)
      // 0
      // FMOVA = 4'b0000
      mycpu_pkg::MOVA :
      begin
        f_out = a_in;
        z_out = (a_in == '0);
        n_out = '0;
      end

      // 1
      // Increment A, does not saturate
      // Output flags are always '0
      // FINC = 4'b0001
      mycpu_pkg::FINC :
      begin
        f_out = a_in + 1;
        z_out = '0;
        n_out = '0;
      end
    
      // 2
      // FADD = 4'b0010
      mycpu_pkg::FADD :
      begin
        f_out = a_in + b_in;
        z_out = '0;
        n_out = '0;
      end
      // 3
      // FMUL = 4'b0011
      mycpu_pkg::FMUL : 
      begin
        if (a_in * b_in > 4'hFFFF)
          // Saturate to maximum value
          begin
            f_out = 4'hFFFF;
          end
        else
          begin
            f_out = a_in * b_in;
          end
        z_out = '0;
        n_out = '0;
      end

      // 4
      // FSRA = 4'b0100 non-Mano!
      mycpu_pkg::FSRA : 
      begin
        f_out = '0;
      end

      // 5
	    // FSUB  = 4'b0101
      mycpu_pkg::FSUB :
      begin
        f_out = a_in - b_in;
        z_out = (((a_in - b_in) & 'hFF) == 0);
        n_out = '0;
      end

      // 6
      // FDEC = 4'b0110
      mycpu_pkg::FDEC :
      begin
        f_out = a_in - 1;
        z_out = (((a_in - 1) & 'hFF) == 0);
        n_out = '0;
      end

      // 7
      // FSLA  = 4'b0111, // non-Mano!
      mycpu_pkg::FSLA :
      begin
        z_out = '0;
      end

      // 8
      // BITWISE AND, OUT = a_in AND b_in
      // FAND  = 4'b1000
      mycpu_pkg::FAND :
      begin
        f_out = (a_in & b_in);
        z_out = ((a_in & b_in) == 0);
      end

      // 9
      // BITWISE OR, OUT = a_in OR b_in
      // FOR   = 4'b1001
      mycpu_pkg::FOR :
      begin
        f_out = (a_in | b_in);
        z_out = ((a_in | b_in) == 0);
      end

      // 10
      // BITWISE XOR, OUT = a_in XOR b_in
      // FXOR = 4'b1010
      mycpu_pkg::FXOR :
      begin
        f_out = (a_in ^ b_in);
        z_out = ((a_in ^ b_in) == 0);
      end

      // 11
      // BITWISE NOT, OUT = a_in XOR b_in
      // FNOT  = 4'b1011
      mycpu_pkg::FNOT :
      begin
        f_out = ~a_in;
        z_out = (a_in == 4'hFFFF);
      end

      // 12
      // FMOVB = 4'b1100
      mycpu_pkg::FMOVB :
      begin
        f_out = b_in;
        z_out = (b_in == 0);
      end

      // 13
      // FSHR  = 4'b1101
      mycpu_pkg::FSHR :
      begin
        f_out = (b_in >> 1);
        z_out = ((b_in >> 1) == 0);
      end

      // 14
      // FSHL  = 4'b1110
      mycpu_pkg::FSHL :
      begin
        f_out = (b_in << 1);
        z_out = ((b_in << 1) == 0);
      end

      // 15
      // FCLR = 4'b1111
      mycpu_pkg::FCLR :
      begin
        f_out = '0;
        // n_out = '0;
        z_out = '1;
      end
      
      default :
      begin
        f_out = '0;
        z_out = '0;
        n_out = '0;
      end
    endcase // fs

  end : fu_logic

endmodule

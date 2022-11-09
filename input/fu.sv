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
        z_out = ((f_out & 2'hFF) == 0);
        n_out = '0;
      end
      // ADD, OUT = A_in + B_in
      mycpu_pkg::FADD :
      begin
        f_out = a_in + b_in;
        z_out = '0;
        n_out = '0;
      end

	// SUBTRACT, OUT = a_in - b_in
      mycpu_pkg::FSUB :
      begin
        f_out = a_in - b_in;
        z_out = ((f_out & 2'hFF) == 0);
        n_out = '0;
      end

      mycpu_pkg::FCLR :
      begin
        f_out = '0;
        // n_out = '0;
        z_out = '1;
      end

	// BITWISE AND, OUT = a_in AND b_in
	mycpu_pkg::FAND :
	begin
		f_out = (a_in & b_in);
		z_out = ((a_in & b_in) == 0);
	end

	// BITWISE OR, OUT = a_in OR b_in
	mycpu_pkg::FOR :
	begin
		f_out = (a_in | b_in);
		z_out = ((a_in | b_in) == 0);
	end
	// BITWISE XOR, OUT = a_in XOR b_in
	mycpu_pkg::FXOR :
	begin
		f_out = (a_in ^ b_in);
		z_out = ((a_in ^ b_in) == 0);
	end

	// BITWISE NOT, OUT = a_in XOR b_in
	// z_out = a_in == 0xff 
	mycpu_pkg::FNOT :
	begin
		f_out = ~a_in;
		z_out = a_in == 0xffff;
	end

	mycpu_pkg::FMOVB :
	begin
		f_out = b_in;
		z_out = (b_in == 0);
	end

	mycpu_pkg::FSHR :
	begin
		f_out = (b_in >> 1);
		z_out = ((b_in >> 1) == 0);
	end

	mycpu_pkg::FSHL :
	begin
		f_out = (b_in << 1);
		z_out = ((b_in << 1) == 0);
	end

	// BITWISE MULTIPLICATION, IMPLEMENTED USING CARRY SAVE ADDER
	// TODO: Finish implementation, 
	mycpu_pkg::FMUL :
	logic partial_sum[15:0];
	logic carry_bits[15:0];

	begin
		begin
		partial_sum = a_in + b_in;
		carry_bits = a_in & b_in;
		end
		// CHECK FOR OVERFLOW
		if (carry_bits[15])
			begin
				// Carry bit is set, saturate
				f_out = 16'b0111_1111_1111_1111;
				z_out = '0;
				n_out = '0;
			end


			// BITWISE OR, OUT = a_in OR b_in
			mycpu_pkg::FOR :
			begin
				f_out = (a_in | b_in);
				z_out = ((a_in | b_in) == 0);
			end
			// BITWISE XOR, OUT = a_in XOR b_in
			mycpu_pkg::FXOR :
			begin
				f_out = (a_in ^ b_in);
				z_out = ((a_in ^ b_in) == 0);
			end

			// BITWISE NOT, OUT = a_in XOR b_in
			// z_out = a_in == 0xff 
			mycpu_pkg::FNOT :
			begin
				f_out = ~a_in;
				z_out = (a_in == 4'hFFFF);
			end

			mycpu_pkg::FMOVB :
        begin
          z_out = '0;
        end
        
			mycpu_pkg::FSHL :
			begin
				f_out = (b_in << 1);
				z_out = ((b_in << 1) == 0);
			end

			mycpu_pkg::FMUL :
      begin
        f_out = '0;
      end

    endcase : fs
  end : fu_logic


   
endmodule

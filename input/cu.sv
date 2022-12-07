`include "mycpu.svh"

import mycpu_pkg::*;

module cu
  (
   input logic 		clk,
   input logic 		rst_n,
   input logic    [15:0] ins_in,
   input logic 		z_in,
   input logic 		n_in,
   output logic 	il_out,
   output logic   [1:0] 	ps_out,
   output logic 	rw_out,
   output logic   [11:0] 	rs_out,
   output logic 	mm_out,
   output logic   [1:0] 	md_out,
   output logic 	mb_out,
   output logic   [3:0] 	fs_out,
   output logic 	wen_out,
   output logic 	iom_out
   );

   cu_state_t st_r, ns;
   opcode_t    opcode;

   assign opcode = opcode_t'(ins_in[15:9]);

  always_ff @( posedge clk or negedge rst_n )
  begin : st_regs
    if ( rst_n == '0)
    begin
      st_r <= RST;
    end
    else
    begin
      st_r <= ns;
    end
  end : st_regs

  always_comb
  begin : idecoder
    case (st_r)
        RST :
          begin
            ns = INF;
            ps_out  = 2'b00;
            il_out  = '0;
            rw_out  = '0;
            rs_out  = '0;
            mm_out  = '0;
            md_out  = 2'b00;
            mb_out  = '0;
            wen_out = '1;
            iom_out = '0;
          end
        INF :
          begin
            ns = EX0;
            ps_out  = 2'b00;
            il_out  = '1;
            rw_out  = '0;
            rs_out  = '0;
            mm_out  = '0;
            md_out  = 2'b00;
            mb_out  = '0;
            wen_out = '1;
            iom_out = '0;
          end
        EX0 :
          begin
            // ns
            if (opcode == HAL) ns = HLT;
            else ns = INF;
            // ps_out
            if (opcode == BRZ)
              begin
                if (z_in == '0) ps_out = 2'b01;
                else ps_out = 2'b10;
              end
            else if (opcode == BRN)
              begin
                if (n_in == '1) ps_out = 2'b10;
                else ps_out = 2'b01;
              end
            else if (opcode == JMP) ps_out = 2'b11;
            else if ((opcode == HAL) || (opcode == XXL)) ps_out = 2'b00;
            else ps_out == 2'b01;
            // il_out
            il_out  = '0;
            // rw_out
            if ((opcode == ST) || (opcode == BRZ) || (opcode == BRN) || (opcode == JMP) ||
                (opcode == IOW) || (opcode == HAL) || (opcode == XXL)) rw_out = '0;
            else rw_out = '1;
            // rs_out
            rs_out = ({'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] });
            // mm_out
            mm_out = '0;
            // md_out
            if ((opcode == LDI) md_out = 2'b01;
            else if (opcode == IOR)) md_out = 2'b10;
            else md_out = 2'b00;
            // mb_out
            if ((opcode == LDI) || (opcode == ADI)) mb_out = '1;
            else mb_out = '0;
            // fs_out
            if (opcode != BRN) fs_out = opcode[3:0];
            else fs_out = 4'b0000;
            // wen_out
            if ((opcode == IOW) || (opcode == ST)) wen_out = '0;
            else wen_out = '1;
            // iom_out
            if ((opcode == IOW) || (opcode == IOR)) iom_out = '1;
            else iom_out = '0;
          end
      endcase // st_r
  end : idecoder

endmodule

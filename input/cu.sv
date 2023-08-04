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
        RST : begin
            ns = INF;
            ps_out  = 2'b00;
            il_out  = '0;
            rw_out  = '0;
            rs_out  = 12'b0000_0000_0000;
            mm_out  = '0;
            md_out  = 2'b00;
            mb_out  = '0;
            wen_out = '1;
            iom_out = '0;
            fs_out  = 4'b0000;
          end
        INF :
          begin
            ns = EX0;
            ps_out  = 2'b00;
            il_out  = '1;
            rw_out  = '0;
            rs_out  = 12'b0000_0000_0000;
            mm_out  = '1;
            md_out  = 2'b00;
            mb_out  = '0;
            wen_out = '1;
            iom_out = '0;
            fs_out  = 4'b0000;
          end

        // Left shift R0, write to R0
        XL0 : begin
          // Next state:
          // INF if zero-flag is '1
          // XL otherwise
          ns = (z_in == '1) ? INF : XL0;
          ps_out = 2'b00;
          il_out = '0;
          rw_out = '0;
          rs_out = 12'b0000_0000_0000;
          mm_out = '0; // Don't care
          mb_out = '0;
          wen_out = '1;
          iom_out = '1;
          fs_out = 4'b0000; // FMOVA
        end

        EX0 : begin
            case (opcode)
              MOVA : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0000;
              end
              INC : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0001;
              end

              ADD : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0010;
              end
              MUL : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0011;
              end
              SRA : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0100;
              end

              SUB : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0101;
              end

              DEC : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0110;
              end

              SLA : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0111;
              end

              AND : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1000;
              end

              OR : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1001;
              end
              XOR : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1010;
              end

              NOT : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1011;
              end

              MOVB : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1100;
              end

              SHR : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1101;
              end

              SHL : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1110;
              end

              CLR : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1111;
              end

              LDI : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '1;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b1100;
              end

              ADI : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '1;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0010;
              end

              LD : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b01;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = '1; // Don't care
              end

              ST : begin
                ns = INF;
                ps_out = 2'b01;
                il_out = '0;
                rw_out = '0;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '0;
                iom_out = '0;
                fs_out = '1; // Don't care
              end

              BRZ : begin
                if (z_in == '1) ps_out = 2'b10;
                else ps_out = 2'b01;
                ns = INF;
                il_out = '0;
                rw_out = '0;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b01;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0000;
              end

              BRN : begin
                if (n_in == '1) ps_out = 2'b10;
                else ps_out = 2'b01;
                ns = INF;
                il_out = '0;
                rw_out = '0;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b01;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0000;
              end

              JMP : begin
                ps_out = 2'b11;
                ns = INF;
                il_out = '0;
                rw_out = '0;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = 4'b0000;
              end

              IOR : begin
                ps_out = 2'b01;
                ns = INF;
                il_out = '0;
                rw_out = '1;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b10;
                mb_out = '0;
                wen_out = '1;
                iom_out = '1;
                fs_out = '1; // Don't care
              end

              IOW : begin
                ps_out = 2'b01;
                ns = INF;
                il_out = '0;
                rw_out = '0;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '0;
                iom_out = '1;
                fs_out = '1; // Don't care
              end

              XXL : begin
                ps_out = 2'b00;
                ns = XL0;
                il_out = '0;
                rw_out = '0;
                rs_out = 12'b0000_0000_0000;
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '0;
                iom_out = '1;
                fs_out = 4'b1110;
              end

              HAL : begin
                ps_out = 2'b00;
                ns = HLT;
                il_out = '0;
                rw_out = '0;
                rs_out = ({1'b0, ins_in[8:6], 1'b0, ins_in[5:3], 1'b0, ins_in[2:0]});
                mm_out = '0;
                md_out = 2'b00;
                mb_out = '0;
                wen_out = '1;
                iom_out = '0;
                fs_out = '1; // Don't care
              end
          endcase // opcode
        end // EX0
      endcase // st_r
  end : idecoder

endmodule

`include "mycpu.svh"
/// TODO: "Tip: If a module instance port drives an internal net (like bbus) and also an output port (like d_out),
/// connect the driving port to the  intermal net, and then connect the net to the output port with an assign statement.
///
/// .m_out(bbus)
//// 
///assign d_out = bbus;


import mycpu_pkg::*;

module mycpu
  (
  input logic 	       clk,
  input logic 	       rst_n,
  output logic [15:0] a_out, 
  input logic [15:0]  d_in,
  output logic [15:0] d_out,
  input logic [15:0]  io_in,
  output logic        wen_out,
  output logic        iom_out
  );


  /// PORTS
  logic [1:0] ps;
  logic il;
  logic mm;
  logic [1:0] md;
  logic mb;
  logic rw;
  logic [8:0] rs;
  logic [3:0] fs;
  logic [15:0] pca;
  logic [15:0] ins;
  logic [15:0] ia;
  logic [15:0] iv;
  logic [15:0] abus;
  logic [15:0] bdat;
  logic [15:0] bbus;
  logic dbus;
  logic [15:0] fbus;
  logic z;
  logic n;

  /// SUBMODULES

  cu CU
  (
  .clk(clk),
  .rst_n(rst_n),
  .z_in(z),
  .n_in(n),
  .ins_in(ins),
  .wen_out(wen_out),
  .iom_out(iom_out),
  .ps_out(ps),
  .il_out(il),
  .mm_out(mm),
  .md_out(md),
  .mb_out(mb),
  .rw_out(rw),
  .rs_out(rs),
  .fs_out(fs)
  );

  ir IR
  (
  .clk(clk),
  .rst_n(rst_n),
  .il_in(il),
  .ins_in(d_in),
  .ia_out(ia),
  .ins_out(ins),
  .iv_out(iv)
  );

  (
  .clk(clk),
  .rst_n(rst_n),
  .ps_in(ps),
  .ia_in(ia),
  .ra_in(abus),
  .pc_out(pca)
  );

  fu FU
  (
  .a_in(abus),
  .b_in(bbus),
  .fs_in(fs),
  .f_out(fbus),
  .z_out(z),
  .n_out(n)
  );	.a_in(abus)	.f_out(fbus)
    .b_in(bbus)	.z_out(z)
    .fs_in(fs)	.n_out(n)


  rb RB
  (
  .clk(clk),
  .rst_n(rst_n),
  .d_in(dbus),
  .rw_in(rw),
  .rs_in(rs),
  .a_out(abus),
  .b_out(bdat)
  );

  mux_2x16 MUXM
  (
  .sel_in(mm),
  .d0_in(abus),
  .d1_in(pca),
  .m_out(a_out)
  );	.sel_in(mm)	.m_out(a_out)
    .d0_in(abus)
    .d1_in(pca)

  mux_2x16 MUXB
  (
  .sel_in(mb),
  .d0_in(bdat),
  .d1_in(iv),
  .m_out(bbus)
  );

  mux_3x16 MUXD
  (
  .sel_in(md),
  .d0_in(fbus),
  .d1_in(d_in),
  .d2_in(io_in),
  .m_out(dbus)
  );


endmodule 

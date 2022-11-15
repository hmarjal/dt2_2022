// This macro is defined in mycpu.svh:
`ifdef INCLUDE_ASSERTIONS

`ifdef design_top_is_mycpu

bind mycpu mycpu_svamod SVA_mycpu (.*);
bind ir ir_svamod SVA_ir (.*);
bind pc pc_svamod SVA_pc (.*);
bind rb rb_svamod SVA_rb (.*);
bind cu cu_svamod SVA_cu (.*);
bind mycpu fu_svamod SVA_FU (.a_in(abus), .b_in(bbus), .fs_in(fs), .f_out(fbus), .z_out(z), .n_out(n), .*);
bind mycpu mux_2x16_svamod SVA_MUXM (.sel_in(mm), .d0_in(abus), .d1_in(pca), .m_out(a_out), .*);
bind mycpu mux_2x16_svamod SVA_MUXB (.sel_in(mb), .d0_in(bdat), .d1_in(iv), .m_out(bbus), .*);
bind mycpu mux_3x16_svamod SVA_MUXD (.sel_in(md), .d0_in(fbus), .d1_in(d_in), .d2_in(io_in), .m_out(dbus), .*);

`endif


`ifdef design_top_is_mux_2x16
bind mux_2x16_tb mux_2x16_svamod SVA_mux_2x16 (.*);
`endif

`ifdef design_top_is_mux_3x16
bind mux_3x16_tb mux_3x16_svamod SVA_mux_3x16 (.*);
`endif

`ifdef design_top_is_fu
bind fu_tb fu_svamod SVA_fu (.*);
`endif


`ifdef design_top_is_ir
bind ir ir_svamod SVA_ir (.*);
`endif


`ifdef design_top_is_pc
bind pc pc_svamod SVA_pc (.*);
`endif


`ifdef design_top_is_rb
bind rb rb_svamod SVA_rb (.*);
`endif


`ifdef design_top_is_cu
bind cu cu_svamod SVA_cu (.*);
`endif


`endif

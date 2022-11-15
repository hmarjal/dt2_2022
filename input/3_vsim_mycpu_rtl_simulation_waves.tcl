onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /mycpu_tb/cycle_counter
add wave -noupdate /mycpu_tb/DUT_INSTANCE/clk
add wave -noupdate /mycpu_tb/DUT_INSTANCE/rst_n
add wave -noupdate -radix unsigned /mycpu_tb/DUT_INSTANCE/a_out
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/d_in
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/d_out
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/io_in
add wave -noupdate /mycpu_tb/DUT_INSTANCE/wen_out
add wave -noupdate /mycpu_tb/DUT_INSTANCE/iom_out
add wave -noupdate -divider Buses
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/abus
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/bbus
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/dbus
add wave -noupdate /mycpu_tb/DUT_INSTANCE/bdat
add wave -noupdate -divider Registers
add wave -noupdate /mycpu_tb/DUT_INSTANCE/rw
add wave -noupdate /mycpu_tb/DUT_INSTANCE/rs
add wave -noupdate -radix decimal -childformat {{{/mycpu_tb/DUT_INSTANCE/RB/rb_r[7]} -radix decimal} {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[6]} -radix decimal} {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[5]} -radix decimal} {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[4]} -radix decimal} {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[3]} -radix decimal} {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[2]} -radix decimal} {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[1]} -radix decimal} {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[0]} -radix decimal}} -subitemconfig {{/mycpu_tb/DUT_INSTANCE/RB/rb_r[7]} {-height 16 -radix decimal} {/mycpu_tb/DUT_INSTANCE/RB/rb_r[6]} {-height 16 -radix decimal} {/mycpu_tb/DUT_INSTANCE/RB/rb_r[5]} {-height 16 -radix decimal} {/mycpu_tb/DUT_INSTANCE/RB/rb_r[4]} {-height 16 -radix decimal} {/mycpu_tb/DUT_INSTANCE/RB/rb_r[3]} {-height 16 -radix decimal} {/mycpu_tb/DUT_INSTANCE/RB/rb_r[2]} {-height 16 -radix decimal} {/mycpu_tb/DUT_INSTANCE/RB/rb_r[1]} {-height 16 -radix decimal} {/mycpu_tb/DUT_INSTANCE/RB/rb_r[0]} {-height 16 -radix decimal}} /mycpu_tb/DUT_INSTANCE/RB/rb_r
add wave -noupdate -divider {Function Unit}
add wave -noupdate /mycpu_tb/DUT_INSTANCE/fs
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/FU/a_in
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/FU/b_in
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/fbus
add wave -noupdate /mycpu_tb/DUT_INSTANCE/z
add wave -noupdate /mycpu_tb/DUT_INSTANCE/n
add wave -noupdate -divider CU
add wave -noupdate /mycpu_tb/DUT_INSTANCE/CU/opcode
add wave -noupdate /mycpu_tb/DUT_INSTANCE/CU/st_r
add wave -noupdate -divider PC
add wave -noupdate /mycpu_tb/DUT_INSTANCE/ps
add wave -noupdate -radix unsigned /mycpu_tb/DUT_INSTANCE/pca
add wave -noupdate -divider IR
add wave -noupdate /mycpu_tb/DUT_INSTANCE/il
add wave -noupdate /mycpu_tb/DUT_INSTANCE/ins
add wave -noupdate -radix decimal /mycpu_tb/DUT_INSTANCE/ia
add wave -noupdate -radix unsigned /mycpu_tb/DUT_INSTANCE/iv
add wave -noupdate -divider Muxes
add wave -noupdate /mycpu_tb/DUT_INSTANCE/mm
add wave -noupdate /mycpu_tb/DUT_INSTANCE/md
add wave -noupdate /mycpu_tb/DUT_INSTANCE/mb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {577500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
wave zoom full

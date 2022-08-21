########################################################
# Clock Definition
#######################################################

# Clock port name -----------------------------.
# Clock period in ns ----------------------.   |
# Clock definition name -------.           |   |
#                              |           |   |
#                              V           V   V

create_clock            -name clk -period 10.0 clk

########################################################
# External Delays of Input Ports
########################################################

# Port that this setting applies to ---.
# External delay in ns ------------.   |
# In relation to which clock? -.   |   |
#                              |   |   |
#                              V   V   V

set_input_delay        -clock clk 0.0 rst_n
set_input_delay        -clock clk 0.0 d_in
set_input_delay        -clock clk 0.0 io_in

########################################################
# External Delays of output Ports
########################################################

set_output_delay       -clock clk 0.0 wen_out
set_output_delay       -clock clk 0.0 iom_out
set_output_delay       -clock clk 0.0 a_out
set_output_delay       -clock clk 0.0 d_out


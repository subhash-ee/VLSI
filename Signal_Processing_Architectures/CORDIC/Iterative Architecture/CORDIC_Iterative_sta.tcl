read_liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib
read_verilog CORDIC_Iterative_gate_level.v
link_design CORDIC_ITER

create_clock -name VCLK -period 10

set_input_delay  0 -clock VCLK [get_ports clk]
set_input_delay  0 -clock VCLK [get_ports rst]
set_input_delay  0 -clock VCLK [get_ports in_valid]
set_input_delay  0 -clock VCLK [get_ports mode]
set_input_delay  0 -clock VCLK [get_ports x_in]
set_input_delay  0 -clock VCLK [get_ports y_in]
set_input_delay  0 -clock VCLK [get_ports theta_in]

set_output_delay 0 -clock VCLK [get_ports sine]
set_output_delay 0 -clock VCLK [get_ports cosine]
set_output_delay 0 -clock VCLK [get_ports mag]
set_output_delay 0 -clock VCLK [get_ports theta]
set_output_delay 0 -clock VCLK [get_ports out_valid]
set_output_delay 0 -clock VCLK [get_ports ready]

report_checks -path_delay max
 
report_checks -path_delay max > CORDIC_Rolling_Timing_Report.txt


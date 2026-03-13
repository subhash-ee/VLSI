read_liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib
read_verilog CORDIC_Pipelined_gate_level.v
link_design CORDIC_Pipelined

create_clock -name clk -period 10 [get_ports clk]

set_input_transition 0.1 [get_ports rst]
set_input_transition 0.1 [get_ports in_valid]
set_input_transition 0.1 [get_ports mode]
set_input_transition 0.1 [get_ports x_in]
set_input_transition 0.1 [get_ports y_in]
set_input_transition 0.1 [get_ports theta_in]


set_load 0.05 [get_ports sine]
set_load 0.05 [get_ports cosine]
set_load 0.05 [get_ports mag]
set_load 0.05 [get_ports angle]
set_load 0.05 [get_ports out_valid]

report_checks -path_delay max

report_checks -path_delay max > reports_max_delay_cla.txt

report_checks -path_delay min

report_checks -path_delay min > reports_min_delay_cla.txt

read_liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib
read_verilog CLA_gate_level_512_bit.v
link_design CLA_N

create_clock -name clk -period 10 [get_ports clk]

set_input_transition 0.1 [get_ports A]
set_input_transition 0.1 [get_ports B]

set_load 0.05 [get_ports Sum]
set_load 0.05 [get_ports C_out]

report_checks -path_delay max

report_checks -path_delay max > reports_max_delay_cla.txt

report_checks -path_delay min

report_checks -path_delay min > reports_min_delay_cla.txt

read_liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib
read_verilog sum_n_fsm_3_gate_level.v
link_design n_sum_fsm_3

# REAL clock for flip-flops
create_clock -name clk -period 10 [get_ports clk]

# Input delays (data inputs only)
set_input_delay  0 -clock clk [get_ports rst]
set_input_delay  0 -clock clk [get_ports N_valid]
set_input_delay  0 -clock clk [get_ports N]

# Output delays
set_output_delay 0 -clock clk [get_ports sum_n]
set_output_delay 0 -clock clk [get_ports sum_valid]

report_checks -path_delay max
report_checks -path_delay max > sum_n_no_fsm_3_timing_report.txt


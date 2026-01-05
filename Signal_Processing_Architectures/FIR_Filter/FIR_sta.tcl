read_liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib
read_verilog FIR_Filter_gate_level.v
link_design FIR

create_clock -name VCLK -period 10

set_input_delay  0 -clock VCLK [get_ports clk]
set_input_delay  0 -clock VCLK [get_ports rst]
set_input_delay  0 -clock VCLK [get_ports x_in]


set_output_delay 0 -clock VCLK [get_ports y_out]

report_checks -path_delay max
 
report_checks -path_delay max > FIR_Filter_Timing_Report.txt


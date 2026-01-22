read_liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib
read_verilog seq_det_gate_level.v
link_design seq_detect

create_clock -name VCLK -period 10

set_input_delay  0 -clock VCLK [get_ports clk]
set_input_delay  0 -clock VCLK [get_ports rst]
set_input_delay  0 -clock VCLK [get_ports x]


set_output_delay 0 -clock VCLK [get_ports y]

report_checks -path_delay max
 
report_checks -path_delay max > Sequence_detector_Timing_Report.txt


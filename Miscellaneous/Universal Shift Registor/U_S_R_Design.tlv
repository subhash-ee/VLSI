\TLV_version 1d: tl-x.org
\SV
/* verilator lint_off UNUSED*/  /* verilator lint_off DECLFILENAME*/  /* verilator lint_off BLKSEQ*/  /* verilator lint_off WIDTH*/  /* verilator lint_off SELRANGE*/  /* verilator lint_off PINCONNECTEMPTY*/  /* verilator lint_off DEFPARAM*/  /* verilator lint_off IMPLICIT*/  /* verilator lint_off COMBDLY*/  /* verilator lint_off SYNCASYNCNET*/  /* verilator lint_off UNOPTFLAT */  /* verilator lint_off UNSIGNED*/  /* verilator lint_off CASEINCOMPLETE*/  /* verilator lint_off UNDRIVEN*/  /* verilator lint_off VARHIDDEN*/  /* verilator lint_off CASEX*/  /* verilator lint_off CASEOVERLAP*/  /* verilator lint_off PINMISSING*/  /* verilator lint_off LATCH*/  /* verilator lint_off BLKANDNBLK*/  /* verilator lint_off MULTIDRIVEN*/  /* verilator lint_off NULLPORT*/  /* verilator lint_off EOFNEWLINE*/  /* verilator lint_off WIDTHCONCAT*/  /* verilator lint_off ASSIGNDLY*/  /* verilator lint_off MODDUP*/  /* verilator lint_off STMTDLY*/  /* verilator lint_off LITENDIAN*/  /* verilator lint_off INITIALDLY*/  /* verilator lint_off */  

//Your Verilog/System Verilog Code Starts Here:
module U_S_R_Design #(parameter WIDTH = 8)
  (input [WIDTH-1:0] LOAD,
   input [1:0] sel,
   input r_s_in, l_s_in, clk,
   output [WIDTH-1:0] Q);
  
  wire [WIDTH-1:0] Q_1, l_s_mux_in, r_s_mux_in;
  assign l_s_mux_in[0] = l_s_in;
  assign r_s_mux_in[WIDTH-1] = r_s_in;
  assign l_s_mux_in[WIDTH-1:1] = Q[WIDTH-2:0];
  assign r_s_mux_in[WIDTH-2:0] = Q[WIDTH-1:1];
  
  genvar i;
  generate
  for(i=0;i<WIDTH;i++)
    begin
      
      U_S_R_1 b_1(.clk(clk), .r_s_mux_in(r_s_mux_in[i]), .l_s_mux_in(l_s_mux_in[i]), .sel(sel), .Q(Q[i]), .load_mux_in(LOAD[i]));
      
    end
  endgenerate
  
endmodule
  
  
 
  
  

//Top Module Code Starts here:
	module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
		logic  [WIDTH-1:0] LOAD;//input
		logic  [1:0] sel;//input
		logic  r_s_in;//input
		logic  l_s_in;//input
		logic  [WIDTH-1:0] Q;//output
//The $random() can be replaced if user wants to assign values
		assign LOAD = $random();
		assign sel = $random();
		assign r_s_in = $random();
		assign l_s_in = $random();
		U_S_R_Design U_S_R_Design(.LOAD(LOAD), .sel(sel), .r_s_in(r_s_in), .l_s_in(l_s_in), .clk(clk), .Q(Q));
	
\TLV
//Add \TLV here if desired                                     
\SV
endmodule


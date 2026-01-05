module FIR #(parameter WIDTH = 16)
  (input clk, rst,
   input signed [WIDTH-1:0] x_in,
   output signed [WIDTH-1:0] y_out);
  
  reg signed [WIDTH-1:0] x_n, x_n_1, x_n_2, x_n_3, x_n_4, x_n_5, x_n_6, x_n_7;
  
  wire  signed [WIDTH-1:0] M_0, M_1, M_2, M_3, M_4, M_5, M_6, M_7;
  
  wire signed [2*WIDTH-1:0] S_0_1, S_2_3, S_4_5, S_6_7;
  
  wire signed [2*WIDTH-1:0] S_0_3, S_4_7;
  
  wire signed [2*WIDTH-1:0] S_0_7;
  
  reg signed [2*WIDTH-1:0] x_n_m, x_n_1_m, x_n_2_m, x_n_3_m, x_n_4_m, x_n_5_m, x_n_6_m, x_n_7_m;
  
  always@(*)
    begin
      if(rst)
        begin
        x_n<=0;
	x_n_1<=0;
        x_n_2<=0;
        x_n_3<=0;
        x_n_4<=0;
        x_n_5<=0;
        x_n_6<=0;
        x_n_7<=0;
    end
      else
        x_n<=x_in;
    end
  
  assign x_n_m = M_0*x_n;
  assign x_n_1_m = M_1*x_n_1;
  assign x_n_2_m = M_2*x_n_2;
  assign x_n_3_m = M_3*x_n_3;
  assign x_n_4_m = M_4*x_n_4;
  assign x_n_5_m = M_5*x_n_5;
  assign x_n_6_m = M_6*x_n_6;
  assign x_n_7_m = M_7*x_n_7;
  
  
  
  assign M_0 = 16'hfea8;
  assign M_1 = 16'hff18;
  assign M_2 = 16'h02ec;
  assign M_3 = 16'h068a;
  assign M_4 = 16'h068a;
  assign M_5 = 16'h02ec;
  assign M_6 = 16'hff18;
  assign M_7 = 16'hfea8;

  always@(posedge clk)
    begin
      x_n_1<=x_n;
      x_n_2<=x_n_1;
      x_n_3<=x_n_2;
      x_n_4<=x_n_3;
      x_n_5<=x_n_4;
      x_n_6<=x_n_5;
      x_n_7<=x_n_6;
    end
  
  assign S_0_1 = x_n_m + x_n_1_m;
  assign S_2_3 = x_n_2_m + x_n_3_m;
  assign S_4_5 = x_n_4_m + x_n_5_m;
  assign S_6_7 = x_n_6_m + x_n_7_m;
  assign S_0_3 = S_0_1 + S_2_3;
  assign S_4_7 = S_4_5 + S_6_7;
  assign S_0_7 = S_0_3 + S_4_7;
  
  
    
  assign  y_out = S_0_7[27:12];
  
endmodule

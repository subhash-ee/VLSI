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
  
  
 
  
  
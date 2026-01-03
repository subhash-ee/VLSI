
// **************N-bit Ripple Carry Adder******************


module RCA_N #(parameter N = 1024)
  (input [N-1:0] A, B,
   input clk,
   output reg [N-1:0] Sum,
   output reg C_out);
  
  reg [N-1:0] A_in, B_in;
  wire [N-1:0] S;
 
  
  wire [N:0]C;
  assign C[0]=0;
  
  
  always@(posedge clk)
    begin
      A_in<=A;
      B_in<=B;
      Sum<=S;
      C_out<=C[N];
    end
  
genvar i;
  generate
    for(i=0;i<N;i=i+1)
      begin:ripple
        FA fa_1(.a(A_in[i]),.b(B_in[i]),.c_in(C[i]),.sum(S[i]),.c_out(C[i+1]));
      end
  endgenerate
  
  
    
endmodule



module FA(input a,b,c_in,
             output sum,c_out);
  
  assign sum = a ^ b ^ c_in;
  assign c_out = a&b | b&c_in | c_in&a;
  
endmodule
  



// **************16-bit Carry Select Adder******************

module CSA_N#(parameter WIDTH = 1024, 
parameter M = 4) (input [WIDTH-1:0] A, B,

   input clk,
   output reg [WIDTH-1:0] Sum,
   output reg C_out);
  
  reg [WIDTH-1:0] A_in, B_in;
  wire [WIDTH-1:0] S;
 
  
  wire [WIDTH/M-1:0]C;
  
  
  always@(posedge clk)
    begin
      A_in<=A;
      B_in<=B;
      Sum<=S;
      C_out<=C[WIDTH/M-1];
    end
  
  FA_4 #(M) fa_4_3(.A(A_in[M-1:0]),.B(B_in[M-1:0]), .C_in(1'b0), .S(S[M-1:0]), .C_out(C[0]));
  
  
  genvar j;
  generate
    for(j=0;j<WIDTH/M-1;j=j+1)
      begin:csa_M
        csa #(M) csa_1(.A(A_in[(j+2)*M-1:(j+1)*M]),.B(B_in[(j+2)*M-1:(j+1)*M]),.C_in(C[j]),.S(S[(j+2)*M-1:(j+1)*M]), .C_out(C[j+1]));
      end
  endgenerate
        
  
endmodule


module csa#(parameter M = 4)
  (input [M-1:0] A,B,
          input C_in,
           output [M-1:0] S,
          output C_out);
  
  wire [M-1:0] S_0, S_1;
  wire Cout_0,Cout_1;
  
  FA_4 #(M) fa_4_1(.A(A),.B(B), .C_in(1'b0),.S(S_0),.C_out(Cout_0));
  
  FA_4 #(M) fa_4_2(.A(A),.B(B), .C_in(1'b1),.S(S_1),.C_out(Cout_1));
  
  assign S = C_in?S_1:S_0;
  assign C_out = C_in?Cout_1:Cout_0;
  
  
endmodule


module FA_4#(parameter M = 4)
  (input [M-1:0] A,B,
         input C_in,
            output [M-1:0] S,
         output C_out);
  wire [M:0] C;
  assign C[0] = C_in;
  assign C_out = C[M];
  genvar i;
  generate
    for(i=0;i<M;i=i+1)
      begin:ripple
        FA fa_1(.a(A[i]),.b(B[i]),.c_in(C[i]),.sum(S[i]),.c_out(C[i+1]));
      end
  endgenerate
endmodule



module FA(input a,b,c_in,
             output sum,c_out);
  
  assign sum = a ^ b ^ c_in;
  assign c_out = a&b|b&c_in|c_in&a;
  
endmodule
  

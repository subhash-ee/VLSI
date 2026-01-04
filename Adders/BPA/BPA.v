

module BPA_N#(parameter N = 512,
                   parameter M = 4)
  (input clk,
   input [N-1:0] A,B,
   output reg [N-1:0] Sum,
  output reg Cout);
  
  reg [N-1:0] A_in, B_in;
  
  wire [N-1:0] S;
  wire [N/M:0] C; 
  
  assign C[0] = 1'b0;
  assign C_out = C[N/M];
  
  always@(posedge clk)
    begin
      A_in<=A;
      B_in<=B;
      Sum<=S;
      Cout<=C_out;
    end
  
  genvar j;
  generate
    for(j=0;j<N/M;j=j+1)
      begin:bpa
        BPA_M #(M) BPA_1 (.A(A_in[(j+1)*M-1:j*M]), .B(B_in[(j+1)*M-1:j*M]), .S(S[(j+1)*M-1:j*M]), .C_in(C[j]), .C_mux_out(C[j+1]));
      end
  endgenerate
  
endmodule


module BPA_M#(parameter M = 4)
  (input [M-1:0] A, B,
  input C_in,
   output [M-1:0] S,
  output C_mux_out);
  
  wire [M-1:0] P_i;
  wire P_f;
  wire C_M_1;
  
  assign P_i =  A^B;
  assign P_f = &P_i;
  
  assign C_mux_out = P_f?C_in:C_M_1;
  
  
  FA_M #(M) fa_4_1(.A(A), .B(B), .C_in(C_in), .S(S), .Cout(C_M_1));
  
endmodule
  

module FA_M #(parameter M = 4)
  (input [M-1:0] A,B,
  input C_in,
   output [M-1:0] S,
   output Cout);
  
  wire [M:0]C;
  
  assign C[0] = C_in;
  assign Cout = C[M];
  
  genvar i;
  generate 
    for(i=0;i<M;i=i+1)
      begin:
        ripple
        FA fa_1(.a(A[i]),.b(B[i]),.c_in(C[i]),.sum(S[i]),.cout(C[i+1]));
      end
  endgenerate
endmodule


  
module FA (input a,b,c_in,
           output sum,cout);
  
 assign sum=a^b^c_in;
 assign cout=a&b|b&c_in|c_in&a;
  
endmodule


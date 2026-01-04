// **************N-bit Carry Look-Ahead Adder******************



module CLA_N #(parameter N = 256)
  (input [N-1:0] A,B,
  input clk,
   output reg [N-1:0] Sum,
  output reg C_out);
  
  reg [N-1:0] A_reg, B_reg;
  
  wire [N-1:0] S_1;
  wire [N:0] Carry;
 
  always@(posedge clk)
    begin
      A_reg <= A;
      B_reg <= B;
      Sum <= S_1;
      C_out <= Carry[N];
    end
  
  carry_sum_gen #(N) c1(.A(A_reg), .B(B_reg), .Carry(Carry), .S(S_1));
  
endmodule


module carry_sum_gen #(parameter N = 16)
  (input [N-1:0] A,B,
   output [N:0] Carry,
   output [N-1:0] S);
  
  wire [N-1:0] P,G;
  wire C_in;
  reg tempP;
  
  
  reg [N-1:0] C_sa;
  integer i,j;
  assign C_in = 0;
  assign P = A^B;
  assign G = A&B;
  
 always @(*)
	begin
    	for (i = 0; i < N; i++) 
			begin
        		C_sa[i] = G[i];

        		// build propagate chain
         		tempP = 1'b1;

        		for (j = i; j >= 0; j--) 
				begin
            		tempP = tempP & P[j];  // multiply propagates

            		if (j == 0)
              			C_sa[i] = C_sa[i] | tempP & C_in;
            		else
              			C_sa[i] = C_sa[i] | tempP & G[j-1];
        		end
    		end
	end

    
  assign Carry[N:1] = C_sa;
  assign Carry[0] = C_in;
  
  assign S = P^Carry[N-1:0];
  
endmodule

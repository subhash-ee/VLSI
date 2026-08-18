module Count_J_K #(parameter WIDTH = 1) 
  (input clk,rst,
   output [WIDTH-1:0] count);
  
  wire [WIDTH-1:0] J,K, adder;
  
  assign adder = count+1;
  assign J = rst?0:adder;
  assign K = ~J;
  
  genvar i;
      generate
        for(i=0;i<WIDTH;i++)
          begin
            J_K J_K_1(.clk(clk), .J(J[i]), .K(K[i]), .Q(count[i]));
          end
      endgenerate

endmodule

 
module J_K (input clk, J, K,
                    output reg Q);
    
  always@(posedge clk)
    begin
      case({J,K})
              2'b00:Q<=Q;
              2'b01:Q<=0;
              2'b10:Q<=1;
              2'b11:Q<=~Q;
      		endcase
    end
endmodule
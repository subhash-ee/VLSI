module n_sum_no_fsm #(parameter WIDTH =4)
  (input clk, rst, N_valid,
   input [WIDTH-1:0] N,
   output reg [2*WIDTH-1:0] sum_n,
  output reg sum_valid);
  
  wire [WIDTH-1:0] i_in;
  reg [WIDTH-1:0] i_out;
  wire [2*WIDTH-1:0] sum_in, add_out;
 
  assign i_in = (N_valid==1)?N:(i_out-1);
  assign add_out = i_out + sum_n;
  assign sum_in = (N_valid==1)?0:add_out;
  
  always@(posedge clk)
    begin
      if(rst)
        i_out <= 0;
      else
      i_out <= i_in;
    end
  
  always@(posedge clk)
    begin
      if(rst)
       sum_n <= 0;
      else
        
      sum_n <= sum_in;
    end
  
  
  always@(posedge clk)
    begin
      if(rst)
        sum_valid <= 0;
      if(i_out==1)
      sum_valid <= 1;
      else
        sum_valid <=0;
    end
  
  
  
        endmodule
        
        
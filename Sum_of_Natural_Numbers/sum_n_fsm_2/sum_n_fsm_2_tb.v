module n_sum_fsm_2_tb;
  
  parameter WIDTH = 4;
  
  reg clk, rst, N_valid;
  reg [WIDTH-1:0] N;
  wire [2*WIDTH-1:0] sum_n;
  wire sum_valid;
  
  n_sum_fsm_2 #(WIDTH) DUT(.clk(clk), .rst(rst), .N_valid(N_valid), .N(N), .sum_n(sum_n), .sum_valid(sum_valid));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    
     rst=1;#10
    N=5; #10
    N_valid = 1;#10
    rst=0;#10
   	N_valid=0; #300
     N=6; #10
    N_valid = 1;#10
    	N_valid=0; #20
    N=3; #10
    N_valid = 1;#10
    N_valid=0; #100
    $finish;
    
  end
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
endmodule
  

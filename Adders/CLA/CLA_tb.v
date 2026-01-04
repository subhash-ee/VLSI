// Code your testbench here
// or browse Examples


module CLA_tb();
  
  parameter N = 16;
  reg [N-1:0] A,B;
  reg clk;
  wire [N-1:0] Sum;
  wire C_out;
  
  CLA #(N) DUT(.A(A),.B(B),.Sum(Sum), .clk(clk), .C_out(C_out));
  
  initial begin
	clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    A=16;B=16; #10
    A=55;B=65; #10
    A=5;B=2; #10
    A=100;B=100;#10
    A=1;B=65535;
    #200
    $finish;
  end
  
  initial begin
    $dumpfile("CLA_tb.vcd");
    $dumpvars(0);

  end
  
endmodule

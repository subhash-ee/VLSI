
module BPA_N_tb();
  
  parameter N = 16;
  parameter M = 4;
  reg [N-1:0] A,B;
  reg clk;
  wire [N-1:0] Sum;
  wire Cout;
  
  BPA_N #(N,M) DUT(.A(A),.B(B),.Sum(Sum), .Cout(Cout), .clk(clk));
  
  initial begin
	clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    A=16'h00F8;B=8; #10
    A=3;B=1; #10
    A=5;B=2; #10
    A=100;B=100;
    #200
    $finish;
  end
  
  initial begin
    $dumpfile("BPA_N_tb.vcd");
    $dumpvars(0, BPA_N_tb);

  end
  
endmodule

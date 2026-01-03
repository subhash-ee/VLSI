module RCA_N_tb();
  
  parameter WIDTH = 16;
  parameter M = 4;
  reg [WIDTH-1:0] A,B;
  reg clk;
  wire [WIDTH-1:0] Sum;
  wire C_out;
  
  RCA_N #(WIDTH,M) DUT(.A(A),.B(B),.Sum(Sum), .C_out(C_out), .clk(clk));
  
  initial begin
	clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    A=16;B=16; #10
    A=55;B=65; #10
    A=5;B=2; #10
    A=100;B=100;
    #200
    $finish;
  end
  
  initial begin
    $dumpfile("RCA_N_tb.vcd");
    $dumpvars(0, RCA_N_tb);

  end
  
endmodule

// Code your testbench here
// or browse Examples

module tb;
  
  parameter WIDTH = 16;
  reg clk, rst, in_valid, mode;
  reg signed [WIDTH-1:0] x_in, y_in, theta_in;
  wire signed [WIDTH-1:0] sine, cosine, mag, angle;
  wire out_valid;
 // wire out_valid, ready;
  reg [WIDTH-1:0] angle_data [0:9];
  localparam SF=2.0**(-14.0);
  integer i, write_data;
  
  
  CORDIC_Pipelined #(WIDTH) DUT (.*);
  
  initial begin
    clk=0;
    forever #10 clk=~clk;
  end
  
  initial begin
    mode=0;
    rst=1; #10
    in_valid=1;#10
    if(mode==0)
      begin
        drive_mode_0(16'h6488); #10
        rst=0; #10
         drive_mode_0(16'h4305 ); #10
        drive_mode_0(16'h0 );
      end
    else
      begin
        drive_mode_1(16'h07c6, 16'h0000 ); #10
        rst=0; #10
        drive_mode_1(16'h07c6,16'h0d76); #10
        drive_mode_1(16'h07c6, 16'h07c6 ); #10
        drive_mode_1(16'h0d76,16'h07c6  ); #10
        drive_mode_1(16'h0000, 16'h07c6 );
      end
     #10 in_valid=0;#500
    $finish;
  end
  

 


  
  task drive_mode_0(input [WIDTH-1:0] angle_gen);
    @(negedge clk)
  x_in=16'h26dd;
    y_in=0;
    theta_in=angle_gen;
  endtask
  
  task drive_mode_1(input [WIDTH-1:0] x_gen, y_gen);
    @(negedge clk)
  x_in=x_gen;
    y_in=y_gen;
    theta_in=0;
  endtask
  
  
  
  
  
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0);
  end
  
endmodule
  
    
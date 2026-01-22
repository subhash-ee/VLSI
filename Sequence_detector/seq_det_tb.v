module seq_detect_tb ();
  
  reg x, clk, rst;
  wire y;
  
  seq_detect DUT (.x(x), .clk(clk), .rst(rst), .y(y));
  
  initial begin 
    
    $dumpfile("seq_detect_tb.vcd");
    $dumpvars(0);
    
  end
  
  initial begin
    
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    
    rst = 1; #10
    rst=0;#10
    x=0; #10
    x=1;#10
    x=0;#10
    x=0;#10
    x=0;#10
    
    x=1;#10
    x=1;#10
    x=0;#10
    x=0;#10
    
    x=1;#10
    x=0;#10
    x=1;#10
    x=0;#10
    
    x=1;#10
    x=0;#10
    x=0;#10
    x=1;#100
    
    $finish;
  end
endmodule

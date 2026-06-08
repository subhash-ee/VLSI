module tb;
  
  parameter WIDTH = 8;
  reg [WIDTH-1:0] LOAD;
  reg [1:0] sel;
  wire [WIDTH-1:0] Q;
  reg r_s_in, l_s_in, clk;
  
  U_S_R #(WIDTH)DUT(.*);
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    LOAD = 255; #10
    sel=2'b11; #10
    sel = 2'b00; #10
    r_s_in = 0; #10
    sel = 2'b10; #100
    $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
endmodule
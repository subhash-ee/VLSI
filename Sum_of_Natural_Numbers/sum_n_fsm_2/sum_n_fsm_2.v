module n_sum_fsm_2 #(parameter WIDTH =4)
  (input clk, rst, N_valid,
   input [WIDTH-1:0] N,
   output reg [2*WIDTH-1:0] sum_n,
  output reg sum_valid);
  
  
  wire [WIDTH-1:0] i_in;
  wire [2*WIDTH-1:0] add_out, sum_in;
  reg [WIDTH-1:0] i_out;
  wire sum_valid_in;
  
  parameter IDLE = 1'b0;
  parameter BUSY = 1'b1;
  
  reg state, next_state;
  
  //state register
  
  always@(posedge clk)
    begin
      if(rst)
        state<=IDLE;
      else
        state<=next_state;
      end
  
  //next state logic
  
  always@(*)
    begin
      case(state)
        IDLE: if(N_valid) next_state = BUSY; else next_state = IDLE;
        BUSY: if(i_out==1) next_state = IDLE; else next_state = BUSY;
      endcase
      end
  
  assign i_in = (state==BUSY)?(i_out-1):N;
  assign sum_in = (state==BUSY)?add_out:0;
  assign sum_valid_in = (i_out==1)?1:0;
  assign add_out = i_out + sum_n;
  
  //i_out register
  
  always@(posedge clk)
    begin
      i_out<=i_in;
    end
  
  //sum_n register
  
  always@(posedge clk)
    begin
      sum_n <= sum_in;
    end
  
  //sum_valid register
  
  always@(posedge clk)
    begin
      sum_valid <= sum_valid_in;
    end
  
        
endmodule
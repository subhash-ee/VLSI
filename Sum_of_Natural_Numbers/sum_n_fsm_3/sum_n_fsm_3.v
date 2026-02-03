module n_sum_fsm_3 #(parameter WIDTH =4)
  (input clk, rst, N_valid,
   input [WIDTH-1:0] N,
   output reg [2*WIDTH-1:0] sum_n,
  output sum_valid);
  
  
  reg [WIDTH-1:0] i_in;
  reg [2*WIDTH-1:0] add_out, sum_in;
  reg [WIDTH-1:0] i_out;
  reg [WIDTH-1:0] Done_count;
  wire ack;
  
  parameter IDLE = 2'b00;
  parameter BUSY = 2'b01;
  parameter DONE = 2'b10;
  
  reg [1:0] state, next_state;
  
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
        BUSY: if(i_out==1) next_state = DONE; else next_state = BUSY;
        DONE: if(ack) next_state = IDLE; else next_state = DONE;
	default: next_state = IDLE;
      endcase
      end
  
  always@(*)
    begin
      case(state)
        IDLE:begin
          i_in=N;
          sum_in=0;
          Done_count=0;
        end
        BUSY:
          begin
            i_in=i_out-1;
            sum_in=add_out;
          end
        DONE:begin
          i_in=i_out;
          sum_in=sum_n;
        end
	default:begin
	i_in=N;
	sum_in=0;
	Done_count=0;
	end

      endcase
    end
  
  assign add_out = i_out + sum_n;
  assign ack = (Done_count==2)?1:0;
  assign sum_valid = (state==DONE)?1:0;
    
  
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
  
  
  //done count*/
  
  always@(posedge clk)
    begin
      if(rst)
      Done_count <= 0;
      else
        begin
        if(state==DONE)
        Done_count <= Done_count+1;
        end
    end
        
endmodule

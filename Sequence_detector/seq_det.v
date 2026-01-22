//Non-Overlapping Sequence detector for the cases 1001, 1100, 1010

module seq_detect (input x, clk, rst,
                  output y);
  
  reg [2:0] state, next_state;
  
  parameter S_rst = 3'b000;
  parameter S_1 = 3'b001;
  parameter S_10 = 3'b010;
  parameter S_11 = 3'b011;
  parameter S_100 = 3'b100;
  parameter S_101 = 3'b101;
  parameter S_110 = 3'b110;
  
  
  //State Register
  
  always@(posedge clk)
    begin
      if(rst)
        begin
      state <= S_rst;
        end
      else
        begin
          state <= next_state;
        end
    end
  
  //next_state logic
  
  always@(*)
    case(state)
      S_rst: if(x==1) next_state = S_1; else next_state  = S_rst;
      S_1: if(x==0) next_state = S_10; else next_state  = S_11;
      S_10: if(x==0) next_state = S_100; else next_state  = S_101;
      S_11: if(x==0) next_state = S_110; else next_state  = S_11;
      S_100: if(x==0) next_state = S_rst; else next_state  = S_rst;
      S_101: if(x==0) next_state = S_rst; else next_state  = S_11;
      S_110: if(x==0) next_state = S_rst; else next_state  = S_101;
      default: next_state = S_rst;
    endcase
  
  //output logic
  
  assign y = ((state==S_100 && x==1) | (state==S_101 && x==0) | (state==S_110 && x==0));
 
  
endmodule

      
  

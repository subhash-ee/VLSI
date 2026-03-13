module CORDIC_Pipelined #(parameter WIDTH=4)
  (input clk, rst, in_valid, mode,
   input signed [WIDTH-1:0] x_in, y_in, theta_in,
   output reg signed [WIDTH-1:0] sine, cosine, mag, angle,
  output out_valid);
  
  reg [WIDTH-1:0] count;
  
  
  wire signed [WIDTH-1:0] x_reg_0, x_reg_1, x_reg_2, x_reg_3, x_reg_4, x_reg_5, x_reg_6, x_reg_7, x_reg_8, x_reg_9, x_reg_10, x_reg_11, x_reg_12, x_reg_13, x_reg_14, x_reg_15;
  
  wire signed [WIDTH-1:0] y_reg_0, y_reg_1, y_reg_2, y_reg_3, y_reg_4, y_reg_5, y_reg_6, y_reg_7, y_reg_8, y_reg_9, y_reg_10, y_reg_11, y_reg_12, y_reg_13, y_reg_14, y_reg_15;
  
  wire signed [WIDTH-1:0] x_sum_0, x_sum_1, x_sum_2, x_sum_3, x_sum_4, x_sum_5, x_sum_6, x_sum_7, x_sum_8, x_sum_9, x_sum_10, x_sum_11, x_sum_12, x_sum_13, x_sum_14, x_sum_15;
  
  wire signed [WIDTH-1:0] y_sum_0, y_sum_1, y_sum_2, y_sum_3, y_sum_4, y_sum_5, y_sum_6, y_sum_7, y_sum_8, y_sum_9, y_sum_10, y_sum_11, y_sum_12, y_sum_13, y_sum_14, y_sum_15;
  
  
  wire signed [WIDTH-1:0] theta_sum_0, theta_sum_1, theta_sum_2, theta_sum_3, theta_sum_4, theta_sum_5, theta_sum_6, theta_sum_7, theta_sum_8, theta_sum_9, theta_sum_10, theta_sum_11, theta_sum_12, theta_sum_13, theta_sum_14, theta_sum_15;
  
  
  wire signed [WIDTH-1:0] theta_reg_0, theta_reg_1, theta_reg_2, theta_reg_3, theta_reg_4, theta_reg_5, theta_reg_6, theta_reg_7, theta_reg_8, theta_reg_9, theta_reg_10, theta_reg_11, theta_reg_12, theta_reg_13, theta_reg_14, theta_reg_15;

  wire signed [WIDTH-1:0] angle_0, angle_1, angle_2, angle_3, angle_4, angle_5, angle_6, angle_7, angle_8, angle_9, angle_10, angle_11, angle_12, angle_13, angle_14, angle_15;
  
  wire signed [WIDTH-1:0] x_shift_0, x_shift_1, x_shift_2, x_shift_3, x_shift_4, x_shift_5, x_shift_6, x_shift_7, 
x_shift_8, x_shift_9, x_shift_10, x_shift_11, x_shift_12, x_shift_13, x_shift_14, x_shift_15;

  wire signed [WIDTH-1:0] y_shift_0, y_shift_1, y_shift_2, y_shift_3, y_shift_4, y_shift_5, y_shift_6, y_shift_7, 
y_shift_8, y_shift_9, y_shift_10, y_shift_11, y_shift_12, y_shift_13, y_shift_14, y_shift_15;

  
  reg signed [WIDTH-1:0] x_in_1, y_in_1, theta_in_1;
  
  //stage 0
  assign x_shift_0  = x_reg_0;
  assign y_shift_0 = y_reg_0;
  
  //stage 1
assign x_shift_1 = {x_reg_1[WIDTH-1], x_reg_1[WIDTH-1:1]};
assign y_shift_1 = {y_reg_1[WIDTH-1], y_reg_1[WIDTH-1:1]};

//stage 2
assign x_shift_2 = {{2{x_reg_2[WIDTH-1]}}, x_reg_2[WIDTH-1:2]};
assign y_shift_2 = {{2{y_reg_2[WIDTH-1]}}, y_reg_2[WIDTH-1:2]};

//stage 3
assign x_shift_3 = {{3{x_reg_3[WIDTH-1]}}, x_reg_3[WIDTH-1:3]};
assign y_shift_3 = {{3{y_reg_3[WIDTH-1]}}, y_reg_3[WIDTH-1:3]};

//stage 4
assign x_shift_4 = {{4{x_reg_4[WIDTH-1]}}, x_reg_4[WIDTH-1:4]};
assign y_shift_4 = {{4{y_reg_4[WIDTH-1]}}, y_reg_4[WIDTH-1:4]};

//stage 5
assign x_shift_5 = {{5{x_reg_5[WIDTH-1]}}, x_reg_5[WIDTH-1:5]};
assign y_shift_5 = {{5{y_reg_5[WIDTH-1]}}, y_reg_5[WIDTH-1:5]};

//stage 6
assign x_shift_6 = {{6{x_reg_6[WIDTH-1]}}, x_reg_6[WIDTH-1:6]};
assign y_shift_6 = {{6{y_reg_6[WIDTH-1]}}, y_reg_6[WIDTH-1:6]};

//stage 7
assign x_shift_7 = {{7{x_reg_7[WIDTH-1]}}, x_reg_7[WIDTH-1:7]};
assign y_shift_7 = {{7{y_reg_7[WIDTH-1]}}, y_reg_7[WIDTH-1:7]};

//stage 8
assign x_shift_8 = {{8{x_reg_8[WIDTH-1]}}, x_reg_8[WIDTH-1:8]};
assign y_shift_8 = {{8{y_reg_8[WIDTH-1]}}, y_reg_8[WIDTH-1:8]};

//stage 9
assign x_shift_9 = {{9{x_reg_9[WIDTH-1]}}, x_reg_9[WIDTH-1:9]};
assign y_shift_9 = {{9{y_reg_9[WIDTH-1]}}, y_reg_9[WIDTH-1:9]};

//stage 10
assign x_shift_10 = {{10{x_reg_10[WIDTH-1]}}, x_reg_10[WIDTH-1:10]};
assign y_shift_10 = {{10{y_reg_10[WIDTH-1]}}, y_reg_10[WIDTH-1:10]};

//stage 11
assign x_shift_11 = {{11{x_reg_11[WIDTH-1]}}, x_reg_11[WIDTH-1:11]};
assign y_shift_11 = {{11{y_reg_11[WIDTH-1]}}, y_reg_11[WIDTH-1:11]};

//stage 12
assign x_shift_12 = {{12{x_reg_12[WIDTH-1]}}, x_reg_12[WIDTH-1:12]};
assign y_shift_12 = {{12{y_reg_12[WIDTH-1]}}, y_reg_12[WIDTH-1:12]};

//stage 13
assign x_shift_13 = {{13{x_reg_13[WIDTH-1]}}, x_reg_13[WIDTH-1:13]};
assign y_shift_13 = {{13{y_reg_13[WIDTH-1]}}, y_reg_13[WIDTH-1:13]};

//stage 14
assign x_shift_14 = {{14{x_reg_14[WIDTH-1]}}, x_reg_14[WIDTH-1:14]};
assign y_shift_14 = {{14{y_reg_14[WIDTH-1]}}, y_reg_14[WIDTH-1:14]};

//stage 15
assign x_shift_15 = {{15{x_reg_15[WIDTH-1]}}, x_reg_15[WIDTH-1:15]};
assign y_shift_15 = {{15{y_reg_15[WIDTH-1]}}, y_reg_15[WIDTH-1:15]};

  
  
  always@(*)
    begin
      cosine = 0;
      sine = 0;
      mag = 0;
    angle = 0;
      if(mode==0)
        begin
      cosine = x_sum_15;
      sine = y_sum_15;
    end
  else
    begin
    mag = x_sum_15;
    angle = theta_sum_15;
    end
  end

  always@(*)
    begin
      //default
      x_in_1=0;
      y_in_1=0;
      theta_in_1=0;
    if(in_valid)
      begin
        x_in_1=x_in;
        y_in_1=y_in;
        theta_in_1=theta_in;
      end
        
  end
  
  
  always@(posedge clk)
    begin
      if(rst)
        begin
          count = 0;
        end
      else
        begin
          count = count+1;
        end
    end
  assign out_valid = (count >= 16)?1:0;
 
assign angle_0  = 16'b0011001001000100;
assign angle_1  = 16'b0001110110101100;
assign angle_2  = 16'b0000111110101110;
assign angle_3  = 16'b0000011111110101;
assign angle_4  = 16'b0000001111111111;
assign angle_5  = 16'b0000001000000000;
assign angle_6  = 16'b0000000100000000;
assign angle_7  = 16'b0000000010000000;
assign angle_8  = 16'b0000000001000000;
assign angle_9  = 16'b0000000000100000;
assign angle_10 = 16'b0000000000010000;
assign angle_11 = 16'b0000000000001000;
assign angle_12 = 16'b0000000000000100;
assign angle_13 = 16'b0000000000000010;
assign angle_14 = 16'b0000000000000001;
assign angle_15 = 16'b0000000000000000;

  
  //stage 0
  
  register #(WIDTH) register_0 (.clk(clk), .rst(rst), .x_in(x_in_1), .y_in(y_in_1), .theta_in(theta_in_1), .x_reg(x_reg_0), .y_reg(y_reg_0), .theta_reg(theta_reg_0));
  sum #(WIDTH) sum_0 (.x_reg(x_reg_0), .y_reg(y_reg_0), .theta_reg(theta_reg_0), .x_shift(x_shift_0), .y_shift(y_shift_0), .angle(angle_0), .x_sum(x_sum_0), .y_sum(y_sum_0), .theta_sum(theta_sum_0), .mode(mode));

  
  
   // Stage 1
register #(WIDTH) register_1 (.clk(clk), .rst(rst), .x_in(x_sum_0), .y_in(y_sum_0), .theta_in(theta_sum_0), .x_reg(x_reg_1), .y_reg(y_reg_1), .theta_reg(theta_reg_1));
sum #(WIDTH) sum_1 (.x_reg(x_reg_1), .y_reg(y_reg_1), .theta_reg(theta_reg_1), .x_shift(x_shift_1), .y_shift(y_shift_1), .angle(angle_1), .x_sum(x_sum_1), .y_sum(y_sum_1), .theta_sum(theta_sum_1), .mode(mode));

// Stage 2
register #(WIDTH) register_2 (.clk(clk), .rst(rst), .x_in(x_sum_1), .y_in(y_sum_1), .theta_in(theta_sum_1), .x_reg(x_reg_2), .y_reg(y_reg_2), .theta_reg(theta_reg_2));
sum #(WIDTH) sum_2 (.x_reg(x_reg_2), .y_reg(y_reg_2), .theta_reg(theta_reg_2), .x_shift(x_shift_2), .y_shift(y_shift_2), .angle(angle_2), .x_sum(x_sum_2), .y_sum(y_sum_2), .theta_sum(theta_sum_2), .mode(mode));

// Stage 3
register #(WIDTH) register_3 (.clk(clk), .rst(rst), .x_in(x_sum_2), .y_in(y_sum_2), .theta_in(theta_sum_2), .x_reg(x_reg_3), .y_reg(y_reg_3), .theta_reg(theta_reg_3));
sum #(WIDTH) sum_3 (.x_reg(x_reg_3), .y_reg(y_reg_3), .theta_reg(theta_reg_3), .x_shift(x_shift_3), .y_shift(y_shift_3), .angle(angle_3), .x_sum(x_sum_3), .y_sum(y_sum_3), .theta_sum(theta_sum_3), .mode(mode));

// Stage 4
register #(WIDTH) register_4 (.clk(clk), .rst(rst), .x_in(x_sum_3), .y_in(y_sum_3), .theta_in(theta_sum_3), .x_reg(x_reg_4), .y_reg(y_reg_4), .theta_reg(theta_reg_4));
sum #(WIDTH) sum_4 (.x_reg(x_reg_4), .y_reg(y_reg_4), .theta_reg(theta_reg_4), .x_shift(x_shift_4), .y_shift(y_shift_4), .angle(angle_4), .x_sum(x_sum_4), .y_sum(y_sum_4), .theta_sum(theta_sum_4), .mode(mode));

// Stage 5
register #(WIDTH) register_5 (.clk(clk), .rst(rst), .x_in(x_sum_4), .y_in(y_sum_4), .theta_in(theta_sum_4), .x_reg(x_reg_5), .y_reg(y_reg_5), .theta_reg(theta_reg_5));
sum #(WIDTH) sum_5 (.x_reg(x_reg_5), .y_reg(y_reg_5), .theta_reg(theta_reg_5), .x_shift(x_shift_5), .y_shift(y_shift_5), .angle(angle_5), .x_sum(x_sum_5), .y_sum(y_sum_5), .theta_sum(theta_sum_5), .mode(mode));

// Stage 6
register #(WIDTH) register_6 (.clk(clk), .rst(rst), .x_in(x_sum_5), .y_in(y_sum_5), .theta_in(theta_sum_5), .x_reg(x_reg_6), .y_reg(y_reg_6), .theta_reg(theta_reg_6));
sum #(WIDTH) sum_6 (.x_reg(x_reg_6), .y_reg(y_reg_6), .theta_reg(theta_reg_6), .x_shift(x_shift_6), .y_shift(y_shift_6), .angle(angle_6), .x_sum(x_sum_6), .y_sum(y_sum_6), .theta_sum(theta_sum_6), .mode(mode));

// Stage 7
register #(WIDTH) register_7 (.clk(clk), .rst(rst), .x_in(x_sum_6), .y_in(y_sum_6), .theta_in(theta_sum_6), .x_reg(x_reg_7), .y_reg(y_reg_7), .theta_reg(theta_reg_7));
sum #(WIDTH) sum_7 (.x_reg(x_reg_7), .y_reg(y_reg_7), .theta_reg(theta_reg_7), .x_shift(x_shift_7), .y_shift(y_shift_7), .angle(angle_7), .x_sum(x_sum_7), .y_sum(y_sum_7), .theta_sum(theta_sum_7), .mode(mode));

// Stage 8
register #(WIDTH) register_8 (.clk(clk), .rst(rst), .x_in(x_sum_7), .y_in(y_sum_7), .theta_in(theta_sum_7), .x_reg(x_reg_8), .y_reg(y_reg_8), .theta_reg(theta_reg_8));
sum #(WIDTH) sum_8 (.x_reg(x_reg_8), .y_reg(y_reg_8), .theta_reg(theta_reg_8), .x_shift(x_shift_8), .y_shift(y_shift_8), .angle(angle_8), .x_sum(x_sum_8), .y_sum(y_sum_8), .theta_sum(theta_sum_8), .mode(mode));

// Stage 9
register #(WIDTH) register_9 (.clk(clk), .rst(rst), .x_in(x_sum_8), .y_in(y_sum_8), .theta_in(theta_sum_8), .x_reg(x_reg_9), .y_reg(y_reg_9), .theta_reg(theta_reg_9));
sum #(WIDTH) sum_9 (.x_reg(x_reg_9), .y_reg(y_reg_9), .theta_reg(theta_reg_9), .x_shift(x_shift_9), .y_shift(y_shift_9), .angle(angle_9), .x_sum(x_sum_9), .y_sum(y_sum_9), .theta_sum(theta_sum_9), .mode(mode));

// Stage 10
register #(WIDTH) register_10 (.clk(clk), .rst(rst), .x_in(x_sum_9), .y_in(y_sum_9), .theta_in(theta_sum_9), .x_reg(x_reg_10), .y_reg(y_reg_10), .theta_reg(theta_reg_10));
sum #(WIDTH) sum_10 (.x_reg(x_reg_10), .y_reg(y_reg_10), .theta_reg(theta_reg_10), .x_shift(x_shift_10), .y_shift(y_shift_10), .angle(angle_10), .x_sum(x_sum_10), .y_sum(y_sum_10), .theta_sum(theta_sum_10), .mode(mode));

// Stage 11
register #(WIDTH) register_11 (.clk(clk), .rst(rst), .x_in(x_sum_10), .y_in(y_sum_10), .theta_in(theta_sum_10), .x_reg(x_reg_11), .y_reg(y_reg_11), .theta_reg(theta_reg_11));
sum #(WIDTH) sum_11 (.x_reg(x_reg_11), .y_reg(y_reg_11), .theta_reg(theta_reg_11), .x_shift(x_shift_11), .y_shift(y_shift_11), .angle(angle_11), .x_sum(x_sum_11), .y_sum(y_sum_11), .theta_sum(theta_sum_11), .mode(mode));

// Stage 12
register #(WIDTH) register_12 (.clk(clk), .rst(rst), .x_in(x_sum_11), .y_in(y_sum_11), .theta_in(theta_sum_11), .x_reg(x_reg_12), .y_reg(y_reg_12), .theta_reg(theta_reg_12));
sum #(WIDTH) sum_12 (.x_reg(x_reg_12), .y_reg(y_reg_12), .theta_reg(theta_reg_12), .x_shift(x_shift_12), .y_shift(y_shift_12), .angle(angle_12), .x_sum(x_sum_12), .y_sum(y_sum_12), .theta_sum(theta_sum_12), .mode(mode));


// Stage 13
register #(WIDTH) register_13 (.clk(clk), .rst(rst), .x_in(x_sum_12), .y_in(y_sum_12), .theta_in(theta_sum_12), .x_reg(x_reg_13), .y_reg(y_reg_13), .theta_reg(theta_reg_13));
sum #(WIDTH) sum_13 (.x_reg(x_reg_13), .y_reg(y_reg_13), .theta_reg(theta_reg_13), .x_shift(x_shift_13), .y_shift(y_shift_13), .angle(angle_13), .x_sum(x_sum_13), .y_sum(y_sum_13), .theta_sum(theta_sum_13), .mode(mode));

// Stage 14
register #(WIDTH) register_14 (.clk(clk), .rst(rst), .x_in(x_sum_13), .y_in(y_sum_13), .theta_in(theta_sum_13), .x_reg(x_reg_14), .y_reg(y_reg_14), .theta_reg(theta_reg_14));
sum #(WIDTH) sum_14 (.x_reg(x_reg_14), .y_reg(y_reg_14), .theta_reg(theta_reg_14), .x_shift(x_shift_14), .y_shift(y_shift_14), .angle(angle_14), .x_sum(x_sum_14), .y_sum(y_sum_14), .theta_sum(theta_sum_14), .mode(mode));

// Stage 15
register #(WIDTH) register_15 (.clk(clk), .rst(rst), .x_in(x_sum_14), .y_in(y_sum_14), .theta_in(theta_sum_14), .x_reg(x_reg_15), .y_reg(y_reg_15), .theta_reg(theta_reg_15));
sum #(WIDTH) sum_15 (.x_reg(x_reg_15), .y_reg(y_reg_15), .theta_reg(theta_reg_15), .x_shift(x_shift_15), .y_shift(y_shift_15), .angle(angle_15), .x_sum(x_sum_15), .y_sum(y_sum_15), .theta_sum(theta_sum_15), .mode(mode));


endmodule


module register #(parameter WIDTH=4)
  (input signed [WIDTH-1:0] x_in, y_in, theta_in,
          input clk, rst,
   output reg signed [WIDTH-1:0] theta_reg, x_reg, y_reg);

  always@(posedge clk)
    begin
      if(rst)
        begin
          x_reg<=0;
          y_reg<=0;
          theta_reg<=0;
        end
      else
        begin
          x_reg<=x_in;
          y_reg<=y_in;
          theta_reg<=theta_in;
        end
         
     end
endmodule



module sum #(parameter WIDTH=4)
  (input signed [WIDTH-1:0] x_reg, y_reg, theta_reg, angle,
           input signed [WIDTH-1:0] x_shift, y_shift,
   input mode,
   output reg signed [WIDTH-1:0] x_sum, y_sum, theta_sum);
          
              always@(*)
                begin
                  if(mode==0)
                    begin
                  if(theta_reg[WIDTH-1]==1)
                    begin
                      x_sum=x_reg+y_shift;
                      y_sum=y_reg-x_shift;
                      theta_sum=theta_reg+angle;
                    end
                  else
                    begin
                      x_sum=x_reg-y_shift;
                      y_sum=y_reg+x_shift;
                      theta_sum=theta_reg-angle;
                    end
                    end
                  else
                    begin
                      if(y_reg[WIDTH-1]==1)
                    begin
                      x_sum=x_reg-y_shift;
                      y_sum=y_reg+x_shift;
                      theta_sum=theta_reg-angle;
                    end
                  else
                    begin
                      x_sum=x_reg+y_shift;
                      y_sum=y_reg-x_shift;
                      theta_sum=theta_reg+angle;
                      
                    end
                    end
                end
              
              endmodule
module CORDIC_ITER #(parameter WIDTH=16)
  (input clk, rst, in_valid, mode,
   input signed [WIDTH-1:0] x_in, y_in, theta_in,
   output reg signed [WIDTH-1:0] sine, cosine, mag, theta,
   output out_valid, ready);
  
  parameter IDLE = 2'b00;
  parameter BUSY = 2'b01;
  parameter DONE = 2'b10;
  
  reg [1:0] state, next_state;
  
  reg [3:0] i;
  wire [3:0] address;
  
  reg [WIDTH-1:0] x_mux_out, y_mux_out, theta_mux_out;
  reg signed  [WIDTH-1:0] x_reg, y_reg, theta_reg, angle, x_shift, y_shift;
  reg signed [WIDTH-1:0] x_adder, y_adder, theta_adder;
  
  wire count_enb;
  
  assign address=i;
  
  //Look Up Table
  
  always@(*)
    begin
      case(address)
        4'd0:angle=16'b0011001001000100;
        4'd1:angle=16'b0001110110101100;
        4'd2:angle=16'b0000111110101110;
        4'd3:angle=16'b0000011111110101;
        4'd4:angle=16'b0000001111111111;
        4'd5:angle=16'b0000001000000000;
        4'd6:angle=16'b0000000100000000;
        4'd7:angle=16'b0000000010000000;
        4'd8:angle=16'b0000000001000000;
        4'd9:angle=16'b0000000000100000;
        4'd10:angle=16'b0000000000010000;
        4'd11:angle=16'b0000000000001000;
        4'd12:angle=16'b0000000000000100;
        4'd13:angle=16'b0000000000000010;
        4'd14:angle=16'b0000000000000001;
        4'd15:angle=16'b0000000000000000;
      endcase   
    end
  
  
  //x_adder, y_adder, theta_adder
  
  always@(*)
    begin
      if(mode==0)
        begin
      if(theta_reg[WIDTH-1]==1)
        begin
          x_adder = x_reg+y_shift;
          y_adder = y_reg-x_shift;
          theta_adder = theta_reg+angle;
        end
      else
        begin
          x_adder = x_reg-y_shift;
          y_adder = y_reg+x_shift;
          theta_adder = theta_reg-angle;
        end
        end
      else
        begin
          if(y_reg[WIDTH-1]==1)
        begin
           x_adder = x_reg-y_shift;
          y_adder = y_reg+x_shift;
          theta_adder = theta_reg-angle;
        end
      else
        begin
          x_adder = x_reg+y_shift;
          y_adder = y_reg-x_shift;
          theta_adder = theta_reg+angle;
        end
        end
    end
  
  //Barrel Shifter
  
  
 always@(*)
    begin
      case(i)
        4'd0:begin
          x_shift=x_reg;
          y_shift=y_reg;
        end
          4'd1:begin
            x_shift={x_reg[WIDTH-1],x_reg[WIDTH-1:1]};
            y_shift={y_reg[WIDTH-1],y_reg[WIDTH-1:1]};
          end
        4'd2:begin
          x_shift={{2{x_reg[WIDTH-1]}},x_reg[WIDTH-1:2]};
          y_shift={{2{y_reg[WIDTH-1]}},y_reg[WIDTH-1:2]};
        end
         4'd3:begin
           x_shift={{3{x_reg[WIDTH-1]}},x_reg[WIDTH-1:3]};
           y_shift={{3{y_reg[WIDTH-1]}},y_reg[WIDTH-1:3]};
        end
        4'd4:begin
          x_shift={{4{x_reg[WIDTH-1]}},x_reg[WIDTH-1:4]};
          y_shift={{4{y_reg[WIDTH-1]}},y_reg[WIDTH-1:4]};
        end
        4'd5:begin
          x_shift={{5{x_reg[WIDTH-1]}},x_reg[WIDTH-1:5]};
          y_shift={{5{y_reg[WIDTH-1]}},y_reg[WIDTH-1:5]};
        end
        4'd6:begin
          x_shift={{6{x_reg[WIDTH-1]}},x_reg[WIDTH-1:6]};
          y_shift={{6{y_reg[WIDTH-1]}},y_reg[WIDTH-1:6]};
        end
        4'd7:begin
	  x_shift={{7{x_reg[WIDTH-1]}},x_reg[WIDTH-1:7]};	
          y_shift={{7{y_reg[WIDTH-1]}},y_reg[WIDTH-1:7]};
        end
        4'd8:begin
          x_shift={{8{x_reg[WIDTH-1]}},x_reg[WIDTH-1:8]};
          y_shift={{8{y_reg[WIDTH-1]}},y_reg[WIDTH-1:8]};
        end
        4'd9:begin
          x_shift={{9{x_reg[WIDTH-1]}},x_reg[WIDTH-1:9]};
          y_shift={{9{y_reg[WIDTH-1]}},y_reg[WIDTH-1:9]};
        end
        4'd10:begin
          x_shift={{10{x_reg[WIDTH-1]}},x_reg[WIDTH-1:10]};
          y_shift={{10{y_reg[WIDTH-1]}},y_reg[WIDTH-1:10]};
        end
        4'd11:begin
          x_shift={{11{x_reg[WIDTH-1]}},x_reg[WIDTH-1:11]};
          y_shift={{11{y_reg[WIDTH-1]}},y_reg[WIDTH-1:11]};
        end
        4'd12:begin
          x_shift={{12{x_reg[WIDTH-1]}},x_reg[WIDTH-1:12]};
          y_shift={{12{y_reg[WIDTH-1]}},y_reg[WIDTH-1:12]};
        end
        4'd13:begin
          x_shift={{13{x_reg[WIDTH-1]}},x_reg[WIDTH-1:13]};
          y_shift={{13{y_reg[WIDTH-1]}},y_reg[WIDTH-1:13]};
        end
        4'd14:begin
          x_shift={{14{x_reg[WIDTH-1]}},x_reg[WIDTH-1:14]};
          y_shift={{14{y_reg[WIDTH-1]}},y_reg[WIDTH-1:14]};
        end
        4'd15:begin
          x_shift={{15{x_reg[WIDTH-1]}},x_reg[WIDTH-1:15]};
          y_shift={{15{y_reg[WIDTH-1]}},y_reg[WIDTH-1:15]};
        end
      endcase
    end
  
  
  //Controlling multiplexers
  always@(*)
    begin
      case(state)
        IDLE:begin
          x_mux_out = x_in;
          y_mux_out = y_in;
          theta_mux_out = theta_in;
        end
        BUSY:begin
          x_mux_out = x_adder;
          y_mux_out = y_adder;
          theta_mux_out = theta_adder;
        end
        DONE:begin
           x_mux_out = x_reg;
          y_mux_out = y_reg;
          theta_mux_out = theta_reg;
        end
        default:begin
          x_mux_out = x_in;
          y_mux_out = y_in;
          theta_mux_out = theta_in;
        end
      endcase  
    end
  
  
  
  //Count
  
  always@(posedge clk)
    begin
      if(count_enb)
        i<=i+1;
      else
        i<=0;
    end
  
 //x_reg, y_reg and theta_reg
  
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
      x_reg<=x_mux_out;
      y_reg<=y_mux_out;
      theta_reg<=theta_mux_out;
        end
    end
  
  //Taking outputs according to mode
  always@(*)
    begin
	cosine = 0;
      	sine = 0;
	mag = 0;	//Default_assignments
        theta = 0;

      if(mode==0)
        begin
      cosine = x_reg;
      sine = y_reg;
        end
      else
        begin
          mag = x_reg;
          theta = theta_reg;
        end
    end
  
  //CONTROL PATH
  
  always@(posedge clk)
    begin
    if(rst)
      state<=IDLE;
  else
    state<=next_state;
  end
  
  always@(*)
    begin
      case(state)
        IDLE:if(in_valid)next_state=BUSY;else next_state=IDLE;
        BUSY:if(i==4'd15)next_state=DONE;else next_state=BUSY;
        DONE:next_state=IDLE;
        default:next_state=IDLE;
      endcase
    end
  
  assign out_valid = (state==DONE);
  assign ready = (state==IDLE);
  assign count_enb = (state==BUSY)?1:0;
  
endmodule
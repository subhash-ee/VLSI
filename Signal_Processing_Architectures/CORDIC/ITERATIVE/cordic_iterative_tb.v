module tb;
  
  parameter WIDTH = 16;
  reg clk, rst, in_valid, mode;  //mode = 0 >>>> rotation, mode = 1 >>>> vectroring
  reg signed [WIDTH-1:0] x_in, y_in, theta_in;
  wire signed [WIDTH-1:0] sine, cosine, mag, theta;
  wire out_valid, ready;
  reg [WIDTH-1:0] angle_data [0:9];
  reg [WIDTH-1:0] x_y_data [0:5][0:1];
  reg [WIDTH-1:0] x_y_scale_data [0:5][0:1];
  localparam SF=2.0**(-14.0);
  localparam scale=1.6468; //1/0.60725
  integer i, write_data;
  
  
  CORDIC_ITER #(WIDTH) DUT (.*);
  
  initial begin
    clk=0;
    forever #10 clk=~clk;
  end
  
  initial begin
    
    drive_reset();
    mode=1;
    write_data=$fopen("output_tracker.txt","w");
    $fclose(write_data);
    if(mode==0)
      $readmemh("angle_hex.txt", angle_data);
     else
       begin
       $readmemh("x_y_hex.txt", x_y_data);
         $readmemh("x_y_scale_hex.txt", x_y_scale_data);
       end
         
    

    if(mode==0)
    begin
    for(i=0;i<10;i=i+1)
      begin
	 drive_input(angle_data[i]);
      check_output();
      end
      end
        else
          begin
            for(i=0;i<6;i=i+1)
              begin
                drive_input_1(x_y_scale_data[i][0],x_y_scale_data[i][1]);
        check_output();
              end
      end
    
    repeat(30)@(negedge clk)
      $finish;
  end
  
  
   task drive_input_1 
     (input[15:0] x_gen, y_gen);
    
    wait (ready==1)
    $display("Received the ready signal and driving the input");
    @(negedge clk)
    in_valid=1;
   // mode=1;
     x_in=x_gen;
     y_in=y_gen;
    theta_in=0;
    @(negedge clk)
    in_valid=0;
  endtask
  
  task drive_input 
  (input[15:0] angle_gen);
    
    wait (ready==1)
    $display("Received the ready signal and driving the input");
    @(negedge clk)
    in_valid=1;
   // mode=0;
    x_in=16'h26dd;
    y_in=0;
    theta_in=angle_gen;
    @(negedge clk)
    in_valid=0;
  endtask
  
  
  task check_output ();
    @(posedge out_valid)
    $display("Received Output valid");
    if(mode==0)
      begin
    $display("cosine of angle %f = %f, sine of angle %f = %f", $itor(theta_in*SF)*57.2958, $itor(cosine*SF), $itor(theta_in*SF)*57.2958, $itor(sine*SF) );
    write_data=$fopen("output_tracker.txt","a");
    $fdisplay(write_data,"cosine of angle %f = %f, sine of angle %f = %f", $itor(theta_in*SF)*57.2958, $itor(cosine*SF), $itor(theta_in*SF)*57.2958, $itor(sine*SF) );
    $fclose(write_data);
      end
    else
      begin
        $display("magnitude of  %f, %f = %f, angle of  %f, %f = %f", $itor(x_in*SF)*scale, $itor(y_in*SF)*scale, $itor(mag*SF), $itor(x_in*SF)*scale, $itor(y_in*SF)*scale, $itor(theta*SF)*57.2958);
    write_data=$fopen("output_tracker.txt","a");
    $fdisplay(write_data,"magnitude of  %f, %f = %f, angle of  %f, %f = %f", $itor(x_in*SF)*scale, $itor(y_in*SF)*scale, $itor(mag*SF), $itor(x_in*SF)*scale, $itor(y_in*SF)*scale, $itor(theta*SF)*57.2958);
    $fclose(write_data);
        
      end
  endtask
  
  task drive_reset();
    @(negedge clk)
    rst=0;
    @(negedge clk)
    rst=1;
    @(negedge clk)
    rst=0;
  endtask

  
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0);
  end
  
endmodule
  
    
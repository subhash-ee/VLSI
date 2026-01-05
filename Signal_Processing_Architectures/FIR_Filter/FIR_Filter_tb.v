parameter WIDTH=16;
module tb;
  reg clk, rst;
  reg [WIDTH-1:0] x_in;
  wire [WIDTH-1:0] y_out;
  integer file, status, i, write_data;
  
  reg [15:0] memory [0:255]; 
  integer count = 0;
  
  localparam SF = 2**(-12);
  
  FIR #(WIDTH) DUT (.*);
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    rst=1;#10
    file = $fopen("Input_Data.txt", "r"); // Open file
    if (file == 0) begin
      $display("Error: File not found!");
      $finish;
    end

    // Read values until end of file (EOF)
    while (!$feof(file)) begin
      status = $fscanf(file, "%h", memory[count]); // Read one hex value
      if (status == 1) count = count + 1; // Only increment if read was successful
    end

    $fclose(file); // Close file
    //rst=0;#10

    for (i=0; i<count; i++)
      begin
        drive_input(memory[i]);
        check_output();
      end
    
    repeat(30)@(posedge clk)
      $finish;
  end
    
    task drive_input (input [WIDTH-1:0] data);
      @(negedge clk)
      rst=0;
        x_in=data;
    endtask
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0);
  end
  
  task check_output ();
    @(posedge clk)
    write_data=$fopen("output_tracker.txt","a");
    $fdisplay(write_data,"%h", y_out);
    $fclose(write_data);
  endtask
      
    
endmodule

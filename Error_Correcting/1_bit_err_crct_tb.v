// Tested by Arigela Subhash

module error_crct_tb;
  parameter r = 5;
  reg [2**r-1:1] D_in_w_p;
  reg [2**r-1:1] D_out_w_p_er;
  reg [2**r-r-2:0] D_in_org;
  reg clk;
  wire [2**r-r-2:0] D_out;
  wire [2**r-1:1] D_out_w_p_crct;
  reg [2**r-r-2:0] D_in [0:9];
  reg [2**r-1:0] D_out_w_p_error [0:9];
  reg [2**r-1:0] D_in_w_p_in [0:9];
  integer i, write_data;
  
  error_crct #(r)DUT(.*);
  
  
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    write_data = $fopen("output_tracker.txt","w");
    $fdisplay(write_data,
"%-31s | %-31s | %-16s | %-31s",
"Input Data with parity",
"Out Data with parity",
"Error in bit num",
"Correct Data with parity");

$fdisplay(write_data,
"--------------------------------|---------------------------------|------------------|--------------------------------");
    $fclose(write_data);
    $readmemb("D_out_p_error.txt", D_out_w_p_error);
    $readmemb("D_in_w_p.txt", D_in_w_p_in);
    $readmemb("Data_in.txt", D_in);
    for(i=0;i<10;i++)
      begin
        drive_input(D_in_w_p_in[i],D_out_w_p_error[i], D_in[i]);
        check_output();
      end
    
    repeat(30)@(negedge clk)
      $finish;
  end
  
  task drive_input(input [2**r-1:1] Data_in_w_p, Data_out_p_error,
                   input [2**r-r-2:0] Data_in); 
    @(posedge clk)
    $display("driving input:");
    D_in_w_p = Data_in_w_p;
    D_out_w_p_er = Data_out_p_error;
    D_in_org = Data_in;
  endtask
  
  task check_output();
    @(negedge clk)
    $display("Data_in_with_parity=%b, Data_out_with_Parity_crct=%b, D_out_w_p_er=%b",D_in_w_p,D_out_w_p_crct,D_out_w_p_er);
    write_data=$fopen("output_tracker.txt","a");
    
    
  
    $fdisplay(write_data,
"%031b | %031b | %-16d | %031b",
D_in_w_p,
D_out_w_p_er,
DUT.S,
D_out_w_p_crct);
  endtask
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
  
endmodule
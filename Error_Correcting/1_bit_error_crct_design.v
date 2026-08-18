// Designed by Arigela Subhash

module error_crct #(parameter r = 3)
  (input [2**r-1:1] D_in_w_p,
   input [2**r-r-2:0] D_in_org,
   input [2**r-1:1] D_out_w_p_er,
   input clk,
   output reg [2**r-r-2:0] D_out,
  output reg [2**r-1:1] D_out_w_p_crct);
  
  reg [2**r-r-2:0] D_out_er;
  reg [2**(r-1):1] P_out_er;
  wire [2**r-1:1] D_out_w_p;
  reg [2**(r-1):1] P_dag;
  reg [2**(r-1):0] Synd;
  reg [r-1:0] S;
  reg [2**r-1:0] D_out_er_ind;
  reg [2**r-1:1] D_in_w_p_reg, D_out_w_p_er_reg;
  
  int i,j;
  reg [r-1:0] count, count_2;
  
  /*always@(posedge clk)
    begin
      D_in_w_p_reg = D_in_w_p;
      D_out_w_p_er_reg = D_out_w_p_er;
    end*/
  
  
  always@(*)
    begin
      count=0;
      for(i=1;i<2**r;i++)
        begin
          if((i&(i-1))==0)
            begin
              P_out_er[i] = D_out_w_p_er[i];
              count=count+1;
            end
          else
            begin
            D_out_er[i-(count+1)]=D_out_w_p_er[i];
          $display("D_out_er[%0d]=%0d",i-(count+1),D_out_er[i-(count+1)]);
            end
        end
    end
  
  data_w_parity #(r) data_w_p_out(.clk(clk), .D_in(D_out_er), .D_in_w_p(D_out_w_p));
  
  always@(*)
    begin
      count_2=0;
      for(j=1;j<2**r;j++)
        begin
          if((j&(j-1))==0)
            begin
              P_dag[j] = D_out_w_p[j];
              Synd[j] = P_dag[j]^P_out_er[j];
              S[count_2] = Synd[j]; 
              count_2=count_2+1;
            end
          else
            D_out[j-(count_2+1)]=D_out_w_p_crct[j];
        end
    end
  
  decoder #(r) er_idfy (.in(S), .out(D_out_er_ind));
  
  assign D_out_w_p_crct = D_out_w_p_er^D_out_er_ind[2**r-1:1];
  
endmodule
           
    
  
module decoder #(parameter r = 3)
  (input [r-1:0] in,
   output [(1<<r)-1:0] out);
  
  assign out = 1'b1<<in;
  
endmodule

module data_w_parity #(parameter r = 3)
  (input [2**r-r-2:0] D_in,
   input clk,
   output [2**r-1:1] D_in_w_p);
  
  reg [2**r-1:1] temp;
   reg [r-1:0] count; 
  wire [r-1:0] k[r];
  wire [2**(r-1):1] P_in;
  int l,m;
  reg [2**r-r-2:0] D_reg_in;
  
  /*always@(posedge clk)
    begin
    D_reg_in<=D_in;
    end*/
  assign D_in_w_p = temp;
  
  
  always@(*)
    begin
      count=0;
      for(l=1;l<2**r;l++)
        begin
          if((l&(l-1)) == 0)
            begin
              temp[l] = 0;
              count=count+1;
            end
          else
            begin
              temp[l] = D_in[l-(count+1)];
              $display("temp[%0d]=%0d",l,temp[l]);
        	end
        end
      for(m=1;m<2**r;m++)
        begin
          if((m&(m-1))==0)
            temp[m]=P_in[m];
        end
    end
  genvar i;
  generate
    for(i=0;i<r;i++)
      begin:parity
        assign k[i]=2**i;
        pattern #(r) p_k (.k(k[i]), .temp(temp),.P_in(P_in[2**i]));
      end
  endgenerate
  
endmodule

  module pattern #(parameter r = 3)
  (input [r-1:0] k,
   input [2**r-1:1] temp,
                output reg P_in);
  
  
  int i,j,l,m;
  int P;
 
  
  always@(*)
    begin
      P_in = 0;
      for(i=k-1;i<2**r;i++)
        begin
          for(j=0;j<k;j++)
            begin
              i=i+1;
              P = ((i&(i-1)) == 0);
              if(i<2**r && P!=1)
                begin
                  P_in=P_in^temp[i];
                end
            end
          i=i+k-1;
        end
    end
  
endmodule

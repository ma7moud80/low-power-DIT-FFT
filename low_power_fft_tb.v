//`include "fft_8.v"
`include "low_power_fft.v"

`timescale 1ns/1ns
module testbench1;

   parameter width = 9;
   parameter clk_per = 10;
   reg                        rstn;
   reg                        clk;
   reg                        start;
   reg                        vld_in;
   reg        [width-1:0]     in;    
   wire       [width-1:0]     out_r;    
   wire       [width-1:0]     out_i;    
   wire                       vld_out;

   always #(clk_per/2) clk = ~clk;

low_power_fft #(.width(width)) dut (
//dit_fft_8 #(.width(width)) dut (
    .rstn(rstn),
    .clk(clk),
    .start(start),
    .vld_in(vld_in),
    .in(in),    
    .out_r(out_r),     
    .out_i(out_i),     
    .vld_out(vld_out)
    );

initial
   begin

   $monitor(" time = %t -> vld_in: %d | in: %b  out_r: %b | out_i: %b | vld_out : %b" , 
   $time, vld_in, in, out_r, out_i, vld_out); 


   // initial values
   clk = 1;
   rstn = 1;
   #10

   // reset assertion
   rstn = 0;
   #10

   rstn = 1;
   //feed input stimulus
   vld_in = 1;
   //#10
   in=1;//1
   #10
   in = 1;
   #10
   in = 1;
   #10
   in = 1;
   #10
   in = 1;
   #10
   in = 1;
   #10
   in = 1;
   #10
   in = 1;
   #10
   vld_in = 0;
   #20
   start = 1;
   #10
   start = 0;
   
   
    rstn = 1;
   //feed input stimulus
   vld_in = 1;
   //#10
   in=1;//1
   #10
   in = 2;
   #10
   in = 4;
   #10
   in = 8;
   #10
   in = 16;
   #10
   in = 32;
   #10
   in = 64;
   #10
   in = 128;
   #10
   vld_in = 0;
   #20
   start = 1;
   #10
   start = 0;

   #200

   $finish;

   end
endmodule
`include "high_speed_fft.v"
//`include "optimized_fft_8.v"

`timescale 1ns/1ns
module testbench;

   parameter width = 9;
   parameter clk_per = 10;
   reg                       rstn;
   reg                       clk;
   reg       [width-1:0]     x0;    
   reg       [width-1:0]     x1;    
   reg       [width-1:0]     x2;    
   reg       [width-1:0]     x3;    
   reg       [width-1:0]     x4;    
   reg       [width-1:0]     x5;    
   reg       [width-1:0]     x6;   
   reg       [width-1:0]     x7;  
   wire      [width-1:0]     y0r;
   wire      [width-1:0]     y0i;
   wire      [width-1:0]     y1r;
   wire      [width-1:0]     y1i;
   wire      [width-1:0]     y2r;
   wire      [width-1:0]     y2i;
   wire      [width-1:0]     y3r;
   wire      [width-1:0]     y3i;
   wire      [width-1:0]     y4r;
   wire      [width-1:0]     y4i;
   wire      [width-1:0]     y5r;
   wire      [width-1:0]     y5i;
   wire      [width-1:0]     y6r;
   wire      [width-1:0]     y6i;
   wire      [width-1:0]     y7r;
   wire      [width-1:0]     y7i;
   wire                      vld;
   wire      [1:0]           counter_o;

   always #(clk_per/2) clk = ~clk;

//high_speed_fft_1 #(.width(width)) dut (
high_speed_fft #(.width(width)) dut (
    .rstn(rstn),
    .clk(clk),
    .x0(x0),    
    .x1(x1),    
    .x2(x2),    
    .x3(x3),    
    .x4(x4),    
    .x5(x5),    
    .x6(x6),    
    .x7(x7),  
    .y0r(y0r),
    .y0i(y0i),
    .y1r(y1r),
    .y1i(y1i),
    .y2r(y2r),
    .y2i(y2i),
    .y3r(y3r),
    .y3i(y3i),
    .y4r(y4r),
    .y4i(y4i),
    .y5r(y5r),
    .y5i(y5i),
    .y6r(y6r),
    .y6i(y6i),
    .y7r(y7r),
    .y7i(y7i),
    .vld(vld),
    .counter_o(counter_o)
    );

initial
   begin
   // initial values
   clk = 1;
   rstn = 1;
   #10

   // reset assertion
   rstn = 0;
   #10

   rstn = 1;
   //feed input
   x0=9'b1;//1
   x1=9'b10;//2
   x2=9'b100;//4
   x3=9'b1000;//8
   x4=9'b10000;//16
   x5=9'b100000;//32
   x6=9'b1000000;//64
   x7=9'b10000000;//128


    $monitor(" time = %t -> vld: %d | y0r: %b | y0i: %b  
                                      y1r: %b | y1i: %b 
                                      y2r: %b | y2i: %b 
                                      y3r: %b | y3i: %b 
                                      y4r: %b | y4i: %b 
                                      y5r: %b | y5i: %b 
                                      y6r: %b | y6i: %b 
                                      y7r: %b | y7i: %b  counter = %d
", $time, vld, y0r, y0i, y1r, y1i, y2r, y2i, y3r, y3i, y4r, y4i, y5r, y5i, y6r, y6i, y7r, y7i, counter_o); 

   //  $display("time = %t -> vld: %d | y0r: %b | y0i: %b", $time, vld, y0r, y0i); 
   //  $display("time = %t -> vld: %d | y1r: %b | y1i: %b", $time, vld, y1r, y1i);
   //  $display("time = %t -> vld: %d | y2r: %b | y2i: %b", $time, vld, y2r, y2i);
   //  $display("time = %t -> vld: %d | y3r: %b | y3i: %b", $time, vld, y3r, y3i);
   //  $display("time = %t -> vld: %d | y4r: %b | y4i: %b", $time, vld, y4r, y4i);
   //  $display("time = %t -> vld: %d | y5r: %b | y5i: %b", $time, vld, y5r, y5i);
   //  $display("time = %t -> vld: %d | y6r: %b | y6i: %b", $time, vld, y6r, y6i);
   //  $display("time = %t -> vld: %d | y7r: %b | y7i: %b", $time, vld, y7r, y7i);

   #100

   $finish;

   end
endmodule
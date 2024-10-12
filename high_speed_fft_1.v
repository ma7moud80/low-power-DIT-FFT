`ifndef OPT_FFT_8

`define OPT_FFT_8

`include "bfu.v"
`include "counter.v"
`include "mux_4x1.v"

module high_speed_fft_1 #(parameter width = 9)(
    input                       rstn,
    input                       clk,
    input       [width-1:0]     x0,    
    input       [width-1:0]     x1,    
    input       [width-1:0]     x2,    
    input       [width-1:0]     x3,    
    input       [width-1:0]     x4,    
    input       [width-1:0]     x5,    
    input       [width-1:0]     x6,    
    input       [width-1:0]     x7,  
    output      [width-1:0]     y0r,
    output      [width-1:0]     y0i,
    output      [width-1:0]     y1r,
    output      [width-1:0]     y1i,
    output      [width-1:0]     y2r,
    output      [width-1:0]     y2i,
    output      [width-1:0]     y3r,
    output      [width-1:0]     y3i,
    output      [width-1:0]     y4r,
    output      [width-1:0]     y4i,
    output      [width-1:0]     y5r,
    output      [width-1:0]     y5i,
    output      [width-1:0]     y6r,
    output      [width-1:0]     y6i,
    output      [width-1:0]     y7r,
    output      [width-1:0]     y7i,
    output                      vld,
    output      [1:0]           counter_o
    );

    parameter w0r=9'b1;
    parameter w0i=9'b0;
    parameter w1r=9'b010110101;//0.707=0.10110101
    parameter w1i=9'b101001011;//-0.707=1.01001011
    parameter w2r=9'b0;
    parameter w2i=9'b111111111;//-1
    parameter w3r=9'b101001011;//-0.707=1.01001011
    parameter w3i=9'b101001011;//-0.707=1.01001011

    //counter 
    //wire [1:0] counter_o; 
    // second stage butterfly units (BFUs) inputs
    wire [width-1:0] bfu1_in1r, bfu1_in1i, bfu1_in2r, bfu1_in2i, bfu1_wr, bfu1_wi, bfu2_in1r, bfu2_in1i, bfu2_in2r, bfu2_in2i, bfu2_wr, bfu2_wi, bfu3_in1r, bfu3_in1i, bfu3_in2r, bfu3_in2i, bfu3_wr, bfu3_wi, bfu4_in1r, bfu4_in1i, bfu4_in2r, bfu4_in2i, bfu4_wr, bfu4_wi; 

    counter #(.values(3)) stage_counter (rstn, clk, 1, counter_o, , vld);

    // the BFU designed sequentailly to store the values that will be mapped to the MUXs inputs
    BFU #(.width(width)) bfu_1(rstn, clk, bfu1_in1r, bfu1_in1i, bfu1_in2r, bfu1_in2i, bfu1_wr, bfu1_wi, y0r, y0i, y4r, y4i);
    BFU #(.width(width)) bfu_2(rstn, clk, bfu2_in1r, bfu2_in1i, bfu2_in2r, bfu2_in2i, bfu2_wr, bfu2_wi, y1r, y1i, y5r, y5i);
    BFU #(.width(width)) bfu_3(rstn, clk, bfu3_in1r, bfu3_in1i, bfu3_in2r, bfu3_in2i, bfu3_wr, bfu3_wi, y2r, y2i, y6r, y6i);
    BFU #(.width(width)) bfu_4(rstn, clk, bfu4_in1r, bfu4_in1i, bfu4_in2r, bfu4_in2i, bfu4_wr, bfu4_wi, y3r, y3i, y7r, y7i);

    mux_4x1 #(.width(width)) bfu1_in1r_mux (counter_o, x0, y0r, y0r, 9'b0, bfu1_in1r);
    mux_4x1 #(.width(width)) bfu1_in1i_mux (counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu1_in1i);
    mux_4x1 #(.width(width)) bfu1_in2r_mux (counter_o, x4, y1r, y2r, 9'b0, bfu1_in2r);
    mux_4x1 #(.width(width)) bfu1_in2i_mux (counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu1_in2i);
    mux_4x1 #(.width(width)) bfu1_wr_mux (counter_o, w0r, w0r, w0r, 9'b0, bfu1_wr);
    mux_4x1 #(.width(width)) bfu1_wi_mux (counter_o, w0i, w0i, w0i, 9'b0, bfu1_wi);
    
    mux_4x1 #(.width(width)) bfu2_in1r_mux (counter_o, x2, y4r, y1r, 9'b0, bfu2_in1r);
    mux_4x1 #(.width(width)) bfu2_in1i_mux (counter_o, 9'b0, 9'b0, y1i, 9'b0, bfu2_in1i);
    mux_4x1 #(.width(width)) bfu2_in2r_mux (counter_o, x6, y5r, y3r, 9'b0, bfu2_in2r);
    mux_4x1 #(.width(width)) bfu2_in2i_mux (counter_o, 9'b0, 9'b0, y3i, 9'b0, bfu2_in2i);
    mux_4x1 #(.width(width)) bfu2_wr_mux (counter_o, w0r, w2r, w1r, 9'b0, bfu2_wr);
    mux_4x1 #(.width(width)) bfu2_wi_mux (counter_o, w0i, w2i, w1i, 9'b0, bfu2_wi);
    
    mux_4x1 #(.width(width)) bfu3_in1r_mux (counter_o, x1, y2r, y4r, 9'b0, bfu3_in1r);
    mux_4x1 #(.width(width)) bfu3_in1i_mux (counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu3_in1i);
    mux_4x1 #(.width(width)) bfu3_in2r_mux (counter_o, x5, y3r, y6r, 9'b0, bfu3_in2r);
    mux_4x1 #(.width(width)) bfu3_in2i_mux (counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu3_in2i);
    mux_4x1 #(.width(width)) bfu3_wr_mux (counter_o, w0r, w0r, w2r, 9'b0, bfu3_wr);
    mux_4x1 #(.width(width)) bfu3_wi_mux (counter_o, w0i, w0i, w2i, 9'b0, bfu3_wi);
    
    mux_4x1 #(.width(width)) bfu4_in1r_mux (counter_o, x3, y6r, y5r, 9'b0, bfu4_in1r);
    mux_4x1 #(.width(width)) bfu4_in1i_mux (counter_o, 9'b0, 9'b0, y5i, 9'b0, bfu4_in1i);
    mux_4x1 #(.width(width)) bfu4_in2r_mux (counter_o, x7, y7r, y7r, 9'b0, bfu4_in2r);
    mux_4x1 #(.width(width)) bfu4_in2i_mux (counter_o, 9'b0, 9'b0, y7i, 9'b0, bfu4_in2i);
    mux_4x1 #(.width(width)) bfu4_wr_mux (counter_o, w0r, w2r, w3r, 9'b0, bfu4_wr);
    mux_4x1 #(.width(width)) bfu4_wi_mux (counter_o, w0i, w2i, w3i, 9'b0, bfu4_wi);



endmodule

`endif
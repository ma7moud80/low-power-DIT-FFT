`ifndef _FFT_8

`define _FFT_8

// `include "bfu_2x4.v"
// `include "bfu_4x4.v"
`include "bfu.v"

module dit_fft_8 #(parameter width = 9)(
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
    output      [width-1:0]     y7i
    );

    parameter w0r=9'b1;
    parameter w0i=9'b0;
    parameter w1r=9'b010110101;//0.707=0.10110101
    parameter w1i=9'b101001011;//-0.707=1.01001011
    parameter w2r=9'b0;
    parameter w2i=9'b111111111;//-1
    parameter w3r=9'b101001011;//-0.707=1.01001011
    parameter w3i=9'b101001011;//-0.707=1.01001011

    // first stage butterfly unit (BFU) ouputs 
    wire [width-1:0] bfu_o_10r, bfu_o_10i, bfu_o_11r, bfu_o_11i, bfu_o_12r, bfu_o_12i, bfu_o_13r, bfu_o_13i, bfu_o_14r, bfu_o_14i, bfu_o_15r, bfu_o_15i, bfu_o_16r, bfu_o_16i, bfu_o_17r, bfu_o_17i; 
    // second stage butterfly unit (BFU) ouputs 
    wire [width-1:0] bfu_o_20r, bfu_o_20i, bfu_o_21r, bfu_o_21i, bfu_o_22r, bfu_o_22i, bfu_o_23r, bfu_o_23i, bfu_o_24r, bfu_o_24i, bfu_o_25r, bfu_o_25i, bfu_o_26r, bfu_o_26i, bfu_o_27r, bfu_o_27i; 


    //stage1
    BFU #(.width(width)) bfu_11(rstn, clk, x0, 9'b0, x4, 9'b0, w0r, w0i, bfu_o_10r, bfu_o_10i, bfu_o_11r, bfu_o_11i);
    BFU #(.width(width)) bfu_12(rstn, clk, x2, 9'b0, x6, 9'b0, w0r, w0i, bfu_o_12r, bfu_o_12i, bfu_o_13r, bfu_o_13i);
    BFU #(.width(width)) bfu_13(rstn, clk, x1, 9'b0, x5, 9'b0, w0r, w0i, bfu_o_14r, bfu_o_14i, bfu_o_15r, bfu_o_15i);
    BFU #(.width(width)) bfu_14(rstn, clk, x3, 9'b0, x7, 9'b0, w0r, w0i, bfu_o_16r, bfu_o_16i, bfu_o_17r, bfu_o_17i);

    //stage2
    BFU #(.width(width)) bfu_21(rstn, clk, bfu_o_10r, 9'b0, bfu_o_12r, 9'b0, w0r, w0i, bfu_o_20r, bfu_o_20i, bfu_o_22r, bfu_o_22i);
    BFU #(.width(width)) bfu_22(rstn, clk, bfu_o_11r, 9'b0, bfu_o_13r, 9'b0, w2r, w2i, bfu_o_21r, bfu_o_21i, bfu_o_23r, bfu_o_23i);
    BFU #(.width(width)) bfu_23(rstn, clk, bfu_o_14r, 9'b0, bfu_o_16r, 9'b0, w0r, w0i, bfu_o_24r, bfu_o_24i, bfu_o_26r, bfu_o_26i);
    BFU #(.width(width)) bfu_24(rstn, clk, bfu_o_15r, 9'b0, bfu_o_17r, 9'b0, w2r, w2i, bfu_o_25r, bfu_o_25i, bfu_o_27r, bfu_o_27i);

    //stage3
    BFU #(.width(width)) bfu_31(rstn, clk, bfu_o_20r, 9'b0, bfu_o_24r, 9'b0, w0r, w0i, y0r, y0i, y4r, y4i);
    BFU #(.width(width)) bfu_32(rstn, clk, bfu_o_21r, bfu_o_21i, bfu_o_25r, bfu_o_25i, w1r, w1i, y1r, y1i, y5r, y5i);
    BFU #(.width(width)) bfu_33(rstn, clk, bfu_o_22r, 9'b0, bfu_o_26r, 9'b0, w2r, w2i, y2r, y2i, y6r, y6i);
    BFU #(.width(width)) bfu_34(rstn, clk, bfu_o_23r, bfu_o_23i, bfu_o_27r, bfu_o_27i, w3r, w3i, y3r, y3i, y7r, y7i);

endmodule

`endif
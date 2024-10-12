`ifndef OPT_FFT_8_1

`define OPT_FFT_8_1

`include "bfu.v"
`include "counter.v"
`include "mux_4x1.v"
`include "mux_8x1.v"
`include "input_mapper.v"
`include "output_mapper.v"

module low_power_fft #(parameter width = 9)(
    input                       rstn,
    input                       clk,
    input                       start,
    input                       vld_in,
    input       [width-1:0]     in,    
    output      [width-1:0]     out_r,
    output      [width-1:0]     out_i,
    output                      vld_out
    );

    parameter w0r=9'b1;
    parameter w0i=9'b0;
    parameter w1r=9'b010110101;//0.707=0.10110101
    parameter w1i=9'b101001011;//-0.707=1.01001011
    parameter w2r=9'b0;
    parameter w2i=9'b111111111;//-1
    parameter w3r=9'b101001011;//-0.707=1.01001011
    parameter w3i=9'b101001011;//-0.707=1.01001011

    // parallel inputs
    wire [width-1:0]     x0,x1,x2,x3,x4,x5,x6,x7;   
    // parralel BFU outputs
    wire [width-1:0]     y0r, y0i, y1r, y1i, y2r, y2i, y3r, y3i, y4r, y4i ,y5r, y5i, y6r, y6i, y7r, y7i;
    // parralel FFT outputs
    wire [width-1:0]     y0r_v, y0i_v, y1r_v, y1i_v, y2r_v, y2i_v, y3r_v, y3i_v, y4r_v, y4i_v, y5r_v, y5i_v, y6r_v, y6i_v, y7r_v, y7i_v;
    //stage counter 
    wire [1:0]           stage_counter_o;
    wire                 stage_counter_vld;
    //output mapper counter 
    wire [2:0]           output_counter_o;
    //BFU parralel inputs
    wire [width-1:0]     bfu1_in1r, bfu1_in1i, bfu1_in2r, bfu1_in2i, bfu1_wr, bfu1_wi, bfu2_in1r, bfu2_in1i, bfu2_in2r, bfu2_in2i, bfu2_wr, bfu2_wi, bfu3_in1r, bfu3_in1i, bfu3_in2r, bfu3_in2i, bfu3_wr, bfu3_wi, bfu4_in1r, bfu4_in1i, bfu4_in2r, bfu4_in2i, bfu4_wr, bfu4_wi; 
    wire                 bfu_vld_o;
    

    // serial to parallel input converter
    input_mapper #(.width(width)) input_mapper1 (rstn, clk, vld_in, in, x0, x1, x2, x3, x4, x5, x6, x7);

    // the counter that drives the BFUs inputs MUXs control signal based on the current stage 
    counter #(.values(3)) stage_counter (rstn, clk, start, stage_counter_o, stage_counter_vld);

    // the BFU designed sequentailly to store the values that will be mapped to the MUXs inputs
    BFU #(.width(width)) bfu_1(rstn, clk, stage_counter_vld, bfu1_in1r, bfu1_in1i, bfu1_in2r, bfu1_in2i, bfu1_wr, bfu1_wi, y0r, y0i, y4r, y4i, y0r_v, y0i_v, y4r_v, y4i_v, bfu_vld_o);
    BFU #(.width(width)) bfu_2(rstn, clk, stage_counter_vld, bfu2_in1r, bfu2_in1i, bfu2_in2r, bfu2_in2i, bfu2_wr, bfu2_wi, y1r, y1i, y5r, y5i, y1r_v, y1i_v, y5r_v, y5i_v);
    BFU #(.width(width)) bfu_3(rstn, clk, stage_counter_vld, bfu3_in1r, bfu3_in1i, bfu3_in2r, bfu3_in2i, bfu3_wr, bfu3_wi, y2r, y2i, y6r, y6i, y2r_v, y2i_v, y6r_v, y6i_v);
    BFU #(.width(width)) bfu_4(rstn, clk, stage_counter_vld, bfu4_in1r, bfu4_in1i, bfu4_in2r, bfu4_in2i, bfu4_wr, bfu4_wi, y3r, y3i, y7r, y7i, y3r_v, y3i_v, y7r_v, y7i_v);

    // MUXs are made to drive the correspoding BFU inputs based in the current stage //
    // BFU1 inputs MUXs
    mux_4x1 #(.width(width)) bfu1_in1r_mux (stage_counter_o, x0, y0r, y0r, 9'b0, bfu1_in1r);
    mux_4x1 #(.width(width)) bfu1_in1i_mux (stage_counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu1_in1i);
    mux_4x1 #(.width(width)) bfu1_in2r_mux (stage_counter_o, x4, y1r, y2r, 9'b0, bfu1_in2r);
    mux_4x1 #(.width(width)) bfu1_in2i_mux (stage_counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu1_in2i);
    mux_4x1 #(.width(width)) bfu1_wr_mux (stage_counter_o, w0r, w0r, w0r, 9'b0, bfu1_wr);
    mux_4x1 #(.width(width)) bfu1_wi_mux (stage_counter_o, w0i, w0i, w0i, 9'b0, bfu1_wi);
    // BFU2 inputs MUXs
    mux_4x1 #(.width(width)) bfu2_in1r_mux (stage_counter_o, x2, y4r, y1r, 9'b0, bfu2_in1r);
    mux_4x1 #(.width(width)) bfu2_in1i_mux (stage_counter_o, 9'b0, 9'b0, y1i, 9'b0, bfu2_in1i);
    mux_4x1 #(.width(width)) bfu2_in2r_mux (stage_counter_o, x6, y5r, y3r, 9'b0, bfu2_in2r);
    mux_4x1 #(.width(width)) bfu2_in2i_mux (stage_counter_o, 9'b0, 9'b0, y3i, 9'b0, bfu2_in2i);
    mux_4x1 #(.width(width)) bfu2_wr_mux (stage_counter_o, w0r, w2r, w1r, 9'b0, bfu2_wr);
    mux_4x1 #(.width(width)) bfu2_wi_mux (stage_counter_o, w0i, w2i, w1i, 9'b0, bfu2_wi);
    // BFU3 inputs MUXs
    mux_4x1 #(.width(width)) bfu3_in1r_mux (stage_counter_o, x1, y2r, y4r, 9'b0, bfu3_in1r);
    mux_4x1 #(.width(width)) bfu3_in1i_mux (stage_counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu3_in1i);
    mux_4x1 #(.width(width)) bfu3_in2r_mux (stage_counter_o, x5, y3r, y6r, 9'b0, bfu3_in2r);
    mux_4x1 #(.width(width)) bfu3_in2i_mux (stage_counter_o, 9'b0, 9'b0, 9'b0, 9'b0, bfu3_in2i);
    mux_4x1 #(.width(width)) bfu3_wr_mux (stage_counter_o, w0r, w0r, w2r, 9'b0, bfu3_wr);
    mux_4x1 #(.width(width)) bfu3_wi_mux (stage_counter_o, w0i, w0i, w2i, 9'b0, bfu3_wi);
    // BFU4 inputs MUXs
    mux_4x1 #(.width(width)) bfu4_in1r_mux (stage_counter_o, x3, y6r, y5r, 9'b0, bfu4_in1r);
    mux_4x1 #(.width(width)) bfu4_in1i_mux (stage_counter_o, 9'b0, 9'b0, y5i, 9'b0, bfu4_in1i);
    mux_4x1 #(.width(width)) bfu4_in2r_mux (stage_counter_o, x7, y7r, y7r, 9'b0, bfu4_in2r);
    mux_4x1 #(.width(width)) bfu4_in2i_mux (stage_counter_o, 9'b0, 9'b0, y7i, 9'b0, bfu4_in2i);
    mux_4x1 #(.width(width)) bfu4_wr_mux (stage_counter_o, w0r, w2r, w3r, 9'b0, bfu4_wr);
    mux_4x1 #(.width(width)) bfu4_wi_mux (stage_counter_o, w0i, w2i, w3i, 9'b0, bfu4_wi);

    // the counter that drives the output MUX control signal 
    counter #(.values(8)) output_mapper_counter (rstn, clk, bfu_vld_o, output_counter_o, vld_out);

    // the output MUXs that drive the output data from parallel to serial
    mux_8x1 #(.width(width)) output_r_mapper (output_counter_o, y0r_v, y1r_v, y2r_v, y3r_v, y4r_v, y5r_v, y6r_v, y7r_v, out_r);
    mux_8x1 #(.width(width)) output_i_mapper (output_counter_o, y0i_v, y1i_v, y2i_v, y3i_v, y4i_v, y5i_v, y6i_v, y7i_v, out_i);

endmodule

`endif
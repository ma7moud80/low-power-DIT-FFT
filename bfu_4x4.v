`ifndef BFU_4X4

`define BFU_4X4

// this bfu module is designed for units that has complex inputs 
module BFU_4x4 #(parameter width = 9) (
    input  signed        [width-1:0] in1r,
    input  signed        [width-1:0] in1i,
    input  signed        [width-1:0] in2r,
    input  signed        [width-1:0] in2i,
    input  signed        [width-1:0] wr,
    input  signed        [width-1:0] wi,
    output               [width-1:0] op1r,
    output               [width-1:0] op1i,
    output               [width-1:0] op2r,
    output               [width-1:0] op2i
); 

wire signed [2*width-1:0] mul_o_r;
wire signed [2*width-1:0] mul_o_i;

assign mul_o_r =  in2r * wr - in2i * wi;
assign mul_o_i =  in2r * wi + in2i * wr;

// the second half portion of the multiplier output is taken as the inputs of this bfu is complex and can be float 
// so the integer part should be considered for more accurarcy
assign op1r = in1r + mul_o_r[2*width-2:width-1];
assign op1i = in1i + mul_o_i[2*width-2:width-1];
assign op2r = in1r - mul_o_r[2*width-2:width-1];
assign op2i = in1i - mul_o_i[2*width-2:width-1];

endmodule

`endif
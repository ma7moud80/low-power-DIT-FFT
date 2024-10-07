`ifndef BFU_2X4

`define BFU_2X4

// this bfu module is designed for units that has real inputs only 
module BFU_2x4 #(parameter width = 9) (
    input  signed        [width-1:0] in1,
    input  signed        [width-1:0] in2,
    input  signed        [width-1:0] wr,
    input  signed        [width-1:0] wi,
    output               [width-1:0] op1r,
    output               [width-1:0] op1i,
    output               [width-1:0] op2r,
    output               [width-1:0] op2i
); 

wire [2*width-1:0] mul_o_r;
wire [2*width-1:0] mul_o_i;

assign mul_o_r =  in2*wr;
assign mul_o_i =  in2*wi;

// the first half portion of the multiplier output is taken as the inputs of this bfu is integer
assign op1r = in1 + mul_o_r[width-1:0];
assign op1i = mul_o_i[width-1:0];
assign op2r = in1 - mul_o_r[width-1:0];
assign op2i = -mul_o_i[width-1:0];

endmodule

`endif
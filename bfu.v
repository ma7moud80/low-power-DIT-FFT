`ifndef BFU

`define BFU

// this bfu module is designed for units that has complex inputs 
module BFU #(parameter width = 9) (
    input                            rstn,
    input                            clk,
    input  signed        [width-1:0] in1r,
    input  signed        [width-1:0] in1i,
    input  signed        [width-1:0] in2r,
    input  signed        [width-1:0] in2i,
    input  signed        [width-1:0] wr,
    input  signed        [width-1:0] wi,
    output reg           [width-1:0] op1r,
    output reg           [width-1:0] op1i,
    output reg           [width-1:0] op2r,
    output reg           [width-1:0] op2i
); 

wire no_floats_or_i;

wire signed [2*width-1:0] mul_o_r;
wire signed [2*width-1:0] mul_o_i;

//assign no_floats_or_i =  ((in1i | in2i) == 0)? 1 : 0;
assign no_floats_or_i =  (in1i == 0 && in2i == 0)? 1 : 0;

assign mul_o_r =  in2r * wr - in2i * wi;
assign mul_o_i =  in2r * wi + in2i * wr;

// a higher half portion of the multiplier output is taken as the inputs of this bfu is complex and can be float 
// so the integer part should be considered for more accurarcy
// the the ouput signals can be should be assigned sequentaily not compinationaly to serve the parallel wise fft structior
// which store BFU output signals for the upcomming stages to save more area and power
always @(posedge clk) begin
   if (!rstn) begin
    op1r <= 0;
    op1i <= 0;
    op2r <= 0;
    op2i <= 0;
   end else begin

    if (no_floats_or_i) begin
    op1r <= in1r + mul_o_r[width-1:0];
    op1i <= in1i + mul_o_i[width-1:0];
    op2r <= in1r - mul_o_r[width-1:0];
    op2i <= in1i - mul_o_i[width-1:0];
    end else begin
    op1r <= in1r + mul_o_r[2*width-2:width-1];
    op1i <= in1i + mul_o_i[2*width-2:width-1];
    op2r <= in1r - mul_o_r[2*width-2:width-1];
    op2i <= in1i - mul_o_i[2*width-2:width-1];
    end
    // op1r <= in1r + no_floats_or_i? mul_o_r[width-1:0] : mul_o_r[2*width-2:width-1];
    // op1i <= in1i + no_floats_or_i? mul_o_i[width-1:0] : mul_o_i[2*width-2:width-1];
    // op2r <= in1r - no_floats_or_i? mul_o_r[width-1:0] : mul_o_r[2*width-2:width-1];
    // op2i <= in1i - no_floats_or_i? mul_o_i[width-1:0] : mul_o_i[2*width-2:width-1];
   end 
end

endmodule

`endif
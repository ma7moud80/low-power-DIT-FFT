
`ifndef _MUX_8X1

`define _MUX_8X1


module mux_8x1 #(
   parameter width = 9
) (
    input  wire [2:0]       control,
    input  wire [width-1:0] in1,
    input  wire [width-1:0] in2,
    input  wire [width-1:0] in3,
    input  wire [width-1:0] in4,
    input  wire [width-1:0] in5,
    input  wire [width-1:0] in6,
    input  wire [width-1:0] in7,
    input  wire [width-1:0] in8,
    output reg [width-1:0] out
);
    always @(*) begin
        case (control)
            'b000 : out=in1; 
            'b001 : out=in2; 
            'b010 : out=in3; 
            'b011 : out=in4; 
            'b100 : out=in5; 
            'b101 : out=in6; 
            'b110 : out=in7; 
            'b111 : out=in8; 
        endcase
    end

endmodule

`endif
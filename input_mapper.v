`ifndef INPUT_MAPPER

`define INPUT_MAPPER


module input_mapper #(parameter width = 9) (
    input                    rstn,
    input                    clk,
    input                    en,
    input    [width-1:0]     in,
    output reg  [width-1:0]     out1,
    output reg  [width-1:0]     out2,
    output reg  [width-1:0]     out3,
    output reg  [width-1:0]     out4,
    output reg  [width-1:0]     out5,
    output reg  [width-1:0]     out6,
    output reg  [width-1:0]     out7,
    output reg  [width-1:0]     out8
);

integer  i;

//reg [width-1:0] register [7:0];

always @(posedge clk) begin
    if (!rstn) begin
        out1 <= 0;
        out2 <= 0;
        out3 <= 0;
        out4 <= 0;
        out5 <= 0;
        out6 <= 0;
        out7 <= 0;
        out8 <= 0;        
        // register[0] <= 0;
        // for (i=0; i<7; i=+1) begin
        //     register[i+1] <= 0;
        // end
    end else begin
        if (en) begin
            out1 <= out2;
            out2 <= out3;
            out3 <= out4;
            out4 <= out5;
            out5 <= out6;
            out6 <= out7;
            out7 <= out8;
            out8 <= in;        
            // out1 <= in;
            // out2 <= out1;
            // out3 <= out2;
            // out4 <= out3;
            // out5 <= out4;
            // out6 <= out5;
            // out7 <= out6;
            // out8 <= out7;        
        end
        // register[0] <= in;
        // for (i=0; i<7; i=+1) begin
        //     register[i+1] <= register[i];
        // end

    end
end

// assign out1 = register[0];
// assign out2 = register[1];
// assign out3 = register[2];
// assign out4 = register[3];
// assign out5 = register[4];
// assign out6 = register[5];
// assign out7 = register[6];
// assign out8 = register[7];

endmodule

`endif
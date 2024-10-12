`ifndef _OUTPUT_MAPPER

`define _OUTPUT_MAPPER

module output_mapper #(parameter width = 9) (
    input                        rstn,
    input                        clk,
    input                        en,
    input        [2:0]           control,
    input        [width-1:0]     in1_r,
    input        [width-1:0]     in1_i,
    input        [width-1:0]     in2_r,
    input        [width-1:0]     in2_i,
    input        [width-1:0]     in3_r,
    input        [width-1:0]     in3_i,
    input        [width-1:0]     in4_r,
    input        [width-1:0]     in4_i,
    input        [width-1:0]     in5_r,
    input        [width-1:0]     in5_i,
    input        [width-1:0]     in6_r,
    input        [width-1:0]     in6_i,
    input        [width-1:0]     in7_r,
    input        [width-1:0]     in7_i,
    input        [width-1:0]     in8_r,
    input        [width-1:0]     in8_i,
    output       [width-1:0]     out_r,
    output       [width-1:0]     out_i
    //output   reg                 vld_o
);

integer i;

reg [width-1:0] register_r [7:0];
reg [width-1:0] register_i [7:0];

always @(posedge clk) begin
    if (!rstn) begin
        for (i=0; i<8; i=+1) begin
            register_r[i] = 0;
            register_i[i] = 0;
        end
    end else begin
        if (en) begin
            // register_r[0] = in1_r;
            // register_i[0] = in1_i;
            // register_r[1] = in2_r;
            // register_i[1] = in2_i;
            // register_r[2] = in3_r;
            // register_i[2] = in3_i;
            // register_r[3] = in4_r;
            // register_i[3] = in4_i;
            // register_r[4] = in5_r;
            // register_i[4] = in5_i;
            // register_r[5] = in6_r;
            // register_i[5] = in6_i;
            // register_r[6] = in7_r;
            // register_i[6] = in7_i;
            // register_r[7] = in8_r;
            // register_i[7] = in8_i;
            register_r[0] = 9;
            register_i[0] = 9;
            register_r[1] = 9;
            register_i[1] = 9;
            register_r[2] = 9;
            register_i[2] = 9;
            register_r[3] = 9;
            register_i[3] = 9;
            register_r[4] = 9;
            register_i[4] = 9;
            register_r[5] = 9;
            register_i[5] = 9;
            register_r[6] = 9;
            register_i[6] = 9;
            register_r[7] = 9;
            register_i[7] = 9;
        end

    end
end

    assign out_r = register_r[control];
    assign out_i = register_i[control];



endmodule

`endif
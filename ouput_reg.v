`ifndef _OUTPUT_REG

`define __OUTPUT_REG

module output_reg #(parameter width = 9) (
    input                   rstn,
    input                   clk,
    input      [width-1:0]  in,  
    output reg  [width-1:0]  out
);

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        out <= 0;
    end else begin
        out <= in;
    end
end



endmodule

`endif
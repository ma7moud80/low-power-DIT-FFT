`ifndef _STAGE_COUNTER

`define _STAGE_COUNTER

module stage_counter #(parameter values = 3) (
    input                             rstn,
    input                             clk,
    output reg [$clog2(values)-1:0]    op,
    output                            vld
);

always @(posedge clk) begin
    if (!rstn) begin
        op <= 0-1;
    end else begin
        if (op!=values-1) begin
            op <= op + 1;
        end else begin
            op <= 0;
        end
    end
end

assign vld = op==2;

endmodule

`endif
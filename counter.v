`ifndef _STAGE_COUNTER

`define _STAGE_COUNTER

module counter #(parameter values = 3) (
    input                             rstn,
    input                             clk,
    //input                             en,
    input                             start,
    output reg [$clog2(values)-1:0]   op,
    output reg                        vld_out
    //output                            is_max
);


always @(posedge clk) begin
    if (!rstn) begin
        op <= 0;
        vld_out <= 0;
    end else begin
        //if (en) begin
        if (start) begin
            vld_out <= 1;
            op <= 0;
        end
        if (vld_out) begin
            if (op != values-1) begin
                op <= op + 1;
            end else begin
                op <= 0;
                vld_out <= 0;
            end
        end
        //end
    end
end

//assign is_max = op==values-1;

endmodule

`endif
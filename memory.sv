module memory #(parameter DATA_WIDTH, parameter ADRR_WIDTH)(
input  logic                      clk,
input  logic                      rstn,
input  logic  [DATA_WIDTH-1:0]    data_in,
input  logic  [ADRR_WIDTH-1:0]    adress,
input  logic                      we,
input  logic                      re,
output logic  [DATA_WIDTH-1:0]    data_out
);

logic [DATA_WIDTH-1:0] internal_memory [2**ADRR_WIDTH-1:0];

always @(posedge clk or negedge rstn)begin
    if(!rstn)begin
        internal_memory <= '{default: 1};
        data_out <= 0;
    end else begin
        if (we) begin
            internal_memory[adress] <= data_in;
        end else if (re) begin
            data_out <= internal_memory[adress];
        end
    end
end



endmodule
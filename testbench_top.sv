import uvm_pkg::*;
`include "uvm_macros.svh"
`include "low_power_fft.v"
`include "parameters.v"
`include "test1.sv"

module tb_top;
    
    logic clk;
    data_if#(`DATA_WIDTH) myif(clk);
    low_power_fft#(`DATA_WIDTH) dut(
    .rstn(myif.rstn),
    .clk(myif.clk),
    .start(myif.start),
    .vld_in(myif.vld_in),
    .in(myif.in),    
    .out_r(myif.out_r),     
    .out_i(myif.out_i),     
    .vld_out(myif.vld_out));
    test1#(`DATA_WIDTH) mytest;


    always #(`CLK_PER/2) clk = ~clk;

    initial begin
        clk = 0;
        uvm_config_db#(virtual data_if#(`DATA_WIDTH))::set(null, "my_test", "vif", myif);
        mytest = new("my_test",null);
        run_test();
    end
endmodule
import uvm_pkg::*;
import test1_pkg::*;
`include "uvm_macros.svh"
`include "memory.sv"
`include "config.sv"

module tb_top;
    
    logic clk;
    data_if#(`DATA_WIDTH,`ADDR_WIDTH) myif(clk);
    memory#(`DATA_WIDTH,`ADDR_WIDTH) dut(.clk(clk), .rstn(myif.rstn), .data_in(myif.data_in), .adress(myif.adress), .we(myif.we), .re(myif.re), .data_out(myif.data_out));
    test1#(`DATA_WIDTH,`ADDR_WIDTH) mytest;


    always #10 clk = ~clk;

    initial begin
        clk = 0;
        uvm_config_db#(virtual data_if#(`DATA_WIDTH,`ADDR_WIDTH))::set(null, "my_test", "vif", myif);
        mytest = new("my_test",null);
        run_test();
    end
endmodule
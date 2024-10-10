import uvm_pkg::*;
`include "uvm_macros.svh"
`include "config.sv"

interface data_if #(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) (input logic clk);
logic                     rstn;
logic                     we;
logic                     re; 
logic [ADDR_WIDTH-1:0]  adress;
logic [DATA_WIDTH-1:0]    data_in;
logic [DATA_WIDTH-1:0]    data_out;

clocking drv_cb @(posedge clk);
  default  input #1 output #1;
    output rstn;
    output we;
    output re;
    output adress;
    output data_in;
    input data_out;
endclocking

clocking mon_cb @(posedge clk);
  default  input #1 output #1;
    input rstn;
    input we;
    input re;
    input adress;
    input data_in;
    input data_out;
endclocking

task rst_data();
  rstn = 0;
  @(posedge clk)
  @(posedge clk)
  rstn = 1;
endtask

// modport driver (
//    clocking drv_cb, input clk, rstn
// );
// modport monitor (
//    clocking mon_cb, input clk, rstn
// );

endinterface
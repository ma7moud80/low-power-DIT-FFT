`ifndef _DATA_IF

`define _DATA_IF

import uvm_pkg::*;
`include "UVM_MACROS.svh"
`include "parameters.v"

interface data_if #(parameter WIDTH = `DATA_WIDTH)(
    input logic clk
);

logic                         rstn;
logic                         vld_in;
logic                         start;
logic  [WIDTH-1:0]            in;
logic  [WIDTH-1:0]            out_r;
logic  [WIDTH-1:0]            out_i;
logic                         vld_out;


// task rst_data();
//     rstn = 0;
//     start = 0;
//     vld_in = 0;
//     in = 0;
//     #`CLK_PER
//     rstn = 1;
// endtask

endinterface

`endif
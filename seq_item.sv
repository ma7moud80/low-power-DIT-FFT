package seq_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh";
`include "config.sv"

class seq_item#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH)  extends uvm_sequence_item;

    bit                            rstn;
    rand bit                       re;
    rand bit                       we;
    rand bit [ADDR_WIDTH-1:0]      adress;
    rand bit [DATA_WIDTH-1:0]      data_in;
    bit      [DATA_WIDTH-1:0]      data_out;
    // rand bit [1:0]                 adress;
    // rand bit [7:0]                 data_in;
    // bit      [7:0]                 data_out;


    `uvm_object_utils_begin(seq_item)
        `uvm_field_int(rstn,UVM_DEFAULT)
        `uvm_field_int(re,UVM_DEFAULT)
        `uvm_field_int(we,UVM_DEFAULT)
        `uvm_field_int(adress,UVM_DEFAULT)
        `uvm_field_int(data_in,UVM_DEFAULT)
        `uvm_field_int(data_out,UVM_DEFAULT)
    `uvm_object_utils_end   
         
    function new(string name="seq_item");
        super.new(name);
    endfunction

    //constraint r_w_c {re!=we;};

endclass

endpackage
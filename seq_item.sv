`ifndef _SEQ_ITEM
`define _SEQ_ITEM


import uvm_pkg::*;
`include "UVM_MACROS.svh"
`include "parameters.v"

class seq_item#(parameter WIDTH = `DATA_WIDTH) extends uvm_sequence_item;
    
    bit                             rstn;
    bit                             vld_in;
    bit                             start;
    rand bit [WIDTH-1:0]            in;
    bit      [WIDTH-1:0]            out_r;
    bit      [WIDTH-1:0]            out_i;
    bit                             vld_out;

    constraint fft_in {in >=0; in<= 20;}
    
    
    `uvm_object_utils_begin(seq_item)
        `uvm_field_int(rstn,UVM_DEFAULT)
        `uvm_field_int(vld_in,UVM_DEFAULT)
        `uvm_field_int(start,UVM_DEFAULT)
        `uvm_field_int(in,UVM_DEFAULT)
        `uvm_field_int(out_r,UVM_DEFAULT)
        `uvm_field_int(out_i,UVM_DEFAULT)
        `uvm_field_int(vld_out,UVM_DEFAULT)
    `uvm_object_utils_end
    
    function new(string name = "seq_item");
        super.new(name);
    endfunction
    
endclass

`endif // _SEQ_ITEM
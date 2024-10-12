`ifndef _SEQUENCE1

`define _SEQUENCE1

import uvm_pkg::*;
`include "UVM_MACROS.svh"
`include "seq_item.sv"
`include "parameters.v"

class sequence1#(parameter WIDTH = `DATA_WIDTH) extends uvm_sequence#(seq_item#(`DATA_WIDTH));
    
    `uvm_object_utils(sequence1)

    int test = 0;

    seq_item item;
    int stimulus_num = 3;
    int FFT_points = 8;
 
    function new(string name = "sequence1");
            super.new(name);
    endfunction

    task body();
        item = seq_item#(`DATA_WIDTH)::type_id::create("sequence1");
        // Reset phase
        start_item(item);
        item.rstn = 0;
        item.start = 0;
        item.vld_in = 0;
        finish_item(item);
        #`CLK_PER; 
        item.rstn = 1;
        // derive the stimulus
        repeat(stimulus_num) begin
    
            // Input assertion phase
            item.vld_in = 1;  // Set valid input high
            repeat(FFT_points) begin
                start_item(item); // Start the transaction for input
                //item.in = 2**test;
                //test++;
                assert(item.randomize()); // Randomize input values
                // Log the generated input values
                `uvm_info(get_name(), "Input values generated from the stimulus:", UVM_LOW);
                item.print();
                finish_item(item); // Finish the transaction after randomization
                #`CLK_PER; 
            end
    
            
            // Start processing phase
            start_item(item); // Start the transaction to begin processing
            item.vld_in = 0; // Set valid input low after all inputs are sent
            item.start = 1; // Assert start signal
            finish_item(item); // Finish the processing start transaction
            #`CLK_PER; 
    
            start_item(item); // Start the transaction to deassert start
            item.start = 0; // Deassert start signal
            finish_item(item); // Finish the processing deassert transaction
            #`CLK_PER;
        end
        #(20*`CLK_PER);
    endtask
    
    

endclass

`endif
//`include "seq_item.sv"
package sequence1_pkg;
    import seq_item_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class sequence1#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_sequence#(seq_item#(DATA_WIDTH,ADDR_WIDTH));
        `uvm_object_utils(sequence1)

        seq_item item;
        
        function new(string name="sequence1");
            super.new(name);
        endfunction
    
        task body;
            item = seq_item#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("sequence1");
            repeat(10) begin
                start_item(item);
                assert(item.randomize());
                item.rstn=1;
                item.re=0;
                item.we=1;
                `uvm_info(get_name(),"write operation test..",UVM_NONE)
                item.print();
                finish_item(item);
            end
            repeat(10) begin
                start_item(item);
                assert(item.randomize());
                item.rstn=1;
                item.re=1;
                item.we=0;
                `uvm_info(get_name(),"read operation test..",UVM_NONE)
                item.print();
                finish_item(item);
            end
        endtask
    
    endclass

endpackage
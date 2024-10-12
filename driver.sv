`ifndef _DRIVER

`define _DRIVER

    import uvm_pkg::*;
    `include "seq_item.sv"
    `include "uvm_macros.svh"
    `include "parameters.v"

    class driver#(parameter WIDTH=`DATA_WIDTH) extends uvm_driver#(seq_item#(WIDTH));
        `uvm_component_utils(driver)

        seq_item#(WIDTH) item;
        virtual data_if#(WIDTH) vif;

        function new(string name="driver", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db#(virtual data_if#(WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            item = seq_item#(WIDTH)::type_id::create("item");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                seq_item_port.get_next_item(item);
                drive;
                `uvm_info(get_name(),"following item is drived to DUT",UVM_NONE)
                item.print();
                seq_item_port.item_done();
            end

        endtask

        task drive();
            //@(posedge vif.clk)
            vif.rstn <= item.rstn;
            vif.vld_in <= item.vld_in;
            vif.start <= item.start;
            vif.in <= item.in;
        endtask

    endclass
    
`endif
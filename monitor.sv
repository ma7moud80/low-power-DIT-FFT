`ifndef _MONITOR

`define _MONITOR

    import uvm_pkg::*;
    `include "seq_item.sv"
    `include "uvm_macros.svh"
    `include "parameters.v"

    class monitor#(parameter WIDTH=`DATA_WIDTH) extends uvm_monitor;
        `uvm_component_utils(monitor)


        seq_item#(WIDTH) item;
        virtual data_if#(WIDTH) vif;

        uvm_analysis_port#(seq_item) sender;

        function new(string name="monitor", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db#(virtual data_if#(WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            item = seq_item#(WIDTH)::type_id::create("item");
            sender = new("sender",this);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sample;
                `uvm_info(get_name(),"following item is sampled from DUT",UVM_NONE)
                item.print();
                sender.write(item);
            end
            
        endtask
        
        task sample();
            @(posedge vif.clk)
            item.rstn = vif.rstn;
            item.vld_in = vif.vld_in;
            item.start = vif.start;
            item.in = vif.in;
            item.out_r = vif.out_r;
            item.out_i = vif.out_i;
            item.vld_out = vif.vld_out;
        endtask

    endclass
    
`endif
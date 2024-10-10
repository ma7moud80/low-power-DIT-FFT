package monitor_pkg;

    import uvm_pkg::*;
    import seq_item_pkg::*;
    `include "uvm_macros.svh"

    `include "config.sv"

    class monitor#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_monitor;
        `uvm_component_utils(monitor)


        seq_item#(DATA_WIDTH,ADDR_WIDTH) item;
        virtual data_if#(DATA_WIDTH,ADDR_WIDTH) vif;

        uvm_analysis_port#(seq_item) sender;

        function new(string name="monitor", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            item = seq_item#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("item");
            sender = new("sender",this);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sample;
                `uvm_info(get_name(),"following item is sampled from DUT",UVM_NONE)
                `uvm_info(get_name(),$sformatf("the if data_out is %h",vif.data_out),UVM_NONE)
                item.print();
                sender.write(item);
            end

        endtask

        task sample();
            @(posedge vif.clk)
            // item.rstn = vif.rstn;
            // item.data_in = vif.data_in;
            // item.adress = vif.adress;
            // item.we = vif.we;
            // item.re = vif.re;
            // item.data_out = vif.data_out;
            item.rstn = vif.mon_cb.rstn;
            item.data_in = vif.mon_cb.data_in;
            item.adress = vif.mon_cb.adress;
            item.we = vif.mon_cb.we;
            item.re = vif.mon_cb.re;
            item.data_out = vif.mon_cb.data_out;
        endtask

    endclass
    
endpackage
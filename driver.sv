package driver_pkg;

    import uvm_pkg::*;
    import seq_item_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class driver#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_driver#(seq_item#(DATA_WIDTH,ADDR_WIDTH));
        `uvm_component_utils(driver)

        seq_item#(DATA_WIDTH,ADDR_WIDTH) item;
        virtual data_if#(DATA_WIDTH,ADDR_WIDTH) vif;

        function new(string name="driver", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            item = seq_item#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("item");
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
            @(posedge vif.clk)
            // vif.rstn <= item.rstn;
            // vif.data_in <= item.data_in;
            // vif.adress <= item.adress;
            // vif.we <= item.we;
            // vif.re <= item.re;
            vif.drv_cb.rstn <= item.rstn;
            vif.drv_cb.data_in <= item.data_in;
            vif.drv_cb.adress <= item.adress;
            vif.drv_cb.we <= item.we;
            vif.drv_cb.re <= item.re;
            //vif.drv_cb.data_out <= item.data_out;
        endtask

    endclass
    
endpackage
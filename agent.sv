package agent_pkg;

    import uvm_pkg::*;
    import config_pkg::*;
    import seq_item_pkg::*;
    import driver_pkg::*;
    import monitor_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class agent#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_agent;
        `uvm_component_utils(agent)

        virtual data_if#(DATA_WIDTH,ADDR_WIDTH) vif;

        // parameter DATA_WIDTH=0;
        // parameter ADDR_WIDTH=0;

        driver#(DATA_WIDTH,ADDR_WIDTH) d0;
        monitor#(DATA_WIDTH,ADDR_WIDTH) m0;
        uvm_sequencer#(seq_item) s0;

        //uvm_analysis_port#(seq_item) sender;

        function new(string name="agent", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            s0 = uvm_sequencer#(seq_item)::type_id::create("sequencer",this);
            d0 = driver#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("driver",this);
            m0 = monitor#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("monitor",this);
            // if(!uvm_config_db#(int)::get(this,"","DATA_WIDTH",DATA_WIDTH) || !uvm_config_db#(int)::get(this,"","ADDR_WIDTH",ADDR_WIDTH))begin
            //     `uvm_fatal(get_name(),"the design parameters cant be fetched from the db");
            // end
            if(!uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::set(this,"driver","vif",vif);
            uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::set(this,"monitor","vif",vif);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            d0.seq_item_port.connect(s0.seq_item_export);
        endfunction 

    endclass
    
endpackage
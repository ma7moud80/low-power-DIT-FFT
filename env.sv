package env_pkg;

    import uvm_pkg::*;
    import agent_pkg::*;
    import scoreboard_pkg::*;
    import coverage_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class env#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_env;
        `uvm_component_utils(env)


        virtual data_if#(DATA_WIDTH,ADDR_WIDTH) vif;

        agent#(DATA_WIDTH,ADDR_WIDTH) a0;
        scoreboard#(DATA_WIDTH,ADDR_WIDTH) s0;
        coverage#(DATA_WIDTH,ADDR_WIDTH) c0;

        function new(string name="env", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            a0=agent#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("agent",this);
            s0=scoreboard#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("scoreboard",this);
            c0=coverage#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("coverage",this);
            
            if(!uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::set(this,"agent","vif",vif);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            a0.m0.sender.connect(s0.receiver);
            a0.m0.sender.connect(c0.analysis_export);
        endfunction

    endclass
    
endpackage
`ifndef _ENV

`define _ENV

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "parameters.v"
    `include "agent.sv"
    `include "scoreboard.sv"

    class env#(parameter WIDTH=`DATA_WIDTH) extends uvm_env;
        `uvm_component_utils(env)


        virtual data_if#(WIDTH) vif;

        agent#(WIDTH) a0;
        scoreboard#(WIDTH) s0;
        //coverage#(WIDTH) c0;

        function new(string name="env", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            a0=agent#(WIDTH)::type_id::create("agent",this);
            s0=scoreboard#(WIDTH)::type_id::create("scoreboard",this);
          //  c0=coverage#(WIDTH)::type_id::create("coverage",this);
            
            if(!uvm_config_db#(virtual data_if#(WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            uvm_config_db#(virtual data_if#(WIDTH))::set(this,"agent","vif",vif);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            a0.m0.sender.connect(s0.receiver);
            //a0.m0.sender.connect(c0.analysis_export);
        endfunction

    endclass
    
`endif
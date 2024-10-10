package test1_pkg;

    import uvm_pkg::*;
    import mem_test_pkg::*;
    import env_pkg::*;
    import sequence1_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class test1#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends mem_test#(DATA_WIDTH,ADDR_WIDTH);
        `uvm_component_utils(test1)

        sequence1#(DATA_WIDTH,ADDR_WIDTH) s0;
        //virtual data_if vif;
        //env e0;

        function new(string name="test1", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            `uvm_info(get_name(),"build phase",UVM_NONE)
            s0=sequence1#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("seq1",this);
        endfunction

         task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);
            vif.rst_data();
            s0.start(e0.a0.s0);
            phase.drop_objection(this);
        endtask

    endclass
    
endpackage
`ifndef _TEST1

`define _TEST1

    import uvm_pkg::*;
    `include "seq_item.sv"
    `include "uvm_macros.svh"
    `include "parameters.v"
    `include "test1.sv"
    `include "fft_test.sv"
    `include "enviroment.sv"
    `include "sequence1.sv"

    class test1#(parameter WIDTH=`DATA_WIDTH) extends fft_test#(WIDTH);
        `uvm_component_utils(test1)

        sequence1#(WIDTH) s0;
        //virtual data_if vif;
        //env e0;

        function new(string name="test1", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            `uvm_info(get_name(),"build phase",UVM_NONE)
            s0=sequence1#(WIDTH)::type_id::create("seq1",this);
        endfunction

         task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);
            //vif.rst_data();
            s0.start(e0.a0.s0);
            phase.drop_objection(this);
        endtask

    endclass

    `endif
package coverage_pkg;
    
    import uvm_pkg::*;
    import config_pkg::*;
    import seq_item_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class coverage#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_subscriber#(seq_item#(DATA_WIDTH,ADDR_WIDTH));
        `uvm_component_utils(coverage)
        
        seq_item#(DATA_WIDTH,ADDR_WIDTH) item;
        
        real cvr_result;
        
        covergroup mem_cvr;
            coverpoint item.rstn;  
            coverpoint item.we;  
            coverpoint item.re;  
            coverpoint item.adress;  
        endgroup

        function void write(seq_item#(DATA_WIDTH,ADDR_WIDTH) t);
            item = t;
            mem_cvr.sample();
        endfunction

        function new(string name="coverage", uvm_component parent);
            super.new(name, parent);
            mem_cvr = new();
        endfunction

        function void extract_phase(uvm_phase phase);
            super.extract_phase(phase);
            cvr_result = mem_cvr.get_coverage();
        endfunction 
        
        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info(get_name(),$sformatf("Coverage is %f",cvr_result ),UVM_NONE)
        endfunction 

    endclass

endpackage
package mem_test_pkg;

    import uvm_pkg::*;
    import env_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class mem_test#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_test;
        `uvm_component_utils(mem_test)
        

        virtual data_if#(DATA_WIDTH,ADDR_WIDTH) vif;

        env#(DATA_WIDTH,ADDR_WIDTH) e0;

        function new(string name="mem_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            `uvm_info(get_name(),"build phase",UVM_NONE)
            e0=env#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("env",this);
            
            if(!uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::get(this,"","vif",vif))begin
                `uvm_fatal(get_name(),"the data if cant be fetched from the db");
            end
            `uvm_info(get_name(),"build phase mid",UVM_NONE)
            uvm_config_db#(virtual data_if#(DATA_WIDTH,ADDR_WIDTH))::set(this,"env","vif",vif);
            `uvm_info(get_name(),"build phase finished",UVM_NONE)
        endfunction

        virtual function void end_of_elaboration();
            print();
        endfunction

        function void report_phase(uvm_phase phase);
            uvm_report_server svr;
            super.report_phase(phase);
            svr = uvm_report_server::get_server();
            if (svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
                `uvm_info(get_name(),"---------------------",UVM_NONE);
                `uvm_info(get_name(),"THE ENTIRE TEST FAIL!",UVM_NONE);
                `uvm_info(get_name(),"---------------------",UVM_NONE);
            end else begin
                `uvm_info(get_name(),"---------------------",UVM_NONE);
                `uvm_info(get_name(),"THE ENTIRE TEST PASS!",UVM_NONE);
                `uvm_info(get_name(),"---------------------",UVM_NONE);
                
            end
        endfunction

    endclass
    
endpackage
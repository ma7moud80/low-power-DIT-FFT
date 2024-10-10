package scoreboard_pkg;

    import uvm_pkg::*;
    import seq_item_pkg::*;
    `include "uvm_macros.svh"
    `include "config.sv"

    class scoreboard#(parameter DATA_WIDTH=`DATA_WIDTH, parameter ADDR_WIDTH=`ADDR_WIDTH) extends uvm_scoreboard;
        `uvm_component_utils(scoreboard)


        seq_item#(DATA_WIDTH,ADDR_WIDTH) item;

        uvm_analysis_imp#(seq_item#(DATA_WIDTH,ADDR_WIDTH),scoreboard#(DATA_WIDTH,ADDR_WIDTH)) receiver;

        logic [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH:0];

        logic [DATA_WIDTH-1:0] temp_addr;

        function new(string name="scoreboard", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            item = seq_item#(DATA_WIDTH,ADDR_WIDTH)::type_id::create("item");
            receiver = new("receiver",this);
            temp_addr=0;
            memory = '{default:'h1};
        endfunction

        function void write(seq_item#(DATA_WIDTH,ADDR_WIDTH) t);
            item =t;
            `uvm_info(get_name(),"following item is subscibed to scoreboard",UVM_NONE)
            t.print();
            
            if (temp_addr != 0) begin
                if (memory[temp_addr] == t.data_out) begin
                    `uvm_info(get_name(),$sformatf("case passed! expected: %h found: %h", memory[temp_addr], t.data_out ),UVM_NONE)
                end else begin
                    `uvm_fatal(get_name(),$sformatf("case failed! expected: %h found: %h", memory[temp_addr], t.data_out ))
                end
                temp_addr =0;
            end

            if (t.we) begin
                memory[t.adress] = t.data_in;
                `uvm_info(get_name()," read operation is capetured.",UVM_NONE)
            end else if (t.re) begin
                temp_addr = t.adress;
            end
        endfunction

    endclass
    
endpackage
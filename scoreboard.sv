`ifndef _SCOREBOARD

`define _SCOREBOARD

    import uvm_pkg::*;
    `include "seq_item.sv"
    `include "uvm_macros.svh"
    `include "parameters.v"
    `include "fft_golden_refrence.sv"

    class scoreboard#(parameter WIDTH=`DATA_WIDTH) extends uvm_scoreboard;
        `uvm_component_utils(scoreboard)



        seq_item#(WIDTH) item;
        // input data fetched from the DUT via the sequence item //
        bit [WIDTH-1:0] fft_inputs [7:0];
        int input_index = 0;
        // for golden model method parameters //
        bit [WIDTH-1:0] fft_outputs_r_actual [7:0];
        bit [WIDTH-1:0] fft_outputs_i_actual [7:0];
        int output_index_actual = 0;
        // output data fetched from the DUT via the sequence item //
        bit [WIDTH-1:0] fft_outputs_r_expected [7:0];
        bit [WIDTH-1:0] fft_outputs_i_expected [7:0];

        uvm_analysis_imp#(seq_item#(WIDTH),scoreboard#(WIDTH)) receiver;

        function new(string name="scoreboard", uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            item = seq_item#(WIDTH)::type_id::create("item");
            receiver = new("receiver",this);
        endfunction

        function void write(seq_item#(WIDTH) t);
            item =t;
            if (t.vld_in) begin
                fft_inputs[input_index] = item.in;
                input_index++;
            end
            if (t.start) begin
                input_index = 0;
                for (int i=0; i<8; i++) begin
                `uvm_info(get_name(),$sformatf("%d input is %b",i,fft_inputs[i]),UVM_NONE)
                end
                fft_ref(fft_inputs, fft_outputs_r_expected, fft_outputs_i_expected);
                for (int i=0; i<8; i++) begin
                `uvm_info(get_name(),$sformatf("%d real output is %b",i,fft_outputs_r_expected[i]),UVM_NONE)
                end
            end
            if (t.vld_out) begin
                fft_outputs_r_actual[output_index_actual] = t.out_r;
                fft_outputs_i_actual[output_index_actual] = t.out_i;
                output_index_actual++;
            end else if (output_index_actual != 0) begin
                output_index_actual = 0;
                verify_data();
            end

            `uvm_info(get_name(),"following item is subscibed to scoreboard",UVM_NONE)
            t.print();

        endfunction

        function void verify_data();
            bit data_mismatched = 0;
            for (int i=0; i<8; i++) begin
                // the verifiation done by checking if there only one unit diff at most between the accurate data generated from the golden model and the actual ones
                if (((fft_outputs_r_expected[i] - fft_outputs_r_actual[i])<=1 || (fft_outputs_r_expected[i] - fft_outputs_r_actual[i])<=-1)  && ((fft_outputs_i_expected[i] - fft_outputs_i_actual[i])<=1 || (fft_outputs_r_expected[i] - fft_outputs_r_actual[i])<=-1)) begin
                `uvm_info(get_name(),$sformatf("the data in index %d matched the expected value: (%b)",i,fft_outputs_r_expected[i]),UVM_NONE)
                end else begin
                    data_mismatched = 1;
                    `uvm_info(get_name(),$sformatf("the data in index %d mis matched the expected value_r: (%b) | actual value_r: (%b) & expected value_i: (%b) | actual value_i: (%b)", i, fft_outputs_r_expected[i], fft_outputs_r_actual[i], fft_outputs_i_expected[i], fft_outputs_i_actual[i]),UVM_NONE)
                end
            end
            if (data_mismatched) begin
                `uvm_fatal(get_name(),"THE SYSTEM DIDNOT PASSED THE TEST")
            end else begin
                `uvm_info(get_name(),"THE SYSTEM PASSED THE TEST",UVM_NONE)
            end
        endfunction
    endclass


    
`endif
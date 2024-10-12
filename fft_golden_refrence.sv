`ifndef _FFT_REF_

`define _FFT_REF_

task fft_ref (
    input  bit [8:0] in [7:0],
    output bit [8:0]      out_real [7:0],
    output bit [8:0]      out_imag [7:0]
);

    real interal_out_r[7:0];
    real interal_out_i[7:0];

    for (int k=0; k<8; k++) begin
        interal_out_r[k] = 0.0;
        interal_out_i[k] = 0.0;
        for (int n=0; n<8; n++) begin
            interal_out_r[k] = interal_out_r[k] + in[n] * $cos(2 * 3.14159 * k * n / 8); 
            interal_out_i[k] = interal_out_i[k] - in[n] * $sin(2 * 3.14159 * k * n / 8); 
        end
        out_real[k] = interal_out_r[k];
        out_imag[k] = interal_out_i[k];
    end

endtask

`endif
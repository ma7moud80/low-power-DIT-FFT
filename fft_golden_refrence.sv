`ifndef _FFT_REF_

`define _FFT_REF_

task fft_ref (
    input  int  in [7:0],
    output real  out_real [7:0],
    output real  out_imag [7:0]
);

    for (int k=0; k<8; k++) begin
        out_real[k] = 0.0;
        out_imag[k] = 0.0;
        for (int n=0; n<8; n++) begin
            out_real[k] = out_real[k] + in[n] * $cos(2 * 3.14159 * k * n / 8); 
            out_imag[k] = out_imag[k] - in[n] * $sin(2 * 3.14159 * k * n / 8); 
        end
    end

endtask

`endif
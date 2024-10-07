`include "fft_golden_refrence.sv"

module fft_ref_tb ();

parameter N = 8;
parameter width = 16;

int in [N-1:0];
real out_real [N-1:0];
real out_imag [N-1:0];


initial begin
    in[0] = 1;
    in[1] = 2;
    in[2] = 4;
    in[3] = 8;
    in[4] = 16;
    in[5] = 32;
    in[6] = 64;
    in[7] = 128;
          fft_ref(in, out_real, out_imag);
          
          for (int i=0; i<N; ++i) begin
              bit [8:0] out_real_b;
              bit [8:0] out_imag_b;
            out_real_b = out_real[i];
            out_imag_b = out_imag[i];
            $display("out_real : %b | out_imag : %b", out_real_b, out_imag_b);
        end
end

endmodule
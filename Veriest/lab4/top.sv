`ifndef TOP_SV
 `define TOP_SV


module top;

   parameter clk_period = 20;
   
   logic clk, rst, clk_gated;
   
   
   fifo_if fif();

   temp_test test(fif);

   fifo #(.FIFO_DEPTH(16)) dut     (.clk(fif.DUT.clk_gated),
				    .rst(fif.DUT.reset),
				    .data_in(fif.DUT.data_in),
				    .data_out(fif.DUT.data_out),
				    .rd_en(fif.DUT.rd_en),
				    .wr_en(fif.DUT.wr_en),
				    .empty(fif.DUT.empty),
				    .full(fif.DUT.full)
);

   
endmodule // top

`endif

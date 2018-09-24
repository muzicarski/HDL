`timescale 1ns/100ps
`include "s2p_register.v"


interface s2p_if(input bit clk);

   parameter width = 8;
   
   bit s_in;
   bit rst;
   
   logic [width-1 : 0] q;

   modport DUT (input clk, rst, s_in,
		output q);
   modport TEST (input q, clk,
		 output rst, si);
endinterface; // s2p_if

program automatic test_1 ( s2p_if.TEST s2pif);

   s2pif.rst = 1'b1;
   repeat (5) @(posedge s2pif.clk);
   s2pif.s_in <= 1'b1;
   repeat (2) @(posedge s2pif.clk);
   s2pif.rst = 1'b0;
   wait(s2pif.q == 'h3);
   s2pif.s_in = 1'b1;
   @posedge (s2pif.clk);
   s2pif.s_in = 1'b0;
   @posedge (s2pif.clk);
   s2pif.s_in = 1'b1;
   repeat (5) @(posedge s2pif.clk);


endprogram
   




module top;

   bit clk;

   parameter width_top = 8;
   



   initial begin
      clk =1'b0;
   end
   
   always #5 clk = ~clk;
   
   s2p_if sif(clk);
   test_1 t1(sif);
   s2p_reg s2p_reg_inst_1 #(width_top)
   (.clk (s2pif.DUT.clk),
    .rst (s2pif.DUT.rst),
    .q   (s2pif.DUT.q),
    .si  (s2pif.DUT.s_in));
      
endmodule   
		 
   

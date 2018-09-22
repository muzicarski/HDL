`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2018 06:44:08 PM
// Design Name: 
// Module Name: counter_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
//`include "../../sources_1/new/dec_counter.v"


interface dec_counter_if (input bit clk);
   logic en, reset, pulse;
//   logic [3:0] q; //use this for dec_counter  AND MUST change PROGRAM TEST 1 ALSO!!!
   logic [11:0] q;  //use this for m_counter 

   modport TEST (input q, pulse, clk,
		 output en, reset);
   modport DUT (input clk, en, reset,
		output q, pulse);
   
endinterface




program automatic test_m_counter (dec_counter_if.TEST dif);
   initial begin
      
      $display("starting simulation : TEST_1");
      dif.reset<=1'b1;
      repeat (2) @(posedge dif.clk);
      dif.reset<=1'b0;
      dif.en<=1'b1;
      wait(dif.q == 12'h111);
      dif.reset<=1'b1;
      repeat (4) @ (posedge dif.clk);
      dif.reset <= 1'b0;
      wait(dif.q == 12'h999);
      dif.en <= 1'b0;
      repeat (5) @(posedge dif.clk);
      dif.en <= 1'b1;
      repeat (10) @ (posedge dif.clk);
      
   end
   
endprogram : test_1


program automatic test_dec_counter (dec_counter_if.TEST dif);
   initial begin
      
      $display("starting simulation : TEST_1");
      dif.reset<=1'b1;
      repeat (2) @(posedge dif.clk);
      dif.reset<=1'b0;
      dif.en<=1'b1;
      wait(dif.q == 4'h7);
      dif.reset<=1'b1;
      repeat (4) @ (posedge dif.clk);
      dif.reset <= 1'b0;
      wait(dif.pulse == 1'b1);
       repeat (5) @(posedge dif.clk);
      wait(dif.q == 4'h9);
      dif.en <= 1'b0;
      repeat (5) @(posedge dif.clk);
      dif.en <= 1'b1;
      repeat (10) @ (posedge dif.clk);
      
   end
   
endprogram : test_dec_counter

   
module counter_tb(
		  );

   bit clk;

   initial begin
      clk =1'b1;
   end

   always #5 clk = ~clk;
   dec_counter_if dif(clk);
   test_1 test1(dif);



/* -----\/----- EXCLUDED -----\/-----
 
 
//Use the following test for dec_counter! 
   test_dec_counter test1(dif);
   
   dec_counter dec_counter_inst_1(.clk(dif.DUT.clk),
	       .reset(dif.DUT.reset),
	       .en(dif.DUT.en),
	       .q(dif.DUT.q),
	       .pulse(dif.DUT.pulse)
	       );
 -----/\----- EXCLUDED -----/\----- */

   
   m_counter m_counter_inst_1(.clk(dif.DUT.clk),
			      .reset(dif.DUT.reset),
			      .en(dif.DUT.en),
			      .q(dif.DUT.q),
			      .pulse(dif.DUT.pulse)
			      );
   
   
   
endmodule

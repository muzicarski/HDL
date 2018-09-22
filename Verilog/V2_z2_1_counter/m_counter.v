`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2018 07:14:22 PM
// Design Name: 
// Module Name: m_counter
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
`include "dec_counter.v"

module m_counter(clk,en,reset,q,pulse
		 );
   
   input clk, en, reset;
   output pulse;
   output [11:0] q;
   

   wire clk_w, en_w, pulse1_w, pulse2_w, pulse3_w, reset_w;
   wire [11:0] q_w;
   
   
   dec_counter d1(.clk(clk_w),
		  .reset(reset_w),
		  .en(en_w),
		  .pulse(pulse1_w),
		  .q(q_w[3:0]));

   
   dec_counter d2(.clk(clk_w),
		  .reset(reset_w),
		  .en(pulse1_w & en_w),
		  .pulse(pulse2_w),
		  .q(q_w[7:4]));

   dec_counter d3(.clk(clk_w),
		  .reset(reset_w),
		  .en(pulse2_w & pulse1_w & en_w),
		  .pulse(pulse3_w),
		  .q(q_w[11:8]));

   
   assign q = q_w;
   assign pulse = pulse3_w;
   assign clk_w = clk;
   assign reset_w = reset;
   assign en_w = en;
   
   
endmodule

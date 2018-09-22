`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2018 06:29:57 PM
// Design Name: 
// Module Name: dec_counter
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


module dec_counter(en,reset,clk,q,pulse
		   );

   input en, reset, clk;
   output pulse;
   output [3:0] q;
   

   reg [3:0] 	    count_s;
   reg 		    pulse_r;

   
   
   always @(posedge clk)
     begin : sync_counter
	if(reset) begin : reset_action
	   count_s <= 4'b0000;
	   pulse_r <= 1'b0;
	end //reset_action
	else if(en)
	  begin : count_up
	     if(count_s == 4'h9) begin : count_ten
		count_s <= 4'h0;
		pulse_r <= 1'h0;
	     end //count_ten
	     else if(count_s == 4'h8) begin : rise_pulse
		count_s <= count_s +1'b1;
		pulse_r <= 1'h1;
	     end//rise_pulse
	     else begin : normal_count
		count_s <= count_s + 1'b1;
		pulse_r <= pulse_r;
	     end //normal_count
	  end //count_up
	else begin : stop_count
	  count_s <= count_s;
	   pulse_r <= pulse_r;
	end// stop_count

	
     end //sync_counter

   assign q = count_s;
   assign pulse = pulse_r;
   
   
endmodule

`ifndef TEMP_TEST_SV
 `define TEMP_TEST_SV


//GATED macro is used to stop the clock to the DUT




program automatic temp_test(fifo_if fif);
   

   parameter clk_period = 20;
   event start_sim;
   logic CLK_EN = `GATED;
   
   
   
   CEnvironment env;
   CTransaction trq[$]; //such queue shall be used for directed tests
   

   initial 
     begin
	env = new(fif,start_sim);
	env.run();
     end

   initial
     begin
	#500 $finish;
     end

   initial
     begin
	fif.CLK_EN = 1'b1;
	fif.clk = 1'b1;
	forever
	  begin
	     #(clk_period / 2) fif.clk = ~fif.clk;
	  end
     end

   initial
     begin
	fif.reset = 1'b1;
	->start_sim;
	
	#(3*clk_period + 3);
	fif.reset = 1'b0;
	$display("reset deactivated @ %0t", $time);
	
     end





	

endprogram // automatic

`endif

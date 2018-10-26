`ifndef FIFO_INTERFACE_SV
 `define FIFO_INTERFACE_SV

 `ifndef GATED
  `define GATED 1
 `else
  `define GATED 0
 `endif



interface fifo_if ;

   parameter clk_period = 20;
   parameter DATA_WIDTH = 8;

   logic clk, reset, clk_gated;
   logic CLK_EN;
   logic rd_en, wr_en, empty, full;
   logic [DATA_WIDTH -1 : 0 ] data_in, data_out;
//   logic 		      signal = {empty, full, data_out};
   

   clocking drv_cb @(posedge clk);
      output 		      wr_en;
      output 		      data_in;
      output 		      rd_en;
   endclocking // d_in_cb

   clocking mon_cb @(posedge clk);
      input 		      wr_en, 
			      rd_en, 
			      data_in,
			      data_out,
			      full,
			      empty;
      
   endclocking // mon_cb

   
      

   modport DUT (input reset, clk_gated, data_in, rd_en, wr_en,
		output empty, full, data_out);
  
   modport DRIVER (clocking drv_cb);
      
      modport MONITOR (clocking mon_cb, input reset, input full, empty, CLK_EN);
	 
	 assign clk_gated = clk & CLK_EN;      

	 property full_valid;
	    !($isunknown(full)) ;
	 endproperty


	 property empty_valid;
	    !($isunknown(empty)) ;
	 endproperty

	 property data_out_valid;
	    !($isunknown(data_out)) ;
	 endproperty

/* -----\/----- EXCLUDED -----\/-----
	 property reset_stable;
	    @(posedge reset)
	      reset #20  $stable(reset);
	 endproperty
 -----/\----- EXCLUDED -----/\----- */

	 
	 
	 signal_validity : assert property(
			 @(posedge clk)
			 disable iff (reset)
			 full_valid and empty_valid and data_out_valid)
	   else $info("Found INVALID signal value");
	 
	 

   

/* -----\/----- EXCLUDED -----\/-----
	 valid_signals: assert property (
					 @(posedge clk)
					 disable iff(reset)
					 
					  !($isunknown(full) or $isunknown(emtpy) or $isunknown(data_out))
					    );
 -----/\----- EXCLUDED -----/\----- */
	 
			    
		



   
   
endinterface // fifo_if


`endif


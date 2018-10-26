`ifndef COVERAGE_CLASS_SV
 `define COVERAGE_CLASS_SV


class CCoverage;

   virtual fifo_if.MONITOR fif;

   covergroup CovFlags @(fif.mon_cb);
      full:coverpoint fif.mon_cb.full;
      empty:coverpoint fif.mon_cb.empty;
   endgroup // CovFlags

   covergroup CovOperations @(fif.mon_cb);
      WRITE: coverpoint fif.mon_cb.wr_en
	{
         bins  YES = {1'b1};
         bins NO = {1'b0};
      }
	 READ: coverpoint fif.mon_cb.rd_en
	   {
            bins  YES = {1'b1};
            bins NO = {1'b0};
	 }
    endgroup // CovOperations

   covergroup CovReset @(fif.reset);
      coverpoint fif.reset
	{
         bins active = {1'b1};
         bins inactive = {1'b0};
        }
   endgroup

   



   
   function new(virtual fifo_if.MONITOR fif);
      this.fif = fif;
      this.CovReset = new;
      this.CovOperations = new;
      this.CovFlags = new;
   endfunction // new

   
   
endclass // CCoverage


  






`endif

`ifndef ENVIRONMENT_CLASS_SV
 `define ENVIRONMENT_CLASS_SV

class CEnvironment #(int FIFO_DEPTH =16);

   event start_sim;
   

   CTransaction tr_queue[$];
   CGenerator gen;
   CDriver drv;
   CMonitor#(FIFO_DEPTH) mon;
   

   function new(virtual fifo_if fif, event start_sim,CTransaction trq[$]='{});
      gen = new(trq);
      drv = new(fif.DRIVER);
      mon = new(fif.MONITOR);

      this.start_sim =start_sim;
      
   endfunction // new

   task run();
      wait(start_sim.triggered);
      
      fork
	 gen.generateTransaction(tr_queue);
	 drv.drive_transaction(tr_queue);
	 mon.flagCheck();
      join
   endtask // run

   
   
   
   
endclass // CEnvironment





`endif

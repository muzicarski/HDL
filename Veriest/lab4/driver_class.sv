`ifndef DRIVER_CLASS_SV
 `define DRIVER_CLASS_SV

class CDriver;

   CTransaction tr;
   
   virtual fifo_if.DRIVER fif;
   

   extern task drive_transaction(ref CTransaction tr_queue[$]);
   extern task readTransaction();
   extern task writeTransaction(CTransaction tr);
   extern task rwTransaction(CTransaction tr);
   extern task clear();
   

   function new(virtual fifo_if.DRIVER fif);
      
      this.fif = fif;

   endfunction // new

   
   
   
endclass // CDriver


task CDriver::drive_transaction(ref CTransaction tr_queue[$]);
   tr= new();
   forever
     begin
	if(tr_queue.size > 0)
	  begin
	     tr = tr_queue.pop_back();

	     if(tr.d_delay)
	       begin
		  clear();
		  repeat(tr.d_delay)
		    begin
		       @(fif.drv_cb);
		    end
	       end
	     case (tr.command)
	       READ : readTransaction();
	       WRITE : writeTransaction(tr);
	       RW: rwTransaction(tr);
	     endcase // case (tr.command)

	  end
	else
	  begin
	     clear();
	     wait(tr_queue.size>0);
	  end
     end

   
endtask

task CDriver::readTransaction();

   fif.drv_cb.wr_en <= 0;
   fif.drv_cb.rd_en <= 1;
   @(fif.drv_cb);
   
endtask

task CDriver::writeTransaction(CTransaction tr);

   fif.drv_cb.wr_en <= 1;
   fif.drv_cb.rd_en <= 0;
   fif.drv_cb.data_in <= tr.data_in;
   @(fif.drv_cb);
   
   
endtask

task CDriver::rwTransaction(CTransaction tr);

   fif.drv_cb.wr_en <= 1;
   fif.drv_cb.rd_en <= 1;
   fif.drv_cb.data_in <= tr.data_in;
   @(fif.drv_cb);
   
endtask


task CDriver::clear();

   fif.drv_cb.wr_en <= 0;
   fif.drv_cb.rd_en <= 0;
   @(fif.drv_cb);
   
   
endtask // CDriver




`endif

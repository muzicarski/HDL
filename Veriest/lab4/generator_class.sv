`ifndef GENERATOR_CLASS_sV
 `define GENERATOR_CLASS_sV

class CGenerator;

   CTransaction tr;
   CTransaction trq[$];
   

   function new(CTransaction trq[$]='{});
      tr = new();
      this.trq = trq;
      
   endfunction // new

   task generateTransaction(ref CTransaction tr_queue[$]);
      if(trq.size)
	begin
	   directedTransactions(tr_queue);
	end
      else
	begin
	   randomTrasactions(tr_queue);
	end
   endtask // generateTransaction




   task directedTransactions(ref CTransaction tr_queue[$]);

      int unsigned num_of_tr;
      num_of_tr = trq.size;

      repeat(num_of_tr)
	begin
	   tr_queue.push_front(trq.pop_back());
	end
      
   endtask // directedTransactions

   


   
   task randomTrasactions (ref CTransaction tr_queue[$]);

      forever
	begin
	   tr = new();
	   assert(tr.randomize())
	     else $error("COULD NOT RANDOMIZE TRANSACTION");
	   tr_queue.push_front(tr);
	   
	   #($urandom % 20); //this delay must exist in order for simulation to work
	end
      
   endtask // randomTrasactions

   
   

   
endclass // CGenerator



     
`endif

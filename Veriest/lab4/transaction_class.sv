`ifndef TRANSACTION_CLASS_SV
 `define TRANSACTION_CLASS_sV


class CTransaction # (int unsigned DATA_WIDTH = 8);

   rand op_t command;

   rand logic [DATA_WIDTH - 1:0] data_in;
   rand int d_delay;
   

   constraint delay_time_c { d_delay dist {0:=10, [1:5]:/30};}


   
   function new();
      this.command = READ;
      this.d_delay = 0;
   endfunction // new

   function void displayTransaction();
      $display(" DATA : %0h name %s", data_in, command.name());
            
   endfunction // displayTransaction

   

   
endclass // CTransaction







`endif

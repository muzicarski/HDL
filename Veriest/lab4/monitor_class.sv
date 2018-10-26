`ifndef MONITOR_CLASS_SV
 `define MONITOR_CLASS_SV

class CMonitor #(int FIFO_DEPTH = 16);

   virtual fifo_if.MONITOR fif;

   const int depth = FIFO_DEPTH;
   int 	     unsigned spaces_filled;
   bit 	     full_flag, empty_flag;

   CCoverage cov;
   CRefModel refmodel;
   

   
   
   function new(virtual fifo_if.MONITOR fif);
      this.fif = fif;
      this.spaces_filled = 0;
      this.full_flag = 1'b0;
      this.empty_flag = 1'b1;
      this.cov = new(fif);
      this.refmodel = new();
   endfunction // new


   extern task flagCheck();
   extern function void updateFlags();
   extern function void checkFlags();
   extern task asyncCheckFlags();
   extern task resetChecker();
   
   
   
endclass // CMonitor









/*TASKS IMPLEMENTATIONS*/


task CMonitor::resetChecker();
   spaces_filled = 0;
   full_flag = 1'b0;
   empty_flag = 1'b1;
//   wait(!(fif.reset));
   
endtask // CMonitor






task CMonitor::flagCheck();

fork

   
   begin : asynchronous_test
      if(fif.reset)
	begin
	   resetChecker();
	   asyncCheckFlags();
	end
      forever
	begin
	   @(posedge fif.reset);
	   resetChecker();
	   asyncCheckFlags();
	end
   end
   

   forever
     begin

	if(fif.reset === 1'b1)
	  begin
	     wait(fif.reset === 1'b0);
	  end
	updateFlags();
	@(fif.mon_cb);
	checkFlags();
     end // forever begin
   
join
endtask // CMonitor


function void CMonitor::updateFlags();
   if(fif.mon_cb.wr_en === 1'b1 && fif.mon_cb.rd_en!==1'b1)
     begin : WRITE
	if(spaces_filled!=depth)
	  begin
	     spaces_filled++;
	  end
     end
   else if(fif.mon_cb.wr_en !== 1'b1 && fif.mon_cb.rd_en===1'b1)
     begin : READ
	if(spaces_filled!=0)
	  begin
	     spaces_filled--;
	  end
     end
   else if(fif.mon_cb.wr_en === 1'b1 && fif.mon_cb.rd_en===1'b1)
     begin : READ_AND_WRITE
	case(spaces_filled)
	  depth:begin
	     spaces_filled--;
	  end
	  0:begin
	     spaces_filled++;
	  end
	endcase // case (spaces_filled)
     end // if (fif.mon_cb.wr_en === 1'b1 && fif.mon_cb.rd_en===1'b1)

   case(spaces_filled)
     depth :
       begin
	  full_flag = 1'b1;
	  empty_flag = 1'b0;
       end
     0: begin
	empty_flag = 1'b1;
	full_flag = 1'b0;
     end
     default : begin
	full_flag = 1'b0;
	empty_flag = 1'b0;
     end
   endcase

//   $display("Spaces filled : %0d", spaces_filled);
   

   
endfunction // CMonitor

function void CMonitor::checkFlags();
   if(fif.mon_cb.full !== full_flag)
     begin
	if(fif.mon_cb.full === 1'b1)
	  begin
	     $error("FULL is set whe it shouldn't be");
	  end
	else
	  begin
	     $error("FULL is inactive when it should be ACTIVE");
	  end
     end // if (fif.mon_cb.full !=== full_flag)
   if(fif.mon_cb.empty !== empty_flag)
     begin
	if(fif.mon_cb.empty === 1'b1)
	  begin
	     $error("EMPTY is set when it shouldn't be");
	  end
	else
	  begin
	     $error("EMPTY is inactive when it should be ACTIVE");
	  end
     end
endfunction // CMonitor::checkFlags




task CMonitor::asyncCheckFlags();
   if(!fif.CLK_EN)
     begin
	@(fif.mon_cb);
	if(fif.full !== full_flag)
	  begin
	     $error("FULL FLAG : cannot be deasserted asynchronously");
	  end // if (fif.mon_cb.full !=== full_flag)
	if(fif.empty !== empty_flag)
	  begin
	   $error("EMPTY FLAG : cannot be asserted asynchronously");
	  end // if (fif.empty !== empty_flag)
     end
endtask // CMonitor::asyncCheckFlags



      




`endif

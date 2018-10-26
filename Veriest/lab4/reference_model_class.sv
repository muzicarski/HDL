`ifndef REFERENCE_MODEL_CLASS
 `define REFERENCE_MODEL_CLASS


class CRefModel #(int FIFO_DEPTH = 16, int DATA_WIDTH = 8);

   int unsigned depth = FIFO_DEPTH;
   int unsigned width = DATA_WIDTH;

   bit [DATA_WIDTH -1 : 0] expected_data[$];


   extern task updateValues();
   
   

   
endclass // CRefModel


task CRefModel::updateValues();
endtask // updateValues




`endif

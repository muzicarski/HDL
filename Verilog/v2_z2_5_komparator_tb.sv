// Code your testbench here
// or browse Examples

module tb;
  
  parameter a_width = 3;
  parameter b_width = 2**a_width - 1;
  
  logic [a_width - 1 : 0] a_in;
  logic [b_width - 1 : 0] b_out;
  
  bit clk = 1'b0;
  
  always #5ns clk = ~clk;
  
  initial begin
    repeat (5) @(posedge clk);
    a_in = 3'b101;
    repeat (3) @(posedge clk);
    a_in = 3'b110;
    repeat (2) @(posedge clk);
    a_in = 3'b001;
    repeat (3) @(posedge clk);
  end	
  
  
  top t1 #(.a_width(a_width)) (.a_in_top ( a_in),
                               .b_out (b_out));	
endmodule
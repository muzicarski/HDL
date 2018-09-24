// Code your design here
module simple_compare(a_in, b_out);
  
  parameter width = 1;
  parameter to_compare = 0;
  
  input [width-1 : 0] a_in;
  output reg b_out;
  
  always @(a_in) begin
    if (a_in == to_compare) begin
      b_out = 1'b1;
    end	
    else begin
      b_out = 1'b0;
    end	
  end	
  
endmodule

module top (a_in_top, b_out);
  parameter a_width = 4;
  parameter n = 2;
  parameter b_width = 2**a_width - 1;
  
  genvar i;
  
  generate
    for(i=b_width-1;i>=0; i--) begin
      simple_compare s1 #(.width = a_width, .to_compare(i)) (.a_in(a_in_top), .b(b_out));
    end
    
  endgenerate
  
endmodule
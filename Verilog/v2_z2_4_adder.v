module adder (cin,a,b,sum,overflow,cout,zero,sign) ;
   parameter width;
   input cin;
   input [width-1 : 0] a, b;

   output [width-1 : 0] sum;
   output 		cout, zero, overflow, sign;


   reg [width - 1 : 0] 	sum_r;
   reg 			zero_r, sign_r, overflow_r;
   reg [width : 0] 	temp_cout_r;
   

   always @(a or b or cin) begin : sum_logic
      sum_r = a+b+cin;
      temp_cout_r = a+b+cin;
   end

   always @(sum) begin : overflow_logic
      if( (a[width - 1] == b[width - 1]) && (a[width-1] != sum[width-1])) begin
	 overflow_r = 1;
      end
      else
	overflow_r = 0;
   end

   always@(sum_r or overflow_r) begin : sign_and_zero_logic
      if(!overflow_r) begin
	 sign_r = sum_r[width -1];
	 if (sum_r == 0) zero_r = 1'b1;
	 else zero_r = zero_r;
      end
      else begin
	 zero_r = 1'b0;
	 sign_r = ~sum_r[width - 1];
      end
   end // sign_and_zero_logic

   assign sum = sum_r;
   assign sign = sign_r;
   assign zero = zero_r;
   assign overflow = overflow_r;
   assign cout = temp_cout_r[width];
   
    
endmodule // adder

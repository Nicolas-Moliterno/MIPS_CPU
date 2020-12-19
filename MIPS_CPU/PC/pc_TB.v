`timescale 1ns/100ps
module pc_TB();
	
	reg clk;
	reg rst;
	
	wire[9:0] count;
	
	pc DUT(
		.clk(clk),
		.rst(rst),
		.count(count)
	);
	
	initial begin
		clk = 0;
		rst = 0;
		
		#250 rst = 1;
		
	end
	
	always #10 clk = ~clk;
	
	initial #300 $stop;
	
endmodule
	
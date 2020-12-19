`timescale 1ns/100ps
module Register_TB();

	reg[31:0] registerIn;
	reg clk;
	reg rst;
	
	wire[31:0] registerOut;
	
	Register DUT(
		.registerIn(registerIn),
		.clk(clk),
		.rst(rst),
		.registerOut(registerOut)
	);
	
	integer i;
	
	
	initial begin 
		clk <= 0;
		rst <= 1;
		registerIn <= 0;
	end
	
	
	initial begin
	
		
		
		#400 rst <= 0;
		for (i = 0; i <= 100; i = i + 1)
			#100 registerIn <= i;
			
		#500 $stop;
	end
	

	always #60 clk = ~clk;
endmodule

	
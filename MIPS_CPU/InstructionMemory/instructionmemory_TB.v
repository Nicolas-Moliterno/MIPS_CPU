`timescale 1ns/100ps

module instructionmemory_TB();

	reg clk;
	reg[9:0] address;
	wire[31:0] dataOut;
	
	instructionmemory DUT(
		.clk(clk),
		.address(address),
		.dataOut(dataOut)
	);
	
	integer i;
	
	initial begin	
			clk = 0;
			address = 0;
		for (i = 0;i<1024;i = i+1)	begin
			#10 address =	i;
		end
		#100 $stop;
	end
	
	always #10 clk = ~clk;
	
	
endmodule

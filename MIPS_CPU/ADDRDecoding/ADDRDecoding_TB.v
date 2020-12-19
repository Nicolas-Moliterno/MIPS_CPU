`timescale 1ns/100ps
module ADDRDecoding_TB();

	reg clk;
	reg[31:0] addr;
	
	wire cs;
	
	ADDRDecoding DUT (
		.clk(clk),
		.addr(addr),
		.cs(cs)
	);
	
	initial begin

		clk = 0;
		addr = 32'h2301;
		 
		#20 addr = 32'h2305;
		#40 addr = 32'h2370;
		#60 addr = 32'h2354;
		#80 addr = 32'h2701; // endereco está fora da faixa
		#100 $stop;
		
	end

	always #10 clk = ~ clk;

endmodule

`timescale 1ns/100ps
module datamemory_TB();

	parameter data_WIDTH = 32;
	parameter ADDR_WIDTH = 10;
	
	//input ports
	reg  [ADDR_WIDTH-1:0] address;
	reg we;
	reg clk;
	reg [data_WIDTH-1:0] dataIn;
	wire [data_WIDTH-1:0] dataOut;
	
	integer k = 0;
	
	datamemory DUT(
		.address(address),
		.dataIn(dataIn),
		.we(we),
		.dataOut(dataOut),
		.clk(clk)
	);
	
	initial begin 
		clk = 0;
		we = 0;
		address = 10'b0;
		dataIn = 31'b0;
		
		we = 1;
		
		for (k=0; k<10; k = k+1) begin
			#70 address = k;
			dataIn = k;
		end
		
		
		we = 0;
		for (k=0;k<10;k=k+1) begin
			#70 address = k;
		end
		
	end
		
	always #25 clk = ~clk;
	
	initial 
	#2300 $stop;

endmodule

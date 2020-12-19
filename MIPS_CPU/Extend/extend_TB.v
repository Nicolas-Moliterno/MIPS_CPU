`timescale 1ns/100ps
module extend_TB();

	reg[15:0] extendIn;
	
	wire[31:0] extendOut;
	reg start;
	
	extend DUT(
		.extendIn(extendIn),
		.extendOut(extendOut),
		.start(start)
	);
	
	initial begin
		start = 1;
		#10 extendIn = 16'b0000_0000_0000_0001;
		
		#10 extendIn = 16'b1000_0000_0000_0000;
	
		#30 start = 0;
	end
endmodule

	
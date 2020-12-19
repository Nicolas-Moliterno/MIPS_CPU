`timescale 1ns/100ps
module alu_TB();

	reg[31:0] A, B;
	reg[2:0] sel;
	wire[31:0] aluOut;
	
	alu DUT(
		.A(A),
		.B(B),
		.sel(sel),
		.aluOut(aluOut)
	);
	
	initial begin 
		A = 1;
		B = 0;
		sel = 0;
		#10 sel = 0;
		#10 sel = 1;
		#10 sel = 2;
		#10 sel = 3;
		
		#150 $stop;
		
	end
endmodule

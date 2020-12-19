`timescale 1ns/100ps

module mux_TB();

	reg[31:0] A, B;
	reg sel;
	
	wire[31:0] muxOut;
	
	mux DUT(
		.A(A),
		.B(B),
		.sel(sel),
		.muxOut(muxOut)
	);
	
	
	initial begin
		A <= 32'hFF;
		B <= 0;
		sel <= 0; //seleciona o A
		
		#5 sel <= 1; //seleciona o B
		#5 A <= 0;
		#5 B <= 32'hFF;
		#5 sel <= 0;
		
	end
	
	initial begin 
		#40 $stop;
	end
	
endmodule

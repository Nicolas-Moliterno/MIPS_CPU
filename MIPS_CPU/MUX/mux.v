module mux(
	
	//inputs
	input[31:0] A, B,
	input sel,
	
	//outputs
	output reg[31:0] muxOut
);

	always @ (*) begin
		case(sel)
			1'b0	:	muxOut <= A; //se canal de selecao eh igual a 0, passa A
			1'b1	:	muxOut <= B; //se canal de selecao eh igual a 1, passa B
		endcase
	end	
endmodule
	
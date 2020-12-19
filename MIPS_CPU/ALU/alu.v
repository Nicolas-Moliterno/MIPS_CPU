module alu(
	//inputs
	input[31:0] A, //rs
	input[31:0] B, //rt
	input[1:0] sel,
	//outputs
	output reg[31:0] aluOut
);

	
	
	always @ (*) begin 			
			case(sel)
				2'b00	:	aluOut <= A + B;
				2'b01	:	aluOut <= A - B;
				2'b10	:	aluOut <= A & B;
				2'b11	:	aluOut <= A | B;
			endcase
	end
	
endmodule
		
				
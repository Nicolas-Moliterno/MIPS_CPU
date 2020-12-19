`timescale 1ns/100ps
module control_TB();

	reg[31:0] Instruction;
	wire[23:0] Ctrl;
	
	control DUT (
		.Instruction(Instruction),
		.Ctrl(Ctrl)
	);
	
	
	reg[31:0] InstructionArray[0:15];
	
	integer i;
	
	initial begin
		
		InstructionArray[0] = 32'b000111_00001_00010_01000_01010_110010;  	// mul
		InstructionArray[1] = 32'b000111_00011_00100_01001_01010_100000;  	// add
		InstructionArray[2] = 32'b000111_01000_01001_01010_01010_100010;  	// sub
		InstructionArray[3] = 32'b000111_00000_00000_00000_01010_111111;  	// nop
		InstructionArray[4] = 32'b000111_00011_00100_01001_01010_100100;  	// and
		InstructionArray[5] = 32'b000111_00011_00100_01001_01010_100101;  	// or
		InstructionArray[6] = 32'b001000_00000_00001_0100_0000_0000_0000; 	// load
		InstructionArray[7] = 32'b001001_01010_01010_0100_0011_1111_1111; 	// store
			
		for(i = 0; i < 8; i = i + 1) begin
		
			#50 Instruction = InstructionArray[i]; 
		
		end
			
		#500 $stop;
	end
endmodule

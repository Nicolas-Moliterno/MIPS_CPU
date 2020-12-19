module instructionmemory(
	//inputs
	input clk,
	input[9:0] address,
	
	//outputs
	output reg[31:0] dataOut
);

	reg[31:0] memoria[0:1023];
	
	initial begin
		////////////Com Pipeline Hazzard ///////////
		memoria[0]	<=	32'b0;
		memoria[1]	<=	32'b0;
		memoria[2]	<=	32'b0;
							//		6	    5	    5		      16
		memoria[3]	<=	32'b001000_00000_00001_0010_0011_0000_0000;	//Load A 2300h = 8960
		memoria[4]	<=	32'b001000_00000_00010_0010_0011_0000_0001;	//Load B 2301h = 8961
		memoria[5]	<=	32'b001000_00000_00011_0010_0011_0000_0010;	//Load C 2302h = 8962
		memoria[6]	<=	32'b001000_00000_00100_0010_0011_0000_0011;	//Load D 2303h = 8963
		//							6      5     5     5     5      6 
		memoria[7]	<=	32'b000111_00001_00010_00101_01010_110010;	//ADD C+D 8962 + 8963 = 17925 
		memoria[8]	<= 32'b000111_00011_00100_00110_01010_010000;	//MUL A*B 8960 * 8961 = 80290560
		memoria[9]	<=	32'b000111_00101_00110_00111_01010_010010;	//SUB (A*B) - (C+D)  80290560 - 17925= 80272635
		//					
		memoria[10]	<=	32'b001001_00000_00111_0010_0110_1111_1111;	//Store (A*B)-(C+D)

		memoria[11]	<=	32'b0;
		
		////////////Sem Pipeline Hazzard ///////////
		memoria[12]	<=	32'b0;
		memoria[13]	<=	32'b0;
		memoria[14]	<=	32'b0;
							//		6	    5	    5		      16
		memoria[15]	<=	32'b001000_00000_00001_0010_0011_0000_0000;	//Load A 2300h = 8960
		memoria[16]	<=	32'b001000_00000_00010_0010_0011_0000_0001;	//Load B 2301h = 8961
		memoria[17]	<=	32'b001000_00000_00011_0010_0011_0000_0010;	//Load C 2302h = 8962
		memoria[18]	<=	32'b001000_00000_00100_0010_0011_0000_0011;	//Load D 2303h = 8963
		
		memoria[19]	<=	32'b0;
		memoria[20]	<=	32'b0;
		memoria[21]	<=	32'b0;
		//							6      5     5     5     5      6 
		memoria[22]	<=	32'b000111_00001_00010_00101_01010_110010;	//ADD C+D 8962 + 8963 = 17925 
		memoria[23]	<= 32'b000111_00011_00100_00110_01010_010000;	//MUL A*B 8960 * 8961 = 80290560
		
		memoria[24]	<=	32'b0;
		memoria[25]	<=	32'b0;
		
		
		memoria[26]	<=	32'b000111_00101_00110_00111_01010_100010;	//SUB (A*B) - (C+D)  80290560 - 17925= 80272635
		//
			
		memoria[27]	<=	32'b0;
		memoria[28]	<=	32'b0;
		memoria[29]	<=	32'b0;
		
		memoria[30]	<=	32'b001001_00000_00111_0010_0110_1111_1111;	//Store (A*B)-(C+D)

		
		memoria[31]	<=	32'b0;
		memoria[32]	<=	32'b0;
		memoria[33]	<=	32'b001000_00000_00110_0010_0110_1111_1111; //Load Resultado final
		memoria[34]	<=	32'b0;
		memoria[35]	<=	32'b0;
		memoria[36]	<=	32'b0;
		memoria[37]	<=	32'b0;
		
		
		
	end
		
	always	@(posedge clk) begin
		dataOut	<=	memoria[address];
	end
	
endmodule
		
		
		
		
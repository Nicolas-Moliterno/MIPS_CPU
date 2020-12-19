module extend(
	//intputs
	input[15:0] extendIn,
	input start,
	
	//outputs
	output reg[31:0] extendOut
);
	
	
	always @(*) begin
		if(start != 1) begin
			if(extendIn[15] == 0)
				extendOut = {16'b0, extendIn};
			else
				extendOut = {16'b1111_1111_1111_1111,extendIn};
		end
		else begin
			extendOut = 0;
		end
		
	end
endmodule

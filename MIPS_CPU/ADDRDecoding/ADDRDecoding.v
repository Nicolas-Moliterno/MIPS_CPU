module ADDRDecoding (
	//inputs
	input[31:0] addr,
	
	//outputs
	output reg cs
);

	always @(addr) begin
		
		if((addr > 32'h22FF) && (addr < 32'h2700)) begin
			cs <= 1'b0;
		end
		
		else begin
			cs <= 1'b1;
		end
	end
endmodule

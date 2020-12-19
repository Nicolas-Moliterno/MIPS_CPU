module registerfile (
	input [31:0] dataIn,
	input we,
	input clk, rst,
	input [4:0] rs,rt,rd,
	output reg [31:0] A,B
);

	integer i;
	
	reg [31:0] register [0:15];
	
	always @ (negedge clk, posedge rst) begin
		i = 0;
			if(rst)
				for(i = 0; i < 16; i = i+1) begin
					register[i] = 32'b0;
				end
			else if (we) 
				register[rd] <= dataIn;
	end
	
	always @ (posedge clk) begin
			A <= register[rs];
			B <= register[rt];
	end

endmodule

// Quartus Prime Verilog Template
// Binary counter

module pc
#(parameter WIDTH=10)
(
	input clk, rst,
	output reg [WIDTH-1:0] count
);

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge rst)
	begin
		if (rst)
			count <= 1'b0;
		else
			count <= count + 1'b1;
	end

endmodule

module datamemory
	//parametros
#(
	parameter data_WIDTH = 32,
	parameter ADDR_WIDTH = 10

)



(
	//input ports
	input [ADDR_WIDTH-1:0] address,
	input we,
	input clk,
	// inout ports
	input [data_WIDTH-1:0] dataIn,
	output reg [data_WIDTH-1:0] dataOut
);
		
	//internal variables
	reg [data_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];
	reg[ADDR_WIDTH-1:0] address_aux;
	
	always @ (posedge clk) begin 
		if (we)
			mem[address_aux] <= dataIn;
		else
			dataOut <= mem[address_aux];
	end
	
	
	initial begin
		mem[0] = 2001; //A
		mem[1] = 4001; //B
		mem[2] = 5001; //C
		mem[3] = 3001;	//D
	end
	
	
	always @ (*) begin
		if(address >= 10'h300 && address <= 10'h3FF) begin
			address_aux <= address - 10'h300;
		end
		
		else begin
			address_aux <= address + 10'h100;
		end
	end
	
endmodule

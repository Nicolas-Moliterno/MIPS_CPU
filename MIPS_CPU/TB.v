`timescale 1ns/100ps
module TB();
	//input
	reg CLK;
	reg [31:0] Data_BUS_READ;
	reg rst;
	//outputs
	wire [31:0] ADDR;
	wire CS;
	wire WR;
	wire [31:0] Data_BUS_WRITE;
	
	
	reg CLK_SYS;
	reg CLK_MUL; 
	reg[31:0] WriteBack;

	
	cpu DUT (
		.CLK(CLK),
		.Data_BUS_READ(Data_BUS_READ),
		.rst(rst),
		.ADDR(ADDR),
		.CS(CS),
		.WR(WR),
		.Data_BUS_WRITE(Data_BUS_WRITE)
	);
	
	
	initial begin
		
								//(sinal que eu quero pegar, como eu chamo o fio no meu projeto)
		$init_signal_spy("DUT/CLK_SYS","CLK_SYS",1);
		$init_signal_spy("DUT/CLK_MUL","CLK_MUL",1);
				
		$init_signal_spy("DUT/fio_mux4Out","WriteBack",1);
				
		rst = 1;
		CLK = 0;
		
		#100 rst = 0;
	end
	
	always #10 CLK = ~CLK;
	
	initial #60000 $stop;
	
	
endmodule

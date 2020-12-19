/*

	ELTD05 - PROJETO DE SISTEMAS DIGITAIS
	PROF. ODILON DUTRA
	UNIVERSIDADE FEDERAL DE ITAJUBÁ
	
	GRUPO 7:
			NICOLAS GUILHERMO SILVA MOLITERNO - 2016000097
			CAIQUE CLEBER DIAS DE REZENDE - 2016003750
			
	QUESTÕES PROPOSTAS:
			
	a) Qual a latência do sistema?
	
			5 pulsos de clock.

	b) Qual o throughput do sistema?
	
			32 bits de instrução por pulso de clock, logo throughput de 32 bits.

	c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador e para o sistema? (Indique a FPGA utilizada)
			
			FPGA EP4CGX150DF31I7AD
			Multiplicador: 183.15 MHz
			Sistema: 56.9 MHz

	d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)
			
			FPGA EP4CGX150DF31I7AD
			Frequência máxima do Multiplicador: 183.15 MHz 
			Frequência máxima do sistema = (183.15)/N. 
			N = número de clocks = 2*16+2 = 34.
			Portanto, frequência máxima do sistema = 5,38 Mhz.

	e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente (se executada em sequência ininterrupta)? Por quê? O que pode 
	ser feito para que a expressão seja calculada corretamente?
			
			Não. Se executar ininterrupdamente ocorre pipeline hazzard porque não dá tempo do valor ser carregado no registrador antes de executar a operação.
			Por isso, é necessário adicionar espaços de instrução 0 entre as operações ou então repetir as instruções de LOAD até que chegue onde
			deve chegar.

	f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com metaestabilidade? Por que?
			Nao acontecera o problema de metaestabilidade porque os pulsos de clock do multiplicador se adequadam 
			ao clock do sistema e os clocks gerados pela PLL não estam defasados entre si.
			
			
	g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por que?
			
			O uso do multiplicador utilizado não é eficiente porque ele deixa o sistema lento, demanda muitos pulsos de clock para um pulso de 
			clock do sistema.
			
			
	h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência de operação maior). Para cada modificação 
	sugerida, qual a nova latência e throughput do sistema?
			
			
			O multiplicador possui uma arquitetura de latencia grande, é possivel segmentar o estagio de execucao em 34 estagios, sendo assim o sistema passa a ter
			38 estagios com um unico clock de frequencia maior. A latencia passa a ser 38 e o Throughput passa a ser de 1 clock por instrucao
			
*/



module cpu (
	//input
	input CLK,
	input[31:0] Data_BUS_READ,
	input rst,
	//outputs
	output[31:0] ADDR,
	output CS,
	output WR,
	output[31:0] Data_BUS_WRITE
);
	
	
	
	
	//FIOS INTERNOS
	
		//Instruction Fetch
			(*keep=1*) wire CLK_SYS, CLK_MUL;
			wire[9:0] fio_PC;
			wire[31:0] fio_control;
	
		//Instruction Decode
		
			wire[23:0] fio_Ctrl0;
			wire[31:0] fio_extendOut;
			wire[31:0] fio_IMMOut;
		
			wire[23:0] fio_Ctrl1;
			wire[31:0] A;
			wire[31:0] B;
		
		//Execute
			wire[31:0] mux1_Out;
			wire[31:0] alu_Out;
			wire[31:0] saida_multi;
			wire[31:0] mux2_Out;
		
			wire[23:0] fio_Ctrl2;
			wire[31:0] fio_B2;
			wire[31:0] fio_D1;
		
		//Memory
			wire[31:0] fio_memoryOut;
			wire addr_cs;
			wire[31:0] fio_mux3Out;
			wire[31:0] fio_D2;
			wire[31:0] fio_CS;
			wire[23:0] fio_Ctrl3;
		
		//Write Back
			(*keep=1*) wire[31:0] fio_mux4Out;
	
	//instruction Fecth
	PLL PLL (
	.areset(rst),
	.inclk0(CLK),
	.c0(CLK_MUL),
	.c1(CLK_SYS)
	);


	instructionmemory instructionmemory(
		.clk(CLK_SYS),
		.address(fio_PC),
		.dataOut(fio_control)
	);

	pc pc(
		.clk(CLK_SYS),
		.rst(rst),
		.count(fio_PC)
	);

	//Instruction Decode
	
	control control(
		.Instruction(fio_control),
		.Ctrl(fio_Ctrl0)
	);
	
	
	extend extend(
		.extendIn(fio_control[15:0]),
		.start(fio_control[20]),
		.extendOut(fio_extendOut)	
	);
	
	Register IMM(
		.registerIn(fio_extendOut), 
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(fio_IMMOut)
	);
	
	Register CTRL1(
		.registerIn({8'b0,fio_Ctrl0}),
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(fio_Ctrl1)
	);
	
	registerfile RegisterFile(
			.dataIn(fio_mux4Out), // [31:0]  voltar aqui para a entrada do ultimo estagio
			.we(fio_Ctrl3[23]),				//voltar aqi para o ultimo estagio fio_Ctrl3 nao criado ainda
			.clk(CLK_SYS),
			.rst(rst),
			.rs(fio_Ctrl0[14:10]),
			.rt(fio_Ctrl0[9:5]),
			.rd(fio_Ctrl3[4:0]), // fio_Ctrl3[4:0] Nao criado ainda qual posicao do registrador quero salvar, vai entrar no Ctrl3
			.A(A),
			.B(B)
	);

	//Execute
	
	
	mux Mux1(
		.A(B),
		.B(fio_IMMOut),
		.sel(fio_Ctrl1[19]),
		.muxOut(mux1_Out)	
	);

	alu ALU(
		.A(A),
		.B(mux1_Out), 
		.sel(fio_Ctrl1[22:21]),
		.aluOut(alu_Out)
	);
		
	multiplicador Multiplicador(
		.Multiplicando(A[15:0]),
		.Multiplicador(mux1_Out[15:0]),
		.St(fio_Ctrl1[15]),
		.Clk(CLK_MUL),
		.Produto(saida_multi)		
	);

	
	mux Mux2(
		.A(saida_multi),
		.B(alu_Out),
		.sel(fio_Ctrl1[18]),
		.muxOut(mux2_Out)	
	);
	
	
	Register D1(
		.registerIn(mux2_Out),
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(ADDR)
	);
	
	Register B2(
		.registerIn(B),
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(Data_BUS_WRITE)
	);
	
	Register Ctrl2(
		.registerIn(fio_Ctrl1),
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(fio_Ctrl2)
	);
	
	
	//Memory
	
	
	datamemory Memory(
		.address(ADDR),
		.we(fio_Ctrl2[16]),
		.clk(CLK_SYS),
		.dataIn(Data_BUS_WRITE),
		.dataOut(fio_memoryOut)
	);
	
	assign WR = fio_Ctrl2[16];
	
	ADDRDecoding ADDRDecoding(
		.addr(ADDR),
		.cs(CS)
	);
	
	Register D2(
		.registerIn(ADDR),
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(fio_D2)
	);
	
	Register M(
		.registerIn(CS),
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(fio_CS)
	);
	
	Register Ctrl3(
		.registerIn(fio_Ctrl2),
		.clk(CLK_SYS),
		.rst(rst),
		.registerOut(fio_Ctrl3)
	);
	
	//Write Back
	
	mux Mux3(
		.A(fio_memoryOut),
		.B(Data_BUS_READ),
		.sel(fio_CS),
		.muxOut(fio_mux3Out)
	);
	
	
	mux Mux4(
		.A(fio_D2),
		.B(fio_mux3Out),
		.sel(fio_Ctrl3[17]),
		.muxOut(fio_mux4Out)
	);

endmodule
	
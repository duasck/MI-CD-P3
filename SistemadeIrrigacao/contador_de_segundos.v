module contador_de_segundos(
    input wire clk,             // Clock de entrada
	 input wire reset,			  // reset 
    input wire [3:0] uni_segundos_in, // Valor inicial de 4 bits para o contador de unidades
    input wire [3:0] dez_segundos_in,      // Dado de entrada para carga inicial
    output wire timeout,         // Saída de timeout
	 output wire [3:0] uni_segundos, // Valor inicial de 4 bits para o contador de unidades
    output wire [3:0] dez_segundos
);

	wire clk_dez, carry;

	// Instâncias dos contadores unidade de segundos
	contador_BCD_decrescente contador_unidade (
		 .clk(clk),
		 .rst(reset),
		 .data(uni_segundos_in),
		 .bcd(uni_segundos),
		 .carry(clk_dez)
	);

	// Instâncias dos contadores dezena de segundos
	contador_BCD_decrescente contador_dezena (
		 .clk(clk_dez),
		 .rst(reset),
		 .data(dez_segundos_in),
		 .bcd(dez_segundos),
		 .carry(carry)
	);

	assign timeout = carry & clk_dez;

endmodule

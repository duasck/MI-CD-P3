module deslocamento_coluna_leds(
	input clk,
	output reg [4:0] coluna
	);
	

	// Passando o valor inicial da coluna
	initial begin
	
		coluna = 5'b00001; // Coluna 5 - MSB; Coluna 0 - LSB;

	end
	
	always @(posedge clk) begin
	
		coluna <= {coluna[3:0], coluna[4]}; // Transforma o MSB no LSB
		
	end
	
endmodule

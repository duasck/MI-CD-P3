module main(
    input HH, 				 //Nível alto
	 input MM, 				 //Nível Médio
	 input LL,				 //Nível Baixo
	 input Ua,				 //Umidade do ar
	 input Us,				 //Umidade do Solo
	 input T,				 //Temperatura
	 input switch,		    //Chave de seleção
	 input r,		       //reset manual
	 input agro,		    //agrodefenssivo 
	 input clk, 			 //Sinal de clock
    output Erro, 			 //Sinal de erro
	 output Alarme, 		 //Alarme
	 output Ve, 			 //Válvula de entrada
	 output a, 				 
	 output b, 				 
	 output c, 				 
	 output d, 				 // a-g: Saídas para os displays de 7 segmentos
	 output e, 				 
	 output f, 				 
	 output g,
	 output d01,
	 output d02,
	 output d03,
	 output d04,
    output [4:0] coluna, //Saída das colunas da matriz de LEDs
    output [6:0] linha,	 //Saída das linhas da matriz de LEDs
	 output LimpezaLed,
	 output agroOut
);
	
	//LevelToPulseMealy b0 (.clk(clk), .data_in(agro), .reset(r), .data_out(agro));
	
	// rever os pinos
	wire clk7seg, clkLeds, V, H, M, L, Bs, Vs;
		
	// Instancia do módulo de irrigação
	sistemaIrrigacao irrigacao_inst (.H(H), .M(M), .L(L), .Ua(Ua), 
	.Us(Us), .T(T), .Vs(Vs), .Bs(Bs));
	
	// Instancia do módulo de nivel
   sistemaNivel nivel_inst (.H(HH), .M(MM), .L(LL), .Cheio(H), .Medio(M), 
	.Baixo(L), .Vazio(V), .Erro(Erro), .Alarme(), .Ve());
	 
	//agrodefenssivo 
	assign agroOut = (agro && (!estado_atual[2]) && estado_atual[1] && estado_atual[0]); // luz verde
	//valvula de entrada
	assign LimpezaLed = (estado_atual[2]) && (!estado_atual[1]) && (!estado_atual[0]); // luz azul
	//assign Alarme = (estado_atual[2]) & (!estado_atual[1]) & (estado_atual[0]); // buzzer 
	//assign Erro = (estado_atual[2]) & (!estado_atual[1]) & (estado_atual[0]); // luz vermelha
	
	// Divisores de clock
	divisorLeds divisor(.clk(clk), .clkLeds(clkLeds));
	divisor7seg(.clk(clkLeds), .clk7seg(clk7seg));
	// Deslocamento da coluna dos LEDs
	
	
	wire countLi;
	wire [2:0] estado_atual;
	
	assign countLi = count && estado_atual[2] && !estado_atual[1] && !estado_atual[0];
	
	//instancia da maquina de estados
	MEF maquinaEstado (.clk(clk), .reset(r), .cheio(H), .gotejamento(Vs), .aspersao(Bs), .erro_nivel(Erro), .countLi(countLi), .state(estado_atual), .enchendo_saida(), .cheio_saida(), 
	.gotejamento_saida(), .aspersao_saida(), .limpeza_saida(), .erro_saida());
	 
	wire [6:0] d1, d2;
	wire [3:0] dezSeg, uniSeg, dezSegIn, uniSegIn;
	// mux_estado
	mux_estado(.estado(estado_atual), .dezena(dezSegIn), .unidade(uniSegIn));
	
	wire res;
	
	assign res = r || ((!estado_atual[2]) && (!estado_atual[1]) && (!estado_atual[0])) && ((!estado_atual[2]) && (!estado_atual[1]) && (!estado_atual[0]));
	//modulo para unidades e dezenas
	contador_de_segundos unidades (.clk(clk7seg), .reset(res), .uni_segundos_in(uniSegIn), .dez_segundos_in(dezSegIn), .timeout(count), .uni_segundos(uniSeg), .dez_segundos(dezSeg));
	
	//Unidade de segundo
	decod7seg dec0 (.A(uniSeg[3]), .B(uniSeg[2]), .C(uniSeg[1]), .D(uniSeg[0]), .a(d1[6]), .b(d1[5]), .c(d1[4]),
	.d(d1[3]), .e(d1[2]), .f(d1[1]), .g(d1[0]));
	
	//Dezena de segundo
	decod7seg dec1 (.A(dezSeg[3]), .B(dezSeg[2]), .C(dezSeg[1]), .D(dezSeg[0]), .a(d2[6]), .b(d2[5]), .c(d2[4]),
	.d(d2[3]), .e(d2[2]), .f(d2[1]), .g(d2[0]));
	
	//Selecionar uma das 4 matrizes
	wire [1:0] select;
	wire [3:0] select_dig;
	
	binary_counter_2bit couter (.clk(clkLeds), .reset(r), .q(select));
	
	wire [6:0] out7seg;

	//Mux 4x1 4bits para os segmentos, duplicando os 2 valores 0 1 = 2 3 
	mux_4x1 mux4x1 (.A(d1), .B(d2), .C(d1), .D(d2), .SEL(select), .out(out7seg));
	
	//Mux 4x1 1bit para selecionar a matriz
   mux_4x1bit mux (.SEL(select), .out(select_dig));

   assign d01 = !select_dig[3];
   assign d02 = !select_dig[2];
   assign d03 = 1;
   assign d04 = 1;
	
	assign a = (!out7seg[6]);
	assign b = (!out7seg[5]);
	assign c = (!out7seg[4]);
	assign d = (!out7seg[3]);
	assign e = (!out7seg[2]);
	assign f = (!out7seg[1]);
	assign g = (!out7seg[0]);
	
	// parte matriz de led
	deslocamento_coluna_leds dc(.clk(clkLeds), .coluna(coluna));
	
	// Atribuição dos valores para as linhas da matriz de LEDs
	assign linha[0] = !(((switch) && ((M && (coluna[2])) || (V && (coluna[1] || coluna[2] || coluna[3]))))
	|| ((!switch) && (Bs || Vs) && (coluna[2] || coluna[3])));
	
	assign linha[1] = !(((switch) && ((L && coluna[1]) || (H && (coluna[1] || coluna[4])) || (V && coluna[1])))
	|| ((!switch) && (Bs || Vs) && (coluna[1] || coluna[4])));
	
	assign linha[2] = !(((switch) && ((L && coluna[1]) || (M && coluna[2]) || (H && (coluna[1] || coluna[4])) 
	|| (V && coluna[1])) || ((!switch) && ((Bs && (coluna[1] || coluna[4]) || (Vs && coluna[1]))))));
	
	assign linha[3] = !(((switch) && ((L && coluna[1]) || (M && coluna[2]) || (H && (coluna[1] || coluna[2] 
	|| coluna[3] || coluna[4])) || (V && (coluna[1] || coluna[2])))) || ((!switch) && (Bs && (coluna[1] || coluna[2] 
	|| coluna[3] || coluna[4]) || (Vs && (coluna[1] || coluna[3] || coluna[4])))));
	
	assign linha[4] = !(((switch) && ((L && coluna[1]) || (M && coluna[2]) || (H && (coluna[1] || coluna[4])) 
	|| (V && coluna[1]))) || ((!switch) && (Bs || Vs) && (coluna[1] || coluna[4])));
	
	assign linha[5] = !(((switch) && ((L && coluna[1]) || (M && coluna[2]) || (H && (coluna[1] || coluna[4])) 
	|| (V && coluna[1]))) || ((!switch) && (Bs || Vs) && (coluna[1] || coluna[4])));
	
	assign linha[6] = !(((switch) && ((L && (coluna[1] || coluna[2] || coluna[3])) || (M && coluna[2]) 
	|| (H && (coluna[1] || coluna[4])) || (V && (coluna[1] || coluna[2] || coluna[3])))) 
	|| ((!switch) && ((Bs && (coluna[1] || coluna[4]))|| (Vs && (coluna[2] || coluna[3])))));
	
endmodule

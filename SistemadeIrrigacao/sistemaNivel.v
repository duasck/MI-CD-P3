module sistemaNivel (input H,
	input M,
	input L,
	output Cheio,
	output Medio,
	output Baixo,
	output Vazio,
	output Erro,
	output Alarme,
	output Ve
);

	//=================DEFINICOES===========
	wire Hinv, Minv, Linv, VeA, VeB, Al, ErA, ErB;

	not N1(Hinv, H);
	not N2(Minv, M);
	not N3(Linv, L);

	// Vazio = ~H ~M ~L
	and V1 (Vazio, Hinv, Minv, Linv);

	// Baixo = ~H ~M L
	and B1 (Baixo, Hinv, Minv, L);

	// Medio = ~H M L
	and M1 (Medio, Hinv, M, L);

	// Cheio = H M L
	and C1 (Cheio, H, M, L);

	// Erro = M ~L + H ~M
	and E2(ErA, M, Linv);
	and E3(ErB, H, Minv);
	or E4(Erro, ErA, ErB);

	//Al = ~L + H ~M
	and A1 (Al, H, Minv);
	or A2(Alarme, Linv, Al);

	//Valvula de entrada
	//Ve = ~H ~M + ~H L
	and Ve1(VeA, Hinv, Minv);
	and Ve2(VeB, Hinv, L);
	or Ve3(Ve, VeA, VeB);

endmodule

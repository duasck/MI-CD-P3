module decod7seg (
    input A,		// Entradas A, B, C, D
	 input B,
	 input C,
	 input D,        
    output a,		// Saídas a, b, c, d, e, f, g
	 output b,
	 output c,
	 output d,
	 output e,
	 output f,
	 output g    
);

    // Cálculo dos segmentos a-g com base nas entradas A, B, C, D

    // Segmento 'a'
    assign a = (A | B | C | (~D)) & (A | (~B) | C | D);

    // Segmento 'b'
    assign b = (A | (~B) | C | (~D)) & (A | (~B) | (~C) | D);

    // Segmento 'c'
    assign c = (A | B | (~C) | D);

    // Segmento 'd'
    assign d = (A | (~B) | C | D) & (A | B | C | (~D)) & (A | ~B | (~C) | (~D));

    // Segmento 'e'
    assign e = (A | (~D)) & (B | C | (~D)) & (A | (~B) | C);

    // Segmento 'f'
    assign f = (A | B | (~D)) & (A | B | (~C));

    // Segmento 'g'
    assign g = (A | B | C) & (A | (~B) | (~C) | (~D));

endmodule

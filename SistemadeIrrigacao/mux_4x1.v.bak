module mux_4x1( //
    input [6:0] A, B, C, D,
    input [1:0] SEL,
    output [6:0] out
);
    wire [6:0] SEL_A, SEL_B, SEL_C, SEL_D;
    wire SEL0_not, SEL1_not;

    // Inversão dos bits de seleção
    not (SEL0_not, SEL[0]);
    not (SEL1_not, SEL[1]);

    // Seleção para cada bit das entradas
    assign SEL_A = {7{(SEL == 2'b00)}} & A;
    assign SEL_B = {7{(SEL == 2'b01)}} & B;
    assign SEL_C = {7{(SEL == 2'b10)}} & C;
    assign SEL_D = {7{(SEL == 2'b11)}} & D;

    // Combinação final das saídas
    assign out = SEL_A | SEL_B | SEL_C | SEL_D;

endmodule

module mux_4x1( //
    input [6:0] A, B, C, D,       // Entradas de 7 bits
    input [1:0] SEL,              // Entrada de seleção de 2 bits
    output [6:0] out              // Saída de 7 bits
);
    wire [6:0] SEL_A, SEL_B, SEL_C, SEL_D; // Fios para armazenar as saídas parciais das entradas selecionadas
    wire SEL0_not, SEL1_not;               // Fios para armazenar os bits invertidos da seleção

    // Inversão dos bits de seleção
    not (SEL0_not, SEL[0]);               // Inverte o bit SEL[0]
    not (SEL1_not, SEL[1]);               // Inverte o bit SEL[1]

    // Seleção para cada bit das entradas
    assign SEL_A = {7{(SEL == 2'b00)}} & A; // Seleciona A se SEL for 00
    assign SEL_B = {7{(SEL == 2'b01)}} & B; // Seleciona B se SEL for 01
    assign SEL_C = {7{(SEL == 2'b10)}} & C; // Seleciona C se SEL for 10
    assign SEL_D = {7{(SEL == 2'b11)}} & D; // Seleciona D se SEL for 11

    // Combinação final das saídas
    assign out = SEL_A | SEL_B | SEL_C | SEL_D; // Combina as saídas selecionadas usando OR

endmodule
module mux2to1teste (
    input wire [3:0] in0,    // Entrada 0 de 4 bits
    input wire [3:0] in1,    // Entrada 1 de 4 bits
    input wire sel,          // Sinal de seleção
    output wire [3:0] out    // Saída de 4 bits
);

    // Portas AND para selecionar as entradas adequadas
    // Quando sel é 0, o sinal out será igual a in0
    // Quando sel é 1, o sinal out será igual a in1
    assign out[0] = (~sel & in0[0]) | (sel & in1[0]);
    assign out[1] = (~sel & in0[1]) | (sel & in1[1]);
    assign out[2] = (~sel & in0[2]) | (sel & in1[2]);
    assign out[3] = (~sel & in0[3]) | (sel & in1[3]);

endmodule
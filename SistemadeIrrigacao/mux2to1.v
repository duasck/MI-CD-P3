module mux2to1 (
    input wire [3:0] in0,    // Entrada 0 de 4 bits
    input wire [3:0] in1,    // Entrada 1 de 4 bits
    input wire sel,          // Sinal de seleção
    output wire [3:0] out    // Saída de 4 bits
);
    assign out = sel ? in1 : in0;  // Atribui in1 para out se sel for verdadeiro, senão atribui in0 para out

endmodule
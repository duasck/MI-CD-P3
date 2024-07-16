module binary_counter_2bit (
    input wire clk,       // Sinal de clock
    input wire reset,     // Sinal de reset
    output wire [1:0] q   // Saída do contador de 2 bits
);
    wire d0, d1;           // Fios intermediários para as entradas dos flip-flops D

    // Instâncias dos flip-flops D
    d_ff ff0 (.clk(clk), .reset(reset), .D(d0), .Q(q[0]));   // Flip-flop D para o bit menos significativo
    d_ff ff1 (.clk(clk), .reset(reset), .D(d1), .Q(q[1]));   // Flip-flop D para o bit mais significativo

    // Lógica do contador (incremento)
    assign d0 = ~q[0];                 // Toggling FF0 (negação do bit atual)
    assign d1 = q[0] ^ q[1];           // Toggling FF1 (XOR entre os bits atuais)

endmodule

module d_ff ( 
    input wire clk,      // Sinal de clock de entrada
    input wire reset,    // Sinal de reset síncrono
    input wire D,        // Dado de entrada
    output reg Q         // Dado de saída registrado
);
    always @(posedge clk or posedge reset) begin
        if (reset)              // Verifica se o sinal de reset está ativo na borda de subida do clock
            Q <= 1'b0;          // Se o reset estiver ativo, o registro é resetado para 0
        else                    // Se o reset não estiver ativo
            Q <= D;             // O dado de entrada é armazenado no registro na próxima borda de subida do clock
    end
endmodule
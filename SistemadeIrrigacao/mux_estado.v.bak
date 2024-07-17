module mux_estado(
    input wire [2:0] estado,    // Entrada de estado de 3 bits
    output reg [3:0] dezena,    // Saída de 4 bits para dezenas
    output reg [3:0] unidade    // Saída de 4 bits para unidades
);

    always @*
    begin
        case (estado)
            3'b010: begin // ESTADO_GOTEJANDO
                dezena <= 4'b0011;
                unidade <= 4'b0000;
            end
            3'b011: begin // ESTADO_ASPERSAO
                dezena <= 4'b0001;
                unidade <= 4'b0101;
            end
            3'b100: begin // ESTADO_LIMPEZA
                dezena <= 4'b0000;
                unidade <= 4'b0101;
            end
            3'b101: begin // ESTADO_ERRO
                dezena <= 4'b0001;
                unidade <= 4'b0000;
            end
            default: begin // Estado padrão caso não corresponda a nenhum dos estados especificados
                dezena <= 4'b0000;
                unidade <= 4'b0000;
            end
        endcase
    end

endmodule

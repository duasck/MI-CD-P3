module MEF (
    input wire clk,
    input wire reset,
    input wire cheio,
    input wire gotejamento,
    input wire aspersao,
    input wire erro_nivel,
	 input wire countLi,
    output reg [2:0] state,
    output reg enchendo_saida,
    output reg cheio_saida,
    output reg gotejamento_saida,
    output reg aspersao_saida,
    output reg limpeza_saida,
    output reg erro_saida
);

    // Definir os estados
    parameter ESTADO_ENCHENDO = 3'b000,
				  ESTADO_CHEIO = 3'b001,
				  ESTADO_GOTEJANDO = 3'b010,
				  ESTADO_ASPERSAO = 3'b011,
				  ESTADO_LIMPEZA = 3'b100,
				  ESTADO_ERRO = 3'b101;

    reg [2:0] current_state, next_state;

    // Lógica de transição de estados
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= ESTADO_ENCHENDO;
        else
            current_state <= next_state;
    end

    // Lógica de próximo estado
    always @(*) begin
        case (current_state)
            ESTADO_ENCHENDO: begin
                if (cheio && !erro_nivel)
                    next_state = ESTADO_CHEIO;
                else if (erro_nivel)
                    next_state = ESTADO_ERRO;
                else
                    next_state = ESTADO_ENCHENDO;
            end
            ESTADO_CHEIO: begin
                if (gotejamento && !erro_nivel)
                    next_state = ESTADO_GOTEJANDO;
                else if (aspersao && !erro_nivel)
                    next_state = ESTADO_ASPERSAO;
					 else if (erro_nivel)
                    next_state = ESTADO_ERRO;
                else
                    next_state = ESTADO_CHEIO;
            end
            ESTADO_GOTEJANDO: begin
                if (!gotejamento && !erro_nivel)
                    next_state = ESTADO_LIMPEZA;
                else if (erro_nivel)
                    next_state = ESTADO_ERRO;
                else
                    next_state = ESTADO_GOTEJANDO;
            end
            ESTADO_ASPERSAO: begin
                if (!aspersao && !erro_nivel)
                    next_state = ESTADO_LIMPEZA;
                else if (erro_nivel)
                    next_state = ESTADO_ERRO;
                else
                    next_state = ESTADO_ASPERSAO;
            end
            ESTADO_LIMPEZA: begin
                if (!cheio && !erro_nivel && countLi)
						  next_state = ESTADO_ENCHENDO;
					 else if(erro_nivel)
						  next_state = ESTADO_ERRO; 
					 else
						  next_state = ESTADO_LIMPEZA;
            end
            ESTADO_ERRO: begin
                if (!erro_nivel && !cheio)
                    next_state = ESTADO_ENCHENDO;
                else
                    next_state = ESTADO_ERRO;
            end
        endcase
    end

    // Lógica de saída
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            enchendo_saida <= 1'b0;
            cheio_saida <= 1'b0;
            gotejamento_saida <= 1'b0;
            aspersao_saida <= 1'b0;
            limpeza_saida <= 1'b0;
            erro_saida <= 1'b0;
        end else begin
            enchendo_saida <= (current_state == ESTADO_ENCHENDO);
            cheio_saida <= (current_state == ESTADO_CHEIO);
            gotejamento_saida <= (current_state == ESTADO_GOTEJANDO);
            aspersao_saida <= (current_state == ESTADO_ASPERSAO);
            limpeza_saida <= (current_state == ESTADO_LIMPEZA);
            erro_saida <= (current_state == ESTADO_ERRO);
        end
    end

     always @(current_state) begin
        state = current_state;
    end

endmodule

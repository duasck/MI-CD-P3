module divisor7seg (
    input wire clk,          // Sinal de clock de entrada
    input wire reset,        // Sinal de reset
    output wire clk7seg      // Sinal de saída para o display de sete segmentos
);
    wire [14:0] d;           // Fio para armazenar o estado do flip-flop D
    wire [14:0] q;           // Fio para saída dos flip-flops D

    // Instanciando os flip-flops D
    d_ff dff_0 (.clk(clk),  .reset(reset), .D(~q[0]), .Q(q[0]));
    d_ff dff_1 (.clk(q[0]), .reset(reset), .D(~q[1]), .Q(q[1]));
    d_ff dff_2 (.clk(q[1]), .reset(reset), .D(~q[2]), .Q(q[2]));
    d_ff dff_3 (.clk(q[2]), .reset(reset), .D(~q[3]), .Q(q[3]));
    d_ff dff_4 (.clk(q[3]), .reset(reset), .D(~q[4]), .Q(q[4]));
    d_ff dff_5 (.clk(q[4]), .reset(reset), .D(~q[5]), .Q(q[5]));
    d_ff dff_6 (.clk(q[5]), .reset(reset), .D(~q[6]), .Q(q[6]));
    d_ff dff_7 (.clk(q[6]), .reset(reset), .D(~q[7]), .Q(q[7]));
    //d_ff dff_8 (.clk(q[7]), .reset(reset), .D(~q[8]), .Q(q[8]));
    d_ff dff_9 (.clk(q[6]), .reset(reset), .D(~clk7seg), .Q(clk7seg));  // Saída do último flip-flop conectada ao sinal de saída
																							//da Matriz de 7 segmentos com aproximadamente 0.745Hz
																							//ou 1,34s

endmodule
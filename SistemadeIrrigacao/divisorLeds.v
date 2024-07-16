module divisorLeds (
    input wire clk,          // Sinal de clock de entrada
    input wire reset,        // Sinal de reset
    output wire clkLeds      // Sinal de saída para os LEDs
);

    wire [14:0] d;           // Fio para armazenar o estado do flip-flop D
    wire [14:0] q;           // Fio para saída dos flip-flops D

    // Instanciando os flip-flops D
    d_ff dff_0 (.clk(clk), .reset(reset), .D(~q[0]), .Q(q[0]));
    d_ff dff_1 (.clk(q[0]), .reset(reset), .D(~q[1]), .Q(q[1]));
    d_ff dff_2 (.clk(q[1]), .reset(reset), .D(~q[2]), .Q(q[2]));
    d_ff dff_3 (.clk(q[2]), .reset(reset), .D(~q[3]), .Q(q[3]));
    d_ff dff_4 (.clk(q[3]), .reset(reset), .D(~q[4]), .Q(q[4]));
    d_ff dff_5 (.clk(q[4]), .reset(reset), .D(~q[5]), .Q(q[5]));
    d_ff dff_6 (.clk(q[5]), .reset(reset), .D(~q[6]), .Q(q[6]));
    d_ff dff_7 (.clk(q[6]), .reset(reset), .D(~q[7]), .Q(q[7]));
    d_ff dff_8 (.clk(q[7]), .reset(reset), .D(~q[8]), .Q(q[8]));
    d_ff dff_9 (.clk(q[8]), .reset(reset), .D(~q[9]), .Q(q[9]));
    d_ff dff_10 (.clk(q[9]), .reset(reset), .D(~q[10]), .Q(q[10]));
    d_ff dff_11 (.clk(q[10]), .reset(reset), .D(~q[11]), .Q(q[11]));
    d_ff dff_12 (.clk(q[11]), .reset(reset), .D(~q[12]), .Q(q[12]));
    d_ff dff_13 (.clk(q[12]), .reset(reset), .D(~q[13]), .Q(q[13]));
    d_ff dff_14 (.clk(q[13]), .reset(reset), .D(~q[14]), .Q(q[14]));
    d_ff dff_15 (.clk(q[14]), .reset(reset), .D(~clkLeds), .Q(clkLeds));  // Saída do último flip-flop conectada ao sinal
																								  //de saída para a matriz de LEDs com aproximadamente
																								  //762,94Hz ou 1,31ms

endmodule
module binary_counter_2bit (
    input wire clk,
    input wire reset,
    output wire [1:0] q
);
    wire d0, d1;

    // Instâncias dos flip-flops D
    d_ff ff0 (.clk(clk), .reset(reset), .D(d0), .Q(q[0]));
    d_ff ff1 (.clk(clk), .reset(reset), .D(d1), .Q(q[1]));

    // Lógica do contador (incremento)
    assign d0 = ~q[0];                 // Toggling FF0
    assign d1 = q[0] ^ q[1];           // Toggling FF1

endmodule

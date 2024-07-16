module mux_4x1bit(
    input [1:0] SEL,
    output [3:0] out
);

    // Seleção da saída com base em SEL
    assign out = (SEL == 2'b00) ? 4'b0001 :
                 (SEL == 2'b01) ? 4'b0010 :
                 (SEL == 2'b10) ? 4'b0100 :
                 (SEL == 2'b11) ? 4'b1000 :
                 4'b0000; // Default case, although this should never be reached.

endmodule
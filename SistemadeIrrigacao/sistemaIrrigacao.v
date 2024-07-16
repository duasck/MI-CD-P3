module sistemaIrrigacao (
    input H,
    input M,
    input L,
    input Ua,
    input Us,
    input T,
    output Vs,
    output Bs
);

    // Declaração de fios internos
    wire Ba, Bb, Aa, Ab;
    wire UsInv, UaInv, Tinv, Hinv, Minv;

    // Inversores para as entradas
    not N1(UsInv, Us);
    not N2(UaInv, Ua);
    not N3(Hinv, H);
    not N4(Minv, M);
    not N5(Tinv, T);

    // Cálculo das saídas Vs (aspersão) e Bs (gotejamento)

    // Aspersão [Bs] = ~Us ~Ua ~H ~M L + ~Us ~T M L
    and B1 (Ba, UsInv, UaInv, Hinv, Minv, L);
    and B2 (Bb, UsInv, Tinv, M, L);
    or B3 (Bs, Ba, Bb);

    // Gotejamento [Vs] = ~Us Ua ~H ~M L + ~Us Ua T M L
    and A1 (Aa, UsInv, Ua, Hinv, Minv, L);
    and A2 (Ab, UsInv, Ua, T, M, L);
    or A3 (Vs, Aa, Ab);

endmodule
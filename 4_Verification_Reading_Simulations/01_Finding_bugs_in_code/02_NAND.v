module top_module (
    input a,
    input b,
    input c,
    output out
);//

    wire out_n;
    assign out = ~out_n;
    andgate inst1 (
        .out(out_n),
        .a(a),
        .b(b),
        .c(c),
        .d(1),
        .e(1)
    );

endmodule


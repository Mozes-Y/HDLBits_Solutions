module top_module (
    input x,
    input y,
    output z
);
    reg A_z1, A_z2, B_z1, B_z2;
    
    A IA [1:0] (
        .x(x),
        .y(y),
        .z({A_z1, A_z2})
    );
    B IB [1:0] (
        .x(x),
        .y(y),
        .z({B_z1, B_z2})
    );
    
    assign z = (A_z1 | B_z1) ^ (A_z2 & B_z2);

endmodule

module A (
    input x,
    input y,
    output z
);
    
    assign z = (x ^ y) & x;

endmodule

module B (
    input x,
    input y,
    output z
);
    
    assign z = x ~^ y;

endmodule


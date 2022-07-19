module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    
    wire cout;
    wire [31:0] comp;
    
    assign comp = b ^ {32{sub}};
    
    add16 u1_add16 (
        .cin (sub        ),
        .a   (a[15:0]    ),
        .b   (comp[15:0] ),
        .sum (sum[15:0]  ),
        .cout(cout       )
    );
    add16 u2_add16 (
        .cin (cout       ),
        .a   (a[31:16]   ),
        .b   (comp[31:16]),
        .sum (sum[31:16] ),
        .cout(           )
    );

endmodule

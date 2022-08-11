module top_module( 
    input [399:0] a, b,
    input cin,
    output reg cout,
    output reg [399:0] sum
);
    
    reg [98:0] mid;
    
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin: BCD_add
            bcd_fadd my_bcd_add(
                .a   (a[(i + 1) * 4 - 1:i * 4]  ),
                .b   (b[(i + 1) * 4 - 1:i * 4]  ),
                .cin (i == 0 ? cin : mid[i - 1] ),
                .cout(i == 99 ? cout : mid[i]   ),
                .sum (sum[(i + 1) * 4 - 1:i * 4])
            );
        end
    endgenerate

endmodule

//version2
module top_module( 
    input [399:0] a, b,
    input cin,
    output reg cout,
    output reg [399:0] sum
);
    
    reg [98:0] mid;
    
    bcd_fadd my_bcd_add [99:0] (
        .a(a),
        .b(b),
        .cin({mid[98:0], cin}),
        .cout({cout, mid[98:0]}),
        .sum(sum)
    );

endmodule

module top_module ( 
    input [99:0] a, b,
    input cin,
    output reg [99:0] cout,
    output reg [99:0] sum
);

    genvar i;
    generate
        for (i = 0; i < $bits(sum); i = i + 1) begin: add_gen
            full_add1 my_add (
                .a    (a[i]),
                .b    (b[i]),
                .cin  (i == 0 ? cin : cout[i - 1]),
                .cout (cout[i]),
                .sum  (sum[i])
            );
        end
    endgenerate

endmodule

module full_add1 (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

// Full adder module here
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

//version2
module top_module( 
    input [99:0] a, b,
    input cin,
    output reg [99:0] cout,
    output reg [99:0] sum
);

    full_add1 my_add [99:0](
        .a(a),
        .b(b),
        .cin({cout[98:0], cin}),
        .cout(cout),
        .sum(sum)
    );
    
endmodule

module full_add1 (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

// Full adder module here
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

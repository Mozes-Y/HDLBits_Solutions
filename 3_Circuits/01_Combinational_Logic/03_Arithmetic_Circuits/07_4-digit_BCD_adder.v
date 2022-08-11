module top_module ( 
    input [15:0] a, b,
    input cin,
    output reg cout,
    output reg [15:0] sum
);
    
    reg [2:0] mid_wire;
    
    bcd_fadd my_4_digit_adder [3:0] (
        .a(a),
        .b(b),
        .cin({mid_wire, cin}),
        .cout({cout, mid_wire}),
        .sum(sum)
    );

endmodule

module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

 	wire cout6, cout;
    assign {cout6, s[6:0]} = a[6:0] + b[6:0];
    assign {cout, s[7]} = a[7] + b[7] + cout6;
    assign overflow = cout ^ cout6;

endmodule
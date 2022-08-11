module top_module (
    input [3:0] x,
    input [3:0] y, 
    output reg [4:0] sum
);
    
    reg [2:0] cout;

    full_adder my_RCA [3:0] (
        .a(x),
        .b(y),
        .cin({cout[2:0], 1'b0}),
        .cout({sum[4], cout}),
        .sum(sum[3:0])
    );

endmodule

module full_adder( 
    input a, b, cin,
    output cout, sum
);
    
    assign cout = a & b | a & cin | b & cin;
    assign sum = a ^ b ^ cin;

endmodule

/* 2nd version
module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// This circuit is a 4-bit ripple-carry adder with carry-out.
	assign sum = x+y;	// Verilog addition automatically produces the carry-out bit.

	// Verilog quirk: Even though the value of (x+y) includes the carry-out, (x+y) is still considered to be a 4-bit number (The max width of the two operands).
	// This is correct:
	// assign sum = (x+y);
	// But this is incorrect:
	// assign sum = {x+y};	// Concatenation operator: This discards the carry-out
endmodule */

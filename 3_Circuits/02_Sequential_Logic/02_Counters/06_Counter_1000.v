module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);

    reg [3:0] Q [2:0];
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = Q[0] > 4'h8 ? 1'b1 : 1'b0;
    assign c_enable[2] = c_enable[1] && (Q[1] > 4'h8) ? 1'b1 : 1'b0;
    assign OneHertz = c_enable[2] && (Q[2] > 4'h8) ? 1'b1 : 1'b0;
    
    bcdcount counter [2:0] (
        .clk({3{clk}}),
        .reset({3{reset}}),
        .enable(c_enable[2:0]),
        .Q(Q)
    );

endmodule

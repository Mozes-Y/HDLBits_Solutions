module top_module (
    input clk,
    input reset,
    input enable,
    output reg [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);
    
    assign c_d = 4'h1;
    assign c_enable = enable;
    assign c_load = reset | (Q == 4'hc && enable == 1'b1);

    count4 the_counter (
        .clk(clk),
        .enable(c_enable),
        .load(c_load),
        .d(c_d),
        .Q(Q)
    );

endmodule

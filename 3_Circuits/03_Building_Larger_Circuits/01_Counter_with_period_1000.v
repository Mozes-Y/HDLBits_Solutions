module top_module (
    input clk,
    input reset,
    output [9:0] q
);

    wire [9:0] q_next;
    assign q_next = (q == 10'd999 ? 10'b0 : (q + 10'b1));

    always @(posedge clk) begin
        q <= reset ? 10'b0 : q_next;
    end

endmodule

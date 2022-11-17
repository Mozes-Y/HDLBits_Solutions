module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    parameter LEFT=1'b0, RIGHT=1'b1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT: next_state = (bump_left == 1'b1 ? RIGHT : LEFT);
            RIGHT: next_state = (bump_right == 1'b1 ? LEFT : RIGHT);
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        state <= (areset == 1'b1 ? LEFT : next_state);
    end

    // Output logic
    assign walk_left = (state == LEFT ? 1'b1 : 1'b0);
    assign walk_right = (state == RIGHT ? 1'b1 : 1'b0);

endmodule

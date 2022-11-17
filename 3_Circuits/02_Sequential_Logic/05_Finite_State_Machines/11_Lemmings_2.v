module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);
    
    parameter LEFT = 2'b10, RIGHT = 2'b11, FALL_L = 2'b00, FALL_R = 2'b01;
    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            LEFT  : next_state = (ground == 1'b0 ? FALL_L : (bump_left == 1'b1 ? RIGHT : LEFT));
            RIGHT : next_state = (ground == 1'b0 ? FALL_R : (bump_right == 1'b1 ? LEFT : RIGHT));
            FALL_L: next_state = (ground == 1'b0 ? FALL_L : LEFT);
            FALL_R: next_state = (ground == 1'b0 ? FALL_R : RIGHT);
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        state <= (areset == 1'b1 ? LEFT : next_state);
    end
    
    assign walk_left  = (state == LEFT  ? 1'b1 : 1'b0);
    assign walk_right = (state == RIGHT ? 1'b1 : 1'b0);
    assign aaah       = (state == FALL_L || state == FALL_R ? 1'b1 : 1'b0);

endmodule

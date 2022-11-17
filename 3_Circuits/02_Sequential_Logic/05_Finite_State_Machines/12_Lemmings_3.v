module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);
    
    parameter LEFT = 3'b000, RIGHT = 3'b001, FALL_L = 3'b010, FALL_R = 3'b011, DIG_L = 3'b100, DIG_R = 3'b101;
    reg [2:0] state, next_state;
    
    always @(*) begin
        case (state)
            LEFT  : next_state = (ground == 1'b0 ? FALL_L : (dig == 1'b1 ? DIG_L : (bump_left == 1'b1 ? RIGHT : LEFT)));
            RIGHT : next_state = (ground == 1'b0 ? FALL_R : (dig == 1'b1 ? DIG_R : (bump_right == 1'b1 ? LEFT : RIGHT)));
            FALL_L: next_state = (ground == 1'b0 ? FALL_L : LEFT);
            FALL_R: next_state = (ground == 1'b0 ? FALL_R : RIGHT);
            DIG_L : next_state = (ground == 1'b0 ? FALL_L : DIG_L);
            DIG_R : next_state = (ground == 1'b0 ? FALL_R : DIG_R);
            default: state = LEFT;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        state <= (areset == 1'b1 ? LEFT : next_state);
    end
    
    assign walk_left  = (state == LEFT ? 1'b1 : 1'b0);
    assign walk_right = (state == RIGHT ? 1'b1 : 1'b0);
    assign aaah       = (state == FALL_L || state == FALL_R ? 1'b1 : 1'b0);
    assign digging    = (state == DIG_L  || state == DIG_R  ? 1'b1 : 1'b0);

endmodule

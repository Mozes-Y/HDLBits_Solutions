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
    
    parameter LEFT = 3'b000, RIGHT = 3'b001, FALL_L = 3'b010, FALL_R = 3'b011, DIG_L = 3'b100, DIG_R = 3'b101, SPLAT = 3'b110;
    reg [2:0] state, next_state;
    reg [4:0] counter;
    
    always @(*) begin
        case (state)
            LEFT  : next_state = (ground == 1'b0 ? FALL_L : (dig == 1'b1 ? DIG_L : (bump_left == 1'b1 ? RIGHT : LEFT)));
            RIGHT : next_state = (ground == 1'b0 ? FALL_R : (dig == 1'b1 ? DIG_R : (bump_right == 1'b1 ? LEFT : RIGHT)));
            FALL_L: next_state = (ground == 1'b0 ? FALL_L : (counter >= 20 ? SPLAT : LEFT));
            FALL_R: next_state = (ground == 1'b0 ? FALL_R : (counter >= 20 ? SPLAT : RIGHT));
            DIG_L : next_state = (ground == 1'b0 ? FALL_L : DIG_L);
            DIG_R : next_state = (ground == 1'b0 ? FALL_R : DIG_R);
            SPLAT : next_state = SPLAT;
            default: next_state = LEFT;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset == 1'b1) begin
            counter <= 5'b00000;
            state   <= LEFT;
        end
        else begin
            if (state == FALL_L || state == FALL_R) begin
                counter <= (counter >= 20 ? counter : counter + 5'b00001);
            end
            else begin
                counter <= 5'b00000;
            end
            state <= next_state;
        end
    end
    
    assign walk_left  = (state == LEFT ? 1'b1 : 1'b0);
    assign walk_right = (state == RIGHT ? 1'b1 : 1'b0);
    assign aaah       = (state == FALL_L || state == FALL_R ? 1'b1 : 1'b0);
    assign digging    = (state == DIG_L  || state == DIG_R ? 1'b1 : 1'b0);

endmodule

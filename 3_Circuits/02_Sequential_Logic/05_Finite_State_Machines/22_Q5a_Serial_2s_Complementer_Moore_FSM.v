module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            S0: next_state = (x == 1'b0 ? S0 : S2);
            S1: next_state = (x == 1'b0 ? S2 : S1);
            S2: next_state = (x == 1'b0 ? S2 : S1);
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        state <= (areset == 1'b1 ? S0 : next_state);
    end
    
    assign z = (state == S2 ? 1'b1 : 1'b0);

endmodule

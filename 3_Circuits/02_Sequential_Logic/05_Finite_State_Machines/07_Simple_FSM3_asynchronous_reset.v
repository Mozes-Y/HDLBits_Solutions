module top_module(
    input clk,
    input in,
    input areset,
    output out
);
    
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] next_state;
    reg [1:0] state;
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in == 1'b0 ? A : B);
            B: next_state = (in == 1'b0 ? C : B);
            C: next_state = (in == 1'b0 ? A : D);
            D: next_state = (in == 1'b0 ? C : B);
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        state <= (areset == 1'b1 ? A : next_state);
    end

    // Output logic
    assign out = (state == D ? 1'b1 : 1'b0);

endmodule

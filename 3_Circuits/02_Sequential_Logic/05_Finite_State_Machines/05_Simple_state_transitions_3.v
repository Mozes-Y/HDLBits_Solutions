module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out
);

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        case (state)
            A: next_state = (in == 1'b0 ? A : B);
            B: next_state = (in == 1'b0 ? C : B);
            C: next_state = (in == 1'b0 ? A : D);
            D: next_state = (in == 1'b0 ? C : B);
        endcase
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state == D ? 1'b1 : 1'b0);

endmodule

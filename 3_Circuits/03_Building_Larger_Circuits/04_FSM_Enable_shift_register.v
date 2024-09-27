module top_module (
    input  clk,
    input  reset,     // Synchronous reset
    output shift_ena
);

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S4;
            default: next_state = S4;
        endcase
    end

    always @(posedge clk) begin
        state <= reset ? S0 : next_state;
    end

    assign shift_ena = ~state[2];

endmodule

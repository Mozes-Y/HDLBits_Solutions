module top_module (
    input  clk,
    input  reset,          // Synchronous reset
    input  data,
    output start_shifting
);
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            S0: next_state = (data == 1'b1 ? S1 : S0);
            S1: next_state = (data == 1'b1 ? S2 : S0);
            S2: next_state = (data == 1'b0 ? S3 : S2);
            S3: next_state = (data == 1'b1 ? S4 : S0);
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        state <= reset ? S0 : next_state;
    end

    assign start_shifting = (state == S4);

endmodule

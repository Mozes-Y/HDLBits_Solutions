module top_module (
    input  clk,
    input  reset,          // Synchronous reset
    input  data,
    output shift_ena,
    output counting,
    input  done_counting,
    output done,
    input  ack
);

    parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011;
    parameter A0 = 4'b0100, A1 = 4'b0101, A2 = 4'b0110, A3 = 4'b0111;
    parameter C = 4'b1111, D = 4'b1110;
    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            S0: next_state = (data == 1'b1 ? S1 : S0);
            S1: next_state = (data == 1'b1 ? S2 : S0);
            S2: next_state = (data == 1'b0 ? S3 : S2);
            S3: next_state = (data == 1'b1 ? A0 : S0);
            A0: next_state = A1;
            A1: next_state = A2;
            A2: next_state = A3;
            A3: next_state = C;
            C: next_state = (done_counting ? D : C);
            D: next_state = (ack ? S0 : D);
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        state <= reset ? S0 : next_state;
    end

    assign shift_ena = (~state[3] & state[2]);  //when state is A
    assign counting = (state == C);
    assign done = (state == D);

endmodule

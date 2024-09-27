module top_module (
    input        clk,
    input        reset,     // Synchronous reset
    input        data,
    output [3:0] count,
    output       counting,
    output       done,
    input        ack
);

    wire shift_ena;
    wire count_ena;
    wire counter_reset = shift_ena | reset;
    wire done_counting = count_ena & ~(|count);

    control_logic control (
        .clk(clk),
        .reset(reset),
        .data(data),
        .shift_ena(shift_ena),
        .counting(counting),
        .done_counting(done_counting),
        .done(done),
        .ack(ack)
    );

    count_read read_data (
        .clk(clk),
        .shift_ena(shift_ena),
        .count_ena(count_ena),
        .data(data),
        .q(count)
    );

    counter time_counter (
        .clk  (clk),
        .reset(counter_reset),
        .carry(count_ena)
    );

endmodule


module control_logic (
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

    assign shift_ena = (~state[3] & state[2]);
    assign counting = (state == C);
    assign done = (state == D);

endmodule

module count_read (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q
);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data};
        end else if (count_ena) begin
            q <= q - 4'd1;
        end else begin
            q <= q;
        end
    end

endmodule

module counter (
    input  clk,
    input  reset,
    output carry
);

    reg  [9:0] q;
    wire [9:0] q_next;
    assign carry  = (q == 10'd999);
    assign q_next = (carry ? 10'b0 : (q + 10'd1));

    always @(posedge clk) begin
        q <= reset ? 10'b0 : q_next;
    end

endmodule


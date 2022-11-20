module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

    parameter S0 = 4'h0, S1 = 4'h1, S2 = 4'h2, S3 = 4'h3, S4 = 4'h4, S5 = 4'h5,
    S6 = 4'h6, S7 = 4'h7, S8 = 4'h8, S9 = 4'h9, S10 = 4'ha;
    
    reg [3:0] state, next_state;
    
    // Use FSM from Fsm_serial
    always @(*) begin
        case (state)
            S0: next_state = (in == 1'b0 ? S1 : S0);
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S8;
            S8: next_state = S9;
            S9: next_state = (in == 1'b1 ? S0 : S10);
            S10: next_state = (in == 1'b1 ? S0 : S10);
        endcase
    end

    always @(posedge clk) begin
        state <= (reset == 1'b1 ? S0 : next_state);
        done  <= (state == S9 && in == 1'b1 ? 1'b1 : 1'b0);
    end
    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        case (state)
            S1: out_byte[0] = in;
            S2: out_byte[1] = in;
            S3: out_byte[2] = in;
            S4: out_byte[3] = in;
            S5: out_byte[4] = in;
            S6: out_byte[5] = in;
            S7: out_byte[6] = in;
            S8: out_byte[7] = in;
        endcase
    end

endmodule

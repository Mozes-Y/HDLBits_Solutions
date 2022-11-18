module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
);

    // FSM from fsm_ps2
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state, next_state;
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = (in[3] == 1'b1 ? S1 : S0);
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = (in[3] == 1'b1 ? S1 : S0);
            default: next_state = S0;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        state <= (reset == 1'b1 ? S0 : next_state);
    end
    // Output logic
    assign done = (state == S3 ? 1'b1 : 1'b0);
    
    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        case (state)
            S0: out_bytes[23:16] = in;
            S1: out_bytes[15: 8] = in;
            S2: out_bytes[7 : 0] = in;
            S3: out_bytes[23:16] = in;
        endcase
    end
    
endmodule
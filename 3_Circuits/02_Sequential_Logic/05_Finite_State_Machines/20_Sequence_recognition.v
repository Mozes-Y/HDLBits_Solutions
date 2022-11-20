module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);
    
    parameter S0 = 4'h0, S1 = 4'h1, S2 = 4'h2, S3 = 4'h3, S4 = 4'h4, S5 = 4'h5, S6 = 4'h6, S7 = 4'h7, S8 = 4'h8, S9 = 4'h9;
    
    reg [3:0] state, next_state;
    
    always @(*) begin
        case (state)
            S0: next_state = (in == 1'b1 ? S1 : S0);
            S1: next_state = (in == 1'b1 ? S2 : S0);
            S2: next_state = (in == 1'b1 ? S3 : S0);
            S3: next_state = (in == 1'b1 ? S4 : S0);
            S4: next_state = (in == 1'b1 ? S5 : S0);
            S5: next_state = (in == 1'b1 ? S6 : S8);
            S6: next_state = (in == 1'b1 ? S7 : S9);
            S7: next_state = (in == 1'b1 ? S7 : S0);
            S8: next_state = (in == 1'b1 ? S1 : S0);
            S9: next_state = (in == 1'b1 ? S1 : S0);
        endcase
    end
    
    always @(posedge clk) begin
        state <= (reset == 1'b1 ? S0 : next_state);
    end
    
    assign disc = (state == S8 ? 1'b1 : 1'b0);
    assign flag = (state == S9 ? 1'b1 : 1'b0);
    assign err  = (state == S7 ? 1'b1 : 1'b0);

endmodule

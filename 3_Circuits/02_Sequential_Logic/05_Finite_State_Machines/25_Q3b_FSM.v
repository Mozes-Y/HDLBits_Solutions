module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] present_state, next_state;
    
    always @(*) begin
        case (present_state)
            S0: next_state = (x == 1'b0 ? S0 : S1);
            S1: next_state = (x == 1'b0 ? S1 : S4);
            S2: next_state = (x == 1'b0 ? S2 : S1);
            S3: next_state = (x == 1'b0 ? S1 : S2);
            S4: next_state = (x == 1'b0 ? S3 : S4);
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk) begin
        present_state <= (reset == 1'b1 ? S0 : next_state);
    end
    
    assign z = (present_state == S3 || present_state == S4 ? 1'b1 : 1'b0);

endmodule

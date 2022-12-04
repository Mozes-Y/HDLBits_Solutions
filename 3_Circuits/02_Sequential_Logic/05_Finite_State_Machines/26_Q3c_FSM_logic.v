module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] next_state;
    
    always @(*) begin
        case (y)
            S0: next_state = (x == 1'b0 ? S0 : S1);
            S1: next_state = (x == 1'b0 ? S1 : S4);
            S2: next_state = (x == 1'b0 ? S2 : S1);
            S3: next_state = (x == 1'b0 ? S1 : S2);
            S4: next_state = (x == 1'b0 ? S3 : S4);
            default: next_state = S0;
        endcase
    end
    
    assign z = (y == S3 || y == S4 ? 1'b1 : 1'b0);
    assign Y0 = next_state[0];

endmodule

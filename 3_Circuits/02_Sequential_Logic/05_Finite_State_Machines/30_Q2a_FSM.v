module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
    reg [2:0] state, next_state;
    
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0 ? A : B);
            B: next_state = (w == 1'b0 ? D : C);
            C: next_state = (w == 1'b0 ? D : E);
            D: next_state = (w == 1'b0 ? A : F);
            E: next_state = (w == 1'b0 ? D : E);
            F: next_state = (w == 1'b0 ? D : C);
            default: next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        state <= (reset == 1'b1 ? A : next_state);
    end
    
    assign z = (state == E || state == F ? 1'b1 : 1'b0);

endmodule

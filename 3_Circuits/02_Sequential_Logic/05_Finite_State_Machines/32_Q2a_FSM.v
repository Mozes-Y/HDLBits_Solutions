module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            A: begin
                if (r[1] == 1'b1)
                    next_state = B;
                else if (r[2] == 1'b1)
                    next_state = C;
                else if (r[3] == 1'b1)
                    next_state = D;
                else
                    next_state = A;
            end
            B: next_state = (r[1] == 1'b1 ? B : A);
            C: next_state = (r[2] == 1'b1 ? C : A);
            D: next_state = (r[3] == 1'b1 ? D : A);
            default: next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        state <= (resetn == 1'b0 ? A : next_state);
    end
    
    assign g[1] = (state == B ? 1'b1 : 1'b0);
    assign g[2] = (state == C ? 1'b1 : 1'b0);
    assign g[3] = (state == D ? 1'b1 : 1'b0);

endmodule

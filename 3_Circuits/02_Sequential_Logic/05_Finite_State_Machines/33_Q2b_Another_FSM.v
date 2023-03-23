module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
);
    
    parameter S0 = 4'h0, S1 = 4'h1, S2 = 4'h2, S3 = 4'h3,
    S4 = 4'h4, S5 = 4'h5, S6 = 4'h6, S7 = 4'h7, S8 = 4'h8;
    
    reg [3:0] state, nextstate;
    
    always @(*) begin
        case (state)
            S0: nextstate = S1;
            S1: nextstate = S2;
            S2: nextstate = (x == 1'b1 ? S3 : S2);
            S3: nextstate = (x == 1'b1 ? S3 : S4);
            S4: nextstate = (x == 1'b1 ? S5 : S2);
            S5: nextstate = (y == 1'b1 ? S7 : S6);
            S6: nextstate = (y == 1'b1 ? S7 : S8);
            S7: nextstate = S7;
            S8: nextstate = S8;
            default: nextstate = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if (resetn == 1'b0)
            state <= S0;
        else
            state <= nextstate;
    end
    
    assign f = (state == S1 ? 1'b1 : 1'b0);
    assign g = (state == S5 || state == S6 || state == S7 ? 1'b1 : 1'b0);

endmodule

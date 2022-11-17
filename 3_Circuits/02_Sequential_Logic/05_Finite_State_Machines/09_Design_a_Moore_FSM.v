module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);
    
    parameter A = 4'b0000, B = 4'b0010, C = 4'b0011, D = 4'b0110, E = 4'b0111, F = 4'b1111;
    reg  [3:0] state, next_state;
    
    always @(*) begin
        case (state)
            A: next_state = (s[3] == 1'b0 ? C : A);
            B: next_state = (s[2] == 1'b0 ? E : (s[3] == 1'b1 ? A : B));
            C: next_state = (s[2] == 1'b0 ? E : (s[3] == 1'b1 ? A : C));
            D: next_state = (s[1] == 1'b0 ? F : (s[2] == 1'b1 ? B : D));
            E: next_state = (s[1] == 1'b0 ? F : (s[2] == 1'b1 ? B : E));
            F: next_state = (s[1] == 1'b1 ? D : F);
            default: next_state = 4'b0000;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= 4'b1111;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign {fr3, fr2, fr1, dfr} = state;

endmodule
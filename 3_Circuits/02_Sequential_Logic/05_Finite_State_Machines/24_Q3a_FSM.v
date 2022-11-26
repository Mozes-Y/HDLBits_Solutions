module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    parameter A = 3'b000, B0 = 3'b001, B1 = 3'b010, B2 = 3'b011;
    reg [2:0] state, next_state;
    reg [1:0] counter;
    
    always @(*) begin
        case (state)
            A : next_state = (s == 1'b1 ? B0 : A);
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state   <= A;
            counter <= 2'b00;
            z       <= 1'b0;
        end
        else begin
            state <= next_state;
            z <= (state == B2 && (counter + (w == 1'b1 ? 2'b01 : 2'b00) == 2'b10) ? 1'b1 : 1'b0);
            if (state == B2 || state == A) begin
                counter <= 2'b00;
            end
            else begin
                counter <= counter + (w == 1'b1 ? 2'b01 : 2'b00);
            end
        end
    end

endmodule

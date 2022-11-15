module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out
);

    parameter OFF = 1'b0, ON = 1'b1; 
    reg state;

    always @(posedge clk, posedge areset) begin
        if (areset == 1'b1) begin
            state <= OFF;
        end
        else begin
            case (state)
                OFF: state <= (j == 1'b0 ? OFF : ON);
                ON : state <= (k == 1'b0 ? ON : OFF);
            endcase
        end
    end

    // Output logic
    assign out = state;

endmodule

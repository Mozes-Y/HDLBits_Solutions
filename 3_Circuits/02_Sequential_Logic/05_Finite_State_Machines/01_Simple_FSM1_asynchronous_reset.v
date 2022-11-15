module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out
);  

    reg state, next_state;
    
    assign next_state = (in == 1'b1 ? state : ~state);
    assign out = state;

    always @(posedge clk, posedge areset) begin
        state <= (areset == 1'b1 ? 1'b1 : next_state);
    end

endmodule

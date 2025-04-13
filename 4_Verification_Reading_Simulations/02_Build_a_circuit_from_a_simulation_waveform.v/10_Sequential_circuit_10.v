module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state
);
    
    always @(posedge clk) begin
        state <= (a ~^ b ? a : state);
    end
    
    assign q = (state ? a ~^ b : a ^ b);

endmodule

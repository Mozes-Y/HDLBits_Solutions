module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q
);
    
    always @(posedge clk) begin
        if (q > 4'h9 || reset == 1'b1) begin
            q <= 4'h1;
        end
        else begin
            q <= q + 4'h1;
        end
    end

endmodule

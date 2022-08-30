module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output reg q
);
    
    always @(posedge clk) begin
        q <= r ? 1'b0 : d;
    end

endmodule

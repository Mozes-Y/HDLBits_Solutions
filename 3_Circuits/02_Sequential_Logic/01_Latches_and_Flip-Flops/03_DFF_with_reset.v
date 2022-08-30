module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output reg [7:0] q
);
    
    always @(posedge clk) begin
        q <= reset ? 8'h00 : d;
    end

endmodule

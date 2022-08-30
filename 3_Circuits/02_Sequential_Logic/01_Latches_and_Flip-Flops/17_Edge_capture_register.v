module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    
    reg [31:0] last_in;
    
    always @(posedge clk) begin
        last_in <= in;
        out <= reset ? 32'h00000000 : (~in & last_in) | out;
    end

endmodule

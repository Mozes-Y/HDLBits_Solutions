module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 
    
    always @(posedge clk) begin
        q <= load == 1'b1 ? data : ({q[510:0], 1'b0} ^ q) | (~{1'b0, q[511:1]} & {q[510:0], 1'b0} & q);
    end

endmodule

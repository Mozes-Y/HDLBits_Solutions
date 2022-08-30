module top_module (
    input clk,
    input x,
    output z
);
    
    reg [2:0] q;
    assign z = ~(|q);
    
    always @(posedge clk) begin
        q[0] <= x ^ q[0];
        q[1] <= x & ~q[1];
        q[2] <= x | ~q[2];
    end

endmodule

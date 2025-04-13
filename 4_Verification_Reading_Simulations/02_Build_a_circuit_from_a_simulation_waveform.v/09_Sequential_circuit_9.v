module top_module (
    input clk,
    input a,
    output [3:0] q
);
    
    always @(posedge clk) begin
        if (a) begin
            q <= 4'd4;
        end else if (q == 4'd6) begin
            q <= 4'd0;
        end else begin
            q <= q + 4'd1;
        end
    end

endmodule

module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q
);
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 4'h0;
        end
        else begin
            if (slowena == 1'b1) begin
                q <= (q > 4'h8) ? 4'h0 : q + 4'h1;
            end
        end
    end

endmodule

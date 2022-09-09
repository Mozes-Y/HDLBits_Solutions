module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
); 
    
    always @(posedge clk, posedge areset) begin
        if (areset == 1'b1) begin
            q <= 4'h0;
        end
        else if (load == 1'b1) begin
            q <= data;
        end
        else if (ena == 1'b1) begin
            q <= q >> 1;
        end
    end

endmodule

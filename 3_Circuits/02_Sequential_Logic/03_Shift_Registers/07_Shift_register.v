module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output reg out
);
    
    reg [3:0] dff;
    
    assign out = dff[3];
    
    always @(posedge clk) begin
        if (resetn == 1'b0) begin
            dff <= 4'h0;
        end
        else begin
            dff <= {dff[2:0], in};
        end
    end

endmodule

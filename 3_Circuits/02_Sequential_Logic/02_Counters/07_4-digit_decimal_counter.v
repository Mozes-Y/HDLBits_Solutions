module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output reg [15:0] q
);
    
    assign ena[1] = q[3:0] == 4'h9 ? 1'b1 : 1'b0;
    assign ena[2] = q[7:0] == 8'h99 ? 1'b1 : 1'b0;
    assign ena[3] = q[11:0] == 12'h999 ? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 16'h0000;
        end
        else begin
            q[3:0] <= ena == 3'b000 ? q[3:0] + 4'h1 : 4'h0;
            q[7:4] <= ena == 3'b001 ? q[7:4] + 4'h1 : ena < 3'b001 ? q[7:4] : 4'h0;
            q[11:8] <= ena == 3'b011 ? q[11:8] + 4'h1 : ena < 3'b011 ? q[11:8] : 4'h0;
            q[15:12] <= (ena == 3'b111 && q[15:12] != 4'h9) ? q[15:12] + 4'h1 : ena < 3'b111 ? q[15:12] : 4'h0;
        end
    end
    
endmodule

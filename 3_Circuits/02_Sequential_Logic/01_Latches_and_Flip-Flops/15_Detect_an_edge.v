module top_module (
	input clk,
	input [7:0] in,
	output reg [7:0] pedge
);
	
    reg [7:0] in_last;	
			
	always @(posedge clk) begin
		in_last <= in;
		pedge <= in & ~in_last;
	end
	
endmodule

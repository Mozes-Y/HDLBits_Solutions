module top_module( 
    input [99:0] in,
    output reg [99:0] out
);
    
    always @(*) begin
        for (integer i = 0; i < $bits(in); i = i + 1) begin
            out [i] = in[$bits(in) - 1 - i];
        end
    end

endmodule

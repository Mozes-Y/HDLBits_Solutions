module top_module( 
    input [254:0] in,
    output reg [7:0] out
);
    
    always @(*) begin
        out = 8'b00000000;
        for (integer i = 0; i < $bits(in); i = i + 1) begin
            out = out + in[i];
        end
    end

endmodule

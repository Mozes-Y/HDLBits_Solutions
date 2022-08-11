module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min
);//

    wire [7:0] intermediate_result1, intermediate_result2;
    
    assign intermediate_result1 = a < b ? a: b;
    assign intermediate_result2 = c < d ? c: d;
    assign min = intermediate_result1 < intermediate_result2 ? intermediate_result1: intermediate_result2;

endmodule

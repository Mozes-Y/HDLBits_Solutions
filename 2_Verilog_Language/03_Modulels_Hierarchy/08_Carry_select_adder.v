module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire sel;
    wire [15:0] sum1;
    wire [15:0] sum2;
    
    add16 u1_add16 (
        .cin (0         ),
        .a   (a[15:0]   ),
        .b   (b[15:0]   ),
        .sum (sum[15:0] ),
        .cout(sel       )
    );
    add16 u2_add16 (
        .cin (0         ),
        .a   (a[31:16]  ),
        .b   (b[31:16]  ),
        .sum (sum1      ),
        .cout(          )
    );
    add16 u3_add16 (
        .cin (1         ),
        .a   (a[31:16]  ),
        .b   (b[31:16]  ),
        .sum (sum2      ),
        .cout(          )
    );
    
    always @(*) begin
        sum[31:16] =  (sel == 1'b0) ? sum1 : sum2;
    end

endmodule

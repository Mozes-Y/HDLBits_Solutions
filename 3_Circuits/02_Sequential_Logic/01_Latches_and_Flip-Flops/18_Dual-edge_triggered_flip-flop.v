module top_module (
    input clk,
    input d,
    output q
);
    
    reg Q1, Q0;
    
    assign q = clk ? Q1 : Q0;
    
    always @(posedge clk) begin
        Q1 <= d;
    end
    always @(negedge clk) begin
        Q0 <= d;
    end

endmodule

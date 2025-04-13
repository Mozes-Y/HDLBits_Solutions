module top_module (
    input clock,
    input a,
    output p,
    output q
);
    reg temp;
    assign p  = (clock ? a : temp);
    always @(negedge clock) begin
        temp <= a;
        q <= p;
    end
    

endmodule

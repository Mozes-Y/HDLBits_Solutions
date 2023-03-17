module top_module();
    reg in, clk;
    reg [2:0] s;
    wire out;
    
    q7 dut (.clk(clk), .in(in), .s(s), .out(out));
    
    initial begin
        clk = 1'b0;
        in  = 1'b0;
        s   = 3'h2;
        #10;
        s = 3'h6;
        #10;
        s = 3'h2;
        in = 1'b1;
        #10;
        s = 3'h7;
        in = 1'b0;
        #10;
        s = 3'h0;
        in = 1'b1;
        #30;
        s = 3'h0;
        in = 1'b0;
    end
    
    always begin
        #5;
        clk = ~clk;
    end

endmodule
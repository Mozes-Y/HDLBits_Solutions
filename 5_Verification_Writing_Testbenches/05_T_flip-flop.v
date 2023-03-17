module top_module ();
    reg clk, reset, t;
    wire q;
    
    tff dut (.clk(clk), .reset(reset), .t(t), .q(q));
    
    initial begin
        clk   = 1'b0;
        reset = 1'b1;
        t     = 1'b1;
        #15;
        reset = 1'b0;
    end
    
    always begin
        #10;
        clk = ~clk;
    end

endmodule

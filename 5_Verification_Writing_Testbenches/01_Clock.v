module top_module ( );

    parameter delay = 5;
    reg clk;
    
    dut test(.clk(clk));
    
    initial begin
        clk = 1'b0;
    end
    
    always begin
        #delay;
        clk = ~clk;
    end
    
endmodule
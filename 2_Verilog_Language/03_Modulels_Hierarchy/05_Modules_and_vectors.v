module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    
    wire [7:0] bus1;
    wire [7:0] bus2;
    wire [7:0] bus3;
    
    my_dff8 dff1 ( .clk(clk), .d(d),    .q(bus1) );
    my_dff8 dff2 ( .clk(clk), .d(bus1), .q(bus2) );
    my_dff8 dff3 ( .clk(clk), .d(bus2), .q(bus3) );
    
    always @(*) begin
        case(sel)
            2'b00: q = d;
            2'b01: q = bus1;
            2'b10: q = bus2;
            2'b11: q = bus3;
        endcase
    end

endmodule

module top_module (
    input in1,
    input in2,
    input in3,
    output out
);
    
    wire xnor_in12;
    
    assign xnor_in12 = in1 ~^ in2;
    assign out  = xnor_in12 ^ in3;

endmodule

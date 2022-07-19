module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire mid1_abc;
    wire mid1_def;
    wire mid2_ab;
    wire mid2_cd;
    
    assign mid1_abc = p1a & p1b & p1c;
    assign mid1_def = p1d & p1e & p1f;
    assign mid2_ab = p2a & p2b;
    assign mid2_cd = p2c & p2d;
    assign p1y = mid1_abc | mid1_def;
    assign p2y = mid2_ab | mid2_cd;

endmodule

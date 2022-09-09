module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output reg [3:0] LEDR
);
    
    MUXDFF my_mux_dff [3:0] (
        .clk({4{KEY[0]}}),
        .w({KEY[3], LEDR[3:1]}),
        .R(SW[3:0]),
        .E({4{KEY[1]}}),
        .L({4{KEY[2]}}),
        .Q(LEDR[3:0])
    );

endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output reg Q
);
    
    always @(posedge clk) begin
        Q <= L ? R : (E ? w : Q);
    end

endmodule

module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
); 
    
    wire [2:0] carry;
    assign carry[0] = ss[3:0] == 4'h9 && ss[7:4] == 4'h5 ? 1'b1 : 1'b0;
    assign carry[1] = carry[0] == 1'b1 && mm[3:0] == 4'h9 && mm[7:4] == 4'h5 ? 1'b1 : 1'b0;
    assign carry[2] = carry[1] == 1'b1 && hh[3:0] == 4'h2 && hh[7:4] == 4'h1 ? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            pm <= 1'b0;
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
        end
        else begin
            if (ena == 1'b1) begin
                ss[3:0] <= ss[3:0] == 4'h9 ? 4'h0 : ss[3:0] + 4'h1;
                ss[7:4] <= carry[0] == 1'b1 ? 4'h0 : ss[3:0] == 4'h9 ? ss[7:4] + 4'h1 : ss[7:4];
                mm[3:0] <= carry[0] == 1'b1 ? mm[3:0] == 4'h9 ? 4'h0 : mm[3:0] + 4'h1 : mm[3:0];
                mm[7:4] <= carry[0] == 1'b1 ? carry[1] == 1'b1 ? 4'h0 : mm[3:0] == 4'h9 ? mm[7:4] + 4'h1 : mm[7:4] : mm[7:4];
                hh[3:0] <= carry[1] == 1'b1 ? hh[3:0] == 4'h9 ? 4'h0 : carry[2] == 1'b1 ? 4'h1 : hh[3:0] + 4'h1 : hh[3:0];
                hh[7:4] <= carry[1] == 1'b1 ? carry[2] == 1'b1 ? 4'h0 : hh[3:0] == 4'h9 ? hh[7:4] + 4'h1 : hh[7:4] : hh[7:4];
                pm <= carry[1] == 1'b1 && hh[3:0] == 4'h1 && hh[7:4] == 4'h1 ? ~pm : pm;
            end
        end
    end

endmodule

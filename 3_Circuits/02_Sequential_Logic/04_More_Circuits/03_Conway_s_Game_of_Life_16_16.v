module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
);
    
    always @(posedge clk) begin
        if (load == 1'b1) begin
            q <= data;
        end
        else begin
            for (integer i = 0; i < 256; i = i + 1) begin
                case (q[(i+1)%256] + q[(i+255)%256] + q[(i+240)%256] + q[(i+16)%256] + q[(i+241)%256] + q[(i+15)%256] 
                    + q[(i+((i % 16 == 0) ? 31 : 239))%256] + q[(i+((i % 16 == 15) ? 225 : 17))%256])
                    4'd2: q[i] <= q[i];
                    4'd3: q[i] <= 1'b1;
                    default: q[i] <= 1'b0;
                endcase
            end
        end
    end

endmodule
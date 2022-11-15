// Note the Verilog-1995 module declaration syntax here:
module top_module(
    input clk,
    input reset,    // Synchronous reset to state B
    input in,
    output out
);
    
    parameter A = 1'b0, B = 1'b1;
    reg present_state;
    assign out = present_state;

    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
            present_state <= B;
        end
        else begin
            case (present_state)
                // Fill in state transition logic
                A: present_state <= (in == 1'b1 ? A : B);
                B: present_state <= (in == 1'b1 ? B : A);
            endcase
        end
    end

endmodule

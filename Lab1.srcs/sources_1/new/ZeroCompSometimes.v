`timescale 1ns / 1ps
// sel = 0 Movz
// sel = 1 Movn
module ZeroCompSometimes(in, out, sel);
    
    input [31:0] in;
    input sel;
    output reg out;
    
    always@(in, sel) begin
        if ( (sel == 0 && in == 32'b0) || (sel == 1 && in != 32'b0) )
            out <= 1;
        else
            out <= 0;
    end

endmodule

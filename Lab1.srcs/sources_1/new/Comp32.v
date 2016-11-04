`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Comp32.v
// Description - 32 Bit Comparator.
////////////////////////////////////////////////////////////////////////////////

module Comp32(in1, in2, out);
    input [31:0] in1, in2;
    output reg out;
    
    always@(in1, in2) begin
        if(in1 == in2)
            out <= 1;
        else
            out <= 0;
    end
endmodule

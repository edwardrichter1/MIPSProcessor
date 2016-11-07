`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit3To1.v
// Description - Performs signal multiplexing between 3 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB, inC, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0] sel;

    always@(inA, inB, sel) begin
        if(sel == 2'b0)
            out <= inA;
        else if(sel == 2'b1)
            out <= inB;
        else if(sel == 2'b2)
            out <= inC;
    end 

endmodule

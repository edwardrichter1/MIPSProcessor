`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out, ForceZero, Shift16);

    /* A 16-Bit input word */
    input [15:0] in;
    input Shift16;
    input ForceZero;
    
    /* A 32-Bit output word */
    output[31:0] out;
    
    reg [31:0] out;
    
    always@(in, ForceZero, Shift16) begin
        if (Shift16)
            out = {in, 16'b0};
        else if (in[15] == 0 || ForceZero)
            out = {16'b0, in};
        else
            out = {16'd65535, in};
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2016 10:29:25 PM
// Design Name: 
// Module Name: GetCoordinates
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GetCoordinates(
        xDim,
        yDim,
        ZeroZero,
        OneZero,
        TwoZero,
        ThreeZero,
        ZeroOne,
        OneOne, 
        TwoOne, 
        ThreeOne,
        UpperOrLower
    );
    
    input [31:0] xDim, yDim;
    input UpperOrLower;
    output reg [12:0] ZeroZero, OneZero, TwoZero, ThreeZero,
    ZeroOne, OneOne, TwoOne, ThreeOne;
    
    always@(xDim, yDim, UpperOrLower) begin
        if(UpperOrLower) begin // upper part of the frame
            ZeroZero <= (yDim) * 64 + xDim + 4;
            OneZero <= (yDim) * 64 + xDim + 5;
            TwoZero <= (yDim) * 64 + xDim + 6;
            ThreeZero <= (yDim) * 64+ xDim + 7;
            ZeroOne <= (yDim + 1) * 64 + xDim + 4;
            OneOne <= (yDim + 1) * 64 + xDim + 5;
            TwoOne <= (yDim + 1) * 64 + xDim + 6;
            ThreeOne <= (yDim + 1) * 64 + xDim + 7;
        end
        else begin // lower part of the frame
            ZeroZero <= (yDim + 2) * 64 + xDim + 4;
            OneZero <= (yDim + 2) * 64 + xDim + 5;
            TwoZero <= (yDim + 2) * 64 + xDim + 6;
            ThreeZero <= (yDim + 2) * 64 + xDim + 7;
            ZeroOne <= (yDim + 3) * 64 + xDim + 4;
            OneOne <= (yDim + 3) * 64 + xDim + 5;
            TwoOne <= (yDim + 3) * 64 + xDim + 6;
            ThreeOne <= (yDim + 3) * 64 + xDim + 7;
        end
    end
    
endmodule

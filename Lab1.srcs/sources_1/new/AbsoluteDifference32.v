`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2016 02:14:50 PM
// Design Name: 
// Module Name: AbsoluteDifference32
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


module AbsoluteDifference32(
        inA,
        inB,
        inC,
        TopOrBottom,
        outC
    );
    
    input [31:0] inA, inB, inC;
    input TopOrBottom;
    output [31:0] outC;
    
    reg [31:0] tempDifference, outC;
    
    
    always@(inA, inB, TopOrBottom) begin         
        if(inA[31] == 1)
            outC <= -inA;
        else
            outC <= inA;               
       /*
        if(tempDifference[31] == 1) 
            outC <= ~tempDifference + 1; // 2's compliment to make positive
        else
            outC <= tempDifference;*/
    end
endmodule

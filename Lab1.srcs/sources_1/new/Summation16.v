`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2016 02:21:59 PM
// Design Name: 
// Module Name: Summation16
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


module Summation16(
        inA,
        inB,
        inC,
        inD,
        inE,
        inF,
        inG,
        inH,
        inI,
        inJ,
        inK,
        inL,
        inM,
        inN,
        inO,
        inP,
        out
    );
    input [31:0] inA, inB, inC, inD, inE, inF, inG, inH, inI, inJ, inK, inL, inM, inN, inO, inP;
    output [31:0] out;
    
    always@(inA, inB, inC, inD, inE, inF, inG, inH, inI, inJ, inK, inL, inM, inN, inO, inP) begin
        out <= inA + inB + inC + inD + inE + inF + inG + inH + inI + inJ + inK + inL + inM + inN + inO + inP;
    end
    
endmodule

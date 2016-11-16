`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2016 10:26:23 PM
// Design Name: 
// Module Name: Mux32Bit7To1
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


module Mux32Bit7To1(
        inA, 
        inB, 
        inC, 
        inD, 
        inE, 
        inF, 
        inG, 
        sel, 
        out
    );
    
    output reg [31:0] out;
    
    input [31:0] inA, inB, inC, inD, inE, inF, inG;
    input [2:0] sel;

    always@(*) begin
        if(sel == 3'd0)
            out <= inA;
        else if(sel == 3'd1)
            out <= inB;
        else if(sel == 3'd2)
            out <= inC;
        else if(sel == 3'd3)
            out <= inD;
        else if(sel == 3'd4)
            out <= inE;
        else if(sel == 3'd5)
            out <= inF;
        else if(sel == 3'd6)
            out <= inG;
    end 
    
endmodule

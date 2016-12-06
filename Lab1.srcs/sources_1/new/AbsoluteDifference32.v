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
    
    (* mark_debug = "true" *) input [31:0] inA, inB, inC;
    input TopOrBottom;
    output [31:0] outC;
    
    reg [31:0] outC;
    
    
    always@(inA, inB, inC, TopOrBottom) begin         
        if(TopOrBottom) begin
            outC <= inA > inB ? inA - inB : inB - inA;
            /*if((~(inA > inB)))
                outC <= inA - inB;
            else
                outC <= inB - inA;*/
        end
        else begin
            outC <= inA > inC ? inA - inC : inC - inA;
            /*if((~(inA > inC)))
                outC <= inA - inC;
            else
                outC <= inC - inA;*/        
        end
        
    end
endmodule

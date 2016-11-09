`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2016 04:01:08 PM
// Design Name: 
// Module Name: Pipe1Reg
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


module Pipe1Reg(
        Clk, 
        WriteEnable, 
        ReadEnable, 
        InstructionIn, 
        InstructionOut, 
        PCAddResultIn, 
        PCAddResultOut
    );
    input Clk, WriteEnable, ReadEnable;
    input [31:0] InstructionIn, PCAddResultIn;
    
    output reg [31:0] PCAddResultOut, InstructionOut;
    
    reg [31:0] PCAddResultTemp, InstructionTemp;
    always@(negedge Clk) begin
        if(ReadEnable == 1) begin
            InstructionOut <= InstructionTemp;
            PCAddResultOut <= PCAddResultTemp;
        end
    end
    
    always@(posedge Clk) begin
        if(WriteEnable == 1) begin
            InstructionTemp <= InstructionIn;
            PCAddResultTemp <= PCAddResultIn;
        end
    end
    
endmodule

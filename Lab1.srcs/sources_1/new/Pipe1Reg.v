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
        Reset, 
        WriteEnable,
        InstructionIn, 
        InstructionOut, 
        PCAddResultIn, 
        PCAddResultOut
    );
    input Clk, WriteEnable, Reset;
    input [31:0] InstructionIn, PCAddResultIn;
    
    output reg [31:0] PCAddResultOut, InstructionOut;
    
    always@(negedge Clk) begin
        if(Reset == 1) begin
            InstructionOut <= 32'd0;
            PCAddResultOut <= 32'd0;
        end
        else if(WriteEnable == 1) begin
            InstructionOut <= InstructionIn;
            PCAddResultOut <= PCAddResultIn;
        end
    end
    
endmodule

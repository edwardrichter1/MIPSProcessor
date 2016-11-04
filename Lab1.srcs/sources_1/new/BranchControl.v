`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2016 04:31:46 PM
// Design Name: 
// Module Name: BranchControl
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


module BranchControl(Zero, BranchControlIn, BranchControlOut, ComparePort);
    input [31:0] ComparePort;
    input [2:0] BranchControlIn;
    input Zero;
    
    output reg BranchControlOut;
    
    always@(ComparePort, Zero, BranchControlIn) begin
        case(BranchControlIn)
            3'b000: BranchControlOut <= 1'b0;  // not a branch instruction
            3'b001: BranchControlOut <= Zero;  // beq
            3'b010: BranchControlOut <= ~Zero; // bne
            3'b011: BranchControlOut <= ~ComparePort[31]; // bgez
            3'b100: BranchControlOut <= ~ComparePort[31] & ~Zero; // bgtz
            3'b101: BranchControlOut <= ComparePort[31]; // blez and bltz
        endcase
    end
endmodule

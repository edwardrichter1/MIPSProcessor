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


module BranchControl(ReadData2, Equal, BranchControlIn, BranchControlOut);
    input [31:0] ReadData2;
    input [2:0] BranchControlIn;
    input Equal;
    
    output reg BranchControlOut;
    
    always@(Equal, ReadData2, BranchControlIn) begin
        case(BranchControlIn)
            3'b000: BranchControlOut <= 1'b0;  // not a branch instruction
            3'b001: BranchControlOut <= Equal;  // beq
            3'b010: BranchControlOut <= ~Equal; // bne
            3'b011: BranchControlOut <= ~ReadData2[31]; // bgez
            3'b100: BranchControlOut <= ~ReadData2[31] & ~Equal; // bgtz
            3'b101: BranchControlOut <= ReadData2[31] | Equal; // blez
            3'b110: BranchControlOut <= ReadData2[31]; // bltz
            default: BranchControlOut <= 0;
        endcase
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2016 01:12:13 PM
// Design Name: 
// Module Name: MemoryUnit
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


module MemoryUnit(
        Clk, // inputs 
        Address,
        WriteData,
        MemWrite,
        MemReadOut,
        DataMemOut,
        ReadData // outputs
    );
    
    input Clk, MemWrite, MemReadOut;
    input [31:0] Address, WriteData;
    input [1:0] DataMemOut;
    
    output [31:0] ReadData;
    
    DataMemory DM1(
         .Address(Address),
         .WriteData(WriteData),
         .Clk(Clk),
         .MemWrite(MemWrite),
         .MemRead(MemReadOut),
         .ReadData(ReadData),
         .DataMem(DataMemOut)
     );

endmodule

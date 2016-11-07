`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2016 01:25:56 PM
// Design Name: 
// Module Name: Pipe4Reg
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


module Pipe4Reg(
        Clk, // inputs 
        PCAddResultIn, 
        HiIn,
        LoIn,
        ALUResultIn,
        MemWriteDataIn, //whats this for
        WriteRegisterIn,
        ReadData1In,
        ReadData2In,
        SignExtendRegisterIn,
        RegWriteIn,
        MemtoRegIn,
        SignExtendToRegIn,
        MovIn, 
        CmpSelIn,
        MoveHiIn,
        MoveLoIn,
        JumpLinkIn,
        PCAddResultOut, // outputs 
        HiOut,
        LoOut,
        ALUResultOut,
        MemWriteDataOut,
        WriteRegisterOut,
        ReadData1Out,
        ReadData2Out,
        SignExtendRegisterOut,
        RegWriteOut,
        MemtoRegOut,
        SignExtendToRegOut,
        MovOut, 
        CmpSelOut,
        MoveHiOut,
        MoveLoOut,
        JumpLinkOut
    );
    input Clk, RegWriteIn, MemtoRegIn, SignExtendToRegIn, MovIn, CmpSelIn, MoveHiIn, MoveLoIn, JumpLinkIn;
    input [31:0] PCAddResultIn, HiIn, LoIn, ALUResultIn, MemWriteDataIn, ReadData1In, ReadData2In, SignExtendRegisterIn;
    input [4:0] WriteRegisterIn;
    
endmodule

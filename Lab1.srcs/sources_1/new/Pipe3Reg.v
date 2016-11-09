`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2016 01:24:44 PM
// Design Name: 
// Module Name: Pipe3Reg
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


module Pipe3Reg(
        Clk, // inputs 
        PCAddResultIn,
        HiIn,
        LoIn,
        ALUResultIn,
        MemWriteDataIn,
        WriteRegisterIn,
        ReadData1In,
        ReadData2In,
        SignExtendRegisterIn,
        RegWriteIn,
        MemWriteIn,
        MemReadIn,
        MemtoRegIn,
        SignExtendToRegIn,
        MovIn, 
        CmpSelIn,
        MoveHiIn,
        MoveLoIn,
        DataMemIn,
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
        MemWriteOut,
        MemReadOut,
        MemtoRegOut,
        SignExtendToRegOut,
        MovOut, 
        CmpSelOut,
        MoveHiOut,
        MoveLoOut,
        DataMemOut,
        JumpLinkOut
    );
    
    input Clk, RegWriteIn, MemWriteIn, MemReadIn, MemtoRegIn,
    SignExtendToRegIn, MovIn, CmpSelIn, MoveHiIn, MoveLoIn, JumpLinkIn;
    input [31:0] PCAddResultIn, HiIn, LoIn, ALUResultIn, MemWriteDataIn, 
    ReadData1In, ReadData2In, SignExtendRegisterIn;
    input [4:0] WriteRegisterIn;
    input [1:0] DataMemIn;
    
    output reg RegWriteOut, MemWriteOut, MemReadOut, MemtoRegOut,
    SignExtendToRegOut, MovOut, CmpSelOut, MoveHiOut, MoveLoOut, JumpLinkOut;
    output reg [31:0] PCAddResultOut, HiOut, LoOut, ALUResultOut, MemWriteDataOut, 
    ReadData1Out, ReadData2Out, SignExtendRegisterOut;
    output reg [4:0] WriteRegisterOut;
    output reg [1:0] DataMemOut;
    
    reg RegWriteTemp, MemWriteTemp, MemReadTemp, MemtoRegTemp,
    SignExtendToRegTemp, MovTemp, CmpSelTemp, MoveHiTemp, MoveLoTemp, JumpLinkTemp;
    reg [31:0] PCAddResultTemp, HiTemp, LoTemp, ALUResultTemp, MemWriteDataTemp, 
    ReadData1Temp, ReadData2Temp, SignExtendRegisterTemp;
    reg [4:0] WriteRegisterTemp;
    reg [1:0] DataMemTemp;

    always@(negedge Clk) begin
        PCAddResultOut <= PCAddResultTemp;
        HiOut <= HiTemp;
        LoOut <= LoTemp;
        ALUResultOut <= ALUResultTemp;
        MemWriteDataOut <= MemWriteDataTemp;
        WriteRegisterOut <= WriteRegisterTemp;
        ReadData1Out <= ReadData1Temp;
        ReadData2Out <= ReadData2Temp;
        SignExtendRegisterOut <= SignExtendRegisterTemp;
        RegWriteOut <= RegWriteTemp;
        MemWriteOut <= MemWriteTemp;
        MemReadOut <= MemReadTemp;
        MemtoRegOut <= MemtoRegTemp;
        SignExtendToRegOut <= SignExtendToRegTemp;
        MovOut <= MovTemp;
        CmpSelOut <= CmpSelTemp;
        MoveHiOut <= MoveHiTemp;
        MoveLoOut <= MoveLoTemp;
        DataMemOut <= DataMemTemp;
        JumpLinkOut <= JumpLinkTemp;
    end
    
    always@(posedge Clk) begin
        PCAddResultTemp <= PCAddResultIn;
        HiTemp <= HiIn;
        LoTemp <= LoIn;
        ALUResultTemp <= ALUResultIn;
        MemWriteDataTemp <= MemWriteDataIn;
        WriteRegisterTemp <= WriteRegisterIn;
        ReadData1Temp <= ReadData1In;
        ReadData2Temp <= ReadData2In;
        SignExtendRegisterTemp <= SignExtendRegisterIn;
        RegWriteTemp <= RegWriteIn;
        MemWriteTemp <= MemWriteIn;
        MemReadTemp <= MemReadIn;
        MemtoRegTemp <= MemtoRegIn;
        SignExtendToRegTemp <= SignExtendToRegIn;
        MovTemp <= MovIn;
        CmpSelTemp <= CmpSelIn;
        MoveHiTemp <= MoveHiIn;
        MoveLoTemp <= MoveLoIn;
        DataMemTemp <= DataMemIn;
        JumpLinkTemp <= JumpLinkIn;
    end
    
    
    
    
    
endmodule

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
        MemWriteDataIn,
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
        DataMemReadIn,
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
        JumpLinkOut,
        DataMemReadOut
    );
    
    input Clk, RegWriteIn, MemtoRegIn, SignExtendToRegIn, MovIn,
    CmpSelIn, MoveHiIn, MoveLoIn, JumpLinkIn;
    input [31:0] PCAddResultIn, HiIn, LoIn, ALUResultIn, MemWriteDataIn,
    ReadData1In, ReadData2In, SignExtendRegisterIn, DataMemReadIn;
    input [4:0] WriteRegisterIn;
    
    output reg RegWriteOut, MemtoRegOut, SignExtendToRegOut, MovOut,
    CmpSelOut, MoveHiOut, MoveLoOut, JumpLinkOut;
    output reg [31:0] PCAddResultOut, HiOut, LoOut, ALUResultOut, MemWriteDataOut,
    ReadData1Out, ReadData2Out, SignExtendRegisterOut, DataMemReadOut;
    output reg [4:0] WriteRegisterOut;

    reg RegWriteTemp, MemtoRegTemp, SignExtendToRegTemp, MovTemp,
    CmpSelTemp, MoveHiTemp, MoveLoTemp, JumpLinkTemp;
    reg [31:0] PCAddResultTemp, HiTemp, LoTemp, ALUResultTemp, MemWriteDataTemp,
    ReadData1Temp, ReadData2Temp, SignExtendRegisterTemp, DataMemReadTemp;
    reg [4:0] WriteRegisterTemp;
    
    always@(posedge Clk) begin
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
        MemtoRegOut <= MemtoRegTemp;
        SignExtendToRegOut <= SignExtendToRegTemp;
        MovOut <= MovTemp;
        CmpSelOut <= CmpSelTemp;
        MoveHiOut <= MoveHiTemp;
        MoveLoOut <= MoveLoTemp;
        JumpLinkOut <= JumpLinkTemp;
        DataMemReadOut <= DataMemReadTemp;
    end

    always@(negedge Clk) begin
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
        MemtoRegTemp <= MemtoRegIn;
        SignExtendToRegTemp <= SignExtendToRegIn;
        MovTemp <= MovIn;
        CmpSelTemp <= CmpSelIn;
        MoveHiTemp <= MoveHiIn;
        MoveLoTemp <= MoveLoIn;
        JumpLinkTemp <= JumpLinkIn;
        DataMemReadTemp <= DataMemReadIn;
    end



endmodule
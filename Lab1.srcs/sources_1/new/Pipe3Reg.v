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
        Reset,
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
    SignExtendToRegIn, MovIn, CmpSelIn, MoveHiIn, MoveLoIn, JumpLinkIn, Reset;
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
    
    
    always@(negedge Clk) begin
        if(Reset == 1) begin
            PCAddResultOut <= 0;
            HiOut <= 0;
            LoOut <= 0;
            ALUResultOut <= 0;
            MemWriteDataOut <= 0;
            WriteRegisterOut <= 0;
            ReadData1Out <= 0;
            ReadData2Out <= 0;
            SignExtendRegisterOut <= 0;
            RegWriteOut <= 0;
            MemWriteOut <= 0;
            MemReadOut <= 0;
            MemtoRegOut <= 0;
            SignExtendToRegOut <= 0;
            MovOut <= 0;
            CmpSelOut <= 0;
            MoveHiOut <= 0;
            MoveLoOut <= 0;
            DataMemOut <= 0;
            JumpLinkOut <= 0;
        end
        else begin
            PCAddResultOut <= PCAddResultIn;
            HiOut <= HiIn;
            LoOut <= LoIn;
            ALUResultOut <= ALUResultIn;
            MemWriteDataOut <= MemWriteDataIn;
            WriteRegisterOut <= WriteRegisterIn;
            ReadData1Out <= ReadData1In;
            ReadData2Out <= ReadData2In;
            SignExtendRegisterOut <= SignExtendRegisterIn;
            RegWriteOut <= RegWriteIn;
            MemWriteOut <= MemWriteIn;
            MemReadOut <= MemReadIn;
            MemtoRegOut <= MemtoRegIn;
            SignExtendToRegOut <= SignExtendToRegIn;
            MovOut <= MovIn;
            CmpSelOut <= CmpSelIn;
            MoveHiOut <= MoveHiIn;
            MoveLoOut <= MoveLoIn;
            DataMemOut <= DataMemIn;
            JumpLinkOut <= JumpLinkIn;
        end
    end
endmodule

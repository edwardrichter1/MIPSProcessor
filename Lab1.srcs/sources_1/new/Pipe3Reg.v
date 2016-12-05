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
        DataMemIn,
        JumpLinkIn,
        SADWriteIn,
        UpperOrLowerIn,
        ZeroZeroIn, 
        OneZeroIn, 
        TwoZeroIn, 
        ThreeZeroIn,
        ZeroOneIn, 
        OneOneIn, 
        TwoOneIn, 
        ThreeOneIn,
        PCAddResultOut, // outputs
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
        DataMemOut,
        JumpLinkOut,
        SADWriteOut,
        UpperOrLowerOut,
        ZeroZeroOut, 
        OneZeroOut, 
        TwoZeroOut, 
        ThreeZeroOut,
        ZeroOneOut, 
        OneOneOut, 
        TwoOneOut, 
        ThreeOneOut,
    );
    
    input Clk, RegWriteIn, MemWriteIn, MemReadIn, MemtoRegIn,
    SignExtendToRegIn, MovIn, CmpSelIn,JumpLinkIn, Reset, 
    SADWriteIn, UpperOrLowerIn;
    input [31:0] PCAddResultIn,ALUResultIn, MemWriteDataIn, 
    ReadData1In, ReadData2In, SignExtendRegisterIn;
    input [4:0] WriteRegisterIn;
    input [1:0] DataMemIn;
    input [12:0] ZeroZeroIn, OneZeroIn, TwoZeroIn, ThreeZeroIn,
    ZeroOneIn, OneOneIn, TwoOneIn, ThreeOneIn;
    
    output reg RegWriteOut, MemWriteOut, MemReadOut, MemtoRegOut,
    SignExtendToRegOut, MovOut, CmpSelOut, JumpLinkOut, 
    SADWriteOut, UpperOrLowerOut;
    output reg [31:0] PCAddResultOut, ALUResultOut, MemWriteDataOut, 
    ReadData1Out, ReadData2Out, SignExtendRegisterOut;
    output reg [4:0] WriteRegisterOut;
    output reg [1:0] DataMemOut;
    output reg [12:0] ZeroZeroOut, OneZeroOut, TwoZeroOut, ThreeZeroOut,
    ZeroOneOut, OneOneOut, TwoOneOut, ThreeOneOut;
    
    
    always@(negedge Clk) begin
        if(Reset == 1) begin
            PCAddResultOut <= 0;
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
            DataMemOut <= 0;
            JumpLinkOut <= 0;
            SADWriteOut <= 0;
            UpperOrLowerOut <= 0;
            ZeroZeroOut <= 0;
            OneZeroOut <= 0;
            TwoZeroOut <= 0;
            ThreeZeroOut <= 0;
            ZeroOneOut <= 0;
            OneOneOut <= 0;
            TwoOneOut <= 0;
            ThreeOneOut <= 0;
        end
        else begin
            PCAddResultOut <= PCAddResultIn;
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
            DataMemOut <= DataMemIn;
            JumpLinkOut <= JumpLinkIn;
            SADWriteOut <= SADWriteIn;
            UpperOrLowerOut <= UpperOrLowerIn;
            ZeroZeroOut <= ZeroZeroIn;
            OneZeroOut <= OneZeroIn;
            TwoZeroOut <= TwoZeroIn;
            ThreeZeroOut <= ThreeZeroIn;
            ZeroOneOut <= ZeroOneIn;
            OneOneOut <= OneOneIn;
            TwoOneOut <= TwoOneIn;
            ThreeOneOut <= ThreeOneIn;
        end
    end
endmodule

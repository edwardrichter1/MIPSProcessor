`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2016 01:13:08 PM
// Design Name: 
// Module Name: WriteBackUnit
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


module WriteBackUnit(
        PCAddResult, // inputs
        Hi,
        Lo,
        ALUResult,
        DataMemRead,
        WriteRegister,
        ReadData1,
        ReadData2,
        SignExtendRegisterOut,
        RegWriteOut,
        MemtoRegOut,
        SignExtendToRegOut,
        MovOut, 
        CmpSelOut,
        MoveHiOut,
        MoveLoOut,
        JumpLinkOut,
        WriteData, // outputs
        CmpOut
    );
    input [31:0] PCAddResult, Hi, Lo, ALUResult, DataMemRead, ReadData1,
    ReadData2, SignExtendRegisterOut;
    input RegWriteOut, MemtoRegOut, SignExtendToRegOut, MovOut,
    CmpSelOut, MoveHiOut, MoveLoOut, JumpLinkOut;
    input [4:0] WriteRegister; // don't think this is necessary
    
    output [31:0] WriteData;
    output CmpOut;
    
    wire [31:0] ReadDataMuxOutput, SignExtendMuxOutput, MovMuxOutput,
    HiMuxOutput, LoMuxOutput; 
    
    ZeroCompSometimes ZCS(
        .in(ReadData2), 
        .out(CmpOut),
        .sel(CmpSelOut)
    );
    Mux32Bit2To1 ReadDataMux(
        .out(ReadDataMuxOutput),
        .inA(ALUResult),
        .inB(DataMemRead),
        .sel(MemtoRegOut)
    );
    Mux32Bit2To1 SignExtendMux(
        .out(SignExtendMuxOutput),
        .inA(ReadDataMuxOutput),
        .inB(SignExtendRegisterOut),
        .sel(SignExtendToRegOut)
    );
    Mux32Bit2To1 MovMux(
        .out(MovMuxOutput),
        .inA(SignExtendMuxOutput),
        .inB(ReadData1),
        .sel(MovOut)
    );
    Mux32Bit2To1 HiMux(
        .out(HiMuxOutput),
        .inA(MovMuxOutput),
        .inB(Hi),
        .sel(MoveHiOut)
    );
    Mux32Bit2To1 LoMux(
        .out(LoMuxOutput),
        .inA(HiMuxOutput),
        .inB(Lo),
        .sel(MoveLoOut)
    );
    Mux32Bit2To1 JumpLinkMux(
        .out(WriteData),
        .inA(LoMuxOutput),
        .inB(DataMemRead),
        .sel(JumpLinkOut)
    );
endmodule
 
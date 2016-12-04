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
        ALUResult,
        DataMemRead,
        ReadData1,
        ReadData2,
        SignExtendRegisterOut,
        MemtoRegOut,
        SignExtendToRegOut,
        MovOut, 
        CmpSelOut,
        JumpLinkOut,
        SAD,
        SADWrite,
        WriteData, // outputs
        CmpOut
    );
    input [31:0] PCAddResult, ALUResult, DataMemRead, ReadData1,
    ReadData2, SignExtendRegisterOut, SAD;
    input MemtoRegOut, SignExtendToRegOut, MovOut,
    CmpSelOut, JumpLinkOut, SADWrite;
    
    output [31:0] WriteData;
    output CmpOut;
    
    wire [31:0] ReadDataMuxOutput, SignExtendMuxOutput, MovMuxOutput, JumpLinkMuxOutput; 
    
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
    Mux32Bit2To1 JumpLinkMux(
        .out(JumpLinkMuxOutput),
        .inA(MovMuxOutput),
        .inB(PCAddResult),
        .sel(JumpLinkOut)
    );
    Mux32Bit2To1 SADMux(
        .out(WriteData),
        .inA(JumpLinkMuxOutput),
        .inB(SAD),
        .sel(SADWrite)
    );
endmodule
 
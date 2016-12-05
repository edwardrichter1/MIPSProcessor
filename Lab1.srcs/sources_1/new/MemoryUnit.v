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
        WBWriteData,
        WBSel,
        ZeroZero,
        OneZero,
        TwoZero,
        ThreeZero,
        ZeroOne,
        OneOne, 
        TwoOne, 
        ThreeOne,
        UpperOrLower,
        ReadData, // outputs
        SAD
    );
    
    input Clk, MemWrite, MemReadOut, WBSel, UpperOrLower;
    input [31:0] Address, WriteData, WBWriteData;
    input [12:0] ZeroZero, OneZero, TwoZero, ThreeZero, ZeroOne,
    OneOne, TwoOne, ThreeOne;
    
    wire [31:0] WDOutput;
    
    wire [31:0] ZeroZeroOutput, OneZeroOutput, TwoZeroOutput, ThreeZeroOutput, ZeroOneOutput,
    OneOneOutput, TwoOneOutput, ThreeOneOutput, ZeroTwoOutput, OneTwoOutput, TwoTwoOutput,
    ThreeTwoOutput, ZeroThreeOutput, OneThreeOutput, TwoThreeOutput, ThreeThreeOutput;
    
    wire [31:0] ZeroZeroFrame, OneZeroFrame, TwoZeroFrame, ThreeZeroFrame, ZeroOneFrame,
    OneOneFrame, TwoOneFrame, ThreeOneFrame, ZeroTwoFrame, OneTwoFrame, TwoTwoFrame,
    ThreeTwoFrame, ZeroThreeFrame, OneThreeFrame, TwoThreeFrame, ThreeThreeFrame;

    wire [31:0] ZeroZeroWindow, OneZeroWindow, TwoZeroWindow, ThreeZeroWindow, ZeroOneWindow,
    OneOneWindow, TwoOneWindow, ThreeOneWindow, ZeroTwoWindow, OneTwoWindow, TwoTwoWindow,
    ThreeTwoWindow, ZeroThreeWindow, OneThreeWindow, TwoThreeWindow, ThreeThreeWindow;
    
    output [31:0] ReadData, SAD;
    
    DataMemory DM1(
        .Address(Address),
        .WriteData(WDOutput),
        .Clk(Clk),
        .MemWrite(MemWrite),
        .MemRead(MemReadOut),
        .ReadData(ReadData),
        .ZeroZero(ZeroZero),
        .OneZero(OneZero),
        .TwoZero(TwoZero),
        .ThreeZero(ThreeZero),
        .ZeroOne(ZeroOne),
        .OneOne(OneOne), 
        .TwoOne(TwoOne), 
        .ThreeOne(ThreeOne),
        .ZeroZeroFrame(ZeroZeroFrame),
        .OneZeroFrame(OneZeroFrame),
        .TwoZeroFrame(TwoZeroFrame),
        .ThreeZeroFrame(ThreeZeroFrame),
        .ZeroOneFrame(ZeroOneFrame),
        .OneOneFrame(OneOneFrame), 
        .TwoOneFrame(TwoOneFrame), 
        .ThreeOneFrame(ThreeOneFrame), 
        .ZeroZeroWindow(ZeroZeroWindow),
        .OneZeroWindow(OneZeroWindow),
        .TwoZeroWindow(TwoZeroWindow),
        .ThreeZeroWindow(ThreeZeroWindow),
        .ZeroOneWindow(ZeroOneWindow),
        .OneOneWindow(OneOneWindow), 
        .TwoOneWindow(TwoOneWindow), 
        .ThreeOneWindow(ThreeOneWindow),
        .UpperOrLower(UpperOrLower)
     );
     Mux32Bit2To1 WDMux(
        .inA(WriteData),
        .inB(WBWriteData),
        .out(WDOutput),
        .sel(WBSel)
     );
     AbsoluteDifference32 ZeroZero1(
         .inA(ZeroZeroFrame),
         .inB(ZeroZeroWindow),
         .outC(ZeroZeroOutput)
     );
     AbsoluteDifference32 OneZero1(
         .inA(OneZeroFrame),
         .inB(OneZeroWindow),
         .outC(OneZeroOutput)
     );
     AbsoluteDifference32 TwoZero1(
          .inA(TwoZeroFrame),
          .inB(TwoZeroWindow),
          .outC(TwoZeroOutput)
      );
     AbsoluteDifference32 ThreeZero1(
         .inA(ThreeZeroFrame),
         .inB(ThreeZeroWindow),
         .outC(ThreeZeroOutput)
     );
     AbsoluteDifference32 ZeroOne1(
         .inA(ZeroOneFrame),
         .inB(ZeroOneWindow),
         .outC(ZeroOneOutput)
     );
     AbsoluteDifference32 OneOne1(
         .inA(OneOneFrame),
         .inB(OneOneWindow),
         .outC(OneOneOutput)
     );
     AbsoluteDifference32 TwoOne1(
         .inA(TwoOneFrame),
         .inB(TwoOneWindow),
         .outC(TwoOneOutput)
     );
     AbsoluteDifference32 ThreeOne1(
         .inA(ThreeOneFrame),
         .inB(ThreeOneWindow),
         .outC(ThreeOneOutput)
     );
     Summation16 sum(
         .inA(ZeroZeroOutput),
         .inB(OneZeroOutput),
         .inC(TwoZeroOutput),
         .inD(ThreeZeroOutput),
         .inE(ZeroOneOutput),
         .inF(OneOneOutput),
         .inG(TwoOneOutput),
         .inH(ThreeOneOutput),
         .out(SAD)
     );
endmodule

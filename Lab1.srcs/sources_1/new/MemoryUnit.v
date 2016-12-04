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
        xDim,
        yDim,
        ReadData, // outputs
        SAD
    );
    
    input Clk, MemWrite, MemReadOut, WBSel;
    input [31:0] Address, WriteData, WBWriteData, xDim, yDim;
    
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
         .xDim(xDim),
         .yDim(yDim),
         .ZeroZeroFrame(ZeroZeroFrame),
         .OneZeroFrame(OneZeroFrame),
         .TwoZeroFrame(TwoZeroFrame),
         .ThreeZeroFrame(ThreeZeroFrame),
         .ZeroOneFrame(ZeroOneFrame),
         .OneOneFrame(OneOneFrame), 
         .TwoOneFrame(TwoOneFrame), 
         .ThreeOneFrame(ThreeOneFrame), 
         .ZeroTwoFrame(ZeroTwoFrame), 
         .OneTwoFrame(OneTwoFrame), 
         .TwoTwoFrame(TwoTwoFrame),
         .ThreeTwoFrame(ThreeTwoFrame), 
         .ZeroThreeFrame(ZeroThreeFrame), 
         .OneThreeFrame(OneThreeFrame), 
         .TwoThreeFrame(TwoThreeFrame), 
         .ThreeThreeFrame(ThreeThreeFrame),
         .ZeroZeroWindow(ZeroZeroWindow),
         .OneZeroWindow(OneZeroWindow),
         .TwoZeroWindow(TwoZeroWindow),
         .ThreeZeroWindow(ThreeZeroWindow),
         .ZeroOneWindow(ZeroOneWindow),
         .OneOneWindow(OneOneWindow), 
         .TwoOneWindow(TwoOneWindow), 
         .ThreeOneWindow(ThreeOneWindow), 
         .ZeroTwoWindow(ZeroTwoWindow), 
         .OneTwoWindow(OneTwoWindow), 
         .TwoTwoWindow(TwoTwoWindow),
         .ThreeTwoWindow(ThreeTwoWindow), 
         .ZeroThreeWindow(ZeroThreeWindow), 
         .OneThreeWindow(OneThreeWindow), 
         .TwoThreeWindow(TwoThreeWindow), 
         .ThreeThreeWindow(ThreeThreeWindow)
     );
     Mux32Bit2To1 WDMux(
        .inA(WriteData),
        .inB(WBWriteData),
        .out(WDOutput),
        .sel(WBSel)
     );
     AbsoluteDifference32 ZeroZero(
         .inA(ZeroZeroFrame),
         .inB(ZeroZeroWindow),
         .outC(ZeroZeroOutput)
     );
     AbsoluteDifference32 OneZero(
         .inA(OneZeroFrame),
         .inB(OneZeroWindow),
         .outC(OneZeroOutput)
     );
     AbsoluteDifference32 TwoZero(
          .inA(TwoZeroFrame),
          .inB(TwoZeroWindow),
          .outC(TwoZeroOutput)
      );
     AbsoluteDifference32 ThreeZero(
         .inA(ThreeZeroFrame),
         .inB(ThreeZeroWindow),
         .outC(ThreeZeroOutput)
     );
     AbsoluteDifference32 ZeroOne(
         .inA(ZeroOneFrame),
         .inB(ZeroOneWindow),
         .outC(ZeroOneOutput)
     );
     AbsoluteDifference32 OneOne(
         .inA(OneOneFrame),
         .inB(OneOneWindow),
         .outC(OneOneOutput)
     );
     AbsoluteDifference32 TwoOne(
         .inA(TwoOneFrame),
         .inB(TwoOneWindow),
         .outC(TwoOneOutput)
     );
     AbsoluteDifference32 ThreeOne(
         .inA(ThreeOneFrame),
         .inB(ThreeOneWindow),
         .outC(ThreeOneOutput)
     );
     AbsoluteDifference32 ZeroTwo(
         .inA(ZeroTwoFrame),
         .inB(ZeroTwoWindow),
         .outC(ZeroTwoOutput)
     );
     AbsoluteDifference32 OneTwo(
         .inA(OneTwoFrame),
         .inB(OneTwoWindow),
         .outC(OneTwoOutput)
     );
     AbsoluteDifference32 TwoTwo(
         .inA(TwoTwoFrame),
         .inB(TwoTwoWindow),
         .outC(TwoTwoOutput)
     );
     AbsoluteDifference32 ThreeTwo(
         .inA(ThreeTwoFrame),
         .inB(ThreeTwoWindow),
         .outC(ThreeTwoOutput)
     );
     AbsoluteDifference32 ZeroThree(
         .inA(ZeroThreeFrame),
         .inB(ZeroThreeWindow),
         .outC(ZeroThreeOutput)
     );
     AbsoluteDifference32 OneThree(
         .inA(OneThreeFrame),
         .inB(OneThreeWindow),
         .outC(OneThreeOutput)
     );
     AbsoluteDifference32 TwoThree(
         .inA(TwoThreeFrame),
         .inB(TwoThreeWindow),
         .outC(TwoThreeOutput)
     );
     AbsoluteDifference32 ThreeThree(
         .inA(ThreeThreeFrame),
         .inB(ThreeThreeWindow),
         .outC(ThreeThreeOutput)
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
         .inI(ZeroTwoOutput),
         .inJ(OneTwoOutput),
         .inK(TwoTwoOutput),
         .inL(ThreeTwoOutput),
         .inM(ZeroThreeOutput),
         .inN(OneThreeOutput),
         .inO(TwoThreeOutput),
         .inP(ThreeThreeOutput),
         .out(SAD)
     );
endmodule

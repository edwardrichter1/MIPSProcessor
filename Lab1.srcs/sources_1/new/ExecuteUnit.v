`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2016 01:11:56 PM
// Design Name: 
// Module Name: ExecuteUnit
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


module ExecuteUnit(
        Clk, // inputs
        ShiftAmount, 
        ReadData1In,
        ReadData2In,
        SignExtendIn,
        RTIn,
        RDIn,
        RSIn,
        RegDstIn,
        ALUSrcIn,
        ALUControlIn,
        HiWriteEnableIn, 
        LoWriteEnableIn,
        HiLoOpIn,
        HiDstIn,
        LoDstIn,
        MoveHiLoIn,
        JumpLinkIn,
        MEMAddress,
        WBWriteData,
        RSMuxControl,
        RTMuxControl,
        HiOut, // outputs
        LoOut,
        ALUResultOut,
        MemWriteDataOut,
        WriteRegisterOut
    );
    
    input Clk, RegDstIn, ALUSrcIn, HiWriteEnableIn, LoWriteEnableIn,
    HiLoOpIn, HiDstIn, LoDstIn, MoveHiLoIn, JumpLinkIn;
    input [31:0]  ReadData1In, ReadData2In, SignExtendIn, MEMAddress, WBWriteData;
    input [4:0] RTIn, RDIn, RSIn, ALUControlIn, ShiftAmount, WriteRegisterOut;
    input [1:0] RTMuxControl, RSMuxControl;
    output [31:0] HiOut, LoOut, ALUResultOut, MemWriteDataOut;
    
    wire Zero;
    wire [4:0] RDRTMuxOutput; 
    wire [31:0] RSMuxOutput, MemWriteDataOut, ALUResultHi, ALUResultOut, HiALUorOPMuxOutput,
    LoALUorOPMuxOutput, HiOut, LoOut, HiResult, LoResult, ALUSrcMuxOutput, MoveLoMuxOutput, MoveHiMuxOutput;
    
    Mux32Bit3To1 RSMux(
        .out(RSMuxOutput), 
        .inA(ReadData1In), 
        .inB(MEMAddress), 
        .inC(WBWriteData), 
        .sel(RSMuxControl)
    );
    Mux32Bit3To1 RTMux(
        .out(MemWriteDataOut), 
        .inA(ReadData2In), 
        .inB(MEMAddress), 
        .inC(WBWriteData), 
        .sel(RTMuxControl)
    );
    Mux32Bit2To1 ALUSrcMux(
        .out(ALUSrcMuxOutput),
        .inA(MemWriteDataOut),
        .inB(SignExtendIn),
        .sel(ALUSrcIn)
    );
    ALU32Bit ALU(
        .ALUControl(ALUControlIn),
        .ShiftAmount(ShiftAmount),
        .A(RSMuxOutput),
        .B(ALUSrcMuxOutput),
        .ALUResult(ALUResultOut),
        .ALUResultHi(ALUResultHi),
        .Zero(Zero)
    );
    Mux5Bit2To1 RDRTMux(
        .out(RDRTMuxOutput),
        .inA(RTIn),
        .inB(RDIn),
        .sel(RegDstIn)
    );
    Mux5Bit2To1 WriteRegisterJumpLink(
        .out(WriteRegisterOut),
        .inA(RDRTMuxOutput),
        .inB(5'd31),
        .sel(JumpLinkIn)
    );
    Mux32Bit2To1 HiALUorOPMux(
        .out(HiALUorOPMuxOutput),
        .inA(ALUResultHi),
        .inB(HiResult),
        .sel(HiDstIn)
    );
    Mux32Bit2To1 LoALUorOPMux(
        .out(LoALUorOPMuxOutput),
        .inA(ALUResultOut),
        .inB(LoResult),
        .sel(LoDstIn)
    );
    Mux32Bit2To1 MoveHiMux(
        .out(MoveHiMuxOutput),
        .inA(HiALUorOPMuxOutput),
        .inB(ReadData1In),
        .sel(MoveHiLoIn)
    );
    Mux32Bit2To1 MoveLoMux(
        .out(MoveLoMuxOutput),
        .inA(LoALUorOPMuxOutput),
        .inB(ReadData1In),
        .sel(MoveHiLoIn)
    );
    Reg32Bit HiRegister(
        .in(MoveHiMuxOutput),
        .out(HiOut),
        .Clk(Clk),
        .WriteEnable(HiWriteEnableIn)
    );
    Reg32Bit LoRegister(
        .in(MoveLoMuxOutput),
        .out(LoOut),
        .Clk(Clk),
        .WriteEnable(LoWriteEnableIn)
   );
   HiLoArith HiLoOp(
       .A({HiOut, LoOut}), 
       .B({ALUResultHi, ALUResultOut}), 
       .outHi(HiResult),
       .outLo(LoResult), 
       .op(HiLoOpIn)
   );

endmodule

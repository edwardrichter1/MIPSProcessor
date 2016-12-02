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
        JumpLinkIn,
        MEMAddress,
        WBWriteData,
        RSMuxControl,
        RTMuxControl,
        ALUResultOut, // outputs
        MemWriteDataOut,
        WriteRegisterOut
    );
    
    input RegDstIn, ALUSrcIn, JumpLinkIn;
    input [31:0]  ReadData1In, ReadData2In, SignExtendIn, MEMAddress, WBWriteData;
    input [4:0] RTIn, RDIn, RSIn, ALUControlIn, ShiftAmount;
    input [1:0] RTMuxControl, RSMuxControl;
    output [4:0] WriteRegisterOut;
    output [31:0] ALUResultOut, MemWriteDataOut;
    
    wire [4:0] RDRTMuxOutput; 
    wire [31:0] RSMuxOutput, MemWriteDataOut, ALUSrcMuxOutput;
    
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
        .ALUResult(ALUResultOut)
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

endmodule

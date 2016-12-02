`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2016 04:15:42 PM
// Design Name: 
// Module Name: MipsDatapath
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


module MipsDatapath(
        Clk,
        PCReset,
        V0RegVal,
        V1RegVal
    );
    
    input Clk, PCReset;
    output [31:0] V0RegVal, V1RegVal;
    
    wire [31:0] CurrentPC;
    wire [31:0] IFInstruction, IFPCAddResult;
    
    wire IDRegWrite, IDRegDst, 
    IDALUSrc, IDMemWrite, IDMemRead, IDMemtoReg, IDSignExtendToReg,
    IDCmpOut, IDMov, IDCmpSel, IDJumpLink, IDJump, IDJumpReg, IDBranchControlOut;
    wire [4:0] IDALUControl;
    wire [31:0] IDInstruction, IDPCAddResult, IDReadData1, IDReadData2, IDSignExtendOut, 
    IDSignExtendRegisterOut, IDBranchOut;

    wire EXRegWrite, EXRegDst, EXALUSrc, EXMemWrite, EXMemRead, EXMemtoReg, EXSignExtendToReg,
    EXCmpOut, EXMov, EXCmpSel, EXJumpLink;
    wire [4:0] EXALUControl, EXRT, EXRD, EXRS, EXWriteRegister, EXShiftAmount;
    wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXSignExtendOut, EXSignExtendRegisterOut, EXALUResult, 
    EXMemWriteData;

    wire MEMRegWrite, MEMRegDst, MEMMemWrite, MEMMemRead, MEMMemtoReg, MEMSignExtendToReg,
    MEMCmpOut, MEMMov, MEMCmpSel, MEMJumpLink;
    wire [4:0] MEMWriteRegister;
    wire [31:0] MEMReadData1, MEMReadData2, MEMWriteData, MEMALUResult, MEMSignExtendRegisterOut, 
    MEMPCAddResult, MEMMemWriteData, MEMDataMemRead;

    wire WBRegWrite, WBRegDst, WBMemtoReg, WBSignExtendToReg, WBCmpOut, WBMov, 
    WBCmpSel,WBJumpLink, WBMemRead;
    wire [4:0] WBWriteRegister;
    wire [31:0] WBReadData1, WBReadData2, WBPCAddResult, WBALUResult, WBMemWriteData,
    WBSignExtendRegisterOut, WBWriteData, WBDataMemRead;

    wire IFIDReset, IFIDReadEnable, PCEnable, BubbleMuxControl, MEMRTMuxControl;
    wire [1:0] EXRTMuxControl, EXRSMuxControl;
    wire [2:0] IDRTMuxControl, IDRSMuxControl;
    wire [31:0] BubbleMuxOutput;
    wire [2:0] IDBranchControlSignal;
    
    InstructionFetchUnit IF (
        .Instruction(IFInstruction),
        .PCResult(CurrentPC),
        .PCAddResult(IFPCAddResult),
        .Reset(PCReset),
        .Clk(Clk),
        .ReadData1(IDReadData1),
        .JumpLink(IDJumpLink),
        .JumpReg(IDJumpReg),
        .Jump(IDJump),
        .Branch(IDBranchControlOut),
        .BranchAddress(IDBranchOut),
        .PCEnable(PCEnable),
        .OldInstruction(IDInstruction)
    );
    Pipe1Reg IFtoID(
        .Clk(Clk), 
        .Reset(IFIDReset),
        .WriteEnable(1'b1),
        .InstructionIn(IFInstruction),
        .PCAddResultIn(IFPCAddResult),
        .InstructionOut(IDInstruction),
        .PCAddResultOut(IDPCAddResult)
    );
    InstructionDecodeUnit ID (
        .Clk(Clk),
        .PCAddResultIn(IDPCAddResult), // inputs
        .Instruction(BubbleMuxOutput),
        .WriteRegister(WBWriteRegister),
        .RegWriteIn(WBRegWrite | (WBCmpOut & WBMov)),
        .WriteData(WBWriteData),
        .MuxInputRS(IDRSMuxControl),
        .MuxInputRT(IDRTMuxControl),
        .ALUResult(EXALUResult),
        .Address(MEMALUResult),
        .WriteBackData(WBWriteData),
        .EXPCAddResult(EXPCAddResult),
        .MEMPCAddResult(MEMPCAddResult),
        .WBPCAddResult(WBPCAddResult),
        .RD1Output(IDReadData1), // outputs
        .RD2Output(IDReadData2),
        .SignExtendOut(IDSignExtendOut),
        .SignExtendRegisterOut(IDSignExtendRegisterOut),
        .RegDst(IDRegDst),
        .RegWriteOut(IDRegWrite),
        .ALUSrc(IDALUSrc),
        .MemWrite(IDMemWrite),
        .MemRead(IDMemRead),
        .MemtoReg(IDMemtoReg),
        .ALUControl(IDALUControl),
        .SignExtendToReg(IDSignExtendToReg),
        .Mov(IDMov), 
        .CmpSel(IDCmpSel),
        .JumpLink(IDJumpLink),
        .Jump(IDJump),
        .JumpReg(IDJumpReg),
        .BranchControlOut(IDBranchControlOut),
        .BranchControlIn(IDBranchControlSignal),
        .BranchOut(IDBranchOut),
        .V0(V0RegVal),
        .V1(V1RegVal)
    );
    Pipe2Reg IDtoEx (
        .Clk(Clk),
        .Reset(PCReset),
        .PCAddResultIn(IDPCAddResult), // inputs
        .ReadData1In(IDReadData1),
        .ReadData2In(IDReadData2),
        .SignExtendIn(IDSignExtendOut),
        .RTIn(IDInstruction[20:16]),
        .RDIn(IDInstruction[15:11]),
        .RSIn(IDInstruction[25:21]),
        .ShiftAmountIn(IDInstruction[10:6]),
        .SignExtendRegisterIn(IDSignExtendRegisterOut),
        .RegDstIn(IDRegDst),
        .RegWriteIn(IDRegWrite),
        .ALUSrcIn(IDALUSrc),
        .MemWriteIn(IDMemWrite),
        .MemReadIn(IDMemRead),
        .MemtoRegIn(IDMemtoReg),
        .ALUControlIn(IDALUControl),
        .SignExtendToRegIn(IDSignExtendToReg),
        .MovIn(IDMov), 
        .CmpSelIn(IDCmpSel),
        .JumpLinkIn(IDJumpLink),
        .PCAddResultOut(EXPCAddResult), // outputs
        .ReadData1Out(EXReadData1),
        .ReadData2Out(EXReadData2),
        .SignExtendOut(EXSignExtendOut),
        .RTOut(EXRT),
        .RDOut(EXRD),
        .RSOut(EXRS),
        .ShiftAmountOut(EXShiftAmount),
        .SignExtendRegisterOut(EXSignExtendRegisterOut),
        .RegDstOut(EXRegDst),
        .RegWriteOut(EXRegWrite),
        .ALUSrcOut(EXALUSrc),
        .MemWriteOut(EXMemWrite),
        .MemReadOut(EXMemRead),
        .MemtoRegOut(EXMemtoReg),
        .ALUControlOut(EXALUControl),
        .SignExtendToRegOut(EXSignExtendToReg),
        .MovOut(EXMov), 
        .CmpSelOut(EXCmpSel),
        .JumpLinkOut(EXJumpLink)
    );
    ExecuteUnit EX (
        .ShiftAmount(EXShiftAmount), // inputs
        .ReadData1In(EXReadData1),
        .ReadData2In(EXReadData2),
        .SignExtendIn(EXSignExtendOut),
        .RTIn(EXRT),
        .RDIn(EXRD),
        .RSIn(EXRS),
        .RegDstIn(EXRegDst),
        .ALUSrcIn(EXALUSrc),
        .ALUControlIn(EXALUControl),
        .JumpLinkIn(EXJumpLink),
        .MEMAddress(MEMALUResult),
        .WBWriteData(WBWriteData),
        .RSMuxControl(EXRSMuxControl),
        .RTMuxControl(EXRTMuxControl),
        .ALUResultOut(EXALUResult), // outputs
        .MemWriteDataOut(EXMemWriteData),
        .WriteRegisterOut(EXWriteRegister)
    );
    ForwardingUnit FU (
        .IDEXJumpLink(EXJumpLink),
        .MEMWBJumpLink(WBJumpLink),
        .EXMEMJumpLink(MEMJumpLink),
        .MEMWBRegWrite(WBRegWrite),
        .EXMEMMemRead(MEMMemRead),
        .EXMEMRegWrite(MEMRegWrite),
        .EXMEMRegisterRD(MEMWriteRegister),
        .MEMWBRegisterRD(WBWriteRegister),
        .IDEXRegisterRS(EXRS),
        .IDEXRegisterRT(EXRT),
        .EXRSMuxControl(EXRSMuxControl),
        .EXRTMuxControl(EXRTMuxControl),
        .IDRSMuxControl(IDRSMuxControl),
        .IDRTMuxControl(IDRTMuxControl),
        .IDEXRegWrite(EXRegWrite),
        .IFIDRegisterRS(IDInstruction[25:21]),
        .IFIDRegisterRT(IDInstruction[20:16]),
        .IDEXRegisterRD(EXWriteRegister),
        .MEMRTMuxControl(MEMRTMuxControl),
        .WBMemRead(WBMemRead),
        .MEMMemWrite(MEMMemWrite),
        .MEMWBRegisterRT(WBWriteRegister),
        .EXMEMRegisterRT(MEMWriteRegister),
        .IFIDJumpReg(IDJumpReg)
    );
    HazardDetectionUnit HU(
        .IFIDMEMRead(IDMemRead),
        .IFIDMEMWrite(IDMemWrite),
        .EXMEMRead(MEMMemRead),
        .EXMEMRegisterRT(MEMWriteRegister),
        .IDEXMEMRead(EXMemRead),
        .IDEXRegisterRT(EXRT),
        .IFIDRegisterRS(IDInstruction[25:21]),
        .IFIDRegisterRT(IDInstruction[20:16]),
        .Branch(IDBranchControlSignal),
        .BubbleMuxControl(BubbleMuxControl),
        .PCWrite(PCEnable),
        .IFIDReadEnable(IFIDReadEnable),
        .IFIDReset(IFIDReset)
    );
    Mux32Bit2To1 BubbleMux(
        .out(BubbleMuxOutput),
        .inA(IDInstruction),
        .inB(32'd0),
        .sel(BubbleMuxControl)
    );
    Pipe3Reg EXtoM (
        .Clk(Clk), // inputs 
        .Reset(PCReset),
        .PCAddResultIn(EXPCAddResult),
        .MemWriteDataIn(EXMemWriteData),
        .ALUResultIn(EXALUResult),
        .WriteRegisterIn(EXWriteRegister),
        .ReadData1In(EXReadData1),
        .ReadData2In(EXReadData2),
        .SignExtendRegisterIn(EXSignExtendRegisterOut),
        .RegWriteIn(EXRegWrite),
        .MemWriteIn(EXMemWrite),
        .MemReadIn(EXMemRead),
        .MemtoRegIn(EXMemtoReg),
        .SignExtendToRegIn(EXSignExtendToReg),
        .MovIn(EXMov), 
        .CmpSelIn(EXCmpSel),
        .JumpLinkIn(EXJumpLink),
        .PCAddResultOut(MEMPCAddResult), // outputs
        .ALUResultOut(MEMALUResult),
        .MemWriteDataOut(MEMMemWriteData),
        .WriteRegisterOut(MEMWriteRegister),
        .ReadData1Out(MEMReadData1),
        .ReadData2Out(MEMReadData2),
        .SignExtendRegisterOut(MEMSignExtendRegisterOut),
        .RegWriteOut(MEMRegWrite),
        .MemWriteOut(MEMMemWrite),
        .MemReadOut(MEMMemRead),
        .MemtoRegOut(MEMMemtoReg),
        .SignExtendToRegOut(MEMSignExtendToReg),
        .MovOut(MEMMov), 
        .CmpSelOut(MEMCmpSel),
        .JumpLinkOut(MEMJumpLink)
    );
    MemoryUnit MEM (
        .Clk(Clk), // inputs 
        .Address(MEMALUResult),
        .WriteData(MEMMemWriteData),
        .MemWrite(MEMMemWrite),
        .MemReadOut(MEMMemRead),
        .WBWriteData(WBWriteData),
        .WBSel(MEMRTMuxControl),
        .ReadData(MEMDataMemRead) // outputs
    );
    Pipe4Reg MEMtoWB (
        .Clk(Clk), // inputs 
        .Reset(PCReset),
        .PCAddResultIn(MEMPCAddResult), 
        .ALUResultIn(MEMALUResult),
        .MemWriteDataIn(MEMMemWriteData),
        .WriteRegisterIn(MEMWriteRegister),
        .ReadData1In(MEMReadData1),
        .ReadData2In(MEMReadData2),
        .SignExtendRegisterIn(MEMSignExtendRegisterOut),
        .RegWriteIn(MEMRegWrite),
        .MemtoRegIn(MEMMemtoReg),
        .SignExtendToRegIn(MEMSignExtendToReg),
        .MovIn(MEMMov), 
        .CmpSelIn(MEMCmpSel),
        .JumpLinkIn(MEMJumpLink),
        .DataMemReadIn(MEMDataMemRead),
        .MemReadIn(MEMMemRead),
        .PCAddResultOut(WBPCAddResult), // outputs 
        .ALUResultOut(WBALUResult),
        .MemWriteDataOut(WBMemWriteData),
        .WriteRegisterOut(WBWriteRegister),
        .ReadData1Out(WBReadData1),
        .ReadData2Out(WBReadData2),
        .SignExtendRegisterOut(WBSignExtendRegisterOut),
        .RegWriteOut(WBRegWrite),
        .MemtoRegOut(WBMemtoReg),
        .SignExtendToRegOut(WBSignExtendToReg),
        .MovOut(WBMov), 
        .CmpSelOut(WBCmpSel),
        .JumpLinkOut(WBJumpLink),
        .DataMemReadOut(WBDataMemRead),
        .MemReadOut(WBMemRead)
    );
    WriteBackUnit WB (
        .PCAddResult(WBPCAddResult), // inputs
        .ALUResult(WBALUResult),
        .DataMemRead(WBDataMemRead),
        .ReadData1(WBReadData1),
        .ReadData2(WBReadData2),
        .SignExtendRegisterOut(WBSignExtendRegisterOut),
        .MemtoRegOut(WBMemtoReg),
        .SignExtendToRegOut(WBSignExtendToReg),
        .MovOut(WBMov), 
        .CmpSelOut(WBCmpSel),
        .JumpLinkOut(WBJumpLink),
        .WriteData(WBWriteData), // outputs
        .CmpOut(WBCmpOut)
    );
    
    
endmodule

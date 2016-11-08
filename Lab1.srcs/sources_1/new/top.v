`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Team Members:
// Overall percent effort of each team meber: 
// Eddie Richter: 50%
// Hugo Valdez: 50%
// 
// ECE369 - Computer Architecture
// Laboratory 3 (PostLab)
// Module - top.v
// Description - Top module for MIPS processor.
// INPUTS:-
//
// OUTPUTS:- 
// FUNCTIONALITY:-
////////////////////////////////////////////////////////////////////////////////

module top(out7, en_out, Clk, PCReset);
    input Clk, PCReset;
    output [31:0] S1RegVal, S2RegVal, S3RegVal, S4RegVal;
    output wire [31:0] NextPC;

    wire [31:0] IFInstruction, IFPCAddResult;
    
    wire IDHiWriteEnable, IDLoWriteEnable, IDRegWrite, IDRegDst, 
    IDALUSrc, IDMemWrite, IDMemRead, IDMemtoReg, IDSignExtendToReg,
    IDCmpOut, IDMov, IDCmpSel, IDHiLoOp, IDHiDst, IDLoDst, IDMoveHiLo, IDMoveHi, IDMoveLo, IDJumpLink;
    wire [1:0] IDDataMem;
    wire [4:0] IDALUControl, IDRT, IDRS, IDRD;
    wire [31:0] IDInstruction, IDPCAddResult, IDReadData1, IDReadData2, IDSignExtendOut, 
    IDSignExtendRegisterOut;

    wire EXHiWriteEnable, EXLoWriteEnable, EXRegWrite, EXRegDst, 
    EXALUSrc, EXMemWrite, EXMemRead, EXMemtoReg, EXSignExtendToReg,
    EXCmpOut, EXMov, EXCmpSel, EXHiLoOp, EXHiDst, EXLoDst, EXMoveHiLo, EXMoveHi, EXMoveLo, EXJumpLink;
    wire [1:0] EXDataMem;
    wire [4:0] EXALUControl, EXRT, EXRD, EXRS, EXWriteRegister, EXShiftAmount;
    wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXSignExtendOut, EXSignExtendRegisterOut,
    EXHi, EXLo, EXALUResult, EXMemWriteData;

    wire MEMRegWrite, MEMRegDst, MEMMemWrite, MEMMemRead, MEMMemtoReg, MEMSignExtendToReg,
    MEMCmpOut, MEMMov, MEMCmpSel, MEMMoveHi, MEMMoveLo, MEMJumpLink;
    wire [1:0] MEMDataMem;
    wire [4:0] MEMWriteRegister;
    wire [31:0] MEMReadData1, MemReadData2, MEMWriteData, MEMALUResult, MEMHi,
    MEMLo, MEMSignExtendRegisterOut, MEMPCAddResult, MEMMemWriteData, MEMDataMemRead;

    wire WBRegWrite, WBRegDst, WBMemtoReg, WBSignExtendToReg, WBCmpOut, WBMov, 
    WBCmpSel, WBMoveHi, WBMoveLo, WBJumpLink;
    wire [4:0] WBWriteRegister;
    wire [31:0] WBReadData1, WBReadData2, WBPCAddResult, WBHi, WBLo, WBALUResult, WBMemWriteData,
    WBSignExtendRegisterOut, WBWriteData, WBDataMemRead;

    InstructionFetchUnit IF (
        .Instruction(IFInstruction),
        .PCIn(NextPC),
        .PCAddResult(IFPCAddResult),
        .Reset(PCReset),
        .Clk(Clk)
    );
    Pipe1Reg IFtoID(
        .Clk(Clk), 
        .WriteEnable(1),
        .ReadEnable(1),
        .InstructionIn(IFInstruction),
        .PCADDResultIn(IFPCAddResult),
        .InstructionOut(IDInstruction),
        .PCAddResultOut(IDPCAddResult)
    );
    InstructionDecodeUnit ID (
        .Clk(Clk),
        .PCAddResultIn(IDPCAddResult), // inputs
        .Instruction(IDInstruction),
        .WriteRegister(WBWriteRegister),
        .RegWriteIn(WBRegWrite | (WBCmpOut & WBMov)),
        .WriteData(WBWriteData),
        .ReadData1(IDReadData1), // outputs
        .ReadData2(IDReadData2),
        .SignExtendOut(IDSignExtendOut),
        .RT(IDRT),
        .RD(IDRD),
        .RS(IDRS),
        .SignExtendRegisterOut(IDSignExtendRegisterOut),
        .NextPC(NextPC),
        .Jump(IDJump),
       // .Instruction(IDInstruction),
        .RegDst(IDRegDst),
        .RegWriteOut(IDRegWrite),
        .ALUSrc(IDALUSrc),
        .MemWrite(IDMemWrite),
        .MemRead(IDMemRead),
        .MemtoReg(IDMemtoReg),
        .ALUControl(IDALUControl),
        .HiWriteEnable(IDHiWriteEnable), 
        .LoWriteEnable(IDLoWriteEnable),
        .SignExtendToReg(IDSignExtendToReg),
        .Mov(IDMov), 
        .CmpSel(IDCmpSel),
        .HiLoOp(IDHiLoOp),
        .HiDst(IDHiDst),
        .LoDst(IDLoDst),
        .MoveHiLo(IDMoveHiLo),
        .MoveHi(IDMoveHi),
        .MoveLo(IDMoveLo),
        .DataMem(IDDataMem),
       // .JumpReg(IDJumpReg),
        .JumpLink(IDJumpLink)
    );
    Pipe2Reg IDtoEx (
        .Clk(Clk), 
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
        .HiWriteEnableIn(IDHiWriteEnable), 
        .LoWriteEnableIn(IDLoWriteEnable),
        .SignExtendToRegIn(IDSignExtendToReg),
        .MovIn(IDMov), 
        .CmpSelIn(IDCmpSel),
        .HiLoOpIn(IDHiLoOp),
        .HiDstIn(IDHiDst),
        .LoDstIn(IDLoDst),
        .MoveHiLoIn(IDMoveHiLo),
        .MoveHiIn(IDMoveHi),
        .MoveLoIn(IDMoveLo),
        .DataMemIn(IDDataMem),
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
        .HiWriteEnableOut(EXHiWriteEnable), 
        .LoWriteEnableOut(EXLoWriteEnable),
        .SignExtendToRegOut(EXSignExtendToReg),
        .MovOut(EXMov), 
        .CmpSelOut(EXCmpSel),
        .HiLoOpOut(EXHiLoOp),
        .HiDstOut(EXHiDst),
        .LoDstOut(EXLoDst),
        .MoveHiLoOut(EXMoveHiLo),
        .MoveHiOut(EXMoveHi),
        .MoveLoOut(EXMoveLo),
        .DataMemOut(EXDataMem),
        .JumpLinkOut(EXJumpLink)
    );
    ExecuteUnit EX (
        .Clk(Clk), // inputs 
        .ShiftAmount(EXShiftAmount),
        //.PCAddResultIn(EXPCAddResult),
        .ReadData1In(EXReadData1),
        .ReadData2In(EXReadData2),
        .SignExtendIn(EXSignExtendOut),
        .RTIn(EXRT),
        .RDIn(EXRD),
        .RSIn(EXRS),
        .RegDstIn(EXRegDst),
        .ALUSrcIn(EXALUSrc),
        .ALUControlIn(EXALUControl),
        .HiWriteEnableIn(EXHiWriteEnable), 
        .LoWriteEnableIn(EXLoWriteEnable),
        .HiLoOpIn(EXHiLoOp),
        .HiDstIn(EXHiDst),
        .LoDstIn(EXLoDst),
        .MoveHiLoIn(EXMoveHiLo),
        .JumpLinkIn(EXJumpLink),
        .HiOut(EXHi), // outputs
        .LoOut(EXLo),
        .ALUResultOut(EXALUResult),
        //.MemWriteDataOut(EXMemWriteData),
        .WriteRegisterOut(EXWriteRegister)
    );
    Pipe3Reg EXtoM (
        .Clk(Clk), // inputs 
        .PCAddResultIn(EXPCAddResult),
        .HiIn(EXHi),
        .LoIn(EXLo),
        .ALUResultIn(EXALUResult),
        .MemWriteDataIn(EXReadData2),
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
        .MoveHiIn(EXMoveHi),
        .MoveLoIn(EXMoveLo),
        .DataMemIn(EXDataMem),
        .JumpLinkIn(EXJumpLink),
        .PCAddResultOut(MEMPCAddResult), // outputs
        .HiOut(MEMHi),
        .LoOut(MEMLo),
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
        .MoveHiOut(MEMMoveHi),
        .MoveLoOut(MEMMoveLo),
        .DataMemOut(MEMDataMem),
        .JumpLinkOut(MEMJumpLink)
    );
    MemoryUnit MEM (
        .Clk(Clk), // inputs 
        .Address(MEMALUResult),
        .WriteData(MEMMemWriteData),
        .MemWrite(MEMMemWrite),
        .MemReadOut(MEMMemRead),
        .DataMemOut(MEMDataMem),
        .ReadData(MEMReadData) // outputs
    );
    Pipe4Reg MEMtoWB (
        .Clk(Clk), // inputs 
        .PCAddResultIn(MEMPCAddResult), 
        .HiIn(MEMHi),
        .LoIn(MEMLo),
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
        .MoveHiIn(MEMMoveHi),
        .MoveLoIn(MEMMoveLo),
        .JumpLinkIn(MEMJumpLink),
        .DataMemReadIn(MEMDataMemRead),
        .PCAddResultOut(WBPCAddResult), // outputs 
        .HiOut(WBHi),
        .LoOut(WBLo),
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
        .MoveHiOut(WBMoveHi),
        .MoveLoOut(WBMoveLo),
        .JumpLinkOut(WBJumpLink),
        .DataMemReadOut(WBDataMemRead)
    );
    WriteBackUnit WB (
        .PCAddResult(WBPCAddResult), // inputs
        .Hi(WBHi),
        .Lo(WBLo),
        .ALUResult(WBALUResult),
        .DataMemRead(WBDataMemRead),
        //.WriteRegister(WBWriteRegister),
        .ReadData1(WBReadData1),
        .ReadData2(WBReadData2),
        .SignExtendRegisterOut(WBSignExtendRegisterOut),
        //.RegWriteOut(WBRegWrite),
        .MemtoRegOut(WBMemtoReg),
        .SignExtendToRegOut(WBSignExtendToReg),
        .MovOut(WBMov), 
        .CmpSelOut(WBCmpSel),
        .MoveHiOut(WBMoveHi),
        .MoveLoOut(WBMoveLo),
        .JumpLinkOut(WBJumpLink),
        .WriteData(WBWriteData), // outputs
        .CmpOut(WBCmpOut)
    );
   
endmodule

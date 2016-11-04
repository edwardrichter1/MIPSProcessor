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
    IDALUSrc, IDMemWrite, IDMemRead, IDMemtoReg, IDSize, IDSignExtendToReg,
    IDCmpOut, IDMov, IDCmpSel, IDHiLoOp, IDHiDst, IDLoDst, IDMoveHiLo, IDMoveHi, IDMoveLo,
    IDForceZero, IDBranchControlOut, IDJump, IDShift16, IDJumpReg, IDJumpLink;
    wire [1:0] IDDataMem;
    wire [4:0] IDALUControl, IDRT, IDRS, IDRD;
    wire [31:0] IDInstruction, IDPCAddResult, IDReadData1, IDReadData2, IDSignExtendOut, 
    IDSignExtendRegisterOut;

    wire EXHiWriteEnable, EXLoWriteEnable, EXRegWrite, EXRegDst, 
    EXALUSrc, EXMemWrite, EXMemRead, EXMemtoReg, EXSize, EXSignExtendToReg,
    EXCmpOut, EXMov, EXCmpSel, EXHiLoOp, EXHiDst, EXLoDst, EXMoveHiLo, EXMoveHi, EXMoveLo,
    EXForceZero, EXBranchControlOut, EXJump, EXShift16, EXJumpReg, EXJumpLink;
    wire [1:0] EXDataMem;
    wire [4:0] EXALUControl, EXRT, EXRD, EXRS, EXWriteRegister;
    wire [31:0] EXPCAddResult, EXReadData1, EXReadData2, EXSignExtendOut, EXSignExtendRegisterOut,
    EXHi, EXLo, EXALUResult, EXMemWriteData;

    wire MEMRegWrite, MEMRegDst, MEMMemWrite, MEMMemRead, MEMMemtoReg, MEMSignExtendToReg,
    MEMCmpOut, MEMMov, MEMCmpSel, MEMMoveHi, MEMMoveLo, MEMJumpLink;
    wire [1:0] MEMDataMem;
    wire [4:0] MEMWriteRegister;
    wire [31:0] MEMReadData1, MemReadData2, MEMWriteData, MEMALUResult, MEMHi,
    MEMLo, MEMSignExtendRegisterOut, MEMPCAddResult;

    wire WBRegWrite, WBRegDst, WBMemtoReg, WBSignExtendToReg, WBCmpOut, WBMov, 
    WBCmpSel, WBMoveHi, WBMoveLo, WBJumpLink;
    wire [4:0] WBWriteRegister;
    wire [31:0] WBReadData1, WBReadData2, WBPCAddResult, WBHi, WBLo, WBALUResult, WBMemWriteData,
    WBSignExtendRegisterOut;

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
        .InstructionOut(IDInstruction),
        .PCAddResultIn(IFPCAddResult),
        .PCAddResultOut(IDPCAddResult)
    );
    InstructionDecodeUnit ID (
        .PCAddResultIn(IDPCAddResult), // inputs
        .Instruction(IDInstruction),
        .WriteRegister(WBWriteRegister),
        .RegWrite(WBRegWrite | (WBCmpOut & WBMov)),
        .WriteData(WBWriteData),
        .ReadData1(IDReadData1), // outputs
        .ReadData2(IDReadData2),
        .PCAddResultOut(IDPCAddResult),
        .SignExtendOut(IDSignExtendOut),
        .RT(IDRT),
        .RD(IDRD),
        .RS(IDRS),
        .SignExtendRegisterOut(IDSignExtendRegisterOut),
        .NextPC(NextPC),
        .Shift16(IDShift16),
        .Jump(IDJump),
        .Instruction(IDInstruction),
        .RegDst(IDRegDst),
        .RegWrite(IDRegWrite),
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
        .Size(IDSize),
        .HiLoOp(IDHiLoOp),
        .HiDst(IDHiDst),
        .LoDst(IDLoDst),
        .MoveHiLo(IDMoveHiLo),
        .MoveHi(IDMoveHi),
        .MoveLo(IDMoveLo),
        .ForceZero(IDForceZero),
        .DataMem(IDDataMem),
        .JumpReg(IDJumpReg),
        .JumpLink(IDJumpLink)    
    );
    Pipe2Reg IDtoEx (
        .Clk(Clk), 
        .PCAddResultIn(IDPCAddResult), // inputs
        .ReadData1In(IDReadData1),
        .ReadData2In(IDReadData2),
        .SignExtendIn(IDSignExtendOut),
        .RTIn(IDRT),
        .RDIn(IDRD),
        .RSIn(IDRS),
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
        .PCAddResultIn(EXPCAddResult),
        .ReadData1In(EXReadData1),
        .ReadData2In(EXReadData2),
        .SignExtendIn(EXSignExtendOut),
        .RTIn(EXRT),
        .RDIn(EXRD),
        .RSIn(EXRS),
        .SignExtendRegisterIn(EXSignExtendRegisterOut),
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
        .HiOut(EXHi),
        .LoOut(EXLo),
        .ALUResultOut(EXALUResult),
        .MemWriteDataOut(EXMemWriteData),
        .WriteRegisterOut(EXWriteRegister)
    );
    Pipe3Reg EXtoM (
        .Clk(Clk), // inputs 
        .WriteEnable(1),
        .ReadEnable(1),
        .PCAddResultIn(EXPCAddResult),
        .HiIn(EXHi),
        .LoIn(EXLo),
        .ALUResultIn(EXALUResult),
        .MemWriteDataIn(EXMemWriteData),
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
        .ReadData(MemReadData) // outputs
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
    );
    WriteBackUnit WB (
        .PCAddResult(WBPCAddResult), // inputs
        .Hi(WBHi),
        .Lo(WBLo),
        .ALUResult(WBALUResult),
        .DataMemRead(WBDataMemRead),
        .WriteRegister(WBWriteRegister),
        .ReadData1(WBReadData1),
        .ReadData2(WBReadData2),
        .SignExtendRegisterOut(WBSignExtendRegisterOut),
        .RegWriteOut(WBRegWrite),
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
    
    /*BranchControl BC(
        .Zero(Zero),
        .BranchControlIn(BranchControlIn),
        .ComparePort(ReadData1),
        .BranchControlOut(BranchControlOut)
    );
    Mux32Bit2To1 M12(
        .out(MuxOutput12),
        .inA(PCAddResult),
        .inB( (Instruction32 << 2) + PCAddResult),
        .sel(BranchControlOut)
    );
    Controller C1(
        .BranchControlIn(BranchControlIn),
        .Shift16(Shift16),
        .Jump(Jump),
        .Instruction(Instruction),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUControl(ALUControl),
        .HiWriteEnable(HiWriteEnable), 
        .LoWriteEnable(LoWriteEnable),
        .SignExtendToReg(SignExtendToReg),
        .Mov(Mov), 
        .CmpSel(CmpSel),
        .Size(Size),
        .HiLoOp(HiLoOp),
        .HiDst(HiDst),
        .LoDst(LoDst),
        .MoveHiLo(MoveHiLo),
        .MoveHi(MoveHi),
        .MoveLo(MoveLo),
        .ForceZero(ForceZero),
        .DataMem(DataMem),
        .JumpReg(JumpReg),
        .JumpLink(JumpLink)
    );
    Mux32Bit2To1 M13(
        .out(MuxOutput13),
        .inA(MuxOutput12),
        .inB({PCAddResult[31:28], Instruction[25:0], 2'b00}),
        .sel(Jump)
    );
    Mux5Bit2To1 M1(
        .out(MuxOutput1),
        .inA(Instruction[20:16]),
        .inB(Instruction[15:11]),
        .sel(RegDst)
    );
    RegisterFile RF1(
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(MuxOutput16),
        .WriteData(MuxOutput17),
        .RegWrite( (Mov & CmpOut) | RegWrite),
        .Clk(ClkOut),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    ZeroCompSometimes ZCS(
        .in(ReadData2), 
        .out(CmpOut),
        .sel(CmpSel)
    );
    SignExtendRegister SER(
        .in(ReadData2),
        .out(Data32),
        .Size(Size)
    );
    SignExtension SE1(
        .in(Instruction[15:0]),
        .out(Instruction32),
        .ForceZero(ForceZero),
        .Shift16(Shift16)
    );
    Mux32Bit2To1 M2(
        .out(MuxOutput2),
        .inA(ReadData2),
        .inB(Instruction32),
        .sel(ALUSrc)
    );
    ALU32Bit ALU1(
        .ALUControl(ALUControl),
        .ShiftAmount(Instruction[10:6]),
        .A(ReadData1),
        .B(MuxOutput2),
        .ALUResult(ALUResult),
        .ALUResultHi(ALUResultHi),
        .Zero(Zero)
    );
    Mux32Bit2To1 M6(
        .out(MuxOutput6),
        .inA(ALUResultHi),
        .inB(HiResult),
        .sel(HiDst)
    );
    Mux32Bit2To1 M7(
        .out(MuxOutput7),
        .inA(ALUResult),
        .inB(LoResult),
        .sel(LoDst)
    );
    Mux32Bit2To1 M8(
        .out(MuxOutput8),
        .inA(MuxOutput6),
        .inB(ReadData1),
        .sel(MoveHiLo)
    );
    Mux32Bit2To1 M9(
        .out(MuxOutput9),
        .inA(MuxOutput7),
        .inB(ReadData1),
        .sel(MoveHiLo)
    );    
    Reg32Bit HR (
        .in(MuxOutput8),
        .out(ALUResultHi2),
        .Clk(ClkOut),
        .WriteEnable(HiWriteEnable)
    );
    Reg32Bit LR (
        .in(MuxOutput9),
        .out(ALUResultLo2),
        .Clk(ClkOut),
        .WriteEnable(LoWriteEnable)
   );
   HiLoArith HLA(
       .A({ALUResultHi2, ALUResultLo2}), 
       .B({ALUResultHi, ALUResult}), 
       .outHi(HiResult),
       .outLo(LoResult), 
       .op(HiLoOp)
   );
   DataMemory DM1(
        .Address(ALUResult),
        .WriteData(ReadData2),
        .Clk(ClkOut),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(ReadData),
        .DataMem(DataMem)
    );
    Mux32Bit2To1 M3(
        .out(MuxOutput3),
        .inA(ALUResult),
        .inB(ReadData),
        .sel(MemtoReg)
    );
    Mux32Bit2To1 M4(
        .out(MuxOutput4),
        .inA(MuxOutput3),
        .inB(Data32),
        .sel(SignExtendToReg)
    );
    Mux32Bit2To1 M5(
        .out(MuxOutput5),
        .inA(MuxOutput4),
        .inB(ReadData1),
        .sel(Mov)
    );
    Mux32Bit2To1 M10(
        .out(MuxOutput10),
        .inA(MuxOutput5),
        .inB(ALUResultHi2),
        .sel(MoveHi)
    );
    Mux32Bit2To1 M11(
        .out(MuxOutput11),
        .inA(MuxOutput10),
        .inB(ALUResultLo2),
        .sel(MoveLo)
    );
    Mux32Bit2To1 M14(
        .out(MuxOutput14),
        .inA(MuxOutput13),
        .inB(ReadData1),
        .sel(JumpReg)
    );
    Mux32Bit2To1 M15(
        .out(MuxOutput15),
        .inA(MuxOutput14),
        .inB({PCAddResult[31:28], Instruction[25:0], 2'b00}),
        .sel(JumpLink)
    );
    Mux5Bit2To1 M16(
        .out(MuxOutput16),
        .inA(MuxOutput1),
        .inB(5'b11111),
        .sel(JumpLink)    
    );
    Mux32Bit2To1 M17(
        .out(MuxOutput17),
        .inA(MuxOutput11),
        .inB(PCAddResult),
        .sel(JumpLink) 
    );
    Mux32Bit2To1 M18(
        .out(MuxOutput18),
        .inA(32'd0),
        .inB(MuxOutput17),
        .sel(RegWrite) 
    );*/
endmodule

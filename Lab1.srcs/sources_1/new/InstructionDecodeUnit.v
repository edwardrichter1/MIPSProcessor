`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Team Members:
//      Eddie Richter
//      Hugo Valdez 
// ECE369 - Computer Architecture
// Module - InstructionDecodeUnit.v
// Description - The Instruction Decode stage in the MIPS pipelined datapath.
// INPUTS:-
//
// OUTPUTS:-
// Instruction: 
//
// FUNCTIONALITY:-
////////////////////////////////////////////////////////////////////////////////


module InstructionDecodeUnit(
        Clk, // inputs
        PCAddResultIn,
        Instruction,
        WriteRegister,
        RegWriteIn,
        WriteData,
        ReadData1, // outputs
        ReadData2,
        SignExtendOut,
       // CAddResultOut,
        RT,
        RD,
        RS,
        SignExtendRegisterOut,
        NextPC,
        Instruction,
        RegDst,
        RegWriteOut,
        ALUSrc,
        MemWrite,
        MemRead,
        MemtoReg,
        ALUControl,
        HiWriteEnable, 
        LoWriteEnable,
        SignExtendToReg,
        Mov, 
        CmpSel,
        HiLoOp,
        HiDst,
        LoDst,
        MoveHiLo,
        MoveHi,
        MoveLo,
        DataMem,
        JumpLink    
    );
    input Clk, RegWriteIn;
    input [31:0] PCAddResultIn, Instruction, WriteData;
    input [4:0] WriteRegister;
    output [31:0] ReadData1, ReadData2, SignExtendOut,
    SignExtendRegisterOut, NextPC/*, Instruction*/;
    output [4:0] RT, RD, RS, ALUControl;
    output [1:0] DataMem;
    output RegDst, RegWriteOut, ALUSrc, MemWrite, MemRead,
    MemtoReg, HiWriteEnable, LoWriteEnable, SignExtendToReg, Mov, CmpSel, HiLoOp,
    HiDst, LoDst, MoveHiLo, MoveHi, MoveLo, JumpLink;
    
    wire Shift16, ForceZero, Jump, JumpReg, JumpLink, Size, BranchControlOut, Equal;
    wire [31:0] BranchMuxOutput, ReadData1, ReadData2;
    wire [2:0] BranchControlIn;
    
    RegisterFile RF(
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(WriteRegister),
        .WriteData(WriteData),
        .RegWrite(RegWriteIn),
        .Clk(Clk),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    Comp32 RegComp(
        .in1(ReadData1),
        .in2(ReadData2),
        .out(Equal)
    );
    BranchControl BC(
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .Equal(Equal),
        .BranchControlIn(BranchControlIn),
        .BranchControlOut(BranchControlOut)
    );
    Mux32Bit2To1 BranchMux(
        .out(BranchMuxOutput),
        .inA(PCAddResultIn),
        .inB((Instruction[15:0] << 2) + PCAddResultIn),
        .sel(BranchControlOut)
    );
    Mux32Bit2To1 JumpMux(
        .out(JumpMuxOutput),
        .inA(BranchMuxOutput),
        .inB({PCAddResultIn[31:28], Instruction[25:0], 2'b00}),
        .sel(Jump | JumpLink)
    );
    Mux32Bit2To1 JumpRegMux(
        .out(NextPC),
        .inA(JumpMuxOutput),
        .inB(ReadData1),
        .sel(JumpReg)
    );
    SignExtension SE1(
        .in(Instruction[15:0]),
        .out(SignExtendOut),
        .ForceZero(ForceZero),
        .Shift16(Shift16)
    );
    SignExtendRegister SER(
        .in(ReadData2),
        .out(SignExtendRegisterOut),
        .Size(Size)
    );
    Controller C1(
        .BranchControlIn(BranchControlIn),
        .Shift16(Shift16),
        .Jump(Jump),
        .Instruction(Instruction),
        .RegDst(RegDst),
        .RegWrite(RegWriteOut),
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

endmodule

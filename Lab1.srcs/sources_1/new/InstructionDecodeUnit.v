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
        PCAddResultIn, // inputs
        Instruction,
        WriteRegister,
        RegWrite,
        WriteData,
        ReadData1, // outputs
        ReadData2,
        CAddResultOut,
        SignExtendOut,
        RT,
        RD,
        RS,
        SignExtendRegisterOut,
        NextPC,
        Shift16,
        Jump,
        Instruction,
        RegDst,
        RegWrite,
        ALUSrc,
        MemWrite,
        emRead,
        MemtoReg,
        ALUControl,
        HiWriteEnable, 
        LoWriteEnable,
        SignExtendToReg,
        Mov, 
        CmpSel,
        Size,
        HiLoOp,
        HiDst,
        LoDst,
        MoveHiLo,
        MoveHi,
        MoveLo,
        ForceZero,
        DataMem,
        JumpReg,
        JumpLink    
    );
    
    input        PCAddResultIn, // inputs
    Instruction,
    WriteRegister,
    RegWrite,
    WriteData,
    ReadData1, // outputs
    ReadData2,
    CAddResultOut,
    SignExtendOut,
    RT,
    RD,
    RS,
    SignExtendRegisterOut,
    NextPC,
    Shift16,
    Jump,
    Instruction,
    RegDst,
    RegWrite,
    ALUSrc,
    MemWrite,
    emRead,
    MemtoReg,
    ALUControl,
    HiWriteEnable, 
    LoWriteEnable,
    SignExtendToReg,
    Mov, 
    CmpSel,
    Size,
    HiLoOp,
    HiDst,
    LoDst,
    MoveHiLo,
    MoveHi,
    MoveLo,
    ForceZero,
    DataMem,
    JumpReg,
    JumpLink    
    
    
endmodule

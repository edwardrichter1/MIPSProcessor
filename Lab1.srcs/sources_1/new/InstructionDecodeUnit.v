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
        MuxInputRS,
        MuxInputRT,
        ALUResult,
        Address,        
        RD1Output, // outputs
        RD2Output,
        SignExtendOut,
        RT,
        RD,
        RS,
        SignExtendRegisterOut,
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
        JumpLink,
        JumpReg,
        Jump,
        BranchControlOut,
        BranchControlIn,
        BranchOut,
        S1,
        S2,
        S3,
        S4    
    );
    input Clk, RegWriteIn;
    input [31:0] PCAddResultIn, Instruction, WriteData, Address, ALUResult;
    input [4:0] WriteRegister;
    output [31:0] RD1Output, RD2Output, SignExtendOut,
    SignExtendRegisterOut, BranchOut, S1, S2, S3, S4;
    input /*[1:0]*/[2:0] MuxInputRS, MuxInputRT;
    
    output [4:0] RT, RD, RS, ALUControl;
    output [1:0] DataMem;
    output RegDst, RegWriteOut, ALUSrc, MemWrite, MemRead,
    MemtoReg, HiWriteEnable, LoWriteEnable, SignExtendToReg, Mov, CmpSel, HiLoOp,
    HiDst, LoDst, MoveHiLo, MoveHi, MoveLo, JumpLink, BranchControlOut, Jump, JumpReg;
    output [2:0] BranchControlIn;
    
    wire Shift16, ForceZero, Jump, JumpReg, JumpLink, Size, BranchControlOut, Equal;
    wire [31:0] BranchMuxOutput, ReadData1, ReadData2, JumpMuxOutput, SignExtendOut, PCAddResultIn, RD1Output, RD2Output;
    wire [2:0] BranchControlIn;
    
    RegisterFile RF(
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(WriteRegister),
        .WriteData(WriteData),
        .RegWrite(RegWriteIn),
        .Clk(Clk),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .S1(S1),
        .S2(S2),
        .S3(S3),
        .S4(S4)        
    );
    /*Mux32Bit3To1 RD1(
        .inA(ReadData1),
        .inB(ALUResult),
        .inC(Address),
        .out(RD1Output),
        .sel(MuxInputRS)
    );
    Mux32Bit3To1 RD2(
        .inA(ReadData2),
        .inB(ALUResult),
        .inC(Address),
        .out(RD2Output),
        .sel(MuxInputRT)
    );*/
    Mux32Bit7To1 RD1(
        .inA(ReadData1), 
        .inB(ALUResult), 
        .inC(Address), 
        .inD(), // WriteBackData 
        .inE(), // EXPCAddResult
        .inF(), // MEMPCAddResult
        .inG(), // WBPCAddResult
        .sel(MuxInputRS), // Forwarding unit will send this
        .out(RD1Output)
    );
    Mux32Bit7To1 RD2(
        .inA(ReadData2), 
        .inB(ALUResult), 
        .inC(Address), 
        .inD(), // WriteBackData
        .inE(), // EXPCAddResult
        .inF(), // MEMPCAddResult
        .inG(), // WBPCAddResult
        .sel(MuxInputRS), // Forwarding unit will send this
        .out(RD2Output)
    );
    Comp32 RegComp(
        .in1(RD1Output),
        .in2(RD2Output),
        .out(Equal)
    );
    BranchControl BC(
        .ReadData2(RD1Output),
        .Equal(Equal),
        .BranchControlIn(BranchControlIn),
        .BranchControlOut(BranchControlOut)
    );
    SignExtension SE1(
        .in(Instruction[15:0]),
        .out(SignExtendOut),
        .ForceZero(ForceZero),
        .Shift16(Shift16)
    );
    SignExtendRegister SER(
        .in(RD2Output),
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
    Adder32Bit adder(
        .A(SignExtendOut << 2),
        .B(PCAddResultIn),
        .C(BranchOut)
    );
    

endmodule

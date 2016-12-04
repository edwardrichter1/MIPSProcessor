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
        WriteBackData,
        EXPCAddResult,
        MEMPCAddResult,
        WBPCAddResult,        
        RD1Output, // outputs
        RD2Output,
        SignExtendOut,
        SignExtendRegisterOut,
        RegDst,
        RegWriteOut,
        ALUSrc,
        MemWrite,
        MemRead,
        MemtoReg,
        ALUControl,
        SignExtendToReg,
        Mov, 
        CmpSel,
        JumpLink,
        JumpReg,
        Jump,
        BranchControlOut,
        BranchControlIn,
        BranchOut,
        V0,
        V1,
        SADWrite,
        UpperOrLower
    );
    input Clk, RegWriteIn;
    input [31:0] PCAddResultIn, Instruction, WriteData, Address, ALUResult,
    WriteBackData, EXPCAddResult, MEMPCAddResult, WBPCAddResult;
    input [4:0] WriteRegister;
    output [31:0] RD1Output, RD2Output, SignExtendOut,
    SignExtendRegisterOut, BranchOut, V0, V1;
    input [2:0] MuxInputRS, MuxInputRT;
    
    output [4:0] ALUControl;
    output RegDst, RegWriteOut, ALUSrc, MemWrite, MemRead,
    MemtoReg, SignExtendToReg, Mov, CmpSel, JumpLink, BranchControlOut, Jump, JumpReg, 
    SADWrite, UpperOrLower;
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
        .V0(V0),
        .V1(V1)   
    );
    Mux32Bit7To1 RD1(
        .inA(ReadData1), 
        .inB(ALUResult), 
        .inC(Address), 
        .inD(WriteBackData), // WriteBackData 
        .inE(EXPCAddResult), // EXPCAddResult
        .inF(MEMPCAddResult), // MEMPCAddResult
        .inG(WBPCAddResult), // WBPCAddResult
        .sel(MuxInputRS), // Forwarding unit will send this
        .out(RD1Output)
    );
    Mux32Bit7To1 RD2(
        .inA(ReadData2), 
        .inB(ALUResult), 
        .inC(Address), 
        .inD(WriteBackData), // WriteBackData
        .inE(EXPCAddResult), // EXPCAddResult
        .inF(MEMPCAddResult), // MEMPCAddResult
        .inG(WBPCAddResult), // WBPCAddResult
        .sel(MuxInputRT), // Forwarding unit will send this
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
        .SignExtendToReg(SignExtendToReg),
        .Mov(Mov), 
        .CmpSel(CmpSel),
        .Size(Size),
        .ForceZero(ForceZero),
        .DataMem(DataMem),
        .JumpReg(JumpReg),
        .JumpLink(JumpLink),
        .SADWrite(SADWrite),
        .UpperOrLower(UpperOrLower)
    );
    Adder32Bit adder(
        .A(SignExtendOut << 2),
        .B(PCAddResultIn),
        .C(BranchOut)
    );
    

endmodule

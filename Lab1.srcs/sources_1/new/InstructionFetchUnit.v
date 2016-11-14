`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members:
// Overall percent effort of each team meber: 
// Eddie Richter: 50%
// Hugo Valdez: 50%
// 
// ECE369 - Computer Architecture
// Laboratory 3 (PostLab)
// Module - InstructionFetchUnit.v
// Description - Fetches the instruction from the instruction memory based on 
//               the program counter (PC) value.
// INPUTS:-
// Reset: 1-Bit input signal. 
// Clk: Input clock signal.
//
// OUTPUTS:-
// Instruction: 32-Bit output instruction from the instruction memory. 
//              Decimal value diplayed on the LCD usng the wrapper given in Lab 2
//
// FUNCTIONALITY:-
// Please connect up the following implemented modules to create this
// 'InstructionFetchUnit':-
//   (a) ProgramCounter.v
//   (b) PCAdder.v
//   (c) InstructionMemory.v
// Connect the modules together in a testbench so that the instruction memory
// outputs the contents of the next instruction indicated by the memory location
// in the PC at every clock cycle. Please initialize the instruction memory with
// some preliminary values for debugging purposes.
//
// @@ The 'Reset' input control signal is connected to the program counter (PC) 
// register which initializes the unit to output the first instruction in 
// instruction memory.
// @@ The 'Instruction' output port holds the output value from the instruction
// memory module.
// @@ The 'Clk' input signal is connected to the program counter (PC) register 
// which generates a continuous clock pulse into the module.
////////////////////////////////////////////////////////////////////////////////

module InstructionFetchUnit(
        Instruction, 
        PCResult, 
        PCAddResult, 
        Reset, 
        Clk, 
        JumpLink, 
        JumpReg, 
        Jump, 
        Branch, 
        BranchAddress, 
        ReadData1,
        PCEnable,
        OldInstruction
    );

    input Reset, Clk, JumpLink, JumpReg, Jump, Branch, PCEnable;
    input [31:0] ReadData1, BranchAddress, OldInstruction;
    output [31:0] Instruction;
    output [31:0] PCResult;
    
    output wire [31:0] PCAddResult;
    wire[31:0] PCResult, BranchMuxOutput, JumpMuxOutput,
    JumpRegMuxOutput;
    
    PCAdder PCAdder1(PCResult, PCAddResult);
    ProgramCounter ProgramCounter1(
        .Address(JumpRegMuxOutput),
        .PCResult(PCResult),
        .Reset(Reset), 
        .Clk(Clk),
        .Enable(PCEnable)
    );
    InstructionMemory InstructionMemory1(PCResult, Instruction);
    Mux32Bit2To1 BranchMux(
        .out(BranchMuxOutput),
        .inA(PCAddResult),
        .inB(BranchAddress),
        .sel(Branch)
    );
    Mux32Bit2To1 JumpMux(
        .out(JumpMuxOutput),
        .inA(BranchMuxOutput),
        .inB({PCAddResult[31:28], OldInstruction[25:0], 2'b00}),
        .sel(Jump | JumpLink)
    );
    Mux32Bit2To1 JumpRegMux(
        .out(JumpRegMuxOutput),
        .inA(JumpMuxOutput),
        .inB(ReadData1),
        .sel(JumpReg)
    );
    
endmodule

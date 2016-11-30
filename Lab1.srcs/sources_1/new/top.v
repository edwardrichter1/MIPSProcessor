`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Team Members:
// Overall percent effort of each team meber: 
// Eddie Richter: 50%
// Hugo Valdez: 50%
// Number of pipeline stages: 5
// Branch Decision: ID
// Branch Resolution: ID
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

module top(out7, en_out, Clk, PCReset, CDReset);
    input Clk, PCReset, CDReset;
    output [6:0] out7;
    output [7:0] en_out;
    wire ClkOut;
    wire [31:0] Output1, Output2;

    MipsDatapath mdp(
        .Clk(ClkOut),
        .PCReset(PCReset),
        .V0RegVal(Output1),
        .V1RegVal(Output2)
    );
    Two4DigitDisplay sevenSeg(
        .Clk(Clk), 
        .NumberA(Output2), 
        .NumberB(Output1), 
        .out7(out7), 
        .en_out(en_out)
     );
     ClkDiv CD(
        .Clk(Clk), 
        .Rst(CDReset), 
        .ClkOut(ClkOut)
     );   
endmodule

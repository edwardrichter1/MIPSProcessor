`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2016 04:01:08 PM
// Design Name: 
// Module Name: Pipe1Reg
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



module Pipe2Reg(
        Clk, // inputs
        Reset,
        PCAddResultIn,
        ReadData1In,
        ReadData2In,
        SignExtendIn,
        RTIn,
        RDIn,
        RSIn,
        SignExtendRegisterIn,
        RegDstIn,
        RegWriteIn,
        ALUSrcIn,
        MemWriteIn,
        MemReadIn,
        MemtoRegIn,
        ALUControlIn,
        HiWriteEnableIn, 
        LoWriteEnableIn,
        SignExtendToRegIn,
        MovIn, 
        CmpSelIn,
        HiLoOpIn,
        HiDstIn,
        LoDstIn,
        MoveHiLoIn,
        MoveHiIn,
        MoveLoIn,
        DataMemIn,
        JumpLinkIn,
        PCAddResultOut, // outputs
        ReadData1Out,
        ReadData2Out,
        SignExtendOut,
        RTOut,
        RDOut,
        RSOut,
        SignExtendRegisterOut,
        RegDstOut,
        RegWriteOut,
        ALUSrcOut,
        MemWriteOut,
        MemReadOut,
        MemtoRegOut,
        ALUControlOut,
        HiWriteEnableOut, 
        LoWriteEnableOut,
        SignExtendToRegOut,
        MovOut, 
        CmpSelOut,
        HiLoOpOut,
        HiDstOut,
        LoDstOut,
        MoveHiLoOut,
        MoveHiOut,
        MoveLoOut,
        DataMemOut,
        JumpLinkOut,
        ShiftAmountIn,
        ShiftAmountOut
    );

    input Clk, RegDstIn, RegWriteIn, ALUSrcIn, MemWriteIn,MemReadIn,
    MemtoRegIn, LoWriteEnableIn, HiWriteEnableIn, SignExtendToRegIn,
    MovIn, CmpSelIn, HiLoOpIn, HiDstIn, LoDstIn, MoveHiLoIn,
    MoveHiIn, MoveLoIn, JumpLinkIn, Reset;
    input [31:0] SignExtendRegisterIn, PCAddResultIn, ReadData1In, ReadData2In, SignExtendIn;
    input [4:0] RTIn, RDIn, RSIn, ALUControlIn, ShiftAmountIn;
    input [1:0] DataMemIn;
    
    output reg RegDstOut, RegWriteOut, ALUSrcOut, MemWriteOut, MemReadOut,
    MemtoRegOut, LoWriteEnableOut, HiWriteEnableOut, SignExtendToRegOut,
    MovOut, CmpSelOut, HiLoOpOut, HiDstOut, LoDstOut, MoveHiLoOut,
    MoveHiOut, MoveLoOut, JumpLinkOut;
    output reg [31:0] SignExtendRegisterOut, PCAddResultOut, ReadData1Out, ReadData2Out, SignExtendOut;
    output reg [4:0] RTOut, RDOut, RSOut, ALUControlOut, ShiftAmountOut;
    output reg [1:0] DataMemOut;
    
    
    always@(negedge Clk) begin
        if (Reset == 1) begin
            PCAddResultOut <= 0;
            ShiftAmountOut <= 0;
            ReadData1Out <= 0;
            ReadData2Out <= 0;
            SignExtendOut <= 0;
            RTOut <= 0;
            RDOut <= 0;
            RSOut <= 0;
            SignExtendRegisterOut <= 0;
            RegDstOut <= 0;
            RegWriteOut <= 0;
            ALUSrcOut <= 0;
            MemWriteOut <= 0;
            MemReadOut <= 0;
            MemtoRegOut <= 0;
            ALUControlOut <= 0;
            HiWriteEnableOut <= 0;
            LoWriteEnableOut <= 0;
            SignExtendToRegOut <= 0;
            MovOut <= 0;
            CmpSelOut <= 0;
            HiLoOpOut <= 0;
            HiDstOut <= 0;
            LoDstOut <= 0;
            MoveHiLoOut <= 0;
            MoveHiOut <= 0;
            MoveLoOut <= 0;
            DataMemOut <= 0;
            JumpLinkOut <= 0;
        end
        else begin
            PCAddResultOut <= PCAddResultIn;
            ShiftAmountOut <= ShiftAmountIn;
            ReadData1Out <= ReadData1In;
            ReadData2Out <= ReadData2In;
            SignExtendOut <= SignExtendIn;
            RTOut <= RTIn;
            RDOut <= RDIn;
            RSOut <= RSIn;
            SignExtendRegisterOut <= SignExtendRegisterIn;
            RegDstOut <= RegDstIn;
            RegWriteOut <= RegWriteIn;
            ALUSrcOut <= ALUSrcIn;
            MemWriteOut <= MemWriteIn;
            MemReadOut <= MemReadIn;
            MemtoRegOut <= MemtoRegIn;
            ALUControlOut <= ALUControlIn;
            HiWriteEnableOut <= HiWriteEnableIn;
            LoWriteEnableOut <= LoWriteEnableIn;
            SignExtendToRegOut <= SignExtendToRegIn;
            MovOut <= MovIn;
            CmpSelOut <= CmpSelIn;
            HiLoOpOut <= HiLoOpIn;
            HiDstOut <= HiDstIn;
            LoDstOut <= LoDstIn;
            MoveHiLoOut <= MoveHiLoIn;
            MoveHiOut <= MoveHiIn;
            MoveLoOut <= MoveLoIn;
            DataMemOut <= DataMemIn;
            JumpLinkOut <= JumpLinkIn;        
        end
    end

    

endmodule

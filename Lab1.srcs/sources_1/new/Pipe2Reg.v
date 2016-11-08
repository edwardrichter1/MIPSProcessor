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
    MoveHiIn, MoveLoIn, JumpLinkIn;
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
    
    reg RegDstTemp, RegWriteTemp, ALUSrcTemp, MemWriteTemp, MemReadTemp,
    MemtoRegTemp, LoWriteEnableTemp, HiWriteEnableTemp, SignExtendToRegTemp,
    MovTemp, CmpSelTemp, HiLoOpTemp, HiDstTemp, LoDstTemp, MoveHiLoTemp,
    MoveHiTemp, MoveLoTemp, JumpLinkTemp;
    reg [31:0] SignExtendRegisterTemp, PCAddResultTemp, ReadData1Temp, ReadData2Temp, SignExtendTemp;
    reg [4:0] RTTemp, RDTemp, RSTemp, ALUControlTemp, ShiftAmountTemp;
    reg [1:0] DataMemTemp;
    
   always@(posedge Clk) begin
        PCAddResultOut <= PCAddResultTemp;
        ShiftAmountOut <= ShiftAmountTemp;
        ReadData1Out <= ReadData1Temp;
        ReadData2Out <= ReadData2Temp;
        SignExtendOut <= SignExtendTemp;
        RTOut <= RTTemp;
        RDOut <= RDTemp;
        RSOut <= RSTemp;
        SignExtendRegisterOut <= SignExtendRegisterTemp;
        RegDstOut <= RegDstTemp;
        RegWriteOut <= RegWriteTemp;
        ALUSrcOut <= ALUSrcTemp;
        MemWriteOut <= MemWriteTemp;
        MemReadOut <= MemReadTemp;
        MemtoRegOut <= MemtoRegTemp;
        ALUControlOut <= ALUControlTemp;
        HiWriteEnableOut <= HiWriteEnableTemp;
        LoWriteEnableOut <= LoWriteEnableTemp;
        SignExtendToRegOut <= SignExtendToRegTemp;
        MovOut <= MovTemp;
        CmpSelOut <= CmpSelTemp;
        HiLoOpOut <= HiLoOpTemp;
        HiDstOut <= HiDstTemp;
        LoDstOut <= LoDstTemp;
        MoveHiLoOut <= MoveHiLoTemp;
        MoveHiOut <= MoveHiTemp;
        MoveLoOut <= MoveLoTemp;
        DataMemOut <= DataMemTemp;
        JumpLinkOut <= JumpLinkTemp;
    end
    
    always@(negedge Clk) begin
        PCAddResultTemp <= PCAddResultIn;
        ShiftAmountTemp <= ShiftAmountIn;
        ReadData1Temp <= ReadData1In;
        ReadData2Temp <= ReadData2In;
        SignExtendTemp <= SignExtendIn;
        RTTemp <= RTIn;
        RDTemp <= RDIn;
        RSTemp <= RSIn;
        SignExtendRegisterTemp <= SignExtendRegisterIn;
        RegDstTemp <= RegDstIn;
        RegWriteTemp <= RegWriteIn;
        ALUSrcTemp <= ALUSrcIn;
        MemWriteTemp <= MemWriteIn;
        MemReadTemp <= MemReadIn;
        MemtoRegTemp <= MemtoRegIn;
        ALUControlTemp <= ALUControlIn;
        HiWriteEnableTemp <= HiWriteEnableIn;
        LoWriteEnableTemp <= LoWriteEnableIn;
        SignExtendToRegTemp <= SignExtendToRegIn;
        MovTemp <= MovIn;
        CmpSelTemp <= CmpSelIn;
        HiLoOpTemp <= HiLoOpIn;
        HiDstTemp <= HiDstIn;
        LoDstTemp <= LoDstIn;
        MoveHiLoTemp <= MoveHiLoIn;
        MoveHiTemp <= MoveHiIn;
        MoveLoTemp <= MoveLoIn;
        DataMemTemp <= DataMemIn;
        JumpLinkTemp <= JumpLinkIn;
    end

    

endmodule

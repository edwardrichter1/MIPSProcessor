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
        SignExtendToRegIn,
        MovIn, 
        CmpSelIn,
        DataMemIn,
        JumpLinkIn,
        SADWriteIn,
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
        SignExtendToRegOut,
        MovOut, 
        CmpSelOut,
        DataMemOut,
        JumpLinkOut,
        ShiftAmountIn,
        ShiftAmountOut,
        SADWriteOut
    );

    input Clk, RegDstIn, RegWriteIn, ALUSrcIn, MemWriteIn,MemReadIn,
    MemtoRegIn, SignExtendToRegIn, MovIn, CmpSelIn, JumpLinkIn, Reset, SADWriteIn;
    input [31:0] SignExtendRegisterIn, PCAddResultIn, ReadData1In, ReadData2In, SignExtendIn;
    input [4:0] RTIn, RDIn, RSIn, ALUControlIn, ShiftAmountIn;
    input [1:0] DataMemIn;
    
    output reg RegDstOut, RegWriteOut, ALUSrcOut, MemWriteOut, MemReadOut,
    MemtoRegOut, SignExtendToRegOut, MovOut, CmpSelOut, JumpLinkOut, SADWriteOut;
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
            SignExtendToRegOut <= 0;
            MovOut <= 0;
            CmpSelOut <= 0;
            DataMemOut <= 0;
            JumpLinkOut <= 0;
            SADWriteOut <= 0;
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
            SignExtendToRegOut <= SignExtendToRegIn;
            MovOut <= MovIn;
            CmpSelOut <= CmpSelIn;
            DataMemOut <= DataMemIn;
            JumpLinkOut <= JumpLinkIn;
            SADWriteOut <= SADWriteIn;        
        end
    end

    

endmodule

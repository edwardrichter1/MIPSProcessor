`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2016 01:25:56 PM
// Design Name: 
// Module Name: Pipe4Reg
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


module Pipe4Reg(
        Clk, // inputs 
        Reset,
        PCAddResultIn, 
        HiIn,
        LoIn,
        ALUResultIn,
        MemWriteDataIn,
        WriteRegisterIn,
        ReadData1In,
        ReadData2In,
        SignExtendRegisterIn,
        RegWriteIn,
        MemtoRegIn,
        SignExtendToRegIn,
        MovIn, 
        CmpSelIn,
        MoveHiIn,
        MoveLoIn,
        JumpLinkIn,
        DataMemReadIn,
        PCAddResultOut, // outputs 
        HiOut,
        LoOut,
        ALUResultOut,
        MemWriteDataOut,
        WriteRegisterOut,
        ReadData1Out,
        ReadData2Out,
        SignExtendRegisterOut,
        RegWriteOut,
        MemtoRegOut,
        SignExtendToRegOut,
        MovOut, 
        CmpSelOut,
        MoveHiOut,
        MoveLoOut,
        JumpLinkOut,
        DataMemReadOut
    );
    
    input Clk, RegWriteIn, MemtoRegIn, SignExtendToRegIn, MovIn,
    CmpSelIn, MoveHiIn, MoveLoIn, JumpLinkIn, Reset;
    input [31:0] PCAddResultIn, HiIn, LoIn, ALUResultIn, MemWriteDataIn,
    ReadData1In, ReadData2In, SignExtendRegisterIn, DataMemReadIn;
    input [4:0] WriteRegisterIn;
    
    output reg RegWriteOut, MemtoRegOut, SignExtendToRegOut, MovOut,
    CmpSelOut, MoveHiOut, MoveLoOut, JumpLinkOut;
    output reg [31:0] PCAddResultOut, HiOut, LoOut, ALUResultOut, MemWriteDataOut,
    ReadData1Out, ReadData2Out, SignExtendRegisterOut, DataMemReadOut;
    output reg [4:0] WriteRegisterOut;

/*    reg RegWriteTemp, MemtoRegTemp, SignExtendToRegTemp, MovTemp,
    CmpSelTemp, MoveHiTemp, MoveLoTemp, JumpLinkTemp;
    reg [31:0] PCAddResultTemp, HiTemp, LoTemp, ALUResultTemp, MemWriteDataTemp,
    ReadData1Temp, ReadData2Temp, SignExtendRegisterTemp, DataMemReadTemp;
    reg [4:0] WriteRegisterTemp;
*/    
/*    always@(negedge Clk) begin
        PCAddResultOut <= PCAddResultTemp; 
        HiOut <= HiTemp;
        LoOut <= LoTemp;
        ALUResultOut <= ALUResultTemp;
        MemWriteDataOut <= MemWriteDataTemp;
        WriteRegisterOut <= WriteRegisterTemp;
        ReadData1Out <= ReadData1Temp;
        ReadData2Out <= ReadData2Temp;
        SignExtendRegisterOut <= SignExtendRegisterTemp;
        RegWriteOut <= RegWriteTemp;
        MemtoRegOut <= MemtoRegTemp;
        SignExtendToRegOut <= SignExtendToRegTemp;
        MovOut <= MovTemp;
        CmpSelOut <= CmpSelTemp;
        MoveHiOut <= MoveHiTemp;
        MoveLoOut <= MoveLoTemp;
        JumpLinkOut <= JumpLinkTemp;
        DataMemReadOut <= DataMemReadTemp;
    end
*/
    always@(posedge Clk) begin
        if(Reset == 1) begin
            PCAddResultOut <= 0; 
            HiOut <= 0;
            LoOut <= 0;
            ALUResultOut <= 0;
            MemWriteDataOut <= 0;
            WriteRegisterOut <= 0;
            ReadData1Out <= 0;
            ReadData2Out <= 0;
            SignExtendRegisterOut <= 0;
            RegWriteOut <= 0;
            MemtoRegOut <= 0;
            SignExtendToRegOut <= 0;
            MovOut <= 0;
            CmpSelOut <= 0;
            MoveHiOut <= 0;
            MoveLoOut <= 0;
            JumpLinkOut <= 0;
            DataMemReadOut <= 0;        
        end
        else begin
            PCAddResultOut <= PCAddResultIn; 
            HiOut <= HiIn;
            LoOut <= LoIn;
            ALUResultOut <= ALUResultIn;
            MemWriteDataOut <= MemWriteDataIn;
            WriteRegisterOut <= WriteRegisterIn;
            ReadData1Out <= ReadData1In;
            ReadData2Out <= ReadData2In;
            SignExtendRegisterOut <= SignExtendRegisterIn;
            RegWriteOut <= RegWriteIn;
            MemtoRegOut <= MemtoRegIn;
            SignExtendToRegOut <= SignExtendToRegIn;
            MovOut <= MovIn;
            CmpSelOut <= CmpSelIn;
            MoveHiOut <= MoveHiIn;
            MoveLoOut <= MoveLoIn;
            JumpLinkOut <= JumpLinkIn;
            DataMemReadOut <= DataMemReadIn;
        end
    end



endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 01:03:09 AM
// Design Name: 
// Module Name: HazardDetectionUnit
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


module HazardDetectionUnit(
        MEMWBMEMRead, // testing
        MEMWBRegisterRT, // testing
        IFIDMEMRead,
        IFIDMEMWrite,
        EXMEMRead,
        EXMEMRegisterRT,
        IDEXMEMRead,
        IDEXRegisterRT,
        IFIDRegisterRS,
        IFIDRegisterRT,
        Branch,
        BubbleMuxControl,
        PCWrite,
        IFIDReadEnable,
        IFIDReset
    );
    
    input EXMEMRead, IDEXMEMRead, IFIDMEMRead, IFIDMEMWrite;
    input [4:0] IDEXRegisterRT, EXMEMRegisterRT, IFIDRegisterRS, IFIDRegisterRT;
    input [2:0] Branch;
    
    input MEMWBMEMRead; // testin this out
    input [4:0] MEMWBRegisterRT;
    
    
    output reg BubbleMuxControl, PCWrite, IFIDReadEnable, IFIDReset;
    
    always@(/*EXMEMRead, EXMEMRegisterRT, IDEXRegisterRT, IFIDRegisterRS, IFIDRegisterRT, IDEXMEMRead, Branch, IFIDMEMRead, IFIDMEMWrite*/*) begin
        if( (IDEXMEMRead & ~(IFIDMEMRead | IFIDMEMWrite)) & ((IDEXRegisterRT == IFIDRegisterRS) | (IDEXRegisterRT == IFIDRegisterRT)) ) begin
            BubbleMuxControl <= 1;
            PCWrite <= 0;
            IFIDReadEnable <= 0;
            IFIDReset <= 0;        
        end
        else if(EXMEMRead & ((EXMEMRegisterRT == IFIDRegisterRS) | (EXMEMRegisterRT == IFIDRegisterRT))) begin
            if(Branch != 3'd0) begin
                BubbleMuxControl <= 1;
                PCWrite <= 0;
                IFIDReadEnable <= 0;
                IFIDReset <= 0;                
            end
        end
        else if(MEMWBMEMRead & ((MEMWBRegisterRT == IFIDRegisterRS) | (MEMWBRegisterRT == IFIDRegisterRT))) begin // testing this out
            if(Branch != 3'd0) begin
                BubbleMuxControl <= 1;
                PCWrite <= 0;
                IFIDReadEnable <= 0;
                IFIDReset <= 0;                
            end        
        end
        else begin
            BubbleMuxControl <= 0;
            PCWrite <= 1;
            IFIDReadEnable <= 1;
            IFIDReset <= 0;
        end
    end
    
endmodule

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
    
    input IDEXMEMRead, Branch;
    input [4:0] IDEXRegisterRT, IFIDRegisterRS, IFIDRegisterRT;
    
    output reg BubbleMuxControl, PCWrite, IFIDReadEnable, IFIDReset;
    
    always@(*) begin
        if(Branch) begin
            IFIDReset <= 1;
        end
        else if(IDEXMEMRead && (IDEXRegisterRT == IFIDRegisterRS) && (IDEXRegisterRT == IFIDRegisterRT) ) begin
            BubbleMuxControl <= 1;
            PCWrite <= 0;
            IFIDReadEnable <= 0;
            IFIDReset <= 0;
        end
        else begin
            BubbleMuxControl <= 0;
            PCWrite <= 1;
            IFIDReadEnable <= 1;
            IFIDReset <= 0;
        end
    end
    
endmodule

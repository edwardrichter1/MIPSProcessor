`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2016 04:29:57 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
        IDEXJumpLink,
        EXMEMJumpLink,
        EXMEMMemRead,
        MEMWBRegWrite,
        EXMEMRegWrite,
        EXMEMRegisterRD,
        MEMWBRegisterRD,
        IDEXRegisterRD,
        IDEXRegisterRS,
        IFIDRegisterRS,
        IFIDRegisterRT,
        IDEXRegisterRT,
        IDEXRegWrite,
        EXRSMuxControl,
        EXRTMuxControl,
        IDRSMuxControl,
        IDRTMuxControl,
        MEMRTMuxControl,
        WBMemRead,
        MEMMemWrite,
        MEMWBRegisterRT,
        EXMEMRegisterRT
    );
    
    input IDEXJumpLink, EXMEMJumpLink, MEMWBRegWrite, EXMEMRegWrite, IDEXRegWrite, WBMemRead, MEMMemWrite, EXMEMMemRead;
    input [4:0] MEMWBRegisterRD, EXMEMRegisterRD, IDEXRegisterRS, IFIDRegisterRS, IFIDRegisterRT, 
    IDEXRegisterRD, IDEXRegisterRT, MEMWBRegisterRT, EXMEMRegisterRT;
    
    output reg [1:0] EXRSMuxControl, EXRTMuxControl, /*IDRSMuxControl, IDRTMuxControl*/;
    output reg [2:0] IDRSMuxControl, IDRTMuxControl; // adding this
    output reg MEMRTMuxControl;
    
    always@(*) begin
        // ALU
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRS) && ~EXMEMMemRead) // RS MEM
            EXRSMuxControl <= 2'b01;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRS)) // RS WB
            EXRSMuxControl <= 2'b10;
        else
            EXRSMuxControl <= 2'b00;
        
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRT) && ~EXMEMMemRead) // RT MEM
            EXRTMuxControl <= 2'b01;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRT)) // RT WB
            EXRTMuxControl <= 2'b10;
        else
            EXRTMuxControl <= 2'b00;
        // Branch
        if(IDEXRegWrite && (IDEXRegisterRD != 0) && ((IFIDRegisterRS == IDEXRegisterRD) | (IDEXJumpLink) ) ) // RS EX
            IDRSMuxControl <= 2'b01;
        else if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && ((IFIDRegisterRS == EXMEMRegisterRD) | (EXMEMJumpLink)) && ~EXMEMMemRead)// RS MEM
            IDRSMuxControl <= 2'b10;
        else
            IDRSMuxControl <= 2'b00;
        
        if(IDEXRegWrite && (IDEXRegisterRD != 0) && ((IFIDRegisterRT == IDEXRegisterRD) | (IDEXJumpLink)) ) // RT EX
            IDRTMuxControl <= 2'b01;
        else if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && ((IFIDRegisterRT == EXMEMRegisterRD) | (EXMEMJumpLink)) && ~EXMEMMemRead)  // RT MEM
            IDRTMuxControl <= 2'b10;
        else
            IDRTMuxControl <= 2'b00;    
        // lw -> sw forwarding from wb to memory
        if(WBMemRead && MEMMemWrite && (MEMWBRegisterRT == EXMEMRegisterRT))
            MEMRTMuxControl <= 1;
        else
            MEMRTMuxControl <= 0;
            
    end
    
endmodule

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
        MEMWBJumpLink,
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
        EXMEMRegisterRT,
        IFIDJumpReg
    );
    
    input MEMWBJumpLink, IDEXJumpLink, EXMEMJumpLink, MEMWBRegWrite, IFIDJumpReg, EXMEMRegWrite, IDEXRegWrite, WBMemRead, MEMMemWrite, EXMEMMemRead;
    input [4:0] MEMWBRegisterRD, EXMEMRegisterRD, IDEXRegisterRS, IFIDRegisterRS, IFIDRegisterRT, 
    IDEXRegisterRD, IDEXRegisterRT, MEMWBRegisterRT, EXMEMRegisterRT;
    
    output reg [1:0] EXRSMuxControl, EXRTMuxControl;
    output reg [2:0] IDRSMuxControl, IDRTMuxControl;
    output reg MEMRTMuxControl;
    
    always@(*) begin
        // Forwarding to EX stage
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRS) && ~EXMEMMemRead) // RS MEM
            EXRSMuxControl <= 3'd1;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRS)) // RS WB
            EXRSMuxControl <= 3'd2;
        else
            EXRSMuxControl <= 3'd0;
        
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRT) && ~EXMEMMemRead) // RT MEM
            EXRTMuxControl <= 3'd1;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRT)) // RT WB
            EXRTMuxControl <= 3'd2;
        else
            EXRTMuxControl <= 3'd0;
        
        // MEMWBJumpLink
        // Forwarding to ID stage
        if(IDEXRegWrite && (IDEXRegisterRD != 0) && (IFIDRegisterRS == IDEXRegisterRD) & ~IDEXJumpLink) // ALUResult RS EX
            IDRSMuxControl <= 3'd1;
        else if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (IFIDRegisterRS == EXMEMRegisterRD) && ~EXMEMMemRead & ~EXMEMJumpLink)// Address RS EX
            IDRSMuxControl <= 3'd2;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (IFIDRegisterRS == MEMWBRegisterRD) & ~MEMWBJumpLink) // WriteData RS WB
            IDRSMuxControl <= 3'd3;
        else if(IDEXRegWrite && (IDEXRegisterRD != 0) && IDEXJumpLink && IFIDJumpReg) // PCAddResult RS EX
            IDRSMuxControl <= 3'd4;
        else if(IDEXRegWrite && (IDEXRegisterRD != 0) && EXMEMJumpLink && IFIDJumpReg ) // PCAddResult RS MEM
            IDRSMuxControl <= 3'd5;
        else if(IDEXRegWrite && (IDEXRegisterRD != 0) && MEMWBJumpLink && IFIDJumpReg ) // PCAddResult RS WB
            IDRSMuxControl <= 3'd6;
        else
            IDRSMuxControl <= 3'd0;
        
        if(IDEXRegWrite && (IDEXRegisterRD != 0) && (IFIDRegisterRT == IDEXRegisterRD) ) // ALUResult RT EX
            IDRTMuxControl <= 3'd1;
        else if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (IFIDRegisterRT == EXMEMRegisterRD) && ~EXMEMMemRead)// Address RT EX
            IDRTMuxControl <= 3'd2;
        else if(MEMWBRegWrite && (IDEXRegisterRD != 0) && (IFIDRegisterRT == MEMWBRegisterRD)) // WriteData RT WB
            IDRTMuxControl <= 3'd3;
        else if(IDEXRegWrite && (IDEXRegisterRD != 0) && IDEXJumpLink && IFIDJumpReg ) // PCAddResult RT EX
            IDRTMuxControl <= 3'd4;
        else if(IDEXRegWrite && (IDEXRegisterRD != 0) && EXMEMJumpLink && IFIDJumpReg ) // PCAddResult RT MEM
            IDRTMuxControl <= 3'd5;
        else if(IDEXRegWrite && (IDEXRegisterRD != 0) && MEMWBJumpLink && IFIDJumpReg ) // PCAddResult RT WB
            IDRTMuxControl <= 3'd6;
        else
            IDRTMuxControl <= 3'd0;

        // lw -> sw forwarding from wb to memory
        if(WBMemRead && MEMMemWrite && (MEMWBRegisterRT == EXMEMRegisterRT))
            MEMRTMuxControl <= 1;
        else
            MEMRTMuxControl <= 0;
            
    end
    
endmodule

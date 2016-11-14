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
    
    input MEMWBRegWrite, EXMEMRegWrite, IDEXRegWrite, WBMemRead, MEMMemWrite;
    input [4:0] MEMWBRegisterRD, EXMEMRegisterRD, IDEXRegisterRS, IFIDRegisterRS, IFIDRegisterRT, 
    IDEXRegisterRD, IDEXRegisterRT, MEMWBRegisterRT, EXMEMRegisterRT;
    
    output reg [1:0] EXRSMuxControl, EXRTMuxControl, IDRSMuxControl, IDRTMuxControl;
    output reg MEMRTMuxControl;
    
    always@(*) begin
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRS))
            EXRSMuxControl <= 2'b01;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRS))
            EXRSMuxControl <= 2'b10;
        else
            EXRSMuxControl <= 2'b00;
        
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRT))
            EXRTMuxControl <= 2'b01;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRT))
            EXRTMuxControl <= 2'b10;
        else
            EXRTMuxControl <= 2'b00;
            
        if(IDEXRegWrite && (IDEXRegisterRD != 0) && (IFIDRegisterRS == IDEXRegisterRD))
            IDRSMuxControl <= 2'b01;
        else if(IDEXRegWrite && (EXMEMRegisterRD != 0) && (IFIDRegisterRS == EXMEMRegisterRD))
            IDRSMuxControl <= 2'b10;
        else
            IDRSMuxControl <= 2'b00;
        
        if(IDEXRegWrite && (IDEXRegisterRD != 0) && (IFIDRegisterRT == IDEXRegisterRD))
            IDRTMuxControl <= 2'b01;
        else if(IDEXRegWrite && (EXMEMRegisterRD != 0) && (IFIDRegisterRT == EXMEMRegisterRD))
            IDRTMuxControl <= 2'b10;
        else
            IDRTMuxControl <= 2'b00;    
        
        if(WBMemRead && MEMMemWrite && (MEMWBRegisterRT == EXMEMRegisterRT))
            MEMRTMuxControl <= 1;
            
    end
    
endmodule

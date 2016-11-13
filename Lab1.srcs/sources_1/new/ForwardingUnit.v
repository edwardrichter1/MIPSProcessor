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
        IDEXRegisterRS,
        IDEXRegisterRT,
        RSMuxControl,
        RTMuxControl
    );
    
    input MEMWBRegWrite, EXMEMRegWrite;
    input [4:0] MEMWBRegisterRD, EXMEMRegisterRD, IDEXRegisterRS, IDEXRegisterRT;
    
    output reg [1:0] RSMuxControl, RTMuxControl;
    
    always@(*) begin
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRS))
            RSMuxControl <= 2'b10;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRS))
            RSMuxControl <= 2'b01;
        else
            RSMuxControl <= 2'b00;
        
        if(EXMEMRegWrite && (EXMEMRegisterRD != 0) && (EXMEMRegisterRD == IDEXRegisterRT))
            RTMuxControl <= 2'b10;
        else if(MEMWBRegWrite && (MEMWBRegisterRD != 0) && (MEMWBRegisterRD == IDEXRegisterRT))
            RTMuxControl <= 2'b01;
        else
            RTMuxControl <= 2'b00;
    end
    
endmodule

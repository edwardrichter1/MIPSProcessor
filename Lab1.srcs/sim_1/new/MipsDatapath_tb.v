`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2016 04:25:08 PM
// Design Name: 
// Module Name: MipsDatapath_tb
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


module MipsDatapath_tb();
        reg Clk, PCReset;
        wire [31:0] V0RegVal, V1RegVal;
        
        MipsDatapath mdp(
            .Clk(Clk),
            .PCReset(PCReset),
            .V0RegVal(V0RegVal),
            .V1RegVal(V1RegVal)
        );
        
        always begin
            Clk <= 0;
            #100 Clk <= 1;
            #100;
        end
        
        initial begin
            PCReset <= 1;
            #250;
            PCReset <= 0;
        end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Design Name: 
// Module Name: top_tb
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


module top_tb();

    reg Clk, PCReset;
    wire [31:0] S1RegVal, S2RegVal, S3RegVal, S4RegVal, CurrentPC;
	
	top u0(
        .S1RegVal(S1RegVal),
        .S2RegVal(S2RegVal),
        .S3RegVal(S3RegVal),
        .S4RegVal(S4RegVal),
        .CurrentPC(CurrentPC),
        .PCReset(PCReset),
        .Clk(Clk)
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

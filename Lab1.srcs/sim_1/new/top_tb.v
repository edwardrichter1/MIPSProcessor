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

    reg Clk, PCReset, CDReset;
    wire [6:0] out7;
    wire [7:0] en_out; 
    //wire [31:0] CurrentPC;
    //wire [31:0] V0RegVal, V1RegVal;
	
	top u0(
        .out7(out7),
        //.V0RegVal(V0RegVal),
        //.V1RegVal(V1RegVal),
        .en_out(en_out),
        //.CurrentPC(CurrentPC),
        .PCReset(PCReset),
        .CDReset(CDReset),
        .Clk(Clk)
	);
	
    always begin
        Clk <= 0;
        #100 Clk <= 1;
        #100;
    end
    
	initial begin
        PCReset <= 1;
        CDReset <= 1;
        #250;
        PCReset <= 0;
        CDReset <= 0;
	end

endmodule

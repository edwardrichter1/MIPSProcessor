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

    reg PCReset, CDReset;
    reg Clk;
    wire [7:0] en_out;
    wire [6:0] out7;
	//wire [31:0] PCResult;
	//wire [31:0] MuxOutput18;
	top u0(
        .PCReset(PCReset),
        .CDReset(CDReset),
        .Clk(Clk),
        .en_out(en_out),
        .out7(out7)
        //.PCResult(PCResult),
        //.MuxOutput18(MuxOutput18)
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
	    CDReset <= 1;
	end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2016 12:29:49 PM
// Design Name: 
// Module Name: InstructionFetchUnit_tb
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


module InstructionFetchUnit_tb();

    reg Reset;
    reg Clk;
    wire [31:0] Instruction;

	InstructionFetchUnit u0(
		.Instruction(Instruction),
        .Reset(Reset),
        .Clk(Clk)
	);
    always begin
        Clk <= 0;
        #100 Clk <= 1;
        #100;
    end
    
	initial begin
        Reset <= 1;
        #150;
        Reset <= 0;
	   
	end

endmodule

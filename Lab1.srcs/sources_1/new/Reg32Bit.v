`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 1
// Module - HiReg.v
// Description -
//
// INPUTS:-
//
// OUTPUTS:-
//
// FUNCTIONALITY:-
////////////////////////////////////////////////////////////////////////////////

module Reg32Bit(in, out, WriteEnable, Clk);

	input [31:0] in;
	input Clk, WriteEnable;

	output reg [31:0] out;
	
	reg [31:0] data;

    always@(posedge Clk) begin
        if (WriteEnable == 1)
            data <= in;
    end
    
    always@(*) begin
        out <= data;
    end

endmodule

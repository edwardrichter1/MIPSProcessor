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

module HiReg(in, out, Reset, Clk);

	input [31:0] in;
	input Reset, Clk;

	output reg [31:0] out;
	
	reg [31:0] data;

    always@(posedge Clk) begin
        if (Reset == 1) begin
            data <= 0;
        end
        else begin
            data <= in;
        end
    end
    
    always@(*) begin
        out <= data;
    end

endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 1
// Module - LoReg.v
// Description -
//
// INPUTS:-
//
// OUTPUTS:-
//
// FUNCTIONALITY:-
////////////////////////////////////////////////////////////////////////////////

module LoReg(in, out, Reset, Clk);

	input [31:0] in;
	input Reset, Clk;

	output reg [31:0] out;

    always@(posedge Clk) begin
        if (Reset == 1) begin
            out <= 0;
        end
        else begin
            out <= in;
        end
    end

endmodule

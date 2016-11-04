`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 1
// Module - ProgramCounter_tb.v
// Description - Test the 'ProgramCounter.v' module.
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_tb(); 

	reg [31:0] Address;
	reg Reset, Clk;

	wire [31:0] PCResult;

    ProgramCounter u0(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk)
    );

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
        Reset = 1;
        #15;
        Reset = 0;
        Address = 20;
        #10;
        Address = 30;
        #10;
        Address = 40;
	
	end

endmodule

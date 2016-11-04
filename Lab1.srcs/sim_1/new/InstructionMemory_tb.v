`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);

	initial begin
	
        Address = 0;
        #10;
        Address = 4;
        #10;
        Address = 8;
        #10;
        Address = 16;
        #10;
        Address = 32;
	
	end

endmodule

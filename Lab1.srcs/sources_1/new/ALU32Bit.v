`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 0000
// SUB  | 0001
// MUL  | 0010
// SLL  | 0011
// SLR  | 0100
// SLT  | 0101
// AND  | 0110
// OR   | 0111
// NOR  | 1000
// XOR  | 1001
// ROT  | 1010
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, ShiftAmount, A, B, ALUResult, ALUResultHi, Zero);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input [4:0] ShiftAmount; // the amount that we should shift

	output [31:0] ALUResult, ALUResultHi;	// answer 
	output Zero;	    // Zero=1 if ALUResult == 0
	
	reg signed [31:0] ALUResult, ALUResultHi; // making it a register
	reg Zero;
	reg signed [63:0] ALUResult64;
    
    always @ (ALUControl, A, B, ShiftAmount) begin
        case (ALUControl)
            5'b00000  : ALUResult <= A + B; 
            5'b00001  : ALUResult <= A - B;
            5'b00010  : begin
                            ALUResult64 = $signed(A) * $signed(B);
                            ALUResultHi = ALUResult64[63:32];
                            ALUResult = ALUResult64[31:0];
                       end
            5'b00011  : ALUResult <= B << A;
            5'b00100  : ALUResult <= B >> A;
            5'b00101  : begin
                        if ( $signed(A) < $signed(B) )
                            ALUResult <= 32'b1;
                        else
                            ALUResult <= 32'b0;
                       end
            5'b00110  : ALUResult <= A & B;
            5'b00111  : ALUResult <= A | B;
            5'b01000  : ALUResult <= ~(A | B);
            5'b01001  : ALUResult <= A ^ B;
            5'b01010  : ALUResult <= (B>>A)|(B<<(32-A));
            5'b01011  : ALUResult <= B << ShiftAmount;
            5'b01100  : ALUResult <= B >> ShiftAmount;
            5'b01101  : ALUResult <= (B>>ShiftAmount)|(B<<(32-ShiftAmount));
            5'b01110  : ALUResult <= $signed(B) >>> ShiftAmount; 
            5'b01111 : begin
                       if (A < B)
                           ALUResult <= 32'b1;
                       else
                           ALUResult <= 32'b0;
                      end
            5'b10000  : ALUResult <= $signed(B) >>> A;
            5'b10001  : begin
                          ALUResult64 = A * B;
                          ALUResultHi = ALUResult64[63:32];
                          ALUResult = ALUResult64[31:0];
                     end
        endcase
    end
    
    always@(*) begin
        if(ALUResult == 0)
            Zero <= 1'b1;
        else
            Zero <= 1'b0;
    end

endmodule

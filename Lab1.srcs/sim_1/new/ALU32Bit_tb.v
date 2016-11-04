`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	    ALUControl <= 4'b0000;
	    A <= 32'd5;
	    B <= 32'd7;
	    #20 $display("ADD: ALUResult=%h, Zero=%h", ALUResult, Zero);

        ALUControl <= 4'b0001;
	    A <= 32'd5;
	    B <= 32'd7;
	    #20 $display("SUB: ALUResult=%h, Zero=%h", ALUResult, Zero);	    
	   

        #100
        ALUControl <=4'b0010;
        A <= 32'd5;
        B <= 32'd7;
        #20 $display("MUL: ALUResult=%h, Zero=%h", ALUResult, Zero);

        #100
        ALUControl <= 4'b0011;
        A <= 32'd5;
        B <= 32'd2;
        #20 $display("SLL: ALUResult=%h, Zero=%h", ALUResult, Zero);
        
        #100
        ALUControl <= 4'b0100;
        A <= 32'd5;
        B <= 32'd2;
        #20 $display("SRL: ALUResult=%h, Zero=%h", ALUResult, Zero);
        
        #100
        ALUControl <= 4'b0101;
        A <= 32'd7;
        B <= 32'd5;
        #20 $display("SLT: ALUResult=%h, Zero=%h", ALUResult, Zero);
        
        #100
        ALUControl <= 4'b0110;
        A <= 32'd7;
        B <= 32'd5;
        #20 $display("AND: ALUResult=%h, Zero=%h", ALUResult, Zero);
        
        #100
        ALUControl <= 4'b0111;
        A <= 32'd7;
        B <= 32'd5;
        #20 $display("OR: ALUResult=%h, Zero=%h", ALUResult, Zero);
        
        #100
        ALUControl <= 4'b1000;
        A <= 32'd7;
        B <= 32'd5;
        #20 $display("NOR: ALUResult=%h, Zero=%h", ALUResult, Zero);    

        #100
        ALUControl <= 4'b1001;
        A <= 32'd7;
        B <= 32'd5;
        #20 $display("XOR: ALUResult=%h, Zero=%h", ALUResult, Zero);	

        #100
        ALUControl <= 4'b1010;
        A <= 32'd7;
        B <= 32'd5;
        #20 $display("ROT: ALUResult=%h, Zero=%h", ALUResult, Zero);

	end

endmodule

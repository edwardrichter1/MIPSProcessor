`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 
    reg[31:0]  memory[255:0];  // Instruction memory can hold 256 32 bit words
    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    initial begin
        memory[0] = 32'b00100011101111011111111111111100;	//	main:		addi	$sp, $sp, -4
        memory[1] = 32'b10101111101111110000000000000000;    //            sw    $ra, 0($sp)
        memory[2] = 32'b00110100000001000000000000000000;    //            ori    $a0, $zero, 0
        memory[3] = 32'b00110100000001010000000000010000;    //            ori    $a1, $zero, 16
        memory[4] = 32'b00110100000001100100000000010000;    //            ori    $a2, $zero, 16400
        memory[5] = 32'b00001100000000000000000000000111;    //            jal    vbsme
        memory[6] = 32'b00001000000000000000000000000110;    //    end:        j    end
        memory[7] = 32'b00110100000000100000000000000000;    //    vbsme:        ori    $v0, $zero, 0
        memory[8] = 32'b00110100000000110000000000000000;    //            ori    $v1, $zero, 0
        memory[9] = 32'b00000001001010001001000000010000;    //            addi    $s2, $s2, 0
        memory[10] = 32'b00000001001010001001100000010001;    //            addi    $s3, $s3, 0
        memory[11] = 32'b00100011101111011111111111111100;    //            addi    $sp, $sp, -4
        memory[12] = 32'b10101111101111110000000000000000;    //            sw    $ra, 0($sp)
        memory[13] = 32'b00100000000100010111111111111111;    //            addi    $s1, $zero, 32767
        memory[14] = 32'b00000010011100101000000000100000;    //            add    $s0, $s3, $s2
        memory[15] = 32'b00100000000101100000000000111100;    //            addi    $s6, $zero, 60
        memory[16] = 32'b00100000000101110000000000111100;    //            addi    $s7, $zero, 60
        memory[17] = 32'b00000010000000001000100000100000;    //            add    $s1, $s0, $zero
        memory[18] = 32'b00000001001000000001000000100000;    //            add    $v0, $t1, $zero
        memory[19] = 32'b00000001000000000001100000100000;    //            add    $v1, $t0, $zero
        memory[20] = 32'b00010001001101100000000000000010;    //    main_loop:    beq    $t1, $s6, at_right
        memory[21] = 32'b00100001001010010000000000000001;    //            addi    $t1, $t1, 1
        memory[22] = 32'b00001000000000000000000000011001;    //            j    done_branching
        memory[23] = 32'b00100000000010010000000000000000;    //    at_right:    addi    $t1, $zero, 0
        memory[24] = 32'b00100001000010000000000000000001;    //            addi    $t0, $t0, 1
        memory[25] = 32'b00000001001010001001000000010000;    //    done_branching:    addi    $s2, $s2, 0
        memory[26] = 32'b00000001001010001001100000010001;    //            addi    $s3, $s3, 0
        memory[27] = 32'b00101001001110010000000000111100;    //            slti    $t9, $t1, 60
        memory[28] = 32'b00101001000110000000000000111100;    //            slti    $t8, $t0, 60
        memory[29] = 32'b00000010011100101000000000100000;    //            add    $s0, $s3, $s2
        memory[30] = 32'b00010010001100000000000000000010;    //            beq    $s1, $s0, equal_to
        memory[31] = 32'b00000010000100010101000000101010;    //            slt    $t2, $s0, $s1
        memory[32] = 32'b00010001010000000000000000000011;    //            beq    $t2, $zero, no_new_SAD
        memory[33] = 32'b00000010000000001000100000100000;    //    equal_to:    add    $s1, $s0, $zero
        memory[34] = 32'b00000001000000000001000000100000;    //            add    $v0, $t0, $zero
        memory[35] = 32'b00000001001000000001100000100000;    //            add    $v1, $t1, $zero
        memory[36] = 32'b00010111000000001111111111101111;    //    no_new_SAD:    bne    $t8, $zero, main_loop
        memory[37] = 32'b00010111001000001111111111101110;    //            bne    $t9, $zero, main_loop
        memory[38] = 32'b10001111101111110000000000000000;    //    done:        lw    $ra, 0($sp)
        memory[39] = 32'b00100011101111010000000000000100;    //            addi    $sp, $sp, 4
        memory[40] = 32'b00000011111000000000000000001000;    //            jr    $ra    

    end
 
    
    always@(Address) begin
        Instruction <= memory[Address >> 2];
    end

endmodule

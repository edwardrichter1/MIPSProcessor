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
        //$readmemh("Instruction_memory.txt", memory);
        memory[0] = 32'b00100011101111011111111111111100;	//	main:		addi	$sp, $sp, -4
        memory[1] = 32'b10101111101111110000000000000000;    //            sw    $ra, 0($sp)
        memory[2] = 32'b00110100000001000000000000000000;    //            ori    $a0, $zero, 0
        memory[3] = 32'b00110100000001010000000000010000;    //            ori    $a1, $zero, 16
        memory[4] = 32'b00110100000001100100000000010000;    //            ori    $a2, $zero, 16400
        memory[5] = 32'b00001100000000000000000000000111;    //            jal    vbsme
        memory[6] = 32'b00001000000000000000000000000110;    //    end:        j    end
        memory[7] = 32'b00110100000000100000000000000000;    //    vbsme:        ori    $v0, $zero, 0
        memory[8] = 32'b00110100000000110000000000000000;    //            ori    $v1, $zero, 0
        memory[9] = 32'b00100011101111011111111111111100;    //            addi    $sp, $sp, -4
        memory[10] = 32'b10101111101111110000000000000000;    //            sw    $ra, 0($sp)
        memory[11] = 32'b00100000000100010111111111111111;    //            addi    $s1, $zero, 32767
        memory[12] = 32'b00100000000101100000000000111100;    //            addi    $s6, $zero, 60
        memory[13] = 32'b00100000000101110000000000111100;    //            addi    $s7, $zero, 60
        memory[14] = 32'b00001100000000000000000000100110;    //            jal    SAD
        memory[15] = 32'b00000010000000001000100000100000;    //            add    $s1, $s0, $zero
        memory[16] = 32'b00000001001000000001000000100000;    //            add    $v0, $t1, $zero
        memory[17] = 32'b00000001000000000001100000100000;    //            add    $v1, $t0, $zero
        memory[18] = 32'b00010001001101100000000000000010;    //    main_loop:    beq    $t1, $s6, at_right
        memory[19] = 32'b00100001001010010000000000000001;    //            addi    $t1, $t1, 1
        memory[20] = 32'b00001000000000000000000000010111;    //            j    done_branching
        memory[21] = 32'b00100000000010010000000000000000;    //    at_right:    addi    $t1, $zero, 0
        memory[22] = 32'b00100001000010000000000000000001;    //            addi    $t0, $t0, 1
        memory[23] = 32'b00100000000100000000000000000000;    //    done_branching:    addi    $s0, $zero, 0
        memory[24] = 32'b00001100000000000000000000100110;    //            jal    SAD
        memory[25] = 32'b00010010001100000000000000000011;    //            beq    $s1, $s0, equal_to
        memory[26] = 32'b00000010000100011100100000101010;    //            slt    $t9, $s0, $s1
        memory[27] = 32'b00101001000110000000000000111100;    //            slti    $t8, $t0, 60
        memory[28] = 32'b00010011001000000000000000000011;    //            beq    $t9, $zero, no_new_SAD
        memory[29] = 32'b00000010000000001000100000100000;    //    equal_to:    add    $s1, $s0, $zero
        memory[30] = 32'b00000001000000000001000000100000;    //            add    $v0, $t0, $zero
        memory[31] = 32'b00000001001000000001100000100000;    //            add    $v1, $t1, $zero
        memory[32] = 32'b00101001001110010000000000111100;    //    no_new_SAD:    slti    $t9, $t1, 60
        memory[33] = 32'b00010111000000001111111111110000;    //            bne    $t8, $zero, main_loop  NEED MANUAL OFFSET
        memory[34] = 32'b00010111001000001111111111101111;    //            bne    $t9, $zero, main_loop  NEED MANUAL OFFSET
        memory[35] = 32'b10001111101111110000000000000000;    //    done:        lw    $ra, 0($sp)
        memory[36] = 32'b00100011101111010000000000000100;    //            addi    $sp, $sp, 4
        memory[37] = 32'b00000011111000000000000000001000;    //            jr    $ra
        memory[38] = 32'b00100000000010100000000000000000;    //    SAD:        addi    $t2, $zero, 0
        memory[39] = 32'b00100000000010110000000000000000;    //    first_loop:    addi    $t3, $zero, 0
        memory[40] = 32'b00000001000010100110000000100000;    //    second_loop:    add    $t4, $t0, $t2
        memory[41] = 32'b00000000000011000110000110000000;    //            sll    $t4, $t4, 6
        memory[42] = 32'b00000001100010010110000000100000;    //            add    $t4, $t4, $t1
        memory[43] = 32'b00000001100010110110000000100000;    //            add    $t4, $t4, $t3
        memory[44] = 32'b00000000000011000110000010000000;    //            sll    $t4, $t4, 2
        memory[45] = 32'b00000001100001010110000000100000;    //            add    $t4, $t4, $a1
        memory[46] = 32'b10001101100011000000000000000000;    //            lw    $t4, 0($t4)
        memory[47] = 32'b00000000000010100110100010000000;    //            sll    $t5, $t2, 2
        memory[48] = 32'b00000001101010110110100000100000;    //            add    $t5, $t5, $t3
        memory[49] = 32'b00000000000011010110100010000000;    //            sll    $t5, $t5, 2
        memory[50] = 32'b00000001101001100110100000100000;    //            add    $t5, $t5, $a2
        memory[51] = 32'b10001101101011010000000000000000;    //            lw    $t5, 0($t5)
        memory[52] = 32'b00100001011010110000000000000001;    //            addi    $t3, $t3, 1
        memory[53] = 32'b00000001100011010110000000100010;    //            sub    $t4, $t4, $t5
        memory[54] = 32'b00000001100000000110100000101010;    //            slt    $t5, $t4, $zero
        memory[55] = 32'b00100001010010100000000000000001;    //            addi    $t2, $t2, 1
        memory[56] = 32'b00010001101000000000000000000001;    //            beq    $t5, $zero, SKIP
        memory[57] = 32'b00000000000011000110000000100010;    //            sub    $t4, $zero, $t4
        memory[58] = 32'b00000010000011001000000000100000;    //    SKIP:        add    $s0, $s0, $t4
        memory[59] = 32'b00101001011011000000000000000100;    //            slti    $t4, $t3, 4
        memory[60] = 32'b00101001010011110000000000000100;    //            slti    $t7, $t2, 4
        memory[61] = 32'b00010101100000001111111111101010;    //            bne    $t4, $zero, second_loop  NEED MANUAL OFFSET
        memory[62] = 32'b00010101111000001111111111101000;    //            bne    $t7, $zero, first_loop   NEED MANUAL OFFSET
        memory[63] = 32'b00000011111000000000000000001000;    //            jr    $ra


    end
 
    
    always@(Address) begin
        Instruction <= memory[Address >> 2];
    end

endmodule

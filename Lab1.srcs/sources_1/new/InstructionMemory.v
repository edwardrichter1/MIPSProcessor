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
    reg[31:0]  InstructionReg[255:0];  // Instruction memory can hold 256 32 bit words
    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    initial begin
        //$readmemh("Instruction_memory.txt", InstructionReg);
        InstructionReg[0] = 32'b00100011101111011111111111111100;	//	main:			addi	$sp, $sp, -4
        InstructionReg[1] = 32'b10101111101111110000000000000000;    //                sw    $ra, 0($sp)
        InstructionReg[2] = 32'b00110100000001000000000000000000;    //                ori    $a0, $zero, 0
        InstructionReg[3] = 32'b00110100000001010000000000010000;    //                ori    $a1, $zero, 16
        InstructionReg[4] = 32'b00110100000001100001001011110100;    //                ori    $a2, $zero, 4852
        InstructionReg[5] = 32'b00001100000000000000000000000111;    //                jal    vbsme
        InstructionReg[6] = 32'b00001000000000000000000000000110;    //    end:            j    end
        InstructionReg[7] = 32'b00110100000000100000000000000000;    //    vbsme:            ori    $v0, $zero, 0
        InstructionReg[8] = 32'b00110100000000110000000000000000;    //                ori    $v1, $zero, 0
        InstructionReg[9] = 32'b00100011101111011111111111111100;    //                addi    $sp, $sp, -4
        InstructionReg[10] = 32'b10101111101111110000000000000000;    //                sw    $ra, 0($sp)
        InstructionReg[11] = 32'b00100000000100000000000000000000;    //                addi    $s0, $zero, 0
        InstructionReg[12] = 32'b00100000000100010111111111111111;    //                addi    $s1, $zero, 32767
        InstructionReg[13] = 32'b10001100100100100000000000000000;    //                lw    $s2, 0($a0)
        InstructionReg[14] = 32'b10001100100100110000000000000100;    //                lw    $s3, 4($a0)
        InstructionReg[15] = 32'b10001100100101000000000000001000;    //                lw    $s4, 8($a0)
        InstructionReg[16] = 32'b10001100100101010000000000001100;    //                lw    $s5, 12($a0)
        InstructionReg[17] = 32'b00000010010101001011000000100010;    //                sub    $s6, $s2, $s4
        InstructionReg[18] = 32'b00000010011101011011100000100010;    //                sub    $s7, $s3, $s5
        InstructionReg[19] = 32'b00100000000010000000000000000000;    //                addi    $t0, $zero, 0
        InstructionReg[20] = 32'b00100000000010010000000000000000;    //                addi    $t1, $zero, 0
        InstructionReg[21] = 32'b00100000000010100000000000000000;    //                addi    $t2, $zero, 0
        InstructionReg[22] = 32'b00100000000010110000000000000000;    //                addi    $t3, $zero, 0
        InstructionReg[23] = 32'b00100000000011110000000000000000;    //                addi    $t7, $zero, 0
        InstructionReg[24] = 32'b00001100000000000000000001001101;    //                jal    SAD
        InstructionReg[25] = 32'b00000010000000001000100000100000;    //                add    $s1, $s0, $zero
        InstructionReg[26] = 32'b00000001001000000001000000100000;    //                add    $v0, $t1, $zero
        InstructionReg[27] = 32'b00000001000000000001100000100000;    //                add    $v1, $t0, $zero
        InstructionReg[28] = 32'b00000001000101100110000000100010;    //                sub    $t4, $t0, $s6
        InstructionReg[29] = 32'b00000001001101110101000000100010;    //                sub    $t2, $t1, $s7
        InstructionReg[30] = 32'b00000001100010100110000000100101;    //                or    $t4, $t4, $t2
        InstructionReg[31] = 32'b00010001100000000000000000101010;    //                beq    $t4, $zero, done
        InstructionReg[32] = 32'b00010001000000000000000000000111;    //    main_loop:        beq    $t0, $zero, top_or_right
        InstructionReg[33] = 32'b00010001001101110000000000000110;    //                beq    $t1, $s7, top_or_right
        InstructionReg[34] = 32'b00010001001000000000000000001111;    //                beq    $t1, $zero, bottom_or_left
        InstructionReg[35] = 32'b00010001000101100000000000001110;    //                beq    $t0, $s6, bottom_or_left
        InstructionReg[36] = 32'b00010001111000000000000000010111;    //                beq    $t7, $zero, middle_going_up
        InstructionReg[37] = 32'b00100001000010000000000000000001;    //                addi    $t0, $t0, 1
        InstructionReg[38] = 32'b00100001001010011111111111111111;    //                addi    $t1, $t1, -1
        InstructionReg[39] = 32'b00001000000000000000000000111110;    //                j    done_branching
        InstructionReg[40] = 32'b00010001111000000000000000000011;    //    top_or_right:        beq    $t7, $zero, window_going_up
        InstructionReg[41] = 32'b00100001000010000000000000000001;    //                addi    $t0, $t0, 1
        InstructionReg[42] = 32'b00100001001010011111111111111111;    //                addi    $t1, $t1, -1
        InstructionReg[43] = 32'b00001000000000000000000000111110;    //                j    done_branching
        InstructionReg[44] = 32'b00100001111011110000000000000001;    //    window_going_up:    addi    $t7, $t7, 1
        InstructionReg[45] = 32'b00010001001101110000000000000010;    //                beq    $t1, $s7, window_at_right
        InstructionReg[46] = 32'b00100001001010010000000000000001;    //                addi    $t1, $t1, 1
        InstructionReg[47] = 32'b00001000000000000000000000111110;    //                j    done_branching
        InstructionReg[48] = 32'b00100001000010000000000000000001;    //    window_at_right:    addi    $t0, $t0, 1
        InstructionReg[49] = 32'b00001000000000000000000000111110;    //                j    done_branching
        InstructionReg[50] = 32'b00010101111000000000000000000011;    //    bottom_or_left:        bne    $t7, $zero, window_going_down
        InstructionReg[51] = 32'b00100001001010010000000000000001;    //                addi    $t1, $t1, 1
        InstructionReg[52] = 32'b00100001000010001111111111111111;    //                addi    $t0, $t0, -1
        InstructionReg[53] = 32'b00001000000000000000000000111110;    //                j    done_branching
        InstructionReg[54] = 32'b00100001111011111111111111111111;    //    window_going_down:    addi    $t7, $t7, -1
        InstructionReg[55] = 32'b00010001000101100000000000000010;    //                beq    $t0, $s6, window_on_bottom
        InstructionReg[56] = 32'b00100001000010000000000000000001;    //                addi    $t0, $t0, 1
        InstructionReg[57] = 32'b00001000000000000000000000111110;    //                j    done_branching
        InstructionReg[58] = 32'b00100001001010010000000000000001;    //    window_on_bottom:    addi    $t1, $t1, 1
        InstructionReg[59] = 32'b00001000000000000000000000111110;    //                j    done_branching
        InstructionReg[60] = 32'b00100001001010010000000000000001;    //    middle_going_up:    addi    $t1, $t1, 1
        InstructionReg[61] = 32'b00100001000010001111111111111111;    //                addi    $t0, $t0, -1
        InstructionReg[62] = 32'b00100000000100000000000000000000;    //    done_branching:        addi    $s0, $zero, 0
        InstructionReg[63] = 32'b00001100000000000000000001001101;    //                jal    SAD
        InstructionReg[64] = 32'b00010010001100000000000000000010;    //                beq    $s1, $s0, equal_to
        InstructionReg[65] = 32'b00000010000100011100100000101010;    //                slt    $t9, $s0, $s1
        InstructionReg[66] = 32'b00010011001000000000000000000011;    //                beq    $t9, $zero, no_new_SAD
        InstructionReg[67] = 32'b00000010000000001000100000100000;    //    equal_to:        add    $s1, $s0, $zero
        InstructionReg[68] = 32'b00000001000000000001000000100000;    //                add    $v0, $t0, $zero
        InstructionReg[69] = 32'b00000001001000000001100000100000;    //                add    $v1, $t1, $zero
        InstructionReg[70] = 32'b00000001000101101100100000101010;    //    no_new_SAD:        slt    $t9, $t0, $s6
        InstructionReg[71] = 32'b00010111001000001111111111011000;    //                bne    $t9, $zero, main_loop (1111111111011010 -> 1111111111011000)
        InstructionReg[72] = 32'b00000001001101111100100000101010;    //                slt    $t9, $t1, $s7
        InstructionReg[73] = 32'b00010111001000001111111111011000;    //                bne    $t9, $zero, main_loop
        InstructionReg[74] = 32'b10001111101111110000000000000000;    //    done:            lw    $ra, 0($sp)
        InstructionReg[75] = 32'b00100011101111010000000000000100;    //                addi    $sp, $sp, 4
        InstructionReg[76] = 32'b00000011111000000000000000001000;    //                jr    $ra
        InstructionReg[77] = 32'b00100000000010100000000000000000;    //    SAD:            addi    $t2, $zero, 0
        InstructionReg[78] = 32'b00100000000010110000000000000000;    //    first_loop:        addi    $t3, $zero, 0
        InstructionReg[79] = 32'b00000001000010100110000000100000;    //    second_loop:        add    $t4, $t0, $t2
        InstructionReg[80] = 32'b01110001100100110110000000000010;    //                mul    $t4, $t4, $s3
        InstructionReg[81] = 32'b00000001100010010110000000100000;    //                add    $t4, $t4, $t1
        InstructionReg[82] = 32'b00000001100010110110000000100000;    //                add    $t4, $t4, $t3
        InstructionReg[83] = 32'b00000000000011000110000010000000;    //                sll    $t4, $t4, 2
        InstructionReg[84] = 32'b00000001100001010110000000100000;    //                add    $t4, $t4, $a1
        InstructionReg[85] = 32'b10001101100011000000000000000000;    //                lw    $t4, 0($t4)
        InstructionReg[86] = 32'b01110010101010100110100000000010;    //                mul    $t5, $s5, $t2
        InstructionReg[87] = 32'b00000001101010110110100000100000;    //                add    $t5, $t5, $t3
        InstructionReg[88] = 32'b00000000000011010110100010000000;    //                sll    $t5, $t5, 2
        InstructionReg[89] = 32'b00000001101001100110100000100000;    //                add    $t5, $t5, $a2
        InstructionReg[90] = 32'b10001101101011010000000000000000;    //                lw    $t5, 0($t5)
        InstructionReg[91] = 32'b00000001100011010110000000100010;    //                sub    $t4, $t4, $t5
        InstructionReg[92] = 32'b00000001100000000110100000101010;    //                slt    $t5, $t4, $zero
        InstructionReg[93] = 32'b00010001101000000000000000000001;    //                beq    $t5, $zero, SKIP
        InstructionReg[94] = 32'b00000000000011000110000000100010;    //                sub    $t4, $zero, $t4
        InstructionReg[95] = 32'b00000010000011001000000000100000;    //    SKIP:            add    $s0, $s0, $t4
        InstructionReg[96] = 32'b00100001011010110000000000000001;    //                addi    $t3, $t3, 1
        InstructionReg[97] = 32'b00000001011101010110000000101010;    //                slt    $t4, $t3, $s5
        InstructionReg[98] = 32'b00010101100000001111111111101100;    //                bne    $t4, $zero, second_loop (1111111111101110 -> 1111111111101100)
        InstructionReg[99] = 32'b00100001010010100000000000000001;    //                addi    $t2, $t2, 1
        InstructionReg[100] = 32'b00000001010101000110000000101010;    //                slt    $t4, $t2, $s4
        InstructionReg[101] = 32'b00010101100000001111111111101000;    //                bne    $t4, $zero, first_loop (1111111111101010 -> 1111111111101000)
        InstructionReg[102] = 32'b00000011111000000000000000001000;    //                jr    $ra

        /*InstructionReg[0] = 32'b00100011101111011111111111111100;	//	main:			addi	$sp, $sp, -4
        InstructionReg[1] = 32'b10101111101111110000000000000000;    //                sw    $ra, 0($sp)
        InstructionReg[2] = 32'b00110100000001000000000000000000;    //                ori    $a0, $zero, 0
        InstructionReg[3] = 32'b00110100000001010000000000010000;    //                ori    $a1, $zero, 16
        InstructionReg[4] = 32'b00110100000001100000000001010000;    //                ori    $a2, $zero, 80
        InstructionReg[5] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[6] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[7] = 32'b00110100000001000000000001100000;    //                ori    $a0, $zero, 96
        InstructionReg[8] = 32'b00110100000001010000000001110000;    //                ori    $a1, $zero, 112
        InstructionReg[9] = 32'b00110100000001100000010001110000;    //                ori    $a2, $zero, 1136
        InstructionReg[10] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[11] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[12] = 32'b00110100000001000000010010110000;    //                ori    $a0, $zero, 1200
        InstructionReg[13] = 32'b00110100000001010000010011000000;    //                ori    $a1, $zero, 1216
        InstructionReg[14] = 32'b00110100000001100000100011000000;    //                ori    $a2, $zero, 2240
        InstructionReg[15] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[16] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[17] = 32'b00110100000001000000100101000000;    //                ori    $a0, $zero, 2368
        InstructionReg[18] = 32'b00110100000001010000100101010000;    //                ori    $a1, $zero, 2384
        InstructionReg[19] = 32'b00110100000001100000110101010000;    //                ori    $a2, $zero, 3408
        InstructionReg[20] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[21] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[22] = 32'b00110100000001000000110111010000;    //                ori    $a0, $zero, 3536
        InstructionReg[23] = 32'b00110100000001010000110111100000;    //                ori    $a1, $zero, 3552
        InstructionReg[24] = 32'b00110100000001100001000111100000;    //                ori    $a2, $zero, 4576
        InstructionReg[25] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[26] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[27] = 32'b00110100000001000001001000100000;    //                ori    $a0, $zero, 4640
        InstructionReg[28] = 32'b00110100000001010001001000110000;    //                ori    $a1, $zero, 4656
        InstructionReg[29] = 32'b00110100000001100010001000110000;    //                ori    $a2, $zero, 8752
        InstructionReg[30] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[31] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[32] = 32'b00110100000001000010010000110000;    //                ori    $a0, $zero, 9264
        InstructionReg[33] = 32'b00110100000001010010010001000000;    //                ori    $a1, $zero, 9280
        InstructionReg[34] = 32'b00110100000001100011010001000000;    //                ori    $a2, $zero, 13376
        InstructionReg[35] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[36] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[37] = 32'b00110100000001000011010010000000;    //                ori    $a0, $zero, 13440
        InstructionReg[38] = 32'b00110100000001010011010010010000;    //                ori    $a1, $zero, 13456
        InstructionReg[39] = 32'b00110100000001100100010010010000;    //                ori    $a2, $zero, 17552
        InstructionReg[40] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[41] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[42] = 32'b00110100000001000100010100010000;    //                ori    $a0, $zero, 17680
        InstructionReg[43] = 32'b00110100000001010100010100100000;    //                ori    $a1, $zero, 17696
        InstructionReg[44] = 32'b00110100000001100100100100100000;    //                ori    $a2, $zero, 18720
        InstructionReg[45] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[46] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[47] = 32'b00110100000001000100100110100000;    //                ori    $a0, $zero, 18848
        InstructionReg[48] = 32'b00110100000001010100100110110000;    //                ori    $a1, $zero, 18864
        InstructionReg[49] = 32'b00110100000001100100110110110000;    //                ori    $a2, $zero, 19888
        InstructionReg[50] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[51] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[52] = 32'b00110100000001000100110111110000;    //                ori    $a0, $zero, 19952
        InstructionReg[53] = 32'b00110100000001010100111000000000;    //                ori    $a1, $zero, 19968
        InstructionReg[54] = 32'b00110100000001100101001000000000;    //                ori    $a2, $zero, 20992
        InstructionReg[55] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[56] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[57] = 32'b00110100000001000101001100000000;    //                ori    $a0, $zero, 21248
        InstructionReg[58] = 32'b00110100000001010101001100010000;    //                ori    $a1, $zero, 21264
        InstructionReg[59] = 32'b00110100000001100110001100010000;    //                ori    $a2, $zero, 25360
        InstructionReg[60] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[61] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[62] = 32'b00110100000001000110011100010000;    //                ori    $a0, $zero, 26384
        InstructionReg[63] = 32'b00110100000001010110011100100000;    //                ori    $a1, $zero, 26400
        InstructionReg[64] = 32'b00110100000001100110101100100000;    //                ori    $a2, $zero, 27424
        InstructionReg[65] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[66] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[67] = 32'b00110100000001000110101101100000;    //                ori    $a0, $zero, 27488
        InstructionReg[68] = 32'b00110100000001010110101101110000;    //                ori    $a1, $zero, 27504
        InstructionReg[69] = 32'b00110100000001100111101101110000;    //                ori    $a2, $zero, 31600
        InstructionReg[70] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[71] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[72] = 32'b00110100000001000111101110110000;    //                ori    $a0, $zero, 31664
        InstructionReg[73] = 32'b00110100000001010111101111000000;    //                ori    $a1, $zero, 31680
        InstructionReg[74] = 32'b00110100000001100111110000000000;    //                ori    $a2, $zero, 31744
        InstructionReg[75] = 32'b00001100000000000000000001100000;    //                jal    vbsme
        InstructionReg[76] = 32'b00001100000000000000000001010000;    //                jal    print_result
        InstructionReg[77] = 32'b10001111101111110000000000000000;    //                lw    $ra, 0($sp)
        InstructionReg[78] = 32'b00100011101111010000000000000100;    //                addi    $sp, $sp, 4
        InstructionReg[79] = 32'b00000011111000000000000000001000;    //                jr    $ra
        InstructionReg[80] = 32'b00000000010000000010000000100000;    //    print_result:        add    $a0, $v0, $zero
        InstructionReg[81] = 32'b00110100000000100000000000000001;    //                ori    $v0, $zero, 1
        InstructionReg[82] = 32'b00000000000000000000000000000000;    //                nop
        InstructionReg[83] = 32'b00110100000001000111110001000000;    //                ori    $a0, $zero, 31808
        InstructionReg[84] = 32'b00110100000000100000000000000100;    //                ori    $v0, $zero, 4
        InstructionReg[85] = 32'b00000000000000000000000000000000;    //                nop
        InstructionReg[86] = 32'b00000000011000000010000000100000;    //                add    $a0, $v1, $zero
        InstructionReg[87] = 32'b00110100000000100000000000000001;    //                ori    $v0, $zero, 1
        InstructionReg[88] = 32'b00000000000000000000000000000000;    //                nop
        InstructionReg[89] = 32'b00110100000001000111110001000000;    //                ori    $a0, $zero, 31808
        InstructionReg[90] = 32'b00110100000000100000000000000100;    //                ori    $v0, $zero, 4
        InstructionReg[91] = 32'b00000000000000000000000000000000;    //                nop
        InstructionReg[92] = 32'b00110100000001000111110001000000;    //                ori    $a0, $zero, 31808
        InstructionReg[93] = 32'b00110100000000100000000000000100;    //                ori    $v0, $zero, 4
        InstructionReg[94] = 32'b00000000000000000000000000000000;    //                nop
        InstructionReg[95] = 32'b00000011111000000000000000001000;    //                jr    $ra
        InstructionReg[96] = 32'b00110100000000100000000000000000;    //    vbsme:            ori    $v0, $zero, 0
        InstructionReg[97] = 32'b00110100000000110000000000000000;    //                ori    $v1, $zero, 0
        InstructionReg[98] = 32'b00100011101111011111111111111100;    //                addi    $sp, $sp, -4
        InstructionReg[99] = 32'b10101111101111110000000000000000;    //                sw    $ra, 0($sp)
        InstructionReg[100] = 32'b00100000000100000000000000000000;    //                addi    $s0, $zero, 0
        InstructionReg[101] = 32'b00100000000100010111111111111111;    //                addi    $s1, $zero, 32767
        InstructionReg[102] = 32'b10001100100100100000000000000000;    //                lw    $s2, 0($a0)
        InstructionReg[103] = 32'b10001100100100110000000000000100;    //                lw    $s3, 4($a0)
        InstructionReg[104] = 32'b10001100100101000000000000001000;    //                lw    $s4, 8($a0)
        InstructionReg[105] = 32'b10001100100101010000000000001100;    //                lw    $s5, 12($a0)
        InstructionReg[106] = 32'b00000010010101001011000000100010;    //                sub    $s6, $s2, $s4
        InstructionReg[107] = 32'b00000010011101011011100000100010;    //                sub    $s7, $s3, $s5
        InstructionReg[108] = 32'b00100000000010000000000000000000;    //                addi    $t0, $zero, 0
        InstructionReg[109] = 32'b00100000000010010000000000000000;    //                addi    $t1, $zero, 0
        InstructionReg[110] = 32'b00100000000010100000000000000000;    //                addi    $t2, $zero, 0
        InstructionReg[111] = 32'b00100000000010110000000000000000;    //                addi    $t3, $zero, 0
        InstructionReg[112] = 32'b00100000000011110000000000000000;    //                addi    $t7, $zero, 0
        InstructionReg[113] = 32'b00001100000000000000000010100110;    //                jal    SAD
        InstructionReg[114] = 32'b00000010000000001000100000100000;    //                add    $s1, $s0, $zero
        InstructionReg[115] = 32'b00000001001000000001000000100000;    //                add    $v0, $t1, $zero
        InstructionReg[116] = 32'b00000001000000000001100000100000;    //                add    $v1, $t0, $zero
        InstructionReg[117] = 32'b00000001000101100110000000100010;    //                sub    $t4, $t0, $s6
        InstructionReg[118] = 32'b00000001001101110101000000100010;    //                sub    $t2, $t1, $s7
        InstructionReg[119] = 32'b00000001100010100110000000100101;    //                or    $t4, $t4, $t2
        InstructionReg[120] = 32'b00010001100000000000000000101010;    //                beq    $t4, $zero, done
        InstructionReg[121] = 32'b00010001000000000000000000000111;    //    main_loop:        beq    $t0, $zero, top_or_right
        InstructionReg[122] = 32'b00010001001101110000000000000110;    //                beq    $t1, $s7, top_or_right
        InstructionReg[123] = 32'b00010001001000000000000000001111;    //                beq    $t1, $zero, bottom_or_left
        InstructionReg[124] = 32'b00010001000101100000000000001110;    //                beq    $t0, $s6, bottom_or_left
        InstructionReg[125] = 32'b00010001111000000000000000010111;    //                beq    $t7, $zero, middle_going_up
        InstructionReg[126] = 32'b00100001000010000000000000000001;    //                addi    $t0, $t0, 1
        InstructionReg[127] = 32'b00100001001010011111111111111111;    //                addi    $t1, $t1, -1
        InstructionReg[128] = 32'b00001000000000000000000010010111;    //                j    done_branching
        InstructionReg[129] = 32'b00010001111000000000000000000011;    //    top_or_right:        beq    $t7, $zero, window_going_up
        InstructionReg[130] = 32'b00100001000010000000000000000001;    //                addi    $t0, $t0, 1
        InstructionReg[131] = 32'b00100001001010011111111111111111;    //                addi    $t1, $t1, -1
        InstructionReg[132] = 32'b00001000000000000000000010010111;    //                j    done_branching
        InstructionReg[133] = 32'b00100001111011110000000000000001;    //    window_going_up:    addi    $t7, $t7, 1
        InstructionReg[134] = 32'b00010001001101110000000000000010;    //                beq    $t1, $s7, window_at_right
        InstructionReg[135] = 32'b00100001001010010000000000000001;    //                addi    $t1, $t1, 1
        InstructionReg[136] = 32'b00001000000000000000000010010111;    //                j    done_branching
        InstructionReg[137] = 32'b00100001000010000000000000000001;    //    window_at_right:    addi    $t0, $t0, 1
        InstructionReg[138] = 32'b00001000000000000000000010010111;    //                j    done_branching
        InstructionReg[139] = 32'b00010101111000000000000000000011;    //    bottom_or_left:        bne    $t7, $zero, window_going_down
        InstructionReg[140] = 32'b00100001001010010000000000000001;    //                addi    $t1, $t1, 1
        InstructionReg[141] = 32'b00100001000010001111111111111111;    //                addi    $t0, $t0, -1
        InstructionReg[142] = 32'b00001000000000000000000010010111;    //                j    done_branching
        InstructionReg[143] = 32'b00100001111011111111111111111111;    //    window_going_down:    addi    $t7, $t7, -1
        InstructionReg[144] = 32'b00010001000101100000000000000010;    //                beq    $t0, $s6, window_on_bottom
        InstructionReg[145] = 32'b00100001000010000000000000000001;    //                addi    $t0, $t0, 1
        InstructionReg[146] = 32'b00001000000000000000000010010111;    //                j    done_branching
        InstructionReg[147] = 32'b00100001001010010000000000000001;    //    window_on_bottom:    addi    $t1, $t1, 1
        InstructionReg[148] = 32'b00001000000000000000000010010111;    //                j    done_branching
        InstructionReg[149] = 32'b00100001001010010000000000000001;    //    middle_going_up:    addi    $t1, $t1, 1
        InstructionReg[150] = 32'b00100001000010001111111111111111;    //                addi    $t0, $t0, -1
        InstructionReg[151] = 32'b00100000000100000000000000000000;    //    done_branching:        addi    $s0, $zero, 0
        InstructionReg[152] = 32'b00001100000000000000000010100110;    //                jal    SAD
        InstructionReg[153] = 32'b00010010001100000000000000000010;    //                beq    $s1, $s0, equal_to
        InstructionReg[154] = 32'b00000010000100011100100000101010;    //                slt    $t9, $s0, $s1
        InstructionReg[155] = 32'b00010011001000000000000000000011;    //                beq    $t9, $zero, no_new_SAD
        InstructionReg[156] = 32'b00000010000000001000100000100000;    //    equal_to:        add    $s1, $s0, $zero
        InstructionReg[157] = 32'b00000001000000000001000000100000;    //                add    $v0, $t0, $zero
        InstructionReg[158] = 32'b00000001001000000001100000100000;    //                add    $v1, $t1, $zero
        InstructionReg[159] = 32'b00000001000101101100100000101010;    //    no_new_SAD:        slt    $t9, $t0, $s6
        InstructionReg[160] = 32'b00010111001000001111111111011000;    //                bne    $t9, $zero, main_loop  (1111111111011010 -> 1111111111011000)
        InstructionReg[161] = 32'b00000001001101111100100000101010;    //                slt    $t9, $t1, $s7
        InstructionReg[162] = 32'b00010111001000001111111111011000;    //                bne    $t9, $zero, main_loop NEED TO ADJUST BY -4
        InstructionReg[163] = 32'b10001111101111110000000000000000;    //    done:            lw    $ra, 0($sp)
        InstructionReg[164] = 32'b00100011101111010000000000000100;    //                addi    $sp, $sp, 4
        InstructionReg[165] = 32'b00000011111000000000000000001000;    //                jr    $ra
        InstructionReg[166] = 32'b00100000000010100000000000000000;    //    SAD:            addi    $t2, $zero, 0
        InstructionReg[167] = 32'b00100000000010110000000000000000;    //    first_loop:        addi    $t3, $zero, 0
        InstructionReg[168] = 32'b00000001000010100110000000100000;    //    second_loop:        add    $t4, $t0, $t2
        InstructionReg[169] = 32'b01110001100100110110000000000010;    //                mul    $t4, $t4, $s3
        InstructionReg[170] = 32'b00000001100010010110000000100000;    //                add    $t4, $t4, $t1
        InstructionReg[171] = 32'b00000001100010110110000000100000;    //                add    $t4, $t4, $t3
        InstructionReg[172] = 32'b00000000000011000110000010000000;    //                sll    $t4, $t4, 2
        InstructionReg[173] = 32'b00000001100001010110000000100000;    //                add    $t4, $t4, $a1
        InstructionReg[174] = 32'b10001101100011000000000000000000;    //                lw    $t4, 0($t4)
        InstructionReg[175] = 32'b01110010101010100110100000000010;    //                mul    $t5, $s5, $t2
        InstructionReg[176] = 32'b00000001101010110110100000100000;    //                add    $t5, $t5, $t3
        InstructionReg[177] = 32'b00000000000011010110100010000000;    //                sll    $t5, $t5, 2
        InstructionReg[178] = 32'b00000001101001100110100000100000;    //                add    $t5, $t5, $a2
        InstructionReg[179] = 32'b10001101101011010000000000000000;    //                lw    $t5, 0($t5)
        InstructionReg[180] = 32'b00000001100011010110000000100010;    //                sub    $t4, $t4, $t5
        InstructionReg[181] = 32'b00000001100000000110100000101010;    //                slt    $t5, $t4, $zero
        InstructionReg[182] = 32'b00010001101000000000000000000001;    //                beq    $t5, $zero, SKIP
        InstructionReg[183] = 32'b00000000000011000110000000100010;    //                sub    $t4, $zero, $t4
        InstructionReg[184] = 32'b00000010000011001000000000100000;    //    SKIP:            add    $s0, $s0, $t4
        InstructionReg[185] = 32'b00100001011010110000000000000001;    //                addi    $t3, $t3, 1
        InstructionReg[186] = 32'b00000001011101010110000000101010;    //                slt    $t4, $t3, $s5
        InstructionReg[187] = 32'b00010101100000001111111111101100;    //                bne    $t4, $zero, second_loop (1111111111101110 -> 1111111111101100)
        InstructionReg[188] = 32'b00100001010010100000000000000001;    //                addi    $t2, $t2, 1
        InstructionReg[189] = 32'b00000001010101000110000000101010;    //                slt    $t4, $t2, $s4
        InstructionReg[190] = 32'b00010101100000001111111111101000;    //                bne    $t4, $zero, first_loop  (1111111111101010 -> 1111111111101000)
        InstructionReg[191] = 32'b00000011111000000000000000001000;    //                jr    $ra*/


    end
 
    
    always@(Address) begin
        Instruction <= InstructionReg[Address >> 2];
    end

endmodule

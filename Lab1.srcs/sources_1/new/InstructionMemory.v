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
        InstructionReg[191] = 32'b00000011111000000000000000001000;    //                jr    $ra


        //InstructionReg[0] <= 32'b00100000000100010000000000001010; // addi    $s1, $zero, 10
        //InstructionReg[1] <= 32'b00100000000100100000000000001011; // addi    $s2, $zero, 11
        //InstructionReg[2] <= 32'b00100000000100110000000000001100; // addi    $s3, $zero, 12
        //InstructionReg[3] <= 32'b00100000000101000000000000001101; // addi    $s4, $zero, 13
        /*InstructionReg[0] = 32'h34040000;	//	main:		ori	$a0, $zero, 0
        InstructionReg[1] = 32'h08000004;    //            j    start
        InstructionReg[2] = 32'h2004000a;    //            addi    $a0, $zero, 10
        InstructionReg[3] = 32'h2004000a;    //            addi    $a0, $zero, 10
        InstructionReg[4] = 32'h8c900004;    //    start:        lw    $s0, 4($a0)
        InstructionReg[5] = 32'h8c900008;    //            lw    $s0, 8($a0)
        InstructionReg[6] = 32'hac900000;    //            sw    $s0, 0($a0)
        InstructionReg[7] = 32'hac90000c;    //            sw    $s0, 12($a0)
        InstructionReg[8] = 32'h8c910000;    //            lw    $s1, 0($a0)
        InstructionReg[9] = 32'h8c92000c;    //            lw    $s2, 12($a0)
        InstructionReg[10] = 32'h12000003;    //            beq    $s0, $zero, branch1
        InstructionReg[11] = 32'h02008820;    //            add    $s1, $s0, $zero
        InstructionReg[12] = 32'h12110001;    //            beq    $s0, $s1, branch1
        InstructionReg[13] = 32'h08000037;    //            j    error
        InstructionReg[14] = 32'h2010ffff;    //    branch1:    addi    $s0, $zero, -1
        InstructionReg[15] = 32'h0601fff4;    //            bgez    $s0, start
        InstructionReg[16] = 32'h22100001;    //            addi    $s0, $s0, 1
        InstructionReg[17] = 32'h06010001;    //            bgez    $s0, branch2
        InstructionReg[18] = 32'h08000037;    //            j    error
        InstructionReg[19] = 32'h2010ffff;    //    branch2:    addi    $s0, $zero, -1
        InstructionReg[20] = 32'h1E000005;    //            bgtz    $s0, branch3
        InstructionReg[21] = 32'h20100001;    //            addi    $s0, $zero, 1
        InstructionReg[22] = 32'h20100001;    //            addi    $s0, $zero, 1
        InstructionReg[23] = 32'h20100001;    //            addi    $s0, $zero, 1
        InstructionReg[24] = 32'h1E000001;    //            bgtz    $s0, branch3
        InstructionReg[25] = 32'h08000037;    //            j    error
        InstructionReg[26] = 32'h06000003;    //    branch3:    bltz    $s0, branch4
        InstructionReg[27] = 32'h2010ffff;    //            addi    $s0, $zero, -1
        InstructionReg[28] = 32'h06000001;    //            bltz    $s0, branch4
        InstructionReg[29] = 32'h08000037;    //            j    error
        InstructionReg[30] = 32'h2011ffff;    //    branch4:    addi    $s1, $zero, -1
        InstructionReg[31] = 32'h16110002;    //            bne    $s0, $s1, branch5
        InstructionReg[32] = 32'h16000001;    //            bne    $s0, $zero, branch5
        InstructionReg[33] = 32'h08000037;    //            j    error
        InstructionReg[34] = 32'h20100080;    //    branch5:    addi    $s0, $zero, 128
        InstructionReg[35] = 32'ha0900000;    //            sb    $s0, 0($a0)
        InstructionReg[36] = 32'h80900000;    //            lb    $s0, 0($a0)
        InstructionReg[37] = 32'h1a000001;    //            blez    $s0, branch6
        InstructionReg[38] = 32'h08000037;    //            j    error
        InstructionReg[39] = 32'h2010ffff;    //    branch6:    addi    $s0, $zero, -1
        InstructionReg[40] = 32'ha4900000;    //            sh    $s0, 0($a0)
        InstructionReg[41] = 32'h20100000;    //            addi    $s0, $zero, 0
        InstructionReg[42] = 32'h84900000;    //            lh    $s0, 0($a0)
        InstructionReg[43] = 32'h1a000001;    //            blez    $s0, branch7
        InstructionReg[44] = 32'h08000037;    //            j    error
        InstructionReg[45] = 32'h2010ffff;    //    branch7:    addi    $s0, $zero, -1
        InstructionReg[46] = 32'h3c100001;    //            lui    $s0, 1
        InstructionReg[47] = 32'h06010001;    //            bgez    $s0, branch8
        InstructionReg[48] = 32'h08000037;    //            j    error
        InstructionReg[49] = 32'h08000033;    //    branch8:    j    jump1
        InstructionReg[50] = 32'h2210fffe;    //            addi    $s0, $s0, -2
        InstructionReg[51] = 32'h0c000035;    //    jump1:        jal    jal1
        InstructionReg[52] = 32'h08000004;    //            j    start
        InstructionReg[53] = 32'h03e00008;    //    jal1:        jr    $ra
        InstructionReg[54] = 32'h08000037;    //            j    error
        InstructionReg[55] = 32'h00000008;    //    error:        jr    $zero
        InstructionReg[56] = 32'h3402000a;    //            ori    $v0, $zero, 10
        InstructionReg[57] = 32'h00000000;    //            nop*/


        /*InstructionReg[0] <= 32'b00110100000001000000000000000000; //->	main:		ori	$a0, $zero, 0
        InstructionReg[1] <= 32'b00001000000000000000000000000100; //->            j    start
        InstructionReg[2] <= 32'b00100000000001000000000000001010; //->            addi    $a0, $zero, 10
        InstructionReg[3] <= 32'b00100000000001000000000000001010; //->            addi    $a0, $zero, 10
        InstructionReg[4] <= 32'b10001100100100000000000000000100; //->    start:        lw    $s0, 4($a0)
        InstructionReg[5] <= 32'b10001100100100000000000000001000; //->            lw    $s0, 8($a0)
        InstructionReg[6] <= 32'b10101100100100000000000000000000; //->            sw    $s0, 0($a0)
        InstructionReg[7] <= 32'b10101100100100000000000000001100; //->            sw    $s0, 12($a0)
        InstructionReg[8] <= 32'b10001100100100010000000000000000; //->            lw    $s1, 0($a0)
        InstructionReg[9] <= 32'b10001100100100100000000000001100; //->            lw    $s2, 12($a0)
        InstructionReg[10] <= 32'b00010010000000000000000000000011; //->            beq    $s0, $zero, branch1
        InstructionReg[11] <= 32'b00000010000000001000100000100000; //->            add    $s1, $s0, $zero
        InstructionReg[12] <= 32'b00010010000100010000000000000001; //->            beq    $s0, $s1, branch1
        InstructionReg[13] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[14] <= 32'b00100000000100001111111111111111; //->    branch1:    addi    $s0, $zero, -1
        InstructionReg[15] <= 32'b00000110000000011111111111110110; //->            bgez    $s0, start
        InstructionReg[16] <= 32'b00100010000100000000000000000001; //->            addi    $s0, $s0, 1
        InstructionReg[17] <= 32'b00000110000000010000000000000001; //->            bgez    $s0, branch2
        InstructionReg[18] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[19] <= 32'b00100000000100001111111111111111; //->    branch2:    addi    $s0, $zero, -1
        InstructionReg[20] <= 32'b00011110000000000000000000000011; //->            bgtz    $s0, branch3
        InstructionReg[21] <= 32'b00100000000100000000000000000001; //->            addi    $s0, $zero, 1
        InstructionReg[22] <= 32'b00011110000000000000000000000001; //->            bgtz    $s0, branch3
        InstructionReg[23] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[24] <= 32'b00000110000000000000000000000011; //->    branch3:    bltz    $s0, branch4
        InstructionReg[25] <= 32'b00100000000100001111111111111111; //->            addi    $s0, $zero, -1
        InstructionReg[26] <= 32'b00000110000000000000000000000001; //->            bltz    $s0, branch4
        InstructionReg[27] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[28] <= 32'b00100000000100011111111111111111; //->    branch4:    addi    $s1, $zero, -1
        InstructionReg[29] <= 32'b00010110000100010000000000000010; //->            bne    $s0, $s1, branch5
        InstructionReg[30] <= 32'b00010110000000000000000000000001; //->            bne    $s0, $zero, branch5
        InstructionReg[31] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[32] <= 32'b00100000000100000000000010000000; //->    branch5:    addi    $s0, $zero, 128
        InstructionReg[33] <= 32'b10100000100100000000000000000000; //->            sb    $s0, 0($a0)
        InstructionReg[34] <= 32'b10000000100100000000000000000000; //->            lb    $s0, 0($a0)
        InstructionReg[35] <= 32'b00011010000000000000000000000001; //->            blez    $s0, branch6
        InstructionReg[36] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[37] <= 32'b00100000000100001111111111111111; //->    branch6:    addi    $s0, $zero, -1
        InstructionReg[38] <= 32'b10100100100100000000000000000000; //->            sh    $s0, 0($a0)
        InstructionReg[39] <= 32'b00100000000100000000000000000000; //->            addi    $s0, $zero, 0
        InstructionReg[40] <= 32'b10000100100100000000000000000000; //->            lh    $s0, 0($a0)
        InstructionReg[41] <= 32'b00011010000000000000000000000001; //->            blez    $s0, branch7
        InstructionReg[42] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[43] <= 32'b00100000000100001111111111111111; //->    branch7:    addi    $s0, $zero, -1
        InstructionReg[44] <= 32'b00111100000100000000000000000001; //->            lui    $s0, 1
        InstructionReg[45] <= 32'b00000110000000010000000000000001; //->            bgez    $s0, branch8
        InstructionReg[46] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[47] <= 32'b00001000000000000000000000110001; //->    branch8:    j    jump1
        InstructionReg[48] <= 32'b00100010000100001111111111111110; //->            addi    $s0, $s0, -2
        InstructionReg[49] <= 32'b00001100000000000000000000110011; //->    jump1:        jal    jal1
        InstructionReg[50] <= 32'b00001000000000000000000000000100; //->            j    start
        InstructionReg[51] <= 32'b00000011111000000000000000001000; //->    jal1:        jr    $ra
        InstructionReg[52] <= 32'b00001000000000000000000000110101; //->            j    error
        InstructionReg[53] <= 32'b00000000000000000000000000001000; //->    error:        jr    $zero
        InstructionReg[54] <= 32'b00110100000000100000000000001010;*/ //->            ori    $v0, $zero, 10


        /*
        InstructionReg[0] <= 32'b00100000000010000000000000001001;  // main:	addi	$t0, $zero, 9
        //InstructionReg[1] <= 32'b00111100000010010000000000000001;  // lui	$t1, 1
        InstructionReg[1] <= 32'b00100000000010010000000000001001;  // addi    $t1, $zero, 9
        InstructionReg[2] <= 32'b00100000000100000000000000000111;  // addi    $s0, $zero, 7
        InstructionReg[3] <= 32'b00010001000010010000000000000001;  // beq    $t0, $t1, move
        InstructionReg[4] <= 32'b00100000000010100000000000001010;  // addi    $t2, $zero, 10  if t2 == 10 then failed
        InstructionReg[5] <= 32'b00100000000010110000000000001001;  // move:    addi    $t3, $zero, 9
        InstructionReg[6] <= 32'b00100000000011001111111111111011;  // addi    $t4, $zero, -5
        InstructionReg[7] <= 32'b00010010000010001111111111111111;  // beq    $s0, $t0, move
        InstructionReg[8] <= 32'b00010110000010000000000000000001;  // bne    $s0, $t0, move2
        InstructionReg[9] <= 32'b00100000000100010000000000010101;  // addi    $s1, $zero, 21  if s1 == 21 then failed, s2 == 21 if worked
        InstructionReg[10] <= 32'b00100000000100100000000000010101; // move2:    addi    $s2, $zero, 21
        InstructionReg[11] <= 32'b00000101100000010000000000000010; // bgez    $t4, move3
        InstructionReg[12] <= 32'b00000100000000010000000000000001; // bgez    $zero, move3
        InstructionReg[13] <= 32'b00100000000010001111111111111101; // addi    $t0, $zero, -3
        InstructionReg[14] <= 32'b00000000000000000000100000101010; // move3:    slt    $at, $zero, $zero
        InstructionReg[15] <= 32'b00010100001000000000000000000011; // bne    $at, $zero, move4
        InstructionReg[16] <= 32'b00000000000010010000100000101010; // slt    $at, $zero, $t1
        InstructionReg[17] <= 32'b00010100001000000000000000000001; // bne    $at, $zero, move4
        InstructionReg[18] <= 32'b00100000000010001111111111111100; // addi    $t0, $zero, -4
        InstructionReg[19] <= 32'b00011001001000000000000000000010; // move4:    blez    $t1, move5
        InstructionReg[20] <= 32'b00011000000000000000000000000001; // blez    $zero, move5
        InstructionReg[21] <= 32'b00100000000010001111111111111011; // addi    $t0, $zero, -5
        InstructionReg[22] <= 32'b00000100000000000000000000000010; // move5:    bltz    $zero, move6
        InstructionReg[23] <= 32'b00000101100000000000000000000001; // bltz    $t4, move6
        InstructionReg[24] <= 32'b00100000000010001111111111111010; // addi    $t0, $zero, -6
        InstructionReg[25] <= 32'b00100000000011010000000001100100; // move6:    addi    $t5, $zero, 100
        InstructionReg[26] <= 32'b00001000000000000000000000011110; // j	jumpthang
        InstructionReg[27] <= 32'b00100000000100111111111110010010; // addi    $s3, $zero, -110
        InstructionReg[28] <= 32'b00100000000101001111111110010001; // addi    $s4, $zero, -111
        InstructionReg[29] <= 32'b00100000000101011111111110010000; // addi    $s5, $zero, -112
        InstructionReg[30] <= 32'b00100000000101101111111110001111; // jumpthang:    addi    $s6, $zero, -113
        InstructionReg[31] <= 32'b00111100000010010000000000000001;  // lui	$t1, 1
        InstructionReg[32] <= 32'b10101100000010000000000000011000; // sw $t1 24($zero)
        InstructionReg[33] <= 32'b10100000000011000000000000011101; // sb $t4 29($zero)
        InstructionReg[34] <= 32'b10100100000011000000000000100010; // sh $t4 34($zero)
        InstructionReg[35] <= 32'b10001100000011100000000000011000; // lw $t6 24($zero)
        InstructionReg[36] <= 32'b10000000000011110000000000011101; // lb $t7 29($zero) 
        InstructionReg[37] <= 32'b10000100000011010000000000100010; // lh $t5 34($zero)
        //InstructionReg[38] <= 32'b0;
        InstructionReg[38] <= 32'b00000000000011010100000000100000; // add $t0, $zero, $t5*/
        /*InstructionReg[0] = 32'b00100000000100000000000000000001;
        InstructionReg[1] = 32'b00100000000100010000000000000001;
        InstructionReg[2] = 32'b00000010000100011000000000100100;
        InstructionReg[3] = 32'b00000010000000001000000000100100;
        InstructionReg[4] = 32'b00000010001100001000000000100010;
        InstructionReg[5] = 32'b00000010000000001000000000100111;
        InstructionReg[6] = 32'b00000010000000001000000000100111;
        InstructionReg[7] = 32'b00000000000000001000000000100101;
        InstructionReg[8] = 32'b00000010001000001000000000100101;
        InstructionReg[9] = 32'b00000000000100001000000010000000;
        InstructionReg[10] = 32'b00000010001100001000000000000100;
        InstructionReg[11] = 32'b00000010000000001000000000101010;
        InstructionReg[12] = 32'b00000010000100011000000000101010;
        InstructionReg[13] = 32'b00000000000100011000000001000011;
        InstructionReg[14] = 32'b00000000000100011000000000000111;
        InstructionReg[15] = 32'b00000000000100011000000001000010;
        InstructionReg[16] = 32'b00000000000100011000000011000000;
        InstructionReg[17] = 32'b00000000000100001000000011000010;
        InstructionReg[18] = 32'b00000010001100001000000000000100;
        InstructionReg[19] = 32'b00000010001100001000000000000110;
        InstructionReg[20] = 32'b00000010000100011000000000100110;
        InstructionReg[21] = 32'b00000010000100011000000000100110;
        InstructionReg[22] = 32'b00100000000100100000000000000100;
        InstructionReg[23] = 32'b01110010000100101000000000000010;
        InstructionReg[24] = 32'b00100010000100000000000000000100;
        InstructionReg[25] = 32'b00110010000100000000000000000000;
        InstructionReg[26] = 32'b00110110000100000000000000000001;
        InstructionReg[27] = 32'b00101010000100000000000000000000;
        InstructionReg[28] = 32'b00101010000100000000000000000001;
        InstructionReg[29] = 32'b00111010000100000000000000000001;
        InstructionReg[30] = 32'b00111010000100000000000000000001;
        InstructionReg[31] = 32'b00100000000100001111111111111110;
        InstructionReg[32] = 32'b00100000000100010000000000000010;
        InstructionReg[33] = 32'b00000010001100001001000000101011;
        InstructionReg[34] = 32'b00101110001100001111111111111110;
        InstructionReg[35] = 32'b00000010001000001000000000001010;
        InstructionReg[36] = 32'b00000000000100011000000000001011;
        InstructionReg[37] = 32'b00000010001100101000000000100000;
        InstructionReg[38] = 32'b00100000000100001111111111111110;
        InstructionReg[39] = 32'b00000010001100001000100000100001;
        InstructionReg[40] = 32'b00100100000100011111111111111111;
        InstructionReg[41] = 32'b00100000000100100000000000100000;
        InstructionReg[42] = 32'b00000010001100100000000000011000;
        InstructionReg[43] = 32'b00000000000000001010000000010000;
        InstructionReg[44] = 32'b00000000000000001010100000010010;
        InstructionReg[45] = 32'b00000010001100100000000000011001;
        InstructionReg[46] = 32'b00000000000000001010000000010000;
        InstructionReg[47] = 32'b00000000000000001010100000010010;
        InstructionReg[48] = 32'b01110010001100100000000000000000;
        InstructionReg[49] = 32'b00000000000000001010000000010000;
        InstructionReg[50] = 32'b00000000000000001010100000010010;
        InstructionReg[51] = 32'b00000010010000000000000000010001;
        InstructionReg[52] = 32'b00000010001000000000000000010011;
        InstructionReg[53] = 32'b00000000000000001010000000010000;
        InstructionReg[54] = 32'b00000000000000001010100000010010;
        InstructionReg[55] = 32'b00110010001100011111111111111111;
        InstructionReg[56] = 32'b01110010100100100000000000000100;
        InstructionReg[57] = 32'b00000000000000001010000000010000;
        InstructionReg[58] = 32'b00000000000000001010100000010010;
        InstructionReg[59] = 32'b00100000000100100000000000000001;
        InstructionReg[60] = 32'b00000000001100101000111111000010;
        InstructionReg[61] = 32'b00100000000101000000000000011111;
        InstructionReg[62] = 32'b00000010100100011000100001000110;
        InstructionReg[63] = 32'b00110100000100010000111111110000;
        InstructionReg[64] = 32'b01111100000100011010010000100000;
        InstructionReg[65] = 32'b01111100000100011010011000100000;*/

        //InstructionReg[0] = 32'b00100000000010000000000000000110; // addi $t0, $zero, 6
        //InstructionReg[1] = 32'b00100000000010010000000000000111; // addi $t1, $zero, 7
        //InstructionReg[2] = 32'b00000001000010010101000000100000; // add $t2, $t0, $t1
        //InstructionReg[3] = 32'b00000001010010010101100000100010; // sub $t3, $t2, $t1
        //InstructionReg[4] = 32'd0;
        //InstructionReg[5] = 32'd0;
        //InstructionReg[6] = 32'd0;
        //InstructionReg[4] = 32'b01110001011010010110000000000010; // mul $t4, $t3, $t1
        /*InstructionReg[8] = 32'b00000001010010110110100000100100; // and $t5, $t2, $t3
        InstructionReg[9] = 32'b00110001001011100000000000101010; // andi $t6, $t1, 42
        InstructionReg[10] = 32'b00110101011011110000000000001100; // ori $t7, $t3, 12
        InstructionReg[11] = 32'b00000001100010011000000000100101; // or $s0, $t4, $t1
        InstructionReg[12] = 32'b00000001011011001000100000100111; //nor $s1, $t3, $t4
        InstructionReg[13] = 32'b00000001010010001001000000100110; // xor $s2, $t2, $t0
        InstructionReg[14] = 32'b00111001100100110000000000001010; // xori $s3, $t4, 10
        InstructionReg[15] = 32'b00000001011011101010000000101010; // slt $s4, $t3, $t6
        InstructionReg[16] = 32'b00000001001010001010000000101010; // slt $s4, $t1, $t0
        InstructionReg[17] = 32'b00101001100101010000000000101011; // slti $s5, $t4, 43
        InstructionReg[18] = 32'b00101001110101010000000000000001; // slti $s5, $t6, 1
        InstructionReg[19] = 32'b00000001000010011011000000100001; // addu $s6, $t0, $t1
        InstructionReg[20] = 32'b00100101010101100000000000000111; // addiu $s6, $t2, 7
        InstructionReg[21] = 32'b00000001000011011011100001000110; // rotrv $s7, $t5, $t0
        InstructionReg[22] = 32'b00000000000100101001000010000000; // sll $s2, $s2, 2
        InstructionReg[23] = 32'b00000000000011010110100010000010; // srl $t5, $t5, 2
        InstructionReg[24] = 32'b00000000001011001011100111000010; // rotr $s7, $t4, 7
        InstructionReg[25] = 32'b00000001000010010000000000011000; // mult $t0, $t1
        InstructionReg[26] = 32'b00000001001010100000000000011001; // multu	$t1, $t2
        InstructionReg[27] = 32'b00101001001010001111111111111110; // slti $t0, $t1, -2
        InstructionReg[28] = 32'b00000001100010110100100000101011; // sltu $t1, $t4, $t3
        InstructionReg[29] = 32'b00101101100010011111111111111110; // sltiu $t1, $t4, -2
        InstructionReg[30] = 32'b01111100000100000101011000100000; //seh $t2, $s0
        InstructionReg[31] = 32'b01111100000100010101011000100000; //seh $t2, $s1
        InstructionReg[32] = 32'b01111100000101110101110000100000; //seb $t3, $s7
        InstructionReg[33] = 32'b00000010110010110110000000001010; // movz $t4, $s6, $t3
        InstructionReg[34] = 32'b00000010111000000110100000001010; // movz $t5, $s7, $zero
        InstructionReg[35] = 32'b00000010111010110110000000001011; // movn $t4, $s7, $t3
        InstructionReg[36] = 32'b00000010110000000110100000001011; // movn $t5, $s6, $zero
        InstructionReg[34] = 32'b01110001110100110000000000000000; // madd $t6, $s3
        InstructionReg[35] = 32'b01110001110100110000000000000100; // msub $t6, $s3*/

    end
 
    
    always@(Address) begin
        Instruction <= InstructionReg[Address >> 2];
    end

endmodule

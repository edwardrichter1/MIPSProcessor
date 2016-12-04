`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members:
// Overall percent effort of each team meber: 
// Eddie Richter: 
// Hugo Valdez: 
// 
// ECE369 - Computer Architecture
// Laboratory 3 (PostLab)
// Module - Controller.v
// Description - Controls the datapath of the MIPS processor.
// INPUTS:
//
// OUTPUTS:-
// FUNCTIONALITY:-
////////////////////////////////////////////////////////////////////////////////

module Controller(
        DataMem, 
        JumpReg, 
        JumpLink, 
        Shift16, 
        Jump, 
        BranchControlIn, 
        ForceZero, 
        Mov, 
        CmpSel, 
        Instruction, 
        Size, 
        RegDst, 
        RegWrite, 
        ALUSrc, 
        MemWrite, 
        MemRead,
        MemtoReg, 
        ALUControl, 
        SignExtendToReg,
        SADWrite
    );
    input[31:0] Instruction;
    output reg Mov, CmpSel, SignExtendToReg, Size, RegDst, 
    RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg, ForceZero, Jump, Shift16, JumpReg, JumpLink,
    SADWrite;
    output reg [1:0] DataMem;
    output reg [2:0] BranchControlIn;
    output reg[4:0] ALUControl;
    
    initial begin
        Jump <= 0;
        JumpReg <= 0;
        JumpLink <= 0;
        BranchControlIn <= 3'b000;
        RegWrite <= 0;       
    end
    
    always@(Instruction) begin // Datapath Controller
        RegWrite <= 0;
        DataMem <= 0;
        Jump <= 0;
        JumpReg <= 0;
        BranchControlIn <= 3'b000;
        ForceZero <= 0;
        JumpLink <= 0;
        if (Instruction == 32'd0) begin // nop
            Mov <= 0;
            RegWrite <= 0;
            MemWrite <= 0;
            MemRead <= 0;
            Jump <= 0;
            JumpReg <= 0;
            JumpLink <= 0;
            BranchControlIn <= 3'b000;
            MemtoReg <= 0;
        end
        else begin
            case(Instruction[31:26])
                6'b000000: begin
                                RegDst <= 1;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                BranchControlIn <= 3'd0;
                                ForceZero <= 0;
                                ALUSrc <= 0;
                                Mov <= 0;
                                MemtoReg <= 0;
                                RegWrite <= 1;
                                MemRead <= 0;
                                MemWrite <= 0;
                                SignExtendToReg <= 0;
                                SADWrite <= 0;
                                case(Instruction[5:0])
                                   6'b100000: ALUControl <= 5'b00000; // Add
                                   6'b100001: ALUControl <= 5'b00000; // Addu
                                   6'b100010: ALUControl <= 5'b00001; // Sub
                                   6'b100100: ALUControl <= 5'b00110; // And
                                   6'b100101: ALUControl <= 5'b00111; // Or
                                   6'b100111: ALUControl <= 5'b01000; // Nor
                                   6'b100110: ALUControl <= 5'b01001; // Xor
                                   6'b101010: ALUControl <= 5'b00101; // Slt
                                   6'b101011: ALUControl <= 5'b01111; // Sltu
                                   6'b000000: ALUControl <= 5'b01011; // Sll
                                   6'b000100: ALUControl <= 5'b00011; // Sllv
                                   6'b000011: ALUControl <= 5'b01110; // Sra
                                   6'b000111: ALUControl <= 5'b10000; // Srav
                                   6'b001010: begin  // Movz
                                                    ALUControl <= 5'b01011;
                                                    RegWrite <= 0;
                                                    Mov <= 1;
                                                    CmpSel <= 0;
                                              end
                                   6'b001011: begin // Movn
                                                    ALUControl <= 5'b01011;
                                                    RegWrite <= 0;
                                                    Mov <= 1;
                                                    CmpSel <= 1;
                                            end
                                   6'b000010: begin 
                                                    if (Instruction[21] == 1'b0)
                                                        ALUControl <= 5'b01100; // Srl
                                                    else
                                                        ALUControl <= 5'b01101; // Rotr
                                              end
                                   6'b000110: begin
                                                    if (Instruction[6] == 1'b1)
                                                        ALUControl <= 5'b01010; // Rotrv
                                                    else
                                                        ALUControl <= 5'b00100;
                                              end
                                   6'b001000: begin // jr
                                                    RegWrite <= 0;
                                                    JumpReg <= 1;
                                              end
                                   6'b010000: begin // SAD
                                                    RegDst <= 0;
                                                    JumpReg <= 0;
                                                    JumpLink <= 0;
                                                    Shift16 <= 0;
                                                    Jump <= 0;
                                                    ForceZero <= 0;
                                                    BranchControlIn <= 3'd0;
                                                    ALUSrc <= 1;
                                                    MemtoReg <= 0;
                                                    Mov <= 0;
                                                    RegWrite <= 1;
                                                    MemRead <= 0;
                                                    MemWrite <= 0;
                                                    SignExtendToReg <= 0;
                                                    ALUControl <= 5'b00000;
                                                    SADWrite <= 1;
                                              end  
                                endcase
                           end
                6'b001000: begin // Addi
                                RegDst <= 0;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'd0;
                                ALUSrc <= 1;
                                MemtoReg <= 0;
                                Mov <= 0;
                                RegWrite <= 1;
                                MemRead <= 0;
                                MemWrite <= 0;
                                SignExtendToReg <= 0;
                                ALUControl <= 5'b00000;
                           end
                6'b001001: begin // Addiu
                                RegDst <= 0;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'd0;
                                ALUSrc <= 1;
                                MemtoReg <= 0;
                                RegWrite <= 1;
                                MemRead <= 0;
                                Mov <= 0;
                                MemWrite <= 0;
                                SignExtendToReg <= 0;
                                ALUControl <= 5'b00000;
                           end 
                6'b011100: begin // Mul
                                RegDst <= 1;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'd0;
                                ALUSrc <= 0;
                                MemtoReg <= 0;
                                RegWrite <= 1;
                                MemRead <= 0;
                                MemWrite <= 0;
                                Mov <= 0;
                                SignExtendToReg <= 0;                          
                                ALUControl <= 5'b00010;
                          end
               6'b001100: begin // Andi
                                RegDst <= 0;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 1;
                                ALUSrc <= 1;
                                MemtoReg <= 0;
                                RegWrite <= 1;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                BranchControlIn <= 3'd0;
                                SignExtendToReg <= 0;
                                ALUControl <= 5'b00110;
                          end
               6'b001101: begin // Ori
                                RegDst <= 0;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 1;
                                BranchControlIn <= 3'd0;
                                ALUSrc <= 1;
                                MemtoReg <= 0;
                                RegWrite <= 1;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                SignExtendToReg <= 0;
                                ALUControl <= 5'b00111;
                          end
               6'b001110: begin // xori
                                RegDst <= 0;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 1;
                                ALUSrc <= 1;
                                MemtoReg <= 0;
                                BranchControlIn <= 3'd0;
                                RegWrite <= 1;
                                MemRead <= 0;
                                Mov <= 0;
                                SignExtendToReg <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b01001;
                          end
               6'b001010: begin // slti
                                RegDst <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                SADWrite <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                ALUSrc <= 1;
                                MemtoReg <= 0;
                                RegWrite <= 1;
                                BranchControlIn <= 3'd0;
                                SignExtendToReg <= 0;
                                MemRead <= 0;
                                Mov <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b00101;
                          end
               6'b001011: begin // sltui
                                RegDst <= 0;
                                JumpReg <= 0;
                                SADWrite <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                ALUSrc <= 1;
                                MemtoReg <= 0;
                                BranchControlIn <= 3'd0;
                                RegWrite <= 1;
                                SignExtendToReg <= 0;
                                MemRead <= 0;
                                Mov <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b01111;
                        end
               6'b011111: begin // Seb and Seh
                                RegDst <= 1;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                SADWrite <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'd0;
                                RegWrite <= 1;
                                Mov <= 0;
                                SignExtendToReg <= 1;
                                MemRead <= 0;
                                MemWrite <= 0;
                                Size <= Instruction[9];
                          end
               6'b000100: begin // beq
                                RegDst <= 1;
                                JumpReg <= 0;
                                SADWrite <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'b001;
                                ALUSrc <= 0;
                                RegWrite <= 0;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b00001;
                          end
               6'b000101: begin // bne
                                RegDst <= 1;
                                JumpReg <= 0;
                                SADWrite <= 0;
                                JumpLink <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'b010;
                                ALUSrc <= 0;
                                RegWrite <= 0;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b00001;
                        end
             6'b000001: begin // bgez or bltz
                                RegDst <= 1;
                                Shift16 <= 0;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                if (Instruction[16] == 1) begin // bgez
                                    BranchControlIn <= 3'b011;
                                    end
                                else // bltz
                                    BranchControlIn <= 3'b110;
                                ALUSrc <= 0;
                                RegWrite <= 0;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b00001;
                        end
             6'b000110: begin // blez
                                RegDst <= 1;
                                Shift16 <= 0;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'b101;
                                ALUSrc <= 0;
                                RegWrite <= 0;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b00001;
                        end
             6'b000111: begin // bgtz
                                RegDst <= 1;
                                Shift16 <= 0;
                                JumpReg <= 0;
                                SADWrite <= 0;
                                JumpLink <= 0;
                                Jump <= 0;
                                ForceZero <= 0;
                                BranchControlIn <= 3'b100;
                                ALUSrc <= 0;
                                RegWrite <= 0;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b00001;
                        end
             6'b000010: begin // j
                                Jump <= 1;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                SADWrite <= 0;
                                Shift16 <= 0;
                                RegWrite <= 0;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                        end
             6'b001111: begin // lui
                                RegDst <= 0;
                                Shift16 <= 1;
                                SADWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 0;
                                Jump <= 0;
                                ForceZero <= 0;                            
                                BranchControlIn <= 3'd0;
                                ALUSrc <= 1;
                                RegWrite <= 1;
                                Mov <= 0;
                                MemRead <= 0;
                                MemWrite <= 0;
                                ALUControl <= 5'b00111;
                                MemtoReg <= 0;
                                SignExtendToReg <= 0;
                        end       
             6'b101011: begin //SW
                                RegDst <= 0;
                                ForceZero <= 0;
                                Shift16 <= 0;
                                SADWrite <= 0;
                                Jump <= 0;
                                BranchControlIn <= 3'd0;
                                ALUSrc <= 1;
                                Mov <= 0;
                                RegWrite <= 0;
                                MemRead <= 0;
                                MemWrite <= 1;
                                ALUControl <= 5'b00000;
                                DataMem <= 2'b00;
                                JumpReg <=0;
                                JumpLink <= 0;
                        end
             6'b100011: begin //LW
                                RegDst <= 0;
                                ForceZero <= 0;
                                ALUSrc <= 1;
                                SADWrite <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                BranchControlIn <= 3'd0;
                                Mov <= 0;
                                MemtoReg <= 1;
                                RegWrite <= 1;
                                MemRead <= 1;
                                MemWrite <= 0;
                                SignExtendToReg <= 0;
                                ALUControl <= 5'b00000;
                                DataMem <= 2'b00;
                                JumpReg <=0;
                                JumpLink <= 0;
                        end
             6'b100000: begin //LB
                                RegDst <= 0;
                                ForceZero <= 0;
                                Shift16 <= 0;
                                Jump <= 0;
                                SADWrite <= 0;
                                BranchControlIn <= 3'd0;
                                ALUSrc <= 1;
                                Mov <= 0;
                                MemtoReg <= 1;
                                RegWrite <= 1;
                                MemRead <= 1;
                                MemWrite <= 0;
                                SignExtendToReg <= 0;
                                ALUControl <= 5'b00000;
                                DataMem <= 2'b01;
                                JumpReg <=0;
                                JumpLink <= 0;
                        end
             6'b101000: begin //SB
                                RegDst <= 0;
                                ForceZero <= 0;
                                ALUSrc <= 1;
                                Mov <= 0;
                                Shift16 <= 0;
                                SADWrite <= 0;
                                Jump <= 0;
                                BranchControlIn <= 3'd0;
                                RegWrite <= 0;
                                MemRead <= 0;
                                MemWrite <= 1;
                                ALUControl <= 5'b00000;
                                DataMem <= 2'b01;
                                JumpReg <=0;
                                JumpLink <= 0;
                        end
             6'b100001: begin //lh
                                RegDst <= 0;
                                ForceZero <= 0;
                                ALUSrc <= 1;
                                Shift16 <= 0;
                                SADWrite <= 0;
                                Jump <= 0;
                                BranchControlIn <= 3'd0;
                                Mov <= 0;
                                MemtoReg <= 1;
                                RegWrite <= 1;
                                MemRead <= 1;
                                MemWrite <= 0;
                                SignExtendToReg <= 0;
                                ALUControl <= 5'b00000;
                                DataMem <= 2'b10;
                                JumpReg <=0;
                                JumpLink <= 0;
                        end
             6'b101001: begin //sh
                                RegDst <= 0;
                                ForceZero <= 0;
                                ALUSrc <= 1;
                                Mov <= 0;
                                Shift16 <= 0;
                                SADWrite <= 0;
                                Jump <= 0;
                                BranchControlIn <= 3'd0;                            
                                RegWrite <= 0;
                                MemRead <= 0;
                                MemWrite <= 1;
                                ALUControl <= 5'b00000;
                                DataMem <= 2'b10;
                                JumpReg <=0;
                                JumpLink <= 0;
                        end
             6'b000011: begin //jal
                                Mov <= 0;
                                Shift16 <= 0;
                                SADWrite <= 0;
                                Jump <= 0;
                                BranchControlIn <= 3'd0;
                                RegWrite <= 1;
                                MemWrite <= 0;
                                JumpReg <= 0;
                                JumpLink <= 1;
                        end
            endcase
        end
    end
    
endmodule

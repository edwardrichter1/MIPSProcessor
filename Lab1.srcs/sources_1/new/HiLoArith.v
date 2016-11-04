`timescale 1ns / 1ps
// op = 1 add
// op = 0 sub
module HiLoArith(A, B, outHi, outLo, op);
    input [63:0] A, B;
    input op;
    
    reg [63:0] temp;
    
    output reg[31:0] outHi, outLo;
    
    always@(*) begin
        if(op == 1)
            temp = A + B;
        else 
            temp = A - B;
        
        outHi <= temp[63:32];
        outLo <= temp[31:0];
    end
endmodule

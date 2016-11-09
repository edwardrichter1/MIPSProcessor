`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2016 11:54:19 AM
// Design Name: 
// Module Name: Adder32Bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Adder32Bit(A, B, C);
input [31:0] A, B;
output reg [31:0] C;
    always@(*)begin
        C <= A + B;
    end
    
endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
        
        #15
        Address = 32'd4;
        WriteData = 4;
        MemWrite = 1;
        #55 $display("ReadData=%h", ReadData);
        #5
        Address = 32'd8;
        WriteData = 8;
        #55  $display("ReadData=%h", ReadData);
        #5
        MemWrite = 0;
        Address = 32'd4;
        MemRead = 1;
        #20  $display("ReadData=%h", ReadData);
        #5
        Address = 32'd8;
        #20  $display("ReadData=%h", ReadData);        
	end

endmodule

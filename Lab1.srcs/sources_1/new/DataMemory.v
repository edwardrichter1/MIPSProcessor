`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, DataMem); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    input [1:0] DataMem;

    output reg[31:0] ReadData; // Contents of memory location at Address
    reg [31:0] memory [1023:0];
    
    initial begin
        memory[0] = 32'd0;
        memory[1] = 32'd1;
        memory[2] = 32'd2;
        memory[3] = 32'd3;
        memory[4] = 32'd4;
        memory[5] = -32'd1;
    end
    
    always@(posedge Clk) begin // write process
        case(DataMem)
            2'b00: begin
                        if (MemWrite == 1) begin
                            memory[Address[11:2]] <= WriteData;
                        end
                    end
            2'b01: begin //byte
                        if (MemWrite == 1) begin
                            //memory[Address[11:2]][17+:8] <= 8'b1111111;
                            memory[Address[11:2]][(Address[1:0]*8)+:8] <= WriteData[7:0];
                        end
                   end
            2'b10: begin //
                        if (MemWrite == 1)
                            memory[Address[11:2]][(Address[1:0]*8)+:16] <= WriteData[15:0];
                   end
        endcase
    end
    
          
    always@(MemRead, Address, DataMem) begin
        case(DataMem)
            2'b00: begin
                    if (MemRead == 1)
                        ReadData <= memory[Address[11:2]];
                    else
                        ReadData <= 32'b0;
                   end
            2'b01: begin
                        if (MemRead == 1) begin
                            ReadData = memory[Address[11:2]][(Address[1:0]*8)+:8];
                            if (ReadData[7] == 0)
                                ReadData <= {24'd0, ReadData[7:0]};
                            else
                                ReadData <= {24'd16777215, ReadData[7:0]};     
                        end
                        else
                            ReadData <= 32'b0;
                   end
            2'b10: begin
                       if (MemRead == 1) begin
                           ReadData = memory[Address[11:2]][(Address[1:0]*8)+:16];
                           if (ReadData[15] == 0)
                               ReadData <= {16'd0, ReadData[15:0]};
                           else
                               ReadData <= {16'd65535, ReadData[15:0]};     
                       end
                       else
                           ReadData <= 32'b0;
                   end
        endcase
    end

endmodule

`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
// Size = 0 Sign extend byte
// Size = 1 Sign extend half word
////////////////////////////////////////////////////////////////////////////////
module SignExtendRegister(in, out, Size);

    /* A 16-Bit input word */
    input [31:0] in;
    input Size;
    
    /* A 32-Bit output word */
    output[31:0] out;
    
    reg [31:0] out;
    
    always@(in, Size) begin
        if(Size == 1) begin
            if (in[15] == 0)
                out <= {16'b0, in[15:0]};
            else
                out <= {32'd65535, in[15:0]};
        end
        else begin
            if (in[7] == 0)
                out <= {24'b0, in[7:0]};
            else
                out <= {32'd16777215, in[7:0]};
        end
    end

endmodule

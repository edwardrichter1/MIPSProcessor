`timescale 1ns / 1ps

module ClkDiv(Clk, Rst, ClkOut);
    input Clk, Rst;
    output reg ClkOut;
    //parameter DivVal1 = 50,000,000; // 1 s
    parameter DivVal1 = 100000;// 5; // 100 MHz -> 10 MHz
    reg [25:0] DivCnt;
    reg ClkInt;
    
    //to create 1 Hz clock from 100-MHz on the board
    //always@(posedge rst) begin
        always @(posedge Clk) begin
            if( Rst == 1 )begin
                DivCnt <= 0;
                ClkOut <= 0;
                ClkInt <= 0;
            end
            else begin
                if( DivCnt >= DivVal1 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end   
      end 
endmodule

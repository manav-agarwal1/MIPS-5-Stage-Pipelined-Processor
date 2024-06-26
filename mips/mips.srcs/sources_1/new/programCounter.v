`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2022 05:19:58 PM
// Design Name: 
// Module Name: programCounter
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


module programCounter(
input PCWrite,
input   i_clk,
input [31:0] pcIn,
output reg [31:0] pcOut
    );

initial
   pcOut <= 32'b0; 
    
always @(posedge i_clk)
    if(PCWrite)
        pcOut <= pcIn;
endmodule

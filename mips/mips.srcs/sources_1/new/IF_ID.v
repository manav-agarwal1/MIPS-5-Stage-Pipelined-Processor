`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 22:50:18
// Design Name: 
// Module Name: IF_ID
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

`define nop 32'h000000
module IF_ID(
input IF_ID_Write,
input clk,
input [31:0] instruction,
input [31:0] pc,
input IF_Flush,
output reg [31:0] instructionOp,
output reg [31:0] pcOut
);
always @(posedge clk)
begin
    if(IF_Flush == 0 & IF_ID_Write)
        instructionOp <= instruction;
    else if(IF_Flush == 1 & IF_ID_Write)
        instructionOp <= `nop;
end
always @(posedge clk)
begin
    if(IF_Flush == 0 & IF_ID_Write)
        pcOut <= pc;
    else if(IF_Flush == 1 & IF_ID_Write)
        pcOut <= `nop;
end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 23:23:09
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
input clk,
input [9:0] Control,
input [31:0] alu,
input [31:0] wrtData,
input [4:0] RegWrtAdd,
output reg [9:0] controlop,
output reg [31:0] aluop,
output reg [31:0] wrtDataop,
output reg [4:0] RegWrtAddop
);
always @(posedge clk)
    controlop <= Control;
always @(posedge clk)
    aluop <= alu;
always @(posedge clk)
    wrtDataop <= wrtData;
always @(posedge clk)
    RegWrtAddop <= RegWrtAdd;
endmodule

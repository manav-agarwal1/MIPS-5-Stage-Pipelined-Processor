`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 23:40:50
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
input [31:0] rdData,
input [9:0] controls,
input [31:0] alu,
input [4:0] regWrtAdd,
input clk,
output reg [31:0] rdDataop,
output reg [9:0] controlsop,
output reg [31:0] aluop,
output reg [4:0] regWrtAddop
    );
always @(posedge clk)
    rdDataop <= rdData;
always @(posedge clk)
    controlsop <= controls;
always @(posedge clk)
    aluop <= alu;
always @(posedge clk)
    regWrtAddop <= regWrtAdd;
endmodule

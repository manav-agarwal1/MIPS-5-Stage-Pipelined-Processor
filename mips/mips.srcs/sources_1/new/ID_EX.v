`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 22:56:25
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
input clk,
input [9:0] control,
input [31:0] signExt,
input [31:0] rdData1,
input [31:0] rdData2,
input [4:0] IF_ID_RegisterRs,
input [4:0] IF_ID_RegisterRt,
input [4:0] IF_ID_RegisterRd,
output reg [9:0] controlop,
output reg [31:0] signExtop,
output reg [31:0] rdData1op,
output reg [31:0] rdData2op,
output reg [4:0] ID_EX_RegisterRs,
output reg [4:0] ID_EX_RegisterRt,
output reg [4:0] ID_EX_RegisterRd
  );
 always @(posedge clk)
    controlop <= control;
 always @(posedge clk)
    signExtop <= signExt;
// always @(posedge clk)
//    slicetsop <= slicets;
// always @(posedge clk)
//    slicefeop <= slicefe;
 always @(posedge clk)   
    rdData1op <= rdData1;
 always @(posedge clk)
    rdData2op <= rdData2;
 always @(posedge clk)
    ID_EX_RegisterRs <= IF_ID_RegisterRs;
 always @(posedge clk)
    ID_EX_RegisterRt <= IF_ID_RegisterRt;
 always @(posedge clk)
    ID_EX_RegisterRd <= IF_ID_RegisterRd;

endmodule

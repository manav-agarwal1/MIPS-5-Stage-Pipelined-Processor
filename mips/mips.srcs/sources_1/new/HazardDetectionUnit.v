`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2022 16:44:19
// Design Name: 
// Module Name: HazardDetectionUnit
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


module HazardDetectionUnit(
input [9:0] ID_EX_Control,
input [4:0] ID_EX_RegisterRt,
input [4:0] IF_ID_RegisterRs,
input [4:0] IF_ID_RegisterRt,
output reg ControlSrc,
output reg PCWrite,
output reg IF_ID_Write
);
// MemRead is ~MemWrite
assign ID_EX_MemRead = ID_EX_Control[7];
initial
begin
    ControlSrc = 'b1;
    PCWrite = 'b1;
    IF_ID_Write = 'b1;
end
always @(*)
begin
    if(ID_EX_MemRead & ((ID_EX_RegisterRt == IF_ID_RegisterRs) || (ID_EX_RegisterRt == IF_ID_RegisterRt)))
    begin
        ControlSrc = 'b0;
        PCWrite = 'b0;
        IF_ID_Write = 'b0;
    end
    else
    begin
        ControlSrc = 'b1;
        PCWrite = 'b1;
        IF_ID_Write = 'b1;
    end
end
endmodule

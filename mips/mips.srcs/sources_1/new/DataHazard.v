`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2022 15:31:15
// Design Name: 
// Module Name: DataHazard
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


module DataHazard(
input EX_MEM_RegWrite,
input [4:0] EX_MEM_RegisterRd,
input [4:0] ID_EX_RegisterRs,
input [4:0] ID_EX_RegisterRt,
input MEM_WB_RegWrite,
input [4:0] MEM_WB_RegisterRd,
input Ex_MEM_RegWrite,
input [4:0] Ex_MEM_RegisterRd,
output reg [1:0] ForwardA,
output reg [1:0] ForwardB
);
always @(*)
begin
    ForwardA = 'b00;
    ForwardB = 'b00;
    if(Ex_MEM_RegWrite & (Ex_MEM_RegisterRd != 'b0) & (Ex_MEM_RegisterRd == ID_EX_RegisterRs))
        ForwardA = 'b10;
    else if(MEM_WB_RegWrite & (MEM_WB_RegisterRd != 'b0) & (MEM_WB_RegisterRd == ID_EX_RegisterRs))
        ForwardA = 'b01;
    if(Ex_MEM_RegWrite & (Ex_MEM_RegisterRd != 'b0) & (Ex_MEM_RegisterRd == ID_EX_RegisterRt))
        ForwardB = 'b10;
    else if(MEM_WB_RegWrite & (MEM_WB_RegisterRd != 'b0) & (MEM_WB_RegisterRd == ID_EX_RegisterRt))
        ForwardB = 'b01;
end
endmodule

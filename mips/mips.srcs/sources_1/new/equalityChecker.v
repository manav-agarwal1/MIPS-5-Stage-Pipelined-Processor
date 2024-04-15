`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 22:58:53
// Design Name: 
// Module Name: equalityChecker
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


module equalityChecker(
input [31:0] data1,
input [31:0] data2,
output zeroflag
    );
assign zeroflag = (data1 == data2);
endmodule

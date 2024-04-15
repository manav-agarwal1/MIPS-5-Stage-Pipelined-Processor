`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2022 16:24:42
// Design Name: 
// Module Name: mux3_1
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


module mux3_1#(parameter width=16)(
input [width-1:0]  in0,
input [width-1:0]  in1,
input [width-1:0]  in2,
input [1:0]        ctrl,
output reg [width-1:0] muxOut
    );
always @(*)
begin
    case(ctrl)
        2'b00 : muxOut = in0;
        2'b01 : muxOut = in1;
        2'b10 : muxOut = in2;
        default : muxOut = 'b0;
    endcase
end
endmodule

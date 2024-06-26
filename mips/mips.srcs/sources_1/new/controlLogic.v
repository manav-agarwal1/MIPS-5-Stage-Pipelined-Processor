`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2022 03:21:30 PM
// Design Name: 
// Module Name: controlLogic
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
`define lw    'b100011
`define sw    'b101011
`define addi  'b001000
`define bne   'b000101
`define rtype 'b000000
`define add   'b100000
`define sub   'b100010
`define andOp 'b100100
`define orOp  'b100101
`define slt   'b101010
`define jmp   'b000010
module controlLogic(
input   [31:0] instruction,
input          zeroFlag,
output reg     regDst,
output reg     regWrite,
output reg     aluSrc,
output reg [2:0]   aluOp,
output reg     memWrite,
output reg     memToReg,
output reg     jmpSrc,
output reg     pcSrc,
output reg        IF_Flush 
);
//initial
//    pcSrc <= 1'b0;
wire [5:0] opCode;
wire [5:0] func;
initial
begin
    pcSrc = 0;
    IF_Flush = 0;
    jmpSrc = 0;
end
assign func = instruction[5:0];
assign opCode = instruction[31:26];
//assign IF_Flush = ((opCode == `bne & ~zeroFlag) || (opCode == `jmp)) ? 1'b0 : 1'b1;
//assign pcSrc = (opCode == `bne & ~zeroFlag) ? 1'b1 : 1'b0;always
always @(*)
begin
    IF_Flush = 0;
    if((opCode == `bne & ~zeroFlag) || (opCode == `jmp))
        IF_Flush = 1'b1;
    else
        IF_Flush = 1'b0;
end
always @(*)
begin
    pcSrc = 0;
    if(opCode == `bne & ~zeroFlag)
        pcSrc = 1'b1;
    else
        pcSrc = 1'b0;
end

always @(*)
begin
    regDst = 0;
    if(opCode == `rtype)
        regDst = 1'b1;
    else
        regDst = 1'b0;
end

always @(*)
begin
    regWrite = 0;
    if(opCode == `rtype | opCode == `lw | opCode == `addi)
        regWrite = 1'b1;
    else
        regWrite = 1'b0;
end

always @(*)
begin
    aluSrc = 0;
    if(opCode == `rtype | opCode == `bne)
        aluSrc = 1'b0;
    else
        aluSrc = 1'b1;
end

always @(*)
begin
    aluOp = 3'd0;
    if(opCode == `rtype)
    begin
        case(func)
            `add:aluOp = 3'b010;
            `sub:aluOp = 3'b110;
            `andOp:aluOp = 3'b000;
            `orOp:aluOp = 3'b001;
            `slt:aluOp = 3'b111;
            default:aluOp = 3'b000;
        endcase
    end
    else if(opCode == `lw | opCode == `sw | opCode == `addi)
        aluOp = 3'b010;
    else
        aluOp = 3'b110;
end


always @(*)
begin
    memWrite = 0;
    if(opCode == `sw)
        memWrite = 1'b1;
    else
        memWrite = 1'b0;
end

always @(*)
begin
    memToReg = 0;
    if(opCode == `lw)
        memToReg = 1'b1;
    else
        memToReg = 1'b0;
end
always @(*)
begin
    if(opCode == `jmp)
        jmpSrc = 1'b1;
    else
        jmpSrc = 1'b0;
end

endmodule

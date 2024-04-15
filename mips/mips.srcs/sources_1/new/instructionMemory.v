module instructionMemory(
input   [31:0] addressBus,
output  [31:0] instruction
);

reg [31:0] mem [1023:0];

initial
begin
    mem[0] = 32'h20090064;//addi $t1,$zero,100
    mem[1] = 32'h200a00c8;//addi $t2,$zero,200
    mem[2] = 32'h012a5820;//add $t3,$t1,$t2
    mem[3] = 32'hac0b0004;//sw $t3,4
//    mem[4] = 32'h08000009;//j nxt
    mem[4] = 32'h152a0004;//bne $t1,$t2,nxt
    mem[5] = 32'h00000000;//nop
    mem[6] = 32'h00000000;//nop
    mem[7] = 32'h00000000;//nop
    mem[8] = 32'h00000000;//nop
    mem[9] = 32'h8c0c0004;//24 nxt: lw $t4,4
    mem[10] = 32'h218c0064;//addi $t4,$t4,100
end

assign instruction =  mem[addressBus[31:2]];


endmodule
//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Sat Apr 30 07:06:42 2022
//Host        : DESKTOP-AML1QVU running 64-bit major release  (build 9200)
//Command     : generate_target mips.bd
//Design      : mips
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ForwardingUnit_imp_1K2QMGL
   (Din,
    Din1,
    Ex_MEM_RegisterRd,
    ForwardA,
    ForwardB,
    ID_EX_RegisterRs,
    ID_EX_RegisterRt,
    MEM_WB_RegisterRd);
  input [9:0]Din;
  input [9:0]Din1;
  input [4:0]Ex_MEM_RegisterRd;
  output [1:0]ForwardA;
  output [1:0]ForwardB;
  input [4:0]ID_EX_RegisterRs;
  input [4:0]ID_EX_RegisterRt;
  input [4:0]MEM_WB_RegisterRd;

  wire [1:0]ForwardingUnit_ForwardA;
  wire [1:0]ForwardingUnit_ForwardB;
  wire [4:0]ID_EX_0_slicetsop;
  wire [4:0]InsructionDecode_ID_EX_RegisterRs;
  wire [4:0]InstructionExecute_RegWrtAddop;
  wire [9:0]InstructionExecute_controlop;
  wire [9:0]MEM_WB_0_controlsop;
  wire [4:0]regWrAddr_1;
  wire [0:0]xlslice_0_Dout1;
  wire [0:0]xlslice_1_Dout;

  assign ForwardA[1:0] = ForwardingUnit_ForwardA;
  assign ForwardB[1:0] = ForwardingUnit_ForwardB;
  assign ID_EX_0_slicetsop = ID_EX_RegisterRt[4:0];
  assign InsructionDecode_ID_EX_RegisterRs = ID_EX_RegisterRs[4:0];
  assign InstructionExecute_RegWrtAddop = Ex_MEM_RegisterRd[4:0];
  assign InstructionExecute_controlop = Din[9:0];
  assign MEM_WB_0_controlsop = Din1[9:0];
  assign regWrAddr_1 = MEM_WB_RegisterRd[4:0];
  mips_DataHazard_0_0 DataHazard_0
       (.Ex_MEM_RegWrite(xlslice_0_Dout1),
        .Ex_MEM_RegisterRd(InstructionExecute_RegWrtAddop),
        .ForwardA(ForwardingUnit_ForwardA),
        .ForwardB(ForwardingUnit_ForwardB),
        .ID_EX_RegisterRs(InsructionDecode_ID_EX_RegisterRs),
        .ID_EX_RegisterRt(ID_EX_0_slicetsop),
        .MEM_WB_RegWrite(xlslice_1_Dout),
        .MEM_WB_RegisterRd(regWrAddr_1));
  mips_xlslice_0_8 xlslice_0
       (.Din(InstructionExecute_controlop),
        .Dout(xlslice_0_Dout1));
  mips_xlslice_1_1 xlslice_1
       (.Din(MEM_WB_0_controlsop),
        .Dout(xlslice_1_Dout));
endmodule

module HazardDetectionUnit_imp_1HW9RPR
   (ID_EX_Control,
    ID_EX_RegisterRt,
    IF_ID_RegisterRs,
    IF_ID_RegisterRt,
    IF_ID_Write,
    PCWrite,
    in1,
    muxOut);
  input [9:0]ID_EX_Control;
  input [4:0]ID_EX_RegisterRt;
  input [4:0]IF_ID_RegisterRs;
  input [4:0]IF_ID_RegisterRt;
  output IF_ID_Write;
  output PCWrite;
  input [9:0]in1;
  output [9:0]muxOut;

  wire HazardDetectionUnit_0_ControlSrc;
  wire HazardDetectionUnit_0_IF_ID_Write;
  wire HazardDetectionUnit_0_PCWrite;
  wire [9:0]ID_EX_0_controlop;
  wire [4:0]ID_EX_0_slicetsop;
  wire [9:0]mux_0_muxOut;
  wire [9:0]xlconcat_0_dout;
  wire [9:0]xlconcat_0_dout1;
  wire [7:0]xlconstant_0_dout;
  wire [0:0]xlslice_0_Dout;
  wire [4:0]xlslice_0_Dout_1;
  wire [4:0]xlslice_1_Dout;
  wire [0:0]xlslice_1_Dout1;

  assign ID_EX_0_controlop = ID_EX_Control[9:0];
  assign ID_EX_0_slicetsop = ID_EX_RegisterRt[4:0];
  assign IF_ID_Write = HazardDetectionUnit_0_IF_ID_Write;
  assign PCWrite = HazardDetectionUnit_0_PCWrite;
  assign muxOut[9:0] = mux_0_muxOut;
  assign xlconcat_0_dout = in1[9:0];
  assign xlslice_0_Dout_1 = IF_ID_RegisterRs[4:0];
  assign xlslice_1_Dout = IF_ID_RegisterRt[4:0];
  mips_HazardDetectionUnit_0_0 HazardDetectionUnit_0
       (.ControlSrc(HazardDetectionUnit_0_ControlSrc),
        .ID_EX_Control(ID_EX_0_controlop),
        .ID_EX_RegisterRt(ID_EX_0_slicetsop),
        .IF_ID_RegisterRs(xlslice_0_Dout_1),
        .IF_ID_RegisterRt(xlslice_1_Dout),
        .IF_ID_Write(HazardDetectionUnit_0_IF_ID_Write),
        .PCWrite(HazardDetectionUnit_0_PCWrite));
  mips_mux_0_2 mux_0
       (.ctrl(HazardDetectionUnit_0_ControlSrc),
        .in0(xlconcat_0_dout1),
        .in1(xlconcat_0_dout),
        .muxOut(mux_0_muxOut));
  mips_xlconcat_0_1 xlconcat_0
       (.In0(xlconstant_0_dout),
        .In1(xlslice_0_Dout),
        .In2(xlslice_1_Dout1),
        .dout(xlconcat_0_dout1));
  mips_xlconstant_0_2 xlconstant_0
       (.dout(xlconstant_0_dout));
  mips_xlslice_0_9 xlslice_0
       (.Din(xlconcat_0_dout),
        .Dout(xlslice_0_Dout));
  mips_xlslice_1_2 xlslice_1
       (.Din(xlconcat_0_dout),
        .Dout(xlslice_1_Dout1));
endmodule

module InstructionDecode_imp_1V0HFM2
   (Din,
    Dout,
    Dout1,
    ID_EX_RegisterRd,
    ID_EX_RegisterRs,
    ID_EX_RegisterRt,
    IF_Flush,
    adderOut,
    control,
    controlop,
    dout2,
    in_clock,
    op2,
    rdData1op,
    rdData2op,
    regWrAddr,
    regWrData,
    regWrEn,
    signExtop);
  input [31:0]Din;
  output [4:0]Dout;
  output [4:0]Dout1;
  output [4:0]ID_EX_RegisterRd;
  output [4:0]ID_EX_RegisterRs;
  output [4:0]ID_EX_RegisterRt;
  output IF_Flush;
  output [31:0]adderOut;
  input [9:0]control;
  output [9:0]controlop;
  output [9:0]dout2;
  input in_clock;
  input [31:0]op2;
  output [31:0]rdData1op;
  output [31:0]rdData2op;
  input [4:0]regWrAddr;
  input [31:0]regWrData;
  input regWrEn;
  output [31:0]signExtop;

  wire [9:0]ID_EX_0_controlop;
  wire [4:0]ID_EX_0_slicefeop;
  wire [4:0]ID_EX_0_slicetsop;
  wire [31:0]IF_ID_0_instructionOp;
  wire [4:0]InsructionDecode_ID_EX_RegisterRs;
  wire InsructionDecode_IF_Flush;
  wire [31:0]InsructionDecode_rdData1op;
  wire [31:0]InstructionDecode_adderOut;
  wire [31:0]InstructionDecode_outData;
  wire [31:0]InstructionDecode_rdData2op;
  wire [31:0]InstructionDecode_signExtop;
  wire [31:0]InstructionFetch_pcOut;
  wire [31:0]RegFile_0_regRdData1;
  wire [31:0]RegFile_0_regRdData2;
  wire alu_0_zeroFlag1;
  wire [2:0]controlLogic_0_aluOp;
  wire controlLogic_0_aluSrc;
  wire controlLogic_0_jmpsrc;
  wire controlLogic_0_memToReg;
  wire controlLogic_0_memWrite;
  wire controlLogic_0_pcSrc;
  wire controlLogic_0_regDst;
  wire controlLogic_0_regWrite;
  wire i_clk_0_1;
  wire [9:0]mux_0_muxOut;
  wire [31:0]mux_2_muxOut;
  wire [4:0]regWrAddr_1;
  wire [31:0]shiftLeft_0_outData;
  wire [9:0]xlconcat_0_dout;
  wire xlslice_0_Dout;
  wire [4:0]xlslice_0_Dout_1;
  wire [4:0]xlslice_1_Dout;
  wire [4:0]xlslice_2_Dout;
  wire [15:0]xlslice_3_Dout;

  assign Dout[4:0] = xlslice_0_Dout_1;
  assign Dout1[4:0] = xlslice_1_Dout;
  assign ID_EX_RegisterRd[4:0] = ID_EX_0_slicefeop;
  assign ID_EX_RegisterRs[4:0] = InsructionDecode_ID_EX_RegisterRs;
  assign ID_EX_RegisterRt[4:0] = ID_EX_0_slicetsop;
  assign IF_Flush = InsructionDecode_IF_Flush;
  assign IF_ID_0_instructionOp = Din[31:0];
  assign InstructionFetch_pcOut = op2[31:0];
  assign adderOut[31:0] = InstructionDecode_adderOut;
  assign controlop[9:0] = ID_EX_0_controlop;
  assign dout2[9:0] = xlconcat_0_dout;
  assign i_clk_0_1 = in_clock;
  assign mux_0_muxOut = control[9:0];
  assign mux_2_muxOut = regWrData[31:0];
  assign rdData1op[31:0] = InsructionDecode_rdData1op;
  assign rdData2op[31:0] = InstructionDecode_rdData2op;
  assign regWrAddr_1 = regWrAddr[4:0];
  assign signExtop[31:0] = InstructionDecode_signExtop;
  assign xlslice_0_Dout = regWrEn;
  mips_ID_EX_0_0 ID_EX_0
       (.ID_EX_RegisterRd(ID_EX_0_slicefeop),
        .ID_EX_RegisterRs(InsructionDecode_ID_EX_RegisterRs),
        .ID_EX_RegisterRt(ID_EX_0_slicetsop),
        .IF_ID_RegisterRd(xlslice_2_Dout),
        .IF_ID_RegisterRs(xlslice_0_Dout_1),
        .IF_ID_RegisterRt(xlslice_1_Dout),
        .clk(i_clk_0_1),
        .control(mux_0_muxOut),
        .controlop(ID_EX_0_controlop),
        .rdData1(RegFile_0_regRdData1),
        .rdData1op(InsructionDecode_rdData1op),
        .rdData2(RegFile_0_regRdData2),
        .rdData2op(InstructionDecode_rdData2op),
        .signExt(InstructionDecode_outData),
        .signExtop(InstructionDecode_signExtop));
  mips_RegFile_0_0 RegFile_0
       (.i_clk(i_clk_0_1),
        .regRdAddr1(xlslice_0_Dout_1),
        .regRdAddr2(xlslice_1_Dout),
        .regRdData1(RegFile_0_regRdData1),
        .regRdData2(RegFile_0_regRdData2),
        .regWrAddr(regWrAddr_1),
        .regWrData(mux_2_muxOut),
        .regWrEn(xlslice_0_Dout));
  mips_adder_1_0 adder_1
       (.adderOut(InstructionDecode_adderOut),
        .op1(shiftLeft_0_outData),
        .op2(InstructionFetch_pcOut));
  mips_controlLogic_0_0 controlLogic_0
       (.IF_Flush(InsructionDecode_IF_Flush),
        .aluOp(controlLogic_0_aluOp),
        .aluSrc(controlLogic_0_aluSrc),
        .instruction(IF_ID_0_instructionOp),
        .jmpSrc(controlLogic_0_jmpsrc),
        .memToReg(controlLogic_0_memToReg),
        .memWrite(controlLogic_0_memWrite),
        .pcSrc(controlLogic_0_pcSrc),
        .regDst(controlLogic_0_regDst),
        .regWrite(controlLogic_0_regWrite),
        .zeroFlag(alu_0_zeroFlag1));
  mips_equalityChecker_0_0 equalityChecker_0
       (.data1(RegFile_0_regRdData1),
        .data2(RegFile_0_regRdData2),
        .zeroflag(alu_0_zeroFlag1));
  mips_shiftLeft_0_0 shiftLeft_0
       (.inData(InstructionDecode_outData),
        .outData(shiftLeft_0_outData));
  mips_signExtern_0_0 signExtern_0
       (.inData(xlslice_3_Dout),
        .outData(InstructionDecode_outData));
  mips_xlconcat_0_0 xlconcat_0
       (.In0(controlLogic_0_regDst),
        .In1(controlLogic_0_regWrite),
        .In2(controlLogic_0_aluSrc),
        .In3(controlLogic_0_aluOp),
        .In4(controlLogic_0_memWrite),
        .In5(controlLogic_0_memToReg),
        .In6(controlLogic_0_jmpsrc),
        .In7(controlLogic_0_pcSrc),
        .dout(xlconcat_0_dout));
  mips_xlslice_0_0 xlslice_0
       (.Din(IF_ID_0_instructionOp),
        .Dout(xlslice_0_Dout_1));
  mips_xlslice_1_0 xlslice_1
       (.Din(IF_ID_0_instructionOp),
        .Dout(xlslice_1_Dout));
  mips_xlslice_2_0 xlslice_2
       (.Din(IF_ID_0_instructionOp),
        .Dout(xlslice_2_Dout));
  mips_xlslice_3_0 xlslice_3
       (.Din(IF_ID_0_instructionOp),
        .Dout(xlslice_3_Dout));
endmodule

module InstructionExecute_imp_EK0OYR
   (Din,
    RegWrtAddop,
    aluop,
    controlop,
    ctrl,
    ctrl1,
    in0,
    in1,
    in2,
    in3,
    in4,
    in_clock,
    wrtData,
    wrtDataop);
  input [9:0]Din;
  output [4:0]RegWrtAddop;
  output [31:0]aluop;
  output [9:0]controlop;
  input [1:0]ctrl;
  input [1:0]ctrl1;
  input [4:0]in0;
  input [4:0]in1;
  input [31:0]in2;
  input [31:0]in3;
  input [31:0]in4;
  input in_clock;
  input [31:0]wrtData;
  output [31:0]wrtDataop;

  wire [31:0]EX_MEM_0_wrtDataop;
  wire [1:0]ForwardingUnit_ForwardA;
  wire [1:0]ForwardingUnit_ForwardB;
  wire [9:0]ID_EX_0_controlop;
  wire [4:0]ID_EX_0_slicefeop;
  wire [4:0]ID_EX_0_slicetsop;
  wire [31:0]InsructionDecode_rdData1op;
  wire [31:0]InstructionDecode_signExtop;
  wire [4:0]InstructionExecute_RegWrtAddop;
  wire [31:0]InstructionExecute_aluop;
  wire [9:0]InstructionExecute_controlop;
  wire [31:0]alu_0_aluOut;
  wire i_clk_0_1;
  wire [31:0]mux3_1_0_muxOut;
  wire [31:0]mux3_1_1_muxOut;
  wire [31:0]mux_2_muxOut;
  wire [31:0]op2Mux_muxOut;
  wire [4:0]regWrAdd_muxOut;
  wire [31:0]wrtData_1;
  wire [2:0]xlslice_0_Dout1;
  wire [0:0]xlslice_0_Dout_1;
  wire [0:0]xlslice_4_Dout;

  assign ForwardingUnit_ForwardA = ctrl[1:0];
  assign ForwardingUnit_ForwardB = ctrl1[1:0];
  assign ID_EX_0_controlop = Din[9:0];
  assign ID_EX_0_slicefeop = in1[4:0];
  assign ID_EX_0_slicetsop = in0[4:0];
  assign InsructionDecode_rdData1op = in3[31:0];
  assign InstructionDecode_signExtop = in2[31:0];
  assign RegWrtAddop[4:0] = InstructionExecute_RegWrtAddop;
  assign aluop[31:0] = InstructionExecute_aluop;
  assign controlop[9:0] = InstructionExecute_controlop;
  assign i_clk_0_1 = in_clock;
  assign mux_2_muxOut = in4[31:0];
  assign wrtData_1 = wrtData[31:0];
  assign wrtDataop[31:0] = EX_MEM_0_wrtDataop;
  mips_xlslice_4_0 ALUSrc
       (.Din(ID_EX_0_controlop),
        .Dout(xlslice_4_Dout));
  mips_EX_MEM_0_0 EX_MEM_0
       (.Control(ID_EX_0_controlop),
        .RegWrtAdd(regWrAdd_muxOut),
        .RegWrtAddop(InstructionExecute_RegWrtAddop),
        .alu(alu_0_aluOut),
        .aluop(InstructionExecute_aluop),
        .clk(i_clk_0_1),
        .controlop(InstructionExecute_controlop),
        .wrtData(mux3_1_1_muxOut),
        .wrtDataop(EX_MEM_0_wrtDataop));
  mips_xlslice_0_1 RegDst
       (.Din(ID_EX_0_controlop),
        .Dout(xlslice_0_Dout_1));
  mips_xlslice_0_2 aluOp
       (.Din(ID_EX_0_controlop),
        .Dout(xlslice_0_Dout1));
  mips_alu_0_0 alu_0
       (.aluOp(xlslice_0_Dout1),
        .aluOut(alu_0_aluOut),
        .op1(mux3_1_0_muxOut),
        .op2(op2Mux_muxOut));
  mips_mux3_1_0_0 mux3_1_0
       (.ctrl(ForwardingUnit_ForwardA),
        .in0(InsructionDecode_rdData1op),
        .in1(mux_2_muxOut),
        .in2(InstructionExecute_aluop),
        .muxOut(mux3_1_0_muxOut));
  mips_mux3_1_1_0 mux3_1_1
       (.ctrl(ForwardingUnit_ForwardB),
        .in0(wrtData_1),
        .in1(mux_2_muxOut),
        .in2(InstructionExecute_aluop),
        .muxOut(mux3_1_1_muxOut));
  mips_mux_1_0 op2Mux
       (.ctrl(xlslice_4_Dout),
        .in0(mux3_1_1_muxOut),
        .in1(InstructionDecode_signExtop),
        .muxOut(op2Mux_muxOut));
  mips_mux_0_0 regWrAdd
       (.ctrl(xlslice_0_Dout_1),
        .in0(ID_EX_0_slicetsop),
        .in1(ID_EX_0_slicefeop),
        .muxOut(regWrAdd_muxOut));
endmodule

module InstructionFetch_imp_18MHQQX
   (Din,
    IF_Flush,
    IF_ID_Write,
    PCWrite,
    in1,
    in2,
    in_clock,
    instructionOp,
    pcOut);
  input [9:0]Din;
  input IF_Flush;
  input IF_ID_Write;
  input PCWrite;
  input [31:0]in1;
  input [31:0]in2;
  input in_clock;
  output [31:0]instructionOp;
  output [31:0]pcOut;

  wire [9:0]Conrols;
  wire [31:0]IF_ID_0_instructionOp;
  wire IF_ID_Write_1;
  wire InsructionDecode_IF_Flush;
  wire [31:0]InsructionDecode_dout1;
  wire [31:0]InstructionDecode_adderOut;
  wire [31:0]InstructionFetch_pcOut;
  wire PCWrite_1;
  wire [31:0]adder_0_adderOut;
  wire [31:0]constantFour_dout;
  wire i_clk_0_1;
  wire [31:0]instructionMemory_0_instruction;
  wire [31:0]mux_0_muxOut;
  wire [31:0]mux_3_muxOut;
  wire [0:0]pcSrc_Dout;
  wire [31:0]programCounter_0_pcOut;
  wire [0:0]xlslice_0_Dout1;

  assign Conrols = Din[9:0];
  assign IF_ID_Write_1 = IF_ID_Write;
  assign InsructionDecode_IF_Flush = IF_Flush;
  assign InsructionDecode_dout1 = in1[31:0];
  assign InstructionDecode_adderOut = in2[31:0];
  assign PCWrite_1 = PCWrite;
  assign i_clk_0_1 = in_clock;
  assign instructionOp[31:0] = IF_ID_0_instructionOp;
  assign pcOut[31:0] = InstructionFetch_pcOut;
  mips_IF_ID_0_0 IF_ID_0
       (.IF_Flush(InsructionDecode_IF_Flush),
        .IF_ID_Write(IF_ID_Write_1),
        .clk(i_clk_0_1),
        .instruction(instructionMemory_0_instruction),
        .instructionOp(IF_ID_0_instructionOp),
        .pc(adder_0_adderOut),
        .pcOut(InstructionFetch_pcOut));
  mips_adder_0_0 adder_0
       (.adderOut(adder_0_adderOut),
        .op1(programCounter_0_pcOut),
        .op2(constantFour_dout));
  mips_xlconstant_0_0 constantFour
       (.dout(constantFour_dout));
  mips_instructionMemory_0_0 instructionMemory_0
       (.addressBus(programCounter_0_pcOut),
        .instruction(instructionMemory_0_instruction));
  mips_xlslice_0_7 jmpSrc
       (.Din(Conrols),
        .Dout(xlslice_0_Dout1));
  mips_mux_0_1 mux_0
       (.ctrl(xlslice_0_Dout1),
        .in0(mux_3_muxOut),
        .in1(InsructionDecode_dout1),
        .muxOut(mux_0_muxOut));
  mips_mux_3_0 mux_3
       (.ctrl(pcSrc_Dout),
        .in0(adder_0_adderOut),
        .in1(InstructionDecode_adderOut),
        .muxOut(mux_3_muxOut));
  mips_xlslice_0_3 pcSrc
       (.Din(Conrols),
        .Dout(pcSrc_Dout));
  mips_programCounter_0_0 programCounter_0
       (.PCWrite(PCWrite_1),
        .i_clk(i_clk_0_1),
        .pcIn(mux_0_muxOut),
        .pcOut(programCounter_0_pcOut));
endmodule

module Memory_imp_1UC14WL
   (Din,
    aluop,
    controlsop,
    in_clock,
    rdDataop,
    regWrtAdd,
    regWrtAddop,
    writeAddress,
    writeData);
  input [9:0]Din;
  output [31:0]aluop;
  output [9:0]controlsop;
  input in_clock;
  output [31:0]rdDataop;
  input [4:0]regWrtAdd;
  output [4:0]regWrtAddop;
  input [31:0]writeAddress;
  input [31:0]writeData;

  wire [9:0]EX_MEM_0_controlop;
  wire [31:0]EX_MEM_0_wrtDataop;
  wire [4:0]InstructionExecute_RegWrtAddop;
  wire [31:0]InstructionExecute_aluop;
  wire [31:0]MEM_WB_0_aluop;
  wire [9:0]MEM_WB_0_controlsop;
  wire [31:0]MEM_WB_0_rdDataop;
  wire [31:0]dataMemory_0_readData;
  wire i_clk_0_1;
  wire [4:0]regWrAddr_1;
  wire [0:0]xlslice_0_Dout;

  assign EX_MEM_0_controlop = Din[9:0];
  assign EX_MEM_0_wrtDataop = writeData[31:0];
  assign InstructionExecute_RegWrtAddop = regWrtAdd[4:0];
  assign InstructionExecute_aluop = writeAddress[31:0];
  assign aluop[31:0] = MEM_WB_0_aluop;
  assign controlsop[9:0] = MEM_WB_0_controlsop;
  assign i_clk_0_1 = in_clock;
  assign rdDataop[31:0] = MEM_WB_0_rdDataop;
  assign regWrtAddop[4:0] = regWrAddr_1;
  mips_MEM_WB_0_0 MEM_WB_0
       (.alu(InstructionExecute_aluop),
        .aluop(MEM_WB_0_aluop),
        .clk(i_clk_0_1),
        .controls(EX_MEM_0_controlop),
        .controlsop(MEM_WB_0_controlsop),
        .rdData(dataMemory_0_readData),
        .rdDataop(MEM_WB_0_rdDataop),
        .regWrtAdd(InstructionExecute_RegWrtAddop),
        .regWrtAddop(regWrAddr_1));
  mips_xlslice_0_4 MemWrt
       (.Din(EX_MEM_0_controlop),
        .Dout(xlslice_0_Dout));
  mips_dataMemory_0_0 dataMemory_0
       (.i_clk(i_clk_0_1),
        .memWrite(xlslice_0_Dout),
        .readAddress(InstructionExecute_aluop),
        .readData(dataMemory_0_readData),
        .writeAddress(InstructionExecute_aluop),
        .writeData(EX_MEM_0_wrtDataop));
endmodule

module WriteBack_imp_Y0788N
   (Din,
    Dout,
    in0,
    in1,
    muxOut);
  input [9:0]Din;
  output [0:0]Dout;
  input [31:0]in0;
  input [31:0]in1;
  output [31:0]muxOut;

  wire [31:0]MEM_WB_0_aluop;
  wire [9:0]MEM_WB_0_controlsop;
  wire [31:0]MEM_WB_0_rdDataop;
  wire [31:0]mux_2_muxOut;
  wire [0:0]xlslice_0_Dout;
  wire [0:0]xlslice_0_Dout1;

  assign Dout[0] = xlslice_0_Dout;
  assign MEM_WB_0_aluop = in0[31:0];
  assign MEM_WB_0_controlsop = Din[9:0];
  assign MEM_WB_0_rdDataop = in1[31:0];
  assign muxOut[31:0] = mux_2_muxOut;
  mips_xlslice_0_5 MemtoReg
       (.Din(MEM_WB_0_controlsop),
        .Dout(xlslice_0_Dout1));
  mips_xlslice_0_6 RegWrtEn
       (.Din(MEM_WB_0_controlsop),
        .Dout(xlslice_0_Dout));
  mips_mux_2_0 regWrData
       (.ctrl(xlslice_0_Dout1),
        .in0(MEM_WB_0_aluop),
        .in1(MEM_WB_0_rdDataop),
        .muxOut(mux_2_muxOut));
endmodule

module jumpAddCalc_imp_1POJER8
   (Din,
    Din1,
    dout);
  input [31:0]Din;
  input [31:0]Din1;
  output [31:0]dout;

  wire [31:0]IF_ID_0_instructionOp;
  wire [31:0]InstructionFetch_pcOut;
  wire [31:0]xlconcat_1_dout;
  wire [1:0]xlconstant_0_dout;
  wire [3:0]xlslice_4_Dout;
  wire [25:0]xlslice_5_Dout;

  assign IF_ID_0_instructionOp = Din1[31:0];
  assign InstructionFetch_pcOut = Din[31:0];
  assign dout[31:0] = xlconcat_1_dout;
  mips_xlconcat_1_0 xlconcat_1
       (.In0(xlconstant_0_dout),
        .In1(xlslice_5_Dout),
        .In2(xlslice_4_Dout),
        .dout(xlconcat_1_dout));
  mips_xlconstant_0_1 xlconstant_0
       (.dout(xlconstant_0_dout));
  mips_xlslice_4_1 xlslice_4
       (.Din(InstructionFetch_pcOut),
        .Dout(xlslice_4_Dout));
  mips_xlslice_5_0 xlslice_5
       (.Din(IF_ID_0_instructionOp),
        .Dout(xlslice_5_Dout));
endmodule

(* CORE_GENERATION_INFO = "mips,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mips,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=57,numReposBlks=49,numNonXlnxBlks=0,numHierBlks=8,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=25,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=6,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "mips.hwdef" *) 
module mips
   (in_clock);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.IN_CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.IN_CLOCK, CLK_DOMAIN mips_in_clock, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input in_clock;

  wire [31:0]EX_MEM_0_wrtDataop;
  wire [1:0]ForwardingUnit_ForwardA;
  wire [1:0]ForwardingUnit_ForwardB;
  wire HazardDetectionUnit_0_IF_ID_Write;
  wire HazardDetectionUnit_0_PCWrite;
  wire [9:0]ID_EX_0_controlop;
  wire [4:0]ID_EX_0_slicefeop;
  wire [4:0]ID_EX_0_slicetsop;
  wire [31:0]IF_ID_0_instructionOp;
  wire [4:0]InsructionDecode_ID_EX_RegisterRs;
  wire InsructionDecode_IF_Flush;
  wire [31:0]InsructionDecode_dout1;
  wire [31:0]InsructionDecode_rdData1op;
  wire [31:0]InstructionDecode_adderOut;
  wire [31:0]InstructionDecode_rdData2op;
  wire [31:0]InstructionDecode_signExtop;
  wire [4:0]InstructionExecute_RegWrtAddop;
  wire [31:0]InstructionExecute_aluop;
  wire [9:0]InstructionExecute_controlop;
  wire [31:0]InstructionFetch_pcOut;
  wire [31:0]MEM_WB_0_aluop;
  wire [9:0]MEM_WB_0_controlsop;
  wire [31:0]MEM_WB_0_rdDataop;
  wire i_clk_0_1;
  wire [9:0]mux_0_muxOut;
  wire [31:0]mux_2_muxOut;
  wire [4:0]regWrAddr_1;
  wire [9:0]xlconcat_0_dout;
  wire [0:0]xlslice_0_Dout;
  wire [4:0]xlslice_0_Dout_1;
  wire [4:0]xlslice_1_Dout;

  assign i_clk_0_1 = in_clock;
  ForwardingUnit_imp_1K2QMGL ForwardingUnit
       (.Din(InstructionExecute_controlop),
        .Din1(MEM_WB_0_controlsop),
        .Ex_MEM_RegisterRd(InstructionExecute_RegWrtAddop),
        .ForwardA(ForwardingUnit_ForwardA),
        .ForwardB(ForwardingUnit_ForwardB),
        .ID_EX_RegisterRs(InsructionDecode_ID_EX_RegisterRs),
        .ID_EX_RegisterRt(ID_EX_0_slicetsop),
        .MEM_WB_RegisterRd(regWrAddr_1));
  HazardDetectionUnit_imp_1HW9RPR HazardDetectionUnit
       (.ID_EX_Control(ID_EX_0_controlop),
        .ID_EX_RegisterRt(ID_EX_0_slicetsop),
        .IF_ID_RegisterRs(xlslice_0_Dout_1),
        .IF_ID_RegisterRt(xlslice_1_Dout),
        .IF_ID_Write(HazardDetectionUnit_0_IF_ID_Write),
        .PCWrite(HazardDetectionUnit_0_PCWrite),
        .in1(xlconcat_0_dout),
        .muxOut(mux_0_muxOut));
  InstructionDecode_imp_1V0HFM2 InstructionDecode
       (.Din(IF_ID_0_instructionOp),
        .Dout(xlslice_0_Dout_1),
        .Dout1(xlslice_1_Dout),
        .ID_EX_RegisterRd(ID_EX_0_slicefeop),
        .ID_EX_RegisterRs(InsructionDecode_ID_EX_RegisterRs),
        .ID_EX_RegisterRt(ID_EX_0_slicetsop),
        .IF_Flush(InsructionDecode_IF_Flush),
        .adderOut(InstructionDecode_adderOut),
        .control(mux_0_muxOut),
        .controlop(ID_EX_0_controlop),
        .dout2(xlconcat_0_dout),
        .in_clock(i_clk_0_1),
        .op2(InstructionFetch_pcOut),
        .rdData1op(InsructionDecode_rdData1op),
        .rdData2op(InstructionDecode_rdData2op),
        .regWrAddr(regWrAddr_1),
        .regWrData(mux_2_muxOut),
        .regWrEn(xlslice_0_Dout),
        .signExtop(InstructionDecode_signExtop));
  InstructionExecute_imp_EK0OYR InstructionExecute
       (.Din(ID_EX_0_controlop),
        .RegWrtAddop(InstructionExecute_RegWrtAddop),
        .aluop(InstructionExecute_aluop),
        .controlop(InstructionExecute_controlop),
        .ctrl(ForwardingUnit_ForwardA),
        .ctrl1(ForwardingUnit_ForwardB),
        .in0(ID_EX_0_slicetsop),
        .in1(ID_EX_0_slicefeop),
        .in2(InstructionDecode_signExtop),
        .in3(InsructionDecode_rdData1op),
        .in4(mux_2_muxOut),
        .in_clock(i_clk_0_1),
        .wrtData(InstructionDecode_rdData2op),
        .wrtDataop(EX_MEM_0_wrtDataop));
  InstructionFetch_imp_18MHQQX InstructionFetch
       (.Din(xlconcat_0_dout),
        .IF_Flush(InsructionDecode_IF_Flush),
        .IF_ID_Write(HazardDetectionUnit_0_IF_ID_Write),
        .PCWrite(HazardDetectionUnit_0_PCWrite),
        .in1(InsructionDecode_dout1),
        .in2(InstructionDecode_adderOut),
        .in_clock(i_clk_0_1),
        .instructionOp(IF_ID_0_instructionOp),
        .pcOut(InstructionFetch_pcOut));
  Memory_imp_1UC14WL Memory
       (.Din(InstructionExecute_controlop),
        .aluop(MEM_WB_0_aluop),
        .controlsop(MEM_WB_0_controlsop),
        .in_clock(i_clk_0_1),
        .rdDataop(MEM_WB_0_rdDataop),
        .regWrtAdd(InstructionExecute_RegWrtAddop),
        .regWrtAddop(regWrAddr_1),
        .writeAddress(InstructionExecute_aluop),
        .writeData(EX_MEM_0_wrtDataop));
  WriteBack_imp_Y0788N WriteBack
       (.Din(MEM_WB_0_controlsop),
        .Dout(xlslice_0_Dout),
        .in0(MEM_WB_0_aluop),
        .in1(MEM_WB_0_rdDataop),
        .muxOut(mux_2_muxOut));
  jumpAddCalc_imp_1POJER8 jumpAddCalc
       (.Din(InstructionFetch_pcOut),
        .Din1(IF_ID_0_instructionOp),
        .dout(InsructionDecode_dout1));
endmodule

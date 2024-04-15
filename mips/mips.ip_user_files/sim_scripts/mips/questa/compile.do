vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xlslice_v1_0_2
vlib questa_lib/msim/xlconstant_v1_1_7
vlib questa_lib/msim/xlconcat_v2_1_4

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xlslice_v1_0_2 questa_lib/msim/xlslice_v1_0_2
vmap xlconstant_v1_1_7 questa_lib/msim/xlconstant_v1_1_7
vmap xlconcat_v2_1_4 questa_lib/msim/xlconcat_v2_1_4

vlog -work xil_defaultlib  \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_MEM_WB_0_0/sim/mips_MEM_WB_0_0.v" \

vlog -work xlslice_v1_0_2  \
"../../../../mips.gen/sources_1/bd/mips/ipshared/11d0/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_4/sim/mips_xlslice_0_4.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_dataMemory_0_0/sim/mips_dataMemory_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_5/sim/mips_xlslice_0_5.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_6/sim/mips_xlslice_0_6.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux_2_0/sim/mips_mux_2_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_7/sim/mips_xlslice_0_7.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux_0_1/sim/mips_mux_0_1.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_3/sim/mips_xlslice_0_3.v" \

vlog -work xlconstant_v1_1_7  \
"../../../../mips.gen/sources_1/bd/mips/ipshared/fcfc/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlconstant_0_0/sim/mips_xlconstant_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_adder_0_0/sim/mips_adder_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux_3_0/sim/mips_mux_3_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_programCounter_0_0/sim/mips_programCounter_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_IF_ID_0_0/sim/mips_IF_ID_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_instructionMemory_0_0/sim/mips_instructionMemory_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_alu_0_0/sim/mips_alu_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux_0_0/sim/mips_mux_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_1/sim/mips_xlslice_0_1.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux_1_0/sim/mips_mux_1_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux3_1_0_0/sim/mips_mux3_1_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_EX_MEM_0_0/sim/mips_EX_MEM_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_2/sim/mips_xlslice_0_2.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_4_0/sim/mips_xlslice_4_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux3_1_1_0/sim/mips_mux3_1_1_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_8/sim/mips_xlslice_0_8.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_1_1/sim/mips_xlslice_1_1.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_DataHazard_0_0/sim/mips_DataHazard_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_ID_EX_0_0/sim/mips_ID_EX_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_controlLogic_0_0/sim/mips_controlLogic_0_0.v" \

vlog -work xlconcat_v2_1_4  \
"../../../../mips.gen/sources_1/bd/mips/ipshared/4b67/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlconcat_0_0/sim/mips_xlconcat_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_0/sim/mips_xlslice_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_shiftLeft_0_0/sim/mips_shiftLeft_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_1_0/sim/mips_xlslice_1_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_2_0/sim/mips_xlslice_2_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_3_0/sim/mips_xlslice_3_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_equalityChecker_0_0/sim/mips_equalityChecker_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_RegFile_0_0/sim/mips_RegFile_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_signExtern_0_0/sim/mips_signExtern_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_adder_1_0/sim/mips_adder_1_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlconstant_0_2/sim/mips_xlconstant_0_2.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_mux_0_2/sim/mips_mux_0_2.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_HazardDetectionUnit_0_0/sim/mips_HazardDetectionUnit_0_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_0_9/sim/mips_xlslice_0_9.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_1_2/sim/mips_xlslice_1_2.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlconcat_0_1/sim/mips_xlconcat_0_1.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlconcat_1_0/sim/mips_xlconcat_1_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_4_1/sim/mips_xlslice_4_1.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlslice_5_0/sim/mips_xlslice_5_0.v" \
"../../../../mips.gen/sources_1/bd/mips/ip/mips_xlconstant_0_1/sim/mips_xlconstant_0_1.v" \
"../../../../mips.gen/sources_1/bd/mips/sim/mips.v" \

vlog -work xil_defaultlib \
"glbl.v"


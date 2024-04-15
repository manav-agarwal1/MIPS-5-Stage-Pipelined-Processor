
################################################################
# This is a generated script based on design: mips
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source mips_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# DataHazard, HazardDetectionUnit, mux, ID_EX, RegFile, adder, controlLogic, equalityChecker, shiftLeft, signExtern, EX_MEM, alu, mux3_1, mux3_1, mux, mux, IF_ID, adder, instructionMemory, mux, mux, programCounter, MEM_WB, dataMemory, mux

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg400-1
   set_property BOARD_PART digilentinc.com:zybo-z7-20:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name mips

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: jumpAddCalc
proc create_hier_cell_jumpAddCalc { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_jumpAddCalc() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir I -from 31 -to 0 Din1
  create_bd_pin -dir O -from 31 -to 0 dout

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {2} \
   CONFIG.IN1_WIDTH {26} \
   CONFIG.IN2_WIDTH {4} \
   CONFIG.NUM_PORTS {3} \
 ] $xlconcat_1

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {2} \
 ] $xlconstant_0

  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {28} \
   CONFIG.DOUT_WIDTH {4} \
 ] $xlslice_4

  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_5 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {25} \
   CONFIG.DOUT_WIDTH {26} \
 ] $xlslice_5

  # Create port connections
  connect_bd_net -net IF_ID_0_instructionOp [get_bd_pins Din1] [get_bd_pins xlslice_5/Din]
  connect_bd_net -net InstructionFetch_pcOut [get_bd_pins Din] [get_bd_pins xlslice_4/Din]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins dout] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconcat_1/In0] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins xlconcat_1/In2] [get_bd_pins xlslice_4/Dout]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins xlconcat_1/In1] [get_bd_pins xlslice_5/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: WriteBack
proc create_hier_cell_WriteBack { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_WriteBack() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 Din
  create_bd_pin -dir O -from 0 -to 0 Dout
  create_bd_pin -dir I -from 31 -to 0 in0
  create_bd_pin -dir I -from 31 -to 0 in1
  create_bd_pin -dir O -from 31 -to 0 muxOut

  # Create instance: MemtoReg, and set properties
  set MemtoReg [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 MemtoReg ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {7} \
   CONFIG.DIN_TO {7} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $MemtoReg

  # Create instance: RegWrtEn, and set properties
  set RegWrtEn [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 RegWrtEn ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $RegWrtEn

  # Create instance: regWrData, and set properties
  set block_name mux
  set block_cell_name regWrData
  if { [catch {set regWrData [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $regWrData eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $regWrData

  # Create port connections
  connect_bd_net -net MEM_WB_0_aluop [get_bd_pins in0] [get_bd_pins regWrData/in0]
  connect_bd_net -net MEM_WB_0_controlsop [get_bd_pins Din] [get_bd_pins MemtoReg/Din] [get_bd_pins RegWrtEn/Din]
  connect_bd_net -net MEM_WB_0_rdDataop [get_bd_pins in1] [get_bd_pins regWrData/in1]
  connect_bd_net -net mux_2_muxOut [get_bd_pins muxOut] [get_bd_pins regWrData/muxOut]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins RegWrtEn/Dout]
  connect_bd_net -net xlslice_0_Dout1 [get_bd_pins MemtoReg/Dout] [get_bd_pins regWrData/ctrl]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Memory
proc create_hier_cell_Memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_Memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 Din
  create_bd_pin -dir O -from 31 -to 0 aluop
  create_bd_pin -dir O -from 9 -to 0 controlsop
  create_bd_pin -dir I -type clk in_clock
  create_bd_pin -dir O -from 31 -to 0 rdDataop
  create_bd_pin -dir I -from 4 -to 0 regWrtAdd
  create_bd_pin -dir O -from 4 -to 0 regWrtAddop
  create_bd_pin -dir I -from 31 -to 0 writeAddress
  create_bd_pin -dir I -from 31 -to 0 writeData

  # Create instance: MEM_WB_0, and set properties
  set block_name MEM_WB
  set block_cell_name MEM_WB_0
  if { [catch {set MEM_WB_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MEM_WB_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MemWrt, and set properties
  set MemWrt [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 MemWrt ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {6} \
   CONFIG.DIN_TO {6} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $MemWrt

  # Create instance: dataMemory_0, and set properties
  set block_name dataMemory
  set block_cell_name dataMemory_0
  if { [catch {set dataMemory_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dataMemory_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net EX_MEM_0_controlop [get_bd_pins Din] [get_bd_pins MEM_WB_0/controls] [get_bd_pins MemWrt/Din]
  connect_bd_net -net EX_MEM_0_wrtDataop [get_bd_pins writeData] [get_bd_pins dataMemory_0/writeData]
  connect_bd_net -net InstructionExecute_RegWrtAddop [get_bd_pins regWrtAdd] [get_bd_pins MEM_WB_0/regWrtAdd]
  connect_bd_net -net InstructionExecute_aluop [get_bd_pins writeAddress] [get_bd_pins MEM_WB_0/alu] [get_bd_pins dataMemory_0/readAddress] [get_bd_pins dataMemory_0/writeAddress]
  connect_bd_net -net MEM_WB_0_aluop [get_bd_pins aluop] [get_bd_pins MEM_WB_0/aluop]
  connect_bd_net -net MEM_WB_0_controlsop [get_bd_pins controlsop] [get_bd_pins MEM_WB_0/controlsop]
  connect_bd_net -net MEM_WB_0_rdDataop [get_bd_pins rdDataop] [get_bd_pins MEM_WB_0/rdDataop]
  connect_bd_net -net dataMemory_0_readData [get_bd_pins MEM_WB_0/rdData] [get_bd_pins dataMemory_0/readData]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins MEM_WB_0/clk] [get_bd_pins dataMemory_0/i_clk]
  connect_bd_net -net regWrAddr_1 [get_bd_pins regWrtAddop] [get_bd_pins MEM_WB_0/regWrtAddop]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins MemWrt/Dout] [get_bd_pins dataMemory_0/memWrite]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: InstructionFetch
proc create_hier_cell_InstructionFetch { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_InstructionFetch() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 Din
  create_bd_pin -dir I IF_Flush
  create_bd_pin -dir I IF_ID_Write
  create_bd_pin -dir I PCWrite
  create_bd_pin -dir I -from 31 -to 0 in1
  create_bd_pin -dir I -from 31 -to 0 in2
  create_bd_pin -dir I -type clk in_clock
  create_bd_pin -dir O -from 31 -to 0 instructionOp
  create_bd_pin -dir O -from 31 -to 0 pcOut

  # Create instance: IF_ID_0, and set properties
  set block_name IF_ID
  set block_cell_name IF_ID_0
  if { [catch {set IF_ID_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IF_ID_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: adder_0, and set properties
  set block_name adder
  set block_cell_name adder_0
  if { [catch {set adder_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $adder_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $adder_0

  # Create instance: constantFour, and set properties
  set constantFour [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constantFour ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {4} \
   CONFIG.CONST_WIDTH {32} \
 ] $constantFour

  # Create instance: instructionMemory_0, and set properties
  set block_name instructionMemory
  set block_cell_name instructionMemory_0
  if { [catch {set instructionMemory_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $instructionMemory_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: jmpSrc, and set properties
  set jmpSrc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 jmpSrc ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {8} \
   CONFIG.DIN_TO {8} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $jmpSrc

  # Create instance: mux_0, and set properties
  set block_name mux
  set block_cell_name mux_0
  if { [catch {set mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux_0

  # Create instance: mux_3, and set properties
  set block_name mux
  set block_cell_name mux_3
  if { [catch {set mux_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux_3

  # Create instance: pcSrc, and set properties
  set pcSrc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 pcSrc ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {9} \
   CONFIG.DIN_TO {9} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $pcSrc

  # Create instance: programCounter_0, and set properties
  set block_name programCounter
  set block_cell_name programCounter_0
  if { [catch {set programCounter_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $programCounter_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net Conrols [get_bd_pins Din] [get_bd_pins jmpSrc/Din] [get_bd_pins pcSrc/Din]
  connect_bd_net -net IF_ID_0_instructionOp [get_bd_pins instructionOp] [get_bd_pins IF_ID_0/instructionOp]
  connect_bd_net -net IF_ID_Write_1 [get_bd_pins IF_ID_Write] [get_bd_pins IF_ID_0/IF_ID_Write]
  connect_bd_net -net InsructionDecode_IF_Flush [get_bd_pins IF_Flush] [get_bd_pins IF_ID_0/IF_Flush]
  connect_bd_net -net InsructionDecode_dout1 [get_bd_pins in1] [get_bd_pins mux_0/in1]
  connect_bd_net -net InstructionDecode_adderOut [get_bd_pins in2] [get_bd_pins mux_3/in1]
  connect_bd_net -net InstructionFetch_pcOut [get_bd_pins pcOut] [get_bd_pins IF_ID_0/pcOut]
  connect_bd_net -net PCWrite_1 [get_bd_pins PCWrite] [get_bd_pins programCounter_0/PCWrite]
  connect_bd_net -net adder_0_adderOut [get_bd_pins IF_ID_0/pc] [get_bd_pins adder_0/adderOut] [get_bd_pins mux_3/in0]
  connect_bd_net -net constantFour_dout [get_bd_pins adder_0/op2] [get_bd_pins constantFour/dout]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins IF_ID_0/clk] [get_bd_pins programCounter_0/i_clk]
  connect_bd_net -net instructionMemory_0_instruction [get_bd_pins IF_ID_0/instruction] [get_bd_pins instructionMemory_0/instruction]
  connect_bd_net -net mux_0_muxOut [get_bd_pins mux_0/muxOut] [get_bd_pins programCounter_0/pcIn]
  connect_bd_net -net mux_3_muxOut [get_bd_pins mux_0/in0] [get_bd_pins mux_3/muxOut]
  connect_bd_net -net pcSrc_Dout [get_bd_pins mux_3/ctrl] [get_bd_pins pcSrc/Dout]
  connect_bd_net -net programCounter_0_pcOut [get_bd_pins adder_0/op1] [get_bd_pins instructionMemory_0/addressBus] [get_bd_pins programCounter_0/pcOut]
  connect_bd_net -net xlslice_0_Dout1 [get_bd_pins jmpSrc/Dout] [get_bd_pins mux_0/ctrl]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: InstructionExecute
proc create_hier_cell_InstructionExecute { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_InstructionExecute() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 Din
  create_bd_pin -dir O -from 4 -to 0 RegWrtAddop
  create_bd_pin -dir O -from 31 -to 0 aluop
  create_bd_pin -dir O -from 9 -to 0 controlop
  create_bd_pin -dir I -from 1 -to 0 ctrl
  create_bd_pin -dir I -from 1 -to 0 ctrl1
  create_bd_pin -dir I -from 4 -to 0 in0
  create_bd_pin -dir I -from 4 -to 0 in1
  create_bd_pin -dir I -from 31 -to 0 in2
  create_bd_pin -dir I -from 31 -to 0 in3
  create_bd_pin -dir I -from 31 -to 0 in4
  create_bd_pin -dir I -type clk in_clock
  create_bd_pin -dir I -from 31 -to 0 wrtData
  create_bd_pin -dir O -from 31 -to 0 wrtDataop

  # Create instance: ALUSrc, and set properties
  set ALUSrc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ALUSrc ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $ALUSrc

  # Create instance: EX_MEM_0, and set properties
  set block_name EX_MEM
  set block_cell_name EX_MEM_0
  if { [catch {set EX_MEM_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $EX_MEM_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RegDst, and set properties
  set RegDst [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 RegDst ]
  set_property -dict [ list \
   CONFIG.DIN_WIDTH {10} \
 ] $RegDst

  # Create instance: aluOp, and set properties
  set aluOp [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 aluOp ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {5} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {3} \
 ] $aluOp

  # Create instance: alu_0, and set properties
  set block_name alu
  set block_cell_name alu_0
  if { [catch {set alu_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $alu_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: mux3_1_0, and set properties
  set block_name mux3_1
  set block_cell_name mux3_1_0
  if { [catch {set mux3_1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux3_1_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux3_1_0

  # Create instance: mux3_1_1, and set properties
  set block_name mux3_1
  set block_cell_name mux3_1_1
  if { [catch {set mux3_1_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux3_1_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux3_1_1

  # Create instance: op2Mux, and set properties
  set block_name mux
  set block_cell_name op2Mux
  if { [catch {set op2Mux [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $op2Mux eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $op2Mux

  # Create instance: regWrAdd, and set properties
  set block_name mux
  set block_cell_name regWrAdd
  if { [catch {set regWrAdd [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $regWrAdd eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {5} \
 ] $regWrAdd

  # Create port connections
  connect_bd_net -net EX_MEM_0_wrtDataop [get_bd_pins wrtDataop] [get_bd_pins EX_MEM_0/wrtDataop]
  connect_bd_net -net ForwardingUnit_ForwardA [get_bd_pins ctrl] [get_bd_pins mux3_1_0/ctrl]
  connect_bd_net -net ForwardingUnit_ForwardB [get_bd_pins ctrl1] [get_bd_pins mux3_1_1/ctrl]
  connect_bd_net -net ID_EX_0_controlop [get_bd_pins Din] [get_bd_pins ALUSrc/Din] [get_bd_pins EX_MEM_0/Control] [get_bd_pins RegDst/Din] [get_bd_pins aluOp/Din]
  connect_bd_net -net ID_EX_0_slicefeop [get_bd_pins in1] [get_bd_pins regWrAdd/in1]
  connect_bd_net -net ID_EX_0_slicetsop [get_bd_pins in0] [get_bd_pins regWrAdd/in0]
  connect_bd_net -net InsructionDecode_rdData1op [get_bd_pins in3] [get_bd_pins mux3_1_0/in0]
  connect_bd_net -net InstructionDecode_signExtop [get_bd_pins in2] [get_bd_pins op2Mux/in1]
  connect_bd_net -net InstructionExecute_RegWrtAddop [get_bd_pins RegWrtAddop] [get_bd_pins EX_MEM_0/RegWrtAddop]
  connect_bd_net -net InstructionExecute_aluop [get_bd_pins aluop] [get_bd_pins EX_MEM_0/aluop] [get_bd_pins mux3_1_0/in2] [get_bd_pins mux3_1_1/in2]
  connect_bd_net -net InstructionExecute_controlop [get_bd_pins controlop] [get_bd_pins EX_MEM_0/controlop]
  connect_bd_net -net alu_0_aluOut [get_bd_pins EX_MEM_0/alu] [get_bd_pins alu_0/aluOut]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins EX_MEM_0/clk]
  connect_bd_net -net mux3_1_0_muxOut [get_bd_pins alu_0/op1] [get_bd_pins mux3_1_0/muxOut]
  connect_bd_net -net mux3_1_1_muxOut [get_bd_pins EX_MEM_0/wrtData] [get_bd_pins mux3_1_1/muxOut] [get_bd_pins op2Mux/in0]
  connect_bd_net -net mux_2_muxOut [get_bd_pins in4] [get_bd_pins mux3_1_0/in1] [get_bd_pins mux3_1_1/in1]
  connect_bd_net -net op2Mux_muxOut [get_bd_pins alu_0/op2] [get_bd_pins op2Mux/muxOut]
  connect_bd_net -net regWrAdd_muxOut [get_bd_pins EX_MEM_0/RegWrtAdd] [get_bd_pins regWrAdd/muxOut]
  connect_bd_net -net wrtData_1 [get_bd_pins wrtData] [get_bd_pins mux3_1_1/in0]
  connect_bd_net -net xlslice_0_Dout1 [get_bd_pins aluOp/Dout] [get_bd_pins alu_0/aluOp]
  connect_bd_net -net xlslice_0_Dout_1 [get_bd_pins RegDst/Dout] [get_bd_pins regWrAdd/ctrl]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins ALUSrc/Dout] [get_bd_pins op2Mux/ctrl]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: InstructionDecode
proc create_hier_cell_InstructionDecode { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_InstructionDecode() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -from 4 -to 0 Dout
  create_bd_pin -dir O -from 4 -to 0 Dout1
  create_bd_pin -dir O -from 4 -to 0 ID_EX_RegisterRd
  create_bd_pin -dir O -from 4 -to 0 ID_EX_RegisterRs
  create_bd_pin -dir O -from 4 -to 0 ID_EX_RegisterRt
  create_bd_pin -dir O IF_Flush
  create_bd_pin -dir O -from 31 -to 0 adderOut
  create_bd_pin -dir I -from 9 -to 0 control
  create_bd_pin -dir O -from 9 -to 0 controlop
  create_bd_pin -dir O -from 9 -to 0 dout2
  create_bd_pin -dir I -type clk in_clock
  create_bd_pin -dir I -from 31 -to 0 op2
  create_bd_pin -dir O -from 31 -to 0 rdData1op
  create_bd_pin -dir O -from 31 -to 0 rdData2op
  create_bd_pin -dir I -from 4 -to 0 regWrAddr
  create_bd_pin -dir I -from 31 -to 0 regWrData
  create_bd_pin -dir I regWrEn
  create_bd_pin -dir O -from 31 -to 0 signExtop

  # Create instance: ID_EX_0, and set properties
  set block_name ID_EX
  set block_cell_name ID_EX_0
  if { [catch {set ID_EX_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ID_EX_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RegFile_0, and set properties
  set block_name RegFile
  set block_cell_name RegFile_0
  if { [catch {set RegFile_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RegFile_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: adder_1, and set properties
  set block_name adder
  set block_cell_name adder_1
  if { [catch {set adder_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $adder_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $adder_1

  # Create instance: controlLogic_0, and set properties
  set block_name controlLogic
  set block_cell_name controlLogic_0
  if { [catch {set controlLogic_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $controlLogic_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: equalityChecker_0, and set properties
  set block_name equalityChecker
  set block_cell_name equalityChecker_0
  if { [catch {set equalityChecker_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $equalityChecker_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: shiftLeft_0, and set properties
  set block_name shiftLeft
  set block_cell_name shiftLeft_0
  if { [catch {set shiftLeft_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $shiftLeft_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: signExtern_0, and set properties
  set block_name signExtern
  set block_cell_name signExtern_0
  if { [catch {set signExtern_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signExtern_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.IN3_WIDTH {3} \
   CONFIG.NUM_PORTS {8} \
 ] $xlconcat_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {25} \
   CONFIG.DIN_TO {21} \
   CONFIG.DOUT_WIDTH {5} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {20} \
   CONFIG.DIN_TO {16} \
   CONFIG.DOUT_WIDTH {5} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {11} \
   CONFIG.DOUT_WIDTH {5} \
 ] $xlslice_2

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DOUT_WIDTH {16} \
 ] $xlslice_3

  # Create port connections
  connect_bd_net -net ID_EX_0_controlop [get_bd_pins controlop] [get_bd_pins ID_EX_0/controlop]
  connect_bd_net -net ID_EX_0_slicefeop [get_bd_pins ID_EX_RegisterRd] [get_bd_pins ID_EX_0/ID_EX_RegisterRd]
  connect_bd_net -net ID_EX_0_slicetsop [get_bd_pins ID_EX_RegisterRt] [get_bd_pins ID_EX_0/ID_EX_RegisterRt]
  connect_bd_net -net IF_ID_0_instructionOp [get_bd_pins Din] [get_bd_pins controlLogic_0/instruction] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net InsructionDecode_ID_EX_RegisterRs [get_bd_pins ID_EX_RegisterRs] [get_bd_pins ID_EX_0/ID_EX_RegisterRs]
  connect_bd_net -net InsructionDecode_IF_Flush [get_bd_pins IF_Flush] [get_bd_pins controlLogic_0/IF_Flush]
  connect_bd_net -net InsructionDecode_rdData1op [get_bd_pins rdData1op] [get_bd_pins ID_EX_0/rdData1op]
  connect_bd_net -net InstructionDecode_adderOut [get_bd_pins adderOut] [get_bd_pins adder_1/adderOut]
  connect_bd_net -net InstructionDecode_outData [get_bd_pins ID_EX_0/signExt] [get_bd_pins shiftLeft_0/inData] [get_bd_pins signExtern_0/outData]
  connect_bd_net -net InstructionDecode_rdData2op [get_bd_pins rdData2op] [get_bd_pins ID_EX_0/rdData2op]
  connect_bd_net -net InstructionDecode_signExtop [get_bd_pins signExtop] [get_bd_pins ID_EX_0/signExtop]
  connect_bd_net -net InstructionFetch_pcOut [get_bd_pins op2] [get_bd_pins adder_1/op2]
  connect_bd_net -net RegFile_0_regRdData1 [get_bd_pins ID_EX_0/rdData1] [get_bd_pins RegFile_0/regRdData1] [get_bd_pins equalityChecker_0/data1]
  connect_bd_net -net RegFile_0_regRdData2 [get_bd_pins ID_EX_0/rdData2] [get_bd_pins RegFile_0/regRdData2] [get_bd_pins equalityChecker_0/data2]
  connect_bd_net -net alu_0_zeroFlag1 [get_bd_pins controlLogic_0/zeroFlag] [get_bd_pins equalityChecker_0/zeroflag]
  connect_bd_net -net controlLogic_0_aluOp [get_bd_pins controlLogic_0/aluOp] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net controlLogic_0_aluSrc [get_bd_pins controlLogic_0/aluSrc] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net controlLogic_0_jmpsrc [get_bd_pins controlLogic_0/jmpSrc] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net controlLogic_0_memToReg [get_bd_pins controlLogic_0/memToReg] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net controlLogic_0_memWrite [get_bd_pins controlLogic_0/memWrite] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net controlLogic_0_pcSrc [get_bd_pins controlLogic_0/pcSrc] [get_bd_pins xlconcat_0/In7]
  connect_bd_net -net controlLogic_0_regDst [get_bd_pins controlLogic_0/regDst] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net controlLogic_0_regWrite [get_bd_pins controlLogic_0/regWrite] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins ID_EX_0/clk] [get_bd_pins RegFile_0/i_clk]
  connect_bd_net -net mux_0_muxOut [get_bd_pins control] [get_bd_pins ID_EX_0/control]
  connect_bd_net -net mux_2_muxOut [get_bd_pins regWrData] [get_bd_pins RegFile_0/regWrData]
  connect_bd_net -net regWrAddr_1 [get_bd_pins regWrAddr] [get_bd_pins RegFile_0/regWrAddr]
  connect_bd_net -net shiftLeft_0_outData [get_bd_pins adder_1/op1] [get_bd_pins shiftLeft_0/outData]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout2] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins regWrEn] [get_bd_pins RegFile_0/regWrEn]
  connect_bd_net -net xlslice_0_Dout_1 [get_bd_pins Dout] [get_bd_pins ID_EX_0/IF_ID_RegisterRs] [get_bd_pins RegFile_0/regRdAddr1] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins Dout1] [get_bd_pins ID_EX_0/IF_ID_RegisterRt] [get_bd_pins RegFile_0/regRdAddr2] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins ID_EX_0/IF_ID_RegisterRd] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins signExtern_0/inData] [get_bd_pins xlslice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: HazardDetectionUnit
proc create_hier_cell_HazardDetectionUnit { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_HazardDetectionUnit() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 ID_EX_Control
  create_bd_pin -dir I -from 4 -to 0 ID_EX_RegisterRt
  create_bd_pin -dir I -from 4 -to 0 IF_ID_RegisterRs
  create_bd_pin -dir I -from 4 -to 0 IF_ID_RegisterRt
  create_bd_pin -dir O IF_ID_Write
  create_bd_pin -dir O PCWrite
  create_bd_pin -dir I -from 9 -to 0 in1
  create_bd_pin -dir O -from 9 -to 0 muxOut

  # Create instance: HazardDetectionUnit_0, and set properties
  set block_name HazardDetectionUnit
  set block_cell_name HazardDetectionUnit_0
  if { [catch {set HazardDetectionUnit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $HazardDetectionUnit_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: mux_0, and set properties
  set block_name mux
  set block_cell_name mux_0
  if { [catch {set mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {10} \
 ] $mux_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {8} \
   CONFIG.NUM_PORTS {3} \
 ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {8} \
 ] $xlconstant_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {8} \
   CONFIG.DIN_TO {8} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {9} \
   CONFIG.DIN_TO {9} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create port connections
  connect_bd_net -net HazardDetectionUnit_0_ControlSrc [get_bd_pins HazardDetectionUnit_0/ControlSrc] [get_bd_pins mux_0/ctrl]
  connect_bd_net -net HazardDetectionUnit_0_IF_ID_Write [get_bd_pins IF_ID_Write] [get_bd_pins HazardDetectionUnit_0/IF_ID_Write]
  connect_bd_net -net HazardDetectionUnit_0_PCWrite [get_bd_pins PCWrite] [get_bd_pins HazardDetectionUnit_0/PCWrite]
  connect_bd_net -net ID_EX_0_controlop [get_bd_pins ID_EX_Control] [get_bd_pins HazardDetectionUnit_0/ID_EX_Control]
  connect_bd_net -net ID_EX_0_slicetsop [get_bd_pins ID_EX_RegisterRt] [get_bd_pins HazardDetectionUnit_0/ID_EX_RegisterRt]
  connect_bd_net -net mux_0_muxOut [get_bd_pins muxOut] [get_bd_pins mux_0/muxOut]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins in1] [get_bd_pins mux_0/in1] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net xlconcat_0_dout1 [get_bd_pins mux_0/in0] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_0_Dout_1 [get_bd_pins IF_ID_RegisterRs] [get_bd_pins HazardDetectionUnit_0/IF_ID_RegisterRs]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins IF_ID_RegisterRt] [get_bd_pins HazardDetectionUnit_0/IF_ID_RegisterRt]
  connect_bd_net -net xlslice_1_Dout1 [get_bd_pins xlconcat_0/In2] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ForwardingUnit
proc create_hier_cell_ForwardingUnit { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ForwardingUnit() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 Din
  create_bd_pin -dir I -from 9 -to 0 Din1
  create_bd_pin -dir I -from 4 -to 0 Ex_MEM_RegisterRd
  create_bd_pin -dir O -from 1 -to 0 ForwardA
  create_bd_pin -dir O -from 1 -to 0 ForwardB
  create_bd_pin -dir I -from 4 -to 0 ID_EX_RegisterRs
  create_bd_pin -dir I -from 4 -to 0 ID_EX_RegisterRt
  create_bd_pin -dir I -from 4 -to 0 MEM_WB_RegisterRd

  # Create instance: DataHazard_0, and set properties
  set block_name DataHazard
  set block_cell_name DataHazard_0
  if { [catch {set DataHazard_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $DataHazard_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {10} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create port connections
  connect_bd_net -net ForwardingUnit_ForwardA [get_bd_pins ForwardA] [get_bd_pins DataHazard_0/ForwardA]
  connect_bd_net -net ForwardingUnit_ForwardB [get_bd_pins ForwardB] [get_bd_pins DataHazard_0/ForwardB]
  connect_bd_net -net ID_EX_0_slicetsop [get_bd_pins ID_EX_RegisterRt] [get_bd_pins DataHazard_0/ID_EX_RegisterRt]
  connect_bd_net -net InsructionDecode_ID_EX_RegisterRs [get_bd_pins ID_EX_RegisterRs] [get_bd_pins DataHazard_0/ID_EX_RegisterRs]
  connect_bd_net -net InstructionExecute_RegWrtAddop [get_bd_pins Ex_MEM_RegisterRd] [get_bd_pins DataHazard_0/Ex_MEM_RegisterRd]
  connect_bd_net -net InstructionExecute_controlop [get_bd_pins Din] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net MEM_WB_0_controlsop [get_bd_pins Din1] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net regWrAddr_1 [get_bd_pins MEM_WB_RegisterRd] [get_bd_pins DataHazard_0/MEM_WB_RegisterRd]
  connect_bd_net -net xlslice_0_Dout1 [get_bd_pins DataHazard_0/Ex_MEM_RegWrite] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins DataHazard_0/MEM_WB_RegWrite] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set in_clock [ create_bd_port -dir I -type clk in_clock ]

  # Create instance: ForwardingUnit
  create_hier_cell_ForwardingUnit [current_bd_instance .] ForwardingUnit

  # Create instance: HazardDetectionUnit
  create_hier_cell_HazardDetectionUnit [current_bd_instance .] HazardDetectionUnit

  # Create instance: InstructionDecode
  create_hier_cell_InstructionDecode [current_bd_instance .] InstructionDecode

  # Create instance: InstructionExecute
  create_hier_cell_InstructionExecute [current_bd_instance .] InstructionExecute

  # Create instance: InstructionFetch
  create_hier_cell_InstructionFetch [current_bd_instance .] InstructionFetch

  # Create instance: Memory
  create_hier_cell_Memory [current_bd_instance .] Memory

  # Create instance: WriteBack
  create_hier_cell_WriteBack [current_bd_instance .] WriteBack

  # Create instance: jumpAddCalc
  create_hier_cell_jumpAddCalc [current_bd_instance .] jumpAddCalc

  # Create port connections
  connect_bd_net -net EX_MEM_0_wrtDataop [get_bd_pins InstructionExecute/wrtDataop] [get_bd_pins Memory/writeData]
  connect_bd_net -net ForwardingUnit_ForwardA [get_bd_pins ForwardingUnit/ForwardA] [get_bd_pins InstructionExecute/ctrl]
  connect_bd_net -net ForwardingUnit_ForwardB [get_bd_pins ForwardingUnit/ForwardB] [get_bd_pins InstructionExecute/ctrl1]
  connect_bd_net -net HazardDetectionUnit_0_IF_ID_Write [get_bd_pins HazardDetectionUnit/IF_ID_Write] [get_bd_pins InstructionFetch/IF_ID_Write]
  connect_bd_net -net HazardDetectionUnit_0_PCWrite [get_bd_pins HazardDetectionUnit/PCWrite] [get_bd_pins InstructionFetch/PCWrite]
  connect_bd_net -net ID_EX_0_controlop [get_bd_pins HazardDetectionUnit/ID_EX_Control] [get_bd_pins InstructionDecode/controlop] [get_bd_pins InstructionExecute/Din]
  connect_bd_net -net ID_EX_0_slicefeop [get_bd_pins InstructionDecode/ID_EX_RegisterRd] [get_bd_pins InstructionExecute/in1]
  connect_bd_net -net ID_EX_0_slicetsop [get_bd_pins ForwardingUnit/ID_EX_RegisterRt] [get_bd_pins HazardDetectionUnit/ID_EX_RegisterRt] [get_bd_pins InstructionDecode/ID_EX_RegisterRt] [get_bd_pins InstructionExecute/in0]
  connect_bd_net -net IF_ID_0_instructionOp [get_bd_pins InstructionDecode/Din] [get_bd_pins InstructionFetch/instructionOp] [get_bd_pins jumpAddCalc/Din1]
  connect_bd_net -net InsructionDecode_ID_EX_RegisterRs [get_bd_pins ForwardingUnit/ID_EX_RegisterRs] [get_bd_pins InstructionDecode/ID_EX_RegisterRs]
  connect_bd_net -net InsructionDecode_IF_Flush [get_bd_pins InstructionDecode/IF_Flush] [get_bd_pins InstructionFetch/IF_Flush]
  connect_bd_net -net InsructionDecode_dout1 [get_bd_pins InstructionFetch/in1] [get_bd_pins jumpAddCalc/dout]
  connect_bd_net -net InsructionDecode_rdData1op [get_bd_pins InstructionDecode/rdData1op] [get_bd_pins InstructionExecute/in3]
  connect_bd_net -net InstructionDecode_adderOut [get_bd_pins InstructionDecode/adderOut] [get_bd_pins InstructionFetch/in2]
  connect_bd_net -net InstructionDecode_rdData2op [get_bd_pins InstructionDecode/rdData2op] [get_bd_pins InstructionExecute/wrtData]
  connect_bd_net -net InstructionDecode_signExtop [get_bd_pins InstructionDecode/signExtop] [get_bd_pins InstructionExecute/in2]
  connect_bd_net -net InstructionExecute_RegWrtAddop [get_bd_pins ForwardingUnit/Ex_MEM_RegisterRd] [get_bd_pins InstructionExecute/RegWrtAddop] [get_bd_pins Memory/regWrtAdd]
  connect_bd_net -net InstructionExecute_aluop [get_bd_pins InstructionExecute/aluop] [get_bd_pins Memory/writeAddress]
  connect_bd_net -net InstructionExecute_controlop [get_bd_pins ForwardingUnit/Din] [get_bd_pins InstructionExecute/controlop] [get_bd_pins Memory/Din]
  connect_bd_net -net InstructionFetch_pcOut [get_bd_pins InstructionDecode/op2] [get_bd_pins InstructionFetch/pcOut] [get_bd_pins jumpAddCalc/Din]
  connect_bd_net -net MEM_WB_0_aluop [get_bd_pins Memory/aluop] [get_bd_pins WriteBack/in0]
  connect_bd_net -net MEM_WB_0_controlsop [get_bd_pins ForwardingUnit/Din1] [get_bd_pins Memory/controlsop] [get_bd_pins WriteBack/Din]
  connect_bd_net -net MEM_WB_0_rdDataop [get_bd_pins Memory/rdDataop] [get_bd_pins WriteBack/in1]
  connect_bd_net -net i_clk_0_1 [get_bd_ports in_clock] [get_bd_pins InstructionDecode/in_clock] [get_bd_pins InstructionExecute/in_clock] [get_bd_pins InstructionFetch/in_clock] [get_bd_pins Memory/in_clock]
  connect_bd_net -net mux_0_muxOut [get_bd_pins HazardDetectionUnit/muxOut] [get_bd_pins InstructionDecode/control]
  connect_bd_net -net mux_2_muxOut [get_bd_pins InstructionDecode/regWrData] [get_bd_pins InstructionExecute/in4] [get_bd_pins WriteBack/muxOut]
  connect_bd_net -net regWrAddr_1 [get_bd_pins ForwardingUnit/MEM_WB_RegisterRd] [get_bd_pins InstructionDecode/regWrAddr] [get_bd_pins Memory/regWrtAddop]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins HazardDetectionUnit/in1] [get_bd_pins InstructionDecode/dout2] [get_bd_pins InstructionFetch/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins InstructionDecode/regWrEn] [get_bd_pins WriteBack/Dout]
  connect_bd_net -net xlslice_0_Dout_1 [get_bd_pins HazardDetectionUnit/IF_ID_RegisterRs] [get_bd_pins InstructionDecode/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins HazardDetectionUnit/IF_ID_RegisterRt] [get_bd_pins InstructionDecode/Dout1]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



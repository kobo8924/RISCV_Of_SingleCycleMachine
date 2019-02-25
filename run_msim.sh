#!/bin/sh

PRJ_NAME=RISCV_Of_SingleCycleMachine
TOP_NAME=ScmOfRISCV_tb
WORK_DIR=work
SCRIPT_HOME=$(pwd)
RTL=rtl
INCLUDE=+incdir+./$RTL/def.h

# Modelsim UImode argument(CUI(-c) or GUI(-g))
MODE=$1
REMOVE_F=$1


# Remove file 
if [ $REMOVE_F = -R ]; then
   rm -rf modelsim.ini transcript vsim.wlf ./work
else
    # Create work directory
    if [ ! -d $WORK_DIR ]; then
	vlib $WORK_DIR
	vmap $PRJ_NAME "./$WORK_DIR"
    fi

    # Compile
    vlog  -work $PRJ_NAME -sv -incr $INCLUDE ./$RTL/*.sv
    #vlog  -work $PRJ_NAME -sv -incr $INCLUDE ./rtl/InstructionMemory.sv

    # Run modelsim
    # Select Modelsim UImode(-c or -g).
    if [ $MODE = -c ]; then
	echo "=====  CUI MODE ====="
	vsim $TOP_NAME -c -lib $PRJ_NAME -do "run -all;quit"
    else
	echo "=====  GUI MODE ====="
	vsim  $TOP_NAME -lib $PRJ_NAME -do "add wave -position insertpoint sim:/$TOP_NAME/*"
    fi
fi


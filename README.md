
# @2019/03/20
### Auther k0b0

###
This is a RISC-V of single cycle machine.

# [Simulation environment]
- Quartus Prime 18.1
- ModelSim - Intel FPGA Edition vlog 10.5b Compiler

# [Description of each directory] ###
- FpgaOfRISCV : Directory for logic synthesis and placement and routing with Quartus prime.
- rtl         : RTL code directory.
- README      : README
- run_msim.sh : Script file for compilation and simulation.

# [Compile and Simulation method]

## Move to work directory.
$ cd $HOME/RISCV_Of_SingleCycleMachine

## When simulating in CUI mode.
$ ./run_msim.sh -c

## When simulating in GUI mode.
$ ./run_msim.sh

## Delete the created simulation file.
$ ./run_msim.sh -R

# [Other]


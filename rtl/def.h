//
// def.h
//
//
// Ports:
// ================================================
// Name          I/O   SIZE   props
// ================================================
// ================================================
// 
//
//
//

`define IMEM_FILE_PATH "$HOME/mydir/RISCV_Of_SingleCycleMachine/rtl/imem.dat"
`define DMEM_FILE_PATH "$HOME/mydir/RISCV_Of_SingleCycleMachine/rtl/dmem.dat"


`define INST_W 32

`define DATA_W 64

`define FUNCT_3_W 3

`define OPCODE_W 7        // Width of opcode

`define DMEM_ADDRESS_W 64 // Width of DMEM Address
//`define DMEM_ADDRESS_W 4 // Width of DMEM Address

`define IMEM_ADDR_W 5     // Width of Instruction Memory Address
`define IMEM_W 32         // Width of Instruction Memory Word

`define REG_W 5           // Width of RF Address

`define ALU_SEL_W 6       // Width of ALU_SEL

// ALU OPcode
`define ALU_AND  `ALU_SEL_W'b000000
`define ALU_OR   `ALU_SEL_W'b000001
`define ALU_ADD  `ALU_SEL_W'b000010
`define ALU_SUB  `ALU_SEL_W'b000110
`define ALU_XOR  `ALU_SEL_W'b000111
`define ALU_BNE  `ALU_SEL_W'b001000
`define ALU_BLT  `ALU_SEL_W'b001001
`define ALU_BGE  `ALU_SEL_W'b001010
`define ALU_BLTU `ALU_SEL_W'b001011
`define ALU_BGEU `ALU_SEL_W'b001100


//`define ALU_CMP `ALU_SEL_W'b000111
//`define ALU_NOR `ALU_SEL_W'b001010

//============================================
// test_code parameter for instruction memory.
//============================================

// Regr-Imm
parameter REG_IMM = `OPCODE_W'b0010011;

parameter ADDI  = `FUNCT_3_W'b000;
parameter SLTI  = `FUNCT_3_W'b010;
parameter SLTIU = `FUNCT_3_W'b011;
parameter XORI  = `FUNCT_3_W'b100;
parameter ORI   = `FUNCT_3_W'b110;
parameter ANDI  = `FUNCT_3_W'b111;


// Reg-Reg
parameter REG_REG=`OPCODE_W'b0110011;



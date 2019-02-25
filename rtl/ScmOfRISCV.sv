//
//
//
// 2018/04/12
// Written by k0b0
// ScmOfRISCV.sv
// RISCV of SingleCycleMachine
//
//
// Ports:
// ================================================
// Name          I/O   SIZE   props
// ================================================
//
// ================================================
// 
//



`include "def.h"


module ScmOfRISCV (input logic clk,
		   input logic reset);

logic [`IMEM_ADDR_W-1:0] pc;
logic [`IMEM_ADDR_W-1:0] next_pc;
logic [`INST_W-1:0]      instruction;

logic [`OPCODE_W-1:0] opcode;
logic [`REG_W-1:0]    rd;
logic [`REG_W-1:0]    rs1;
logic [`REG_W-1:0]    rs2;
logic [3:0]           alu_ctrl_in;

logic [`DATA_W-1:0]    Readdata1;
logic [`DATA_W-1:0]    Readdata2;
logic [`DATA_W-1:0]    Writedata;
logic [`ALU_SEL_W-1:0] ALUctl;

logic [`DATA_W-1:0]    Immgen;
logic [`DATA_W-1:0]    RegOrConst;
logic [`DATA_W-1:0]    ALUOut;
logic [`DATA_W-1:0]    Dest_data;
logic [`DATA_W-1:0]    Dmem_dataread;

// logic [11:0]           imm;

logic ALUSrc;
logic MemtoReg;
logic RegWrite;
logic MemRead;
logic MemWrite;
logic Branch;
logic ALUOp1;
logic ALUOp0;

logic Zero_flg;

logic [7:0] Control_sigs; // Debug signals


// instruction is from the module InstructionMemory output signals.
assign opcode = instruction[6:0];
assign rd     = instruction[11:7];
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];

//assign imm    = instruction[31:20];

//assign Immgen = {32'd0, imm};

// ImmGen
// Select immedeate by OPCODE.
ImmGen ImmGen_0 (.Inst   (instruction), 
                 .Opcode (opcode),
                 .Imm    (Immgen));


// funct7 of 1bit and funct3.
assign alu_ctrl_in = {instruction[30], instruction[14:12]};

// PC
always_ff @(posedge clk, negedge reset)
begin
    if(!reset) pc <= 0;
    else       pc <= next_pc;
end

assign next_pc = (!(Zero_flg & Branch))? (pc+1) : (pc + (Immgen << 1));

// parameter ADRESS = 5, INSTRUCTION = 32
// [ADRESS-1:0]      Readaddress
// [INSTRUCTION-1:0] Instruction
InstructionMemory InstructionMemory_0(.Readaddress (pc),
                                      .Instruction (instruction));


// [6:0] Instruction_opcode
//       ALUSrc
//       MemtoReg
//       RegWrite
//       MemRead
//       MemWrite
//       Branch
//       ALUOp1
//       ALUOp0
Control Control_0(.Instruction_opcode (opcode),
                  .ALUSrc             (ALUSrc),
	          .MemtoReg           (MemtoReg),
	          .RegWrite           (RegWrite),
	          .MemRead            (MemRead),
	          .MemWrite           (MemWrite),
	          .Branch             (Branch),
	          .ALUOp1             (ALUOp1),
	          .ALUOp0             (ALUOp0));
// Debug signal
assign Control_sigs = {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0};


// #(parameter REG_W=5, DATA_W=64)
//              clk
// [REG_W-1:0]  Readregister1, // Read Register Address1
// [REG_W-1:0]  Readregister2, // Read Register Address2
// [REG_W-1:0]  Writeregister, // Write Register Address
//              RegWrite,      // Write Enable
// [DATA_W-1:0] Writedata,     // Write Data
// [DATA_W-1:0] Readdata1,     // Read Data 1
// [DATA_W-1:0] Readdata2);    // Read Data 2
Registers Registers_0(.clk           (clk),
		      .Readregister1 (rs1),
		      .Readregister2 (rs2),
		      .Writeregister (rd),
		      .RegWrite      (RegWrite),
		      .Writedata     (Dest_data),
		      .Readdata1     (Readdata1),
		      .Readdata2     (Readdata2));

// MUX
// ALUSrc == 0 : Readdata2
// ALUSrc == 1 : Immgen
assign  RegOrConst = (!ALUSrc) ? Readdata2:Immgen;


// [3:0] Inst (from {Instruction{30,14:12}})
// [1:0] AUUOp (from Control)
// [3:0] ALUCtl (To ALU)
ALUControl ALUControl_0(.Inst   (alu_ctrl_in),
                        .ALUOp  ({ALUOp1,ALUOp0}),
		        .ALUCtl (ALUctl));


// [3:0] ALUctl
// [63:0] A, B
// [63:0] ALUOut
//        Zero
ALU ALU_0(.ALUctl (ALUctl),
	  .A      (Readdata1),
	  .B      (RegOrConst),
	  .ALUOut (ALUOut),
	  .Zero   (Zero_flg));


// #(parameter N = 64, M = 64)
//            clk,
//    	      MemWrite,
//    [N-1:0] Address,
//    [M-1:0] Writedata,
//    [M-1:0] Readdata);
DataMemory DMEM_0(.clk       (clk),
                  .MemWrite  (MemWrite),
	          .Address   (ALUOut),
	          .Writedata (Readdata2),
	          .Readdata  (Dmem_dataread));

// MUX
assign Dest_data = (MemtoReg)? Dmem_dataread:ALUOut;

endmodule

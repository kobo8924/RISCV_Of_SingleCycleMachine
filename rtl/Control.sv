//
// Control.sv (Decode to Instruction.)
// 2018/04/19
//
//
// Ports:
// ================================================
// Name                  I/O   SIZE   props
// ================================================
// Instruction_opcode     I     7     OPCODE
// ALUSrc                 O     1
// MemtoReg               O     1
// RegWrite               O     1
// MemRead                O     1
// MemWrite               O     1
// Branch                 O     1
// ALUOp1                 O     1
// ALUOp0                 O     1
// ================================================
// 
//



`include "def.h"

module Control (input  logic [`OPCODE_W-1:0] Instruction_opcode,
	        output logic                 ALUSrc,
		output logic                 MemtoReg,
	        output logic                 RegWrite,
	        output logic                 MemRead,
	        output logic                 MemWrite,
	        output logic                 Branch,
	        output logic                 ALUOp1,
	        output logic                 ALUOp0);

logic [7:0] Control_sigs;

// Decode instruction
always_comb
begin
    casex(Instruction_opcode)
     `OPCODE_W'b0110011 : Control_sigs = 8'b00100010; // R-format
     `OPCODE_W'b0010011 : Control_sigs = 8'b10100011; // Imm
     `OPCODE_W'b0000011 : Control_sigs = 8'b11110000; // ld
     `OPCODE_W'b0100011 : Control_sigs = 8'b1x001000; // sd
     `OPCODE_W'b1100011 : Control_sigs = 8'b0x000101; // beq
                default : Control_sigs = 8'b00000000; // Error
    endcase
end


assign {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0} = Control_sigs;

endmodule

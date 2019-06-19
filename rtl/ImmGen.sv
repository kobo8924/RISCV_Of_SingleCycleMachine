//
// 2019/01/14
// ALUControl.sv
// Written by k0b0 
//
//
//
// Ports:
// ================================================
// Name          I/O   SIZE   props
// ================================================
// Inst            I     32   
// Opcode          I      7
// Imm             O     64
// ================================================
// 
//

`ifndef DEF_HEADDER
    `include "def.h"
    `define DEF_HEADDER
`endif


module ImmGen (input  logic [`INST_W-1:0]   Inst, 
               input  logic [`OPCODE_W-1:0] Opcode, // from Control
	       output logic [`DATA_W-1:0]   Imm);



always_comb
begin
    casex (Opcode)
	`OPCODE_W'b0110111 : Imm = {44'd0, Inst[31:12]};             // LUI
	`OPCODE_W'b0010111 : Imm = {44'd0, Inst[31:12]};             // AUIPC
	`OPCODE_W'b1101111 : Imm = {44'd0, Inst[31:12]};             // JAL
	`OPCODE_W'b1100111 : Imm = {52'd0, Inst[31:20]};             // JALR
	`OPCODE_W'b1100011 : Imm = {52'd0, Inst[31:25], Inst[11:7]}; // br
	`OPCODE_W'b0000011 : Imm = {52'd0, Inst[31:20]};             // ld
	`OPCODE_W'b0010011 : Imm = {52'd0, Inst[31:20]};             // Reg-imm
	`OPCODE_W'b0100011 : Imm = {52'd0, Inst[31:25], Inst[11:7]}; // sd
	         default   : Imm = `DATA_W'd0; // Other
    endcase
end


/*
always_comb
begin
     casex ({ALUOp,Inst})
	 6'b00xxxx : ALUCtl = `ALU_ADD; // add (ld, sd)
	 6'b01xxxx : ALUCtl = `ALU_SUB; // sub (beq)
	 6'b1x0000 : ALUCtl = `ALU_ADD; // add (add)
	 6'b1x1000 : ALUCtl = `ALU_SUB; // sub (sub)
	 6'b1x0111 : ALUCtl = `ALU_AND; // and 
	 6'b1x0110 : ALUCtl = `ALU_OR;  // or  
         6'b1x0100 : ALUCtl = `ALU_XOR; // XOR  
         default   : ALUCtl = `ALU_SEL_W'b000000; // ERROR
     endcase
end
*/


endmodule

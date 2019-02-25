//
// 2018/03/27
// ALUControl.sv
// Written by k0b0 
//
//
//
// Ports:
// ================================================
// Name          I/O   SIZE   props
// ================================================
// Inst            I      4   {funct7Of1bit, funct3}
// ALUOp           I      2
// ALUCtl          O      6
// ================================================
// 
//

/**
*
* ALUOp is Number of type of operation.
* RV32I have 11 type operation and 41 instructions.
*
**/


`include "def.h"

module ALUControl(input  logic [3:0]            Inst,  // from {Instruction{30,14:12}}
                  input  logic [1:0]            ALUOp, // from Control
	          output logic [`ALU_SEL_W-1:0] ALUCtl); // To ALU

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

/*
always_comb
begin
    casex ({ALUOp,Inst})
     6'b00xxxx : ALUCtl = `ALU_ADD;  // ADD (LD, SD)
     6'b01xxxx : ALUCtl = `ALU_SUB;  // SUB (BEQ)
     6'b100000 : ALUCtl = `ALU_ADD;  // ADD (ADD)
     6'b101000 : ALUCtl = `ALU_SUB;  // SUB (SUB)
     6'b100111 : ALUCtl = `ALU_AND;  // AND
     6'b100110 : ALUCtl = `ALU_OR;   // OR  
     6'b100100 : ALUCtl = `ALU_XOR;  // XOR  

     6'b110000 : ALUCtl = `ALU_ADDI; // ADDI  
     6'b110100 : ALUCtl = `ALU_XORI; // XORI  
     6'b110110 : ALUCtl = `ALU_ORI;  // ORI  
     6'b110111 : ALUCtl = `ALU_ANDI; // ANDI  
     default   : ALUCtl = `ALU_SEL_W'b000000; // ERROR
    endcase
end
*/

endmodule

//
// 2018/03/24
// ALU.sv
// writen by k0b0
//
// 
// Ports:
// Name          I/O   SIZE   props
// ALUctl          I      6 
// A               I     64
// B               I     64
// ALU_Out         O     64
// Zero            O      1
//
//


`include "def.h"

module ALU (input  logic [`ALU_SEL_W-1:0] ALUctl, 
            input  logic [`DATA_W-1:0]    A, B, 
            output logic [`DATA_W-1:0]    ALUOut, 
            output                        Zero);

//logic [`DATA_W-1:0] OUTsig;

//assign ALUOut = OUTsig;

assign Zero = (ALUOut == 0);

always_comb
begin
    case(ALUctl)
	`ALU_AND  : ALUOut <= A & B;
	`ALU_OR   : ALUOut <= A | B;
	`ALU_XOR  : ALUOut <= A ^ B;
	`ALU_ADD  : ALUOut <= A + B;
	`ALU_SUB  : ALUOut <= A - B;
	//`ALU_CMP : ALUOut <= (A < B)? 1:0;
	//`ALU_NOR : ALUOut <= ~(A | B);
	default  : ALUOut <= 0;
    endcase
end

endmodule

//
// Registers.sv
//
//
// Ports:
// ================================================
// Name          I/O   SIZE   props
// ================================================
//
//
// ================================================
// 
//


`include "def.h"

module Registers (input                clk,
                  input  [`REG_W-1:0]  Readregister1, // Read Register Address1
                  input  [`REG_W-1:0]  Readregister2, // Read Register Address2
                  input  [`REG_W-1:0]  Writeregister, // Write Register Address
                  input                RegWrite,      // Write Enable
                  input  [`DATA_W-1:0] Writedata,     // Write Data
	          output [`DATA_W-1:0] Readdata1,     // Read Data 1
	          output [`DATA_W-1:0] Readdata2);    // Read Data 2

logic [`DATA_W-1:0] r0 = 0;
logic [`DATA_W-1:0] r1 = 0;
logic [`DATA_W-1:0] r2 = 0;
logic [`DATA_W-1:0] r3 = 0;
logic [`DATA_W-1:0] r4 = 0;
logic [`DATA_W-1:0] r5 = 0;
logic [`DATA_W-1:0] r6 = 0;
logic [`DATA_W-1:0] r7 = 0;
logic [`DATA_W-1:0] r8 = 0;
logic [`DATA_W-1:0] r9 = 0;
logic [`DATA_W-1:0] r10 = 0;
logic [`DATA_W-1:0] r11 = 0;
logic [`DATA_W-1:0] r12 = 0;
logic [`DATA_W-1:0] r13 = 0;
logic [`DATA_W-1:0] r14 = 0;
logic [`DATA_W-1:0] r15 = 0;
logic [`DATA_W-1:0] r16 = 0;
logic [`DATA_W-1:0] r17 = 0;
logic [`DATA_W-1:0] r18 = 0;
logic [`DATA_W-1:0] r19 = 0;
logic [`DATA_W-1:0] r20 = 0;
logic [`DATA_W-1:0] r21 = 0;
logic [`DATA_W-1:0] r22 = 0;
logic [`DATA_W-1:0] r23 = 0;
logic [`DATA_W-1:0] r24 = 0;
logic [`DATA_W-1:0] r25 = 0;
logic [`DATA_W-1:0] r26 = 0;
logic [`DATA_W-1:0] r27 = 0;
logic [`DATA_W-1:0] r28 = 0;
logic [`DATA_W-1:0] r29 = 0;
logic [`DATA_W-1:0] r30 = 0;
logic [`DATA_W-1:0] r31 = 0;

/*
parameter NUM_OF_REG = 32;
genvar i;
generate
for(i = 0; i < NUM_OF_REG; i = i + 1) 
begin: GenerateRegister
    logic [`DATA_W-1:0] r0;
end
endgenerate
*/

	/* Reading Register 1 */
	assign Readdata1 = Readregister1 ==  0 ? r0:
			   Readregister1 ==  1 ? r1:
			   Readregister1 ==  2 ? r2:
			   Readregister1 ==  3 ? r3:
			   Readregister1 ==  4 ? r4:
			   Readregister1 ==  5 ? r5:
			   Readregister1 ==  6 ? r6: 
			   Readregister1 ==  7 ? r7: 
			   Readregister1 ==  8 ? r8: 
			   Readregister1 ==  9 ? r9: 
			   Readregister1 == 10 ? r10: 
			   Readregister1 == 11 ? r11: 
			   Readregister1 == 12 ? r12: 
			   Readregister1 == 13 ? r13: 
			   Readregister1 == 14 ? r14: 
			   Readregister1 == 15 ? r15: 
			   Readregister1 == 16 ? r16: 
			   Readregister1 == 17 ? r17: 
			   Readregister1 == 18 ? r18: 
			   Readregister1 == 19 ? r19: 
			   Readregister1 == 20 ? r20: 
			   Readregister1 == 21 ? r21: 
			   Readregister1 == 22 ? r22: 
			   Readregister1 == 23 ? r23: 
			   Readregister1 == 24 ? r24: 
			   Readregister1 == 25 ? r25: 
			   Readregister1 == 26 ? r26: 
			   Readregister1 == 27 ? r27: 
			   Readregister1 == 28 ? r28: 
			   Readregister1 == 29 ? r29: 
			   Readregister1 == 30 ? r30:r31;

	/* Reading Register 2 */
	assign Readdata2 = Readregister2 ==  0 ? r0:
			   Readregister2 ==  1 ? r1:
			   Readregister2 ==  2 ? r2:
			   Readregister2 ==  3 ? r3:
			   Readregister2 ==  4 ? r4:
			   Readregister2 ==  5 ? r5:
			   Readregister2 ==  6 ? r6: 
			   Readregister2 ==  7 ? r7: 
			   Readregister2 ==  8 ? r8: 
			   Readregister2 ==  9 ? r9: 
			   Readregister2 == 10 ? r10: 
			   Readregister2 == 11 ? r11: 
			   Readregister2 == 12 ? r12: 
			   Readregister2 == 13 ? r13: 
			   Readregister2 == 14 ? r14: 
			   Readregister2 == 15 ? r15: 
			   Readregister2 == 16 ? r16: 
			   Readregister2 == 17 ? r17: 
			   Readregister2 == 18 ? r18: 
			   Readregister2 == 19 ? r19: 
			   Readregister2 == 20 ? r20: 
			   Readregister2 == 21 ? r21: 
			   Readregister2 == 22 ? r22: 
			   Readregister2 == 23 ? r23: 
			   Readregister2 == 24 ? r24: 
			   Readregister2 == 25 ? r25: 
			   Readregister2 == 26 ? r26: 
			   Readregister2 == 27 ? r27: 
			   Readregister2 == 28 ? r28: 
			   Readregister2 == 29 ? r29: 
			   Readregister2 == 30 ? r30:r31;

        /* Writing data */
	always_ff @(posedge clk) 
	begin
	    if(RegWrite) 
	    begin
		case(Writeregister) 
		    //0: r0  <= Writedata; // r0 is zero resister.
		    1: r1  <= Writedata;
		    2: r2  <= Writedata;
		    3: r3  <= Writedata;
		    4: r4  <= Writedata;
		    5: r5  <= Writedata;
		    6: r6  <= Writedata;
		    7: r7  <= Writedata;
		    8: r8  <= Writedata;
		    9: r9  <= Writedata;
		   10: r10 <= Writedata;
		   11: r11 <= Writedata;
		   12: r12 <= Writedata;
		   13: r13 <= Writedata;
		   14: r14 <= Writedata;
		   15: r15 <= Writedata;
		   16: r16 <= Writedata;
		   17: r17 <= Writedata;
		   18: r18 <= Writedata;
		   19: r19 <= Writedata;
		   20: r20 <= Writedata;
		   21: r21 <= Writedata;
		   22: r22 <= Writedata;
		   23: r23 <= Writedata;
		   24: r24 <= Writedata;
		   25: r25 <= Writedata;
		   26: r26 <= Writedata;
		   27: r27 <= Writedata;
		   28: r28 <= Writedata;
		   29: r29 <= Writedata;
		   30: r30 <= Writedata;
		   31: r31 <= Writedata;
		   default : r0 <= `DATA_W'd0;
		endcase
	    end
	end
endmodule

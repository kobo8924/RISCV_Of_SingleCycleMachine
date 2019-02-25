/*
** 2018/04/12
** Written by kobo
** ScmOfRISCV.sv
** RISCV of SingleCycleMachine
**
*/

module ScmOfRISCV();


// [6:0] Instruction_opcode
//       ALUSrc
//       MemtoReg
//       RegWrite
//       MemRead
//       MemWrite
//       Branch
//       ALUOp1
//       ALUOp0
Control Control_0(.Instruction_opcode(),
                  .ALUSrc(),
	          .MemtoReg(),
	          .RegWrite(),
	          .MemRead(),
	          .MemWrite(),
	          .Branch(),
	          .ALUOp1(),
	          .ALUOp0());



// #(parameter REG_W=5, DATA_W=64)
//              clk
// [REG_W-1:0]  Readregister1, // Read Register Address1
// [REG_W-1:0]  Readregister2, // Read Register Address2
// [REG_W-1:0]  Writeregister, // Write Register Address
//              RegWrite,      // Write Enable
// [DATA_W-1:0] Writedata,     // Write Data
// [DATA_W-1:0] Readdata1,     // Read Data 1
// [DATA_W-1:0] Readdata2);    // Read Data 2
Registers Registers_0(.clk(),
		      .Readregister1(),
		      .Readregister2(),
		      .Writeregister(),
		      .RegWrite(),
		      .Writedata(),
		      .Readdata1(),
		      .Readdata2());

// [3:0] Inst (from {Instruction{30,14:12}})
// [1:0] AUUOp (from Control)
// [3:0] ALUCtl (To ALU)
ALUControl ALUControl_0(.Inst(),
		        .ALUOp(),
		        .ALUCtl());

// [3:0] ALUctl
// [63:0] A, B
// [64:0] ALUOut
//        Zero
ALU ALU_0(.ALUctl(),
	  .A(),
	  .B(),
	  .ALUOut(),
	  .Zero());


// #(parameter N = 64, M = 64)
//            clk,
//    	      MemWrite,
//    [N-1:0] Address,
//    [M-1:0] Writedata,
//    [M-1:0] Readdata);
DataMemory DMEM_0(.clk(),
                  .MemWrite(),
	          .Address(),
	          .Writedata(),
	          .Readdata());


endmodule

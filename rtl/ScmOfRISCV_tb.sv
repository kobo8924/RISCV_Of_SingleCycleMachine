//
// 2018/05/01
// ScmOfRISCV_tb.sv
// Written by k0b0
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


`timescale 1ps/1ps
`include "def.h"

module ScmOfRISCV_tb;

parameter CYCLE = 10;

logic clk;
logic reset;

integer cnt = 0;

//string OP = "";
string alu_op = "";

ScmOfRISCV RISCV_0(.clk   (clk),
                   .reset (reset));

// Clock Genereate.
always #(CYCLE/2) clk = ~clk;


initial
begin
    $display("=== Start Of Simulation. ===");
    SYSTEM_RESET();
    
    while(cnt < 10)
    begin
	DISPLAY_SIGNAL(); #(CYCLE);
	cnt = cnt + 1;
    end

    

    $display("=== End Of Simulation. ===");
    $finish;
end

/* System Reset */
task SYSTEM_RESET;
    $display("======================================================");
    $display("Time:%dps : SYSTEM RESET.", $time);
    #0 clk = 1'b0;
    #(CYCLE/2) reset = 1'b0; 
    #(CYCLE/2) reset = 1'b1; 
    $display("Time:%dps : SYSTEM RESET COMPLETE.", $time);
    $display("======================================================");
endtask

/* Display Signals */
task DISPLAY_SIGNAL;
    $display("==========================================================================");
    $display("Time:%2dps CLK:%1d PC:%2d Instruction:%b", $time,clk,RISCV_0.pc, RISCV_0.instruction);

    SHOW_CONTROL_SIGS();
    SHOW_REGISTER_SIGS();
    SHOW_ALU_SIGS();
    SHOW_DMEM_SIGS();

    $display("");
endtask

task SHOW_CONTROL_SIGS;
    $display("=== Control Sigs==========================================================");
    $display("ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0");
    $display("%d\t  %d\t    %d\t      %d\t       %d\t %d\t %d\t %d\t", RISCV_0.ALUSrc, RISCV_0.MemtoReg, RISCV_0.RegWrite, RISCV_0.MemRead, RISCV_0.MemWrite, RISCV_0.Branch, RISCV_0.ALUOp1, RISCV_0.ALUOp0);
endtask

task SHOW_REGISTER_SIGS;
    $display("=== Register Sig s========================================================");
    $display("rs1:%d rs2:%d rd:%d", RISCV_0.rs1, RISCV_0.rs2, RISCV_0.rd);
endtask


task SHOW_ALU_SIGS;
    SELECT_OP();
    $display("=== ALU Sig s=============================================================");
    $display("Operation : %s A:%2d B:%2d ALUout:%3d ZeroFlg:%1d",  alu_op, RISCV_0.Readdata1, RISCV_0.RegOrConst, RISCV_0.ALUOut, RISCV_0.Zero_flg);
endtask

task SHOW_DMEM_SIGS;
    $display("=== DMEM Sigs ============================================================");
    $display("Address:%2d Writedata:%2d Readdata:%2d ",  RISCV_0.ALUOut, RISCV_0.Readdata2, RISCV_0.Dmem_dataread);
    $display("==========================================================================");
endtask



task SELECT_OP;
    // instruction[31:20] : funct7
    // instruction[14:12] : funct3
    // instruction[6:0]   : opcode
    casex({RISCV_0.instruction[31:20], RISCV_0.instruction[14:12], RISCV_0.instruction[6:0]})
	22'bxxxxxxxxxxxx_000_0000011  : alu_op = "LB";
	22'bxxxxxxxxxxxx_001_0000011  : alu_op = "LH";
	22'bxxxxxxxxxxxx_010_0000011  : alu_op = "LW";
	22'bxxxxxxxxxxxx_011_0000011  : alu_op = "LBU";
	22'bxxxxxxxxxxxx_100_0000011  : alu_op = "LHU";
	22'bxxxxxxxxxxxx_000_0100011  : alu_op = "SB";
	22'bxxxxxxxxxxxx_001_0100011  : alu_op = "SH";
	22'bxxxxxxxxxxxx_010_0100011  : alu_op = "SW";
	22'bxxxxxxxxxxxx_000_0010011  : alu_op = "ADDI";
	22'bxxxxxxxxxxxx_010_0010011  : alu_op = "SLTI";
	22'bxxxxxxxxxxxx_011_0010011  : alu_op = "SLTIU";
	22'bxxxxxxxxxxxx_100_0010011  : alu_op = "XORI";
	22'bxxxxxxxxxxxx_110_0010011  : alu_op = "ORI";
	22'bxxxxxxxxxxxx_111_0010011  : alu_op = "ANDI";
	22'b0000000_xxxxx_001_0010011 : alu_op = "SLLI";
	22'b0000000_xxxxx_101_0010011 : alu_op = "SRLI";
	22'b0100000_xxxxx_101_0010011 : alu_op = "SRAI";
	22'b0000000_xxxxx_000_0110011 : alu_op = "ADD";
	22'b0100000_xxxxx_000_0110011 : alu_op = "SUB";
	22'b0000000_xxxxx_001_0110011 : alu_op = "SLL";
	22'b0000000_xxxxx_010_0110011 : alu_op = "SLT";
	22'b0000000_xxxxx_011_0110011 : alu_op = "SLTU";
	22'b0000000_xxxxx_100_0110011 : alu_op = "XOR";
	22'b0000000_xxxxx_101_0110011 : alu_op = "SRL";
	22'b0100000_xxxxx_101_0110011 : alu_op = "SRA";
	22'b0000000_xxxxx_110_0110011 : alu_op = "OR";
	22'b0000000_xxxxx_111_0110011 : alu_op = "AND";
	default                       : alu_op = "Unknow.";
    endcase

    /*
     case(RISCV_0.ALUctl)
	`ALU_AND : alu_op = "AND";
	`ALU_OR  : alu_op = "OR";
	`ALU_XOR : alu_op = "XOR";
	`ALU_ADD : alu_op = "ADD";
	`ALU_SUB : alu_op = "SUB";
	default  : alu_op = "error";
    endcase
    */
endtask


endmodule

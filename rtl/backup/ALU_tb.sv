

`timescale 1ps/1ps

module ALU_tb;

parameter CYCLE = 10;

logic [3:0]  ALUctl;
logic [63:0] A, B;
logic [63:0] ALUOut;
logic        Zero;


ALU ALU_0(.*);

initial
begin
    ALUctl = 4'd2; A = 64'd0; B = 64'd0; #(CYCLE);
    DISPLAY_SIG();

    ALUctl = 4'd2; A = 64'd0; B = 64'd1; #(CYCLE);
    DISPLAY_SIG();

    ALUctl = 4'd6; A = 64'd128; B = 64'd64; #(CYCLE);
    DISPLAY_SIG();

    ALUctl = 4'd6; A = 64'd128; B = 64'd32; #(CYCLE);
    DISPLAY_SIG();
end

task DISPLAY_SIG;
    begin
	$display("ALUCtl:%d, A:%d, B:%d, ALUOut:%d, Zero:%d", ALUctl,A,B,ALUOut,Zero);
    end
endtask

endmodule

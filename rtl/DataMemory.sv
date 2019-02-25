// 2018/08/19
// DataMemory.sv 
// Written by k0b0
//
//
//
//
// Ports:
// ================================================
// Name          I/O   SIZE   props
// ================================================
// clk             I      1   clock
//
// ================================================
// 
//



`include "def.h"

module DataMemory (input                        clk,
	           input                        MemWrite,
	           input  [`DATA_W-1:0]         Address,
	           input  [`DATA_W-1:0]         Writedata,
	           output [`DATA_W-1:0]         Readdata);

//配列数を2のべき乗にするとdmemからデータが読み出せなくなるので、配列数を減ら
//している
//logic [`DATA_W-1:0] dmem [2**`DATA_W-1:0] ;
logic [`DATA_W-1:0] dmem [0:31] ;


initial 
begin
        $readmemh(`DMEM_FILE_PATH, dmem);
end



always_ff @(posedge clk)
begin
    if(MemWrite) 
	dmem[Address] <= Writedata;
end

//assign Readdata = `DATA_W'd255;
//assign Readdata = dmem[1];
assign Readdata = dmem[Address];

endmodule

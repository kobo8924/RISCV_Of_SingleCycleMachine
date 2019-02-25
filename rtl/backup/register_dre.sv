
/* register_dre.sv */

`include "def.h"

module register_dre #(parameter WIDTH = `DATA_W)
                     (input  logic clk,
                      input  logic en,
                      input  logic reset,
		      input  logic [WIDTH-1:0] d,
	              output logic [WIDTH-1:0] q);

always_ff @(posedge clk, posedge reset)
begin
    if(reset)   q <= 4'b0000;
    else if(en) q <= d;
end
endmodule

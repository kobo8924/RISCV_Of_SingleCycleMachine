

`timescale 1 ps / 1 ps

`ifndef DEF_HEADDER
    `include "def.h"
    `define DEF_HEADDER
`endif


module single_port_ram_32 #(parameter D_WIDTH = `DATA_W, A_WIDTH = 8)
                           (input  [D_WIDTH-1:0] address,
	                    input  tri1          clock,
	                    input  [D_WIDTH-1:0] data,
	                    input	         wren,
			    output [D_WIDTH-1:0] q);


wire [D_WIDTH-1:0] sub_wire0;
assign q = sub_wire0;

altsyncram  altsyncram_component (.address_a      (address),
				  .clock0         (clock),
				  .data_a         (data),
				  .wren_a         (wren),
				  .q_a            (sub_wire0),
				  .aclr0          (1'b0),
				  .aclr1          (1'b0),
				  .address_b      (1'b1),
				  .addressstall_a (1'b0),
				  .addressstall_b (1'b0),
				  .byteena_a      (1'b1),
				  .byteena_b      (1'b1),
				  .clock1         (1'b1),
				  .clocken0       (1'b1),
				  .clocken1       (1'b1),
				  .clocken2       (1'b1),
				  .clocken3       (1'b1),
				  .data_b         (1'b1),
				  .eccstatus      (),
				  .q_b            (),
				  .rden_a         (1'b1),
				  .rden_b         (1'b1),
				  .wren_b         (1'b0));
	defparam
		altsyncram_component.clock_enable_input_a          = "BYPASS",
		altsyncram_component.clock_enable_output_a         = "BYPASS",
		altsyncram_component.intended_device_family        = "MAX 10",
		altsyncram_component.lpm_hint                      = "ENABLE_RUNTIME_MOD=NO",
		altsyncram_component.lpm_type                      = "altsyncram",
		altsyncram_component.numwords_a                    = 256,
		altsyncram_component.operation_mode                = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a                = "NONE",
		altsyncram_component.outdata_reg_a                 = "UNREGISTERED",
		altsyncram_component.power_up_uninitialized        = "FALSE",
		altsyncram_component.ram_block_type                = "M9K",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a                     = A_WIDTH,
		altsyncram_component.width_a                       = D_WIDTH,
		altsyncram_component.width_byteena_a               = 1;


endmodule

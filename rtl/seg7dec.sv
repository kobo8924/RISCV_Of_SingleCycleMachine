
`ifndef DEF_HEADDER
    `include "def.h"
    `define DEF_HEADDER
`endif


module seg7dec (
    input       [3:0]   din,
    output reg  [6:0]   nhex
);

/* 7セグメント表示デコーダ              */
/* 各セグメントはgfedcbaの並びで0で点灯 */
always @* begin
    case( din )
        4'h0:   nhex = 7'b1000000;
        4'h1:   nhex = 7'b1111001;
        4'h2:   nhex = 7'b0100100;
        4'h3:   nhex = 7'b0110000;
        4'h4:   nhex = 7'b0011001;
        4'h5:   nhex = 7'b0010010;
        4'h6:   nhex = 7'b0000010;
        4'h7:   nhex = 7'b1011000;
        4'h8:   nhex = 7'b0000000;
        4'h9:   nhex = 7'b0010000;
        4'ha:   nhex = 7'b0001000;
        4'hb:   nhex = 7'b0000011;
        4'hc:   nhex = 7'b1000110;
        4'hd:   nhex = 7'b0100001;
        4'he:   nhex = 7'b0000110;
        4'hf:   nhex = 7'b0001110;
        default:nhex = 7'b1111111;
    endcase
end

endmodule

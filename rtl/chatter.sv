
/* chatter.v */

`ifndef DEF_HEADDER
    `include "def.h"
    `define DEF_HEADDER
`endif


module chatter (
    input   CLK, RST,
    input   SW,
    output reg SW_OUT
);

/* 50MHzを1250000分周して40Hzを作る              */
/* en40hzはシステムクロック1周期分のパルスで40Hz */
reg [20:0] cnt;

wire en40hz = (cnt==1250000-1);

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 21'b0;
    else if ( en40hz )
        cnt <= 21'b0;
    else
        cnt <= cnt + 21'b1;
end

/*  ボタン入力をFF2個で受ける*/
reg [2:0] ff1, ff2;

always @( posedge CLK ) begin
    if ( RST ) begin
        ff2 <=3'b0;
        ff1 <=3'b0;
    end
    else if ( en40hz ) begin
        ff2 <= ff1;
        ff1 <= SW;
    end
end

/* ボタンは押すと0なので、立下りを検出 */
wire temp = ~ff1 & ff2 & en40hz;

/* 念のためFFで受ける */
always @( posedge CLK ) begin
    if ( RST )
        SW_OUT <=3'b0;
    else
        SW_OUT <=temp;
end

endmodule

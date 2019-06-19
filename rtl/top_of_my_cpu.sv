
/* top_of_cpu.v 
 *
 * このコードはピンアサイン("DE10-Lite_pin.qsf")と
 * 制約ファイル("top_of_my_cpu.sdc")に基づいて記述しています。
 *
 * */

`ifndef DEF_HEADDER
    `include "def.h"
    `define DEF_HEADDER
`endif


module top_of_my_cpu(input CLK,       // クロック
                     input RST,       // リセット(右から10番目にあるスイッチ)
		     input [2:0] KEY, // スイッチ (使用するのはKEY[0])
	             output [6:0] HEX0, HEX1, HEX2, HEX3); //7SEGの出力

wire [`IMEM_ADDR_W-1:0] pc_out_w;
wire [`DATA_W-1:0]      alu_out_w;
wire                    my_clk; 

/*************************************************
* チャタリング除去回路
* 手動クロック信号を実現するために、
* 入力スイッチ(KEY[0]:ボードのVGAの左隣にあるボタン)
* のノイズを消去して1パルス(my_clk)を出力する。
**************************************************/
chatter chatter_0(.CLK(CLK), .RST(RST), .SW(KEY[0]), .SW_OUT(my_clk));



/*************************************************
* my_cpu(設計したCPU)
* my_clkを接続してスイッチによる手動クロックで検証を行う
**************************************************/


ScmOfRISCV my_riscv_0(.clk     (my_clk), 
                      .reset   (RST),
		      .pc_out  (pc_out_w),
		      .alu_out (alu_out_w));



/*************************************************
* 7セグメントLED (6個)
* 入力DIN(4ビット)に表示させたい信号を接続する
**************************************************/

seg7dec seg7_0(.din(alu_out_w[3:0]), .nhex(HEX0)); // 右から1番目の7セグメントLED
seg7dec seg7_1(.din(alu_out_w[7:4]), .nhex(HEX1)); // 右から2番目の7セグメントLED

seg7dec seg7_2(.din(pc_out_w[3:0]), .nhex(HEX2)); // 右から3番目の7セグメントLED
seg7dec seg7_3(.din({3'd0, pc_out_w[4]}), .nhex(HEX3)); // 右から4番目の7セグメントLED

// seg7dec seg7_4(.din(), .nhex(HEX4)); // 右から5番目の7セグメントLED
// seg7dec seg7_5(.din(), .nhex(HEX5)); // 右から6番目の7セグメントLED

endmodule

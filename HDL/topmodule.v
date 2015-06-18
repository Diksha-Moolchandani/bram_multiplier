`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:17 06/12/2015 
// Design Name: 
// Module Name:    topmodule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module topmodule#(
	parameter DATA_WIDTH = 4,
	parameter MUL_WIDTH 	= 25,
	parameter BRAM_WIDTH = 18,
	parameter BRAM_ADDR 	= 12	
)(
	input  [DATA_WIDTH-1:0] dataA,
	input  [DATA_WIDTH-1:0] dataB,
	input 						clk,
	output [2*DATA_WIDTH-1:0] dataC
);
 
wire wrA,wrB;
wire [BRAM_ADDR-1:0] addra,addrb;
wire [BRAM_WIDTH-1:0] dina,dinb,douta,doutb;
wire [MUL_WIDTH-1:0]            a;
wire [BRAM_WIDTH-1:0]           b;
wire [MUL_WIDTH+BRAM_WIDTH-1:0] p;
wire start;


assign start = ({dataA,dataB}== 8'b11111111) ? 1'b1 :1'b0;

bram ram (
  .clka(clk), // input clka
  .wea(wrA), // input [0 : 0] wea
  .addra(addra), // input [11 : 0] addra
  .dina(dina), // input [17 : 0] dina
  .douta(douta), // output [17 : 0] douta
  .clkb(clk), // input clkb
  .web(wrB), // input [0 : 0] web
  .addrb(addrb), // input [11 : 0] addrb
  .dinb(dinb), // input [17 : 0] dinb
  .doutb(doutb) // output [17 : 0] doutb
);

controller_bram control (
	.dataA(dataA),
	.dataB(dataB),
	.dataC(dataC),
	.clk(clk),
	.start(start),
	.wrA(wrA),
	.dinA(dina),
	.addrA(addra),
	.doutA(douta),
	.wrB(wrB),
	.dinB(dinb),
	.addrB(addrb),
	.doutB(doutb),
	.A(a),
	.B(b),
	.C(p)
);

dsp dsp (
	.clk(clk), // input clk
	.a(a), // input [24 : 0] a
	.b(b), // input [17 : 0] b
	.p(p)); // ouput [42 : 0] p

endmodule

`timescale 1ns / 1ps
`define clkperiodby2 10

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:50:59 06/12/2015
// Design Name:   topmodule
// Module Name:   C:/Users/dell/Desktop/diksha/bram_multiplier/controller_tb.v
// Project Name:  bram_multiplier
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: topmodule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module controller_tb;

	// Inputs
	reg [3:0] dataA;
	reg [3:0] dataB;
	reg clk;

	// Outputs
	wire start;
	wire [7:0] dataC;

	// Instantiate the Unit Under Test (UUT)
	topmodule uut (
		.dataA(dataA), 
		.dataB(dataB), 
		.clk(clk), 
		
		.dataC(dataC)
	);

	initial begin
		// Initialize Inputs
		dataA = 0;
		dataB = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		
		dataA = 4'b1111;
		dataB = 4'b1111;
		#20
		
		dataA = 4'b1111;
		dataB = 4'b1011;
		#20
		
		dataA = 4'b1111;
		dataB = 4'b1010;
		#20
		dataA = 4'b1111;
		dataB = 4'b1110;
		#20
		dataA = 4'b1111;
		dataB = 4'b1000;
		#20
		$stop;
		end
	always
		#`clkperiodby2 clk <= ~clk;
      
endmodule


module controller_bram #(
	parameter DATA_WIDTH = 4,
	parameter MUL_WIDTH 	= 25,
	parameter BRAM_WIDTH = 18,
	parameter BRAM_ADDR 	= 12							
)(
	//USER INTERFACE
	input  [DATA_WIDTH-1:0] dataA,
	input  [DATA_WIDTH-1:0] dataB,
	input clk,
	input  start,
	output reg [2*DATA_WIDTH-1:0] dataC,
	//BRAM INTERFACE
	output reg wrA,
	output reg [BRAM_WIDTH-1:0] dinA,
	output reg [BRAM_ADDR-1:0]  addrA,
	input  [BRAM_WIDTH-1:0] doutA,
	output reg wrB,
	output reg [BRAM_WIDTH-1:0] dinB,
	output reg [BRAM_ADDR-1:0]  addrB,
	input  [BRAM_WIDTH-1:0] doutB,
	//DSP INTERFACE
	output reg [MUL_WIDTH-1:0]            A,
	output reg [BRAM_WIDTH-1:0]           B,
	input  [MUL_WIDTH+BRAM_WIDTH-1:0] C
	
);
reg [1:0] state;
reg [BRAM_ADDR-1:0]addrA_reg;
parameter 
	IDLE  		= 2'b00,
	BRAM_WRITE 	= 2'b01,
	DSP_WRITE 	= 2'b10;
	
initial begin
	wrA <= 1'b0;
	wrB <= 1'b0;
	dinA <= 0;
	dinB <= 0;
	addrA <= 0;
	addrB <= 0;
	state <= IDLE;
	addrA_reg <=0;
	A <=0;
	B<=0;
	dataC <= 0;
//	C <=0;
//	start <= 0;
end

always@(posedge clk) begin
	case(state)
		IDLE: begin
			wrA  <= 1'b0;
			wrB  <= 1'b0;
			dinA <= 0;
			dinB <= 0;
			addrA<= 0;
			addrB<= 12'b000000111111;
			//start<= 0;
			if(start) begin
				wrA <= 1'b1;
				wrB <= 1'b1;
				state <= BRAM_WRITE;
				end
		end
		
		BRAM_WRITE: begin
			dinA 			<= {{5{1'b0}},dataB,{5{1'b0}},dataA};
			//addrA_reg 	<= addrA;
			addrA			<= addrA + 1;
			if(addrA == 12'b000000111111)
				addrA <= 12'b0;
			dinB			<= {{6{1'b0}},dataC};
			addrB			<= addrB + 1;
			state <= DSP_WRITE;
		end

		DSP_WRITE: begin
			A <= {{21{1'b0}},doutA[3:0]};
			B <= {{21{1'b0}},doutA[12:9]};
			//addrA <= addrA_reg;
			//dinA <= {{35{1'b0}},C};
			dataC <= C;
			state <= BRAM_WRITE;
		end
	endcase
	
end
endmodule

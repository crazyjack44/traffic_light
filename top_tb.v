`timescale 1ns/1ns
module top_tb();
	reg clk								;
	reg rst_n							;
//	reg [9:0] north_red_time			;
//	reg [9:0] north_green_time			;
//	reg [9:0] north_yellow_time			;
//	reg [9:0] west_red_time				;
//	reg [9:0] west_green_time			;
//	reg [9:0] west_yellow_time			;
	wire north_red_led					;
	wire north_green_led				;
	wire north_yellow_led				;
	wire west_red_led					;
	wire west_green_led					;
	wire west_yellow_led				;	
Top Top(
	clk						,
	rst_n					,

//	north_red_time			,
//	north_green_time		,
//	north_yellow_time		,
//	west_red_time			,
//	west_green_time			,
//	west_yellow_time		,

	north_red_led			,
	north_green_led			,
	north_yellow_led		,
	west_red_led			,
	west_green_led			,
	west_yellow_led			
	);
initial clk = 1;
always #10 clk = ~clk;
initial begin
	rst_n = 0;
	#100
	rst_n = 1'b1;

end
endmodule
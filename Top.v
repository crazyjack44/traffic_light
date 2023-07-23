module Top(
	clk						,
	rst_n					,

// 	north_red_time			,
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
input 				clk					;
input 				rst_n				;

//input 	[9:0]	north_red_time		;
//input 	[9:0]	north_green_time	;
//input 	[9:0]	north_yellow_time	;
//input 	[9:0]	west_red_time		;
//input 	[9:0]	west_green_time		;
//input 	[9:0]	west_yellow_time	;
output 				north_red_led		;
output 				north_green_led		;
output 				north_yellow_led	;
output 				west_red_led		;
output 				west_green_led		;
output 				west_yellow_led		;

wire 				north_red_time_pos		;
wire 				north_green_time_pos	;
wire 				north_yellow_time_pos	;
wire 				west_red_time_pos		;
wire 				west_green_time_pos		;
wire 				west_yellow_time_pos	;

reg [9:0] r_north_red_time		;
reg [9:0] r_north_green_time	;
reg [9:0] r_north_yellow_time	;
reg [9:0] r_west_red_time		;
reg [9:0] r_west_green_time		;
reg [9:0] r_west_yellow_time	;

always@(posedge clk)begin
	r_north_red_time	<=25	;	
	r_north_green_time	<=25	;
	r_north_yellow_time	<=5		;
	r_west_red_time		<=25	;
	r_west_green_time	<=25	;	
	r_west_yellow_time	<=5		;
end

count_time count_time(
	.clk						(clk)						,
	.rst_n						(rst_n)						,
	.north_red_time				(r_north_red_time		)	,
	.north_green_time			(r_north_green_time		)	,
	.north_yellow_time			(r_north_yellow_time	)	,
	.west_red_time				(r_west_red_time		)	,
	.west_green_time			(r_west_green_time		)	,
	.west_yellow_time			(r_west_yellow_time		)	,
	.north_red_time_pos			(north_red_time_pos		)	,
	.north_green_time_pos		(north_green_time_pos	)	,
	.north_yellow_time_pos		(north_yellow_time_pos	)	,
	.west_red_time_pos			(west_red_time_pos		)	,
	.west_green_time_pos		(west_green_time_pos	)	,
	.west_yellow_time_pos		(west_yellow_time_pos	)	
	);


led_out led_out(
	.clk						(clk)						,
	.rst_n						(rst_n)						,
	.north_red_time_pos			(north_red_time_pos		)	,
	.north_green_time_pos		(north_green_time_pos	)	,
	.north_yellow_time_pos		(north_yellow_time_pos	)	,
	.west_red_time_pos			(west_red_time_pos		)	,
	.west_green_time_pos		(west_green_time_pos	)	,
	.west_yellow_time_pos		(west_yellow_time_pos	)	,
	.north_red_led				(north_red_led			)	,
	.north_green_led			(north_green_led		)	,
	.north_yellow_led			(north_yellow_led		)	,
	.west_red_led				(west_red_led			)	,
	.west_green_led				(west_green_led			)	,
	.west_yellow_led			(west_yellow_led		)	
	);

endmodule
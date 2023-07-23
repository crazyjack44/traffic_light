module led_out (
		clk						,
		rst_n					,	
		north_red_time_pos		,
		north_green_time_pos	,
		north_yellow_time_pos	,
		west_red_time_pos		,
		west_green_time_pos		,
		west_yellow_time_pos	,

		north_red_led			,
		north_green_led			,
		north_yellow_led		,
		west_red_led			,
		west_green_led			,
		west_yellow_led			

	
);

	input		clk						;
	input		rst_n					;	
	input		north_red_time_pos		;
	input		north_green_time_pos	;
	input		north_yellow_time_pos	;
	input		west_red_time_pos		;
	input		west_green_time_pos		;
	input		west_yellow_time_pos	;
	output reg	north_red_led			;
	output reg	north_green_led			;
	output reg	north_yellow_led		;
	output reg	west_red_led			;
	output reg	west_green_led			;
	output reg	west_yellow_led			;

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		north_red_led		<= 1'b0;	
		north_green_led		<= 1'b0;	
		north_yellow_led	<= 1'b0;	
		west_red_led		<= 1'b0;	
		west_green_led		<= 1'b0;	
		west_yellow_led		<= 1'b0;	
		end 
	else begin
		north_red_led		<= north_red_time_pos		;	
		north_green_led		<= north_green_time_pos		;	
		north_yellow_led	<= north_yellow_time_pos	;	
		west_red_led		<= west_red_time_pos		;	
		west_green_led		<= west_green_time_pos		;	
		west_yellow_led		<= west_yellow_time_pos		;
	end
end


endmodule
module count_time(
		clk						,
		rst_n					,
		north_red_time			,
		north_green_time		,
		north_yellow_time		,
		west_red_time			,
		west_green_time			,
		west_yellow_time		,

		north_red_time_pos		,
		north_green_time_pos	,
		north_yellow_time_pos	,
		west_red_time_pos		,
		west_green_time_pos		,
		west_yellow_time_pos	
	);
input				clk						;
input				rst_n					;
input 	[9:0]		north_red_time			;
input 	[9:0]		north_green_time		;
input 	[9:0]		north_yellow_time		;
input 	[9:0]		west_red_time			;
input 	[9:0]		west_green_time			;
input 	[9:0]		west_yellow_time		;

output		reg		north_red_time_pos		;			
output		reg		north_green_time_pos	;	
output		reg		north_yellow_time_pos	;
output		reg		west_red_time_pos		;
output		reg		west_green_time_pos		;
output		reg		west_yellow_time_pos	;

/////////////////////////////////////////////////////////////////
//计数模块

parameter Time_1s = 50_00;
reg [25:0] count_1s;
reg finish_1s;
reg [2:0] next_state;
reg [2:0] state;
parameter IDLE = 0, North_Green = 1, North_Yellow = 2,North_Red = 3, West_Green = 4, West_Yellow = 5,West_Red = 6;

//1s计数
always @(posedge clk or negedge rst_n)begin
	if(~rst_n)begin
		count_1s <= 6'b0;
		finish_1s <= 1'b0;
	end
	else if(count_1s  == Time_1s - 1)begin
		count_1s <= 6'b0;
		finish_1s<= 1'b1;
	end
	else	begin
		count_1s <= count_1s + 1'b1;
		finish_1s<= 1'b0;
	end
end

reg [5:0] count_west_red;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count_west_red <= 6'b0;
	end 
	else if((count_west_red == west_red_time-1)&&(count_1s  == Time_1s - 1))
		count_west_red <= 6'b0;
	else if((count_1s  == Time_1s - 1)&&((state == North_Green)||(state == North_Yellow)))
		count_west_red <= count_west_red + 1'b1;
	else count_west_red <= count_west_red;
end

reg [5:0] count_west_green;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count_west_green <= 6'b0;
	end 
	else if((count_west_green == west_green_time-1)&&(count_1s  == Time_1s - 1))
		count_west_green <= 6'b0;
	else if((count_1s  == Time_1s - 1)&&(state == West_Green))
		count_west_green <= count_west_green + 1'b1;
	else count_west_green <= count_west_green;
end

reg [5:0] count_west_yellow;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count_west_yellow <= 6'b0;
	end 
	else if((count_west_yellow == west_yellow_time-1)&&(count_1s  == Time_1s - 1))
		count_west_yellow <= 6'b0;
	else if((count_1s  == Time_1s - 1)&&(state == West_Yellow))
		count_west_yellow <= count_west_yellow + 1'b1;
	else count_west_yellow <= count_west_yellow;
end

reg [5:0] count_north_red;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count_north_red <= 6'b0;
	end 
	else if((count_north_red == north_red_time-1)&&(count_1s  == Time_1s - 1))
		count_north_red <= 6'b0;
	else if((count_1s  == Time_1s - 1)&&((state == West_Green)||(state == West_Yellow)))
		count_north_red <= count_north_red + 1'b1;
	else count_north_red <= count_north_red;
end

reg [5:0] count_north_green;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count_north_green <= 6'b0;
	end 
	else if((count_north_green == north_green_time-1)&&(count_1s  == Time_1s - 1))
		count_north_green <= 6'b0;
	else if((count_1s  == Time_1s - 1)&&(state == North_Green))
		count_north_green <= count_north_green + 1'b1;
	else count_north_green <= count_north_green;
end

reg [5:0] count_north_yellow;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count_north_yellow <= 6'b0;
	end 
	else if((count_north_yellow == north_yellow_time-1)&&(count_1s  == Time_1s - 1))
		count_north_yellow <= 6'b0;
	else if((count_1s  == Time_1s - 1)&&(state == North_Yellow))
		count_north_yellow <= count_north_yellow + 1'b1;
	else count_north_yellow <= count_north_yellow;
end

//状态机
always @(posedge clk or negedge rst_n) begin
	if(~rst_n)
		state <= IDLE;
	else
		state <= next_state;
end

always @(*) begin
	case(state)
	IDLE:begin
		next_state = North_Green;
		north_red_time_pos		 = 1'b0;
		north_green_time_pos	 = 1'b1;
		north_yellow_time_pos	 = 1'b0;
		west_red_time_pos		 = 1'b1;
		west_green_time_pos		 = 1'b0;
		west_yellow_time_pos	 = 1'b0;
	end
	North_Green: begin
		if((count_north_green == north_green_time-1)&&(count_1s == Time_1s - 1))begin
			next_state = North_Yellow;
			north_red_time_pos		 = 1'b0;
			north_green_time_pos	 = 1'b0;
			north_yellow_time_pos	 = 1'b1;
			west_red_time_pos		 = 1'b1;
			west_green_time_pos		 = 1'b0;
			west_yellow_time_pos	 = 1'b0;
		end
		else	next_state  = next_state;
	end
	North_Yellow:begin
		if((count_north_yellow == north_yellow_time-1)&&(count_1s == Time_1s - 1))begin
			next_state = West_Green;
			north_red_time_pos		 = 1'b1;
			north_green_time_pos	 = 1'b0;
			north_yellow_time_pos	 = 1'b0;
			west_red_time_pos		 = 1'b0;
			west_green_time_pos		 = 1'b1;
			west_yellow_time_pos	 = 1'b0;			
		end
		else next_state = next_state;
	end
	West_Green:begin
		if((count_west_green == west_green_time-1)&&(count_1s == Time_1s - 1))begin
			next_state = West_Yellow;
			north_red_time_pos		 = 1'b1;
			north_green_time_pos	 = 1'b0;
			north_yellow_time_pos	 = 1'b0;
			west_red_time_pos		 = 1'b0;
			west_green_time_pos		 = 1'b0;
			west_yellow_time_pos	 = 1'b1;			
		end
		else	next_state  = next_state;
	end
	West_Yellow: begin
		if((count_west_yellow == west_yellow_time-1)&&(count_1s == Time_1s - 1))begin
			next_state = IDLE;
			north_red_time_pos		 = 1'b0;
			north_green_time_pos	 = 1'b1;
			north_yellow_time_pos	 = 1'b0;
			west_red_time_pos		 = 1'b1;
			west_green_time_pos		 = 1'b0;
			west_yellow_time_pos	 = 1'b0;			
		end
		else	next_state  = next_state;	
	end
	endcase
end
endmodule
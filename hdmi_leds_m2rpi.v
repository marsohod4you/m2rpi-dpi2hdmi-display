
module hdmi_leds_m2rpi(
	input wire OSC,
	input wire [2:0]KEY,
	output wire [3:0]LED,
	inout wire [27:0]GPIO_A,
	output wire [27:0]GPIO_B,
	
	//Raspberry GPIO pins
	input wire GPIO0,
	input wire GPIO1,
	input wire GPIO2,
	input wire GPIO3,
	input wire GPIO4,
	input wire GPIO5,
	input wire GPIO6,
	input wire GPIO7,
	input wire GPIO8,
	input wire GPIO9,
	input wire GPIO10,
	input wire GPIO11,
	input wire GPIO12,
	input wire GPIO13,
	input wire GPIO14, //Serial RX
  output wire GPIO15, //Serial TX
	input wire GPIO16,
	input wire GPIO17,
	input wire GPIO18,
	input wire GPIO19,
	input wire GPIO20,
	input wire GPIO21,
	input wire GPIO22,
	input wire GPIO23,
	input wire GPIO24,
	input wire GPIO25,
	input wire GPIO26,
	input wire GPIO27
	);
	
			
wire [7:0]TMDS;

assign GPIO_B[5] = TMDS[3]; //channel 2 + red wire
assign GPIO_B[0] = TMDS[2]; //channel 2 - white
assign GPIO_B[1] = 1'b0;

assign GPIO_B[27] = TMDS[5]; //channel 0 + violet wire
assign GPIO_B[17] = TMDS[4]; //channel 0 - white
assign GPIO_B[18] = 1'b0;

assign GPIO_B[26] = TMDS[7]; //channel 1 + green wire
assign GPIO_B[19] = TMDS[6]; //channel 1 - white
assign GPIO_B[16] = 1'b0;

assign GPIO_B[11] = TMDS[1]; //channel clk brown wire
assign GPIO_B[9]  = TMDS[0];
assign GPIO_B[25] = 1'b0;

wire CLK100MHZ; assign CLK100MHZ = OSC;
wire KEY0; assign KEY0= KEY[0];
wire KEY1; assign KEY1= KEY[1];

wire w_clk_video;
wire w_clk_hdmi;
wire w_locked;

pll4pi mypll_inst(
			.inclk0( KEY[1] ),
			.c0( w_clk_video ), //74MHz
			.c1( w_clk_hdmi ),	//370MHz
			.locked( w_locked )
			);


reg [23:0]RGB;
reg HSYNC;
reg VSYNC;
always @(posedge w_clk_video)
begin
	RGB<=GPIO_A[27:4];
end
	
always @( posedge w_clk_video )
begin
	HSYNC <= ~GPIO_A[3];
	VSYNC <= GPIO_A[2];
end

reg ored;
always @( posedge w_clk_video )
begin
	if( HSYNC )
		ored <= 1'b0;
	else
		ored <= ored | (|GPIO_A[12:4]);
end

assign LED[0] = ored;
assign LED[3:1] = 0;

display display_inst(
		.reset( ~w_locked ),
		.clk_video( w_clk_video ),
		.clk_hdmi( w_clk_hdmi ),
		.rgb( RGB ),
		.hsync( HSYNC ),
		.vsync( VSYNC ),
		.TMDS( TMDS )
	   );

endmodule

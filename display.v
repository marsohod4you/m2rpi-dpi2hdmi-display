//marsohod3 board has only 8 yellow LEDs
//but sample MIPS needs red/green LEDs and 7-segment indicators
//so try display LEDs and 7-segment info on HDMI output of Marsohod3 board

module display 
		(
		input wire reset,
		input wire clk_video,	//74MHz
		input wire clk_hdmi,		//370MHz
		input wire [23:0]rgb,
		input wire hsync,
		input wire vsync,
		
		//HDMI output
		output wire [7:0]TMDS
	   );
	   
wire w_video_clk5; assign w_video_clk5 = clk_hdmi;
wire w_video_clk; assign w_video_clk = clk_video;

reg vsync_r;
always @(posedge clk_video)
	vsync_r <= vsync;
wire RES; assign RES = (vsync_r==1'b0)&(vsync==1'b1);

wire HS,VS,AC;
	
hvsync hvsync_(
	.reset( RES ),
	.pixel_clock(clk_video),

	.hsync(HS),
	.vsync(VS),
	.active(AC),

	.pixel_count(),
	.line_count(),
	.dbg()
	);


wire w_tmds_bh;
wire w_tmds_bl;
wire w_tmds_gh;
wire w_tmds_gl;
wire w_tmds_rh;
wire w_tmds_rl;

hdmi u_hdmi(
	.pixclk( w_video_clk ),
	.clk_TMDS2( w_video_clk5 ),
	.hsync( HS ),
	.vsync( VS ),
	.active( AC ),

	.red(   rgb[ 7: 0] ),
	.green( rgb[15: 8] ),
	.blue(  rgb[23:16] ),
	
	.TMDS_bh( w_tmds_bh ),
	.TMDS_bl( w_tmds_bl ),
	.TMDS_gh( w_tmds_gh ),
	.TMDS_gl( w_tmds_gl ),
	.TMDS_rh( w_tmds_rh ),
	.TMDS_rl( w_tmds_rl )
);

altddio_out1 u_ddio1( .datain_h( w_video_clk), .datain_l( w_video_clk), .outclock(w_video_clk5), .dataout( TMDS[1] ) );
altddio_out1 u_ddio0( .datain_h(~w_video_clk), .datain_l(~w_video_clk), .outclock(w_video_clk5), .dataout( TMDS[0] ) );
altddio_out1 u_ddio3( .datain_h( w_tmds_bh),   .datain_l( w_tmds_bl),   .outclock(w_video_clk5), .dataout( TMDS[3] ) );
altddio_out1 u_ddio2( .datain_h(~w_tmds_bh),   .datain_l(~w_tmds_bl),   .outclock(w_video_clk5), .dataout( TMDS[2] ) );
altddio_out1 u_ddio5( .datain_h( w_tmds_gh),   .datain_l( w_tmds_gl),   .outclock(w_video_clk5), .dataout( TMDS[5] ) );
altddio_out1 u_ddio4( .datain_h(~w_tmds_gh),   .datain_l(~w_tmds_gl),   .outclock(w_video_clk5), .dataout( TMDS[4] ) );
altddio_out1 u_ddio7( .datain_h( w_tmds_rh),   .datain_l( w_tmds_rl),   .outclock(w_video_clk5), .dataout( TMDS[7] ) );
altddio_out1 u_ddio6( .datain_h(~w_tmds_rh),   .datain_l(~w_tmds_rl),   .outclock(w_video_clk5), .dataout( TMDS[6] ) );

endmodule

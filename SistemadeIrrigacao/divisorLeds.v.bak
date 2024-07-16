module divisorLeds (clk, clkLeds);

input clk;
output clkLeds;

wire [24:0] d;
	
	ff_d dff_0(clk, d[0]);
	ff_d dff_1(d[0], d[1]);
	ff_d dff_2(d[1], d[2]);
	ff_d dff_3(d[2], d[3]);
	ff_d dff_4(d[3], d[4]);
	ff_d dff_5(d[4], d[5]);
	ff_d dff_6(d[5], d[6]);
	ff_d dff_7(d[6], d[7]);
	ff_d dff_8(d[7], d[8]);
	ff_d dff_9(d[8], d[9]);
	ff_d dff_10(d[9], d[10]);
	ff_d dff_11(d[10], d[11]);
	ff_d dff_12(d[11], d[12]);
	ff_d dff_13(d[12], d[13]);
	ff_d dff_14(d[13], d[14]);
	ff_d dff_15(d[14], clkLeds);

endmodule
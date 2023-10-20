module dualseg7(input logic blank, test, input logic [7:0] dataIn,
	        output logic [6:0] display1, display0);	

	seg7 leftOut(blank, test, dataIn[7:4], display1);
	seg7 rightOut(blank, test, dataIn[3:0], display0);

endmodule

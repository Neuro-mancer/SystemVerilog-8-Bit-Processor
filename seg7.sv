//EE 310 Fundamentals of Computer Engineering
//Assignment: HW3
//Author: Nicholas Carmona
//Module Name: seg7
//Module Function
//*******************************************

module seg7(input logic blank, test, input logic [3:0] dataIn, 
	    output logic [6:0] display);

	always_comb begin // always combinational logic
		// note: hex inputs are active low on board
		if(blank) begin // display blank
			display = 7'b111_1111; 
		end
		else if(~blank & test) begin // display test
			display = 7'b000_0000;
		end
		else begin
			case(dataIn)
				0: display = 7'b100_0000;
				1: display = 7'b111_1001;
				2: display = 7'b010_0100;
				3: display = 7'b011_0000;
				4: display = 7'b001_1001;
				5: display = 7'b001_0010;
				6: display = 7'b000_0010;
				7: display = 7'b111_1000;
				8: display = 7'b000_0000;
				9: display = 7'b001_1000;
				10: display = 7'b000_1000;
				11: display = 7'b000_0011;
				12: display = 7'b100_0110;
				13: display = 7'b010_0001;
				14: display = 7'b000_0110;
				15: display = 7'b000_1110;
			endcase
		end
	end

endmodule

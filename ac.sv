//EE 310 Fundamentals of Computer Engineering
//Assignment: HW3
//Author: Nicholas Carmona
//Module Name: ac
//Module Function
//*******************************************

module ac(input logic clk, load_ac, input logic signed [7:0] z,
	output logic signed [7:0] ac_out);
	
	always_ff@(posedge clk) begin
		if(load_ac) begin
			ac_out <= z;
		end
	end 
endmodule


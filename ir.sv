//EE 310 Fundamentals of Computer Engineering
//Assignment: HW3
//Author: Nicholas Carmona
//Module Name: ir
//Module Function
//*******************************************

module ir(input logic clk, reset, load_iru, load_irl, input logic [7:0] mdr,
	output logic [7:0] opcode, value);

	always_ff@(posedge clk, posedge reset) begin
		if(reset) begin
			opcode <= 8'b0;
			value <= 8'b0;
		end
		else if(load_iru & ~load_irl) begin
			opcode <= mdr;
		end
		else if(load_irl & ~load_iru) begin
			value <= mdr;
		end
	end

endmodule

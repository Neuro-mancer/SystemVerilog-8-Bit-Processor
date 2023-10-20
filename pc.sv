//EE 310 Fundamentals of Computer Engineering
//Assignment: HW3
//Author: Nicholas Carmona
//Module Name: pc
//Module Function
//*******************************************

module pc(input logic clk, reset, load_pc, inc_pc, input logic [7:0] pc_in,
	output logic [7:0] pc_out);

	always_ff@(posedge clk, posedge reset) begin
		if(reset) begin
			pc_out <= 8'b0;
		end
		else if(load_pc) begin
			pc_out <= pc_in;
		end
		else if(inc_pc) begin
			pc_out <= pc_out + 1;
		end
	end

endmodule

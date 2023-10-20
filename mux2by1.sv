//EE 310 Fundamentals of Computer Engineering
//Assignment: HW7
//Author: Nicholas Carmona
//Module Name: mux2by1
//Module Function
//*******************************************

module mux2by1(input logic fetch, input logic [7:0] pc, irl, output logic [7:0] mux_out);

	// if fetch is true, output the instruction register addr
	// otherwise, output the program counter addr
	always_comb
	begin
		if(fetch) begin
			mux_out = pc;
		end
		else begin
			mux_out = irl;
		end
	end

endmodule
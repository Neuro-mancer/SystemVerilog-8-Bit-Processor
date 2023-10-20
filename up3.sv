//EE 310 Fundamentals of Computer Engineering
//Assignment: HW7
//Author: Nicholas Carmona
//Module Name: up3
//Module Function
//*******************************************


module up3(input logic clk, reset, fetch, load_ac, load_pc, 
	inc_pc, load_iru, load_irl, store_mem, output logic zflg, nflg,
	output logic [7:0] pc, opcode, value);

	logic [7:0] internal_ac_out, internal_alu_out, internal_pc_out, internal_irl_out, internal_iru_out, internal_mux_out,
		internal_membus_out;
	
	// initialize and connect every device except the CU for the microprocessor
	pc my_pc(.clk(clk), .reset(reset), .load_pc(load_pc), .inc_pc(inc_pc), .pc_in(internal_irl_out), .pc_out(internal_pc_out)); // done
	ir my_ir(.clk(clk), .reset(reset), .load_iru(load_iru), .load_irl(load_irl), .mdr(internal_membus_out), .value(internal_irl_out), .opcode(internal_iru_out)); // done
	ac my_ac(.clk(clk), .load_ac(load_ac), .z(internal_alu_out), .ac_out(internal_ac_out)); // done
	alu my_alu(.ac(internal_ac_out), .z(internal_alu_out), .value(internal_irl_out), 
		.opcode(internal_iru_out), .mdr(internal_membus_out), .nflg(nflg), .zflg(zflg)); // done
	mux2by1 my_mux(.fetch(fetch), .pc(internal_pc_out), .irl(internal_irl_out), .mux_out(internal_mux_out)); // done
	up3ram my_ram(.clock(clk), .address(internal_mux_out), .data(internal_ac_out), .q(internal_membus_out), .wren(store_mem)); // done
	
	// assign these internal signals to the output for the hardware portion
	assign opcode = internal_iru_out;
	assign pc = internal_pc_out;
	assign value = internal_irl_out;

endmodule
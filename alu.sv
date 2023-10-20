//EE 310 Fundamentals of Computer Engineering
//Assignment: HW3
//Author: Nicholas Carmona
//Module Name: ALU
//Module Function
//*******************************************

module alu(input logic [7:0] opcode, input logic signed [7:0] ac, mdr, value,
	output logic signed [7:0] z, output logic nflg, zflg);
	
	
	
	assign nflg = ac[7] ? 1:0; // test for sign bit
	assign zflg = (ac == 0) ? 1:0; //  test ac is 0
	
	always_comb
	
	begin
	
		case(opcode) // case statement to interpret opcode
		
			8'h01: z = mdr; // LOAD
			8'h02: z = value; // LOADI 
			8'h04: z = 8'h00; // CLR
			8'h05: z = ac + mdr; // ADD
			8'h06: z = ac + value; // ADDI
			8'h07: z = ac - mdr; // SUBT
			8'h08: z = ac - value; // SUBTI
			8'h09: z = ~mdr + 1; // NEG
			8'h0A: z = ~mdr; // NOT
			8'h0B: z = ac & mdr; // AND
			8'h0C: z = ac | mdr; // OR
			8'h0D: z = ac ^ mdr; // XOR
			8'h0E: z = ac << value[2:0]; // SHL
			8'h0F: z = ac >> value[2:0]; // SHR
			default: z = 8'h00; // NOP or others
			
		endcase
		
	end
	
endmodule
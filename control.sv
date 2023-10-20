module control(input logic clk, reset, nflg, zflg, input logic [7:0] opcode,
	output logic load_ac, load_iru, load_irl, load_pc, inc_pc, fetch, store_mem, 
	output logic [3:0] State);
	// initialize state machine states
	typedef enum logic [3:0] {START, PREPU, FETCHU, PREPL, FETCHL, EXECNOP, 
		EXECCLR, EXECCL2, EXECCL30, EXECCL31, EXECSTORE, 
		JUMP, JNEG, JPOSZ, JZERO, JNZER} statetype;
	statetype state, nextstate;
	
	//state for execution execcl = exec class
	//execclxy = class x instruction, part y
	
	// state register for the control unit
	always_ff @(negedge clk, posedge reset)
	begin
		if(reset) begin
			state <= START; // if reset, go back to START state
		end
		else begin
			state <= nextstate; // otherwise, go to nextstate.
		end
	end
	
	always_comb begin
		case(state)
			START: nextstate = PREPU;
			PREPU: nextstate = FETCHU;
			FETCHU:
				case(opcode)
					8'h00: nextstate = EXECNOP;
					8'h04: nextstate = EXECCLR;
					default: nextstate = FETCHL;
				endcase
			PREPL: nextstate = FETCHL;
			FETCHL:
				case(opcode)
					8'h02: nextstate = EXECCL2;
					8'h06: nextstate = EXECCL2;
					8'h08: nextstate = EXECCL2;
					8'h0E: nextstate = EXECCL2;
					8'h0F: nextstate = EXECCL2;
					8'h01: nextstate = EXECCL30;
					8'h05: nextstate = EXECCL30;
					8'h07: nextstate = EXECCL30;
					8'h09: nextstate = EXECCL30;
					8'h0A: nextstate = EXECCL30;
					8'h0B: nextstate = EXECCL30;
					8'h0C: nextstate = EXECCL30;
					8'h0D: nextstate = EXECCL30;
					8'h03: nextstate = EXECSTORE;
					8'h10: nextstate = JUMP;
					8'h11: nextstate = JNEG;
					8'h12: nextstate = JPOSZ;
					8'h13: nextstate = JZERO;
					8'h14: nextstate = JNZER;
					default: nextstate = START;
				endcase
			EXECNOP: nextstate = PREPU; // exec NOP (do nothing)
			EXECCLR: nextstate = PREPU; // exec clr (load_ac high)
			EXECCL2: nextstate = PREPU; // execute all class two instructions (load_ac high)
			EXECCL30: nextstate = EXECCL31; // execute class three instruction beginning (idle clock cycle so addr can be clocked into MAR)
			EXECCL31: nextstate = PREPU; // keep load AC high for this state
			EXECSTORE: nextstate = PREPU; // keep store_mem high for this state
			JUMP: nextstate = PREPU; // unconditionally jump, so assert load_pc
			JNEG: nextstate = PREPU; // negative flag set, so assert load_pc
			JPOSZ: nextstate = PREPU;
			JZERO: nextstate = PREPU;
			JNZER: nextstate = PREPU;
			default: nextstate = START;
		endcase
	end
	
	assign fetch = (state == PREPU | state == FETCHU | state == PREPL | state == FETCHL);
	assign inc_pc = (state == FETCHU | state == FETCHL);
	assign load_iru = (state == FETCHU);
	assign load_irl = (state == FETCHL);
	assign load_ac = (state == EXECCLR | state == EXECCL2 | state == EXECCL31);
	assign load_pc = (state == JUMP | ((state == JNEG) && nflg) | ((state == JPOSZ) && (zflg | ~nflg)) | ((state == JZERO) && zflg)  | ((state == JNZER) && ~zflg)); // remember to add in code for jposz and on
	assign store_mem = (state == EXECSTORE);
	assign State = state;
	
endmodule